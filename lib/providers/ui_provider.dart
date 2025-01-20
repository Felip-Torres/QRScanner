import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  int get SelectedMenuOpt{
    return this._selectedMenuOpt;
  }

  set SelectedMenuOpt(int index){
    this._selectedMenuOpt = index;
    notifyListeners();
  }
}