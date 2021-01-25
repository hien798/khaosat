import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  static const String route = '/result';
  final double score;

  const ResultScreen({Key key, this.score = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Chúc mừng bạn đã hoàn thành bài kiểm tra!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            Text(
              'Kết quả:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '${score.toStringAsFixed(2)}/10.0',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 32),
            Container(
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Go Home',
                  style: TextStyle(fontSize: 16),
                ),
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
