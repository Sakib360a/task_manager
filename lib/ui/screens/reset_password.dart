import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/signup_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

import 'forgot_password_email_verification_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
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
                    'Reset Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Password should be at least 8 characters long, with a mix of letters, numbers and symbols.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _passwordTEController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(hintText: 'New Password'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(hintText: 'Confirm Password'),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _onTapResetPasswordButton,
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
                                recognizer: _signupTapRecognizer
                                  ..onTap = _onTapSignupButton,
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

  void _onTapForgotPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPasswordEmailVerificationScreen(),
      ),
    );
  }

  void _onTapSignupButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }

  void _onTapResetPasswordButton() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    _signupTapRecognizer.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
