import 'package:flutter/material.dart';
import 'package:medical_app/screens/doctor/detail_note.dart';


class NotesDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 80.0,
            width: double.infinity,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => DetailNoteScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 15),
                  const Text(
                    "Сделать заметку",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )),
        Expanded(
          child: Container(
            // margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 15),
            padding: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
                        color: Color.fromRGBO(228, 239, 243, 1.0),
                        child: ExpansionTile(
                          title: Text("Купить маску"),
                          trailing: Text("12.12.4444"),
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(24.0),
                                          child: Text(
                                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ac ultrices blandit elit nisl nisi quam. Potenti egestas purus mattis in. Duis erat purus eget risus velit feugiat risus amet. Lacus nisi, accumsan egestas massa eget odio mi penatibus. Lectus semper dui lectus habitant sit quis elementum suspendisse. Auctor vitae feugiat dignissim ipsum vivamus."),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
