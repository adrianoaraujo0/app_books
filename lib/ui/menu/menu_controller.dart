import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/ui/initial_page.dart';

class MenuController{

  Future<void> logout(BuildContext context) async{
      await FirebaseAuth.instance.signOut().whenComplete((){
        if(FirebaseAuth.instance.currentUser == null){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => InitialPage()), (route) => false);
        }
      });
  }

}