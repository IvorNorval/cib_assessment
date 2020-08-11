import 'package:cib_assessment/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      SystemNavigator.pop();
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/lighting.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            'Have a good day!',
            style: kHeadingTextStyle,
          ),
        ),
      ),
    );
  }
}
