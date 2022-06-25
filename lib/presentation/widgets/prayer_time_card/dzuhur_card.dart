import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/notifications.dart';
import 'package:qalbu/common/text_styles.dart';

class DzuhurCard extends StatefulWidget {
  final String time;
  final String prayerSchedule;

  const DzuhurCard(this.time, this.prayerSchedule, {Key? key})
      : super(key: key);

  @override
  State<DzuhurCard> createState() => _DzuhurCardState();
}

class _DzuhurCardState extends State<DzuhurCard> {
  final switchData = GetStorage();
  bool isDzuhur = false;

  @override
  void initState() {
    super.initState();
    if (switchData.read('isDzuhur') != null) {
      setState(() {
        isDzuhur = switchData.read('isDzuhur');
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
              value: isDzuhur,
              onChanged: (value) {
                setState(() {
                  isDzuhur = value;
                  switchData.write('isDzuhur', isDzuhur);
                  if (isDzuhur == true) {
                    final prayerTime = widget.time.substring(0, 5).split(':');
                    final hour = int.parse(prayerTime[0]);
                    final minute = int.parse(prayerTime[1]);
                    createPrayerTimeNotification(
                      3,
                      hour,
                      minute,
                      'Saatnya Adzan Dzuhur!',
                      'Selamat melaksanakan ibadah sholat Dzuhur:)',
                    );
                  } else {
                    cancelPrayerTimeNotification(3);
                  }
                });
              }),
        ),
      ),
    );
  }
}
