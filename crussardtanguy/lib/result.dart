import 'package:flutter/material.dart';

import 'quizz.dart';
import 'menuPage.dart';

class ResultPage extends StatelessWidget {
  const ResultPage(this.resultScore, this.quizzModel, {Key? key})
      : super(key: key);

  final QuizzModel quizzModel;
  final int resultScore;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Score : ' '$resultScore',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MenuPage(title: 'Menu', quizzModel: quizzModel))),
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(14),
                child: const Text(
                  'Restart quizz',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ))
        ],
      ),
    );
  }
}
