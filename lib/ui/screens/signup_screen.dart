import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const String name= '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController = TextEditingController();
  final TapGestureRecognizer _loginTapRecognizer = TapGestureRecognizer();

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
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _firstNameTEController,
                    decoration: InputDecoration(hintText: 'First Name'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _lastNameTEController,
                    decoration: InputDecoration(hintText: 'Last Name'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberTEController,
                    decoration: InputDecoration(hintText: 'Mobile'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _onTapSignupButton,
                    child: Icon(Icons.arrow_forward_outlined,),
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
                            recognizer: _loginTapRecognizer..onTap = _onTapLoginButton
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

  void _onTapLoginButton(){
    Navigator.pop(context);
  }
  void _onTapSignupButton(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
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
