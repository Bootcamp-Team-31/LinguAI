import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  init() {}

  void setTabIndex(int value) {
    _currentTabIndex = value;
    notifyListeners();
  }
}
