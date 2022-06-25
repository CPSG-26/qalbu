import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/text_styles.dart';
import 'package:qalbu/domain/entities/datum.dart';

class PrayerTimeList extends StatefulWidget {
  final List<Datum> jadwal;

  const PrayerTimeList({Key? key, required this.jadwal}) : super(key: key);

  @override
  State<PrayerTimeList> createState() => _PrayerTimeListState();
}

class _PrayerTimeListState extends State<PrayerTimeList> {
  final dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Allow Notifications'),
              content:
                  const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: kPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: dateTime.day - 1,
      length: widget.jadwal.length,
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
              tabs: widget.jadwal.map((jadwal) {
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
              children: widget.jadwal.map((jadwal) {
                return ListView(
                  children: const [
                    // ImsakCard(jadwal.timings.imsak, 'Imsak'),
                    // ShubuhCard(jadwal.timings.fajr, 'Shubuh'),
                    // DzuhurCard(jadwal.timings.dhuhr, 'Dzuhur'),
                    // AsharCard(jadwal.timings.asr, 'Ashar'),
                    // MaghribCard(jadwal.timings.maghrib, 'Maghrib'),
                    // IsyaCard(jadwal.timings.isha, 'Isya'),
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
