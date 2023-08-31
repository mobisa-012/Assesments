
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:store_mgt/core/cont/data_const.dart';
import 'package:store_mgt/core/cont/margins.dart';
import 'package:store_mgt/core/cont/text_const.dart';
import 'package:store_mgt/screens/login/email_login.dart';


class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController pageController;
  late int selectedPage;

  @override
  void initState() {
    super.initState();
    selectedPage = 0;
    pageController = PageController(initialPage: selectedPage);
  }

  @override
  Widget build(BuildContext context) {
    const pageCount = 3;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Expanded(
              child: PageView(
            controller: pageController,
            onPageChanged: (page) {
              setState(() {
                selectedPage = page;
              });
            },
            children: DataConstants.onboardingTiles,
          )),
          YMargin(y: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
                minimumSize: Size(MediaQuery.of(context).size.width /0.3, 55),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const EmailLogin()));
            },
            child:  Text(
              TextConstants.getStarted,
              style: TextStyle(fontSize: 20, color: Colors.grey[200]),
            ),
          ),         
          YMargin(y: 30),
          PageViewDotIndicator(
            count: pageCount,
            currentItem: selectedPage,
            selectedColor: Colors.purple,
            unselectedColor: Colors.limeAccent,
          ),
            ],
          ),
        ));
  }
}
