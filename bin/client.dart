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
