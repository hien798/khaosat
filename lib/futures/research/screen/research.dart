import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaosat/futures/research/bloc/progress_bloc.dart';
import 'package:khaosat/futures/research/bloc/research_bloc.dart';
import 'package:khaosat/futures/research/widgets/progress_bar.dart';
import 'package:khaosat/futures/research/widgets/question_page.dart';
import 'package:khaosat/futures/result/result.dart';

class ResearchScreen extends StatefulWidget {
  static const String route = '/research';

  @override
  _ResearchScreenState createState() => _ResearchScreenState();
}

class _ResearchScreenState extends State<ResearchScreen>
    with TickerProviderStateMixin {
  TabController _controller;
  ResearchBloc _researchBloc;
  ProgressBloc _progressBloc;

  List<StepInfo> stepInfos = List<StepInfo>.generate(5, (index) => StepInfo());

  @override
  void initState() {
    super.initState();
    _researchBloc = BlocProvider.of<ResearchBloc>(context)
      ..onLoadQuestions(1)
      ..onLoadQuestions(2)
      ..onLoadQuestions(3)
      ..onLoadQuestions(4)
      ..onLoadQuestions(5);
    _progressBloc = BlocProvider.of<ProgressBloc>(context);
    _controller = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            BlocBuilder<ProgressBloc, ProgressState>(builder: (context, state) {
              return ProgressBar(
                controller: _controller,
                step1: state.step1,
                step2: state.step2,
                step3: state.step3,
                step4: state.step4,
                step5: state.step5,
              );
            }),
            Expanded(
              child: BlocBuilder<ResearchBloc, ResearchState>(
                builder: (context, state) {
                  return TabBarView(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      QuestionPage(
                        questions: state.step1,
                        onCompleted: (bool isDone, double score) {
                          print(score);
                          _controller.animateTo(1);
                          onUpdated(1, isDone, score);
                        },
                        onChanged: (bool isDone, double score) {
                          onUpdated(1, isDone, score);
                        },
                      ),
                      QuestionPage(
                        questions: state.step2,
                        onCompleted: (bool isDone, double score) {
                          _controller.animateTo(2);
                          onUpdated(2, isDone, score);
                        },
                        onChanged: (bool isDone, double score) {
                          onUpdated(2, isDone, score);
                        },
                      ),
                      QuestionPage(
                        questions: state.step3,
                        onCompleted: (bool isDone, double score) {
                          _controller.animateTo(3);
                          onUpdated(3, isDone, score);
                        },
                        onChanged: (bool isDone, double score) {
                          onUpdated(3, isDone, score);
                        },
                      ),
                      QuestionPage(
                        questions: state.step4,
                        onCompleted: (bool isDone, double score) {
                          _controller.animateTo(4);
                          onUpdated(4, isDone, score);
                        },
                        onChanged: (bool isDone, double score) {
                          onUpdated(4, isDone, score);
                        },
                      ),
                      QuestionPage(
                        questions: state.step5,
                        onCompleted: (bool isDone, double score) {
                          // Sum
                          onUpdated(5, isDone, score);
                          onCompleted();
                        },
                        onChanged: (bool isDone, double score) {
                          onUpdated(5, isDone, score);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  onUpdated(int step, bool status, double score) {
    _progressBloc..onUpdateStatus(step, status);
    final info = stepInfos[step - 1];
    info.isDone = status;
    info.score = score;
  }

  onCompleted() {
    bool isCompleted = true;
    double score = 0.0;
    stepInfos.forEach((e) {
      score += e.score;
      if (!e.isDone) {
        isCompleted = false;
      }
    });
    if (isCompleted) {
      Navigator.of(context).pushReplacementNamed(ResultScreen.route,
          arguments: {'score': score});
    }
  }
}

class StepInfo {
  bool isDone;
  double score;

  StepInfo({
    this.isDone = false,
    this.score = 0.0,
  });
}
