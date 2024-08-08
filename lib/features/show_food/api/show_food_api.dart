import 'package:cloud_firestore/cloud_firestore.dart';

class ShowFoodApi{
  Future<QuerySnapshot<Map<String, dynamic>>> getPeople()async{
    return await FirebaseFirestore.instance.collection('_People').get();
  }
  Future<QuerySnapshot<Map<String, dynamic>>> getFood()async{
    return await FirebaseFirestore.instance.collection('_Food').get();
  }

}