import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/news_details_screen.dart';

class CardImage extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String content;

  final String bottom;
  final String date;

  const CardImage({
    super.key,
    required this.bottom,
    required this.image,
    required this.title,
    required this.author, required this.content, required this.date,
  });

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return SizedBox(
      width: screensize.width,
      height: screensize.height * (240 / 812),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: screensize.width,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  NewsDetailsScreen(image: image,content: content,desc: title,author: author,date:date ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(100, 67, 67, 67),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text('by $author',
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFFFFF),
                      )),
                  Text(title,
                      style: GoogleFonts.lora(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFFFFF),
                      )),
                  const Spacer(),
                  Text(bottom,
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFFFFF),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
