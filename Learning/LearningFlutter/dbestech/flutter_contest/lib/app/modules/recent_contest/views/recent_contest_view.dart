import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../content/controllers/content_controller.dart';
import '../controllers/recent_contest_controller.dart';

class RecentContestView extends GetView<RecentContestController> {
  const RecentContestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final contentController = Get.find<ContentController>();
    return Scaffold(
      backgroundColor: const Color(0xffCBE6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xff69C5DF),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 4,
            itemBuilder: (_, i) {
              return GestureDetector(
                child: Container(
                  width: width,
                  height: 60,
                  margin:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFebf8fd),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Obx(() {
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(
                                "assets/${contentController.recents[i]['img']}"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contentController.recents[i]['status'],
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
                                  contentController.recents[i]['text'],
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
                              contentController.recents[i]['time'],
                              style: const TextStyle(
                                  fontSize: 10,
                                  decoration: TextDecoration.none,
                                  color: Color(0xFFb2b8bb)),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
