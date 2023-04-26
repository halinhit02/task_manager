import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyEditProfile extends StatefulWidget {
  const MyEditProfile({Key? key}) : super(key: key);

  @override
  State<MyEditProfile> createState() => _MyEditProfileState();
}

class _MyEditProfileState extends State<MyEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Edit Account',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Full Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      labelText: 'Enter full name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      labelText: 'name@example.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {},
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      )),
                  child: Container(
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              left: 0, right: 0,
              child: MaterialButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                padding:
                const EdgeInsets.symmetric(vertical: 10),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: Container(
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  child: const Text(
                    'Save Change',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
