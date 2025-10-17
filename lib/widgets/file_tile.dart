import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import '../models/file_item.dart';

class FileTile extends StatelessWidget {
  final FileItem item;
  const FileTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.insert_drive_file),
      title: Text(item.name, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${(item.size / 1024).toStringAsFixed(1)} KB • ${DateFormat.yMMMd().add_Hm().format(item.modified)}',
      ),
      trailing: IconButton(
        icon: const Icon(Icons.open_in_new),
        onPressed: () => OpenFilex.open(item.path),
      ),
    );
  }
}
