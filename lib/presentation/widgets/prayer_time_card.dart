import 'package:flutter/material.dart';
import 'package:qalbu/common/text_styles.dart';

class PrayerTimeCard extends StatefulWidget {
  final String time;
  final String prayerSchedule;

  const PrayerTimeCard(this.time, this.prayerSchedule, {Key? key})
      : super(key: key);

  @override
  State<PrayerTimeCard> createState() => _PrayerTimeCardState();
}

class _PrayerTimeCardState extends State<PrayerTimeCard> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Card(
        elevation: 4,
        child: ListTile(
          title: Text(widget.time, style: kHeading6),
          subtitle: Text(widget.prayerSchedule, style: kBodyText),
        ),
      ),
    );
  }
}
