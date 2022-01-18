import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/dio_helper.dart';
import 'package:news_app/cache_helper.dart';
import 'package:news_app/home_page.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //main() >> async

  DioHelper.init();

  await CacheHelper.init();
  bool isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp(this.isDark, {Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()..getBusiness(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit()..changeAppMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<ThemeCubit, ThemeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                color: Colors.white60,
                centerTitle: true,
                actionsIconTheme: IconThemeData(color: Colors.brown),
                titleTextStyle: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.brown,
                    statusBarIconBrightness: Brightness.light),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white70,
                elevation: 25.0,
                selectedItemColor: Colors.brown,
                unselectedItemColor: Colors.black26,
              ),
              primarySwatch: Colors.brown,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              textTheme: const TextTheme(
                  bodyText1: TextStyle(color: Colors.white70),
                  bodyText2: TextStyle(color: Colors.white70),
                  subtitle1: TextStyle(color: Colors.white70)),
              appBarTheme: const AppBarTheme(
                color: Colors.white12,
                centerTitle: true,
                actionsIconTheme: IconThemeData(color: Colors.brown),
                titleTextStyle: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                    statusBarIconBrightness: Brightness.light),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white12,
                elevation: 25.0,
                selectedItemColor: Colors.brown,
                unselectedItemColor: Colors.white70,
              ),
              primarySwatch: Colors.brown,
            ),
            themeMode: isLightMode ? ThemeMode.light : ThemeMode.dark,
            home: const Directionality(
                textDirection: TextDirection.rtl, child: HomePage()),
          );
        },
      ),
    );
  }
}
