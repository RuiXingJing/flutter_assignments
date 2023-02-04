import 'package:flutter_assignments/data/db/db_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/model/contact.dart';

class ContactsHelper {
  final DatabaseProvider databaseProvider = DatabaseProvider();

  final PublishSubject<List<Contact>> _contactsFetcher =
      PublishSubject<List<Contact>>();
  final PublishSubject<List<Contact>> _favoriteContactFetcher =
      PublishSubject<List<Contact>>();

  Stream<List<Contact>> get allContacts => _contactsFetcher.stream;

  Stream<List<Contact>> get favoriteContacts => _favoriteContactFetcher.stream;

  ContactsHelper() {
    getAllContacts();
  }

  getAllContacts() async {
    List<Contact> result = await databaseProvider.contactTable.queryAll();
    _contactsFetcher.sink.add(result);
  }

  getFavoriteContacts() async {
    List<Contact> result =
        await databaseProvider.contactTable.queryAll(isFavorite: true);
    _favoriteContactFetcher.sink.add(result);
  }

  addContact(Map<String, dynamic> dataMap) async {
    await databaseProvider.contactTable.insertData(dataMap);
    getAllContacts();
    getFavoriteContacts();
  }

  updateContact(Map<String, dynamic> dataMap) async {
    await databaseProvider.contactTable.updateData(dataMap);
    getAllContacts();
    getFavoriteContacts();
  }

  deleteContact(int id) async {
    await databaseProvider.contactTable.deleteData(id);
    getAllContacts();
    getFavoriteContacts();
  }
}

final contactHelper = ContactsHelper();
