import 'package:flutter/material.dart';
import 'package:dev_todo/models/task_Data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:dev_todo/models/task.dart';
import 'package:dev_todo/widgets/tasks_list.dart';
class BottomScreen extends StatelessWidget {

    @override
  Widget build(BuildContext context) {
    String newTask="";
    return Container(
      child: Container(
        height: 450,
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 80.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                "ADD NEW TASK",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7C83FD),
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 20.0,),
            TextField(
              onChanged: (value){
                newTask=value;
              },
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
              autocorrect: true,
              cursorColor: Color(0xFF7C83FD),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF7C83FD)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF7C83FD),width: 2.0)),
              ),
            ),
            SizedBox(height: 20.0,),
            TextButton(
              onPressed: (){
                Provider.of<TaskData>(context, listen: false).addTask(Task(name: newTask));
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF7C83FD)),
              ),
              child: Text("ADD",style: TextStyle(color: Colors.white,letterSpacing: 2.0),),
            )
          ],
        ),
      ),
    );
  }
}
