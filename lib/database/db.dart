import 'dart:typed_data';

import 'package:ajwafood/database/storage.dart';
import 'package:ajwafood/models/food_model.dart';
import 'package:ajwafood/models/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //UUuid mean FIreabase AuthID
  //bussiness Manager
  Future<String> addResturant({
    required String email,
    required String name,
    required String area,
    required String type,
    required String password,
  }) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //Add User to the database with modal

        Models userModel = Models(
          type: type,
          name: name,
          area: area,
          uuid: cred.user!.uid,
          email: email,
          password: password,
        );
        await firebaseFirestore
            .collection('resturant')
            .doc(cred.user!.uid)
            .set(userModel.toJson());

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> addHotel({
    required String email,
    required String name,
    required String area,
    required String type,
    required String password,
  }) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //Add User to the database with modal

        Models userModel = Models(
          type: type,
          name: name,
          area: area,
          uuid: cred.user!.uid,
          email: email,
          password: password,
        );
        await firebaseFirestore
            .collection('hotel')
            .doc(cred.user!.uid)
            .set(userModel.toJson());

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Add Food
  Future<String> addFood(
      {required Uint8List file,
      required price,
      required String uid,
      required String name,
      required foodCategory,
      required menu}) async {
    String res = "Some Error";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("foodImages", file, true);

      String postId = Uuid().v1();
      FoodModel postModel = FoodModel(
        price: price,
        uuid: uid,
        foodCategory: foodCategory,
        menu: menu,
        foodName: name,
        image: photoUrl,
      );

      ///Uploading Post To Firebase
      FirebaseFirestore.instance
          .collection('foods')
          .doc(postId)
          .set(postModel.toJson());
      res = 'Sucessfully Uploaded in Firebase';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
