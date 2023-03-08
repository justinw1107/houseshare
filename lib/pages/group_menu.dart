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
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Group Menu",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
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
                  width: 150,
                  height: 150,
                  color: Theme.of(context).primaryColor,
                  child: const Center(
                    child: Text('Open Chat',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  nextScreen(context, KrogerShopPage());
                },
                child: Container(
                  width: 150,
                  height: 150,
                  color: Theme.of(context).primaryColor,
                  child: const Center(
                    child: Text('View Groceries',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to feature 3
                },
                child: Container(
                  width: 150,
                  height: 150,
                  color: Theme.of(context).primaryColor,
                  child: const Center(
                    child: Text('View Bills',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  // Navigate to feature 4
                },
                child: Container(
                  width: 150,
                  height: 150,
                  color: Theme.of(context).primaryColor,
                  child: const Center(
                    child: Text('View List',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
