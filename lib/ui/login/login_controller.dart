import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/ui/menu/menu_page.dart';

class LoginController{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(BuildContext context)async{

    try{
      formKey.currentState!.validate();
      
     await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then(
      (value) async{
          if(value.credential != null)return;
            Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => MenuPage()),
              (route) => false,
            );
      }
    );
        
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

  Future<void> signInWithGoogle() async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser == null)return;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      
     UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

  }

  forgetPassword(){


  }


}