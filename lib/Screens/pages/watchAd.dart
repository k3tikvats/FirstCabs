import 'package:flutter/material.dart';

class WatchAd extends StatefulWidget {
  const WatchAd({super.key});

  @override
  State<WatchAd> createState() => _WatchAdState();
}

class _WatchAdState extends State<WatchAd> {
  int countdown = 5;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() async {
    for (int i = 5; i > 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        countdown = i - 1;
      });
    }
    Navigator.pop(context, true); // Return true to indicate the ad was watched
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$countdown'),
            Image.asset(
              'lib/assets/images/ad3.png',
              width: 900,
              height: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
