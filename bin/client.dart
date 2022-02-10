import 'dart:io';
import 'dart:math';
import 'package:grpc/grpc.dart';
import 'package:dart_grpc_server/dart_grpc_server.dart';

class Client {
  ClientChannel? channel;
  GroceriesServiceClient? stub;
  var response;
  bool executionInProgress = true;

  Future<void> main() async {
    channel = ClientChannel('localhost',
        port: 50000,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));

    stub = GroceriesServiceClient(channel!,
        options: CallOptions(timeout: Duration(seconds: 30)));

    while (executionInProgress) {
      try {
        print('----Welcome to our store----');
        print('---What do you want to do---');
        print('1: View all products');
        print('2: Add new products');
        print('3: Edit products');
        print('4: Get product');
        print('5: Delete products');
        print('6: View all categories');
        print('7: add new category');
        print('8: Edit Category');
        print('9: Get category');
        print('10: Delete category');
        print('11: Get all Products of given category');

        var option = int.parse(stdin.readLineSync()!);

        switch (option) {
          case 1:
            response = await stub!.getAllItems(Empty());
            print('-- Store Products --');
            response.items.forEach((item) {
              print(
                  '--: ${item.name} | (id: ${item.id} | categoryId: ${item.categoryId})}');
            });
            break;
          case 2:
            print('Enter product name');
            var name = stdin.readLineSync()!;
            var item = await _findItemByName(name);
            if (item.id != 0) {
              print('-x product already exists ${item.name} | id: ${item.id}');
            } else {
              print("Enter product's category name");
              var categoryName = stdin.readLineSync()!;
              var category = await _findCategoryByName(categoryName);
              if (category.id == 0) {
                print(
                    '-x category $categoryName does not exist, try creating it forst');
              } else {
                item = Item()
                  ..name = name
                  ..id = _randomId()
                  ..categoryId = category.id;
                response = await stub!.createItem(item);
                print(
                    '-- Product created | name ${response.name} | id ${response.id} | categoryId ${response.categoryId}');
              }
            }
            break;
          case 3:
            print('Enter product name');

            break;
          case 4:
            print('Enter product name');
            var name = stdin.readLineSync()!;
            var item = await _findItemByName(name);
            if (item.id != 0) {
              print(
                  '-- product found | name ${item.name} | id ${item.id} | category Id ${item.categoryId}');
            } else {
              print('-x product not found | no product matches the name $name');
            }
            break;
          case 5:
            break;
          case 6:
            response = await stub!.getAllCategories(Empty());
            print("--- Store product categories ---");
            response.categories.forEach((category) {
              print('--: ${category.name} (id: ${category.id})');
            });
            break;
          case 7:
            print('Enter category name: ');
            var name = stdin.readLineSync()!;
            var category = await _findCategoryByName(name);
            if (category.id != 0) {
              print(
                  'category already exists: category ${category.name}(id: ${category.id})');
            } else {
              category = Category()
                ..id = Random(999).nextInt(9999)
                ..name = name;
              response = await stub!.createCategory(category);
              print(
                  'category created: name ${category.name} (id: ${category.id} )');
            }
            break;
          case 8:
            print('Enter Category name');
            var name = stdin.readLineSync()!;
            var category = await _findCategoryByName(name);
            if (category.id != 0) {
              print('Enter new category name');
              name = stdin.readLineSync()!;
              response = await stub!
                  .editCategory(Category(id: category.id, name: name));
              if (response.name == name) {
                print(
                    "-- category updated | name ${response.name} | id: ${response.id}");
              } else {
                print('-x category update failed');
              }
            } else {
              print('-x category $name not found, try creating it!');
            }
            break;
          case 9:
            print('Enter category name');
            var name = stdin.readLineSync()!;
            var category = await _findCategoryByName(name);
            if (category.id != 0) {
              print(
                  '-- category found | name: ${category.name} | id: ${category.id}');
            } else {
              print(
                  '-x category not found| no category matches the name $name');
            }

            break;
          case 10:
            print('Enter category name');
            var name = stdin.readLineSync()!;
            var category = await _findCategoryByName(name);
            if (category.id != 0) {
              await stub!.deleteCategory(category);
              print('-- category deleted');
            } else {
              print('category $name not found');
            }
            break;
          case 11:
            break;
          default:
            print('invalid option');
        }
      } catch (e) {
        print(e);
      }

      print('Do you wish to exit the store? (Y/n)');
      var result = stdin.readLineSync() ?? 'y';
      executionInProgress = result.toLowerCase() != 'y';
    }

    await channel!.shutdown();
  }

  Future<Category> _findCategoryByName(String name) async {
    var category = Category()..name = name;
    category = await stub!.getCategory(category);
    return category;
  }

  Future<Item> _findItemByName(String name) async {
    var item = Item()..name = name;
    item = await stub!.getItem(item);
    return item;
  }

  int _randomId() => Random(1000).nextInt(9999);
}

void main() {
  var client = Client();
  client.main();
}
