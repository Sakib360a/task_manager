import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

import 'forgot_password_code_verification_screen.dart';

class ForgotPasswordEmailVerificationScreen extends StatefulWidget {
  const ForgotPasswordEmailVerificationScreen({super.key});

  @override
  State<ForgotPasswordEmailVerificationScreen> createState() =>
      _ForgotPasswordEmailVerificationScreenState();
}

class _ForgotPasswordEmailVerificationScreenState extends State<ForgotPasswordEmailVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
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
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'A 6 digit code will be sent to your email',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _onTapNextButton,
                    child: Icon(Icons.navigate_next),
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
                            recognizer: TapGestureRecognizer()
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

  void _onTapNextButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPasswordCodeVerificationScreen(),
      ),
    );
  }

  void _onTapLoginButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
