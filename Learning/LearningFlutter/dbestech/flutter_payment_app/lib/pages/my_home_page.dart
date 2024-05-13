import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/colors.dart';
import '../controllers/data_controller.dart';
import '../widgets/buttons.dart';
import '../widgets/large_button.dart';
import '../widgets/text_size.dart';
import 'payment_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DataController _controller = Get.put(DataController());
  final String _baseUrl = 'http://192.168.88.122/Test/public/uploads';

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SizedBox(
        height: h,
        child: Stack(
          children: [
            _headSection(),
            Obx(() {
              if (_controller.isLoading.value == true) {
                return const Center(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator()),
                );
              }
              return _listBills();
            }),
            _payButton(),
          ],
        ),
      ),
    );
  }

  _headSection() {
    return Container(
      height: 150,
      color: Colors.blue,
      child: Stack(
        children: [
          _mainBackground(),
          _curveImageContainer(),
          _buttonContainer(),
          _textContainer(),
        ],
      ),
    );
  }

  _mainBackground() {
    return Positioned(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  _curveImageContainer() {
    return Positioned(
      left: 0,
      right: -2,
      bottom: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/curve.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  _buttonContainer() {
    return Positioned(
      bottom: 5,
      right: 48,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet<dynamic>(
              isScrollControlled: true,
              barrierColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext bc) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          color: const Color(0xFFeef1f4).withOpacity(0.7),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 150,
                        ),
                      ),
                      Positioned(
                        right: 48,
                        child: Container(
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          width: 45,
                          height: 200,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppButtons(
                                icon: Icons.cancel,
                                iconColor: AppColor.mainColor,
                                textColor: Colors.white,
                                backgroundColor: Colors.white,
                                onTap: () => Navigator.pop(context),
                              ),
                              const AppButtons(
                                icon: Icons.add,
                                iconColor: AppColor.mainColor,
                                textColor: Colors.white,
                                backgroundColor: Colors.white,
                                fontSize: 12,
                                text: 'Add Bill',
                              ),
                              const AppButtons(
                                icon: Icons.history,
                                iconColor: AppColor.mainColor,
                                textColor: Colors.white,
                                backgroundColor: Colors.white,
                                fontSize: 12,
                                text: 'History',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('images/lines.png'),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                offset: const Offset(0, 1),
                color: const Color(0xFF11324d).withOpacity(0.2),
              )
            ],
          ),
        ),
      ),
    );
  }

  _listBills() {
    return Positioned(
      top: 160,
      left: 0,
      right: 0,
      bottom: 0,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
          itemCount: _controller.list.length,
          itemBuilder: (_, index) {
            return Container(
              margin: const EdgeInsets.only(top: 10, right: 10),
              height: 110,
              width: MediaQuery.of(context).size.width - 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFd8dbe0),
                    offset: Offset(1, 1),
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '$_baseUrl/${_controller.list[index].brandLogo}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _controller.list[index].brandName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColor.mainColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'ID: 846594',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.idColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedText(
                            text: _controller.list[index].dueInfo,
                            color: Colors.green),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  var value = !_controller.list[index].status;
                                  var newItem = _controller.list[index]
                                      .copyWith(status: value);
                                  _controller.list[index] = newItem;
                                  _controller.list.refresh();
                                },
                                child: Container(
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color:
                                        _controller.list[index].status == false
                                            ? AppColor.selectBackground
                                            : AppColor.green,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Select',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _controller.list[index].status ==
                                                false
                                            ? AppColor.selectColor
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                            Expanded(child: Container()),
                            Text(
                              '\$${_controller.list[index].due}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColor.mainColor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Due in 3 days',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColor.idColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 5,
                          height: 35,
                          decoration: BoxDecoration(
                            color: AppColor.halfOval,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _payButton() {
    return Positioned(
      bottom: 20,
      child: AppLargeButton(
        text: 'Pay all bills',
        textColor: Colors.white,
        onTap: () => Get.to(() => const PaymentPage()),
      ),
    );
  }

  _textContainer() {
    return const Stack(
      children: [
        Positioned(
          left: 0,
          top: 60,
          child: Text(
            'My Bills',
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color(0xFF293952)),
          ),
        ),
        Positioned(
          left: 40,
          top: 40,
          child: Text(
            'My Bills',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
