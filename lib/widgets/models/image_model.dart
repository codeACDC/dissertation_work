class  ImageModel {
  final String url;
  final int index;
  bool isTap;

  ImageModel({
    required this.url,
    required this.index,
    this.isTap = false,
});
}