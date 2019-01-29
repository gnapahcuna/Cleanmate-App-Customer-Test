import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cleanmate_customer_app/HomeScreen.dart';
import 'package:cleanmate_customer_app/screens/myOrder.dart' as _orderPage;
import 'package:cleanmate_customer_app/screens/productList.dart' as _productlist;
import 'package:cleanmate_customer_app/screens/login.dart';
import 'screens/service.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder>{
      //intent เกี่ยวข้อง
      '/Login': (BuildContext context) => new Login(),
      '/HomeScreen': (BuildContext context) => new HomeScreen(),
      '/Service': (BuildContext context) => new Service(),
    },
    onGenerateRoute: (RouteSettings settings) {
      switch (settings.name) {
        case '/Order': return new FromRightToLeft(
          builder: (_) => new _orderPage.About(),
          settings: settings,
        );
        /*case '/Service': return new FromRightToLeft(
          builder: (_) => new _servicePage.Support(),
          settings: settings,
        );*/
        case '/ProductList': return new FromRightToLeft(
          builder: (_) => new _productlist.ProductList(),
          settings: settings,
        );
      }
    },
  ));
} 

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    //intent
    Navigator.of(context).pushReplacementNamed('/Service');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        //set image
        child: new Image.asset('assets/images/logo.png'),
      ),
    );
  }
}