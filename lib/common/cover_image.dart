import 'dart:io';

import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  final String? image;
  const CoverImage(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return image != null ? Image.file(File(image!)) : const Placeholder();
  }
}
