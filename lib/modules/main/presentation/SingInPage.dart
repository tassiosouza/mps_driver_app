import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';

class SingInPage extends StatefulWidget{
  final AuthenticatorState state;
  SingInPage(this.state);

  @override
  State<StatefulWidget> createState() => SingInPageState();
}

class SingInPageState extends State<SingInPage>{
  @override
  Widget build(BuildContext context) {

    const padding =
    EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16);

    return Scaffold(
      body: Padding(
        padding: padding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // app logo
              Center(
                  child: Image.asset('assets/images/logo.png',
                      width: 230)),
              // prebuilt sign in form from amplify_authenticator package
              SignInForm(),
            ],
          ),
        ),
      ),
      // custom button to take the user to sign up
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t have an account?'),
            TextButton(
              onPressed: () => widget.state.changeStep(
                AuthenticatorStep.signUp,
              ),
              child: const Text('Sign Up',
                  style: TextStyle(fontFamily: 'Poppins')),
            ),
          ],
        ),
      ],
    );
  }

}