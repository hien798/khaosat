import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:khaosat/data/models/question.dart';

class QuestionPage extends StatefulWidget {
  final List<Question> questions;
  final Function onChanged;
  final Function onCompleted;

  QuestionPage({Key key, this.questions, this.onChanged, this.onCompleted})
      : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage>
    with AutomaticKeepAliveClientMixin {
  final _defaultStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
  );
  final Map<String, double> _result = {};

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.questions == null) return _buildNext();
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(16),
      itemCount: widget.questions.length + 1,
      itemBuilder: (context, index) {
        if (index == widget.questions.length) return _buildNext();
        final question = widget.questions[index];
        return Container(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${question.title}: ${question.question}',
                style: _defaultStyle,
              ),
              _buildAnswer(question),
              Divider(height: 1, color: Colors.black),
            ],
          ),
        );
      },
    );
  }

  _buildNext() {
    return Container(
      margin: EdgeInsets.all(12),
      alignment: Alignment.center,
      child: Container(
        width: 44,
        height: 44,
        child: RaisedButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            onCompleted();
          },
          child: Icon(Icons.navigate_next, color: Colors.white),
          color: Colors.blueAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }

  onCompleted() {
    if (widget.onCompleted != null) {
      double score = 0.0;
      bool isDone = true;
      widget.questions.forEach((e) {
        final key = e.title + e.question;
        final _score = _result[key];
        if (_score != null && _score >= 0) {
          score += _score;
        } else {
          isDone = false;
        }
      });
      widget.onCompleted(isDone, score);
    }
  }

  onChanged() {
    if (widget.onChanged != null) {
      double score = 0.0;
      bool isDone = true;
      widget.questions.forEach((e) {
        final key = e.title + e.question;
        final _score = _result[key];
        if (_score != null && _score >= 0) {
          score += _score;
        } else {
          isDone = false;
        }
      });
      widget.onChanged(isDone, score);
    }
  }

  _buildAnswer(Question question) {
    if (question.type == 'single')
      return SingleAnswer(
        question: question,
        onUpdated: (score) {
          final key = question.title + question.question;
          _result[key] = score;
          onChanged();
        },
      );
    else if (question.type == 'multiple')
      return MultipleAnswer(
        question: question,
        onUpdated: (score) {
          final key = question.title + question.question;
          _result[key] = score;
          onChanged();
        },
      );
    else
      return InputAnswer(
        question: question,
        onUpdated: (score) {
          final key = question.title + question.question;
          _result[key] = score;
          onChanged();
        },
      );
  }
}

class SingleAnswer extends StatefulWidget {
  final Question question;
  final Function onUpdated;

  const SingleAnswer({Key key, this.question, this.onUpdated})
      : super(key: key);

  @override
  _SingleAnswerState createState() => _SingleAnswerState();
}

class _SingleAnswerState extends State<SingleAnswer>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String _result;
  final _defaultStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: widget.question.answers.map((e) {
        return RadioListTile(
          value: e,
          groupValue: _result,
          title: Text(e, style: _defaultStyle),
          onChanged: (value) {
            setState(() {
              _result = value;
              if (widget.question.result < widget.question.answers.length) {
                if (widget.onUpdated != null) {
                  widget.onUpdated(
                      widget.question.answers[widget.question.result] == _result
                          ? 1.0
                          : 0.0);
                }
              }
            });
          },
        );
      }).toList(),
    );
  }
}

class MultipleAnswer extends StatefulWidget {
  final Question question;
  final Function onUpdated;

  const MultipleAnswer({Key key, this.question, this.onUpdated})
      : super(key: key);

  @override
  _MultipleAnswerState createState() => _MultipleAnswerState();
}

class _MultipleAnswerState extends State<MultipleAnswer>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final _defaultStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CheckboxGroup(
      labels: widget.question.answers,
      labelStyle: _defaultStyle,
      onSelected: (checked) {
        double score = 0.0;
        final List<String> rs = widget.question.result.map<String>((e) {
          return e >= widget.question.answers.length
              ? ''
              : widget.question.answers[e];
        }).toList();
        for (String ans in checked) {
          if (rs.contains(ans))
            score += 1.0 / rs.length;
          else
            score -= 1.0 / rs.length;
        }
        if (widget.onUpdated != null) {
          widget.onUpdated(score > 0 ? score : 0.0);
        }
      },
    );
  }
}

class InputAnswer extends StatefulWidget {
  final Question question;
  final Function onUpdated;

  const InputAnswer({Key key, this.question, this.onUpdated}) : super(key: key);

  @override
  _InputAnswerState createState() => _InputAnswerState();
}

class _InputAnswerState extends State<InputAnswer>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: TextField(
        onChanged: (value) {
          if (widget.onUpdated != null) {
            widget.onUpdated(value.toLowerCase() ==
                    widget.question.result.toString().toLowerCase()
                ? 1.0
                : 0.0);
          }
        },
        decoration: InputDecoration(hintText: 'Nhập câu trả lời'),
      ),
    );
  }
}
