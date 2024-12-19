// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:third_project/models/article_model.dart';
import 'package:third_project/models/category_model.dart';
import 'package:third_project/models/slider_model.dart';
import 'package:third_project/pages/all_news.dart';
import 'package:third_project/pages/article_view.dart';
import 'package:third_project/pages/category_news.dart';
import 'package:third_project/services/data.dart';
import 'package:third_project/services/news.dart';
import 'package:third_project/services/slider_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  int activeIndex = 0;
  bool _loading = true;

  @override
  void initState() {
    getNews();
    categories = getCategories();
    //sliders = getSliders();
    getSliders();
    super.initState();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  getSliders() async {
    SliderData sliderClass = SliderData();
    await sliderClass.getSliders();
    sliders = sliderClass.sliders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("API"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _loading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: 70,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              image: categories[index].image,
                              categoryName: categories[index].categoryName,
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Breaking News!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AllNews(news: "Breaking")));
                            },
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CarouselSlider.builder(
                        itemCount: sliders.length,
                        itemBuilder: (context, index, realIndex) {
                          String? res = sliders[index].urlToImage;
                          String? res1 = sliders[index].title;
                          return buildImage(res, index, res1);
                        },
                        options: CarouselOptions(
                          height: 250,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          },
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    buildIndicator(),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Trending News!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AllNews(news: "Trending")));
                            },
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return BlogTile(
                              url: articles[index].url,
                              description: articles[index].description,
                              title: articles[index].title,
                              imageUrl: articles[index].urlToImage);
                        })
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: 250,
                  imageUrl: image,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                )),
            Container(
              height: 250,
              padding: const EdgeInsets.only(left: 10),
              margin: const EdgeInsets.only(top: 160.0),
              width: MediaQuery.of(context).size.width ,
              decoration: const BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Text(
                name,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: sliders.length,
        effect: const SlideEffect(
            dotHeight: 15, dotWidth: 15, dotColor: Colors.blue),
      );
}

class CategoryTile extends StatelessWidget {
  final String? image, categoryName;
  const CategoryTile({super.key, this.image, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      name: categoryName!,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image!,
                width: 120,
                height: 70,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(6)),
              child: Center(
                child: Text(
                  categoryName!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, url;
  const BlogTile({
    super.key,
    required this.description,
    required this.title,
    required this.imageUrl,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 3.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Text(
                        maxLines: 2,
                        title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Text(
                        maxLines: 4,
                        description,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
