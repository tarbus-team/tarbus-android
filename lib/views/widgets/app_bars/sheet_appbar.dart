import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tarbus_app/config/app_colors.dart';

class SheetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onDone;

  const SheetAppBar({Key? key, required this.title, required this.onDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.close, size: 18),
        onPressed: () {
          context.router.pop();
        },
      ),
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.of(context).fontColor,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.done, size: 18),
          onPressed: () => onDone(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
