import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/services/api_caller.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

import '../../data/utils/urls.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/snack_bar_message.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const String name = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController =
      TextEditingController();
  final TapGestureRecognizer _loginTapRecognizer = TapGestureRecognizer();

  bool _signUpInProgress = false;

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
                  const SizedBox(height: 82),
                  Text(
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: 'Email'),
                    textInputAction: TextInputAction.next,
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
                    keyboardType: TextInputType.name,
                    controller: _firstNameTEController,
                    decoration: InputDecoration(hintText: 'First Name'),
                    textInputAction: TextInputAction.next,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _lastNameTEController,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    textInputAction: TextInputAction.next,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberTEController,
                    decoration: InputDecoration(hintText: 'Mobile'),
                    textInputAction: TextInputAction.next,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your mobile';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
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
                    visible: _signUpInProgress == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                        text: 'Have an account?',
                        children: [
                          TextSpan(text: ' '),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(color: Color(0xff21bf73)),
                            recognizer: _loginTapRecognizer
                              ..onTap = _onTapLoginButton,
                          ),
                        ],
                      ),
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

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    _signUpInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneNumberTEController.text.trim(),
      "password": _passwordTEController.text,
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.registrationUrl,
      body: requestBody,
    );
    _signUpInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextField();
      showSnackBarMessage(context, 'Registration successful! Please login.');
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  void _onTapLoginButton() {
    Navigator.pop(context);
  }

  void _onTapSignupButton() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _clearTextField() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _phoneNumberTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneNumberTEController.dispose();
    _loginTapRecognizer.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
