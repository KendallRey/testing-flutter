
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/core/constants/preference_keys.dart';
import 'package:normal_list/app/core/services/app_encryption.dart';
import 'package:normal_list/app/core/services/app_provider.dart';
import 'package:normal_list/app/core/utils/validators.dart';
import 'package:normal_list/app/core/widgets/button.dart';
import 'package:normal_list/app/core/widgets/text_form_field.dart';
import 'package:normal_list/app/router.dart';
import 'package:normal_list/features/auth/data/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController secretController = TextEditingController();

  final AuthService authService = AuthService();
  
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  // Load remembered credentials
  Future<void> _loadRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(PreferenceKeys.email);
    final password = prefs.getString(PreferenceKeys.password);
    final isRemembered = prefs.getBool(PreferenceKeys.rememberMe) ?? false;

    if(isRemembered && email != null && password != null){
      emailController.text = email;
      passwordController.text = password;
      setState(() {
        rememberMe = isRemembered;
      });
    }
  }

  // Save credentials
  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    
    if(rememberMe){
      prefs.setString(PreferenceKeys.email, emailController.text);
      prefs.setString(PreferenceKeys.password, passwordController.text);
      prefs.setBool(PreferenceKeys.rememberMe, true);
    } else {
      prefs.remove(PreferenceKeys.email);
      prefs.remove(PreferenceKeys.password);
      prefs.setBool(PreferenceKeys.rememberMe, false);
    }
  }

  // Handle login
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
      await _saveCredentials();
      if(ctx.mounted){
        final secretValue = secretController.text;
        ctx.read<AppProvider>().setSecret(secretValue);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(PreferenceKeys.secret, secretValue);
        AppEncryption(secretValue);
      }
      if(!ctx.mounted) return;
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Welcome to your list!'))
      );
      await Future.delayed(Durations.medium1);
      if(!ctx.mounted) return;
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
                AppTextFormField(
                  controller: secretController,
                  label: 'Secret',
                  validator: FormValidators.validateRequiredString,
                ),
                SizedBox(height: 20),
                AppTextFormField(
                  controller: emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: FormValidators.validateEmail,
                ),
                SizedBox(height: 20),
                AppTextFormField(
                  controller: passwordController,
                  label: 'Password',
                  validator: FormValidators.validatePassword,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      rememberMe = !rememberMe;
                    });
                  },
                  child: Row(
                    children: [
                      Checkbox(
                        value: rememberMe, onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        }
                      ),
                      Text('Remember Me')
                    ],
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 200, // Set the width
                  height: 40, // Set the height
                  child: AppButton(
                    onPressed: () {
                      handleLogin(context);
                    },
                    label: 'Login',
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}