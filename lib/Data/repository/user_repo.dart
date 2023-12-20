
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class UserRepo{
   final FirebaseAuth user=FirebaseAuth.instance;

   Future  getUserData() async{
      final UserId  = await user.currentUser?.uid;
       DocumentReference document = FirebaseFirestore.instance.collection('Users').doc(UserId);
       final userData=document.get().then((doc) => AppUser.fromMap(doc));
      return userData;
  }
   Future setUserData(String name,String email) async{
     final UserId  = await user.currentUser?.uid;
     print(UserId);
     DocumentReference document = FirebaseFirestore.instance.collection('Users').doc(UserId);
     document.set({
       'name':name,'email':email
     });
     return null;
   }
}