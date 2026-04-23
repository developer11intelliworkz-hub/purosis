import 'package:flutter/material.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AppPdfViewer extends StatelessWidget {
  final String url;
  final String? header;

  const AppPdfViewer({super.key, required this.url, this.header});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: header ?? "PDF View"),
      body: SfPdfViewer.network(url),
    );
  }
}
