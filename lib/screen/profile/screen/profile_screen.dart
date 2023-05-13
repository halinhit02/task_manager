import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/repository/auth_repos.dart';
import 'package:thuc_tap_chuyen_nganh/screen/login/bloc/login_bloc.dart';
import 'package:thuc_tap_chuyen_nganh/screen/login/screen/login_screen.dart';
import 'package:thuc_tap_chuyen_nganh/screen/profile/screen/widget/edit_profile.dart';
import 'package:thuc_tap_chuyen_nganh/screen/profile/screen/widget/productivity_screen.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  'https://i.pravatar.cc/84',
                  width: 84,
                  height: 84,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Hà Linh',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'admin@halinhit.com',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 15,
            ),
            RowDescription(
              icon: Icons.person,
              title: 'Edit Profile',
              subIcon: Icons.navigate_next,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => MyEditProfile()));
              },
            ),
            const SizedBox(
              height: 5,
            ),
            RowDescription(
              icon: Icons.account_tree,
              title: 'Productivity',
              subIcon: Icons.navigate_next,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => MyProductivity()));
              },
            ),
            const SizedBox(
              height: 5,
            ),
            RowDescription(
              icon: Icons.sunny,
              title: 'Change Mode',
              subIcon: Icons.navigate_next,
              onTap: () {},
            ),
            const Divider(
              thickness: 1,
              endIndent: 15,
              indent: 15,
            ),
            const SizedBox(
              height: 5,
            ),
            RowDescription(
              icon: Icons.key_outlined,
              title: 'Privacy Policy',
              subIcon: Icons.navigate_next,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            RowDescription(
              icon: Icons.help_center_outlined,
              title: 'Help Center',
              subIcon: Icons.navigate_next,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            RowDescription(
              icon: Icons.logout,
              title: 'Log Out',
              subIcon: Icons.navigate_next,
              onTap: () => AuthRepos().signOut().then(
                    (value) => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (_) => BlocProvider(
                              create: (context) => LoginBloc(),
                              child: const LoginScreen())),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class RowDescription extends StatelessWidget {
  final IconData icon;
  final String title;
  final IconData subIcon;
  final Function() onTap;

  const RowDescription(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subIcon,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Icon(
                subIcon,
                size: 16,
              ),
            ],
          ),
        ));
  }
}
