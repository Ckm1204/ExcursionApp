import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:excursion/modules/home/Home_nav_bar.dart';
import 'package:excursion/modules/home/home/card_firestore.dart';


class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: const Home_nav_bar(),
    );
  }
}
