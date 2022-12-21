import 'package:flutter/material.dart';
import '../../utils/style_app.dart';
import '../login/login_page.dart';
import 'create_account_controller.dart';

class CreateAccountPage extends StatelessWidget {
  CreateAccountPage({super.key});

  StyleApp styleApp = StyleApp();
  CreateAccountController createAccountController = CreateAccountController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: styleApp.boxDecoration1,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 751,
                    width: 380,
                    decoration: styleApp.BoxDecoration2,
                    child: buildForm(context),
                  ),
                ],
              ) 
            ),
          ),
        ),
      )
    );
  }

  Widget buildForm(BuildContext context){
    return Form(
      key: createAccountController.formKey,
      child: Column(
        children: [
          Text("Crie sua conta", style: TextStyle(color: styleApp.fontText, fontSize: 40, fontWeight: FontWeight.w600)),
          const SizedBox(height: 50),
          buildTextFormField(
            hintText: "Nome",
            icon: Icons.person,
            controller: createAccountController.nameController,
            validator: 
              (value) {
                if(value!.isEmpty)return "Digite seu nome";
                return null;
              },
          ),
          const SizedBox(height: 30),
          buildTextFormField(
            hintText: "Email",
            icon: Icons.email,
            controller: createAccountController.emailController,
            validator: 
            (value) {
              if(value!.isEmpty)return "Digite seu email";
              return null;
            },
          ),
          const SizedBox(height: 30),
          buildTextFormField(
            hintText: "Senha",
            icon: Icons.lock,
            controller: createAccountController.passwordController,
            validator: 
              (value) {
                if(value!.isEmpty) {
                  return "Digite sua senha";
                }else if(value != createAccountController.confirmPasswordController.text) {
                  return "Senha incompatíveis";
                }
                return null;
              },
          ),
          const SizedBox(height: 30),
          buildTextFormField(
            hintText: "Confirmar senha",
            icon: Icons.lock,
            controller: createAccountController.confirmPasswordController,
            validator: 
              (value) {
                if(value!.isEmpty) {
                  return "Digite sua senha";
                } else if(value != createAccountController.passwordController.text) {
                  return "Senha incompatíveis";
                }
                return null;
              },
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 137, vertical: 20)
            ),
            onPressed: (){ 
              createAccountController.formKey.currentState!.validate();
            }, 
            child: const Text("Login"), 
          ),
          Expanded(
            child: Column(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                signIn(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildTextFormField({required IconData icon , required String hintText, required TextEditingController controller, required String? Function(String?)? validator}){
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: styleApp.fontText),
        icon: Icon(icon)
      ),
      controller: controller,
    );
  }

   Widget signIn(BuildContext context){
      return TextButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Já tem uma conta?", style: TextStyle(color: styleApp.fontText, fontSize: 15, fontWeight: FontWeight.w500)),
          const SizedBox(width: 7),
          const Text("Faça o login", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500)),
        ]
      )
    );
  }

}