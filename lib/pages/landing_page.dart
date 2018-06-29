import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:esl_words/data/models.dart';
import 'package:esl_words/pages/main_page.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    
    var buildLoadingIndicator = () => ScopedModelDescendant<WordModel>(
          builder: (context, child, model) => model.isLoading ? new Container(
                      color: Colors.grey[300],
                      width: 70.0,
                      height: 70.0,
                      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
              ):new Container()
    ,);
    
    
    _loading? new Container(
      color: Colors.grey[300],
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container();

    Widget _inkWell = new InkWell( // an invisible button
        onTap: () => Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => new ComboWordsPage())),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('ESL', style: new TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)),
            new Text('Word Prompt', style: new TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)),
            new Text('Tap to start!', style: new TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold)),
      ],)
    );

    return new Scaffold(
      backgroundColor: Colors.purple,
      body: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _inkWell,
              new Center(
                child: buildLoadingIndicator(),
              ),
            ],
          ),
    );

  }
  

}