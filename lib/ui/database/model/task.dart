import 'package:cloud_firestore/cloud_firestore.dart';

class tasks{
  static const String collectionName='tasks';
  String? Id;
  String? title;
  DateTime? selectTime ;
  bool? done;
  tasks({this.Id, this.selectTime, this.title, this.done = false});
  tasks.fromFireStore(Map<String,dynamic>? date):this(
    Id: date?['Id'],
    done: date?['done'],
    selectTime: DateTime.fromMillisecondsSinceEpoch(date?['SelectTime']),
    title: date?['title'],
  );

  Map<String,dynamic> tofirestore() {
    return {
      'Id': Id,
      'title': title,
      'SelectTime': selectTime?.millisecondsSinceEpoch ,
      'done':done
    };
  }}