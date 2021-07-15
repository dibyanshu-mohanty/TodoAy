import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallBack;

  TaskTile({required this.isChecked,required this.taskTitle,required this.checkboxCallBack});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.pending_actions_outlined,color: Color(0xFF7C83FD),),
        title: Text(
          taskTitle,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: Transform.scale(
            scale: 1.3,
            child: Checkbox(
                value: isChecked,
                shape: CircleBorder(),
                fillColor: MaterialStateProperty.all(Color(0xFF7952B3)),
                onChanged: (bool? value){
                  checkboxCallBack(value);
                }
            ),
        ),
    );
  }
}

