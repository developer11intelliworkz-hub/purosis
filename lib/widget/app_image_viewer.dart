import 'package:flutter/material.dart';
import 'package:purosis/widget/app_image_view.dart';

class AppImageViewer extends StatefulWidget {
  final List<String> imageUrls;
  final String? title;
  final int initialIndex;

  const AppImageViewer({
    super.key,
    required this.imageUrls,
    this.title,
    this.initialIndex = 0,
  });

  /// Helper for single image
  factory AppImageViewer.single({
    Key? key,
    required String imageUrl,
    String? title,
  }) {
    return AppImageViewer(key: key, imageUrls: [imageUrl], title: title);
  }

  @override
  State<AppImageViewer> createState() => _AppImageViewerState();
}

class _AppImageViewerState extends State<AppImageViewer> {
  bool _showHeader = true;
  late PageController _pageController;
  int _currentIndex = 0;

  void _toggleUI() {
    setState(() {
      _showHeader = !_showHeader;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: _showHeader
          ? AppBar(
              backgroundColor: Colors.black.withOpacity(0.3),
              elevation: 0,
              foregroundColor: Colors.white,
              title: Text(
                widget.title ??
                    "${_currentIndex + 1}/${widget.imageUrls.length}",
              ),
            )
          : null,
      body: GestureDetector(
        onTap: _toggleUI,
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.imageUrls.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Center(
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 5,
                child: AppImageView(imageUrl: widget.imageUrls[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
