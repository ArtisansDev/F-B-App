import 'package:f_b_base/common/text_input_widget.dart';
import 'package:f_b_base/constants/color_constants.dart';
import 'package:f_b_base/constants/pattern_constants.dart';
import 'package:f_b_base/constants/text_styles_constants.dart';
import 'package:f_b_base/data/mode/get_all_table_status/get_all_table_status_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

///partha paul
///customer_drop_down
///02/01/25

List<TableStatusData> selectGetAllTablesResponseData = [];

showTableBottomSheet(
    List<TableStatusData> mGetAllTablesList, Function onGetDetails) async {
  selectGetAllTablesResponseData.clear();
  selectGetAllTablesResponseData.addAll(mGetAllTablesList.toList());

  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true, // Allows the BottomSheet to expand
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8.sp)),
    ),
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      TextEditingController phoneNumberSearchController =
          TextEditingController();
      RxList<TableStatusData> filteredItems =
          selectGetAllTablesResponseData.obs;
      return Container(
        height: 69.h,
        width: 95.w,
        color: Colors.white,
        padding: MediaQuery.of(context).viewInsets, // Handle keyboard overlap
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content
          children: [
            SizedBox(height: 18.sp),
            Text(
              'Select Seating',
              style: getText500(
                  colors: ColorConstants.black.withOpacity(0.8), size: 17.5.sp),
            ),
            SizedBox(height: 18.sp),
            Container(
              height: 28.5.sp,
              margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
              padding: EdgeInsets.only(left: 18.sp, right: 15.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.sp),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.22),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(
                        0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: TextInputWidget(
                isReadOnly: false,
                topPadding: 0.sp,
                controller:
                phoneNumberSearchController,
                showFloatingLabel: false,
                placeHolder: 'Seating number',
                hintText: 'Seating number',
                errorText: null,
                onTextChange: (value) {
                  filteredItems.value = selectGetAllTablesResponseData
                      .where((item) => item.seatNumber
                      .toString()
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                      .toList();
                },
                onFilteringTextInputFormatter: [
                  FilteringTextInputFormatter.allow(
                    RegExp(AppUtilConstants.patternCompanyName),
                  ),
                  LengthLimitingTextInputFormatter(10)
                ],
              ),
            ),

            SizedBox(height: 18.sp),
            Obx(
              () => filteredItems.isEmpty
                  ? GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 45.sp,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          padding: EdgeInsets.all(10.sp),
                          margin: EdgeInsets.only(
                              bottom: 8.sp, left: 15.sp, right: 14.sp),
                          alignment: Alignment.center,
                          child: Text(
                            "No table found",
                            textAlign: TextAlign.center,
                            style: getText500(
                                colors: ColorConstants.black, size: 17.5.sp),
                          )),
                    )
                  : Expanded(
                      child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        TableStatusData mGetAllTablesResponseData =
                            filteredItems[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context, mGetAllTablesResponseData);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              padding: EdgeInsets.all(15.sp),
                              margin: EdgeInsets.only(
                                  bottom: 8.sp, left: 15.sp, right: 14.sp),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    (mGetAllTablesResponseData.seatNumber ?? '')
                                            .isEmpty
                                        ? '--'
                                        : (mGetAllTablesResponseData
                                                .seatNumber ??
                                            ''),
                                    style: getText500(
                                        colors: ColorConstants.black,
                                        size: 17.sp),
                                  )),
                                  Text(
                                    '${mGetAllTablesResponseData.seatingCapacity ?? ''} Seat(s)',
                                    style: getText500(
                                        colors: ColorConstants.black,
                                        size: 17.sp),
                                  )
                                ],
                              )),
                        );
                      },
                    )),
            ),
            SizedBox(height: 12.sp),
          ],
        ),
      );
    },
  ).then((value) {
    if (value != null) {
      TableStatusData mGetAllTablesResponseData = value;
      onGetDetails(mGetAllTablesResponseData);
    }
  });
}
