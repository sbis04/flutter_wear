import 'package:flutter/material.dart';
import 'package:flutter_wear/mode.dart';
import 'package:flutter_wear/shape.dart';
import 'package:flutter_wear/wear_mode.dart';
import 'package:flutter_wear/wear_shape.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _containerColor;
  Color _textColor;

  @override
  void initState() {
    super.initState();

    _containerColor = Colors.white;
    _textColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: WearShape(
            builder: (context, shape) => WearMode(builder: (context, mode) {
              if (mode == Mode.active) {
                _containerColor = Colors.white;
                _textColor = Colors.black;
              } else {
                _containerColor = Colors.black;
                _textColor = Colors.white;
              }
              return Container(
                color: _containerColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(),
                    FlutterLogo(size: 100),
                    Text(
                      'Shape: ${shape == Shape.round ? 'round' : 'square'}',
                      style: TextStyle(color: _textColor),
                    ),
                    Text(
                      'Mode: ${mode == Mode.active ? 'Active' : 'Ambient'}',
                      style: TextStyle(color: _textColor),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
