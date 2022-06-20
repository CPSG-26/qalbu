import 'package:flutter/material.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/text_styles.dart';
import 'package:qalbu/domain/entities/datum.dart';
import 'package:qalbu/presentation/widgets/prayer_time_card.dart';

class PrayerTimeList extends StatelessWidget {
  final List<Datum> jadwal;
  final dateTime = DateTime.now();

  PrayerTimeList({Key? key, required this.jadwal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: dateTime.day - 1,
      length: jadwal.length,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: TabBar(
              isScrollable: true,
              padding: EdgeInsets.zero,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              indicatorPadding: EdgeInsets.zero,
              unselectedLabelColor: kPrimary,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: kPrimary),
              tabs: jadwal.map((jadwal) {
                return SizedBox(
                  height: 70,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Tab(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: kPrimary, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  jadwal.date.gregorian.weekday.en
                                      .substring(0, 3)
                                      .toUpperCase(),
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  jadwal.date.readable
                                      .substring(0, 2)
                                      .toUpperCase(),
                                  style: kSubtitle.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  jadwal.date.readable
                                      .substring(2, 6)
                                      .toUpperCase(),
                                  style: kBodyText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: jadwal.map((jadwal) {
                return ListView(
                  children: [
                    PrayerTimeCard(jadwal.timings.imsak, 'Imsak'),
                    PrayerTimeCard(jadwal.timings.fajr, 'Shubuh'),
                    PrayerTimeCard(jadwal.timings.dhuhr, 'Dzuhur'),
                    PrayerTimeCard(jadwal.timings.asr, 'Ashar'),
                    PrayerTimeCard(jadwal.timings.maghrib, 'Maghrib'),
                    PrayerTimeCard(jadwal.timings.isha, 'Isya'),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
