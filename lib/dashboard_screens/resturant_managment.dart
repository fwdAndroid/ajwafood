import 'package:ajwafood/add_forms/add_resturant.dart';
import 'package:ajwafood/widgets/colors.dart';
import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
