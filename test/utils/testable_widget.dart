import 'package:flutter/material.dart';

Widget testableWidget(Widget? child,
        {NavigatorObserver? navigatorObserver, GlobalKey<NavigatorState>? navigatorKey}) =>
    MaterialApp(
      home: child,
      navigatorKey: navigatorKey,
    );
