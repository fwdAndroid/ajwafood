import 'package:cloud_firestore/cloud_firestore.dart';

class Models {
  String uuid;
  String password;
  String email;
  String area;
  String type;
  String name;

  Models({
    required this.uuid,
    required this.password,
    required this.type,
    required this.email,
    required this.area,
    required this.name,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'name': name,
        'uuid': uuid,
        'email': email,
        'password': password,
        'type': type,
        'area': area
      };

  ///
  static Models fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return Models(
      type: snapshot['type'],
      area: snapshot['area'],
      name: snapshot['name'],
      uuid: snapshot['uuid'],
      email: snapshot['email'],
      password: snapshot['password'],
    );
  }
}
