import 'package:flutter_application_1/pages/first_stateful.dart';
import 'package:flutter_application_1/pages/first_stateless.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:go_router/go_router.dart';

final routesConfig = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
      redirect: (context, state) {
        // bool alreadyLogin = true;
        // if(alreadyLogin) {
        //   return '/home';
        // } else {
        //   return '/login';
        // }
        return '/login';
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
  ],
);