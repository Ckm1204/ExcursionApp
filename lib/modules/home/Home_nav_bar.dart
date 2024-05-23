
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:excursion/utils/constants/sizes.dart';
import 'package:excursion/utils/constants/colors.dart';
import 'package:excursion/utils/constants/text_strings.dart';
import 'package:excursion/generated/app_localizations.dart';
import 'package:get/get.dart';





class Home_nav_bar extends StatefulWidget {
  const Home_nav_bar({super.key});

  @override
  State<Home_nav_bar> createState() => _Home_nav_barState();
}

class _Home_nav_barState extends State<Home_nav_bar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: AppColors.buttonPrimary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            gap: 8,
            padding: const EdgeInsets.all(20.0),
            backgroundColor: AppColors.buttonPrimary,
            color: AppColors.buttonDisabled,
            activeColor: AppColors.buttonDisabled,
            tabBackgroundColor: Colors.grey.shade800,
            onTabChange: (index) {
              print(index);
            },
            tabs: [
              GButton(
                  icon: Icons.home,
                  text: AppText.home
              ),
              GButton(
                  icon: Icons.search,
                  text: AppText.search
              ),
              GButton(
                  icon: Icons.person,
                  text: AppText.profile
              )
            ]

          ),
        ),
      ),

    );
  }
}
