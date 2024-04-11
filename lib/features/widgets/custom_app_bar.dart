import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final double dw = MediaQuery.of(context).size.width;
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Image(
          image: AssetImage('assets/back_icon.png'),
        ),
      ),
      title: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                'assets/navistream_logo/logo_black.png',
              ),
              SizedBox(width: dw * .1)
            ],
          ),
        ],
      ),
    );
  }
}
