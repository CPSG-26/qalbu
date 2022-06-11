import 'package:qalbu/common/colors.dart';
import 'package:qalbu/data/db/db_helper.dart';
import 'package:qalbu/data/models/catatan_model.dart';
import 'package:flutter/material.dart';
import 'package:qalbu/presentation/widgets/list_catatan_widget.dart';
import 'package:qalbu/presentation/widgets/tambah_catatan_widget.dart';

class CatatanIbadahPage extends StatefulWidget {
  static const routeName = '/catatanIbadah-page';

  const CatatanIbadahPage({Key? key}) : super(key: key);

  @override
  State<CatatanIbadahPage> createState() => _CatatanIbadahPageState();
}

class _CatatanIbadahPageState extends State<CatatanIbadahPage> {
  var database = DbHelper();

  void tambahItem(CatatanModel catatan) async {
    await database.tambahCatatan(catatan);
    setState(() {});
  }

  void hapusItem(CatatanModel catatan) async {
    await database.hapusCatatan(catatan);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: kTertiaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),

              /// Judul (Text dan Icon)
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Catatan',
                          style: TextStyle(
                            color: kTertiaryTextColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Ibadah',
                          style: TextStyle(
                            color: kTertiaryTextColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/do.png',
                          height: 135,
                          width: 150,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Container background putih
              Container(
                height: size.height,
                margin: EdgeInsets.only(top: size.height * 0.065),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: kTertiaryTextColor,
                ),
                child: ListCatatan(
                  fungsiTambah: tambahItem,
                  fungsiHapus: hapusItem,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TambahCatatan(
                  fungsiTambah: tambahItem,
                ),
              ),
            ),
          );
        }, //AddTask(),
        child: const Icon(
          Icons.add_rounded,
          size: 35,
        ),
      ),
    );
  }
}
