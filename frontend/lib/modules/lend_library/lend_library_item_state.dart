import 'package:flutter/material.dart';

import './lend_library_item_class.dart';

class LendLibraryItemState extends ChangeNotifier {
  var _lendLibraryItem = null;

  get lendLibraryItem => _lendLibraryItem;

  void setLendLibraryItem(LendLibraryItemClass lendLibraryItem) {
    _lendLibraryItem = lendLibraryItem;
    notifyListeners();
  }

  void clearLendLibraryItem() {
    _lendLibraryItem = null;
    notifyListeners();
  }
}
