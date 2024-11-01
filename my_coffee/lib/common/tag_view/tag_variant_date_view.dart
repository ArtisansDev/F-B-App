/*
 * Project      : my_coffee
 * File         : tag_view.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-09-17
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_coffee/data/mode/get_item_details/get_item_details_response.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/text_styles_constants.dart';

class TagVariantDateView {
  List<VariantData> tagList = [];
  Rx<VariantData> selectVariantData = VariantData().obs;
  Function onTab;

  TagVariantDateView(this.onTab);

  yourKeySkillsView(List<VariantData> tagList) {
    this.tagList.clear();
    this.tagList.addAll(tagList.toList());
    if ((selectVariantData.value.price ?? 0)==0) {
      selectVariantData.value = tagList.first;
    }
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

  getChip(VariantData name) {
    // return Obx(
    //   () {
        return GestureDetector(
          onTap: () {
            onTab(name);
            selectVariantData.value = name;
          },
          child: Container(
            decoration: BoxDecoration(
                color: selectVariantData.value.variantIDP == name.variantIDP
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
              "${name.quantitySpecification} (${name.price} RM)",
              style: getText500(
                  colors: selectVariantData.value.variantIDP == name.variantIDP
                      ? Colors.white
                      : ColorConstants.buttonBar,
                  size: 15.5.sp),
            ),
          ),
        );
    //   },
    // );
  }
}
