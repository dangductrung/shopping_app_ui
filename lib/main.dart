import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/pages/Signup/Signup.dart';
import 'package:shopping_app/pages/home/home.dart';
import 'package:shopping_app/pages/signin/signin.dart';
import 'package:shopping_app/pages/splash/splash_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'pages/bottom_bar/bottombar.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // config injector
  await setupInjector();
  // config timeago
  setupTimeAgo();

  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  await runZonedGuarded<Future<void>>(() async {
    runApp(EasyLocalization(
      // ignore: prefer_const_literals_to_create_immutables
      supportedLocales: [const Locale('en'), const Locale('vi')],
      path: 'assets/lang',
      fallbackLocale: const Locale('vi'),
      useOnlyLangCode: true,
      child: MyApp(),
    ));
  }, FirebaseCrashlytics.instance.recordError);
}

void setupTimeAgo() {
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  timeago.setLocaleMessages('vi_short', timeago.ViShortMessages());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 400),
        title: 'Shopping',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        navigatorKey: navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        // localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        //   DefaultMaterialLocalizations.delegate,
        //   DefaultWidgetsLocalizations.delegate,
        // ],
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: SplashScreen(),
        builder: (context, child) => FlutterEasyLoading(child: child),
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();
  bool isFirst = true;

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
    if (isFirst) {
      isFirst = false;
      WidgetsBinding.instance.addPostFrameCallback((_) => restartApp());
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
