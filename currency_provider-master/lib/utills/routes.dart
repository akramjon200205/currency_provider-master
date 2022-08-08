import 'package:flutter/material.dart';
import 'package:flutter_application_1/compare_page.dart';
import 'package:flutter_application_1/currency_page.dart';

class Routes {
  static const currencyPage = '/currencyPage';
  static const comparePage = '/';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      Map<String, dynamic>? args =
          routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case comparePage:
          return MaterialPageRoute(
            builder: (context) => const ComparePage(),
          );
        case currencyPage:
          return MaterialPageRoute(
            builder: (context) => CurrencyPage(
              args?['list_currency'],
              args?['top_cur'],
              args?['bottom_cur'],
            ),
          );
        default:
          return MaterialPageRoute(
            builder: (context) => const ComparePage(),
          );
      }
    } catch (e) {
      return MaterialPageRoute(
        builder: (context) => const ComparePage(),
      );
    }
  }
}
