import 'package:dart_grpc_server/dart_grpc_server.dart';

class CategoryServices implements ICategoriesServices {
  @override
  Category? createCategory(Category category) {
    categories.add({'id': category.id, 'name': category.name});
    return category;
  }

  @override
  Empty? deleteCategory(Category category) {
    categories.removeWhere((element) => element['id'] == category.id);
    return Empty();
  }

  @override
  Category? editcategory(Category category) {
    try {
      var categoryIndex =
          categories.indexWhere((element) => element['id'] == category.id);
      categories[categoryIndex]['name'] = category.name;
    } catch (e) {
      print('-x Error:: $e');
    }
    return category;
  }

  @override
  List<Category>? getCategories() {
    return categories
        .map((category) => helper.getCategoryFromMap(category))
        .toList();
  }

  @override
  Category? getCategoryById(int id) {
    var category = Category();
    var result = categories.where((element) => element['id'] == id).toList();
    if (result.isNotEmpty) {
      category = helper.getCategoryFromMap(result.first);
    }
    return category;
  }

  @override
  Category? getCategoryByName(String name) {
    var category = Category();
    var result =
        categories.where((element) => element['name'] == name).toList();
    if (result.isNotEmpty) {
      category = helper.getCategoryFromMap(result.first);
    }
    return category;
  }
}
