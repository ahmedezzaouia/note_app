import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notebookapp/models/user.dart';

class DatabaseService {
  final CollectionReference notes = Firestore.instance.collection('notes');

  //insert data to firebase if not exist create a new
  Future updateUserData(
      {String title,
      String desc,
      String userUid,
      String documentName,
      int colourId}) async {
    return await notes.document(documentName).setData({
      'title': title,
      'desc': desc,
      'userUid': userUid,
      'documentId': documentName,
      'coloreId': colourId
    });
  }

  //get stream of list to grid view
  Stream<List<UserData>> get userData {
    return notes.snapshots().map((snap) {
      return snap.documents.map((doc) {
        return UserData(
            title: doc.data['title'],
            desc: doc.data['desc'],
            userUid: doc.data['userUid'],
            documentId: doc.data['documentId'],
            colourId: doc.data['coloreId']);
      }).toList();
    });
  }

  //get stream of user note to noteDetail page
  Stream<UserData> userNote(String documentName) {
    return notes.document(documentName).snapshots().map((snap) {
      return UserData(
          userUid: snap.data['userUid'],
          title: snap.data['title'],
          desc: snap.data['desc'],
          documentId: snap.data['documentId']);
    });
  }
}
