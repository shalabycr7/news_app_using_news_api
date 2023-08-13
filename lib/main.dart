import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_wave/data/cubits/all_news_cubit/cubit/all_news_cubit.dart';
import 'package:news_wave/data/cubits/theme_cubit/cubit/theme_cubit.dart';
import 'package:news_wave/data/repositories/all_news_repo.dart';
import 'package:news_wave/firebase_options.dart';
import 'package:news_wave/screens/home_screen.dart';
import 'package:news_wave/screens/onboarding_screen.dart';
import 'package:news_wave/theme/color_schemes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final prefs = await SharedPreferences.getInstance();
  final alreadySeen = prefs.getBool('alreadySeen') ?? false;

  runApp(MyApp(alreadySeen: alreadySeen));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(message);
  }
}

class MyApp extends StatelessWidget {
  final bool alreadySeen;

  const MyApp({Key? key, required this.alreadySeen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllNewsCubit>(create: (_) => AllNewsCubit(AllNewsRepo())),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit(false)),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, _) {
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
