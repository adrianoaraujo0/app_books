import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/ui/login/login_page.dart';

class CreateAccountController{

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final myFocusNodes = FocusNode();

  createAccount(BuildContext context) async{
    try{
      formKey.currentState!.validate();
      
      if(formKey.currentState!.validate()){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then(
          (value){
            if(value.user == null)return;
            insertFirebaseAuth(value.user!.uid);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            buildSnackBar(context, "Cadastro realizado com sucesso.");
          }
        );
      }

    }on FirebaseAuthException catch(e){
      if(e.code == "email-already-in-use"){
        myFocusNodes.requestFocus();
        buildSnackBar(context, "Email já cadastrado. Tente outro.");
      }
    }
  }

  void insertFirebaseAuth(String uid){
    FirebaseFirestore.instance.collection("user").add({"name":nameController.text, "uid" : uid});
  }  

  buildSnackBar(BuildContext context ,String messenger){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(messenger)));
  }

}