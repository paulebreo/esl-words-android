library esl_words.globals;

import 'dart:async';

import 'package:esl_words/data/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
String person = 'billy';
WordModel model = new WordModel();
int countdownDuration = 15;
bool isRandomWords = true;

Future<bool> saveRandomPreference(bool randomizeTimer) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool("randomize_timer", randomizeTimer);
}

Future<bool> getRandomPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var randomizeTimer =  prefs.getBool("randomize_timer");
  return randomizeTimer;
}

Map<String, String> catimages = {
  "Animals": "animals.png",
  "Body": "body.png",
  "Body Care": "bodycare.png",
  "Books and Things to Read": "booksnthings.png",
  "Business English": "business-english.png",
  "Buildings": "buildings.png",
  "Calendar": "calendar.png",
  "Cars": "cars.png",
  "Celebrations": "celebrations.png",
  "City": "city.png",
  "Clothes": "clothes.png",
  "Colors": "colors.png",
  "Computers": "computers.png",
  "Countries": "countries.png",
  "Food": "eating.png",
  "English Words from Other Languages": "english-from-other.png",
  "Family": "family.png",
  "Gardening and Plants": "gardening.png",
  "Geography": "geography.png",
  "Grammar & English Usage": "grammar.png",
  "Health": "health.png",
  "Holidays": "holidays.png",
  "House": "house.png",
  "Jobs, Occupations and Professions": "jobs.png",
  "Law": "law.png",
  "Math": "math.png",
  "Miscellaneous": "miscellaneous.png",
  "Money": "money.png",
  "Music": "music.png",
  "Office": "office.png",
  "Parts": "parts.png",
  "People": "people.png",
  "Perhaps Not So Useful": "perhaps-not.png",
  "Pronunciation": "pronunciation.png",
  "School": "school.png",
  "Science": "science.png",
  "Seasons": "seasons.png",
  "Security": "security.png",
  "Sports": "sports.png",
  "Time": "time.png",
  "Tools": "tools.png",
  "Transportation": "transportation.png",
  "Travel": "travel.png",
  "Weather": "weather.png",
  "Word Ending": "word-ending.png",
};