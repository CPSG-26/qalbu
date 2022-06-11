import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/text_styles.dart';
import 'package:qalbu/domain/entities/quran_detail.dart';
import 'package:qalbu/presentation/widgets/number_border.dart';

class AyatCard extends StatelessWidget {
  final QuranDetail quranDetail;

  const AyatCard({Key? key, required this.quranDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.all(16),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    kTertiary,
                    kSecondary,
                    kPrimary,
                  ],
                ),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  quranDetail.namaLatin,
                  style: kHeading6.copyWith(color: Colors.white),
                ),
                Text(
                  '${quranDetail.tempatTurun.toUpperCase()} - ${quranDetail.jumlahAyat} Ayat',
                  style: kBodyText.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 32),
                Image.asset('assets/images/bismillah.png')
              ],
            ),
          ),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: quranDetail.ayat.length,
            itemBuilder: (context, index) {
              final ayat = quranDetail.ayat[index];
              var htmlLatin = '''<p>${ayat.tr}</p> ''';
              return Card(
                margin: const EdgeInsets.all(16),
                shape: const Border(
                    bottom: BorderSide(width: 1, color: kSecondaryTextColor)),
                elevation: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(child: NumberBorder(numberAyat: ayat.nomor)),
                          Flexible(
                              flex: 5,
                              fit: FlexFit.tight,
                              child: Text(
                                ayat.ar,
                                textAlign: TextAlign.right,
                                style: kHeading5,
                              )),
                        ],
                      ),
                      Html(
                        data: htmlLatin,
                        style: {
                          "p": Style(
                            textAlign: TextAlign.right,
                            color: kSecondaryTextColor,
                            fontStyle: FontStyle.italic,
                          )
                        },
                      ),
                      Text(
                        'Artinya: ${ayat.idn}',
                        textAlign: TextAlign.justify,
                        style: kBodyText,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
