import 'package:qalbu/common/colors.dart';
import 'package:qalbu/data/models/catatan_model.dart';
import 'package:flutter/material.dart';

class CatatanCard extends StatefulWidget {
  CatatanCard({
    Key? key,
    required this.id,
    required this.judul,
    required this.selesai,
    required this.fungsiTambah,
    required this.fungsiHapus,
  }) : super(key: key);

  final int id;
  final String judul;
  bool selesai;
  final Function fungsiTambah;
  final Function fungsiHapus;

  @override
  State<CatatanCard> createState() => _CatatanCardState();
}

class _CatatanCardState extends State<CatatanCard> {
  @override
  Widget build(BuildContext context) {
    var catatanLokal = CatatanModel(
      id: widget.id,
      judul: widget.judul,
      selesai: widget.selesai,
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 65,
      decoration: const BoxDecoration(
        color: kTaskTile,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: CheckboxListTile(
          title: Text(
            widget.judul,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: widget.selesai ? TextDecoration.lineThrough : null),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          secondary: IconButton(
            onPressed: () {
              widget.fungsiHapus(catatanLokal);
            },
            icon: const Icon(Icons.delete_rounded),
          ),
          value: widget.selesai,
          onChanged: (checked) {
            setState(
              () {
                widget.selesai = checked!;
              },
            );
            catatanLokal.selesai = checked!;
            widget.fungsiTambah(catatanLokal);
          },
          selected: widget.selesai,
          activeColor: kSecondaryTextColor,
        ),
      ),
    );
  }
}
