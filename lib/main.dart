import 'package:flutter/material.dart';
import 'routers/Router.dart';
//引入provider
import 'package:provider/provider.dart';
import 'provider/CartProvider.dart';
import 'provider/CheckOutProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider(),),
        ChangeNotifierProvider(create: (_) => CheckOutProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        builder: (context, child) => Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus.unfocus();
              }
            },
            child: child,
          ),
        ),
        theme: ThemeData(
            primaryColor: Colors.white
        ),
      ),
    );
  }
}
