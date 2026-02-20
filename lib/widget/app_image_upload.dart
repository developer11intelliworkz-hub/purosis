import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AppImageUpload extends StatefulWidget {
  final Function(PlatformFile?) onFileSelected;
  final String title;
  final List<String>? allowedExtensions;

  const AppImageUpload({
    Key? key,
    required this.onFileSelected,
    this.title = "Upload File",
    this.allowedExtensions,
  }) : super(key: key);

  @override
  State<AppImageUpload> createState() => _AppImageUploadState();
}

class _AppImageUploadState extends State<AppImageUpload> {
  PlatformFile? selectedFile;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: widget.allowedExtensions != null
          ? FileType.custom
          : FileType.any,
      allowedExtensions: widget.allowedExtensions,
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
      });
      widget.onFileSelected(selectedFile);
    }
  }

  void removeFile() {
    setState(() {
      selectedFile = null;
    });
    widget.onFileSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: pickFile,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: selectedFile == null
                ? const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select file"),
                Icon(Icons.upload_file),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectedFile!.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: removeFile,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
