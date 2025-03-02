import 'package:fin_track/routes/delegate/delegate.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final GoRouter _router = MyGoRouterDelegate().router;
  GoRouter get router => _router;
  final GlobalKey<NavigatorState> _navigationKey = MyGoRouterDelegate().navigatorKey;
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;
}
