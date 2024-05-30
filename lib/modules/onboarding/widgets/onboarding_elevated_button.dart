import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:app_mobile/modules/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:app_mobile/utils/constants/colors.dart';
import 'package:app_mobile/utils/helpers/helper_functions.dart';
import 'package:app_mobile/utils/constants/sizes.dart';
import 'package:app_mobile/utils/device/device_utility.dart';

class OnBoardingElevatedButton extends StatelessWidget {
  const OnBoardingElevatedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = HelperFunctions.isDarkMode(context);

    return Positioned(
      right: AppSizes.defaultSpace,
      bottom: DeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => controller.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? AppColors.primary : AppColors.black,
        ),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
