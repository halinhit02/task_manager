import 'package:flutter/material.dart';
import 'package:thuc_tap_chuyen_nganh/util/app_constants.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
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
          'Help Center',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Search Topic',
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17)),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: AppConstants.helpCenter.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(20),
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            AppConstants.helpCenter[index][1] as IconData,
                            size: 36,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            AppConstants.helpCenter[index][0].toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                    );
                  }),
            TextButton(
              onPressed: () {},
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(
                    color: Colors.teal,
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    )),
                alignment: Alignment.center,
                child: const Text(
                  'More Topics',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
