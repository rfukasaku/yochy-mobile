import 'package:flutter/material.dart';

import '../../util/app_colors.dart';

PreferredSizeWidget simpleAppBar(BuildContext context, String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.black),
      backgroundColor: AppColors.white,
    ),
  );
}
