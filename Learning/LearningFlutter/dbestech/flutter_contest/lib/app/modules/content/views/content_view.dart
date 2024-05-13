import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/content_controller.dart';

class ContentView extends GetView<ContentController> {
  const ContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 70),
        color: const Color(0xFFc5e5f3),
        child: Column(
          children: [
            //james smith
            Container(
              width: width,
              height: 100,
              margin: const EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFebf8fd),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/img/background.jpg"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "James Smith",
                          style: TextStyle(
                              color: Color(0xFF3b3f42),
                              fontSize: 18,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Top Level",
                          style: TextStyle(
                              color: Color(0xFFfdebb2),
                              fontSize: 12,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFf3fafc)),
                      child: const Center(
                        child: Icon(
                          Icons.notifications,
                          color: Color(0xFF69c5df),
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            //popular contest
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                children: [
                  const Text(
                    "Popular Contest",
                    style: TextStyle(
                        color: Color(0xFF1f2326),
                        fontSize: 20,
                        decoration: TextDecoration.none),
                  ),
                  Expanded(child: Container()),
                  const Text(
                    "Show all",
                    style: TextStyle(
                        color: Color(0xFFcfd5b3),
                        fontSize: 15,
                        decoration: TextDecoration.none),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFfdc33c)),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //list
            SizedBox(
              height: 180,
              child: Obx(() {
                return PageView.builder(
                    controller: PageController(viewportFraction: 0.88),
                    itemCount: controller.details.length,
                    itemBuilder: (_, i) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.detail, arguments: {
                            'name': controller.details[i]['name'],
                            'title': controller.details[i]['title'],
                            'text': controller.details[i]['text'],
                            'img': controller.details[i]['img'],
                            'time': controller.details[i]['time'],
                            'prize': controller.details[i]['prize'],
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          height: 220,
                          width: MediaQuery.of(context).size.width - 20,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: i.isEven
                                  ? const Color(0xFF69c5df)
                                  : const Color(0xFF9294cc)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    controller.details[i]['title'],
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Expanded(child: Container())
                                ],
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: width,
                                child: Text(
                                  controller.details[i]['text'],
                                  style: const TextStyle(
                                      fontSize: 12, color: Color(0xFFb8eefc)),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                thickness: 1.0,
                              ),
                              Row(children: [
                                for (int i = 0; i < 4; i++)
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/${controller.details[i]['img']}"),
                                              fit: BoxFit.cover)),
                                    ),
                                  )
                              ]),
                            ],
                          ),
                        ),
                      );
                    });
              }),
            ),
            const SizedBox(
              height: 30,
            ),
            //recent contests
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                children: [
                  const Text(
                    "Recent Contests",
                    style: TextStyle(
                        color: Color(0xFF1f2326),
                        fontSize: 20,
                        decoration: TextDecoration.none),
                  ),
                  Expanded(child: Container()),
                  const Text(
                    "Show all",
                    style: TextStyle(
                        color: Color(0xFFcfd5b3),
                        fontSize: 15,
                        decoration: TextDecoration.none),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFfdc33c)),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.recentContest);
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.recents.length,
                      itemBuilder: (_, i) {
                        return Container(
                          width: width,
                          height: 60,
                          margin: const EdgeInsets.only(
                              left: 25, right: 25, bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFebf8fd),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(
                                      "assets/${controller.recents[i]['img']}"),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.recents[i]['status'],
                                      style: const TextStyle(
                                          color: Colors.orange,
                                          fontSize: 12,
                                          decoration: TextDecoration.none),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        controller.recents[i]['text'],
                                        style: const TextStyle(
                                            color: Color(0xFF3b3f42),
                                            fontSize: 12,
                                            decoration: TextDecoration.none),
                                      ),
                                    )
                                  ],
                                ),
                                Expanded(child: Container()),
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Text(
                                    controller.recents[i]['time'],
                                    style: const TextStyle(
                                        fontSize: 10,
                                        decoration: TextDecoration.none,
                                        color: Color(0xFFb2b8bb)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
