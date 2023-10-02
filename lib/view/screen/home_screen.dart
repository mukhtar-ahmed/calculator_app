import 'package:calculator_app/constant.dart';
import 'package:calculator_app/controller/home_controller.dart';
import 'package:calculator_app/view/screen/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widget/custom_container.dart';

class HomeScreen extends StatefulWidget {
  static const String id = '/home_screen';
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: kTransparentColor,
              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      height: 360.h,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Text(
                              homeController.pressedButtonText,
                              style: TextStyle(
                                color: kBlackColor,
                                fontSize: 40.sp,
                              ),
                              textAlign: TextAlign.end,
                              maxLines: 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //For top 16 buttons
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 5.w,
                          crossAxisCount: 4,
                          mainAxisExtent: 50.h),
                      itemCount: homeController.buttonText.length,
                      itemBuilder: (BuildContext context, index) {
                        return CustomContainer(
                          onTap: () {
                            homeController
                                .onTapFun(homeController.buttonText[index]);
                          },
                          height: 55.h,
                          width: 55.w,
                          shape: BoxShape.circle,
                          buttonText: homeController.buttonText[index],
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //History Button
                        CustomContainer(
                          onTap: () {
                            Get.toNamed(HistoryScreen.id);
                          },
                          height: 55.h,
                          width: 150.w,
                          shape: BoxShape.rectangle,
                          buttonText: "History",
                        ),
                        // Equal Button
                        CustomContainer(
                          onTap: () {
                            homeController.onTapFun("=");
                          },
                          height: 55.h,
                          width: 55.w,
                          shape: BoxShape.circle,
                          buttonText: "=",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
