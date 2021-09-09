import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.color,
      required this.title,
      required this.casesNumber,
      required this.width,
      required this.textStyle,
      required this.textStyle2,
      required this.height})
      : super(key: key);

  final Color color;
  final String title;
  final String casesNumber;
  final double height;
  final double width;
  final TextStyle? textStyle;
  final TextStyle? textStyle2;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(top: 20),
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: textStyle,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            casesNumber,
            style: textStyle2,
          ),
        ],
      ),
    );
  }
}
