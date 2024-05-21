import 'package:flutter_application_1/models/abstract.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<T>> getCollection<T extends Model>(
    String collectionName,
    T Function(Map<String, dynamic>) fromDocument, {
    String? field,
    dynamic value,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection(collectionName);

      if (field != null && value != null) {
        query = query.where(field, isEqualTo: value);
      }

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
      List<T> items = querySnapshot.docs.map((doc) {
        return fromDocument(doc.data());
      }).toList();

      return items;
    } catch (e) {
      print('Error fetching collection: $e');
      return [];
    }
  }

  Future<T?> getDocument<T extends Model>(String collectionName, String field,
      String value, T Function(Map<String, dynamic>) fromDocument) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(collectionName)
          .where(field, isEqualTo: value)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs.first;
        return fromDocument(documentSnapshot.data());
      } else {
        print('Document not found');
        return null;
      }
    } catch (e) {
      print('Error getting document: $e');
      return null;
    }
  }

  Future<void> createDocument<T extends Model>(
      String collectionName, T model) async {
    try {
      await _firestore.collection(collectionName).add(model.toMap());
    } catch (e) {
      print('Error creating document: $e');
    }
  }
}
