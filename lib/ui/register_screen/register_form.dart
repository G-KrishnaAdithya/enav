import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/buttons.dart';
import '../components/components.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isObscure = true;

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
              controller: _nameController,
              cursorColor: Colors.black,
              style: const TextStyle(
                color: Colors.grey,
              ),
              decoration: kNameFieldDecorator,
            ),
            const SizedBox(
              height: 24,
            ),
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
                if(_passwordController.text.length != 0 && _emailController.text.length != 0 && _nameController.text.length != 0){
                  try{
                    final newUser = await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                    if(newUser != null){
                      print(newUser);
                    }
                  } catch(e) {
                    print(e);
                  }
                }
              },
              label: 'Sign Up',
            ),
          ],
        ),
      ),
    );
  }
}

