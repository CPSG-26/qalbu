import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class KiblatWidget extends StatelessWidget {
  const KiblatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final qiblatDirection = snapshot.data!;

          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: (qiblatDirection.direction * (pi / 180) * -1),
                child: Image.asset('assets/images/compass.png'),
              ),
              Transform.rotate(
                angle: (qiblatDirection.qiblah * (pi / 180) * -1),
                child: Image.asset(
                  'assets/images/needle.png',
                  scale: 1.2,
                ),
              ),
            ],
          );
        });
  }
}
