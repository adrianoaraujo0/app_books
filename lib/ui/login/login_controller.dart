import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/ui/menu/menu_page.dart';

class LoginController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(BuildContext context)async{

    try{
      formKey.currentState!.validate();
      
     await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then(
      (value){
          if(value.credential != null)return;
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuPage()));
     });
        
    }on FirebaseAuthException catch(e){

      if(e.code == "user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(buildSnackBar("Usuário não encontrado."));
      }else if(e.code == "wrong-password"){
        ScaffoldMessenger.of(context).showSnackBar(buildSnackBar("Senha errada."));
      }

    }
  }

 buildSnackBar(String messenger){
    return SnackBar(content: Text(messenger));
  }

  loginWithGoogle(){

    // FirebaseAuth.instance.si

  }


}