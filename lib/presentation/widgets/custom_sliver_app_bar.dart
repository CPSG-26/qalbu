import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalbu/common/colors.dart';

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  const CustomSliverAppBarDelegate({
    required this.expandedHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    const size = 168;
    final top = expandedHeight - shrinkOffset - size / 2;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset),
        buildAppBar(shrinkOffset),
        Positioned(
          top: top,
          left: 8,
          right: 8,
          child: buildFloating(shrinkOffset),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) {
    return shrinkOffset / expandedHeight;
  }

  double disappear(double shrinkOffset) {
    return 1 - shrinkOffset / expandedHeight;
  }

  Widget buildAppBar(double shrinkOffset) {
    return Opacity(
      opacity: appear(shrinkOffset),
      child: AppBar(
        title: Row(
          children: <Widget>[
            const SizedBox(width: 8),
            Image.asset(
              "assets/logo/qalbu-white-transparent.png",
              height: 27,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              size: 32,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget buildBackground(double shrinkOffset) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: Center(
        child: SizedBox(
          child: GridTile(
            header: Container(
              padding: const EdgeInsets.only(top: 36),
              child: Text(
                'Assalamu\'alaikum, Budi',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: kTertiaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            child: Image.asset(
              'assets/images/banner.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFloating(double shrinkOffset) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/logo/qalbu-transparent.png",
                    height: 27,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.person,
                      size: 32,
                      color: kPrimary,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1.5),
            Padding(
              padding:
                  const EdgeInsets.only(top: 6, right: 12, bottom: 10, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.place,
                        color: kPrimary,
                        size: 20,
                      ),
                      Text(
                        "Kabupaten Garut",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Sabtu, 28 Mei 2022",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 12, left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        "Dzuhur",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: kSecondary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "11:49 WIB",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: kSecondary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "02:10:19",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: kSecondary,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "Menjelang Azan",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: kSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent {
    return expandedHeight;
  }

  @override
  double get minExtent {
    return kToolbarHeight + 30;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
