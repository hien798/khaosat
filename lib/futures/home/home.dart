import 'package:flutter/material.dart';
import 'package:khaosat/futures/research/screen/research.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 44,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ResearchScreen.route);
              },
              child: Text('Làm khảo sát'),
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
