import 'package:flutter/material.dart';
import 'package:flutter_assignments/contacts/add_update_contact/view/add_update_contact_page.dart';
import 'package:flutter_assignments/contacts/contact_list/contact_item_widget.dart';
import 'package:flutter_assignments/contacts/contact_list/contacts_helper.dart';
import 'package:flutter_assignments/contacts/contact_list/favorite_contacts_list_page.dart';
import 'package:flutter_assignments/data/model/Contact.dart';

import '../../constants.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    contactHelper.getAllContacts();
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
            _drawerHeader(context),
            _drawerItem(Icons.person, Strings.drawerItemContactsList),
            _drawerItem(Icons.favorite, Strings.drawerItemFavoriteList),
            _drawerItem(Icons.add, Strings.drawerItemAdd),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, AddContactPage.route());
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Contact>>(
        stream: contactHelper.allContacts,
        builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ContactItemWidget(contact: snapshot.data![index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.data == null) {
            return const Center(
              child: Text('Add your first contact'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
                if (label == Strings.drawerItemAdd) {
                  Navigator.push(context, AddContactPage.route());
                } else if (label == Strings.drawerItemFavoriteList) {
                  Navigator.push(context, FavoriteContactsPage.route());
                }
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

  _drawerHeader(BuildContext context) {
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

// class _ContactListPageState extends State<ContactListPage> {
//   List<Contact>? contacts;
//
//   @override
//   Widget build(BuildContext context) {
//     _getAllContacts();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(Strings.pageTitleContactList),
//         centerTitle: true,
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//                 icon: const Icon(Icons.menu));
//           },
//         ),
//       ),
//       drawer: Drawer(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _drawerHeader(),
//             _drawerItem(Icons.person, Strings.drawerItemContactsList),
//             _drawerItem(Icons.favorite, Strings.drawerItemFavoriteList),
//             _drawerItem(Icons.add, Strings.drawerItemAdd),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context, AddContactPage.route());
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   _drawerItem(icon, String label) {
//     return Builder(builder: (BuildContext context) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextButton.icon(
//               onPressed: () {
//                 Scaffold.of(context).closeDrawer();
//                 if (label == Strings.drawerItemAdd) {
//                   Navigator.push(context, AddContactPage.route());
//                 }
//               },
//               icon: Icon(icon),
//               label: Text(
//                 label,
//                 style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black54),
//               )),
//           const Padding(
//             padding: EdgeInsets.fromLTRB(
//                 Paddings.padding10, 0, Paddings.padding10, 0),
//             child: Divider(
//               height: 2,
//               color: Colors.grey,
//             ),
//           )
//         ],
//       );
//     });
//   }
//
//   _drawerHeader() {
//     return Container(
//         width: double.infinity,
//         height: 120,
//         color: Theme.of(context).primaryColor,
//         child: Builder(builder: (BuildContext context) {
//           return IconButton(
//               alignment: Alignment.centerLeft,
//               iconSize: 35,
//               color: Colors.white,
//               onPressed: () {
//                 Scaffold.of(context).closeDrawer();
//               },
//               icon: const Icon(Icons.arrow_back));
//         }));
//   }
//
//   void _getAllContacts() async {
//     List<Contact> result = await DatabaseProvider().contactTable.queryAll();
//     if (result.isNotEmpty) {
//       for (var item in result) {
//         print('result=${item.toMap()}');
//       }
//     } else {
//       print('db is empty');
//     }
//   }
// }
