import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/text_styles.dart';
import 'package:qalbu/common/utils.dart';
import 'package:qalbu/firebase_options.dart';
import 'package:qalbu/injection.dart' as di;
import 'package:qalbu/presentation/bloc/doa_detail/doa_detail_bloc.dart';
import 'package:qalbu/presentation/bloc/doa_list/doa_list_bloc.dart';
import 'package:qalbu/presentation/bloc/favorite_doa/favorite_doa_bloc.dart';
import 'package:qalbu/presentation/bloc/prayer_time_daily/prayer_time_daily_bloc.dart';
import 'package:qalbu/presentation/bloc/prayer_time_monthly/prayer_time_monthly_bloc.dart';
import 'package:qalbu/presentation/bloc/quran/quran_bloc.dart';
import 'package:qalbu/presentation/bloc/quran_detail/quran_detail_bloc.dart';
import 'package:qalbu/presentation/pages/catatan_ibadah_page.dart';
import 'package:qalbu/presentation/pages/doa_detail_page.dart';
import 'package:qalbu/presentation/pages/doa_page.dart';
import 'package:qalbu/presentation/pages/favorite_doa_page.dart';
import 'package:qalbu/presentation/pages/home_page.dart';
import 'package:qalbu/presentation/pages/kiblat_page.dart';
import 'package:qalbu/presentation/pages/legal_page.dart';
import 'package:qalbu/presentation/pages/login_page.dart';
import 'package:qalbu/presentation/pages/prayer_time_page.dart';
import 'package:qalbu/presentation/pages/profile_page.dart';
import 'package:qalbu/presentation/pages/quran_detail_page.dart';
import 'package:qalbu/presentation/pages/quran_page.dart';
import 'package:qalbu/presentation/pages/register_page.dart';
import 'package:qalbu/presentation/pages/splash_screen.dart';
import 'package:qalbu/presentation/pages/tasbih_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AwesomeNotifications().initialize(
    'resource://drawable/res_app_icon',
    [
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        defaultColor: kPrimary,
        channelDescription: 'Scheduled Notifications',
        channelShowBadge: true,
        importance: NotificationImportance.High,
      )
    ],
  );
  await GetStorage.init();

  di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static const String title = 'Qalbu';

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out!');
        }
      } else {
        if (kDebugMode) {
          print('User is signed in!');
        }
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<QuranBloc>()),
        BlocProvider(create: (_) => di.locator<QuranDetailBloc>()),
        BlocProvider(create: (_) => di.locator<DoaListBloc>()),
        BlocProvider(create: (_) => di.locator<DoaDetailBloc>()),
        BlocProvider(create: (_) => di.locator<FavoriteDoaBloc>()),
        BlocProvider(create: (_) => di.locator<PrayerTimeMonthlyBloc>()),
        BlocProvider(create: (_) => di.locator<PrayerTimeDailyBloc>()),
      ],
      child: MaterialApp(
        title: MyApp.title,
        theme: ThemeData(
            colorScheme: kColorScheme,
            primaryColor: kPrimary,
            textTheme: kTextTheme,
            scaffoldBackgroundColor: Colors.white),
        home: FirebaseAuth.instance.currentUser == null
            ? const LoginPage()
            : const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case SplashScreen.routeName:
              return MaterialPageRoute(builder: (_) => const SplashScreen());
            case LoginPage.routeName:
              return MaterialPageRoute(builder: (_) => const LoginPage());
            case RegisterPage.routeName:
              return MaterialPageRoute(builder: (_) => const RegisterPage());
            case ProfilePage.routeName:
              return MaterialPageRoute(builder: (_) => const ProfilePage());
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case QuranPage.routeName:
              return MaterialPageRoute(builder: (_) => const QuranPage());
            case QuranDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(builder: (_) => QuranDetailPage(id: id));
            case TasbihPage.routeName:
              return MaterialPageRoute(builder: (_) => const TasbihPage());
            case DoaPage.routeName:
              return MaterialPageRoute(builder: (_) => const DoaPage());
            case FavoriteDoaPage.routeName:
              return MaterialPageRoute(builder: (_) => const FavoriteDoaPage());
            case DoaDetailPage.routeName:
              final id = settings.arguments as String;
              return MaterialPageRoute(
                  builder: (_) => DoaDetailPage(id: id), settings: settings);
            case KiblatPage.routeName:
              return MaterialPageRoute(builder: (_) => const KiblatPage());
            case CatatanIbadahPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const CatatanIbadahPage());
            case PrayerTimePage.routeName:
              return MaterialPageRoute(builder: (_) {
                PrayerTimePage argument = settings.arguments as PrayerTimePage;
                return PrayerTimePage(
                  lat: argument.lat,
                  long: argument.long,
                  month: argument.month,
                  year: argument.year,
                  currentAddress: argument.currentAddress,
                );
              });
            case LegalPage.routeName:
              return MaterialPageRoute(builder: (_) {
                LegalPage argument = settings.arguments as LegalPage;
                return LegalPage(
                  title: argument.title,
                  content: argument.content,
                );
              });
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
