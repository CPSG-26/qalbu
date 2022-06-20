import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalbu/data/models/menu_data.dart';
import 'package:qalbu/presentation/pages/catatan_ibadah_page.dart';
import 'package:qalbu/presentation/pages/doa_page.dart';
import 'package:qalbu/presentation/pages/kiblat_page.dart';
import 'package:qalbu/presentation/pages/prayer_time_page.dart';
import 'package:qalbu/presentation/pages/quran_page.dart';
import 'package:qalbu/presentation/pages/tasbih_page.dart';

class MenuWidget extends StatelessWidget {
  var now = DateTime.now();
  final double lat;
  final double long;
  final String currentAdress;

  MenuWidget(
      {Key? key,
      required this.lat,
      required this.long,
      required this.currentAdress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight) / 2.5;
    final double itemWidth = size.width / 2;

    return GridView.count(
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: 24,
      childAspectRatio: (itemWidth / itemHeight),
      children: menuData.map((menu) {
        return InkWell(
          onTap: () {
            if (menu.id == '1') {
              Navigator.pushNamed(context, QuranPage.routeName);
            } else if (menu.id == '2') {
              Navigator.pushNamed(context, TasbihPage.routeName);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const TasbihPage()));
            } else if (menu.id == '3') {
              Navigator.pushNamed(context, DoaPage.routeName);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const ListDoaPage()));
            } else if (menu.id == '4') {
              Navigator.pushNamed(
                context,
                PrayerTimePage.routeName,
                arguments: PrayerTimePage(
                    lat: lat,
                    long: long,
                    month: now.month,
                    year: now.year,
                    currentAddress: currentAdress),
              );
            } else if (menu.id == '5') {
              Navigator.pushNamed(context, KiblatPage.routeName);
            } else if (menu.id == '6') {
              Navigator.pushNamed(context, CatatanIbadahPage.routeName);
            }
          },
          child: SizedBox(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    menu.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      menu.title,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
