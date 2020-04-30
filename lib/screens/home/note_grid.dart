import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notebookapp/models/user.dart';
import 'package:notebookapp/screens/home/write_notes.dart';
import 'package:provider/provider.dart';
import 'note_tile.dart';

class NoteGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //get provider classes
    final notes = Provider.of<List<UserData>>(context) ?? [];
    final user = Provider.of<User>(context);
    // show bottom sheet
    showWritePanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return WriteNotes();
          });
    }

    // get on the current user' data from notes List
    List<UserData> currentUserData() {
      List<UserData> userData = [];
      for (final currentUserData
          in notes.where((n) => n.userUid.contains(user.uid))) {
        userData.add(currentUserData);
      }
      return userData;
    }

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Notes',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${currentUserData().length} notes',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () => showWritePanel(),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Color(0xFF4342FE),
                        borderRadius: BorderRadius.circular(70)),
                    child: Icon(
                      FontAwesomeIcons.penAlt,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
                itemCount: currentUserData().length,
                itemBuilder: (BuildContext context, int index) {
                  return NoteTile(
                    userData: currentUserData()[index],
                    currentIndex: index,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
