import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/notifications.dart';
import 'package:qalbu/common/text_styles.dart';

class MaghribCard extends StatefulWidget {
  final String time;
  final String prayerSchedule;

  const MaghribCard(this.time, this.prayerSchedule, {Key? key})
      : super(key: key);

  @override
  State<MaghribCard> createState() => _MaghribCardState();
}

class _MaghribCardState extends State<MaghribCard> {
  final switchData = GetStorage();
  bool isMaghrib = false;

  @override
  void initState() {
    super.initState();
    if (switchData.read('isMaghrib') != null) {
      setState(() {
        isMaghrib = switchData.read('isMaghrib');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Card(
        elevation: 4,
        child: ListTile(
          title: Text(widget.time, style: kHeading6),
          subtitle: Text(widget.prayerSchedule, style: kBodyText),
          trailing: Switch(
              activeColor: kPrimary,
              value: isMaghrib,
              onChanged: (value) {
                setState(() {
                  isMaghrib = value;
                  switchData.write('isMaghrib', isMaghrib);
                  if (isMaghrib == true) {
                    final prayerTime = widget.time.substring(0, 5).split(':');
                    final hour = int.parse(prayerTime[0]);
                    final minute = int.parse(prayerTime[1]);
                    createPrayerTimeNotification(
                      5,
                      hour,
                      minute,
                      'Saatnya Adzan Maghrib!',
                      'Selamat melaksanakan ibadah sholat Maghrib:)',
                    );
                  } else {
                    cancelPrayerTimeNotification(5);
                  }
                });
              }),
        ),
      ),
    );
  }
}
