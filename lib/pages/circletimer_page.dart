import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:esl_words/data/models.dart';
import 'package:esl_words/data/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

// import 'dart:math' as math;

const double PI = 3.1415926535897932;

Future<bool> getIsRandomPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isRandom = prefs.getBool("isRandom");
  return isRandom;
}

class TimerCirclePage extends StatefulWidget {
  final List<String> subcategory;
  final String category;
  final bool isRandom;
  TimerCirclePage({this.category, this.subcategory, this.isRandom});
  @override
  _TimerCircleState createState() => _TimerCircleState();
}

class _TimerCircleState extends State<TimerCirclePage>
    with TickerProviderStateMixin {
  AnimationController controller;
  List _subcategoryWords;
  String _currentWord;
  bool _isRandom = false;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void initWords() {
    if (_isRandom) {
      print("the thing is random");
      // _subcategoryWords = globals.model.getRandomSubcategoryWords(widget.category, widget.subcategory);
      _subcategoryWords = globals.model
          .getAllSubcategoryWords(widget.category, widget.subcategory);
      _subcategoryWords.shuffle();
    } else {
      print("the thing is NOT random");
      // _subcategoryWords = globals.model.getSubcategoryWords(widget.category, widget.subcategory);
      _subcategoryWords = globals.model
          .getAllSubcategoryWords(widget.category, widget.subcategory);
    }
  }

  void resetWords() {
    if (_subcategoryWords.isNotEmpty) {
      setState(() {
        _currentWord = _subcategoryWords.last;
      });
      _subcategoryWords.removeLast();
      print(_currentWord);
      print(_subcategoryWords);
      resetController();
    } else {
      gotoResultsPage();
    }
  }

  Future resetController() async {
    await new Future.delayed(new Duration(milliseconds: 50));
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
  }

  void gotoResultsPage() {
    Navigator.pop(context);
    // print('navigate');
    // var route = new MaterialPageRoute(
    //   builder: (BuildContext context) =>
    //   new SubcategoryPage(category: widget.category)
    // );

    // Navigator.of(context).push(route);
  }

  @override
  void initState() {
    super.initState();
    getIsRandomPreference().then((bool isRandom) {
      updateIsRandom(isRandom);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        print('end of state');
      });
      initWords();
      resetWords();
      resetController();
    });

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: globals.countdownDuration),
    );

    Future.doWhile(() {
      return new Future.delayed(new Duration(milliseconds: 200), () {
        if (!controller.isAnimating) {
          print('animation done');
          // gotoResultsPage();
          // print(_subcategoryWords);
          // gotoResultsPage();
          return false;
        }
        return true;
      });
    });

    controller.addStatusListener((AnimationStatus status) {
      // print("$status");
      if (status == AnimationStatus.dismissed) {
        resetWords();

        // set the new word
      }
    });
  }

  Widget _scopedText(BuildContext context, themeData) {
    // var myTheme = Theme.of(context).copyWith(
    //   textTheme: TextTheme
    // )
    if (_currentWord != null) {
      return new ScopedModelDescendant<WordModel>(
        builder: (context, child, model) => new Text(
              _currentWord,
              style: themeData.textTheme.display2,
            ),
      );
    } else {
      return new Text('nothing here');
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return new CustomPaint(
                                painter: TimerPainter(
                              animation: controller,
                              backgroundColor: Colors.white,
                              color: themeData.indicatorColor,
                            ));
                          },
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _scopedText(context, themeData),
                            AnimatedBuilder(
                                animation: controller,
                                builder: (BuildContext context, Widget child) {
                                  return new Text(
                                    timerString,
                                    style: themeData.textTheme.display4,
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return new Icon(controller.isAnimating
                            ? Icons.pause
                            : Icons.play_arrow);
                      },
                    ),
                    onPressed: () {
                      if (controller.isAnimating)
                        controller.stop();
                      else {
                        controller.reverse(
                            from: controller.value == 0.0
                                ? 1.0
                                : controller.value);
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void updateIsRandom(bool isRandom) {
    print("loaded random ${isRandom}");
    setState(() {
      _isRandom = isRandom;
    });
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * PI;
    canvas.drawArc(Offset.zero & size, PI * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}

class Foo extends StatelessWidget {
  final String word;
  final Timer timer = new Timer(new Duration(seconds: 1), () {
    debugPrint("Print after 5 seconds");
  });
  Foo({this.word});

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return Text('data: ${snapshot.data}');
        }
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Page"),
      ),
      body: futureBuilder,
    );
  }

  Future<String> _getData() async {
    await new Future.delayed(new Duration(seconds: 5));
    return 'foo';
  }
}