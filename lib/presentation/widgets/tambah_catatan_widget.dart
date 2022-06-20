import 'package:qalbu/common/colors.dart';
import 'package:qalbu/data/models/catatan_model.dart';
import 'package:flutter/material.dart';

class TambahCatatan extends StatelessWidget {
  final input = TextEditingController();
  final Function fungsiTambah;

  TambahCatatan({Key? key, required this.fungsiTambah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF757575),
      child: Container(
        decoration: const BoxDecoration(
          color: kTertiaryTextColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Judul tambah catatan
            const Text(
              'Tambah Catatan',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            /// Textfield catatan baru
            SizedBox(
              height: 80,
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                controller: input,
                maxLength: 50,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIconColor: kSecondary,
                  hintText: 'Ketikkan catatan',
                  hintStyle: const TextStyle(
                    color: kHint,
                  ),
                ),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),

            /// Tombol Tambah
            SizedBox(
              height: 40.0,
              child: TextButton(
                onPressed: () {
                  var catatanBaru = CatatanModel(
                    judul: input.text,
                    selesai: false,
                  );
                  fungsiTambah(catatanBaru);
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: kSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Tambah",
                  style: TextStyle(
                    color: kTertiaryTextColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
