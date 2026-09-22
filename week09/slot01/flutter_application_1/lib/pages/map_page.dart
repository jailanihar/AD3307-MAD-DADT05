import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/mad_scaffold.dart';
import 'package:flutter_map/flutter_map.dart';
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
              ],
            ),
          ),
        ]
      ),
    );
  }
}