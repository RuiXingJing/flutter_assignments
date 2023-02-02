import 'package:flutter/material.dart';

import '../../constants.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<StatefulWidget> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.pageTitleContactList),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu));
          },
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _drawerHeader(),
            _drawerItem(Icons.person, Strings.drawerItemContactsList),
            _drawerItem(Icons.favorite, Strings.drawerItemFavoriteList),
            _drawerItem(Icons.add, Strings.drawerItemAdd),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  _drawerItem(icon, String label) {
    return Builder(builder: (BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
              onPressed: () {
                Scaffold.of(context).closeDrawer();
              },
              icon: Icon(icon),
              label: Text(
                label,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              )),
          const Padding(
            padding: EdgeInsets.fromLTRB(
                Paddings.padding10, 0, Paddings.padding10, 0),
            child: Divider(
              height: 2,
              color: Colors.grey,
            ),
          )
        ],
      );
    });
  }

  _drawerHeader() {
    return Container(
        width: double.infinity,
        height: 120,
        color: Theme.of(context).primaryColor,
        child: Builder(builder: (BuildContext context) {
          return IconButton(
              alignment: Alignment.centerLeft,
              iconSize: 35,
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).closeDrawer();
              },
              icon: const Icon(Icons.arrow_back));
        }));
  }
}
