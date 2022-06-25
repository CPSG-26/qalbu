import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalbu/common/colors.dart';
import 'package:slide_countdown/slide_countdown.dart';

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String nextPrayerTime;
  final String currentDate;
  final String currentAddress;
  final int hours;
  final int minutes;
  final int seconds;

  const CustomSliverAppBarDelegate({
    required this.expandedHeight,
    required this.nextPrayerTime,
    required this.currentDate,
    required this.currentAddress,
    required this.hours,
    required this.minutes,
    required this.seconds,
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
                        currentAddress.length > 18
                            ? '${currentAddress.substring(0, 19)}...'
                            : currentAddress,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    currentDate,
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
                      const SizedBox(width: 4),
                      Text(
                        nextPrayerTime,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: kSecondary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SlideCountdown(
                        duration: Duration(
                          hours: hours,
                          minutes: minutes,
                          seconds: seconds,
                        ),
                        slideDirection: SlideDirection.up,
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
