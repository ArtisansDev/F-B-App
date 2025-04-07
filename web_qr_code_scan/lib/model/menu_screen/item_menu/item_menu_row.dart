// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import '../../../../constants/color_constants.dart';
// import '../../../../constants/image_assets_constants.dart';
// import '../../../../constants/text_styles_constants.dart';
// import '../../../common/create_card_view.dart';
// import '../../../common/custom_image.dart';
// import '../../../common/smart_footer.dart';
// import '../../../data/mode/get_category/get_category_response.dart';
// import '../controller/menu_controller.dart';
//
// class ItemMenuRow extends StatelessWidget {
//   final int index;
//   late MenuScreenController controller;
//
//   ItemMenuRow({super.key, required this.index}) {
//     controller = Get.find<MenuScreenController>();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     GetCategoryListData mGetCategoryListData =
//         controller.mGetCategoryListData.value[controller.selectSideMenu.value];
//     return Obx(() {
//       return Column(
//         children: [
//           Visibility(
//               visible: index == 0,
//               child: setImageBanner(ImageAssetsConstants.bannerMenu1)),
//           SizedBox(
//             height: 15.sp,
//           ),
//           Row(
//             children: [
//               SizedBox(width: 15.sp),
//               Container(
//                 width: 1.w,
//                 height: 2.5.h,
//                 color: ColorConstants.cAppColorsBlue,
//               ),
//               SizedBox(width: 11.sp),
//               Text(
//                 mGetCategoryListData.categoryName ?? '',
//                 style: getTextBold(
//                     size: 16.5.sp, colors: ColorConstants.cAppColorsBlue),
//               )
//             ],
//           ),
//           SizedBox(
//             height: 13.sp,
//           ),
//           MediaQuery.removePadding(
//             context: Get.context!,
//             removeTop: true,
//             removeBottom: true,
//             child: GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisExtent: 32.5.h,
//               ),
//               itemCount: controller.mGetCategoryItemListData.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return getCardView(
//                         margin: 10.sp,
//                         paddingTopBottom: 0.sp,
//                         Container(
//                           margin: EdgeInsets.only(top: 15.sp),
//                           height: 32.5.h,
//                           child: Center(
//                               child: Column(
//                             children: [
//                               Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   Container(
//                                     height: 15.8.h,
//                                     alignment: Alignment.topCenter,
//                                     child: Image.asset(
//                                       ImageAssetsConstants.backLogo,
//                                       fit: BoxFit.fitHeight,
//                                       height: 14.h,
//                                     ),
//                                   ),
//                                   Container(
//                                       height: 15.8.h,
//                                       alignment: Alignment.bottomCenter,
//                                       child: Image.asset(
//                                         ImageAssetsConstants.coffee,
//                                         fit: BoxFit.fitHeight,
//                                         height: 15.3.h,
//                                       )),
//                                 ],
//                               ),
//                               Container(
//                                 height: 4.h,
//                                 margin:
//                                     EdgeInsets.only(left: 15.sp, right: 15.sp),
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   'CHAM IT UP',
//                                   textAlign: TextAlign.center,
//                                   maxLines: 2,
//                                   style: getTextRegular(
//                                       size: 14.sp,
//                                       colors: ColorConstants.cAppColorsBlue),
//                                 ),
//                               ),
//                               Container(
//                                 height: 4.32.h,
//                                 margin:
//                                     EdgeInsets.only(left: 15.sp, right: 15.sp),
//                                 alignment: Alignment.topCenter,
//                                 child: Text(
//                                   'White Peach Oolong Cham Latte',
//                                   textAlign: TextAlign.center,
//                                   maxLines: 2,
//                                   style: getText600(
//                                       size: 15.sp,
//                                       colors: ColorConstants.black,
//                                       heights: 1.3),
//                                 ),
//                               ),
//                               Container(
//                                 height: 4.h,
//                                 margin:
//                                     EdgeInsets.only(left: 15.sp, right: 15.sp),
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   '12.00 RM',
//                                   textAlign: TextAlign.center,
//                                   maxLines: 2,
//                                   style: getText500(
//                                       size: 16.sp,
//                                       colors: ColorConstants.black),
//                                 ),
//                               ),
//                             ],
//                           )),
//                         ));
//               },
//             ),
//           )
//         ],
//       );
//     });
//   }
// }
