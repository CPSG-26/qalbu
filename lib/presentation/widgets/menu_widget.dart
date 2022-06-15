import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalbu/data/models/menu_data.dart';
import 'package:qalbu/presentation/pages/catatan_ibadah_page.dart';
import 'package:qalbu/presentation/pages/list_doa_page.dart';
import 'package:qalbu/presentation/pages/quran_page.dart';
import 'package:qalbu/presentation/pages/tasbih_page.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight) / 2.5;
    final double itemWidth = size.width / 2;

    return GridView.count(
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: 12,
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
              Navigator.pushNamed(context, ListDoaPage.routeName);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const ListDoaPage()));
            } else if (menu.id == '5') {
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
                        fontSize: 12,
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
