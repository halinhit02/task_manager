import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Your work faster and structured with Todyapp',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Enter your username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    suffixIcon: Icon(Icons.remove_red_eye_sharp)),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(bottom: 20, left: 18),
        child: TextButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.fromLTRB(150, 15, 150, 15),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
      ),
    );
  }
}
