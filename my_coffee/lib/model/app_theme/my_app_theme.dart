// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/appbars_common.dart';
import '../../common/view_document/view_doument.dart';
import '../../lang/translation_service.dart';
import '../../routes/generated_routes.dart';
import '../../routes/route_constants.dart';
import '../about_us/view/about_us_screen.dart';
import '../dashboard_screen/view/dashboard_screen.dart';
import '../details_edit_page/view/details_edit_page_screen.dart';
import '../details_page/view/details_page_screen.dart';
import '../introduction_screen/view/introduction_screen.dart';
import '../login_screen/view/login_screen.dart';
import '../order_confirmation/view/order_confirmation_screen.dart';
import '../otp_screen/view/otp_screen.dart';
import '../profile_screen/update_profile/view/update_profile_screen.dart';
import '../qr_code_scanner/view/qr_code_scanner_view.dart';
import '../register_screen/view/register_screen_screen.dart';
import '../splash_screen/view/splash_screen.dart';
import '../terms_of_use/view/terms_of_use_screen.dart';
import 'theme/my_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyAppTheme extends StatelessWidget {
  const MyAppTheme({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          title: 'TWT',
          theme: myLightTheme(context),
          darkTheme: myDarkTheme(context),
          onGenerateRoute: GeneratedRoutes.generateRoute,
          defaultTransition: Transition.leftToRightWithFade,
          getPages: [
            GetPage(
                name: RouteConstants.rIntroductionScreen,
                page: () => const IntroductionScreen()),
            GetPage(
                name: RouteConstants.rDashboardScreen,
                page: () => const DashboardScreen()),
            GetPage(
                name: RouteConstants.rLoginScreen,
                page: () => const LoginScreen()),
            GetPage(
                name: RouteConstants.rRegisterScreenScreen,
                page: () => const RegisterScreenScreen()),
            GetPage(
                name: RouteConstants.rOtpScreen, page: () => const OtpScreen()),
            GetPage(
                name: RouteConstants.rUpdateProfileScreen,
                page: () => const UpdateProfileScreen()),
            GetPage(
                name: RouteConstants.rViewDocument, page: () => ViewDocument()),
            GetPage(
                name: RouteConstants.rDetailsPageScreen,
                page: () =>  DetailsPageScreen()),
            GetPage(
                name: RouteConstants.rDetailsEditPageScreen,
                page: () =>  DetailsEditPageScreen()),
            GetPage(
                name: RouteConstants.rOrderConfirmationScreen,
                page: () =>  const OrderConfirmationScreen()),
            GetPage(
                name: RouteConstants.rTermsOfUseScreen,
                page: () => const TermsOfUseScreen()),
            GetPage(
                name: RouteConstants.rAboutUsScreen,
                page: () => const AboutUsScreen()),
            GetPage(
                name: RouteConstants.rQrCodeScannerView,
                page: () => const QrCodeScannerView()),
          ],
          builder: (context, child) {
            return protectFromSettingsFontSize(context, child!);
          },
          home: const SplashScreen(),
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
          localizationsDelegates: const [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}

MediaQuery protectFromSettingsFontSize(BuildContext context, Widget child) {
  final mediaQueryData = MediaQuery.of(context);
  // Font size change(either reduce or increase) from phone setting should not impact app font size
  final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.0);
  return MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
    child: child,
  );
}
