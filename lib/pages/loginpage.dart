import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'enter email'),
              onChanged: ((value) => setState(() {
                    _email = value;
                  })),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'password'),
              onChanged: ((value) => setState(() {
                    _password = value;
                  })),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, onPrimary: Colors.white),
              onPressed: () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _email, password: _password)
                    .then((user) =>
                        Navigator.of(context).popAndPushNamed('/homepage'));
              },
              child: const Text('login'),
            ),
            const SizedBox(height: 15.0),
            const Text('dont have an account?'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: const Text('signUp'),
              onPressed: (() => Navigator.of(context).pushNamed('/signup')),
            ),
          ],
        ),
      )),
    );
  }
}
