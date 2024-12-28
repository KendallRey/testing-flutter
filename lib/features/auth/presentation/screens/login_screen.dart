
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/core/utils/validators.dart';
import 'package:normal_list/app/router.dart';
import 'package:normal_list/features/auth/data/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService authService = AuthService();

  void handleLogin(BuildContext ctx) async {

    if(!_formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final user = await authService.signInWithEmail(email, password);
    
    if(!ctx.mounted) return;
    if(user == null){
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Login failed!'))
      );
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Welcome to your list!'))
      );
      ctx.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration:  InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidators.validateEmail,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: FormValidators.validatePassword,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    handleLogin(context);
                  },
                  child: Text('Login')
                )
              ],
            ),
          )
      ),
    );
  }
}