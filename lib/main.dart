import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/cubits/all_news_cubit/cubit/all_news_cubit.dart';
import 'package:news_app/data/cubits/theme_cubit/cubit/theme_cubit.dart';
import 'package:news_app/data/firebase_api.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/screens/onboarding_screen.dart';
import 'package:news_app/theme/color_schemes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool alreadySeen = prefs.getBool('alreadySeen') ?? false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FireBaseApi().intitNot();
  runApp(MyApp(alreadySeen: alreadySeen));
}

class MyApp extends StatelessWidget {
  final bool alreadySeen;

  const MyApp({super.key, required this.alreadySeen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllNewsCubit>(
          create: (context) => AllNewsCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News Wave',
            theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
            darkTheme:
                ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: alreadySeen ? const Home() : const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
