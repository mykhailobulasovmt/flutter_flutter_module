import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:isl_sdk/main.dart';
import 'package:remove_after_day/navigation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uint8List? _ocrPhoto;
  Uint8List? _alivenessPhoto;
  bool? _isAlive;
  double? _score;

  void _ocr() {
    Navigator.of(context).pushNamed(
      '/islSdk',
      arguments: ISLArgs(IslSdkType.ocr, (ocrPhoto, f) {
        setState(() {
          _ocrPhoto = ocrPhoto;
        });
      }, (isAlive, alivenessPhoto) {}, (score) {}),
    );
  }

  void _aliveness() {
    Navigator.of(context).pushNamed(
      '/islSdk',
      arguments: ISLArgs(IslSdkType.aliveness, (ocrPhoto, f) {}, (isAlive, alivenessPhoto) {
        setState(() {
          _alivenessPhoto = alivenessPhoto;
          _isAlive = isAlive;
        });
      }, (score) {}),
    );
  }

  void _faceMatch() {
    Navigator.of(context).pushNamed(
      '/islSdk',
      arguments: ISLArgs(IslSdkType.faceMatch, (ocrPhoto, f) {}, (isAlive, alivenessPhoto) {}, (score) {
        setState(() {
          _score = score;
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("simple flutter app"),
      ),
      body: Center(
        // child: _contentWidget,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if (alivenessCheckImage != null) Image.memory(alivenessCheckImage!),
            ElevatedButton(
              onPressed: () => _ocr(), // _LaunchTempOcr(),
              child: const Text('Launch Temp OCR'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => _aliveness(),
                  child: const Text('Launch Aliveness'),
                ),
                if (_isAlive != null) Text('Alive = $_isAlive'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Opacity(
                  opacity: _alivenessPhoto != null ? 1.0 : 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_alivenessPhoto != null) {
                        _faceMatch();
                      }
                    },
                    child: const Text('Face matching'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (_score != null) Text('score = ${_score}'),
              ],
            ),
          ],
        ),
        ),
      );
  }
}
