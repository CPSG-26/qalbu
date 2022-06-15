import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/text_styles.dart';
import 'package:qalbu/common/utils.dart';
import 'package:qalbu/injection.dart' as di;
import 'package:qalbu/presentation/bloc/quran/quran_bloc.dart';
import 'package:qalbu/presentation/bloc/quran_detail/quran_detail_bloc.dart';
import 'package:qalbu/presentation/pages/catatan_ibadah_page.dart';
import 'package:qalbu/presentation/pages/home_page.dart';
import 'package:qalbu/presentation/pages/doa_page.dart';
import 'package:qalbu/presentation/pages/quran_detail_page.dart';
import 'package:qalbu/presentation/pages/quran_page.dart';
import 'package:qalbu/presentation/pages/splash_screen.dart';
import 'package:qalbu/presentation/pages/tasbih_page.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

final routes = <String, WidgetBuilder>{
  ListDoaPage.routeName: (context) => const ListDoaPage(),
  DoaPage.routeName: (context) => const DoaPage(),
  CatatanIbadahPage.routeName: (context) => const CatatanIbadahPage(),
};

class MyApp extends StatelessWidget {
  static const String title = 'Qalbu';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<QuranBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<QuranDetailBloc>(),
        ),
      ],
      child: MaterialApp(
        title: title,
        theme: ThemeData(
            colorScheme: kColorScheme,
            primaryColor: kPrimary,
            textTheme: kTextTheme,
            scaffoldBackgroundColor: Colors.white),
        home: const SplashScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case SplashScreen.routeName:
              return MaterialPageRoute(builder: (_) => const SplashScreen());
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case QuranPage.routeName:
              return MaterialPageRoute(builder: (_) => const QuranPage());
            case QuranDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(builder: (_) => QuranDetailPage(id: id));
            case TasbihPage.routeName:
              return MaterialPageRoute(builder: (_) => const TasbihPage());
            case ListDoaPage.routeName:
              return MaterialPageRoute(builder: (_) => const ListDoaPage());
            case DoaPage.routeName:
              return MaterialPageRoute(builder: (_) => const DoaPage());
            case CatatanIbadahPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const CatatanIbadahPage());
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
