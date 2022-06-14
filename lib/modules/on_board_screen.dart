import 'package:flutter/material.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/components/component.dart';
import '../shared/network/local/cache_helper.dart';
import '../styles/constant.dart';

class PageViewItems {
  String? image;
  String? title;
  String? body;

  PageViewItems({
    required this.image,
    required this.title,
    required this.body,
  }) {}
}

List<PageViewItems> PageViewList = [
  PageViewItems(
    image: 'assets/images/on_boarding_1.png',
    title: 'Screen 1',
    body: 'Body 1',
  ),
  PageViewItems(
    image: 'assets/images/on_boarding_2.png',
    title: 'Screen 2',
    body: 'Body 2',
  ),
  PageViewItems(
    image: 'assets/images/on_boarding_3.png',
    title: 'Screen 3',
    body: 'Body 3',
  ),
];

class OnBoardScreen extends StatefulWidget {
  OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value == true) {
        NavigateAndFinsh(context: context, screen: Login_Screen());
        print(value);
      }
    });
  }

  var boardController = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
            child: const Text(
              'SKIP',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int? index) {
                  if (index == PageViewList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print('last');
                  } else {
                    isLast = false;
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: ((context, index) =>
                    buildBoardingItem(PageViewList[index])),
                itemCount: 3,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: PageViewList.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    expansionFactor: 4,
                    activeDotColor: defaultColor,
                    spacing: 5.0,
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(microseconds: 750),
                        curve: Curves.bounceOut,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(PageViewItems model) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                '${model.image}',
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            '${model.title}',
            style: const TextStyle(
              fontSize: 35.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            '${model.body}',
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      );
}
