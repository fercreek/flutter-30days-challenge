import 'package:flutter/foundation.dart';

class CounterProvider with ChangeNotifier {
  int _counter = 0;
  int _submissionCount = 0;

  int get counter => _counter;
  int get submissionCount => _submissionCount;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void resetCounter() {
    _counter = 0;
    notifyListeners();
  }

  void incrementSubmissionCount() {
    _submissionCount++;
    notifyListeners();
  }

  void resetSubmissionCount() {
    _submissionCount = 0;
    notifyListeners();
  }
}
