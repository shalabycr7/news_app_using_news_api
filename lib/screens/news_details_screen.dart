import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailsScreen extends StatelessWidget {
  final String image;
  final String content;
  final String desc;
  final String author;
  final String date;

  const NewsDetailsScreen({
    Key? key,
    required this.image,
    required this.content,
    required this.desc,
    required this.author,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add to favorite',
        onPressed: () {},
        child: SvgPicture.asset(
          'assets/icons/hart.svg',
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: 0,
                child: SizedBox(
                  height: (0.35).sh,
                  width: ScreenUtil().screenWidth,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: (0.65).sh,
                width: ScreenUtil().screenWidth,
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    content,
                    style: GoogleFonts.nunito(
                      fontSize: 13.sp,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0.2.sh,
                child: BlurryContainer(
                  width: 0.8.sw,
                  blur: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                top: 15,
                left: 15,
                child: BlurryContainer(
                  blur: 50,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
