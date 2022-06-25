import 'package:flutter/material.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/text_styles.dart';
import 'package:qalbu/domain/entities/quran.dart';
import 'package:qalbu/presentation/pages/quran_detail_page.dart';
import 'package:qalbu/presentation/widgets/number_border.dart';

class QuranList extends StatelessWidget {
  final List<Quran> quranList;

  const QuranList({Key? key, required this.quranList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: quranList.length,
        itemBuilder: (context, index) {
          final surat = quranList[index];
          return Card(
            elevation: 4,
            child: ListTile(
              leading: NumberBorder(numberAyat: surat.nomor),
              title: Text(surat.namaLatin, style: kHeading6),
              subtitle: Text(
                  '${surat.tempatTurun.toUpperCase()} - ${surat.jumlahAyat} AYAT'),
              trailing: Text(
                surat.nama,
                style: kSubtitle.copyWith(color: kPrimary),
              ),
              onTap: () {
                Navigator.pushNamed(context, QuranDetailPage.routeName,
                    arguments: surat.nomor);
              },
            ),
          );
        },
      ),
    );
  }
}
