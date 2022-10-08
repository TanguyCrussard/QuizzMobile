import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'menuPage.dart';
import 'quizz.dart';

const String URL =
    'https://dept-info.univ-fcomte.fr/joomla/images/CR0700/JSON/quizz_monde_animal.json';

void main() {
  runApp(MyApp(QuizzModel()));
}

class MyApp extends StatelessWidget {
  MyApp(this.quizzModel, {Key? key}) : super(key: key);

  final QuizzModel quizzModel;

  @override
  Widget build(BuildContext context) {
    fetchQuizz(quizzModel);
    return MaterialApp(
      home: MenuPage(title: 'Menu', quizzModel: quizzModel),
    );
  }
}

Future<void> fetchQuizz(QuizzModel quizzModel) async {
  if (quizzModel.quizz.isEmpty) {
    var response = await http.get(Uri.parse(URL));

    if (response.statusCode == 200) {
      quizzModel.fromJson(const Utf8Decoder().convert(response.bodyBytes));
    } else {
      throw Exception('Erreur lors de la récupération des questions');
    }
  }
  print(quizzModel.quizz);
}
