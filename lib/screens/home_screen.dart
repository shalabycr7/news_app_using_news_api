import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:news_wave/data/cubits/all_news_cubit/cubit/all_news_cubit.dart';
import 'package:news_wave/data/cubits/theme_cubit/cubit/theme_cubit.dart';
import 'package:news_wave/data/repositories/all_news_repo.dart';
import 'package:news_wave/shared/news_card.dart';
import 'package:news_wave/theme/color_schemes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _initialize(context);

    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        final currentTheme = isDarkMode ? darkTheme : lightTheme;
        return Theme(
          data: currentTheme,
          child: Scaffold(
            backgroundColor: currentTheme.scaffoldBackgroundColor,
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    _buildSearchBar(context),
                    SizedBox(height: 10.h),
                    _buildHeader(context),
                    SizedBox(height: 10.h),
                    _buildNewsList(context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _initialize(BuildContext context) async {
    _saveAlreadySeen();
    AllNewsRepo().getAllNews();
    context.read<AllNewsCubit>().getAllNews();
  }

  Future<void> _saveAlreadySeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('alreadySeen', true);
  }

  Widget _buildSearchBar(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              hintText: 'Search',
              hintStyle: GoogleFonts.nunito(
                fontSize: 12.sp,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                iconSize: 20,
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
              ),
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: IconButton(
            icon: Icon(
              Icons.light_mode_outlined,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            iconSize: 27,
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "Latest News",
              style: GoogleFonts.lora(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<AllNewsCubit>().getAllNews();
              },
              icon: const Icon(Icons.refresh_outlined),
              splashRadius: 18,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNewsList(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AllNewsCubit, AllNewsState>(
        builder: (context, state) {
          if (state is AllNewsInitial) {
            return const Center(
              child: Text("Press the refresh button to get all news"),
            );
          } else if (state is AllNewsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllNewsSuccess) {
            return ListView.builder(
              itemCount: state.finalData.totalResults,
              itemBuilder: (context, index) {
                return CardImage(
                  image: state.finalData.articles![index].urlToImage ??
                      'https://th.bing.com/th/id/R.f3dbaf93c4c0ebeade43b9282937c0c3?rik=jqMOujmrsFjrWw&pid=ImgRaw&r=0',
                  title: state.finalData.articles![index].title ?? "unknown",
                  author: state.finalData.articles![index].author ?? 'unknown',
                  bottom:
                      state.finalData.articles![index].description ?? 'unknown',
                  content: state.finalData.articles![index].content!,
                  date:
                      state.finalData.articles![index].publishedAt ?? 'unknown',
                );
              },
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Lottie.asset(
                    'assets/images/error_animation.json',
                    width: 200.w,
                  ),
                ),
                Expanded(
                  child: Text(
                    'An error has occurred',
                    style: GoogleFonts.quicksand(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
