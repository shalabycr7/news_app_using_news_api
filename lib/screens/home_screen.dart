import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/cubits/all_news_cubit/cubit/all_news_cubit.dart';
import 'package:news_app/data/data.dart';
import 'package:news_app/data/repositories/all_news_repo.dart';
import 'package:news_app/screens/news_details_screen.dart';
import 'package:news_app/shared/news_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 224, 224, 224),
                          ),
                        ),
                        hintText: 'Dogecoin to the Moon...',
                        hintStyle: GoogleFonts.nunito(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 197, 194, 194),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 25,
                          ),
                          color: const Color.fromARGB(255, 197, 194, 194),
                          iconSize: 18,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: screenSize.width * (42 / 375),
                    height: screenSize.height * (43 / 812),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 255, 58, 68),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/icons/notify.svg',
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Latest News",
                          style: GoogleFonts.lora(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              AllNewsRepo().getAllNews();
                              context.read<AllNewsCubit>().getAllNews();
                            },
                            icon: const Icon(Icons.refresh_outlined))
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "See All",
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 128, 255),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {

                          },
                          child: const Icon(
                            Icons.arrow_forward_outlined,
                            size: 19,
                            color: Color.fromARGB(255, 0, 128, 255),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<AllNewsCubit, AllNewsState>(
                  builder: (context, state) {
                    if (state is AllNewsInitial) {
                      return const Center(
                        child: Text("press above button to get all news "),
                      );
                    } else if (state is AllNewsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AllNewsSuccess) {
                      return ListView.builder(
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return CardImage(
                            image: state.finalData.articles![index].urlToImage!,
                            title: state.finalData.articles![index].title!,
                            author: state.finalData.articles![index].author!,
                            bottom: state.finalData.articles![index].description!,
                            content: state.finalData.articles![index].content!,
                            date: state.finalData.articles![index].publishedAt!,
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
