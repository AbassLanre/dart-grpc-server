import 'package:dart_grpc_server/dart_grpc_server.dart';
import 'package:grpc/grpc.dart';

class GroceriesService extends GroceriesServiceBase {
  @override
  Future<Category> createCategory(ServiceCall call, Category request) async =>
      categoriesServices.createCategory(request)!;

  @override
  Future<Item> createItem(ServiceCall call, Item request) async {
    return itemServices.createItem(request)!;
  }

  @override
  Future<Empty> deleteCategory(ServiceCall call, Category request) async {
    return categoriesServices.deleteCategory(request)!;
  }

  @override
  Future<Empty> deleteItem(ServiceCall call, Item request) async {
    return itemServices.deleteItem(request)!;
  }

  @override
  Future<Category> editCategory(ServiceCall call, Category request) async {
    return categoriesServices.editcategory(request)!;
  }

  @override
  Future<Item> editItem(ServiceCall call, Item request) async {
    return itemServices.editItem(request)!;
  }

  @override
  Future<Categories> getAllCategories(ServiceCall call, Empty request) async {
    return Categories()..categories.addAll(categoriesServices.getCategories()!);
  }

  @override
  Future<Items> getAllItems(ServiceCall call, Empty request) async {
    return Items()..items.addAll(itemServices.getItems()!);
  }

  @override
  Future<Category> getCategory(ServiceCall call, Category request) async {
    return categoriesServices.getCategoryByName(request.name)!;
  }

  @override
  Future<AllItemsOfCategory> getItemsByCategory(
      ServiceCall call, Category request) async {
    return AllItemsOfCategory(
        items: itemServices.getItemsbyCategory(request.id)!,
        categoryId: request.id);
  }

  @override
  Future<Item> getItem(ServiceCall call, Item request) async {
    return itemServices.getItemByName(request.name)!;
  }
}

Future<void> main() async {
  final server = Server([GroceriesService()], const <Interceptor>[],
      CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]));

  await server.serve(port: 50000);
  print('Server listening on port ${server.port}...');
}
