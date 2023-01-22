import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '/widgets/general_alert_dialog.dart';

class FirebaseHelper {
  addOrUpdateContent(
    BuildContext context, {
    required String collectionId,
    required String whereId,
    required String whereValue,
    required Map<String, dynamic> map,
  }) async {
    try {
      GeneralAlertDialog().customLoadingDialog(context);
      final data = await getData(
        collectionId: collectionId,
        whereId: whereId,
        whereValue: whereValue,
      );
      if (data.docs.isEmpty) {
        await FirebaseFirestore.instance.collection(collectionId).add(map);
      } else {
        data.docs.first.reference.update(map);
      }
      Navigator.pop(context);
    } catch (ex) {
      Navigator.pop(context);
      throw ex.toString();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamWithWhere({
    required String collectionId,
    required String whereId,
    required Object? whereValue,
  }) async* {
    try {
      final fireStore = FirebaseFirestore.instance;

      yield* fireStore
          .collection(collectionId)
          .where(whereId, isEqualTo: whereValue)
          .snapshots();
    } catch (ex) {
      throw ex.toString();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamWithWhereIn({
    required String collectionId,
    required String whereId,
    required List<Object?> whereValueList,
  }) async* {
    try {
      final fireStore = FirebaseFirestore.instance;

      yield* fireStore
          .collection(collectionId)
          .where(whereId, whereIn: whereValueList)
          .snapshots();
    } catch (ex) {
      throw ex.toString();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamWithMultipleWhere({
    required String collectionId,
    required String whereId,
    required Object? whereValue,
    required String whereIdSecond,
    required Object? whereValueSecond,
  }) async* {
    try {
      final fireStore = FirebaseFirestore.instance;

      yield* fireStore
          .collection(collectionId)
          .where(whereId, isEqualTo: whereValue)
          .where(whereIdSecond, isEqualTo: whereValueSecond)
          .snapshots();
    } catch (ex) {
      throw ex.toString();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStream({
    required String collectionId,
  }) async* {
    try {
      final fireStore = FirebaseFirestore.instance;

      yield* fireStore.collection(collectionId).snapshots();
    } catch (ex) {
      throw ex.toString();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData({
    required String collectionId,
    required String whereId,
    required String whereValue,
  }) async {
    try {
      final fireStore = FirebaseFirestore.instance;
      // fireStore.collection(collectionId).doc(docId).update(data)
      final data = await fireStore
          .collection(collectionId)
          .where(whereId, isEqualTo: whereValue)
          .get();
      return data;
    } catch (ex) {
      throw ex.toString();
    }
  }

  addData(
    BuildContext context, {
    required Map<String, dynamic> map,
    required String collectionId,
  }) async {
    try {
      await FirebaseFirestore.instance.collection(collectionId).add(map);
    } catch (ex) {
      print(ex.toString());
    }
  }

  updateData(
    BuildContext context, {
    required Map<String, dynamic> map,
    required String collectionId,
    required String docId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionId)
          .doc(docId)
          .update(map);
    } catch (ex) {
      print(ex.toString());
      throw ex.toString();
    }
  }
}
