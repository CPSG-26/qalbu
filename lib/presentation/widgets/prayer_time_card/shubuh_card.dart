import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/notifications.dart';
import 'package:qalbu/common/text_styles.dart';

class ShubuhCard extends StatefulWidget {
  final String time;
  final String prayerSchedule;

  const ShubuhCard(this.time, this.prayerSchedule, {Key? key})
      : super(key: key);

  @override
  State<ShubuhCard> createState() => _ShubuhCardState();
}

class _ShubuhCardState extends State<ShubuhCard> {
  final switchData = GetStorage();
  bool isShubuh = false;

  @override
  void initState() {
    super.initState();
    if (switchData.read('isShubuh') != null) {
      setState(() {
        isShubuh = switchData.read('isShubuh');
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
              value: isShubuh,
              onChanged: (value) {
                setState(() {
                  isShubuh = value;
                  switchData.write('isShubuh', isShubuh);
                  if (isShubuh == true) {
                    final prayerTime = widget.time.substring(0, 5).split(':');
                    final hour = int.parse(prayerTime[0]);
                    final minute = int.parse(prayerTime[1]);
                    createPrayerTimeNotification(
                      2,
                      hour,
                      minute,
                      'Saatnya Adzan Shubuh!',
                      'Selamat melaksanakan ibadah sholat Shubuh:)',
                    );
                  } else {
                    cancelPrayerTimeNotification(2);
                  }
                });
              }),
        ),
      ),
    );
  }
}
