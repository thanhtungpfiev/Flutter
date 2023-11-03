import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../core/theme/colors.dart';
import '../controllers/video_info_controller.dart';

class VideoInfoView extends GetView<VideoInfoController> {
  const VideoInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
          decoration: controller.playArea.value == false
              ? BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.gradientFirst.withOpacity(0.9),
                      AppColor.gradientSecond,
                    ],
                    begin: const FractionalOffset(0.0, 0.4),
                    end: Alignment.topRight,
                  ),
                )
              : BoxDecoration(
                  color: AppColor.gradientSecond,
                ),
          child: Obx(() {
            return Column(
              children: [
                controller.playArea.value == false
                    ? Container(
                        padding:
                            const EdgeInsets.only(top: 50, left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () => Get.back(),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 20,
                                    color: AppColor.secondPageIconColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                Icon(
                                  Icons.info_outline,
                                  size: 20,
                                  color: AppColor.secondPageIconColor,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Legs Toning',
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColor.secondPageTitleColor,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'and Glutes Workout',
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColor.secondPageTitleColor,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 90,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColor
                                            .secondPageContainerGradient1stColor,
                                        AppColor
                                            .secondPageContainerGradient2ndColor,
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.timer_outlined,
                                        size: 20,
                                        color: AppColor.secondPageIconColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '68 min',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.secondPageTitleColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 200,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColor
                                            .secondPageContainerGradient1stColor,
                                        AppColor
                                            .secondPageContainerGradient2ndColor,
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.handyman_outlined,
                                        size: 20,
                                        color: AppColor.secondPageIconColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Resistent band, kettebell',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.secondPageTitleColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : Container(
                        padding:
                            const EdgeInsets.only(top: 50, left: 10, right: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () => Get.back(),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 20,
                                    color: AppColor.secondPageIconColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                Icon(
                                  Icons.info_outline,
                                  size: 20,
                                  color: AppColor.secondPageIconColor,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            controller.controllerInitialized.value == true
                                ? AspectRatio(
                                    aspectRatio: controller
                                        .videoPlayerController
                                        .value
                                        .aspectRatio,
                                    child: VideoPlayer(
                                        controller.videoPlayerController),
                                  )
                                : const AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Text(
                                      'Preparing...',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white60),
                                    ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.fast_rewind,
                                    size: 36,
                                    color: Colors.white,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.handlePlayPauseButton();
                                  },
                                  child: Obx(() {
                                    return Icon(
                                      controller.isPlaying.value == true
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 36,
                                      color: Colors.white,
                                    );
                                  }),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.fast_forward,
                                    size: 36,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Circuit 1: Legs Toning',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.circuitsColor,
                              ),
                            ),
                            Expanded(child: Container()),
                            Row(
                              children: [
                                Icon(
                                  Icons.loop,
                                  size: 20,
                                  color: AppColor.loopColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '3 sets',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColor.setsColor,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Obx(() {
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              itemCount: controller.videoInfos.length,
                              itemBuilder: (_, index) {
                                return buildCard(index);
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
        );
      }),
    );
  }

  GestureDetector buildCard(int index) {
    return GestureDetector(
      onTap: () {
        controller.onTapVideo(index);
      },
      child: SizedBox(
        height: 135,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(
                            controller.videoInfos[index]['thumbnail']),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.videoInfos[index]['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        controller.videoInfos[index]['time'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFFeaeefc),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      '15 rest',
                      style: TextStyle(
                        color: Color(0xFF839fed),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (int i = 0; i < 70; i++)
                      i.isEven
                          ? Container(
                              width: 3,
                              height: 1,
                              decoration: BoxDecoration(
                                color: const Color(0xFF839fed),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            )
                          : Container(
                              width: 3,
                              height: 1,
                              color: Colors.white,
                            ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
