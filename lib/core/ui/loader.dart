import 'package:flutter/material.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.accentColorLight,
      ),
    );
  }
}
