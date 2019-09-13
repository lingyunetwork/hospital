import 'package:flutter/material.dart';

class WePage extends StatelessWidget {
  const WePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     
      body: SingleChildScrollView(
        child: Container(
          height: 300,
          width: double.infinity,
          child: Image.asset(
            "assets/articles/woman3.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}