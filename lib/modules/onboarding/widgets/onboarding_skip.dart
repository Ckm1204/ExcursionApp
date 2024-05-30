import 'package:flutter/material.dart';

import 'package:app_mobile/modules/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:app_mobile/utils/constants/sizes.dart';
import 'package:app_mobile/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      top: DeviceUtils.getAppBarHeight(),
      right: AppSizes.defaultSpace,
      child: TextButton(
        onPressed: () => controller.skipPage(),
        child: const Text('Salir'),
      ),
    );
  }
}
