import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModel {
  String uuid;
  String foodName;
  String foodCategory;
  String image;
  String price;
  String menu;

  FoodModel({
    required this.price,
    required this.uuid,
    required this.foodCategory,
    required this.foodName,
    required this.menu,
    required this.image,
  });

  ///Converting OBject Stringo Json Object
  Map<String, dynamic> toJson() => {
        'foodName': foodName,
        'uuid': uuid,
        'foodCategory': foodCategory,
        'menu': menu,
        'image': image,
        'price': price,
      };

  ///
  static FoodModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return FoodModel(
        image: snapshot['image'],
        menu: snapshot['menu'],
        foodCategory: snapshot['foodCategory'],
        uuid: snapshot['uuid'],
        foodName: snapshot['foodName'],
        price: snapshot['price']);
  }
}
