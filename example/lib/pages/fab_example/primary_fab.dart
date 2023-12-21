import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'fab_example.dart';

/// Small Buttons
class FabPrimarySmallCircle extends StatefulWidget {
  static const String name = 'FABPrimarySmallCircle';

  const FabPrimarySmallCircle();

  @override
  State<FabPrimarySmallCircle> createState() => _FabPrimarySmallCircleState();
}

class _FabPrimarySmallCircleState extends State<FabPrimarySmallCircle> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getFABScaffold(
        ZetaFabShape.circle, ZetaFabSize.small, ZetaFabType.primary, _scrollController, FabPrimarySmallCircle.name);
  }
}

class FabPrimarySmallRounded extends StatefulWidget {
  static const String name = 'FABPrimarySmallRounded';

  const FabPrimarySmallRounded();

  @override
  State<FabPrimarySmallRounded> createState() => _FabPrimarySmallRoundedState();
}

class _FabPrimarySmallRoundedState extends State<FabPrimarySmallRounded> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getFABScaffold(
        ZetaFabShape.rounded, ZetaFabSize.small, ZetaFabType.primary, _scrollController, FabPrimarySmallRounded.name);
  }
}

class FabPrimarySecondSmallSharp extends StatefulWidget {
  static const String name = 'FABPrimarySecondSmallSharp';

  const FabPrimarySecondSmallSharp();

  @override
  State<FabPrimarySecondSmallSharp> createState() => _FabPrimarySecondSmallSharpState();
}

class _FabPrimarySecondSmallSharpState extends State<FabPrimarySecondSmallSharp> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getFABScaffold(ZetaFabShape.sharp, ZetaFabSize.small, ZetaFabType.primarySecond, _scrollController,
        FabPrimarySecondSmallSharp.name);
  }
}

/// Large Buttons
class FabPrimarySecondLargeCircle extends StatefulWidget {
  static const String name = 'FABPrimarySecondLargeCircle';

  const FabPrimarySecondLargeCircle();

  @override
  State<FabPrimarySecondLargeCircle> createState() => _FabPrimarySecondLargeCircleState();
}

class _FabPrimarySecondLargeCircleState extends State<FabPrimarySecondLargeCircle> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getFABScaffold(ZetaFabShape.circle, ZetaFabSize.large, ZetaFabType.primarySecond, _scrollController,
        FabPrimarySecondLargeCircle.name);
  }
}

class FabInverseLargeRounded extends StatefulWidget {
  static const String name = 'FABInverseLargeRounded';

  const FabInverseLargeRounded();

  @override
  State<FabInverseLargeRounded> createState() => _FabInverseLargeRoundedState();
}

class _FabInverseLargeRoundedState extends State<FabInverseLargeRounded> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getFABScaffold(
        ZetaFabShape.rounded, ZetaFabSize.large, ZetaFabType.inverse, _scrollController, FabInverseLargeRounded.name);
  }
}

class FabInverseLargeSharp extends StatefulWidget {
  static const String name = 'FABInverseLargeSharp';

  const FabInverseLargeSharp();

  @override
  State<FabInverseLargeSharp> createState() => _FabInverseLargeSharpState();
}

class _FabInverseLargeSharpState extends State<FabInverseLargeSharp> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getFABScaffold(
        ZetaFabShape.sharp, ZetaFabSize.large, ZetaFabType.inverse, _scrollController, FabInverseLargeSharp.name);
  }
}
