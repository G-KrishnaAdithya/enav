import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.always,
  label: Text('EMAIL'),
  labelStyle: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    letterSpacing: 1,
  ),
  prefixIcon: Padding(
    padding: EdgeInsets.only(
      right: 15,
      left: 5,
    ),
    child: Icon(
      Icons.email_outlined,
      color: Colors.black,
    ),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  ),
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  ),
);

final kNameFieldDecorator = kTextFieldDecoration.copyWith(
  label: const Text('NAME'),
  prefixIcon: const Padding(
    padding: EdgeInsets.only(
      right: 15,
      left: 5,
    ),
    child: Icon(
      Icons.person_outline,
      color: Colors.black,
    ),
  ),
);

final kPasswordFieldDecorator = kTextFieldDecoration.copyWith(
  label: const Text('PASSWORD'),
  prefixIcon: const Padding(
    padding: EdgeInsets.only(
      right: 15,
      left: 5,
    ),
    child: Icon(
      Icons.lock_outline,
      color: Colors.black,
    ),
  ),
);