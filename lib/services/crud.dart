import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class CurdMethods {
  bool islogedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(carData) async {
    // if (islogedIn()) {
    // FirebaseFirestore.instance.collection('testCRUD').add(carData);

    //another method to add data to firbase -- by using transactions
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          await FirebaseFirestore.instance.collection('testCRUD');
      reference.add(carData);
    });
    // } else {
    //   print('need to be logged in');
    // }
  }

  getData() {
    //   return FirebaseFirestore.instance.collection('testCRUD').get();
    return FirebaseFirestore.instance.collection('testCRUD').snapshots();
  }

  updateData(selectDoc, newValues) {
    FirebaseFirestore.instance
        .collection('testCRUD')
        .doc(selectDoc)
        .update(newValues);
  }

  deleteData(docId) {
    FirebaseFirestore.instance.collection('testCRUD').doc(docId).delete();
  }
}
