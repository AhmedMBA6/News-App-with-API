import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:third_project/models/show_category_model.dart';
import 'package:third_project/pages/article_view.dart';
import 'package:third_project/services/show_category_news.dart';

class CategoryNews extends StatefulWidget {
  final String name;
  const CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  getCategories() async {
    ShowCategoryNews categoriesClass = ShowCategoryNews();
    await categoriesClass.getCategories(widget.name.toLowerCase());
    categories = categoriesClass.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            widget.name,
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
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ShowCategory(
                    description: categories[index].description,
                    title: categories[index].title,
                    image: categories[index].urlToImage,
                    url: categories[index].url,);
              }),
        ));
  }
}

class ShowCategory extends StatelessWidget {
  final String image, description, title, url;
  const ShowCategory(
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
