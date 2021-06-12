import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    var resultText = 'You did it!';
    if(resultScore <= 8){
      resultText = "You are Good1";
    }else{
      resultText = "You are Good2";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          FlatButton(child: Text("Restart!!"), onPressed: resetHandler,color: Colors.blue,)
        ],
      ),
    );
  }
}
