import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common/create_card_view.dart';
import '../../../../constants/color_constants.dart';
import '../../../../constants/image_assets_constants.dart';
import '../../../../constants/text_styles_constants.dart';
import '../../../common/custom_image.dart';
import '../../../data/mode/get_category/get_category_response.dart';
import '../controller/menu_controller.dart';

class SideMenuRow extends StatelessWidget {
  final int index;
  late MenuScreenController controller;

  SideMenuRow({super.key, required this.index}) {
    controller = Get.find<MenuScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    GetCategoryListData mGetCategoryListData =
        controller.mGetCategoryListData.value[index];
    return Obx(
      () {
        return GestureDetector(
          onTap: () {
            controller.selectMenu(index);
          },
          child: Row(
            children: [
              Container(
                width: 1.3.w,
                height: 10.h,
                color: controller.selectSideMenu.value == index
                    ? ColorConstants.cAppColorsBlue
                    : Colors.transparent,
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                height: 10.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cacheMenuImage(mGetCategoryListData.categoryImagePath ?? '',
                        ImageAssetsConstants.backLogo, 25.sp),
                    // Icon(index % 2 == 0 ? Icons.coffee_maker : Icons.coffee,
                    //     size: 25.sp,
                    //     color: index == controller.selectSideMenu.value
                    //         ? ColorConstants.cAppColorsBlue
                    //         : ColorConstants.cAppColors.shade50
                    //             .withOpacity(0.6)),
                    SizedBox(
                      height: 9.sp,
                    ),
                    Text(
                      mGetCategoryListData.categoryName ?? '',
                      style: getText600(
                          colors: index == controller.selectSideMenu.value
                              ? ColorConstants.cAppColorsBlue
                              : ColorConstants.cAppColors.shade50
                                  .withOpacity(0.6),
                          size: 13.sp),
                    )
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}
