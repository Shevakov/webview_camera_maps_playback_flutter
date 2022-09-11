class ImagesRepository {
  late List<String> _images;

  ImagesRepository() {
    _images = [];
  }

  ImagesRepository add(String image) {
    _images.add(image);
    return this;
  }

  List<String> get images => _images;
}
