import 'package:qalbu/common/colors.dart';
import 'catatan_card.dart';
import 'package:qalbu/data/db/db_helper.dart';
import 'package:flutter/material.dart';

class ListCatatan extends StatelessWidget {
  final db = DbHelper();
  final Function fungsiTambah;
  final Function fungsiHapus;

  ListCatatan({Key? key, required this.fungsiTambah, required this.fungsiHapus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: db.getCatatan(),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        var data = snapshot.data;
        var lengthCatatan = data!.length;

        return lengthCatatan == 0
            ? Center(
                child: Container(
                  height: size.height * 0.5,
                  margin: EdgeInsets.only(top: size.height * 0.065),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: kTertiaryTextColor,
                  ),
                  child: const Text(
                    "Kamu belum memiliki catatan",
                    style: TextStyle(
                      color: kSecondaryTextColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 65,
                  horizontal: 30,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return CatatanCard(
                      id: data[index].id,
                      judul: data[index].judul,
                      selesai: data[index].selesai,
                      fungsiTambah: fungsiTambah,
                      fungsiHapus: fungsiHapus,
                    );
                  },
                ),
              );
      },
    );
  }
}
