import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/file_provider.dart';
import '../services/file_service.dart';
import '../widgets/file_tile.dart';
import '../models/file_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Helper function to determine the appropriate icon for a file
  IconData _getIconForItem(FileItem item) {
    // Assuming FileItem has a name property with an extension
    final lowerName = item.name.toLowerCase();
    if (lowerName.endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (lowerName.endsWith('.png') ||
        lowerName.endsWith('.jpg') ||
        lowerName.endsWith('.jpeg')) {
      return Icons.image;
    } else if (lowerName.endsWith('.doc') || lowerName.endsWith('.docx')) {
      return Icons.description;
    } else if (lowerName.endsWith('.zip') || lowerName.endsWith('.rar')) {
      return Icons.folder_zip;
    }
    return Icons.insert_drive_file;
  }

  @override
  Widget build(BuildContext context) {
    // We listen here because the entire widget needs to rebuild when files or view mode changes
    final provider = Provider.of<FileProvider>(context);
    final files = provider.filteredFiles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart File Manager'),
        actions: [
          IconButton(
            // Toggles between list view (Icon 1) and grid view (Icon 2)
            icon: Icon(provider.gridView ? Icons.view_list : Icons.grid_view),
            onPressed: () => provider.toggleView(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search files...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
              onChanged: provider.setQuery,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: files.isEmpty
                ? const Center(
                    child: Text(
                      'No files found. Try picking some!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                // Use a ternary operator to switch between GridView and ListView
                : provider.gridView
                    ? GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              1.0, // Changed aspect ratio for a better visual fit
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: files.length,
                        itemBuilder: (ctx, i) {
                          final file = files[i];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(_getIconForItem(file),
                                        size: 48,
                                        color: Theme.of(context).primaryColor),
                                    const SizedBox(height: 8),
                                    Text(
                                      file.name,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (ctx, i) => FileTile(item: files[i]),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final picked = await FileService.pickFiles();
          if (picked.isNotEmpty) {
            // BEST PRACTICE: Use listen: false when calling a provider method that doesn't need a rebuild
            // ignore: use_build_context_synchronously
            Provider.of<FileProvider>(context, listen: false).addFiles(picked);
          }
        },
        label: const Text('Pick Files'),
        icon: const Icon(Icons.upload_file),
      ),
    );
  }
}
