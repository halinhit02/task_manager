import 'package:flutter/material.dart';
import 'package:thuc_tap_chuyen_nganh/profile/screen/widget/edit_profile.dart';
import 'package:thuc_tap_chuyen_nganh/profile/screen/widget/help_center.dart';
import 'package:thuc_tap_chuyen_nganh/profile/screen/widget/productivity_screen.dart';

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
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Image(
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                    image: AssetImage('assets/anh_phuong.jpg')),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Phạm Thị Thu Phương',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Center(
              child: Text(
                'PhuongNguNgoc123@gmail.com',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 10,
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
            Divider(
              thickness: 1,
              endIndent: 8,
              indent: 8,
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
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => HelpCenterScreen()));
              },
            ),
            const SizedBox(
              height: 5,
            ),
            RowDescription(
              icon: Icons.logout,
              title: 'Log Out',
              subIcon: Icons.navigate_next,
              onTap: () {},
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
    return GestureDetector(
      onTap: () => onTap(),
      child: ListTile(
        leading: Icon(icon, size: 25),
        title: Text(
          '$title',
          style: TextStyle(fontSize: 20),
        ),
        trailing: Icon(subIcon),
      ),
    );
  }
}
