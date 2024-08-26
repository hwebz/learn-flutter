import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool hideBack;
  final Color? backgroundColor;
  final Widget? actions;
  const BasicAppBar(
      {super.key,
      this.title,
      this.hideBack = false,
      this.actions,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: backgroundColor ?? Colors.transparent,
        elevation: 0,
        title: title ?? const Text(''),
        centerTitle: true,
        actions: [
          actions ?? Container(),
        ],
        leading: hideBack
            ? null
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: (context.isDarkMode ? Colors.white : Colors.black)
                          .withOpacity(0.03),
                      shape: BoxShape.circle),
                  child: Icon(Icons.arrow_back_ios_new,
                      size: 15,
                      color: context.isDarkMode ? Colors.white : Colors.black),
                )));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
