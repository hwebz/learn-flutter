import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  // var _isLoading = true;
  late Future<List<GroceryItem>> _loadedItems;
  String? _error;

  @override
  void initState() {
    super.initState();

    // _loadItems();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    // try {
    final url = Uri.https(
        'shoppinglistflutter-70bb4-default-rtdb.asia-southeast1.firebasedatabase.app',
        'shopping_list.json');
    final response = await http.get(url);
    await Future.delayed(const Duration(seconds: 3));

    if (json.decode(response.body) == null) {
      // setState(() {
      //   _isLoading = false;
      // });
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;

      loadItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category));
    }

    return loadItems;

    //   setState(() {
    //     _groceryItems = _loadedItems;
    //   });
    // } catch (e) {
    //   setState(() {
    //     _error = e.toString().contains('Handshake')
    //         ? 'Failed to fetch data. Please try again later.'
    //         : e.toString();
    //     ;
    //   });
    // } finally {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
  }

  void _addItem() async {
    // final newItem = await Navigator.of(context).push<GroceryItem>(
    //     MaterialPageRoute(builder: (ctx) => const NewItem()));

    // print(newItem);
    // if (newItem == null) {
    //   return;
    // }

    // setState(() {
    //   _groceryItems.add(newItem);
    // });

    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItem()));

    // Using local state instead fetching data again from server
    // after new item added
    // _loadItems();

    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);

      // TODO: Shouldn't use FutureBuilder in this case because
      // it will fetch data again from server after new item added
      // Should revert back to use old way
      _loadedItems = _loadItems();
    });
  }

  void _removeItem(GroceryItem item) async {
    try {
      final url = Uri.https(
          'shoppinglistflutter-70bb4-default-rtdb.asia-southeast1.firebasedatabase.app',
          'shopping_list/${item.id}.json');
      await http.delete(url);

      setState(() {
        _groceryItems.remove(item);
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Failed to delete item. Please try again later.'),
            duration: Duration(seconds: 3)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget content = const Center(child: const Text('No items added yet.'));

    // if (_isLoading) {
    //   content = const Center(child: CircularProgressIndicator());
    // }

    // if (_error != null) {
    //   content = Center(child: Text(_error!));
    // }

    // if (_groceryItems.isNotEmpty) {
    //   content = ListView.builder(
    //       itemCount: _groceryItems.length,
    //       itemBuilder: (ctx, index) => Dismissible(
    //             key: UniqueKey(),
    //             onDismissed: (direction) {
    //               _removeItem(_groceryItems[index]);
    //             },
    //             child: ListTile(
    //               title: Text(_groceryItems[index].name),
    //               leading: Container(
    //                   width: 24,
    //                   height: 24,
    //                   color: _groceryItems[index].category.color),
    //               trailing: Text(_groceryItems[index].quantity.toString()),
    //             ),
    //           ));
    // }
    return Scaffold(
        appBar: AppBar(title: const Text("Grocery List"), actions: [
          IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
        ]),
        body: FutureBuilder(
            future: _loadedItems,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(
                    child:
                        Text('Failed to fetch data. Please try again later.'));
                // You can use snapshot.error.toString() to get more details
              }

              if (snapshot.data!.isEmpty) {
                return const Center(child: Text('No items added yet.'));
              }

              final groceryList = snapshot.data!;
              return ListView.builder(
                  itemCount: groceryList.length,
                  itemBuilder: (ctx, index) => Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          _removeItem(groceryList[index]);
                        },
                        child: ListTile(
                          title: Text(groceryList[index].name),
                          leading: Container(
                              width: 24,
                              height: 24,
                              color: groceryList[index].category.color),
                          trailing:
                              Text(groceryList[index].quantity.toString()),
                        ),
                      ));
            }));
  }
}
