import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          'Help Center',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Search Topic',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
          Container(
            height: 530,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.blueGrey,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Image(
                            image: NetworkImage(
                                'https://tse4.mm.bing.net/th?id=OIP.gmxJsItU1KoRN8ccO_h0HwHaHa&pid=Api&P=0'),
                            width: 80),
                        Text(
                          'platform are you',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
      bottomNavigationBar: TextButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: Colors.teal,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text(
            'More Topics',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
