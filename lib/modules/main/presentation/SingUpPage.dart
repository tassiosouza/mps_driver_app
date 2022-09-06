// ignore_for_file: depend_on_referenced_packages

import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class SingUpPage extends StatefulWidget {
  final AuthenticatorState state;
  // ignore: use_key_in_widget_constructors
  const SingUpPage(this.state);
  @override
  State<StatefulWidget> createState() => SingUpPageState();
}

class SingUpPageState extends State<SingUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text('Ready to join our team ? Register here :)',
                      style: TextStyle(fontFamily: 'Poppins'))),
              // prebuilt sign up form from amplify_authenticator package
              SignUpForm.custom(
                fields: [
                  SignUpFormField.custom(
                    required: true,
                    title: 'Full Name',
                    attributeKey: CognitoUserAttributeKey.name,
                  ),
                  SignUpFormField.email(required: true),
                  SignUpFormField.phoneNumber(required: true),
                  SignUpFormField.password(),
                  SignUpFormField.passwordConfirmation()
                ],
              ),
            ],
          ),
        ),
      ),
      // custom button to take the user to sign in
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Already have an account?'),
            TextButton(
              onPressed: () => widget.state.changeStep(
                AuthenticatorStep.signIn,
              ),
              child: const Text('Sign In',
                  style: TextStyle(fontFamily: 'Poppins')),
            ),
          ],
        ),
      ],
    );
  }
}
