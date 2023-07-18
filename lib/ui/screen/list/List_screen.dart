import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/component/addTask.dart';
import 'package:todo/ui/database/model/task.dart';
import 'package:todo/ui/database/MyDatabase.dart';
import 'package:todo/ui/provider/AuthProvider.dart';
import '../../component/MYdateUtils.dart';

class List_screen extends StatefulWidget {
  @override
  State<List_screen> createState() => _List_screenState();
}

class _List_screenState extends State<List_screen> {
  DateTime seletedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context, listen: false);
    return Container(color: Colors.grey,
     child:Column(
       children: [DatePicker(
         DateTime.now(),
         initialSelectedDate: seletedDate,

         selectionColor: Colors.blue,
         selectedTextColor: Colors.white,
         onDateChange: (date) {
           // New date selected
           setState(() {
             seletedDate = date;
           });
         },
       ),
         Expanded(
           child: StreamBuilder(stream: MyDatabase.getTask(provider.AccountUser?.id??"",Mydate.datenow(seletedDate).millisecondsSinceEpoch),builder: (context, snapshot) {
             if(snapshot.hasError){
               return Text(snapshot.error.toString());
             }if(snapshot.connectionState==ConnectionState.waiting){
               return const Center(child: CircularProgressIndicator());
             }
             var listTask=snapshot.data?.docs.map((doc) => doc.data()).toList();
             return ListView.builder(itemCount: listTask?.length,itemBuilder: (context, index) {
               return AddTask(listTask![index]);
             },);

           },),
         ),
       ],
     )
    );
  }
}
