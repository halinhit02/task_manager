import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../helper/dialog_helper.dart';
import '../../../../repository/auth_repos.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Change Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: 'Your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "New Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: 'New password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  if (oldPasswordController.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'Enter the current password.');
                    return;
                  }
                  if (oldPasswordController.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'Enter the new password.');
                    return;
                  }
                  DialogHelper.showLoadingDialog(context);
                  AuthRepos.instance
                      .updatePassword(
                          oldPasswordController.text, passwordController.text)
                      .then((value) {
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(msg: 'The password is changed.');
                  }).catchError((e) async {
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(msg: e.toString());
                  });
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(12),
                )),
                color: Theme.of(context).primaryColor,
                child: Container(
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  child: const Text(
                    'Change Password',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
