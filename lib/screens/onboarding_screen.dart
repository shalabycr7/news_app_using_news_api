import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_wave/data/cubits/theme_cubit/cubit/theme_cubit.dart';
import 'package:news_wave/screens/home_screen.dart';
import 'package:news_wave/shared/snackbar.dart';
import 'package:news_wave/theme/color_schemes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  Widget _buildImage(String assetName, double width) {
    return SvgPicture.asset('assets/images/$assetName', width: width);
  }

  void requirePermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        sound: true,
        announcement: false,
        provisional: false);
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      showErrorSnackbar(context, "Notification permission is not granted");
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('title : ${message.notification?.title}');
      }
      if (kDebugMode) {
        print('body : ${message.notification?.body}');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    requirePermission();
  }

  @override
  Widget build(BuildContext context) {
    var bodyStyle = GoogleFonts.quicksand(
      fontSize: 13.sp,
    );

    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        final currentTheme = isDarkMode ? darkTheme : lightTheme;
        var pageDecoration = PageDecoration(
          titleTextStyle: GoogleFonts.quicksand(
              fontSize: 25.sp, fontWeight: FontWeight.w500),
          bodyTextStyle: bodyStyle,
          bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          pageColor: currentTheme.scaffoldBackgroundColor,
          imagePadding: EdgeInsets.zero,
        );

        return Theme(
          data: currentTheme,
          child: Scaffold(
            backgroundColor: currentTheme.scaffoldBackgroundColor,
            body: SafeArea(
              child: IntroductionScreen(
                key: introKey,
                globalBackgroundColor: currentTheme.scaffoldBackgroundColor,
                allowImplicitScrolling: true,
                autoScrollDuration: 5000,
                infiniteAutoScroll: true,
                pages: [
                  PageViewModel(
                    title: "World news",
                    body: "Get detailed news from all over the world.",
                    image: _buildImage('slider1.svg', 250.w),
                    decoration: pageDecoration,
                  ),
                  PageViewModel(
                    title: "See detailed info",
                    body: "Find all the info you want about what's new.",
                    image: _buildImage('slider2.svg', 250.w),
                    decoration: pageDecoration,
                  ),
                ],
                onDone: () => _onIntroEnd(context),
                onSkip: () => _onIntroEnd(context),
                showSkipButton: true,
                skipOrBackFlex: 0,
                nextFlex: 0,
                showBackButton: false,
                back: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.primary,
                ),
                skip: Text('Skip',
                    style: GoogleFonts.quicksand(
                        fontSize: 13.0.sp,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600)),
                next: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.primary,
                ),
                done: Text('Done',
                    style: GoogleFonts.quicksand(
                        fontSize: 13.0.sp,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600)),
                curve: Curves.fastLinearToSlowEaseIn,
                controlsMargin: const EdgeInsets.all(16),
                controlsPadding: kIsWeb
                    ? const EdgeInsets.all(12.0)
                    : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                dotsDecorator: DotsDecorator(
                  activeColor: Theme.of(context).colorScheme.primary,
                  size: const Size(10.0, 10.0),
                  activeSize: const Size(22.0, 10.0),
                  activeShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
