import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/buttons.dart';
import '../components/components.dart';
import '../main_page.dart';
import '../navigate_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 32,
        ),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Colors.grey,
              ),
              decoration: kTextFieldDecoration,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _passwordController,
              cursorColor: Colors.black,
              obscureText: _isObscure,
              obscuringCharacter: '●',
              style: const TextStyle(
                color: Colors.grey,
              ),
              decoration: kPasswordFieldDecorator.copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            YellowButton(
              onTap: () async {
                if (_emailController.text.length != 0 &&
                    _passwordController.text.length != 0) {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigatePage(),
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
              label: 'Log In',
            ),
          ],
        ),
      ),
    );
  }
}

