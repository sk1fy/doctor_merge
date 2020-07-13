import 'package:flutter/material.dart';
import 'package:medical_app/models/network.dart';

final commentController = TextEditingController();

class EditBottomSheet extends StatelessWidget {
  String orderId;
  EditBottomSheet({this.orderId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
      ),
      child: ListView(
        children: <Widget>[
          ListTile(title: Text('Коментарии врача:')),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextField(
                controller: commentController,
                maxLines: 5,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '...',
                ),
              ),
              SizedBox(height: 60),
              Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: RaisedButton.icon(
                  icon: Icon(
                    Icons.save,
                    color: Colors.blue,
                  ),
                  label: Text('Сохранить и закрыть',
                      style: TextStyle(color: Colors.blue, fontSize: 16)),
                  onPressed: () => commentEdit(context, orderId),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future commentEdit(context, id) async {
    final editedMedicComment = commentController.value.text;
    try {
      await AuthNetwork.of(context).editCommentOrder(id, editedMedicComment);
    } catch (err) {
      print(err);
    }
    commentController.clear();
    Navigator.pop(context);
  }
}

