import 'package:cloud_firestore/cloud_firestore.dart';

class AddFoodApi{
  Future<QuerySnapshot<Map<String, dynamic>>> getFood()async{
    return await FirebaseFirestore.instance.collection('_Food').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPeople()async{

    return await FirebaseFirestore.instance.collection("_People").get();
  }

  Future<void> deleteFood(String docId)async{
    await FirebaseFirestore.instance
        .collection('_Food')
        .doc(docId)
        .delete();
  }

  Future<void> addFood(Map<String,dynamic> data)async{

    await FirebaseFirestore.instance
        .collection('_Food')
        .add(data);
  }
}