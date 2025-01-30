import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class XImageView extends StatelessWidget {
  final XFile? imageFile;
  final double height;
  final double width;
  final ConnectionState? state;

  final VoidCallback onPressed;

  const XImageView({
    super.key,
    required this.imageFile,
    required this.onPressed,
    this.height = 320.0,
    this.width = 320.0,
    this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state != null) {
      switch (state!) {
        case ConnectionState.waiting:
          return Card(
            child: SizedBox(
                height: height,
                width: width,
                child: CircularProgressIndicator()),
          );
        case ConnectionState.none:
          return Card(
            child: InkWell(
              child: SizedBox(
                  height: height,
                  width: width,
                  child: Text(
                    'Select an image',
                    textAlign: TextAlign.center,
                  )),
            ),
          );
        case ConnectionState.done:
          return Card(
            child: InkWell(
              onTap: onPressed,
              child: SizedBox(
                height: height,
                width: width,
                child: imageFile == null
                    ? Center(
                        child: Text(
                          'Select an image',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : kIsWeb
                        ? Image.network(imageFile!.path)
                        : Image.file(File(imageFile!.path)),
              ),
            ),
          );
        default:
          return Card(
              child: InkWell(
            onTap: onPressed,
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                  child: Text(
                'Select an image',
                textAlign: TextAlign.center,
              )),
            ),
          ));
      }
    }
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: height,
          width: width,
          child: imageFile == null
              ? Center(
                  child: Text(
                    'Select an image',
                    textAlign: TextAlign.center,
                  ),
                )
              : kIsWeb
                  ? Image.network(imageFile!.path)
                  : Image.file(File(imageFile!.path)),
        ),
      ),
    );
  }
}
