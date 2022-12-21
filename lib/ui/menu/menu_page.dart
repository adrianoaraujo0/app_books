import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.asset("assets/images/sol-para-todos.jpg", fit: BoxFit.cover)
          )
        ],
      ),
    );
  }
}