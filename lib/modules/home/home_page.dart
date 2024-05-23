import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:excursion/modules/home/Home_nav_bar.dart';


class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
      bottomNavigationBar: const Home_nav_bar(),
    );
  }
}
