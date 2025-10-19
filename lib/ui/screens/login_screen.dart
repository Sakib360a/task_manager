import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/signup_screen.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import 'forgot_password_email_verification_screen.dart';
import 'main_navbar_holder_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String name= '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TapGestureRecognizer _signupTapRecognizer = TapGestureRecognizer();

  bool _loginInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      String inputText = value ?? '';
                      if (EmailValidator.validate(inputText) == false) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if ((value?.length ?? 0) <= 6) {
                        return 'Password must be longer than 6 character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: _loginInProgress == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: FilledButton(
                      onPressed: _logIn,
                      child: Icon(Icons.navigate_next),
                    ),
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
  void _onTapLoginButton() {
    if (_formKey.currentState!.validate()) {
      _logIn();
    }
  }

  Future<void> _logIn() async {
    _loginInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );

    if(response.isSuccess && response.responseData['status']=='success')
      {
        Navigator.pushNamedAndRemoveUntil(context, MainNavbarHolderScreen.name, (predicate)=>false);
      }
    else{
      _loginInProgress = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage!);
    }


  }
  void _onTapForgotPasswordButton(){
    Navigator.pushNamed(context, ForgotPasswordEmailVerificationScreen.name);
  }
  void _onTapSignupButton(){
    Navigator.pushNamed(context, SignupScreen.name);
  }
  void _clearTextField() {
    _emailTEController.clear();
    _passwordTEController.clear();
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
