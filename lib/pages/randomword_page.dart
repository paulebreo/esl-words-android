import 'package:flutter/material.dart';
import 'package:esl_words/data/globals.dart' as globals;


class RandomWordPage extends StatefulWidget {
  final List<String> subcategory;
  final String category;

  RandomWordPage({this.category, this.subcategory});
  // connect the widget to the state
  @override
  State createState() => new RandomWordPageState();
}
  
class RandomWordPageState extends State<RandomWordPage> {
  List _subcategoryWords;
  String _currentWord;

  void _initWords() {
    // _subcategoryWords = globals.model.getRandomSubcategoryWords(widget.category, widget.subcategory);
    _subcategoryWords = globals.model.getAllSubcategoryWords(widget.category, widget.subcategory);
  }

  void _gotoResultsPage() {
    Navigator.pop(context);
    // print('navigate');
    // var route = new MaterialPageRoute(
    //   builder: (BuildContext context) =>
    //   new SubcategoryPage(category: widget.category)
    // );

    // Navigator.of(context).push(route);
  }
  void _resetWords() {
    if(_subcategoryWords.isNotEmpty) {
      setState(() {
        _currentWord = _subcategoryWords.last;
      });
      _subcategoryWords.removeLast();
      print(_currentWord);
      print(_subcategoryWords);   
      
    } else {
      _gotoResultsPage();
    }
  }

  @override
  void initState() {
      super.initState();
      _initWords();
      _resetWords(); 
      // your code follows
  }

  @override
  void dispose() {
    // your code precedes
    super.dispose();
  }

  var buildTextStyle = () => new TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 50.0);
  
  @override
  Widget build(BuildContext context) {
      return new Material(
          // color: Colors.blueAccent,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(_currentWord, style: buildTextStyle()),
              new IconButton(
                icon: new Icon(Icons.arrow_right),
                color: Colors.black,
                iconSize: 50.0,
                onPressed: _resetWords,
                )
            ],
          )
        );
  }
}
