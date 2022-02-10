import 'package:dart_grpc_server/dart_grpc_server.dart';

abstract class IItemsServices {
  factory IItemsServices() => ItemServices();

  Item? getItemByName(String name) {}
  Item? getItemById(int id) {}

  Item? createItem(Item item) {}
  Item? editItem(Item item) {}
  Empty? deleteItem(Item item) {}
  List<Item>? getItems() {}
  List<Item>? getItemsbyCategory() {}
}

final itemServices = ItemServices();
