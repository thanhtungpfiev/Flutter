import 'dart:math';

import 'package:app03/pages/all_words_page.dart';
import 'package:app03/pages/control_page.dart';
import 'package:app03/values/share_keys.dart';
import 'package:app03/widgets/app_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'package:app03/values/app_assets.dart';
import 'package:app03/values/app_colors.dart';
import 'package:app03/values/app_styles.dart';
import 'package:app03/models/english_today.dart';
import 'package:app03/packages/quote/quote_model.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../packages/quote/quote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _len = 5;
  late final PageController _pageController;

  List<EnglishToday> words = [];

  String quoteTitle = Quotes().getRandom().content ?? "";

  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        ++count;
      }
    }
    return newList;
  }

  void getEnglishToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKeys.counter) ?? 5;
    if (_len != len || words.isEmpty) {
      _len = len;
      List<String> newList = [];
      List<int> rans = fixedListRandom(len: len, max: nouns.length);
      for (var index in rans) {
        newList.add(nouns[index]);
      }
      setState(() {
        words = newList.map((e) => getQuote(e)).toList();
      });
    }
  }

  EnglishToday getQuote(String noun) {
    Quote? quote = Quotes().getByWord(noun);
    return EnglishToday(noun: noun, quote: quote?.content, id: quote?.id);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        title: Text(
          'English today',
          style:
              AppStyles.h3.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppAssets.menu),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            // Quote Title
            Container(
                height: size.height * 1 / 10,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.centerLeft,
                child: Text('"$quoteTitle"',
                    style: AppStyles.h5
                        .copyWith(fontSize: 12, color: AppColors.textColor))),
            // Card
            SizedBox(
              height: size.height * 2 / 3,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: words.length > 5 ? 6 : words.length,
                  itemBuilder: (context, index) {
                    String? firstLetter = words[index].noun?[0];
                    String? leftLetters = words[index]
                        .noun
                        ?.substring(1, words[index].noun?.length);
                    String quote = words[index].quote ?? '';
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        elevation: 4,
                        color: AppColors.primaryColor,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: index >= 5
                              ? InkWell(
                                  //Show More Card
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllWordsPage(words: words)));
                                  },
                                  child: Center(
                                      child: Text('Show more...',
                                          style: AppStyles.h3.copyWith(
                                              shadows: [
                                                const BoxShadow(
                                                    color: Colors.black38,
                                                    offset: Offset(3, 6),
                                                    blurRadius: 6)
                                              ]))),
                                )
                              : Column(
                                  // Normal Card
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Heart Icon
                                    LikeButton(
                                      onTap: (bool isLiked) async {
                                        setState(() {
                                          words[index].isFavorite =
                                              !words[index].isFavorite;
                                        });
                                        return words[index].isFavorite;
                                      },
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      size: 42,
                                      isLiked: words[index].isFavorite,
                                      circleColor: const CircleColor(
                                          start: Color(0xff00ddff),
                                          end: Color(0xff0099cc)),
                                      bubblesColor: const BubblesColor(
                                        dotPrimaryColor: Color(0xff33b5e5),
                                        dotSecondaryColor: Color(0xff0099cc),
                                      ),
                                      likeBuilder: (bool isLiked) {
                                        return ImageIcon(
                                          const AssetImage(AppAssets.heart),
                                          color: isLiked
                                              ? Colors.red
                                              : Colors.white,
                                          size: 42,
                                        );
                                      },
                                    ),
                                    RichText(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: firstLetter,
                                            style: const TextStyle(
                                                fontFamily: FontFamily.sen,
                                                fontSize: 89,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  BoxShadow(
                                                      color: Colors.black38,
                                                      offset: Offset(3, 6),
                                                      blurRadius: 6)
                                                ]),
                                            children: [
                                              TextSpan(
                                                  text: leftLetters,
                                                  style: const TextStyle(
                                                    fontSize: 56,
                                                  )),
                                            ])),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 24.0),
                                      child: SizedBox(
                                        height: size.height * 1 / 3,
                                        child: AutoSizeText(
                                          '"$quote"',
                                          style: AppStyles.h4.copyWith(
                                            letterSpacing: 1,
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    );
                  }),
            ),

            // Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                height: size.height * 1 / 11,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) =>
                          buildIndicator(index == _currentIndex, size)),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          setState(() {
            getEnglishToday();
          });
        },
        child: Image.asset(AppAssets.exchange),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.lightBlue,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 16.0),
              child: Text(
                'Your mind',
                style: AppStyles.h3.copyWith(color: AppColors.textColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: AppButton(
                  label: 'Favorites',
                  onTap: () {
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: AppButton(
                  label: 'Your control',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ControlPage())).then((value) {
                      setState(() {
                        getEnglishToday();
                      });
                    });
                  }),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColors.lightBlue : AppColors.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }

  Widget buildShowMore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      alignment: Alignment.centerLeft,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        elevation: 4,
        color: AppColors.primaryColor,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AllWordsPage(words: words)));
          },
          splashColor: Colors.black38,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Show more',
              style: AppStyles.h5.copyWith(color: AppColors.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
