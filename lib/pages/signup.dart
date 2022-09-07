import 'package:firebase_basics/services/usermanagement.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
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
              onPressed: (() => FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((signedInUser) {
                    UserManagement().storeNewUser(signedInUser.user, context);
                  }).catchError((e) => print(e))),
              child: const Text('login'),
            ),
          ],
        ),
      )),
    );
  }
}
