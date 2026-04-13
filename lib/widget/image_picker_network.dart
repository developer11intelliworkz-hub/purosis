import 'dart:io';

import 'package:flutter/material.dart';

import '../feature/admin/product/model/image_item.dart';

class ImagePickerNetwork extends StatelessWidget {
  final List<ImageItem> images;
  final VoidCallback onAdd;
  final Function(int index) onRemove;
  final int maxImages;

  const ImagePickerNetwork({
    super.key,
    required this.images,
    required this.onAdd,
    required this.onRemove,
    this.maxImages = 6,
  });

  @override
  Widget build(BuildContext context) {
    final showAddButton = images.length < maxImages;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: showAddButton ? images.length + 1 : images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        if (showAddButton && index == images.length) {
          return GestureDetector(
            onTap: onAdd,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add, size: 30),
            ),
          );
        }

        final item = images[index];

        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: item.isNetwork
                  ? Image.network(
                      item.url!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : Image.file(
                      File(item.file!.path!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () => onRemove(index),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
