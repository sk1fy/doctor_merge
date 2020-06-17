import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SDProvider<T> extends ChangeNotifier{
  List<T> _data = [];
  bool _isLoading = false;
  bool _isEnd = false;

  SDProvider({this.gen, this.batchSize = 10, this.length = 100});
  List<T> get data => _data;
  bool get isLoading => _isLoading;
  bool get isEnd => _isEnd;

  bool _disposed = false;

  final T Function() gen;
  final int length;
  final int batchSize;

  @override
  void next() {
    if (_isEnd) return;
    _isLoading = true;
    super.notifyListeners();
    Future.delayed(Duration(milliseconds: 150), () {
      data.addAll(List<T>.filled(batchSize, null).map((_) => gen()));
      _isEnd = data.length > length;
      _isLoading = false;
      super.notifyListeners();
    });
  }

  void notifyListeners() {
    super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future refresh() async {
    _data = [];
    _isLoading = false;
    _isEnd = false;
  }
}
