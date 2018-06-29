import 'package:flutter/material.dart';



class NavigationIconView {
  NavigationIconView({
    Widget icon,
    String title,
  }) : _icon = icon,
       _title = title,
       item = new BottomNavigationBarItem(
         icon: icon,
         title: new Text(title),
       );
  

  final Widget _icon;
  final String _title;
  final BottomNavigationBarItem item;

  String get title => _title;

}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}

