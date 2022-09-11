import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image/image_list.dart';
import 'repository/image_repository.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);
  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageList, ImagesRepository>(
      builder: (_, state) {
        List<String> filenames = state.images;
        return ListView.builder(
            itemCount: filenames.length,
            itemBuilder: (BuildContext context, int index) {
              final item = filenames[index];

              return SizedBox(
                height: 200,
                child: Image.file(
                  File(item),
                  fit: BoxFit.fitWidth,
                ),
              );
            });
      },
    );
  }
}
