import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_wave/screens/news_details_screen.dart';

class CardImage extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String content;
  final String bottom;
  final String date;
  final String link;

  const CardImage({
    Key? key,
    required this.bottom,
    required this.image,
    required this.title,
    required this.author,
    required this.content,
    required this.date,
    required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailsScreen(
              image: image,
              content: content,
              desc: title,
              author: author,
              date: date,
              givenUrl: link,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        height:
            ScreenUtil().orientation == Orientation.portrait ? 0.3.sh : 0.5.sh,
        child: Stack(
          children: [
            _buildImage(),
            _buildOverlay(),
            _buildTextContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: image,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(
            Icons.hide_image_outlined,
          ),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(67, 67, 67, 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildTextContent() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            author,
            style: GoogleFonts.nunito(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.lora(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Text(
            bottom,
            style: GoogleFonts.nunito(
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
