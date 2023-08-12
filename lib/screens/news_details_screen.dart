import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_wave/data/cubits/theme_cubit/cubit/theme_cubit.dart';
import 'package:news_wave/theme/color_schemes.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  final String image;
  final String content;
  final String desc;
  final String author;
  final String date;
  final String givenUrl;

  const NewsDetailsScreen(
      {Key? key,
      required this.image,
      required this.content,
      required this.desc,
      required this.author,
      required this.date,
      required this.givenUrl})
      : super(key: key);

  Future<void> _launchUrl(String link) async {
    final Uri wantedUrl = Uri.parse(link);
    if (!await launchUrl(wantedUrl)) {
      throw Exception('Could not launch $wantedUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        final currentTheme = isDarkMode ? darkTheme : lightTheme;
        return Theme(
          data: currentTheme,
          child: Scaffold(
            backgroundColor: currentTheme.scaffoldBackgroundColor,
            floatingActionButton: FloatingActionButton(
                tooltip: 'Add to favorite',
                onPressed: () {
                  _launchUrl(givenUrl);
                },
                child: const Icon(
                  Icons.launch,
                  size: 30,
                )),
            body: SizedBox(
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      height: ScreenUtil().orientation == Orientation.portrait
                          ? 0.6.sh
                          : 0.5.sh,
                      width: ScreenUtil().screenWidth,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: ScreenUtil().orientation == Orientation.portrait
                        ? 0.46.sh
                        : 0.56.sh,
                    width: ScreenUtil().screenWidth,
                    padding: EdgeInsets.fromLTRB(
                        20,
                        ScreenUtil().orientation == Orientation.portrait
                            ? 0.12.sh
                            : 0.16.sh,
                        20,
                        0),
                    decoration: BoxDecoration(
                      color: currentTheme.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        content * 4,
                        overflow: TextOverflow.visible,
                        style: GoogleFonts.nunito(
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: ScreenUtil().orientation == Orientation.portrait
                        ? 0.44.sh
                        : 0.26.sh,
                    child: BlurryContainer(
                      width: 0.8.sw,
                      blur: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      height: ScreenUtil().orientation == Orientation.portrait
                          ? 0.2.sh
                          : 0.32.sh,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Text(
                            date,
                            style: GoogleFonts.nunito(
                              fontSize: 10.sp,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            desc,
                            style: GoogleFonts.lora(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "Published by $author",
                            style: GoogleFonts.nunito(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 55,
                    left: 15,
                    child: BlurryContainer(
                      blur: 50,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
