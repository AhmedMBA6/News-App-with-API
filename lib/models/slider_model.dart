// ignore_for_file: public_member_api_docs, sort_constructors_first
class SliderModel {
  String? author;
  String title;
  String description;
  String url;
  String urlToImage;
  String? content;
  SliderModel({
     this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
     this.content,
  });
}
