import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_coffee/common/custom_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:my_coffee/constants/text_styles_constants.dart';

import '../constants/color_constants.dart';

// ignore: must_be_immutable
class TextInputWidget extends StatelessWidget {
  String placeHolder = '';
  String hintText = '';
  late TextEditingController controller;
  TextInputType? textInputType = TextInputType.text;
  String? errorText = '';
  bool? hidePassword = false;
  bool? showFloatingLabel = true;
  bool? isReadOnly = false;
  bool? isPhone = false;
  String? suffixIconType = '';
  String? sPrefixText;
  String? prefixImage;
  Color? hintTextColor;
  Color? labelTextColor;
  Color? borderColor;
  TextCapitalization? textCapitalization;
  IconData? prefixIcon;
  IconData? suffixIcon;
  Function? onClick;
  Function? onSubmitted;
  Function? onTextChange;
  int maxLines;
  int minLines;
  double? topPadding;
  double? prefixHeight;
  List<TextInputFormatter>? onFilteringTextInputFormatter = [];

  TextInputWidget({
    super.key,
    this.isReadOnly,
    this.suffixIconType,
    required this.placeHolder,
    required this.hintText,
    required this.controller,
    required this.errorText,
    this.hidePassword,
    this.showFloatingLabel,
    this.textInputType,
    this.borderColor,
    this.hintTextColor,
    this.labelTextColor,
    this.textCapitalization,
    this.prefixIcon,
    this.suffixIcon,
    this.isPhone,
    this.onClick,
    this.onSubmitted,
    this.onTextChange,
    this.sPrefixText,
    this.prefixImage,
    this.prefixHeight,
    this.topPadding,
    this.onFilteringTextInputFormatter,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return isPhone ?? false
        ? TextField(
            onChanged: (value) {
              if (onTextChange != null) {
                onTextChange!(value.toString());
              }
            },
            onTap: () {
              if (onClick != null) {
                onClick!("click");
              }
            },
            readOnly: isReadOnly ?? false,
            enableSuggestions: false,
            autocorrect: false,
            controller: controller,
            keyboardType: textInputType,
            maxLines: maxLines,
            obscureText: hidePassword ?? false,
            inputFormatters:
                onFilteringTextInputFormatter ?? <TextInputFormatter>[],
            style: getText500(colors: ColorConstants.black, size: 16.sp),
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            cursorColor: ColorConstants.appEditText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  left: 0.sp,
                  right: 15.sp,
                  top: topPadding ?? 13.sp,
                  bottom: topPadding ?? 13.sp),
              floatingLabelBehavior: (showFloatingLabel ?? true)
                  ? FloatingLabelBehavior.auto
                  : FloatingLabelBehavior.never,
              hintText: hintText,
              hintStyle: getTextRegular(
                  colors: ColorConstants.appEditTextHint, size: 16.sp),
              errorText: errorText,
              errorStyle: getTextRegular(colors: Colors.red, size: 13.5.sp),
              alignLabelWithHint: true,
              labelText: placeHolder,
              labelStyle: getTextRegular(
                  colors: ColorConstants.appEditTextHint, size: 16.sp),
              prefixIcon: sPrefixText == null
                  ? null
                  : GestureDetector(
                      onTap: () {
                        if (onClick != null) {
                          onClick!("prefixIcon");
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 13.sp),
                          height: prefixHeight ?? 10.h,
                          width: ((prefixHeight ?? 10.h) + 20.sp),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(33.sp),
                                bottomLeft: Radius.circular(35.sp)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '+$sPrefixText',
                                maxLines: 1,
                                style: getText500(
                                    colors: ColorConstants.black, size: 16.sp),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15.sp),
                                color: Colors.grey.shade300,
                                width: 5.sp,
                                height: double.infinity,
                              )
                            ],
                          )),
                    ),
              prefixIconColor: ColorConstants.cAppColors.shade400,
              suffixIcon: suffixIcon == null
                  ? null
                  : GestureDetector(
                      onTap: () {
                        if (onClick != null) {
                          onClick!("suffixIcon");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(
                          suffixIcon,
                          size: 22.sp,
                        ), // icon is 48px widget.
                      ),
                    ),
              suffixIconColor: ColorConstants.cAppColors.shade700,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.sp)),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.sp)),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.sp)),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  )),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.sp)),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  )),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.sp)),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  )),
            ),
          )
        : TextField(
            onChanged: (value) {
              if (onTextChange != null) {
                onTextChange!(value.toString());
              }
            },
            onTap: () {
              if (onClick != null) {
                onClick!("click");
              }
            },
            onSubmitted: (value) {
              if (onSubmitted != null) {
                onSubmitted!(value);
              }
            },
            readOnly: isReadOnly ?? false,
            enableSuggestions: false,
            autocorrect: false,
            controller: controller,
            keyboardType: textInputType,
            maxLines: maxLines,
            obscureText: hidePassword ?? false,
            inputFormatters:
                onFilteringTextInputFormatter ?? <TextInputFormatter>[],
            style: getTextRegular(colors: ColorConstants.black, size: 16.5.sp),
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            cursorColor: ColorConstants.appEditText,
            minLines: minLines,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  left: 15.sp,
                  right: 15.sp,
                  top: topPadding ?? 13.sp,
                  bottom: topPadding ?? 13.sp),
              floatingLabelBehavior: (showFloatingLabel ?? true)
                  ? FloatingLabelBehavior.auto
                  : FloatingLabelBehavior.never,
              hintText: hintText,
              hintStyle:
                  getTextRegular(colors: ColorConstants.buttonBar, size: 16.sp),
              errorText: errorText,
              errorStyle: getTextRegular(colors: Colors.red, size: 13.5.sp),
              alignLabelWithHint: true,
              labelText: placeHolder,
              labelStyle:
                  getTextRegular(colors: ColorConstants.buttonBar, size: 16.sp),
              prefixIcon: prefixImage != null
                  ? setImageSize(prefixImage ?? '', fit: BoxFit.fitHeight)
                  : prefixIcon == null
                      ? null
                      : Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            prefixIcon,
                            size: 22.sp,
                          ), // icon is 48px widget.
                        ),
              prefixIconColor: ColorConstants.cAppColors.shade400,
              suffixIcon: suffixIcon == null
                  ? null
                  : GestureDetector(
                      onTap: () {
                        if (onClick != null) {
                          onClick!("suffixIcon");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(
                          suffixIcon,
                          size: 22.sp,
                        ), // icon is 48px widget.
                      ),
                    ),
              suffixIconColor: ColorConstants.cAppColors.shade700,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.sp)),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.sp)),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.sp)),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  )),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.sp)),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  )),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.sp)),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  )),
            ),
          );
  }
}
