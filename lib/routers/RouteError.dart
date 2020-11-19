import 'package:flutter/material.dart';

class RouteErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text(
          "路由错误",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: Center(
        child: Text("页面路由错误了，请查看代码"),
      ),
    );
  }
}
