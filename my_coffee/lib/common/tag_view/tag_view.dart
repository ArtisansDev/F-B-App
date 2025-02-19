/*
 * Project      : my_coffee
 * File         : tag_view.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-09-17
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class TagView {
  final List<String>? tagList;
  RxString selectTag = ''.obs;

  TagView(this.tagList);

  yourKeySkillsView() {
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
    return tagList?.map((tag) => getChip(tag)).toList();
  }

  getChip(name) {
    return Obx(
      () {
        return
          GestureDetector(
            onTap: (){
              selectTag.value = name;
            },
            child: Container(
              decoration: BoxDecoration(
                  color: selectTag.value == name
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
                "$name",
                style: getText500(
                    colors: selectTag.value == name
                        ? Colors.white
                        : ColorConstants.buttonBar,
                    size: 15.5.sp),
              ),
            ),
          )
          ;
      },
    );
  }
}
