import 'package:flutter/material.dart';
import 'package:esl_words/data/globals.dart' as globals;

class WordsPage extends StatelessWidget {
  final List<String> subcategory;
  final String category;
  final List _subcategoryWords;
  WordsPage({this.category, this.subcategory}) : 
    // _subcategoryWords = globals.model.getSubcategoryWords(category, subcategory).reversed.toList();
    _subcategoryWords = globals.model.getAllSubcategoryWords(category, subcategory).reversed.toList();

  @override
  Widget build(BuildContext context) {

    var buildListView = () => new ListView.builder(
        
        itemCount: _subcategoryWords.length,
        itemBuilder: (context, i) {
          return new ListTile(title: new Text(_subcategoryWords[i]));
        });

    Widget _buildButton() {
      return new FloatingActionButton(
        foregroundColor: Colors.blueAccent,
        onPressed: () => print('hello'),
        tooltip: 'Increment',
        child: new Icon(Icons.add, color: Colors.white),
      );
    }

    return new Scaffold(
      // floatingActionButton: _buildButton(),
      appBar: new AppBar(title: new Text(category),),
      body: buildListView(),
    );
  }
}