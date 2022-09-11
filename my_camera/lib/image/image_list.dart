import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/image_repository.dart';

class ImageList extends Cubit<ImagesRepository> {
  ImageList() : super(ImagesRepository());

  void setFileName(String value) {
    emit(state.add(value));
  }
}
