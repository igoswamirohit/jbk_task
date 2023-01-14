import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({Key? key, required this.title, this.actions})
      : super(key: key);

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: 18.semiBoldStyle.copyWith(color: Colors.white),
      ),
      elevation: .1,
      centerTitle: true,
      backgroundColor: Colors.blue.shade300,
      actions: actions,
      leading: context.navigator.canPop()
          ? IconButton(
              onPressed: () {
                context.navigator.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.white,
                size: 20,
              ))
          : const SizedBox.shrink(),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
