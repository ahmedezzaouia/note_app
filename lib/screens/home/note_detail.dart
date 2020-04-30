import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notebookapp/models/user.dart';
import 'package:notebookapp/services/database_service.dart';
import 'package:provider/provider.dart';

class NoteDetail extends StatefulWidget {
  final UserData userData;
  NoteDetail({@required this.userData});

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  final _keyForm = GlobalKey<FormState>();
  String titleUpdate;
  String descUpdate;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Color(widget.userData.colourId),
      appBar: AppBar(
        backgroundColor: Color(widget.userData.colourId),
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black87,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.system_update_alt,
              color: Colors.black87,
            ),
            onPressed: () async {
              //update note withe the old title
              await DatabaseService().updateUserData(
                  documentName: widget.userData.documentId,
                  title: titleUpdate ?? widget.userData.title,
                  desc: descUpdate ?? widget.userData.desc,
                  userUid: user.uid,
                  colourId: widget.userData.colourId);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: StreamBuilder<UserData>(
          stream: DatabaseService().userNote(widget.userData.documentId),
          builder: (BuildContext context, AsyncSnapshot snap) {
            return Form(
              key: _keyForm,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        initialValue: widget.userData.title,
                        onChanged: (val) {
                          setState(() {
                            titleUpdate = val;
                          });
                        },
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900),
                        decoration: InputDecoration(
                            fillColor: Color(widget.userData.colourId),
                            filled: true,
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: widget.userData.desc,
                        onChanged: (val) {
                          setState(() {
                            descUpdate = val;
                          });
                        },
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        decoration: InputDecoration(
                            fillColor: Color(widget.userData.colourId),
                            filled: true,
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
