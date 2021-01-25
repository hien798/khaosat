import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final TabController controller;
  final bool step1;
  final bool step2;
  final bool step3;
  final bool step4;
  final bool step5;

  const ProgressBar(
      {Key key,
      this.controller,
      this.step1,
      this.step2,
      this.step3,
      this.step4,
      this.step5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        bottom: false,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: TabBar(
            controller: controller,
            tabs: [
              StepWidget(
                step: 1,
                title: 'Khảo sát',
                isDone: step1 == true,
              ),
              StepWidget(
                step: 2,
                title: 'Khảo sát nhu cầu 2',
                isDone: step2 == true,
              ),
              StepWidget(
                step: 3,
                title: 'Khảo sát nhu cầu 3',
                isDone: step3 == true,
              ),
              StepWidget(
                step: 4,
                title: 'Khảo sát nhu cầu 4',
                isDone: step4 == true,
              ),
              StepWidget(
                step: 5,
                title: 'Tổng kết nhu cầu tham gia',
                isDone: step5 == true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepWidget extends StatelessWidget {
  final int step;
  final String title;
  final bool isDone;
  final double width;
  final double height;

  const StepWidget(
      {Key key,
      this.step,
      this.title,
      this.isDone = false,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(isDone);
    return Container(
      width: width ?? MediaQuery.of(context).size.width / 5,
      height: height ?? 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDone ? Colors.green : Colors.pink,
              ),
              child: isDone
                  ? Icon(Icons.done, color: Colors.white)
                  : Text(
                      '${step ?? 0}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          Expanded(
            child: Text(
              title ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
