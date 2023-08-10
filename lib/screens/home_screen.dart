import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/cubits/all_news_cubit/cubit/all_news_cubit.dart';
import 'package:news_app/data/cubits/theme_cubit/cubit/theme_cubit.dart';
import 'package:news_app/data/data.dart';
import 'package:news_app/data/repositories/all_news_repo.dart';
import 'package:news_app/shared/news_card.dart';
import 'package:news_app/theme/color_schemes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _saveAlreadySeen();
  }

  Future<void> _saveAlreadySeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('alreadySeen', true);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return Theme(
          data: isDarkMode
              ? ThemeData.from(colorScheme: darkColorScheme)
              : ThemeData.from(colorScheme: lightColorScheme),
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                borderSide: const BorderSide(),
                              ),
                              hintText: 'Dogecoin to the Moon...',
                              hintStyle: GoogleFonts.nunito(
                                fontSize: 12,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  size: 25,
                                ),
                                iconSize: 18,
                                onPressed: () {
                                  context.read<ThemeCubit>().toggleTheme();
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: screenSize.width * (42 / 375),
                          height: screenSize.height * (43 / 812),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
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
                                onTap: () {},
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
                              child: Text(
                                  "Press the refresh button to get all news"),
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
                                  image: state
                                      .finalData.articles![index].urlToImage!,
                                  title:
                                      state.finalData.articles![index].title!,
                                  author:
                                      state.finalData.articles![index].author!,
                                  bottom: state
                                      .finalData.articles![index].description!,
                                  content:
                                      state.finalData.articles![index].content!,
                                  date: state
                                      .finalData.articles![index].publishedAt!,
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
          ),
        );
      },
    );
  }
}
