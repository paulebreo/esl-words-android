import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';

class WordModel extends Model {
  String _name = 'john';
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  Map<String, Map<String, List>> _mydata;

  
  Map _jsonData;
  Map get jsonData => _jsonData;
  Map<String, Map<String, List>> get mydata => _mydata;
  String get name => _name;
  
  Future<Map<String, Map<String, List>>> parseJsonData(Map jdata) async {
    //var mydata = new Map<String, Map<SubCategory, List<String>>>();
    var mydata = new Map<String, Map<String, List>>();
    // add the category
    jdata['data'].forEach((item) {
      mydata[item['main_title']] = {};
    });

    // for each category
    for (String category in mydata.keys) {
      // go through the jdata again
      for (Map jdata_item in jdata['data']) {
        String subcategory = jdata_item['sub_title'];
        List wordlist = jdata_item['wordlist'];
        if (jdata_item['main_title'] == category)
          mydata[category].putIfAbsent(subcategory, () => wordlist);
      }
    }
    return mydata;
  }


  Future<List<String>> getCategories() async {
    var x =  _mydata.keys.toList();
    x.sort((a,b)=> a.compareTo(b));
    return x;
  }

  List<String> getSubcategories(String category) {
    return _mydata[category].keys.toList();
  }
  List getSubcategoryWords(String category, String subcategory){
    var x = _mydata[category][subcategory].reversed.toList();
    return x;
  }

  List getRandomSubcategoryWords(String category, String subcategory){
    List x = _mydata[category][subcategory];
    x.shuffle();
    return x;
  }

  List getAllSubcategoryWords(String category, List<String> subcategories){
    var subcats = List<String>();
    subcategories.forEach((subcat){
      subcats.addAll(_mydata[category][subcat].map((x)=>x));
    });
    return subcats;
  }

  Future loadData() async {
    // Set our model to loading
    _isLoading = true;
    // Notify Widgets listening to the model that it is now loading and they should
    // show a loading spinner
    notifyListeners();

    // Load the data
    _jsonData = json.decode(await rootBundle.loadString('assets/data/words5.json'));

    _mydata = await parseJsonData(_jsonData);

    // Set loading to false now that the data is loaded
    _isLoading = false;

    // Once again, notify the Widgets listening to this model that it is done loading
    // and data is available for consumption
    notifyListeners();
  }
}