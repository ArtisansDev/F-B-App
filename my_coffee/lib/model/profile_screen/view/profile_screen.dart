import 'package:f_b_base/common/custom_image.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/image_assets_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../routes/route_constants.dart';
import '../controller/profile_controller.dart';
import '../update_profile/controller/update_profile_controller.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileScreenController());
    return _fullView();
  }

  ///full_View
  _fullView() {
    return FocusDetector(
        onVisibilityGained: () {
          if (Get.isRegistered<UpdateProfileScreenController>()) {
            Get.delete<UpdateProfileScreenController>();
          }
          controller.getProfileDetails();
          controller.getOrderDetails();
        },
        onVisibilityLost: () {
          //Get.delete<ProfileScreenController>();
        },
        child: GestureDetector(
            onTap: () {
              AppUtils.hideKeyboard(Get.context!);
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: Obx(
                () {
                  return Visibility(
                    visible: controller.viewVisible.value,
                    child: fullView(),
                  );
                },
              ),
            )));
  }

  fullView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ///profile
          viewProfile(),

          // ///Get Started
          // getStartedView(),

          ///placeAnOrder
          placeAnOrder(),

          // ///Especially For You
          // especiallyForYou(),

          ///needHelp
          //needHelp(),

          ///informationForYou
          informationForYou(),

          SizedBox(
            height: 11.h,
          )
        ],
      ),
    );
  }

  viewProfile() {
    return Container(
        margin: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 19.sp),
        child: Row(
          children: [
            Container(
              height: 19.w,
              width: 19.w,
              padding: EdgeInsets.all(
                  controller.imageUrl.value != null ? 2.sp : 15.sp),
              decoration: BoxDecoration(
                color: ColorConstants.appProgress,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.buttonBar.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, -2), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                child: controller.imageUrl.value != null
                    ? cacheProfileImage(controller.imageUrl.value ?? '',
                        ImageAssetsConstants.profile, 18.w)
                    : setImageSize(ImageAssetsConstants.profile,
                        fit: BoxFit.fill, size: 18.w),
              ),
            ),
            SizedBox(
              width: 15.sp,
            ),
            Expanded(
                child: Container(
              height: 19.w,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.userName.value,
                    style: getTextBold(
                        size: 18.sp, colors: ColorConstants.cAppColorsBlue),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    controller.email.value,
                    style: getText500(
                        size: 15.sp, colors: ColorConstants.buttonBar),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Text(
                    controller.phoneNumber.value,
                    style: getText500(
                        size: 15.sp, colors: ColorConstants.buttonBar),
                  )
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                Get.toNamed(
                  RouteConstants.rUpdateProfileScreen,
                );
              },
              child: Container(
                height: 8.w,
                width: 8.w,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.buttonBar.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, -2), // changes position of shadow
                    ),
                  ],
                ),
                child: Icon(
                  Icons.edit,
                  color: ColorConstants.cAppColorsBlue,
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ));
  }

  getStartedView() {
    return Container(
        margin: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 19.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13.sp),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: 15.sp, top: 13.5.sp, bottom: 14.sp, left: 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 10.5.h,
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          ImageAssetsConstants.backLogo,
                          fit: BoxFit.fitHeight,
                          height: 8.5.h,
                        ),
                      ),
                      Container(
                          height: 10.5.h,
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            ImageAssetsConstants.coffee,
                            fit: BoxFit.fitHeight,
                            height: 10.h,
                          )),
                    ],
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Expanded(
                      child: Container(
                    height: 11.5.h,
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get Started',
                          style: getText600(
                              size: 16.5.sp,
                              colors: ColorConstants.cAppColorsBlue,
                              heights: 1.2),
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do ',
                          style: getText500(
                            size: 15.sp,
                            colors: ColorConstants.appEditProfile,
                          ),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(
                    width: 10.sp,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 4.5.h,
                        padding: EdgeInsets.only(
                            left: 8.sp, right: 15.sp, top: 3.sp, bottom: 3.sp),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: ColorConstants.cAppColorsBlue,
                          ),
                          borderRadius: BorderRadius.circular(11.sp),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              color: ColorConstants.buttonBar,
                            ),
                            SizedBox(
                              width: 8.sp,
                            ),
                            Text(
                              'Top Up',
                              style: getText600(
                                  size: 14.5.sp,
                                  colors: ColorConstants.buttonBar),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                color: ColorConstants.buttonBar,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(13.sp),
                    bottomLeft: Radius.circular(13.sp)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 18.sp,
                    child: setImage(ImageAssetsConstants.off),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Text(
                    'Top Up RM 30 or more and enjoy a 20% OFF voucher',
                    style: getText500(colors: Colors.white, size: 14.sp),
                  )
                ],
              ),
            )
          ],
        ));
  }

  placeAnOrder() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 19.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text(
                'Place an Order',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 15.sp),
            padding: EdgeInsets.all(13.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.sp),
            ),
            child: Column(
              children: [
                (controller.mAddCartModel.value.mItems ?? []).isNotEmpty
                    ? imageAndText(ImageAssetsConstants.profile1, 'Orders',
                        value: controller.mAddCartModel.value.mItems?.length
                            .toString())
                    : imageAndText(ImageAssetsConstants.profile1, 'Orders'),
                Container(
                  margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                imageAndText(ImageAssetsConstants.profile5, 'Orders History'),
                // imageAndText(
                //     ImageAssetsConstants.profile2, 'Register your TWT Tumbler'),
                // Container(
                //   margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                //   width: double.infinity,
                //   height: 4.sp,
                //   color: Colors.grey.shade300,
                // ),
                // imageAndText(
                //     ImageAssetsConstants.profile3, 'Mission & Rewards'),
              ],
            )),
      ],
    );
  }

  especiallyForYou() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 19.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text(
                'Especially For You',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 15.sp),
            padding: EdgeInsets.all(13.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.sp),
            ),
            child: Column(
              children: [
                imageAndText(ImageAssetsConstants.profile4, 'My Voucher'),
                Container(
                  margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                imageAndText(ImageAssetsConstants.profile5, 'Gift Cards'),
                Container(
                  margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                imageAndText(ImageAssetsConstants.profile6,
                    'Invite your Friends (Earn Voucher)'),
              ],
            )),
      ],
    );
  }

  needHelp() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 19.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text(
                'Need Help?',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 15.sp),
            padding: EdgeInsets.all(13.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.sp),
            ),
            child: Column(
              children: [
                imageAndText(ImageAssetsConstants.profile7, 'Help Centre'),
                Container(
                  margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                imageAndText(ImageAssetsConstants.profile8, 'Feedback'),
                Container(
                  margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                imageAndText(ImageAssetsConstants.profile9, 'Settings'),
              ],
            )),
      ],
    );
  }

  informationForYou() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 19.sp),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text(
                'Information for You',
                style: getText600(
                    colors: ColorConstants.cAppColorsBlue, size: 17.sp),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 19.sp, right: 19.sp, top: 15.sp),
            padding: EdgeInsets.all(13.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.sp),
            ),
            child: Column(
              children: [
                imageAndText(ImageAssetsConstants.profile2, 'About Us'),
                Container(
                  margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                imageAndText(ImageAssetsConstants.profile10, 'Terms of Use'),
                Container(
                  margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                imageAndText(
                    ImageAssetsConstants.profile11, 'Application Version',
                    value: controller.version.value),
                Container(
                  margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                imageAndText(ImageAssetsConstants.profile11, 'Logout',
                    mIconData: Icons.logout),
                Container(
                  margin: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                  width: double.infinity,
                  height: 4.sp,
                  color: Colors.grey.shade300,
                ),
                imageAndText(ImageAssetsConstants.profile11, 'Delete Account',
                    mIconData: Icons.no_accounts),
              ],
            )),
      ],
    );
  }

  imageAndText(
    String? imageUrl,
    String title, {
    IconData? mIconData,
    String? value,
  }) {
    return GestureDetector(
        onTap: () {
          controller.openNextPage(title);
        },
        child: Row(
          children: [
            SizedBox(
              width: 12.sp,
            ),
            SizedBox(
              height: 4.5.h,
              width: 4.5.h,
              child: (mIconData != null)
                  ? Icon(mIconData)
                  : setImage(imageUrl ?? ''),
            ),
            SizedBox(
              width: 13.sp,
            ),
            Expanded(
                child: Text(
              title,
              style: getText500(size: 16.sp, colors: ColorConstants.buttonBar),
            )),
            Text(
              value ?? '',
              style: getText500(size: 16.sp, colors: ColorConstants.buttonBar),
            ),
            SizedBox(
              width: 12.sp,
            ),
          ],
        ));
  }
}
