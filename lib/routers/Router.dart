import 'package:flutter/material.dart';
import '../tabs/Tabs.dart';
import 'RouteError.dart';
import '../pages/ProductList.dart';
import '../pages/Search.dart';
import '../pages/ProductDetail.dart';

final routes = {
  '/': (context) => Tabs(),
  '/productList': (context, {arguments}) => ProductListPage(arguments),
  '/search': (context) => SearchPage(),
  '/productDetail': (context, {arguments}) => ProductDetailPage(arguments),
};

// ignore: top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
  ///统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          settings: RouteSettings(name: name),
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(
          settings: RouteSettings(name: name),
          builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return MaterialPageRoute(builder: (context) => RouteErrorPage());
};
