import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'question.dart';
import 'quizz.dart';

class ModifyPage extends StatelessWidget {
  const ModifyPage({Key? key, required this.title, required this.quizzModel})
      : super(key: key);

  final QuizzModel quizzModel;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider(
      create: (context) => ModifyPageModel(quizzModel),
      child: Consumer<ModifyPageModel>(
        builder: (context, modifyPageModele, child) {
          return Scaffold(
              appBar: AppBar(
                title: Text(title),
              ),
              body: ListView.builder(
                  itemCount: quizzModel.quizz.length,
                  itemBuilder: (BuildContext context, int index) {
                    final question =
                        quizzModel.quizz.elementAt(index).keys.first;
                    final response =
                        quizzModel.quizz.elementAt(index).values.first;
                    return Dismissible(
                        key: Key(question),
                        background: Container(
                          color: Colors.cyan,
                          child: const Icon(
                            Icons.delete,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          modifyPageModele.deleteQuestion(index);
                          var snackBar = SnackBar(
                            content:
                                Text('Suppression de la question "$question"'),
                            action: SnackBarAction(
                              label: 'Annulation de la suppresion',
                              onPressed: () {
                                modifyPageModele
                                    .addQuestion(Question(question));
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Column(
                          children: <Widget>[
                            Card(
                                child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    quizzModel.quizz
                                        .elementAt(index)
                                        .keys
                                        .first,
                                    textAlign: TextAlign.center,
                                  ),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Modification de la question"),
                                            content: TextField(
                                                decoration: InputDecoration(
                                                    hintText: question),
                                                onSubmitted: (value) {
                                                  Navigator.of(context).pop();
                                                  modifyPageModele
                                                      .changeQuestion(value,
                                                          index, response);
                                                }),
                                          );
                                        });
                                  },
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      modifyPageModele.modifyResponse(index);
                                    },
                                    child: Text(response.toString()))
                              ],
                            )),
                          ],
                        ));
                  }),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Ajouter une question"),
                          content: TextField(
                              decoration: const InputDecoration(
                                  hintText: "Saisir une question"),
                              onSubmitted: (value) {
                                modifyPageModele.addQuestion(Question(value));
                                Navigator.of(context).pop();
                              }),
                        );
                      });
                },
                tooltip: 'Ajouter une question',
                child: const Icon(Icons.add),
              ));
        },
      ),
    ));
  }
}

class ModifyPageModel with ChangeNotifier {
  final QuizzModel _quizzModel;

  ModifyPageModel(this._quizzModel);

  void deleteQuestion(int index) {
    _quizzModel.quizz.removeAt(index);
    notifyListeners();
  }

  void addQuestion(Question question) {
    _quizzModel.quizz.add({question.questionText: true});
    notifyListeners();
  }

  void changeQuestion(String question, int index, bool response) {
    _quizzModel.quizz.removeAt(index);
    _quizzModel.quizz.insert(index, {question: response});
    notifyListeners();
  }

  void modifyResponse(int index) {
    final question = _quizzModel.quizz.elementAt(index).keys.first;
    final response = _quizzModel.quizz.elementAt(index).values.first;
    _quizzModel.quizz.elementAt(index).update(question, (value) => !response);
    notifyListeners();
  }
}
