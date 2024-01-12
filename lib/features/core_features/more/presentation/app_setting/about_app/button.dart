import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/localization/language_helper.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/features/core_features/more/presentation/app_setting/about_app/screen.dart';

class MoreAboutAppButton extends StatelessWidget {
  const MoreAboutAppButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AboutAppScreen(),
            ));
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
        child: CustomText(
          text: LanguageHelper.getTranslation(context).about_app,
          fontSize: AppConstants.textSize16,
        ),
      ),
    );
  }
}