import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../models/file_item.dart';

class FileService {
  static Future<List<FileItem>> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: false,
    );
    if (result == null) return [];
    final paths = result.paths.whereType<String>().toList();
    final items = <FileItem>[];
    for (final p in paths) {
      try {
        final f = File(p);
        if (await f.exists()) {
          items.add(FileItem.fromFile(f));
        }
      } catch (_) {}
    }
    return items;
  }
}
