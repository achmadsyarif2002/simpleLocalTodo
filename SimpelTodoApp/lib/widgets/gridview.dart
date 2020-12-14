import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bahanlatihan/models/activity.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  final List<Activity> userActivity;
  final TextEditingController titleController;
  final TextEditingController descController;
  TodoList({
    this.userActivity,
    this.titleController,
    this.descController,
  });

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(30.0),
          itemCount: widget.userActivity.length,
          itemBuilder: (ctx, index) {
            return Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              )),
              child: ListTile(
                leading: Icon(Icons.widgets),
                title: Text(
                  widget.userActivity[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    widget.titleController.text = widget.userActivity[index].title;
                    widget.descController.text = widget.userActivity[index].subTitle;
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.TOPSLIDE,
                      dialogType: DialogType.ERROR,
                      title: 'Delete This List ? ',
                      desc: 'Are you sure?',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        setState(() {
                          widget.userActivity.removeAt(index);
                        });
                      },
                    )..show();
                  },
                ),
                subtitle: Text(
                  widget.userActivity[index].subTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
