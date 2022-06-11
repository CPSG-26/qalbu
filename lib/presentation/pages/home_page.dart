import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalbu/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:qalbu/presentation/widgets/doa_widget.dart';
import 'package:qalbu/presentation/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverPersistentHeader(
            delegate: CustomSliverAppBarDelegate(expandedHeight: 204),
            pinned: true,
          ),
          buildSliver(context)
        ],
      ),
    );
  }

  Widget buildSliver(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 56, right: 8, bottom: 8, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const MenuWidget(),
            const SizedBox(height: 4),
            Text(
              'Rekomendasi Doa',
              style: GoogleFonts.poppins(
                  fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            const DoaWidget()
          ],
        ),
      ),
    );
  }
}
