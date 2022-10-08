import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'quizz.dart';
import 'result.dart';


class PlayPageModel with ChangeNotifier {
  int _totalScore = 0;
  int _questionIndex = 0;

  PlayPageModel(this._questionIndex, this._totalScore);

  void _answerQuestion(bool answer) {
    if (answer) {
      _totalScore++;
      _questionIndex++;
    } else {
      _questionIndex++;
    }
    notifyListeners();
  }
}

class PlayPage extends StatelessWidget {
  const PlayPage({Key? key, required this.quizzModel}) : super(key: key);

  final QuizzModel quizzModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider(
            create: (context) => PlayPageModel(0, 0),
            child: Consumer<PlayPageModel>(
              builder: (context, playPageModel, child) {
                return Scaffold(
                    appBar: AppBar(
                      title:
                      Text(playPageModel._questionIndex != quizzModel.quizz.length ? 'Question ${playPageModel._questionIndex + 1}' : 'Resultat'),
                    ),
                    body: //Succes
                    Center(
                        child: playPageModel._questionIndex <
                            quizzModel.quizz.length
                            ? QuizzPage(
                            answerQuestion: playPageModel._answerQuestion,
                            questionIndex: playPageModel._questionIndex,
                            quizzModel: quizzModel)
                            : ResultPage(playPageModel._totalScore, quizzModel)));
              },
            )));
  }
}