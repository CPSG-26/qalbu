import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qalbu/domain/entities/datum.dart';
import 'package:qalbu/presentation/bloc/doa_list/doa_list_bloc.dart';
import 'package:qalbu/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:qalbu/presentation/widgets/doa_widget.dart';
import 'package:qalbu/presentation/widgets/menu_widget.dart';

import '../bloc/prayer_time_daily/prayer_time_daily_bloc.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentTime = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
  var date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  var nextDay = DateFormat('dd-MM-yyyy')
      .format(DateTime.now().add(const Duration(days: 1)));

  late Datum data;
  Position? _currentPosition;
  String? _currentAddress;
  String? prayerHours;
  String? prayerMinutes;
  String? prayerNext;

  late Duration difference;
  int? days;
  int? hours;
  int? minutes;
  int? seconds;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {});
    _getCurrentLocation().whenComplete(() => Future.microtask(() {
          context.read<PrayerTimeDailyBloc>().add(FetchPrayerTimeDaily(
              date, _currentPosition!.latitude, _currentPosition!.longitude));
          context.read<DoaListBloc>().add(GetDoaListEvent());
        }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimeDailyBloc, PrayerTimeDailyState>(
      builder: (context, state) {
        if (state is PrayerTimeDailyEmpty) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is PrayerTimeDailyLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is PrayerTimeDailyHasData) {
          data = state.prayerTime.data;
          _getCountDown();
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: CustomSliverAppBarDelegate(
                    expandedHeight: 204,
                    nextPrayerTime: prayerNext ?? '-',
                    currentDate: data.date.readable,
                    currentAddress: _currentAddress ?? '-',
                    hours: hours!,
                    minutes: minutes!,
                    seconds: seconds!,
                  ),
                  pinned: true,
                ),
                buildSliver(context)
              ],
            ),
          );
        } else {
          return const Text('Failed');
        }
      },
    );
  }

  Widget buildSliver(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 56, right: 8, bottom: 8, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MenuWidget(
              lat: _currentPosition!.latitude,
              long: _currentPosition!.longitude,
              currentAdress: _currentAddress ?? '-',
            ),
            const SizedBox(height: 4),
            Text(
              'Rekomendasi Doa',
              style: GoogleFonts.poppins(
                  fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            SizedBox(
              height: 600,
              child: buildDoaRecommendation(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDoaRecommendation(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DoaListBloc, DoaListState>(
        builder: (context, state) {
          if (state is DoaListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DoaListLoaded) {
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final doa = state.result[index];
                  return DoaWidget(doa);
                },
                itemCount: 10,
              ),
            );
          } else if (state is DoaListEmpty) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            );
          } else if (state is DoaListError) {
            return Center(
              key: const Key('error_message'),
              child: Text(
                state.message,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.getServiceStatusStream();
      await Geolocator.getCurrentPosition();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _currentPosition = position;
      _getAddressFromLatLng();
    });
  }

  void _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = place.subAdministrativeArea!;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _getCountDown() {
    var apiDateShubuh =
        '${date.toString().substring(0, 10)} ${data.timings.imsak}';
    var apiDateDzuhur =
        '${date.toString().substring(0, 10)} ${data.timings.dhuhr}';
    var apiDateAshar =
        '${date.toString().substring(0, 10)} ${data.timings.asr}';
    var apiDateMaghrib =
        '${date.toString().substring(0, 10)} ${data.timings.maghrib}';
    var apiDateIsya =
        '${date.toString().substring(0, 10)} ${data.timings.isha}';

    DateTime now = DateFormat("dd-MM-yyyy HH:mm").parse(currentTime);
    DateTime shubuh = DateFormat("dd-MM-yyyy HH:mm").parse(apiDateShubuh);
    DateTime dzuhur = DateFormat("dd-MM-yyyy HH:mm").parse(apiDateDzuhur);
    DateTime ashar = DateFormat("dd-MM-yyyy HH:mm").parse(apiDateAshar);
    DateTime maghrib = DateFormat("dd-MM-yyyy HH:mm").parse(apiDateMaghrib);
    DateTime isya = DateFormat("dd-MM-yyyy HH:mm").parse(apiDateIsya);

    if (now.isBefore(shubuh)) {
      var upcomingPrayerTime = data.timings.fajr.split(':');
      prayerHours = upcomingPrayerTime[0];
      prayerMinutes = upcomingPrayerTime[1];
      prayerNext = 'Shubuh ${data.timings.fajr}';
    } else if (now.isBefore(dzuhur) && now.isAfter(shubuh)) {
      var upcomingPrayerTime = data.timings.dhuhr.split(':');
      prayerHours = upcomingPrayerTime[0];
      prayerMinutes = upcomingPrayerTime[1];
      prayerNext = 'Dzuhur ${data.timings.dhuhr}';
    } else if (now.isBefore(ashar) && now.isAfter(dzuhur)) {
      var upcomingPrayerTime = data.timings.asr.split(':');
      prayerHours = upcomingPrayerTime[0];
      prayerMinutes = upcomingPrayerTime[1];
      prayerNext = 'Ashar ${data.timings.asr}';
    } else if (now.isBefore(maghrib) && now.isAfter(ashar)) {
      var upcomingPrayerTime = data.timings.maghrib.split(':');
      prayerHours = upcomingPrayerTime[0];
      prayerMinutes = upcomingPrayerTime[1];
      prayerNext = 'Maghrib ${data.timings.maghrib}';
    } else if (now.isBefore(isya) && now.isAfter(maghrib)) {
      var upcomingPrayerTime = data.timings.isha.split(':');
      prayerHours = upcomingPrayerTime[0];
      prayerMinutes = upcomingPrayerTime[1];
      prayerNext = 'Isya ${data.timings.isha}';
    } else {
      var upcomingPrayerTime = data.timings.fajr.split(':');
      prayerHours = upcomingPrayerTime[0];
      prayerMinutes = upcomingPrayerTime[1];
      prayerNext = 'Shubuh ${data.timings.fajr}';
    }

    DateTime a = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(prayerHours ?? '0'),
      int.parse(prayerMinutes ?? '0'),
    );

    difference = a.difference(now);

    days = difference.inDays;
    hours = difference.inHours % 24;
    minutes = difference.inMinutes % 60;
    seconds = difference.inSeconds % 60;

    if (kDebugMode) {
      print(
          "$days day(s) $hours hour(s) $minutes minute(s) $seconds second(s).");
    }
  }
}
