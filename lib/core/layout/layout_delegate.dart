import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack_riverpod/core/layout/screen_type_helper.dart';

abstract class LayoutDelegate {
  final BuildContext context;

  const LayoutDelegate(this.context);

  ScreenTypeHelper get screenTypeHelper;
}
