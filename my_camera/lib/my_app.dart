import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image/image_list.dart';
import 'my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Camera',
      home: BlocProvider<ImageList>(
        create: (_) => ImageList(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
