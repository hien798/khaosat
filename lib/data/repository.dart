import 'dart:io';
import 'package:khaosat/data/api.dart';
import 'package:khaosat/data/models/question.dart';

class Repository {
  final Api api;

  Repository(this.api);

  Future<List<Question>> loadQuestions(int step) async {
    return questionFromJson(jsonData);
  }

}

const jsonData = '''
[
    {
        "title":"Question 1",
        "question":"Tỉnh nào thuộc Tây Nguyên",
        "type":"single",
        "answers": [
            "Lâm Đồng",
            "Đồng Nai",
            "Đồng Tháp",
            "Quảng Ngãi"
        ],
        "result": 0
    },
    {
        "title":"Question 2",
        "question":"Sông Hồng còn được gọi là gì?",
        "type":"multiple",
        "answers": [
            "Sông Mã",
            "Sông Nhị Hà",
            "Sông Đà Rằng",
            "Sông Xích Đằng",
            "Sông Bạch Hạc"
        ],
        "result": [1,3,4]
    },
    {
        "title":"Question 3",
        "question":"Tên gọi cố đô Huế thời Tây Sơn là gì?",
        "type":"input",
        "result": "Phú Xuân"
    },
    {
        "title":"Question 4",
        "question":"Đâu là các tỉnh thành không giáp biển?",
        "type":"multiple",
        "answers": [
            "Hà Nội",
            "TP. Hồ Chí Minh",
            "Hải Phòng",
            "Đà Nẵng",
            "Cần Thơ"
        ],
        "result": [0,4]
    },
    {
        "title":"Question 5",
        "question": "Lũy Thầy là công trình do ai xây dựng?",
        "type":"single",
        "answers": [
            "Lý Thường Kiệt",
            "Trần Quang Diệu",
            "Trịnh Kiểm",
            "Đào Duy Từ"
        ],
        "result": 3
    }
]
''';
