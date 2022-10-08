import 'dart:convert';
import 'package:flutter/material.dart';

import 'question.dart';

class QuizzModel with ChangeNotifier {
  final List<Map<String, bool>> _quizz = [];
  final int _questionIndex = 0;
  final Function answerQuestion = () => {};

  List<Map<String, bool>> get quizz => _quizz;

  int get questionIndex => _questionIndex;

  QuizzModel();

  void fromJson(String jsonString) {
    if(quizz.isEmpty){
      var jsonDecoded = jsonDecode(jsonString);
      for (var value in jsonDecoded[jsonDecoded.keys.first]) {
        quizz.add({
          Question(value['question']).questionText:
          "vrai".compareTo(value['reponse']) == 0
        });
      }
    }
  }
}

class QuizzPage extends StatelessWidget {
  final QuizzModel quizzModel;
  final int questionIndex;
  final Function answerQuestion;

  const QuizzPage({
    Key? key,
    required this.quizzModel,
    required this.questionIndex,
    required this.answerQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Question(
        quizzModel._quizz[questionIndex].keys.first,
      ),
      SizedBox(
        width: 300,
        height: 150,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => {
                if (quizzModel._quizz[questionIndex].values.first)
                  {
                    answerQuestion(true),
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Correct'),
                        duration: Duration(milliseconds: 600))),
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Incorrect'),
                        duration: Duration(milliseconds: 600))),
                    answerQuestion(false),
                  }
              },
              child: const Text('Vrai'),
            ),
            ElevatedButton(
              onPressed: () => {
                if (!quizzModel._quizz[questionIndex].values.first)
                  {
                    answerQuestion(true),
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Correct'),
                        duration: Duration(milliseconds: 600))),
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Incorrect'),
                        duration: Duration(milliseconds: 600))),
                    answerQuestion(false),
                  }
              },
              child: const Text('Faux'),
            ),
          ],
        ),
      )
    ]);
  }
}

/*
  child

      :

  const Text

  (

  'Faux'),
  ),
  ),
  /*...(quizzModel._quizz[questionIndex].values.first
                as List<Map<String, bool>>)
            .map((answer) {
          return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => {
                  if (answer.values.first !=
                      quizzModel._quizz[questionIndex].values.first)
                    {
                      answerQuestion(false),
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Incorrect'),
                          duration: Duration(seconds: 1)))
                    }
                  else
                    {
                      answerQuestion(true),
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Correct')))
                    }
                },
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(color: Colors.white)),
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                child: Text(answer['text'].toString()),
              ));
        }).toList()*/
  ],
  );*/
