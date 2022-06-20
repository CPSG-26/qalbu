import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qalbu/presentation/bloc/doa_list/doa_list_bloc.dart';
import 'package:qalbu/presentation/bloc/prayer_time_daily/prayer_time_daily_bloc.dart';
import 'package:qalbu/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:qalbu/presentation/widgets/doa_widget.dart';
import 'package:qalbu/presentation/widgets/menu_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentTime = DateFormat('dd-MM-yyyy H:m').format(DateTime.now());
  var date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  var nextDay = DateFormat('dd-MM-yyyy')
      .format(DateTime.now().add(const Duration(days: 1)));

  Position? _currentPosition;
  String? _currentAddress;
  String? prayerHours;
  String? prayerMinutes;
  String? prayerNext;

  int? days;
  int? hours;
  int? minutes;
  int? seconds;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DoaListBloc>().add(GetDoaListEvent());
    });
    _getCurrentLocation().whenComplete(() => Future.microtask(() {
          context.read<PrayerTimeDailyBloc>().add(FetchPrayerTimeDaily(
              date, _currentPosition!.latitude, _currentPosition!.longitude));
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
          final prayerTime = state.prayerTime.data;
          var apiDateShubuh =
              '${date.toString().substring(0, 10)} ${prayerTime.timings.imsak}';
          var apiDateDzuhur =
              '${date.toString().substring(0, 10)} ${prayerTime.timings.dhuhr}';
          var apiDateAshar =
              '${date.toString().substring(0, 10)} ${prayerTime.timings.asr}';
          var apiDateMaghrib =
              '${date.toString().substring(0, 10)} ${prayerTime.timings.maghrib}';
          var apiDateIsya =
              '${date.toString().substring(0, 10)} ${prayerTime.timings.isha}';

          var shubuh = DateFormat("dd-MM-yyyy hh:mm").parse(apiDateShubuh);
          var dzuhur = DateFormat("dd-MM-yyyy hh:mm").parse(apiDateDzuhur);
          var ashar = DateFormat("dd-MM-yyyy hh:mm").parse(apiDateAshar);
          var maghrib = DateFormat("dd-MM-yyyy hh:mm").parse(apiDateMaghrib);
          var isya = DateFormat("dd-MM-yyyy hh:mm").parse(apiDateIsya);
          var time = DateFormat("dd-MM-yyyy hh:mm").parse(currentTime);

          if (time.compareTo(shubuh) <= 0) {
            var upcomingPrayerTime = prayerTime.timings.fajr.split(':');
            prayerHours = upcomingPrayerTime[0];
            prayerMinutes = upcomingPrayerTime[1];
            prayerNext = 'Shubuh ${prayerTime.timings.fajr} WIB';
          } else if (time.compareTo(dzuhur) <= 0) {
            var upcomingPrayerTime = prayerTime.timings.dhuhr.split(':');
            prayerHours = upcomingPrayerTime[0];
            prayerMinutes = upcomingPrayerTime[1];
            prayerNext = 'Dzuhur ${prayerTime.timings.dhuhr} WIB';
          } else if (time.compareTo(ashar) <= 0) {
            var upcomingPrayerTime = prayerTime.timings.asr.split(':');
            prayerHours = upcomingPrayerTime[0];
            prayerMinutes = upcomingPrayerTime[1];
            prayerNext = 'Ashar ${prayerTime.timings.asr} WIB';
          } else if (time.compareTo(maghrib) <= 0) {
            var upcomingPrayerTime = prayerTime.timings.maghrib.split(':');
            prayerHours = upcomingPrayerTime[0];
            prayerMinutes = upcomingPrayerTime[1];
            prayerNext = 'Maghrib ${prayerTime.timings.maghrib} WIB';
          } else if (time.compareTo(isya) <= 0) {
            var upcomingPrayerTime = prayerTime.timings.isha.split(':');
            prayerHours = upcomingPrayerTime[0];
            prayerMinutes = upcomingPrayerTime[1];
            prayerNext = 'Isya ${prayerTime.timings.isha} WIB';
          } else {
            var upcomingPrayerTime = prayerTime.timings.fajr.split(':');
            prayerHours = upcomingPrayerTime[0];
            prayerMinutes = upcomingPrayerTime[1];
            prayerNext = 'Shubuh ${prayerTime.timings.fajr} WIB';
          }
          _getCountDown();
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: CustomSliverAppBarDelegate(
                    expandedHeight: 204,
                    nextPrayerTime: prayerNext ?? '-',
                    currentDate: prayerTime.date.readable,
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
                physics: NeverScrollableScrollPhysics(),
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

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Geolocator.getServiceStatusStream();
      await Geolocator.getCurrentPosition();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
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
    DateTime a = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      int.parse(prayerHours!),
      int.parse(prayerMinutes!),
    );
    DateTime b = DateTime.now();

    Duration difference = a.difference(b);

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
