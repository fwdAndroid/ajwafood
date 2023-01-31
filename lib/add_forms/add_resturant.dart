import 'package:ajwafood/database/db.dart';
import 'package:ajwafood/widgets/colors.dart';
import 'package:ajwafood/widgets/exc_button.dart';
import 'package:ajwafood/widgets/input_text.dart';
import 'package:ajwafood/widgets/sidebar.dart';
import 'package:ajwafood/widgets/utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:email_validator/email_validator.dart';

class AddResturant extends StatefulWidget {
  const AddResturant({super.key});

  @override
  State<AddResturant> createState() => _AddResturantState();
}

class _AddResturantState extends State<AddResturant> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  bool _isLoading = false;
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                width: 448,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText(
                          'Add Resturant in Ajwa Platform',
                          textStyle: const TextStyle(
                            fontSize: 25.0,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      totalRepeatCount: 4,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                    const SizedBox(height: 21),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email Address",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      validator: (value) =>
                          value != null && !EmailValidator.validate(value)
                              ? 'Enter a valid Emails'
                              : null,
                      controller: _emailController,
                      labelText: "example@gmail.com",
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
                        "Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: passController,
                      labelText: "********",
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {},
                      onSaved: (val) {},
                      validator: (value) {
                        if (value != null && value.length < 6) {
                          return 'Password length must be 6 or greater';
                        } else {
                          return null;
                        }
                      },
                      textInputAction: TextInputAction.done,
                      isPassword: true,
                      enabled: true,
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: _nameController,
                      labelText: "Al Muqadar Resturant",
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
                        "Area",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 9),
                    InputText(
                      controller: _areaController,
                      labelText: "Lahore DHQ",
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

  void onCreate() async {
    setState(() {
      _isLoading = true;
    });

    String rse = await DatabaseMethods().addResturant(
        email: _emailController.text,
        password: passController.text,
        area: _areaController.text,
        name: _nameController.text,
        type: "Resturant");

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse != 'sucess') {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => SideDrawer()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Conguration Data is Added")));
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => SideDrawer()));
    }
  }
}
