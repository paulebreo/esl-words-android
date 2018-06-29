
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:esl_words/pages/landing_page.dart';
import 'package:esl_words/data/globals.dart' as globals;
import 'package:esl_words/data/models.dart';

void main() {
  globals.model.loadData();
  Widget app = new WordApp();
  runApp(app);
}

class WordApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<WordModel>(
      model: globals.model,
      child: new MaterialApp(
        title: 'ESL Word List', 
        theme: ThemeData(primarySwatch: Colors.purple ), 
        home: LandingPage(),
      ),
    );
  }
}

/*

  IDEA: when i choose the subcategory i should get a snackbar showing the actions
  i can take
  
  you need to use a timer to do the countdown

  https://stackoverflow.com/questions/45780902/viewing-a-greeting-screen-for-a-specific-period-of-time/45782116#45782116

  you need to memorize the context when you hit next

  https://stackoverflow.com/questions/49804891/force-flutter-navigator-to-reload-state-when-popping

  make a state that redraws a new scaffold that has a body of a countdown

  

  https://stackoverflow.com/questions/44302588/flutter-create-a-countdown-widget
*/
