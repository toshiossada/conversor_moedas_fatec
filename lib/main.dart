import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_module.dart';

void main() => runApp(ModularApp(module: AppModule(), child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              
            ),
      ),
      initialRoute: '/',
    ).modular();
  }
}
