import 'package:flutter/material.dart';
import 'package:flutter_app/quiz.dart';
import 'package:flutter_app/result.dart';
import './question.dart';
import './answer.dart';

// void main() {
//   runApp(MyApp());
// }
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

// statefull 위젯을 만들 떄 MyApp의 명을 따서 State를 붙여야함! 규칙임.
// _ 붙이면 private
class _MyAppState extends State<MyApp> {
  // const -> compile시 설정
  // final -> runtime시 설정

  final questions = const [
    {
      'questionText': "hello1",
      'answer': [
        {'text': 'Black', 'score' : 10},
        {'text': 'Red', 'score' : 5},
        {'text': 'Green', 'score' : 8},
        {'text': 'White', 'score' : 2},
      ],
    },
    {
      'questionText': "hello2",
      'answer': [
        {'text': 'Black2', 'score' : 5},
        {'text': 'Red2', 'score' : 15},
        {'text': 'Green2', 'score' : 3},
        {'text': 'White2', 'score' : 7},
      ],
    },
    {
      'questionText': "hello3",
      'answer': [
        {'text': 'Black3', 'score' : 1},
        {'text': 'Red3', 'score' : 1},
        {'text': 'Green3', 'score' : 1},
        {'text': 'White3', 'score' : 1},
      ],
    }
  ];
  int _questionIndex = 0;
  int _totalScore = 0;

  void _resetQuiz(){
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });

  }

  void _answerQuestion(int score) {
    // 상태 변경은 setState

    _totalScore = _totalScore + score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);

    if (_questionIndex < questions.length) {
      print("runrunrun");
    } else {
      print("no run!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    // var dummy = ['hello'];
    // dummy.add('Max');
    // print(dummy);
    // dummy = [];
    // print(dummy);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("AppBar"),
        ),
        body: _questionIndex < questions.length
            ? Quiz(
                questions: questions,
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
