import 'package:flutter/material.dart';

class Gradients {
  static LinearGradient pinkGradient = LinearGradient(
    colors: [
      Colors.pink[300],
      Colors.pink[400],
      Colors.pink[500],
      Colors.pink[600],
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static LinearGradient blueGradient = LinearGradient(
    colors: [
      Colors.blue[300],
      Colors.blue[400],
      Colors.blue[500],
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static LinearGradient greenGradient = LinearGradient(
    colors: [
      Colors.green[300],
      Colors.green[400],
      Colors.green[500],
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static LinearGradient purpleGradient = LinearGradient(
    colors: [
      Colors.purple[300],
      Colors.purple[400],
      Colors.purple[500],
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static LinearGradient orangeGradient = LinearGradient(
    colors: [
      Colors.deepOrange[300],
      Colors.deepOrange[400],
      Colors.deepOrange[500],
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
