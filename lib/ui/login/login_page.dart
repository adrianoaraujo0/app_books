import 'package:flutter/material.dart';
import 'package:login/ui/createAccount/create_account_page.dart';
import 'package:login/ui/login/login_controller.dart';
import 'package:login/utils/style_app.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  StyleApp styleApp = StyleApp();
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
           decoration: styleApp.boxDecoration1,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSecondContainer(context),
                  ],
                ),
              ),
            ),
        )
      ),
    );
  }

  Widget buildSecondContainer(BuildContext context){
    return Container(
      decoration: styleApp.BoxDecoration2,
      height: 751,
      width: 380,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: buildForm(context),
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context){
    return Form(
      key: loginController.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text("Login", style: TextStyle(color: styleApp.fontText, fontSize: 40, fontWeight: FontWeight.w600)),
            const SizedBox(height: 50),
            buildTextField(Icons.email, "Email"),
            const SizedBox(height: 30),
            buildTextField(Icons.lock, "Senha", true),
            const SizedBox(height: 20),
            forgetMyPassword(),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 137, vertical: 20)
              ),
              onPressed: (){ 
                loginController.formKey.currentState!.validate();
              }, 
              child: const Text("Login"), 
            ),
            const SizedBox(height: 60),
            Row(
              children: [
                const Expanded(child: Divider(height: 10, thickness: 2)),
                const SizedBox(width: 10),
                Text("OR", style: TextStyle(fontSize: 20, color: styleApp.fontText)),
                const SizedBox(width: 10),
                const Expanded(child: Divider(height: 10, thickness: 2)),
              ],
            ),
            const SizedBox(height: 50),
            loginWithGoogle(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  createAnAccount(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget forgetMyPassword(){
    return Text("Esqueci minha senha", style: TextStyle(color: styleApp.fontText));
  }

  Widget loginWithGoogle(){
    return Row(
      children: [
        Image.asset("assets/images/google.png", height: 30),
        const SizedBox(width: 10),
        Text("Login com ", style: TextStyle(color: styleApp.fontText, fontSize: 15, fontWeight: FontWeight.w500)),
        const Text("Google", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500))
      ],
    );
  }

  Widget createAnAccount(BuildContext context){
    // return InkWell(
    //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage())),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text("Não tem uma conta?", style: TextStyle(color: styleApp.fontText, fontSize: 15, fontWeight: FontWeight.w500)),
    //       const SizedBox(width: 7),
    //       const Text("Crie uma conta", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)),
    //     ],
    //   ),
    // );  
    return TextButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage())), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Não tem uma conta?", style: TextStyle(color: styleApp.fontText, fontSize: 15, fontWeight: FontWeight.w500)),
          const SizedBox(width: 7),
          const Text("Crie uma conta", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)),
        ]
      )
    );
  }

  Widget buildTextField(IconData icon, String hintText, [bool obscure = false]){
    return TextFormField(
      validator: (value) {
        if(value!.isEmpty){
          return "Ops, você deixou esse campo vazio!";
        }
      },
      obscureText: obscure,
      decoration: InputDecoration(
        icon: Icon(icon),
        hintText: hintText,
        hintStyle: TextStyle(color:  styleApp.fontText)
      ),
    );
  }
}