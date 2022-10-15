// ignore_for_file: file_names

import 'package:fantasy_bet/widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static const routeName = '/main_page';

  @override
  State<MainPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Fantasy Bet'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Center(
          child: SvgPicture.asset(
        'assets/icons/cl.svg',
        height: 30.0,
        width: 30.0,
      )),
    );
  }
}
