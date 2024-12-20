import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/color_constants.dart';
import '../constants/image_assets_constants.dart';
import '../data/mode/get_dashboard/get_dashboard_response.dart';

cacheCoursesImage(String imageUrl, String placeHolderImagePath, double size) {
  debugPrint("image Url $imageUrl");
  return CachedNetworkImage(
    imageUrl: imageUrl,
    key: UniqueKey(),
    width: size,
    height: size,
    fit: BoxFit.cover,
    placeholder: (context, url) {
      return Image.asset(
        placeHolderImagePath,
        width: size,
        fit: BoxFit.fitWidth,
      );
    },
    errorWidget: (context, url, error) {
      return Image.asset(
        placeHolderImagePath,
        width: size,
        fit: BoxFit.fitWidth,
      );
    },
    imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
    )),
  );
}

cacheBestItemImage(String imageUrl, String placeHolderImagePath, double size) {
  debugPrint("image Url $imageUrl");
  return CachedNetworkImage(
    imageUrl: imageUrl,
    key: UniqueKey(),
    width: size,
    height: size,
    fit: BoxFit.cover,
    placeholder: (context, url) {
      return Image.asset(
        placeHolderImagePath,
        width: size,
        fit: BoxFit.fitHeight,
      );
    },
    errorWidget: (context, url, error) {
      return Image.asset(
        placeHolderImagePath,
        width: size,
        fit: BoxFit.fitHeight,
      );
    },
    imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: BorderRadius.circular(11.sp),
        child: Container(
            decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ))),
  );
}

cacheMenuImage(String imageUrl, String placeHolderImagePath, double size) {
  debugPrint("image Url $imageUrl");
  return CachedNetworkImage(
      imageUrl: imageUrl,
      key: UniqueKey(),
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return Image.asset(
          placeHolderImagePath,
          width: size,
          fit: BoxFit.fitWidth,
        );
      },
      errorWidget: (context, url, error) {
        return Image.asset(
          placeHolderImagePath,
          width: size,
          fit: BoxFit.fitWidth,
        );
      },
      imageBuilder: (context, imageProvider) => ClipRRect(
            borderRadius: BorderRadius.circular(11.sp),
            child: Container(
                decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            )),
          ));
}

cacheProfileImage(String imageUrl, String placeHolderImagePath, double size) {
  debugPrint("ProfileImage Url $imageUrl");
  return CachedNetworkImage(
      useOldImageOnUrlChange: false,
      cacheKey: DateTime.now().toString(),
      imageUrl: imageUrl,
      key: UniqueKey(),
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return Container(
            padding: EdgeInsets.all(15.sp),
            child: Image.asset(
              placeHolderImagePath,
              width: size,
              fit: BoxFit.fitWidth,
            ));
      },
      errorWidget: (context, url, error) {
        return Container(
            padding: EdgeInsets.all(15.sp),
            child: Image.asset(
              placeHolderImagePath,
              width: size,
              fit: BoxFit.fitWidth,
            ));
      },
      imageBuilder: (context, imageProvider) => ClipOval(
            child: Container(
                decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            )),
          ));
}

svgImageSet(String assetName, double width, double height,
    {Color colour = Colors.black}) {
  return SvgPicture.asset(
    assetName,
    colorFilter: ColorFilter.mode(colour, BlendMode.srcIn),
    width: width,
    height: height,
  );
}

svgImageSetNoColour(String assetName, double width, double height) {
  return SvgPicture.asset(
    assetName,
    width: width,
    height: height,
  );
}

editIcon(Function onTab) {
  return GestureDetector(
    onTap: () {
      onTab();
    },
    child: Container(
      height: 20.sp,
      width: 20.sp,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
          color: ColorConstants.cAppColorsBlue,
          borderRadius: BorderRadius.all(Radius.circular(8.sp))),
      child: Image.asset(
        ImageAssetsConstants.appLogo,
        fit: BoxFit.fitWidth,
      ),
    ),
  );
}

setImage(String image, {BoxFit? fit}) {
  return Image.asset(
    image,
    fit: fit ?? BoxFit.fitWidth,
  );
}

setImageSize(String image, {BoxFit? fit, double? size}) {
  return Image.asset(
    image,
    fit: fit ?? BoxFit.fitWidth,
    height: size ?? 10.sp,
    width: size ?? 10.sp,
  );
}

setImageBanner(String image) {
  return Image.asset(
    image,
    fit: BoxFit.fitHeight,
  );
}

// setImageHomeBanner(BannerMaster image) {
//   return Image.asset(
//     image.bannerImagePath ?? '',
//     fit: BoxFit.fitHeight,
//   );
// }

cacheImageHomeBanner(
    String imageUrl, String placeHolderImagePath, double size) {
  debugPrint("image Url $imageUrl");
  return CachedNetworkImage(
    imageUrl: imageUrl,
    key: UniqueKey(),
    width: size,
    height: size,
    fit: BoxFit.fitHeight,
    placeholder: (context, url) {
      return Image.asset(
        placeHolderImagePath,
        width: size,
        fit: BoxFit.fitHeight,
      );
    },
    errorWidget: (context, url, error) {
      return Image.asset(
        placeHolderImagePath,
        width: size,
        fit: BoxFit.fitHeight,
      );
    },
    imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: imageProvider,
        fit: BoxFit.contain,
      ),
    )),
  );
}
