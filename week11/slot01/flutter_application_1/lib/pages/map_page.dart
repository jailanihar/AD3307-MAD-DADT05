import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/mad_scaffold.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  LatLng _currentLocation = LatLng(4.904668, 114.933395);
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      return;
    }
    if(permission == LocationPermission.deniedForever) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
    _mapController.move(_currentLocation, _mapController.camera.zoom);
  }

  Future<void> loadPreviousSelectedLocation() async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null) {
      return;
    }
    DocumentSnapshot<Map<String, dynamic>> userData =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if(userData.exists) {
      setState(() {
        _selectedLocation = 
          LatLng(userData.data()!['selectedLat'], userData.data()!['selectedLng']);
      });
    }
  }

  Future<void> saveSelectedLocation() async {
    if(_selectedLocation == null) {
      return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null) {
      return;
    }
    DocumentReference userDoc = 
      FirebaseFirestore.instance.collection('users').doc(user.uid);

    userDoc.update({
      'selectedLat': _selectedLocation!.latitude,
      'selectedLng': _selectedLocation!.longitude,
    });
  }

  @override
  Widget build(BuildContext context) {
    return MADScaffold(
      titleText: 'Map Page', 
      body: ListView(
        children: [
          Container(
            height: 500,
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _currentLocation,
                    initialZoom: 19.0,
                    onTap: (tapPosition, point) {
                      setState(() {
                        _selectedLocation = point;
                      });
                    }
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _currentLocation,
                          child: Icon(
                            Icons.my_location,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        if(_selectedLocation != null)
                          Marker(
                            point: _selectedLocation!,
                            child: Icon(
                              Icons.pin_drop,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Column(
                    spacing: 5,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if(_selectedLocation != null) {
                            _mapController.move(
                              _selectedLocation!, 
                              _mapController.camera.zoom
                            );
                          }
                        }, 
                        child: const Icon(Icons.pin_drop, size: 24),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedLocation = null;
                          });
                        }, 
                        child: const Icon(Icons.cancel, size: 24),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _mapController.move(
                            _currentLocation, 
                            _mapController.camera.zoom
                          );
                        }, 
                        child: const Icon(Icons.my_location, size: 24),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if(_mapController.camera.zoom >= 20) {
                            return;
                          }
                          _mapController.move(
                            _mapController.camera.center,
                            _mapController.camera.zoom + 0.2 
                          );
                        }, 
                        child: const Icon(Icons.zoom_in, size: 24),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if(_mapController.camera.zoom <= 10) {
                            return;
                          }
                          _mapController.move(
                            _mapController.camera.center,
                            _mapController.camera.zoom - 0.2 
                          );
                        }, 
                        child: const Icon(Icons.zoom_out, size: 24),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: loadPreviousSelectedLocation,
            child: const Text("Load Previous Loc")
          ),
          ElevatedButton(
            onPressed: saveSelectedLocation,
            child: const Text("Save Selected Loc")
          ),
        ]
      ),
    );
  }
}