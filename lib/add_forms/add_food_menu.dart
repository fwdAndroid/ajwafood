import 'dart:io';
import 'dart:typed_data';

import 'package:ajwafood/database/db.dart';
import 'package:ajwafood/widgets/colors.dart';
import 'package:ajwafood/widgets/exc_button.dart';
import 'package:ajwafood/widgets/input_text.dart';
import 'package:ajwafood/widgets/sidebar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ajwafood/widgets/utils.dart';
import 'package:uuid/uuid.dart';

class AddFoodMenu extends StatefulWidget {
  const AddFoodMenu({super.key});

  @override
  State<AddFoodMenu> createState() => _AddFoodMenuState();
}

class _AddFoodMenuState extends State<AddFoodMenu> {
  TextEditingController foodName = TextEditingController();
  TextEditingController foodCategory = TextEditingController();
  TextEditingController menu = TextEditingController();
  TextEditingController price = TextEditingController();
  var _file;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  File? imageUrl;
  String imageLink = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Go Back",
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: InkWell(
                onTap: () => selectImage(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 374,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _file != null
                            ? CircleAvatar(
                                radius: 45,
                                backgroundImage: MemoryImage(_file!))
                            : CircleAvatar(
                                radius: 45,
                                backgroundImage: AssetImage(
                                  "assets/png/cam.png",
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                width: 448,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 14),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Food Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: foodName,
                      labelText: "Apple",
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {},
                      onSaved: (val) {},
                      textInputAction: TextInputAction.done,
                      isPassword: false,
                      enabled: true,
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Food Category",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: foodCategory,
                      labelText: "Burger",
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {},
                      onSaved: (val) {},
                      textInputAction: TextInputAction.done,
                      isPassword: false,
                      enabled: true,
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Menu",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: menu,
                      labelText: "Salad",
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {},
                      onSaved: (val) {},
                      textInputAction: TextInputAction.done,
                      isPassword: false,
                      enabled: true,
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Price",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: price,
                      labelText: "10",
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {},
                      onSaved: (val) {},
                      textInputAction: TextInputAction.done,
                      isPassword: false,
                      enabled: true,
                    ),
                    const SizedBox(height: 40),
                    WonsButton(
                      height: 50,
                      width: 348,
                      verticalPadding: 0,
                      color: AppColors.primary,
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : Text(
                              "Add",
                              style: TextStyle(
                                  color: AppColors.neutral,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                      onPressed: onCreate,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  var uid = Uuid().v1();
  void onCreate() async {
    setState(() {
      _isLoading = true;
    });

    String rse = await DatabaseMethods().addFood(
        name: foodName.text,
        foodCategory: foodCategory.text,
        price: price.text,
        menu: menu.text,
        file: _file,
        uid: uid);

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse != 'sucess') {
      Customdialog().showInSnackBar(rse, context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Conguration Data is Added")));
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => SideDrawer()));
    }
  }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _file = ui;
    });
  }

  void getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
  }

  static pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);

    if (file != null) {
      return await file.readAsBytes();
    }
    print('No Image Selected');
  }
}
