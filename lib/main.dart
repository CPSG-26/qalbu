import 'package:flutter/material.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/common/utils.dart';
import 'package:qalbu/presentation/pages/doa_page.dart';
import 'package:qalbu/presentation/pages/home_page.dart';
import 'package:qalbu/presentation/pages/list_doa_page.dart';
import 'package:qalbu/presentation/pages/splash_screen.dart';
import 'package:qalbu/presentation/pages/tasbih_page.dart';

void main() {
  runApp(const MyApp());
}

final routes = <String, WidgetBuilder>{
  ListDoaPage.routeName: (context) => const ListDoaPage(),
  DoaPage.routeName: (context) => const DoaPage()
};

class MyApp extends StatelessWidget {
  static const String title = 'Qalbu';
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          case TasbihPage.routeName:
            return MaterialPageRoute(builder: (_) => const TasbihPage());
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
    );
  }
}
