// ignore_for_file: sort_child_properties_last, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/presentation/pages/doa_page.dart';

class ListDoaPage extends StatefulWidget {
  static const routeName = 'listDoa-page';

  const ListDoaPage({Key? key}) : super(key: key);

  @override
  State<ListDoaPage> createState() => _ListDoaPageState();
}

class _ListDoaPageState extends State<ListDoaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 5.0,
        backgroundColor: kPrimary,
        title: Row(
          // ignore: sort_child_properties_last
          children: <Widget>[
            const Text(
              'Kumpulan Doa',
              style: TextStyle(color: Colors.white),
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: Row(
                children: const <Widget>[
                  Padding(
                    // ignore: unnecessary_const
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.bookmark,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                    // ignore: unnecessary_const
                    borderSide: BorderSide(color: Color(0xFF629C59)),
                  ),
                  // ignore: unnecessary_const
                  prefixIcon: const Visibility(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                  hintText: 'Cari Disini',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              // ignore: sort_child_properties_last
              child: Card(
                child: InkWell(
                  splashColor: kPrimary,
                  onTap: () {
                    Navigator.pushNamed(context, DoaPage.routeName);
                  },
                  child: SizedBox(
                    width: 350,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Doa Keluar Rumah',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(
                          Icons.bookmark_border,
                          color: kSecondary,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.white54, blurRadius: 2.0)
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Card(
                child: InkWell(
                  splashColor: kPrimary,
                  onTap: () {},
                  child: SizedBox(
                    width: 350,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Doa Masuk Rumah',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(
                          Icons.bookmark_outlined,
                          color: kSecondary,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.white54, blurRadius: 2.0)
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Card(
                child: InkWell(
                  splashColor: kPrimary,
                  onTap: () {},
                  child: SizedBox(
                    width: 350,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        // ignore: prefer_const_constructors
                        Expanded(
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Doa Bekal Taqwa Bagi Orang Berpergian',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.bookmark_border,
                          color: kSecondary,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.white54, blurRadius: 2.0)
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Card(
                shape: const BeveledRectangleBorder(
                    // ignore: unnecessary_const
                    borderRadius: const BorderRadius.all(Radius.circular(2.0))),
                child: InkWell(
                  splashColor: kPrimary,
                  onTap: () {},
                  child: SizedBox(
                    width: 350,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Doa Safar Saat Sudah di Kendaraan',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(
                          Icons.bookmark_outlined,
                          color: kSecondary,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.white54, blurRadius: 2.0)
              ]),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
