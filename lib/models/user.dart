class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String userUid;
  final String title;
  final String desc;
  final String documentId;
  final int colourId;

  UserData(
      {this.title, this.userUid, this.desc, this.documentId, this.colourId});
}
