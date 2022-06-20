import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/text_styles.dart';
import 'package:qalbu/presentation/bloc/prayer_time_monthly/prayer_time_monthly_bloc.dart';
import 'package:qalbu/presentation/widgets/prayer_time_list.dart';

class PrayerTimePage extends StatefulWidget {
  static const routeName = 'jadwal-sholat';

  final double lat;
  final double long;
  final int month;
  final int year;
  final String currentAddress;

  const PrayerTimePage({
    Key? key,
    required this.lat,
    required this.long,
    required this.month,
    required this.year,
    required this.currentAddress,
  }) : super(key: key);

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PrayerTimeMonthlyBloc>().add(FetchPrayerTimeMonthly(
          widget.lat, widget.long, widget.month, widget.year));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Sholat'),
        elevation: 0,
      ),
      body: Center(
        child: BlocBuilder<PrayerTimeMonthlyBloc, PrayerTimeMonthlyState>(
          builder: (context, state) {
            if (state is PrayerTimeMonthlyLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PrayerTimeMonthlyHasData) {
              return Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(16),
                    child: ListTile(
                      title: Text(
                        'Lokasi Anda',
                        style: kSubtitle.copyWith(color: kSecondaryTextColor),
                      ),
                      leading: const Icon(
                        Icons.location_on,
                        size: 32,
                        color: kSecondary,
                      ),
                      subtitle: Text(widget.currentAddress,
                          style: kHeading6.copyWith(color: kTextColor)),
                    ),
                  ),
                  Expanded(
                      child: PrayerTimeList(jadwal: state.prayerTimeList.data)),
                ],
              );
            } else {
              return const Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
