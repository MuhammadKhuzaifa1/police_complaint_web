import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseReferences{

  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference usersReference = FirebaseFirestore.instance.collection('users');
  CollectionReference casesReference = FirebaseFirestore.instance.collection('cases');
  CollectionReference chatReference = FirebaseFirestore.instance.collection('chat');
}