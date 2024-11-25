/*
 * Project      : my_coffee
 * File         : tag_view.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-09-17
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:my_coffee/constants/color_constants.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import 'package:my_coffee/data/mode/get_item_details/get_item_details_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../model/dashboard_screen/controller/dashboard_controller.dart';

class TagModifierDateView {
  List<ModifierData> tagList = [];
  RxList<ModifierData> selectTag = <ModifierData>[].obs;
  Function onTab;
  DashboardScreenController mDashboardScreenController =
  Get.find<DashboardScreenController>();
  TagModifierDateView(this.onTab);

  yourKeySkillsView(List<ModifierData> tagList) {
    this.tagList.clear();
    this.tagList.addAll(tagList.toList());
    return Container(
      margin: EdgeInsets.all(19.sp),
      alignment: Alignment.centerLeft,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 15.sp, // gap between adjacent chips
        runSpacing: 15.sp, // gap between lines
        children: <Widget>[...generateTags()],
      ),
    );
  }

  generateTags() {
    return tagList.map((tag) => getChip(tag)).toList();
  }

  getChip(ModifierData name) {
    return Obx(
      () {
        return GestureDetector(
          onTap: () {
            addOrRemove(name);
            onTab(selectTag);
          },
          child: Container(
            decoration: BoxDecoration(
                color: !search(name)
                    ? ColorConstants.cAppColorsBlue
                    : Colors.white,
                borderRadius: BorderRadius.circular(11.sp),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x33000000),
                      offset: Offset(0, 0),
                      blurRadius: 3),
                ]),
            padding: EdgeInsets.only(
                top: 11.5.sp, bottom: 11.5.sp, right: 17.5.sp, left: 17.5.sp),
            child: Text(
              "${name.modifierName} (${mDashboardScreenController.selectedCurrency} ${name.price})",
              style: getText500(
                  colors:
                      !search(name) ? Colors.white : ColorConstants.buttonBar,
                  size: 15.5.sp),
            ),
          ),
        );
      },
    );
  }

  addOrRemove(ModifierData name) {
    if (selectTag.value.isEmpty) {
      selectTag.value.add(name);
    } else {
      if (search(name)) {
        selectTag.value.add(name);
      } else {
        selectTag.removeWhere((item) => item.modifierIDP == name.modifierIDP);
      }
    }
    selectTag.refresh();
  }

  search(ModifierData name) {
    return selectTag.value
        .where((food) => food.modifierIDP!
            .toLowerCase()
            .contains(name.modifierIDP!.toLowerCase()))
        .toList()
        .isEmpty;
  }
}
