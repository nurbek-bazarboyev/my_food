import 'package:cloud_firestore/cloud_firestore.dart';

class AddFamilyMemberApi{
  Future<QuerySnapshot<Map<String, dynamic>>> getPeople()async{
    return await FirebaseFirestore.instance.collection('_People').get();
  }

  Future<void> AddMember(Map<String,dynamic>data)async{
    await FirebaseFirestore.instance.collection('_People').add(data);
  }

  Future<void> DeleteMember(String docId)async{
    await FirebaseFirestore.instance
        .collection("_People")
        .doc(docId)
        .delete();
  }

}