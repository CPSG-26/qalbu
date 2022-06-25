import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/notifications.dart';
import 'package:qalbu/common/text_styles.dart';

class IsyaCard extends StatefulWidget {
  final String time;
  final String prayerSchedule;

  const IsyaCard(this.time, this.prayerSchedule, {Key? key}) : super(key: key);

  @override
  State<IsyaCard> createState() => _IsyaCardState();
}

class _IsyaCardState extends State<IsyaCard> {
  final switchData = GetStorage();
  bool isIsya = false;

  @override
  void initState() {
    super.initState();
    if (switchData.read('isIsya') != null) {
      setState(() {
        isIsya = switchData.read('isIsya');
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
              value: isIsya,
              onChanged: (value) {
                setState(() {
                  isIsya = value;
                  switchData.write('isIsya', isIsya);
                  if (isIsya == true) {
                    final prayerTime = widget.time.substring(0, 5).split(':');
                    final hour = int.parse(prayerTime[0]);
                    final minute = int.parse(prayerTime[1]);
                    createPrayerTimeNotification(
                      6,
                      hour,
                      minute,
                      'Saatnya Adzan Isya!',
                      'Selamat melaksanakan ibadah sholat Isya:)',
                    );
                  } else {
                    cancelPrayerTimeNotification(6);
                  }
                });
              }),
        ),
      ),
    );
  }
}
