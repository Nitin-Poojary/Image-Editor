import 'package:flutter/material.dart';
import 'package:imageeditor/utils/filters.dart';

class FilterProvider extends ChangeNotifier {
  List<double> filterMatrix = nofilter;

  setFilter(List<double> filter) {
    filterMatrix = filter;
    notifyListeners();
  }

  get getFilter {
    return filterMatrix;
  }

  removeFilter() {
    filterMatrix = nofilter;
  }
}
