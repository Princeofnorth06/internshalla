import 'package:flutter/material.dart';
import 'package:internshalla/main.dart';

class IconText extends StatelessWidget {
  const IconText(
      {super.key, this.location, required this.icons, required this.text});

  final List<String>? location;
  final String text;

  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icons,
          color: Colors.grey,
          size: 18,
        ),
        SizedBox(
          width: mq.width * 0.015,
        ),
        SizedBox(
            width: mq.width * 0.4,
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ))
      ],
    );
  }
}
