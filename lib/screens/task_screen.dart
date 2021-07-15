import 'package:dev_todo/models/task_Data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dev_todo/widgets/tasks_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'bottom_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
class TaskScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final User? user;
  TaskScreen({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7C83FD),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF7C83FD),
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => BottomScreen()
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 40.0, right: 40.0, bottom: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello ${user!.displayName} !",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0),
                    ),
                    Expanded(
                      child: IconButton(  
                        onPressed: (){
                          _googleSignIn.signOut();
                          Navigator.pop(context);
                        },
                        icon: FaIcon(FontAwesomeIcons.signOutAlt,color: Colors.white,size: 18.0,),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.list,
                    size: 35.0,
                    color: Color(0xFF7C83FD),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "TodoAy",
                  style: TextStyle(
                    fontSize: 45.0,
                    color: Colors.white,
                    letterSpacing: 3.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "${Provider.of<TaskData>(context).taskLen} Tasks",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: TasksList(),
            ),
          ),
        ],
      ),
    );
  }
}


