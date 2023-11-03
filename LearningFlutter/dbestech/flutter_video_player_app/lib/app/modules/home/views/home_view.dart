import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Training',
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColor.homePageTitle,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                  color: AppColor.homePageIcons,
                ),
                const SizedBox(
                  width: 7,
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 15,
                  color: AppColor.homePageIcons,
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: AppColor.homePageIcons,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  'Your program',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColor.homePageSubtitle,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.homePageDetail,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.VIDEO_INFO),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 15,
                    color: AppColor.homePageIcons,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(5, 10),
                    blurRadius: 20,
                    color: AppColor.gradientSecond.withOpacity(0.3),
                  )
                ],
                gradient: LinearGradient(
                  colors: [
                    AppColor.gradientFirst.withOpacity(0.8),
                    AppColor.gradientSecond.withOpacity(0.9),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next workout',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.homePageContainerTextSmall,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Legs Toning',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.homePageContainerTextSmall,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'and Glutes Workout',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.homePageContainerTextSmall,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 15,
                              color: AppColor.homePageContainerTextSmall,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '60 min',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.homePageContainerTextSmall,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.gradientFirst,
                                blurRadius: 10,
                                offset: const Offset(4, 8),
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.play_circle_fill,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 160,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20),
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/card.jpg'),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40,
                          offset: const Offset(8, 10),
                          color: AppColor.gradientSecond.withOpacity(0.3),
                        ),
                        BoxShadow(
                          blurRadius: 10,
                          offset: const Offset(-1, -5),
                          color: AppColor.gradientSecond.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    margin: const EdgeInsets.only(right: 200, bottom: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/figure.png'),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    margin: const EdgeInsets.only(left: 140, top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your are doing great',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.homePageDetail),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Keep it up\n',
                            style: TextStyle(
                                color: AppColor.homePagePlanColor,
                                fontSize: 16),
                            children: const [
                              TextSpan(text: 'stick to your plan'),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'Area of focus',
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColor.homePageTitle,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(() {
                return OverflowBox(
                  maxWidth: MediaQuery.of(context).size.width,
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(
                        controller.infos.length,
                        (index) => Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          margin: const EdgeInsets.only(
                              left: 10, bottom: 10, top: 10),
                          height: 150,
                          width: (MediaQuery.of(context).size.width - 30) / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(controller.infos[index]['img']),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                offset: const Offset(3, 3),
                                color: AppColor.gradientSecond.withOpacity(0.1),
                              ),
                              BoxShadow(
                                blurRadius: 3,
                                offset: const Offset(-3, -3),
                                color: AppColor.gradientSecond.withOpacity(0.1),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                controller.infos[index]['title'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColor.homePageDetail,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
