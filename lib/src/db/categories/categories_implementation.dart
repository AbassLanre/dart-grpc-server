import 'package:dart_grpc_server/dart_grpc_server.dart';

class CategoryServices implements ICategoriesServices {
  @override
  Category? createCategory(Category category) {
    categories.add({'id': category.id, 'name': category.name});
    return category;
  }

  @override
  Empty? deleteCategory(Category category) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Category? editcategory(Category category) {
    // TODO: implement editcategory
    throw UnimplementedError();
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
