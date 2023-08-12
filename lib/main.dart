import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_wave/data/cubits/all_news_cubit/cubit/all_news_cubit.dart';
import 'package:news_wave/data/cubits/theme_cubit/cubit/theme_cubit.dart';
import 'package:news_wave/screens/home_screen.dart';
import 'package:news_wave/screens/onboarding_screen.dart';
import 'package:news_wave/theme/color_schemes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool alreadySeen = prefs.getBool('alreadySeen') ?? false;
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
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (BuildContext context, Widget? child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'News Wave',
                theme: isDarkMode ? darkTheme : lightTheme,
                home: alreadySeen ? const Home() : const OnBoardingScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
