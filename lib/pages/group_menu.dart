import 'package:flutter/material.dart';
import 'package:houseshare/pages/chat_page.dart';
import 'package:houseshare/pages/kroger_shop_page.dart';
import 'package:houseshare/widgets/widgets.dart';

class GroupMenu extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupMenu(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<GroupMenu> createState() => _GroupMenuState();
}

class _GroupMenuState extends State<GroupMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                nextScreen(
                    context,
                    ChatPage(
                      groupId: widget.groupId,
                      groupName: widget.groupName,
                      userName: widget.userName,
                    ));
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: const Center(
                  child:
                      Text('Open Chat', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                nextScreen(context, KrogerShopPage());
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.green,
                child: const Center(
                  child: Text('View Groceries',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                // Navigate to feature 3
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: const Center(
                  child:
                      Text('Feature 3', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
