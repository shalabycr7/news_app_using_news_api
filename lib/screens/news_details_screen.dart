import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailsScreen extends StatelessWidget {
  final String image;
  final String content;
  final String desc;
  final String author;
  final String date;




  const NewsDetailsScreen({super.key,required this.image, required this.content, required this.desc, required this.author, required this.date});

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 58, 68),
        elevation: 0,
        onPressed: () {},
        child: SvgPicture.asset(
          'assets/icons/hart.svg',
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: screensize.width,
          height: screensize.height,
          child: Stack(children: [
            SizedBox(
              width: screensize.width,
              height: screensize.height * (0.6),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 120, left: 15, right: 15),
                  child: SingleChildScrollView(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'LONDON ',
                            style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 46, 5, 5),
                            ),
                          ),
                          TextSpan(
                            text:
                                content,
                            style: GoogleFonts.nunito(
                              fontSize: 15,
                              color: const Color.fromARGB(255, 46, 5, 5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: screensize.height * (281 / 812),
              left: screensize.width * (32 / 375),
              right: screensize.width * (32 / 375),
              child: BlurryContainer(
                width: screensize.width * 0.7,
                blur: 50,
                height: screensize.height * (171 / 812),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(date,
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 46, 5, 5),
                            )),
                        const Spacer(),
                        Text(
                            desc,
                            style: GoogleFonts.lora(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 46, 5, 5),
                            )),
                        const Spacer(),
                        Text(
                          "Published by $author",
                          style: GoogleFonts.nunito(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 46, 5, 5),
                          ),
                        )
                      ]),
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 15,
              child: BlurryContainer(
                blur: 150,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                    )),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
