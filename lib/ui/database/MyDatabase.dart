import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/ui/database/model/task.dart';

import 'model/User.dart';

class MyDatabase {
  static CollectionReference<User> getUserCollection() {
    return FirebaseFirestore.instance.collection('users').withConverter(
          fromFirestore: (snapshot, options) =>
              User.fromfirestore(snapshot.data()!),
          toFirestore: (user, options) => user.tofirestore(),
        );
  }
  static CollectionReference<tasks> getTaskCollection(String uID) {
    return getUserCollection().doc(uID).collection(tasks.collectionName).withConverter(
      fromFirestore: (snapshot, options) =>
          tasks.fromFireStore(snapshot.data()!),
      toFirestore: (task, options) => task.tofirestore(),
    );
  }


  static Future<void> addUser(User user) {
    var collection = getUserCollection();
   return collection.doc(user.id).set(user);
  }
  static Future<User?> readUser(String Id) async {
    var collection=getUserCollection();
    var read=await collection.doc(Id).get();
    return read.data();
  }
  static Future<void> addtask(String Id,tasks task){
 var newTackdoc=  getTaskCollection(Id).doc();
 task.Id=newTackdoc.id;
 return newTackdoc.set(task);


  }
  static Future<QuerySnapshot<tasks>> getTask(String uID)  {
    return  getTaskCollection(uID).get();

  }

}
