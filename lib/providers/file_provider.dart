import 'package:flutter/foundation.dart';
import '../models/file_item.dart';

class FileProvider with ChangeNotifier {
  List<FileItem> _files = [];
  bool _gridView = false;
  FileCategory? _filter;
  String _query = '';

  List<FileItem> get files => List.unmodifiable(_files);
  bool get gridView => _gridView;

  void setFiles(List<FileItem> files) {
    _files = files;
    notifyListeners();
  }

  void addFiles(List<FileItem> files) {
    _files.addAll(files);
    notifyListeners();
  }

  void toggleView() {
    _gridView = !_gridView;
    notifyListeners();
  }

  void setFilter(FileCategory? category) {
    _filter = category;
    notifyListeners();
  }

  void setQuery(String q) {
    _query = q;
    notifyListeners();
  }

  List<FileItem> get filteredFiles {
    var list = _files;
    if (_filter != null) {
      list = list.where((f) => f.category == _filter).toList();
    }
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((f) => f.name.toLowerCase().contains(q)).toList();
    }
    return list;
  }
}
