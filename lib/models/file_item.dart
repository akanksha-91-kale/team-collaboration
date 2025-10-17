import 'dart:io';

enum FileCategory { image, video, document, other }

class FileItem {
  final String path;
  final String name;
  final int size;
  final DateTime modified;
  final FileCategory category;

  FileItem({
    required this.path,
    required this.name,
    required this.size,
    required this.modified,
    required this.category,
  });

  factory FileItem.fromFile(File file) {
    final ext = file.path.split('.').last.toLowerCase();
    FileCategory cat = FileCategory.other;
    if (['png', 'jpg', 'jpeg', 'gif', 'webp', 'bmp'].contains(ext)) {
      cat = FileCategory.image;
    } else if (['mp4', 'mov', 'mkv', 'avi', 'webm'].contains(ext))
      // ignore: curly_braces_in_flow_control_structures
      cat = FileCategory.video;
    else if ([
      'pdf',
      'doc',
      'docx',
      'txt',
      'ppt',
      'pptx',
      'xls',
      'xlsx',
      'csv',
      'json',
    ].contains(ext))
      // ignore: curly_braces_in_flow_control_structures
      cat = FileCategory.document;

    return FileItem(
      path: file.path,
      name: file.uri.pathSegments.last,
      size: file.lengthSync(),
      modified: file.lastModifiedSync(),
      category: cat,
    );
  }
}
