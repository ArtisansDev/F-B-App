import 'package:f_b_base/alert/app_alert.dart';
import 'package:f_b_base/constants/message_constants.dart';
import 'package:f_b_base/constants/web_constants.dart';
import 'package:f_b_base/data/local/shared_prefs/shared_prefs.dart';
import 'package:f_b_base/data/mode/profile_image/profile_image_update_request.dart';
import 'package:f_b_base/data/mode/user_address_update/user_update_address_request.dart';
import 'package:f_b_base/data/mode/user_address_update/user_update_address_response.dart';
import 'package:f_b_base/data/mode/user_details/user_details_response.dart';
import 'package:f_b_base/data/mode/user_update/user_update_request.dart';
import 'package:f_b_base/data/mode/user_update/user_update_response.dart';
import 'package:f_b_base/data/remote/api_call/user_authentication/user_authentication_api.dart';
import 'package:f_b_base/data/remote/web_response.dart';
import 'package:f_b_base/lang/translation_service_key.dart';
import 'package:f_b_base/locator.dart';
import 'package:f_b_base/utils/app_utils.dart';
import 'package:f_b_base/utils/image_picker_utils.dart';
import 'package:f_b_base/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/get_user_details.dart';
import '../../../../constants/logout_expired.dart';

class UpdateProfileScreenController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> mobileNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> addressController1 = TextEditingController().obs;
  Rx<TextEditingController> addressController2 = TextEditingController().obs;

  Rx<UserDetailsResponseData> mUserDetailsResponseData =
      UserDetailsResponseData().obs;
  Rx<Addresses> mAddresses1 = Addresses(addressType: 0).obs;
  Rx<Addresses> mAddresses2 = Addresses(addressType: 1).obs;
  RxString gender = ''.obs;
  Rxn<String> imageUrl = Rxn<String>();
  RxString phoneCode = '91'.obs;
  RxBool mProfile = true.obs;
  RxBool mAddress1 = true.obs;
  RxBool mAddress2 = true.obs;
  final localApi = locator.get<UserAuthenticationApi>();

  UpdateProfileScreenController() {
    getProfileDetails();
    getImageSet();
  }

  getProfileDetails() async {
    mUserDetailsResponseData.value = await SharedPrefs().getUserDetails();
    nameController.value.text = mUserDetailsResponseData.value.firstName ?? '';
    emailController.value.text = mUserDetailsResponseData.value.email ?? '';
    mobileNumberController.value.text =
        mUserDetailsResponseData.value.phoneNumber ?? '';
    for (Addresses mAddresses
        in mUserDetailsResponseData.value.addresses ?? []) {
      if (mAddresses.addressType == 0) {
        mAddresses1.value = mAddresses;
        addressController1.value.text = mAddresses1.value.address ?? '';
      }
      if (mAddresses.addressType == 1) {
        mAddresses2.value = mAddresses;
        addressController2.value.text = mAddresses2.value.address ?? '';
      }
    }
    imageUrl.value = mUserDetailsResponseData.value.userImage;
    mUserDetailsResponseData.refresh();
  }

  isProfileUpdate() {
    if (nameController.value.text.trim().isEmpty) {
      AppAlertBase.showSnackBar(Get.context!, 'Please enter your name');
    } else if (emailController.value.text.trim().isEmpty) {
      AppAlertBase.showSnackBar(Get.context!, sUsernameHint.tr);
    } else if (AppUtils.isValidEmail(emailController.value.text.trim())) {
      AppAlertBase.showSnackBar(Get.context!, sUsernameErrorValid.tr);
    } else {
      profileUpdateApiCall();
    }
  }

  void profileUpdateApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        UserUpdateRequest mUserUpdateRequest = UserUpdateRequest(
            userID: await SharedPrefs().getUserId(),
            phoneNumber: mobileNumberController.value.text,
            email: emailController.value.text,
            firstName: nameController.value.text,
            lastName: '');
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postUserDetailsUpdate(mUserUpdateRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          UserUpdateResponse mUserUpdateResponse = mWebResponseSuccess.data;
          if (mUserUpdateResponse.statusCode == WebConstants.statusCode200) {
            AppAlertBase.showSnackBar(
                Get.context!, mUserUpdateResponse.statusMessage ?? "");
            await getUserDetails();
            mProfile.value = !mProfile.value;
          } else {
            AppAlertBase.showSnackBar(
                Get.context!, mUserUpdateResponse.statusMessage ?? "");
          }
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  isUpdateAddress(String type) {
    if (type == "0") {
      if (addressController1.value.text.trim().isEmpty) {
        AppAlertBase.showSnackBar(Get.context!, 'Please enter your home address');
        return;
      }
      addressUpdateApiCall(
          mAddresses1.value, addressController1.value.text.trim());
    } else {
      if (addressController2.value.text.trim().isEmpty) {
        AppAlertBase.showSnackBar(Get.context!, 'Please enter your office address');
        return;
      }
      addressUpdateApiCall(
          mAddresses2.value, addressController2.value.text.trim());
    }
  }

  void addressUpdateApiCall(Addresses value, String sAddress) {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        UserUpdateAddressRequest mUserUpdateAddressRequest =
            UserUpdateAddressRequest(
                addressIDP: value.addressIDP ?? '',
                address: sAddress,
                addressType: (value.addressType ?? 0).toString(),
                userIDF: await SharedPrefs().getUserId());
        WebResponseSuccess mWebResponseSuccess =
            await localApi.postUserAddressUpdate(mUserUpdateAddressRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          UserUpdateAddressResponse mUserUpdateAddressResponse =
              mWebResponseSuccess.data;
          if (mUserUpdateAddressResponse.statusCode ==
              WebConstants.statusCode200) {
            AppAlertBase.showSnackBar(
                Get.context!, mUserUpdateAddressResponse.statusMessage ?? "");
            await getUserDetails();
            if ((value.addressType ?? 0) == 0) {
              mAddress1.value = !mAddress1.value;
            } else {
              mAddress2.value = !mAddress2.value;
            }
          } else {
            AppAlertBase.showSnackBar(
                Get.context!, mUserUpdateAddressResponse.statusMessage ?? "");
          }
        }
      } else {
        AppAlertBase.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }

  /// Image picker
  Rxn<String> attachmentPath = Rxn<String>();
  late ImagePickerUtils mImagePickerUtils;

  void getImageSet() {
    mImagePickerUtils = ImagePickerUtils((value) {
      apiProfileImageFile(value);
    });
  }

  void apiProfileImageFile(String filePath) {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        ProfileImageUpdateRequest mProfileUpdateRequest =
            ProfileImageUpdateRequest(
                userID: mUserDetailsResponseData.value.userID);
        WebResponseSuccess mWebResponseSuccess = await localApi.postProfileImageFile(filePath, mProfileUpdateRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          attachmentPath.value = filePath;
          await getUserDetails();
        } else {
          AppAlertBase.showSnackBar(
              Get.context!, mWebResponseSuccess.statusMessage ?? '');
          if (mWebResponseSuccess.statusCode == WebConstants.statusCode401) {
            logout();
          }
        }
      }
    });
  }
}
