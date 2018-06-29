import 'dart:async';
import "package:flutter/material.dart";
import 'package:esl_words/data/globals.dart' as globals;
import 'package:esl_words/pages/circletimer_page.dart';
import 'package:esl_words/pages/words_page.dart';
import 'package:esl_words/pages/randomword_page.dart';
import 'package:esl_words/pages/useroptions_page.dart';
import 'package:esl_words/ui/navigation_icon.dart';
import 'package:esl_words/ui/choice.dart';


class ComboWordsPage extends StatefulWidget {
  @override
  _ComboWordsPageState createState() => new _ComboWordsPageState();
}

class _ComboWordsPageState extends State<ComboWordsPage> with TickerProviderStateMixin {

  List<NavigationIconView> _navigationViews;
  int _currentIndex = 0;
  int _total = 3;
  List<String> _subcatWordlist = [];
   Choice _selectedChoice = choices[0]; // The app's "state".
  String _currentCategory;
  String _currentSubcategory;
  List<String> selectedSubcats = [];
  bool _hideBotNav = true;
  bool _showBotNav = false;
  double _maxAnimatedHeight = 60.0;
  static String t2;
  // BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<List<String>> _categories;
  // Image _partyImage = new Image.network(
  //     "http://www.freshcardsgifts.co.uk/images/_lib/animal-party-greetings-card-3003237-0-1344698261000.jpg");
  
  // Image _partyImage = new Image.asset('assets/smiley.jpg');
  

  //Image _partyImage = new Image.asset(t2);
  void resetCats() {
    _currentCategory = null;
    selectedSubcats = [];
  }
  
  @override
  void initState() {
    super.initState();
   
    _categories = globals.model.getCategories();
     _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.timelapse),
        title: 'Timed',

     
      ),
      new NavigationIconView(
        icon: const Icon(Icons.shuffle),
        title: 'Random',

   
      ),


      new NavigationIconView(
        icon: const Icon(Icons.assignment),
        title: 'List',


      )
    ];
  }
  
  
  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    if(choice.title == 'Options') {
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new UserOptionsPage()));
    }
  }
 
  
  @override
  Widget build(BuildContext context) {
      
      void gotoRandom() {
        print('random');
        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new RandomWordPage(category: _currentCategory, subcategory: selectedSubcats),
        );
        Navigator.of(context).push(route);
      }
      
      void gotoTimed() {
              var route = new MaterialPageRoute(
                builder: (BuildContext context) => new TimerCirclePage(
                    category: _currentCategory,
                    subcategory: selectedSubcats,
                    isRandom: globals.isRandomWords),
              );
              Navigator.of(context).push(route);
      }

      void gotoList() {
              var route = new MaterialPageRoute(
                builder: (BuildContext context) => new WordsPage(category: _currentCategory, subcategory: selectedSubcats),
              );
              Navigator.of(context).push(route);
      }
     
     final botNavBar = new Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.purple,
          splashColor: Colors.yellowAccent,
          // primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(caption: new TextStyle(color: Colors.white))
        ),
       child:new BottomNavigationBar(
        fixedColor: Colors.white,
       items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      // type: _type,
      onTap: (int index) {
        String navbarAction = _navigationViews[index].title;
        if(_currentCategory == null) {
          scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text("Please select a category above.")
          ),);
          return;
        } 
        switch (navbarAction) {
          case 'Timed':
            print('timed');
            gotoTimed();
             break;
          case 'Random':
            gotoRandom();
            break;
          case 'List':
            print('list');
            gotoList();
            break;
        }
        setState(() {
          // _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          // _navigationViews[_currentIndex].controller.forward();
        });
      },
    )
     );
     
     

    void toggleBotNavBar() {
      if(selectedSubcats.isEmpty) {
        setState(() {
            _showBotNav = false;
                });
      } else {
          setState(() {
            _showBotNav = true;
          });
      }
      //  _animatedHeight!=0.0 ? _animatedHeight=0.0 :_animatedHeight=60.0;
    }
    void toggleSubcatSelection(String subcat) {
      
      if(selectedSubcats.contains(subcat)){
        setState(() {
                  selectedSubcats.remove(subcat);
                });        
      } else {
        setState(() {
        selectedSubcats.add(subcat);
                });
      }
    }

    List<Widget> buildSubCatListTiles() {
      var x = List<Widget>();
      if(_subcatWordlist.isEmpty) return <Widget>[];

      _subcatWordlist.forEach((subcat){

        ListTile newTile = new ListTile(
          title: new Text(subcat),
          selected: selectedSubcats.contains(subcat),
          onTap: () {
             _currentSubcategory = subcat;
            // print(_currentSubcategory);
            toggleSubcatSelection(subcat);
            toggleBotNavBar();
             // setState(() {
            //   _currentSubcategory = subcat;              
            // });
          },
        );
        var ltTheme = new ListTileTheme(child:newTile, selectedColor: Colors.deepPurpleAccent, );
 
        x.add(ltTheme);
      }); 
      return x;
    }
  
      var catListMenu = (BuildContext context, AsyncSnapshot snapshot) {
      return new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length, //add the length of your list here
                itemBuilder: (BuildContext context, int index) {
                  String cat = snapshot.data[index];
                  try {
                    t2 = "assets/images/" +globals.catimages[cat];
                  } catch(e) {
                    t2 = "assets/images/smiley.png";
                  }
                
                  return new  Column(
                          children: <Widget>[
                            new Container(
                              width: 100.0, height: 100.0,
                              child: new FlatButton(
                                child: Image.asset(t2),
                                onPressed: () 
                                {
                                 resetCats();
                                  _currentCategory = cat;

                                  setState((){
                                    _showBotNav = false;
                                    _subcatWordlist = globals.model.getSubcategories(cat);
                                  });
                                },
                                ),
                              ),
                            //Exact width and height, consider adding Flexible as a parent to the Container
                            new Text("$cat")
                          ],
                        );
                });
    };  

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
      var buildCatLisView = new Container(padding: new EdgeInsets.all(0.0), height: 150.0,
        child: new ListView(
        children: <Widget>[
                new Container(height: 120.0, child: catListMenu(context,  snapshot)),
              ],
            ),
      );



      var buildSubCatListView = new Expanded(child: new Container(padding: new EdgeInsets.all(0.0), child:
      new ListView(
        children: <Widget>[
                 new Column(children: buildSubCatListTiles())
              ],
            ),
      ));
      
     
      return new Column(
        children: <Widget>[
            buildCatLisView,
            buildSubCatListView
        ]
      );
    }

    var futureBuilder = new FutureBuilder(
      future: _categories,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    var popUpMenu =  new PopupMenuButton<Choice>(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return new PopupMenuItem<Choice>(
                    value: choice,
                    child: new Text(choice.title),
                  );
                }).toList();
              },
            );
    
    var buildIcon = new IconButton(
      icon: new Icon(Icons.settings),
      tooltip: 'Settings',
      onPressed: (){  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new UserOptionsPage())); },
    );

    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(title: new Text("Common words"),actions:<Widget>[buildIcon]),
      bottomNavigationBar: _showBotNav ? botNavBar : null,
      body: futureBuilder,
          
    );
  }
  
}

