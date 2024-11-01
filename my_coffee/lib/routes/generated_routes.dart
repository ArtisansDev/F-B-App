import 'package:flutter/material.dart';
import 'package:my_coffee/common/view_document/view_doument.dart';
// import 'package:my_coffee/common/view_document/view_doument.dart';

import '../common/view_document/view_document_model.dart';
import '../model/about_us/view/about_us_screen.dart';
import '../model/dashboard_screen/view/dashboard_screen.dart';
import '../model/details_edit_page/view/details_edit_page_screen.dart';
import '../model/details_page/view/details_page_screen.dart';
import '../model/introduction_screen/view/introduction_screen.dart';
import '../model/login_screen/view/login_screen.dart';
import '../model/order_confirmation/view/order_confirmation_screen.dart';
import '../model/otp_screen/view/otp_screen.dart';
import '../model/profile_screen/update_profile/view/update_profile_screen.dart';
import '../model/register_screen/view/register_screen_screen.dart';
import '../model/terms_of_use/view/terms_of_use_screen.dart';
import 'route_constants.dart';

class GeneratedRoutes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String routeName = routeSettings.name.toString();

    switch (routeName) {
      ///Introduction-Screen
      case RouteConstants.rIntroductionScreen:
        return MaterialPageRoute(
            builder: (context) => const IntroductionScreen());

      ///Login-Screen
      case RouteConstants.rLoginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      ///Register-Screen
      case RouteConstants.rRegisterScreenScreen:
        return MaterialPageRoute(
            builder: (context) => const RegisterScreenScreen());

      ///Otp-Screen
      case RouteConstants.rOtpScreen:
        return MaterialPageRoute(builder: (context) => const OtpScreen());

      ///Dashboard-Screen
      case RouteConstants.rDashboardScreen:
        return MaterialPageRoute(builder: (context) => const DashboardScreen());

      ///UpdateProfile-Screen
      case RouteConstants.rUpdateProfileScreen:
        return MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen());

      ///ViewDocument-Screen
      case RouteConstants.rViewDocument:
        return MaterialPageRoute(builder: (context) => ViewDocument());

      ///DetailsPageScreen-Screen
      case RouteConstants.rDetailsPageScreen:
        return MaterialPageRoute(builder: (context) => DetailsPageScreen());

      ///DetailsEditPageScreen-Screen
      case RouteConstants.rDetailsEditPageScreen:
        return MaterialPageRoute(builder: (context) => DetailsEditPageScreen());

      ///OrderConfirmation-Screen
      case RouteConstants.rOrderConfirmationScreen:
        return MaterialPageRoute(
            builder: (context) => const OrderConfirmationScreen());

      ///TermsOfUse-Screen
      case RouteConstants.rTermsOfUseScreen:
        return MaterialPageRoute(
            builder: (context) => const TermsOfUseScreen());

      ///AboutUs-Screen
      case RouteConstants.rAboutUsScreen:
        return MaterialPageRoute(builder: (context) => const AboutUsScreen());

      default:
        return _routeNotFound(sRouteName: " - $routeName");
    }
  }

  static Route<dynamic> _routeNotFound({String sRouteName = ""}) {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Center(
          child: Text("Page not found!$sRouteName"),
        ),
      );
    });
  }
}
