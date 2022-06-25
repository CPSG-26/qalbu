import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/notifications.dart';
import 'package:qalbu/common/text_styles.dart';

class AsharCard extends StatefulWidget {
  final String time;
  final String prayerSchedule;

  const AsharCard(this.time, this.prayerSchedule, {Key? key}) : super(key: key);

  @override
  State<AsharCard> createState() => _AsharCardState();
}

class _AsharCardState extends State<AsharCard> {
  final switchData = GetStorage();
  bool isAshar = false;

  @override
  void initState() {
    super.initState();
    if (switchData.read('isAshar') != null) {
      setState(() {
        isAshar = switchData.read('isAshar');
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
              value: isAshar,
              onChanged: (value) {
                setState(() {
                  isAshar = value;
                  switchData.write('isAshar', isAshar);
                  if (isAshar == true) {
                    final prayerTime = widget.time.substring(0, 5).split(':');
                    final hour = int.parse(prayerTime[0]);
                    final minute = int.parse(prayerTime[1]);
                    createPrayerTimeNotification(
                      4,
                      hour,
                      minute,
                      'Saatnya Adzan Ashar!',
                      'Selamat melaksanakan ibadah sholat Ashar:)',
                    );
                  } else {
                    cancelPrayerTimeNotification(4);
                  }
                });
              }),
        ),
      ),
    );
  }
}
