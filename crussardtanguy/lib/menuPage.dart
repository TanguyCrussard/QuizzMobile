import 'package:flutter/material.dart';

import 'modifyPage.dart';
import 'playPage.dart';
import 'quizz.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key, required this.title, required this.quizzModel})
      : super(key: key);

  final QuizzModel quizzModel;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Bienvenue sur le Quizz",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.blueAccent),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PlayPage(quizzModel: quizzModel)));
                },
                child: const Text("Jouer")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ModifyPage(
                              title: "Modification du Quizz",
                              quizzModel: quizzModel)));
                },
                child: const Text("Modifier le Quizz"))
          ],
        ),
      ),
    );
  }
}
