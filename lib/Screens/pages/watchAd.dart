import 'package:flutter/material.dart';

class WatchAd extends StatefulWidget {
  const WatchAd({super.key});

  @override
  State<WatchAd> createState() => _WatchAdState();
}

class _WatchAdState extends State<WatchAd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'lib/assets/images/ad3.png',
            width: 900, 
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
