import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/images/logo.png'),
        radius: 50,
        backgroundColor: Colors.white,
      ),
    );
  }
}
