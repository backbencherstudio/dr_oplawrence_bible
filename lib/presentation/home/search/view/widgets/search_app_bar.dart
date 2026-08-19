import 'package:flutter/material.dart';

/// App bar with back arrow used by the search screen.
class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffEBEBEB),
      elevation: 0,
      leading: GestureDetector(
        onTap: onBack ?? () => Navigator.maybePop(context),
        child: Image.asset('assets/icons/back_arrow.png', scale: 4),
      ),
    );
  }
}