/*
 * Project      : my_coffee
 * File         : qr_code_scanner.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-02
 * Version      : 1.0
 * Ticket       : 
 */
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:my_coffee/constants/color_constants.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/appbars_common.dart';
import '../../../common/button_constants.dart';
import '../../../common/custom_image.dart';
import '../../../common/text_input_widget.dart';
import '../../../constants/image_assets_constants.dart';
import '../../../constants/pattern_constants.dart';
import '../../../lang/translation_service_key.dart';
import '../controller/qr_code_scanner_controller.dart';

class QrCodeScannerView extends GetView<QrCodeScannerController> {
  const QrCodeScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => QrCodeScannerController());
    return FocusDetector(onVisibilityGained: () {
      if (Platform.isAndroid) {
        controller.mQRViewController.value?.pauseCamera();
      }
      controller.mQRViewController.value?.resumeCamera();
    }, onVisibilityLost: () {
      Get.delete<QrCodeScannerController>();
    }, child: Obx(
      () {
        return Scaffold(
          appBar: AppBarsCommon.appBarBack(title: 'Table select'),
          backgroundColor: Colors.grey.shade200,
          body: Column(
            children: <Widget>[
              Expanded(flex: 3, child: _buildQrView(context)),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(15.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10.sp,
                      ),
                      if (controller.result.value != null)
                        Text(
                          'Data: ${controller.result.value!.code}',
                          style: getText500(
                              colors: ColorConstants.buttonBar, size: 18.sp),
                        )
                      else
                        Text(
                          'Scan a code',
                          style: getText500(
                              colors: ColorConstants.buttonBar, size: 18.sp),
                        ),
                      SizedBox(
                        height: 20.sp,
                      ),
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
                              offset: const Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TextInputWidget(
                          topPadding: 0.sp,
                          controller: controller.tableNumberController.value,
                          showFloatingLabel: false,
                          placeHolder: 'Enter the table number',
                          hintText: 'Enter the table number',
                          errorText: null,
                          onFilteringTextInputFormatter: [
                            FilteringTextInputFormatter.allow(
                                RegExp(AppUtilConstants.patternOnlyNumber)),
                            LengthLimitingTextInputFormatter(2)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18.sp,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
                        padding: EdgeInsets.only(left: 18.sp, right: 6.sp),
                        width: double.infinity,
                        height: 28.5.sp,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35.sp),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.22),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // GestureDetector(
                            //     onTap: () {
                            //       // controller.changeLocation();
                            //     },
                            //     child: SizedBox(
                            //       child: setImage(ImageAssetsConstants.homeLocation),
                            //       height: 20.sp,
                            //       width: 20.sp,
                            //     )),
                            // SizedBox(
                            //   width: 15.sp,
                            // ),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    controller.changeLocation();

                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Text(
                                      controller
                                          .mDashboardScreenController
                                          .selectGetAllBranchesListData
                                          .value
                                          .branchName ??
                                          'Please select the branch',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: getText500(
                                          colors: ColorConstants.buttonBar, size: 15.5.sp),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18.sp,
                      ),
                      SizedBox(
                        width: 45.w,
                        child: rectangleRoundedCornerButtonMedium(sOrderNow.tr,
                            () {
                          controller.selectTable();
                        },
                            bgColor: ColorConstants.cAppColorsBlue,
                            textColor: Colors.white,
                            height: 26.sp,
                            size: 16.5.sp),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: <Widget>[
                      //     Container(
                      //       margin: const EdgeInsets.all(8),
                      //       child: ElevatedButton(
                      //           onPressed: () async {
                      //             await controller.mQRViewController.value
                      //                 ?.toggleFlash();
                      //           },
                      //           child: FutureBuilder(
                      //             future: controller.mQRViewController.value
                      //                 ?.getFlashStatus(),
                      //             builder: (context, snapshot) {
                      //               return Text('Flash: ${snapshot.data}');
                      //             },
                      //           )),
                      //     ),
                      //     Container(
                      //       margin: const EdgeInsets.all(8),
                      //       child: ElevatedButton(
                      //           onPressed: () async {
                      //             await controller.mQRViewController.value
                      //                 ?.flipCamera();
                      //           },
                      //           child: FutureBuilder(
                      //             future: controller.mQRViewController.value
                      //                 ?.getCameraInfo(),
                      //             builder: (context, snapshot) {
                      //               if (snapshot.data != null) {
                      //                 return Text(
                      //                     'Camera facing ${describeEnum(snapshot.data!)}');
                      //               } else {
                      //                 return const Text('loading');
                      //               }
                      //             },
                      //           )),
                      //     )
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: <Widget>[
                      //     Container(
                      //       margin: const EdgeInsets.all(8),
                      //       child: ElevatedButton(
                      //         onPressed: () async {
                      //           await controller.mQRViewController.value
                      //               ?.pauseCamera();
                      //         },
                      //         child: const Text('pause',
                      //             style: TextStyle(fontSize: 20)),
                      //       ),
                      //     ),
                      //     Container(
                      //       margin: const EdgeInsets.all(8),
                      //       child: ElevatedButton(
                      //         onPressed: () async {
                      //           await controller.mQRViewController.value
                      //               ?.resumeCamera();
                      //         },
                      //         child: const Text('resume',
                      //             style: TextStyle(fontSize: 20)),
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    ));
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.

    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: controller.qrKey,
      onQRViewCreated: (p0) {
        controller.onQRViewCreated(p0);
      },
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 65.w),
      onPermissionSet: (ctrl, p) =>
          controller.onPermissionSet(context, ctrl, p),
    );
  }
}
