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
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Category? getCategoryById(int id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }

  @override
  Category? getCategoryByName(String name) {
    // TODO: implement getCategoryByName
    throw UnimplementedError();
  }
}
