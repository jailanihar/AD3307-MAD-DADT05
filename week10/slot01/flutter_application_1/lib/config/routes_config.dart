import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/first_stateful.dart';
import 'package:flutter_application_1/pages/first_stateless.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/pages/register_page.dart';
import 'package:go_router/go_router.dart';

final routesConfig = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
      redirect: (context, state) {
        User? user = FirebaseAuth.instance.currentUser;
        if(user != null) {
          return '/home';
        } else {
          return null;
        }
      },
    ),
    GoRoute(
      path: '/first-stateless',
      builder: (context, state) => MyFirstStatelessPage(),
    ),
    GoRoute(
      path: '/first-stateful',
      builder: (context, state) => MyFirstStatefulPage(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => MapPage(),
    ),
  ],
);