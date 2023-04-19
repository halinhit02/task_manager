import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chart.dart';

class MyProductivity extends StatefulWidget {
  const MyProductivity({Key? key}) : super(key: key);

  @override
  State<MyProductivity> createState() => _MyProductivityState();
}

class _MyProductivityState extends State<MyProductivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Productivity',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              const SizedBox(
                height: 5,
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
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                      Text('20 Jul 2022')
                    ],
                  ),
                  const VerticalDivider(
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                      Text('20 Jul 2022')
                    ],
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Report Progess',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'set a goal',
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              '20/28',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'task',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Finish your task now !',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    // CustomPaint(
                    //   foregroundPainter: CircleProgess(),
                    //   child: Container(
                    //     width: 50,
                    //     height: 50,
                    //   ),
                    // )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Statistic Goals',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 400,
                child: ChartScreen(),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20, left: 18),
                child: TextButton(
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.fromLTRB(110, 15, 110, 15),
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        'More Statistic',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CircleProgess extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..strokeWidth = 10
//       ..color = Colors.blueGrey
//       ..style = PaintingStyle.stroke;
//
//     Offset center = Offset(size.width / 5, size.height / 5);
//     double radius = 10;
//     canvas.drawCircle(center, radius, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     throw UnimplementedError();
//   }
// }
