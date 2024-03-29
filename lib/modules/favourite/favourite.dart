import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../style/icon_broken.dart';

enum Actions { share, delete, archive }

class FavouuritePage extends StatefulWidget {
  const FavouuritePage({Key? key}) : super(key: key);

  @override
  _FavouuritePageState createState() => _FavouuritePageState();
}

class _FavouuritePageState extends State<FavouuritePage> {
  final List<Map<String, dynamic>> _items = List.generate(
      50,
      (index) => {
            "id": index,
            "title": "question $index",
            "content":
                "This is the answers of question $index. It is very long and you have to expand the tile to see it."
          });

  void _removeItem(int id, String text) {
    setState(() {
      _items.removeWhere((element) => element['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 1500),
        content: Text('Item with id #$id has been $text')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(IconBroken.Arrow___Left)),
        ),
        body: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (_, index) {
              final item = _items[index];
              return Slidable(
                key: Key(item["title"]),
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  dismissible: DismissiblePane(
                    onDismissed: () => _removeItem(index, 'reanswered'),
                  ),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.blue,
                      icon: IconBroken.Download,
                      label: 'reanswer',
                      onPressed: (_) {},
                    ),
                    SlidableAction(
                      backgroundColor: Colors.green,
                      icon: IconBroken.Search,
                      label: 'Share',
                      onPressed: (context) => _removeItem(index, 'shared'),
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  dismissible: DismissiblePane(
                    onDismissed: () => _removeItem(index, ''),
                  ),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.red,
                      icon: IconBroken.Delete,
                      label: 'Delete',
                      onPressed: (context) => _removeItem(index, 'deleted'),
                    )
                  ],
                ),
                child: Card(
                  key: PageStorageKey(item['id']),
                  color: Colors.white,
                  elevation: 4,
                  child: ExpansionTile(
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      childrenPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      expandedCrossAxisAlignment: CrossAxisAlignment.end,
                      title: Text(
                        item['title'],
                        style: const TextStyle(color: Colors.black),
                      ),
                      children: [
                        Text(item['content'],
                            style: const TextStyle(color: Colors.black)),
                      ]),
                ),
              );
            }));
  }
}
