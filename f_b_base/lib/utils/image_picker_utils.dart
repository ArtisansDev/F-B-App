// ignore_for_file: prefer_typing_uninitialized_variables

/*
 * Project      : my_coffee
 * File         : image_picker.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-04
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/color_constants.dart';

class ImagePickerUtils {

  var imageFile;
  String fileName = "";
  final ImagePicker _picker = ImagePicker();
  final Function getPic;
  ImagePickerUtils(this.getPic);

  ///call
  void settingImagePicker() {
    showModalBottomSheet(
        context: Get.context!,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8.sp), // Adjust the radius as needed
          ),
        ),
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: const Text('Gallery'),
                    onTap: () => {imageSelector('Gallery'), Get.back()}),
                Container(height: 2.sp,
                  width: double.infinity,
                  color: Colors.grey,),
                ListTile(
                  title: const Text('Camera'),
                  onTap: () => {imageSelector('Camera'), Get.back()},
                ),
              ],
            ),
          );
        });
  }

  ///IMAGE PICKER
  Future imageSelector(String pickerType) async {
    if (pickerType == 'Gallery') {
      imageFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 85);
    } else if (pickerType == 'Camera') {
      imageFile =
      await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    }

    if (imageFile != null) {
      fileName = imageFile!.name.toString();
      _cropImage(fileName);
    } else {
      // debugPrint("You have not taken image");
    }
  }

  ///cropImage
  _cropImage(String sName) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: ColorConstants.cAppColorsBlue,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockEnabled: true,
        ),
      ],
    );

    if (croppedFile != null) {
      getPic(croppedFile.path.toString());
      // attachmentPath.value = croppedFile.path.toString();
    } else {
      // // debugPrint("You have not taken image");
    }

    // if (croppedFile != null) {
    //   imageFile = croppedFile;
    //
    //   ///
    //   final bytes = imageFile.readAsBytesSync().lengthInBytes;
    //   final kb = bytes / 1024;
    //   final mb = kb / 1024;
    //
    //   ///
    //   if (mb > 2.0) {
    //     imageFile = await testCompressAndGetFile(imageFile, 5);
    //     fileName = imageFile.path.toString().substring(
    //         imageFile.path.toString().lastIndexOf("/") + 1,
    //         imageFile.path.toString().length);
    //     attachmentPath = imageFile.path.toString();
    //
    //   } else {
    //     // fileName = sName;
    //     fileName = imageFile.path.toString().substring(
    //         imageFile.path.toString().lastIndexOf("/") + 1,
    //         imageFile.path.toString().length);
    //     attachmentPath = imageFile.path.toString();
    //
    //
    //   }
    // } else {
    //   // // debugPrint("You have not taken image");
    // }
  }

  ///Compress
  // Future<File?> testCompressAndGetFile(File file, int quality) async {
  //   FirebasePerformance _performance = FirebasePerformance.instance;
  //   final Trace trace = _performance.newTrace('image_compress_emp_profile');
  //   await trace.start();
  //   final dir = await path_provider.getTemporaryDirectory();
  //   final targetPath = dir.absolute.path +
  //       "/" +
  //       DateTime.now()
  //           .toString()
  //           .replaceAll(" ", "")
  //           .replaceAll(".", "_")
  //           .replaceAll(":", "_") +
  //       ".jpg";
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path,
  //     targetPath,
  //     quality: quality,
  //   );
  //
  //   // // debugPrint(file.lengthSync().toString());
  //   // // debugPrint(result?.lengthSync().toString());
  //   await trace.stop();
  //   return result;
  // }
}