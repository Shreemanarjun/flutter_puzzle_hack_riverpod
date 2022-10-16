import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack_riverpod/features/puzzle/ui/puzzle_view.dart';
import 'package:flutter_puzzle_hack_riverpod/shared/widgets/drawer/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: AppDrawer(),
      body: PuzzleView(),
    );
  }
}
