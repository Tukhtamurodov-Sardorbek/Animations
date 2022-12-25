import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedListPage extends StatefulWidget {
  const AnimatedListPage({super.key});

  @override
  State<AnimatedListPage> createState() => _AnimatedListPageState();
}

class _AnimatedListPageState extends State<AnimatedListPage> {
  List<int> list = [0, 1, 2, 3, 4, 5];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  ListTile listTile({required int orderNumber}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: const Icon(Icons.account_circle_outlined, size: 30, color: Colors.purpleAccent,),
      title: Text('Person $orderNumber', textAlign: TextAlign.center,),
      trailing: IconButton(
        icon: const Icon(Icons.remove_circle, size: 30, color: CupertinoColors.destructiveRed,),
        onPressed: () {
          final index = list.indexOf(orderNumber);
          final number = list.removeAt(index);
          // _listKey.currentState!.removeItem(index, (context, animation) => listTile(orderNumber: number));
          _listKey.currentState!.removeItem(
            index,
            duration: const Duration(milliseconds: 800),
                (context, animation) {
              return FadeTransition(
                opacity: CurvedAnimation(parent: animation, curve: const Interval(0.5, 1.0)),
                child: SizeTransition(
                  axisAlignment: 0.0,
                  sizeFactor: CurvedAnimation(parent: animation, curve: const Interval(0.5, 1.0)),
                  child: listTile(orderNumber: number),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedList(
          key: _listKey,
          padding: EdgeInsets.zero,
          initialItemCount: list.length,
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: listTile(orderNumber: list[index]),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade600,
        onPressed: () {
          final index = list.isNotEmpty ? list.length : 0;
          final number = list.isNotEmpty ? list.last + 1 : 0;
          // * Update list
          list.add(number);
          // * Update the animatedList
          _listKey.currentState!.insertItem(index, duration: const Duration(milliseconds: 800));
        },
        child: const Icon(Icons.add, size: 30, color: Colors.purpleAccent),
      ),
    );
  }
}
