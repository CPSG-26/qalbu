import 'package:flutter/material.dart';
import 'package:qalbu/common/text_styles.dart';

class NumberBorder extends StatelessWidget {
  final int numberAyat;

  const NumberBorder({Key? key, required this.numberAyat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset('assets/icons/no_ayat.png'),
        Text(numberAyat.toString(), style: kBodyText),
      ],
    );
  }
}
