import 'package:flutter/material.dart';

import 'package:internshalla/main.dart';
import 'package:internshalla/screens/filter.dart';

class AppBar2 extends StatelessWidget {
  const AppBar2(
      {super.key,
      required this.profile,
      required this.location,
      required this.duration});

  final List<String> profile;
  final List<String> location;
  final List<String> duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: mq.width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: mq.height * 0.028),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FiltersScreen(
                          profile: profile,
                          location: location,
                          duration: duration,
                        )));
          },
          child: Container(
              height: mq.height * 0.038,
              width: mq.width * 0.23,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/fuicon.png",
                    height: mq.height * .017,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: mq.width * 0.02,
                  ),
                  const Text(
                    'Filters',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: mq.height * 0.01,
        ),
        const Text(
          '10 total internships',
          style: TextStyle(color: Colors.grey),
        )
      ]),
    );
  }
}
