// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:uuid/uuid.dart';

// class DatabaseMethods {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//   //UUuid mean FIreabase AuthID
//   //bussiness Manager
//   Future<String> business({
//     required String email,
//     required String name,
//     required String area,
//     required String type,
//     required String password,
//   }) async {
//     String res = 'Some error occured';

//     try {
//       if (email.isNotEmpty || password.isNotEmpty) {
//         UserCredential cred = await _auth.createUserWithEmailAndPassword(
//             email: email, password: password);
//         //Add User to the database with modal

//         Models userModel = Models(
//           type: type,
//           name: name,
//           area: area,
//           uuid: cred.user!.uid,
//           email: email,
//           password: password,
//         );
//         await firebaseFirestore
//             .collection('business')
//             .doc(cred.user!.uid)
//             .set(userModel.toJson());

//         res = 'success';
//       }
//     } catch (e) {
//       res = e.toString();
//     }
//     return res;
//   }

  

//   //Retailer retailer
//   //Areas
//   Future<String> addRetailer({
//     required String email,
//     required String name,
//     required String area,
//     required String type,
//     required String password,
//   }) async {
//     String res = 'Some error occured';

//     try {
//       if (email.isNotEmpty || password.isNotEmpty) {
//         UserCredential cred = await _auth.createUserWithEmailAndPassword(
//             email: email, password: password);
//         //Add User to the database with modal

//         Models userModel = Models(
//           type: type,
//           name: name,
//           area: area,
//           uuid: cred.user!.uid,
//           email: email,
//           password: password,
//         );
//         await firebaseFirestore
//             .collection('retailers')
//             .doc(cred.user!.uid)
//             .set(userModel.toJson());

//         res = 'success';
//       }
//     } catch (e) {
//       res = e.toString();
//     }
//     return res;
//   }

//   //Add Product
//   Future<String> addProduct({
//     required String dimension,
//     required String uuid,
//     required String productname,
//     required String pcs,
//     required String rate,
//   }) async {
//     String res = 'Some error occured';

//     try {
//       //Add User to the database with modal
//       String postId = Uuid().v1();

//       ProductModels userModel = ProductModels(
//           productname: productname,
//           pcs: pcs,
//           uuid: postId,
//           dimensions: dimension,
//           rate: rate);
//       await FirebaseFirestore.instance
//           .collection('products')
//           .doc(postId)
//           .set(userModel.toJson());

//       res = 'success';
//     } catch (e) {
//       res = e.toString();
//     }
//     return res;
//   }
// }
