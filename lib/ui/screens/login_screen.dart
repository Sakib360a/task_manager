import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/signup_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

import 'forgot_password_email_verification_screen.dart';
import 'main_navbar_holder_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TapGestureRecognizer _signupTapRecognizer = TapGestureRecognizer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 82),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _onTapLoginButton,
                    child: Icon(Icons.navigate_next),
                  ),
                  const SizedBox(height: 36),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: _onTapForgotPasswordButton,
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                            text: 'Don\'t have an account?',
                            children: [
                              TextSpan(text: ' '),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(color: Color(0xff21bf73)),
                                recognizer: _signupTapRecognizer..onTap = _onTapSignupButton,
                              ),
                            ],
          
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _onTapForgotPasswordButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordEmailVerificationScreen()));
  }
  void _onTapLoginButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainNavbarHolderScreen()), (predicate)=>false);
  }
  void _onTapSignupButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _signupTapRecognizer.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
