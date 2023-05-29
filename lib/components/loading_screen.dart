import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoadingState {

  bool loading = false;

  static LoadingState instance = LoadingState._();
  LoadingState._();

  setLoading(bool value) => loading = value;
}

class LoadingScreen extends StatefulWidget {
  final Widget child;
  const LoadingScreen({super.key, required this.child});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5
      ),
      child: Column(
        children: [
          // Stack(
          //   alignment: Alignment.center,
          //   children: [
          //     Positioned(
          //       child: CircularProgressIndicator()
          //     )
          //   ],
          // ),
          widget.child
        ]
      )
    );
  }
}
