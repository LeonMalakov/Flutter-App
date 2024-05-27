import 'package:elementary/elementary.dart';

class RGBModel extends ElementaryModel {
  static const int STEP = 16;

  int _r = 0;
  int _g = 0;
  int _b = 0;

  int get r => _r;
  int get g => _g;
  int get b => _b;

  void addR() {
    _r = (_r + STEP) % 256;
  }

  void addG() {
    _g = (_g + STEP) % 256;
  }

  void addB() {
    _b = (_b + STEP) % 256;
  }
}