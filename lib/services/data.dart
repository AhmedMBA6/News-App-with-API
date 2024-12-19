import 'package:third_project/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = CategoryModel();

  categoryModel.categoryName = "Business";
  categoryModel.image = "assets/images/business-news.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Entertainment";
  categoryModel.image = "assets/images/entertainment-news.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "General";
  categoryModel.image = "assets/images/general_news.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Health";
  categoryModel.image = "assets/images/health_news.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Sports";
  categoryModel.image = "assets/images/sport_news.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  return category;
}
