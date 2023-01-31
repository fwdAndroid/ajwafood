import 'package:ajwafood/add_forms/add_resturant.dart';
import 'package:ajwafood/widgets/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ResturantManagement extends StatefulWidget {
  const ResturantManagement({
    super.key,
  });

  @override
  _ResturantManagementState createState() => _ResturantManagementState();
}

class _ResturantManagementState extends State<ResturantManagement>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

      //Init Floating Action Bubble
      floatingActionButton: FloatingActionBubble(
        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPressed: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),

        // Floating Action button Icon color
        iconColor: Colors.white,

        // Floating Action button Icon
        iconData: Icons.add_task,
        backgroundColor: AppColors.primary,
        // Menu items
        items: <Widget>[
          // Floating action menu item

          //Floating action menu item
          BubbleMenu(
            title: "Add Resturant",
            iconColor: Colors.white,
            bubbleColor: AppColors.primary,
            icon: Icons.restaurant,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const AddResturant(),
                ),
              );
              _animationController.reverse();
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("resturant").snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: LoadingAnimationWidget.hexagonDots(
                      color: AppColors.primary, size: 200));
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 270.0,
                    crossAxisSpacing: 55.0,
                    mainAxisSpacing: 55.0,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var snap = snapshot.data!.docs[index];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Email: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['email']),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Name: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['name']),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Pass: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['password']),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Area: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snap['area']),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              clipBehavior: Clip.antiAlias,
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (builder) =>
                                //             BusinessView(data: snap)));
                              },
                              child: Text("View"),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
