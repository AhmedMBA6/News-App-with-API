import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:third_project/models/slider_model.dart';

class SliderData {
  List<SliderModel> sliders = [];

  Future<void> getSliders() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=eefe486587f34bea8afa9056cf6a8695";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          SliderModel sliderModel = SliderModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          sliders.add(sliderModel);
        }
      });
    }
  }
}
