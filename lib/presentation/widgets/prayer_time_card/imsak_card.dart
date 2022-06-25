import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/notifications.dart';
import 'package:qalbu/common/text_styles.dart';

class ImsakCard extends StatefulWidget {
  final String time;
  final String prayerSchedule;

  const ImsakCard(this.time, this.prayerSchedule, {Key? key}) : super(key: key);

  @override
  State<ImsakCard> createState() => _ImsakCardState();
}

class _ImsakCardState extends State<ImsakCard> {
  final switchData = GetStorage();
  bool isImsak = false;

  @override
  void initState() {
    super.initState();
    if (switchData.read('isImsak') != null) {
      setState(() {
        isImsak = switchData.read('isImsak');
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
              value: isImsak,
              onChanged: (value) {
                setState(() {
                  isImsak = value;
                  switchData.write('isImsak', isImsak);
                  if (isImsak == true) {
                    final prayerTime = widget.time.substring(0, 5).split(':');
                    final hour = int.parse(prayerTime[0]);
                    final minute = int.parse(prayerTime[1]);
                    createPrayerTimeNotification(
                      1,
                      hour,
                      minute,
                      'Sudah saatnya Imsak!',
                      'Bersiap untuk melaksanakan ibadah sholat shubuh:)',
                    );
                  } else {
                    cancelPrayerTimeNotification(1);
                  }
                });
              }),
        ),
      ),
    );
  }
}
