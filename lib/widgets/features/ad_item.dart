import 'package:flutter/material.dart';


class AdItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const AdItem({Key? key, required this.title, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(imageUrl),
          Text(title),
        ],
      ),
    );
  }
}