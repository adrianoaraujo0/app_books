import 'package:flutter/material.dart';
import 'package:login/ui/login/login_page.dart';
import 'package:login/utils/style_app.dart';

class TelaInicial extends StatelessWidget {
  TelaInicial({super.key});

  StyleApp styleApp = StyleApp();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade700,
                Colors.blue.shade300,
              ],
            )
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text("Welcome to \nYour Library", style: TextStyle(fontSize: 40, color: styleApp.fontText, fontWeight: FontWeight.w600)),
              ),
              Image.asset("assets/images/logo.png"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  },));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800, 
                  padding: 
                    const EdgeInsets.symmetric(
                      horizontal: 120, vertical: 20
                    )
                  ),
                child: const Text("Sign in"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade400,  padding: const EdgeInsets.symmetric(horizontal: 94, vertical: 20)),
                child: const Text("Create Account"),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
