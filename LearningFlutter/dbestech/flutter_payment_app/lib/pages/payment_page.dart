import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/colors.dart';
import '../widgets/buttons.dart';
import '../widgets/large_button.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/paymentbackground.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: h * 0.14,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/success.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const Text(
              'Success !',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.mainColor,
              ),
            ),
            Text(
              'Payment is completed for 2 bills',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColor.idColor,
              ),
            ),
            SizedBox(
              height: h * 0.045,
            ),
            Container(
              height: 140,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 20, bottom: 5),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.green,
                              ),
                              child: const Icon(
                                Icons.done,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'KenGen Power',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.mainColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'ID: 4759379',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.idColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  '\$1248.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.mainColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Column(
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.idColor,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '\$2840.00',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: AppColor.mainColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: h * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppButtons(
                  icon: Icons.share_sharp,
                  text: 'Share',
                  onTap: null,
                ),
                SizedBox(
                  width: h * 0.04,
                ),
                const AppButtons(
                  icon: Icons.print_outlined,
                  text: 'Print',
                  onTap: null,
                ),
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            AppLargeButton(
              text: 'Done',
              backgroundColor: Colors.white,
              textColor: AppColor.mainColor,
              onTap: () => Get.back(),
            )
          ],
        ),
      ),
    );
  }
}
