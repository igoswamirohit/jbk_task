import 'package:flutter/material.dart';
import 'package:jbk_task/ui/screens/cart_view.dart';

import '../ui/screens/detail_view.dart';
import '../ui/screens/home_view.dart';

class RouteManager {
  static MaterialPageRoute<void> onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case DetailView.routeName:
            return const DetailView();
          case CartView.routeName:
            return CartView();
          case HomeView.routeName:
          default:
            return const HomeView();
        }
      },
    );
  }
}
