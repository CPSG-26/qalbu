import 'package:flutter/material.dart';

class DoaPage extends StatefulWidget {
  static const routeName = '/doa-page';

  const DoaPage({Key? key}) : super(key: key);

  @override
  State<DoaPage> createState() => _DoaPageState();
}

class _DoaPageState extends State<DoaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 5.0,
        // ignore: prefer_const_constructors
        backgroundColor: Color(0xFF629C59),
        title: Row(
          // ignore: sort_child_properties_last
          children: const <Widget>[
            Text(
              'Doa Keluar Rumah',
              // ignore: unnecessary_const
              style: TextStyle(color: Colors.white),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
      body: SafeArea(
        child: Column(children: const <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Text(
                'بِسْمِ اللَّهِ، تَوَكَّلْتُ عَلَى اللَّهِ، لاَ حَوْلَ وَلاَ قُوَّةَ إِلاَّ بِاللَّه',
                textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 25, right: 20),
              child: Text(
                'Bismillahi tawakakaltu Alallah, Laa haula wala Quwwata illa Billah',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 25, right: 20),
              child: Text(
                'Dengan nama Allah, aku bertawakkal kepada Allah tiada daya dan kekuatan kecuali dengan Allah',
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
