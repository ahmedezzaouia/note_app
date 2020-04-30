import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notebookapp/models/user.dart';
import 'package:notebookapp/screens/home/note_detail.dart';

class NoteTile extends StatelessWidget {
  final UserData userData;
  final int currentIndex;
  NoteTile({this.userData, this.currentIndex});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoteDetail(userData: userData)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        margin: currentIndex.isEven
            ? EdgeInsets.only(bottom: 5, left: 5)
            : EdgeInsets.only(top: 10, right: 5),
        decoration: BoxDecoration(
          color: Color(userData.colourId),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              userData.title,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: userData.colourId == 4293848814
                      ? Colors.black
                      : Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              userData.desc,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: userData.colourId == 4293848814
                      ? Colors.black
                      : Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
