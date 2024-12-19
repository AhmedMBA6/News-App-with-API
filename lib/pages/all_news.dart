import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:third_project/models/article_model.dart';
import 'package:third_project/models/slider_model.dart';
import 'package:third_project/pages/article_view.dart';
import 'package:third_project/services/news.dart';
import 'package:third_project/services/slider_data.dart';

class AllNews extends StatefulWidget {
  final String news;
  const AllNews({super.key, required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];

  @override
  void initState() {
    getNews();
    getSliders();
    super.initState();
  }

   getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {

    });
  }

  getSliders() async {
    SliderData sliderClass = SliderData();
    await sliderClass.getSliders();
    sliders = sliderClass.sliders;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            "${widget.news}News",
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.news == "Breaking" ? sliders.length : articles.length,
              itemBuilder: (context, index) {
                return AllNewsSection(
                    description: widget.news == "Breaking" ? sliders[index].description : articles[index].description,
                    title: widget.news == "Breaking" ? sliders[index].title : articles[index].title,
                    image: widget.news == "Breaking" ? sliders[index].urlToImage : articles[index].urlToImage,
                    url: widget.news == "Breaking" ? sliders[index].url : articles[index].url);
              }),
        ),
    );
  }
}


class AllNewsSection extends StatelessWidget {
  final String image, description, title, url;
  const AllNewsSection(
      {super.key,
      required this.title,
      required this.image,
      required this.description,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              maxLines: 3,
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
