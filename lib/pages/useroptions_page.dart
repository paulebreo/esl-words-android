import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:esl_words/data/globals.dart' as globals;

// a widget
class UserOptionsPage extends StatefulWidget {
  // connect the widget to the state
  @override
  State createState() => new UserOptionsPageState();
}

Future<bool> saveIsRandomPreferences(bool isRandom) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool("isRandom", isRandom);
}

Future<bool> getIsRandomPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isRandom = prefs.getBool("isRandom");
  return isRandom;
}

Future<bool> saveTimePreferences(String time) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("time", time);
}

Future<String> getTimePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String time = prefs.getString("time");
  return time;
}

// a state
class UserOptionsPageState extends State<UserOptionsPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _timerIsRandom;
  List<String> _checkValues = [
    '5 seconds',
    '10 seconds',
    '15 seconds',
    '20 seconds',
    '30 seconds',
    '45 seconds',
    '60 seconds',
  ];
  final String _checkedValue1 = '5 seconds';
  final String _checkedValue2 = '10 seconds';
  final String _checkedValue3 = '15 seconds';
  final String _checkedValue4 = '20 seconds';
  final String _checkedValue5 = '30 seconds';
  final String _checkedValue6 = '45 seconds';
  final String _checkedValue7 = '60 seconds';
  Map<String, int> _countdownDuration = {
    '5 seconds': 5,
    '10 seconds': 10,
    '15 seconds': 15,
    '20 seconds': 20,
    '30 seconds': 30,
    '45 seconds': 45,
    '60 seconds': 60,
  };
  List<String> _checkedValues;
  String _currentCheck;

  bool switchValue = false;

  Future<void> _changeTimerIsRandom(bool value) async {
    final SharedPreferences prefs = await _prefs;
    // get the value, if null, set it to false
    bool timerIsRandom = !(prefs.getBool('timerIsRandom') ?? false);
    // now, flip the value
    timerIsRandom = !timerIsRandom;

    setState(() {
      _timerIsRandom =
          prefs.setBool("timerIsRandom", timerIsRandom).then((bool success) {
        return timerIsRandom;
      });
    });
  }

  Future<bool> _changeTimerIsRandom2(bool value) async {
    print("the top of changeTimerIsRandom2 value: ${value}");
    final SharedPreferences prefs = await _prefs;
    return prefs.setBool("timerIsRandom", value);
  }

  @override
  void initState() {
    getIsRandomPreference().then(updateIsRandom);
    super.initState();
    _currentCheck = _checkedValue1;
    getTimePreference().then(updateTime);
  }

  @override
  Widget build(BuildContext context) {
    var buildListTile = new FutureBuilder(
        future: _timerIsRandom,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError)
                return new Text("Error: ${snapshot.error}");
              else {
                return new ListTile(
                  title: const Text('Randomize words in timer'),
                  trailing: Switch(
                      value: switchValue,
                      onChanged: (bool value) async {
                        print("the switchvalue ${switchValue}");
                        await _changeTimerIsRandom2(value);
                        setState(() {
                          switchValue = value;
                        });
                        print("the switchvalue after save ${switchValue}");
                        saveIsRandom();
                      }),
                );
              }
          }
        });

    var buildListTile2 = new FutureBuilder(
        future: _timerIsRandom,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError)
                return new Text("Error: ${snapshot.error}");
              else {
                return new ListTile(
                    title: const Text('Timer duration'),
                    trailing: new PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      onSelected: showCheckedMenuSelections,
                      itemBuilder: (BuildContext context) =>
                          List<PopupMenuItem<String>>.generate(7, (int i) {
                            return new CheckedPopupMenuItem<String>(
                                value: _checkValues[i],
                                checked: isChecked(_checkValues[i]),
                                child: new Text(_checkValues[i]));
                          }),
                    ));
              }
          }
        });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Options'),
        ),
        body: ListView(children: <Widget>[
          buildListTile,
          buildListTile2,
          // Pressing the PopupMenuButton on the right of this item shows
          // a menu whose items have text labels and icons and a divider
          // That separates the first three items from the last one.
        ]));
  }

  void saveIsRandom() {
    saveIsRandomPreferences(switchValue).then((bool commited) {
      print("switch value saved : ${switchValue}");
    });
  }
  void saveTime() {
    saveTimePreferences(_currentCheck).then((bool committed){
      print("time value saved: ${_currentCheck}");
    });
  }

  void updateIsRandom(bool isRandom) {
    setState(() {
      switchValue = isRandom;
    });
  }
  void updateTime(String time) {
    setState(() {
      _currentCheck = time;
    });
  }
  // void showCheckedMenuSelections(String value) {
  //   if (_checkedValues.contains(value))
  //     _checkedValues.remove(value);
  //   else
  //     _checkedValues.add(value);

  // }
  void showCheckedMenuSelections(String value) {
    if (_currentCheck == value)
      _currentCheck = "";
    else {
      _currentCheck = value;
      globals.countdownDuration = _countdownDuration[value];
      saveTime();
      print("the duration now is ${globals.countdownDuration}");
    }
  }

  // bool isChecked(String value) => _checkedValues.contains(value);
  bool isChecked(String value) => _currentCheck == value;

  
}
