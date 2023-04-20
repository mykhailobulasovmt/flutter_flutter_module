import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:isl_sdk/main.dart';
import 'package:remove_after_day/main.dart';
import 'package:remove_after_day/page.dart';

MaterialPageRoute getPageRoute(String? name, {Object? arguments}) =>
    MaterialPageRoute(builder: (context) => getScreen(name, arguments: arguments));

Widget getScreen(String? name, {Object? arguments}) {
  switch (name) {
    case '/':
      return const MyHomePage();
    case '/islSdk':
      final args = arguments as ISLArgs;
      return IslSdkHomePage(
        islSdkType: args.islSdkType,
        callBackAliveness: args.callBackAliveness,
        callBackFaceMatch: args.callBackFaceMatch,
        callBackOCR: args.callBackOCR,
      );
    default:
      return const SizedBox.shrink();
  }
}

class ISLArgs {
  ISLArgs(this.islSdkType, this.callBackOCR, this.callBackAliveness, this.callBackFaceMatch);

  final IslSdkType islSdkType;
  final Function(Uint8List uintImage, Map<String, String> map)? callBackOCR;
  final Function(bool isAlive, Uint8List uintImage)? callBackAliveness;
  final Function(double score)? callBackFaceMatch;
}