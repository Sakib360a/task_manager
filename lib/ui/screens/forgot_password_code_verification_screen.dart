import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/reset_password.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ForgotPasswordCodeVerificationScreen extends StatefulWidget {
  const ForgotPasswordCodeVerificationScreen({super.key});

  @override
  State<ForgotPasswordCodeVerificationScreen> createState() =>
      _ForgotPasswordCodeVerificationScreenState();
}

class _ForgotPasswordCodeVerificationScreenState extends State<ForgotPasswordCodeVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeTEController = TextEditingController();
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
                    'Code Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'A 6 digit code has been sent to your email',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Color(0xff22bf73)),
                  ),
                  const SizedBox(height: 24),
                  PinCodeTextField(
                    length: 6,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      inactiveColor: Colors.grey,
                      activeColor: Color(0xff22bf73),

                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    cursorColor: Colors.black,
                    cursorHeight: 25,
                    controller: _codeTEController,
                    onCompleted: (v) {
                      print("Completed");
                    },
                     appContext: context,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _onTapVerifyButton,
                    child: Text('Verify',style: TextStyle(fontWeight: FontWeight.w900),),
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

  void _onTapLoginButton() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (predicate)=>false);
  }
void _onTapVerifyButton(){
    _codeTEController.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
}

  @override
  void dispose() {
    _loginTapRecognizer.dispose();
    // TODO: implement dispose
    super.dispose();
    _codeTEController.dispose();
  }
}
