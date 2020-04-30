import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notebookapp/models/user.dart';
import 'package:notebookapp/services/database_service.dart';
import 'package:notebookapp/shared/constants.dart';
import 'package:provider/provider.dart';

class WriteNotes extends StatefulWidget {
  @override
  _WriteNotesState createState() => _WriteNotesState();
}

class _WriteNotesState extends State<WriteNotes> {
  final _keyForm = GlobalKey<FormState>();
  String currentNote;
  String currentTitle;
  int selectedColor = 0xFFEEEEEE;

  List<int> colorData = [
    0xFF7A7313,
    0xFF851476,
    0xFF07A46E,
    0xFF34709E,
    0xFF644F46,
    0xFF3A8514
  ];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Container(
      color: Color(selectedColor),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Form(
        key: _keyForm,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              'Add a New Note',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? 'Enter Title' : null,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 25),
              decoration: kTextInputDecoration.copyWith(
                  hintText: 'add a title', fillColor: Color(selectedColor)),
              onChanged: (val) {
                setState(() {
                  currentTitle = val;
                });
              },
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              child: TextFormField(
                keyboardType: TextInputType.text,
                validator: (val) => val.isEmpty ? 'Enter you text here' : null,
                expands: true,
                maxLines: null,
                minLines: null,
                maxLength: 300,
                decoration: kTextInputDecoration.copyWith(
                    hintText: 'your description',
                    fillColor: Color(selectedColor)),
                onChanged: (val) {
                  setState(() {
                    currentNote = val;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: colorData.map((colour) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = colour;
                      });
                    },
                    child: AddColor(
                      color: Color(colour),
                    ),
                  );
                }).toList()),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () async {
                if (_keyForm.currentState.validate()) {
                  Navigator.pop(context);
                  await DatabaseService().updateUserData(
                      title: currentTitle,
                      desc: currentNote,
                      userUid: user.uid,
                      documentName: currentTitle,
                      colourId: selectedColor);
                }
              },
              color: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddColor extends StatelessWidget {
  final Color color;
  AddColor({this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(50), color: color),
    );
  }
}
