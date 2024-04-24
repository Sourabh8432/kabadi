import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/utils/app_colors.dart';
import 'package:kabadi_app/view/choose_language/choose_language_view.dart';
import 'package:kabadi_app/view/sell_scrap/sellscrap_controller.dart';
import 'package:pinput/pinput.dart';
import '../../models/get_category_models.dart';
import '../../models/get_price_list.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_images.dart';
import '../../utils/app_prefrences.dart';

class SellScrapView extends StatelessWidget {
  const SellScrapView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SellScrapController>(
        init: SellScrapController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () => _onWillPop(context),
            child: Scaffold(
              key: controller.scaffoldKey,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              height: 220,
                              margin: const EdgeInsets.only(bottom: 40),
                              padding: const EdgeInsets.only(
                                  bottom: 15, right: 30, left: 30),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  image: DecorationImage(
                                      image: AssetImage(AppImages.pickupAppbar),
                                      fit: BoxFit.cover)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.scaffoldKey.currentState
                                              ?.openDrawer();
                                          controller.update();
                                        },
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: lightGreenColor)),
                                          child: Image.asset(
                                            AppImages.drawerImage,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            Container(
                                              height: 60,
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              alignment: Alignment.centerLeft,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  border: Border.all(
                                                      color: lightGreenColor)),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: InkWell(
                                                  onTap: () =>
                                                      _showBottomSheet(context),
                                                  child: Obx(() {
                                                    return Text(
                                                        controller
                                                            .location.value,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                "Poppins",
                                                            color: whiteColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400));
                                                  }),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 130,
                                              color: darkGreenColor,
                                              margin: const EdgeInsets.only(
                                                  left: 30, top: 1),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              child: Row(
                                                children: [
                                                  Text("pickupLocation".tr,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: "Poppins",
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 16,
                                                    color: whiteColor,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 60),
                                ],
                              ),
                            ),
                            controller.isAddressChecker.value == false
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    child: DefaultTabController(
                                        length: 2,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(40))),
                                            padding: const EdgeInsets.all(5),
                                            child: TabBar(
                                                padding: EdgeInsets.zero,
                                                indicatorSize:
                                                    TabBarIndicatorSize.tab,
                                                labelPadding: EdgeInsets.zero,
                                                onTap: (value) {
                                                  controller.tabController
                                                      .value = value;
                                                  controller.update();
                                                },
                                                indicator: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                40))),
                                                indicatorColor: primaryColor,
                                                dividerHeight: 0,
                                                tabs: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    height: 40,
                                                    child: Tab(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            AppImages.sellScrap,
                                                            width: 20,
                                                            height: 20,
                                                            color:
                                                                darkGreenColor,
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(
                                                            "sellScrap".tr,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "Poppins",
                                                                color:
                                                                    darkGreenColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    height: 40,
                                                    child: Tab(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            AppImages.priceList,
                                                            width: 20,
                                                            height: 20,
                                                            color:
                                                                darkGreenColor,
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(
                                                            "priceList".tr,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "Poppins",
                                                                color:
                                                                    darkGreenColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        )),
                                  )
                                : SizedBox(),
                          ],
                        ),
                        controller.tabController.value == 0
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: controller.isAddressChecker.value ==
                                        false
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                            RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "Welcome Back,",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily: "Poppins",
                                                          color: darkGreenColor,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  const TextSpan(text: " "),
                                                  TextSpan(
                                                    text: (controller.getName == "" || controller.getName == null)
                                                        ?  controller.saveName.value
                                                        : controller.getName,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: "Poppins",
                                                        color: darkGreenColor,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ]),
                                                textAlign: TextAlign.left),
                                            const SizedBox(height: 5),
                                            Text(
                                                "Select the items you would like to sell ?",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: "Poppins",
                                                    color: textSubColor,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            const SizedBox(height: 10),
                                          ])
                                    : const SizedBox())
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: controller.isAddressChecker.value ==
                                        false
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                            RichText(
                                                text: TextSpan(
                                                    text: "Scrap Price List",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: "Poppins",
                                                        color: darkGreenColor,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                textAlign: TextAlign.left),
                                            const SizedBox(height: 5),
                                            Text(
                                                "Prices may fluctuate based on Industry rates.",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: "Poppins",
                                                    color: textSubColor,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            const SizedBox(height: 10),
                                          ])
                                    : const SizedBox()),
                        controller.isAddressChecker.value == false
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: controller.tabController.value == 0
                                    ? _buildSellScrap()
                                    : _buildPriceList(),
                              )
                            : Container(
                                height: 400,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.center,
                                child: Text(controller.showMessage.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Poppins",
                                        color: darkGreenColor,
                                        fontWeight: FontWeight.w400)),
                              ),
                      ],
                    ),
                  ),
                  if (controller.isLoading.value)
                    Container(
                      width: Get.width,
                      height: Get.height,
                      color: whiteColor.withOpacity(0.4),
                      child: Center(
                        child: CircularProgressIndicator(
                            color: primaryColor, backgroundColor: whiteColor),
                      ),
                    )
                ],
              ),
              drawer: Drawer(
                backgroundColor: Colors.white,
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    Container(
                      height: 180,
                      padding:
                          const EdgeInsets.only(right: 20, left: 20, top: 40),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            // decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //     border: Border.all(width: 3, color: whiteColor)
                            // ),
                            child: ClipOval(
                              child: Image.network(
                                controller.profileImage.value ?? "",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    AppImages.profile,
                                    fit: BoxFit.fill,
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (controller.profileList?.name == null ||
                                          controller.profileList?.name == "")
                                      ? controller.saveName.value
                                      : controller.getName ?? "",
                                  style: const TextStyle(
                                      color: Color(0xff003032),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Poppins"),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  controller.profileList?.mobile ?? "",
                                  style: const TextStyle(
                                      color: Color(0xff7B7C87),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins"),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.profileView);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "View Profile",
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Poppins"),
                                      ),
                                      const SizedBox(width: 10),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color: primaryColor,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: Color(0xffE8E9E8),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        AppImages.sellScrap,
                        height: 25,
                        width: 25,
                      ),
                      title: const Text(
                        ' Sell Scrap ',
                        style: TextStyle(
                            color: Color(0xff003032),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins"),
                      ),
                      onTap: () {
                        controller.tabController.value = 0;
                        controller.update();
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        AppImages.priceList,
                        height: 25,
                        width: 25,
                      ),
                      title: const Text(
                        ' Price List ',
                        style: TextStyle(
                            color: Color(0xff7B7C87),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins"),
                      ),
                      onTap: () {
                        controller.tabController.value = 1;
                        controller.update();
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        AppImages.myPickupRequestsMenu,
                        height: 25,
                        width: 25,
                      ),
                      title: const Text(
                        ' My Pickup Requests ',
                        style: TextStyle(
                            color: Color(0xff7B7C87),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins"),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed(Routes.myPickupView);
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        AppImages.howItWorksMenu,
                        height: 25,
                        width: 25,
                      ),
                      title: const Text(
                        ' How it works ',
                        style: TextStyle(
                            color: Color(0xff7B7C87),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins"),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        AppImages.shareMenu,
                        height: 25,
                        width: 25,
                      ),
                      title: const Text(
                        ' Share ',
                        style: TextStyle(
                            color: Color(0xff7B7C87),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins"),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        AppImages.contactUsMenu,
                        height: 25,
                        width: 25,
                      ),
                      title: const Text(
                        ' Contact Us ',
                        style: TextStyle(
                            color: Color(0xff7B7C87),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins"),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        AppImages.languageMenu,
                        height: 25,
                        width: 25,
                      ),
                      title: Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: const Row(
                          children: [
                            Text(
                              ' Language ',
                              style: TextStyle(
                                  color: Color(0xff7B7C87),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins"),
                            ),
                            Spacer(),
                            Text(
                              ' En ',
                              style: TextStyle(
                                  color: Color(0xff003032),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins"),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        chooseLangDialog(context, controller);
                      },
                    ),
                    const SizedBox(height: 30),
                    ListTile(
                      leading: SvgPicture.asset(
                        AppImages.logoutMenu,
                        height: 25,
                        width: 25,
                      ),
                      title: Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: const Text(
                          ' Logout ',
                          style: TextStyle(
                              color: Color(0xffF55850),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        showLogoutDialog(context);
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: Color(0xffE8E9E8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        ' Follow us on : ',
                        style: TextStyle(
                            color: Color(0xff7B7C87),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins"),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: primaryColor, width: 1)),
                            margin: const EdgeInsets.only(right: 15),
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            child: SvgPicture.asset(
                              AppImages.instagramMenu,
                              height: 25,
                              width: 25,
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: primaryColor, width: 1)),
                              margin: const EdgeInsets.only(right: 15),
                              alignment: Alignment.center,
                              height: 50,
                              width: 50,
                              child: SvgPicture.asset(
                                AppImages.twitterMenu,
                                height: 25,
                                width: 25,
                              )),
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: primaryColor, width: 1)),
                              margin: const EdgeInsets.only(right: 15),
                              alignment: Alignment.center,
                              height: 50,
                              width: 50,
                              child: SvgPicture.asset(
                                AppImages.facebookMenu,
                                height: 25,
                                width: 25,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              bottomNavigationBar: (controller.tabController.value == 0 &&
                      controller.isAddressChecker.value == false)
                  ? (controller.address.value == null ||
                          controller.address.isEmpty)
                      ? const SizedBox()
                      : _buildContinue(context, controller)
                  : null,
            ),
          );
        });
  }

  Widget _buildContinue(BuildContext context, controller) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onTapContinue(),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  color: primaryColor),
              alignment: Alignment.center,
              height: 50,
              child: Text(
                "pickupRequest".tr,
                style: TextStyle(
                    fontSize: 16,
                    color: darkGreenColor,
                    fontFamily: "MPLUS",
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSellScrap() {
    SellScrapController sellController = Get.find();
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 8),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 180,
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: sellController.getCategoryList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              sellController.toggleSelection(index);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: sellController.isSelected(
                              sellController.getCategoryList[index].categoryId!)
                          ? primaryColor
                          : lightGreenColor,
                      width: 2,
                    ),
                  ),
                  child: Image.network(
                    sellController.getCategoryList[index].categoryImage ?? "",
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        sellController.getCategoryList[index].categoryName ??
                            "null",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 80,
                        child: Text(
                          sellController.getCategoryList[index].priceListName ??
                              "null",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "Poppins",
                            color: textSubColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceList() {
    SellScrapController sellController = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: borderColor),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: sellController.priceList,
                  style: const TextStyle(fontSize: 18, letterSpacing: 1.6),
                  onChanged: (value) {
                    // Filter the list based on user input
                    sellController.filterPriceList(value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: darkGreenColor,
                    ),
                    border: InputBorder.none,
                    hintText: "Search scrap item..",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: textSubColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: sellController.getAllPriceList.length,
          itemBuilder: (context, index) {
            final scrapItem = sellController.getAllPriceList[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  scrapItem.name ?? "null",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    color: textSubColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 75,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: scrapItem.subCategories?.length ?? 0,
                    itemBuilder: (context, subIndex) {
                      final subList = scrapItem.subCategories![subIndex];

                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: borderColor, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subList.name ?? "null",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                color: darkGreenColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${subList.priceUnit}/-${subList.weightUnit}",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                color: textSubColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }


  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Logout',
                style: TextStyle(
                    color: Color(0xff003032),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins"),
              ),
              const SizedBox(height: 20),
              const Text(
                'Are you sure you want to logout?',
                style: TextStyle(
                    color: Color(0xff7B7C87),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              width: 1, color: const Color(0xffE8E9E8)),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              color: Color(0xff003032),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        AppPrefrence.clearPrefrence();
                        Get.offAll(const ChooseLanguageView());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xffF55850),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void chooseLangDialog(BuildContext context, controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Change Language',
                style: TextStyle(
                    color: Color(0xff003032),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins"),
              ),
              const SizedBox(height: 20),
              const Text(
                'Pick your Preferred App Language',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Color(0xff7B7C87),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins"),
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Obx(() {
                          return InkWell(
                            onTap: () {
                              controller.isCheck.value = 0;
                              controller
                                  .updateLanguage(const Locale('en', 'US'));
                            },
                            child: Container(
                              height: 120,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: controller.isCheck.value == 0
                                      ? primaryColor
                                      : whiteColor,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 1, color: borderColor)),
                              child: SvgPicture.asset(
                                AppImages.englishEn,
                                height: 33,
                                width: 44,
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          AppConstants.english,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: controller.isCheck.value == true
                                  ? darkGreenColor
                                  : textSubColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(
                      children: [
                        Obx(() {
                          return InkWell(
                            onTap: () {
                              controller.isCheck.value = 1;
                              controller
                                  .updateLanguage(const Locale('hi', 'IN'));
                            },
                            child: Container(
                              height: 120,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: controller.isCheck.value == 1
                                      ? primaryColor
                                      : whiteColor,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 1, color: borderColor)),
                              child: SvgPicture.asset(
                                AppImages.hindiHi,
                                height: 33,
                                width: 44,
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          AppConstants.hindi,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: controller.isCheck.value == false
                                  ? darkGreenColor
                                  : textSubColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              width: 1, color: const Color(0xffE8E9E8)),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              color: Color(0xff003032),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Text(
                          'Change Language',
                          style: TextStyle(
                              color: Color(0xff003032),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    SellScrapController sellController = Get.find();
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: whiteColor, shape: BoxShape.circle),
                    child: Icon(
                      Icons.close,
                      color: darkGreenColor,
                    ))),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )),
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "selectPickupLocation".tr,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "yourSavedAddresses".tr,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: textSubColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sellController.myAddressData.length,
                    itemBuilder: (context, index) {
                      return Obx(() => GestureDetector(
                            onTap: () {
                              sellController.myIndex.value = index;
                              print(
                                  "index : $index : ${sellController.myIndex}");
                              sellController.update();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  border: sellController.myIndex.value == index
                                      ? Border.all(
                                          width: 2, color: primaryColor)
                                      : null,
                                  color: sellController.myIndex.value != index
                                      ? lightBg
                                      : whiteColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    height: 40,
                                    width: 40,
                                    AppImages.officeSvg,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        sellController.myAddressData[index]
                                                .locationType ??
                                            "null",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Poppins",
                                            color: darkGreenColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        sellController.myAddressData[index]
                                                .addressLine ??
                                            "null",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: "Poppins",
                                            color: darkGreenColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "or".tr,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Poppins",
                        color: textSubColor,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.addNewAddressView);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: primaryColor),
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 20,
                            color: darkGreenColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "addNewAddress".tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                color: darkGreenColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // void onTapContinue() {
  //   SellScrapController continueController = Get.find();
  //   print("address : ${continueController.location.value}");
  //   if (continueController.selectedIds.isEmpty) {
  //     Fluttertoast.showToast(msg: "Please choose at least one category");
  //   } else {
  //     List<int> categoryIds = continueController.selectedIds;
  //     Get.toNamed(
  //       Routes.sellScrapItemView,
  //       arguments: {
  //         'category_id': categoryIds,
  //         'address': continueController.location.value,
  //       },
  //     );
  //   }
  // }

  onTapContinue() {
    SellScrapController continueController = Get.find();
    print("address : ${continueController.location.value}");
    if (continueController.selectedIds.isEmpty) {
      Fluttertoast.showToast(msg: "Please chooses attlist on category");
    } else {
      List<int> categoryIds = continueController.selectedIds;
      Get.toNamed(
        Routes.sellScrapItemView,
        arguments: [
          {'category_id': categoryIds,},
          {'address': continueController.location.value},
        ],
      );
    }
  }

  Future<bool> _onWillPop(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Exit",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Text("Do you want to Exit?"),
        actions: [
          cancelButton(context),
          continueButton(context),
        ],
      ),
    );
    return Future.value(false);
  }

  Widget cancelButton(context) {
    return TextButton(
      child: const Text("NO"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget continueButton(context) {
    return TextButton(
      child: Text("YES"),
      onPressed: () {
        SystemNavigator.pop();
      },
    );
  }
}
