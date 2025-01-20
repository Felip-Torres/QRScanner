import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  int get SelectedMenuOpt{
    return _selectedMenuOpt;
  }

  set SelectedMenuOpt(int index){
    _selectedMenuOpt = index;
    notifyListeners();
  }
}