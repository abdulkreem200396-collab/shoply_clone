import 'package:flutter/material.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/features/about/view/about_screen.dart';
import 'package:shoply_clone/features/edit_profile/view/edit_profile_screen.dart';
import 'package:shoply_clone/features/forgot_password/view/forgot_password_screen.dart';
import 'package:shoply_clone/features/language/view/language_screen.dart';
import 'package:shoply_clone/features/login/view/login_screen.dart';
import 'package:shoply_clone/features/main/view/main_screen.dart';
import 'package:shoply_clone/features/onboarding/view/onboarding_screen.dart';
import 'package:shoply_clone/features/orders/view/orders_screen.dart';
import 'package:shoply_clone/features/product_details/view/product_details_screen.dart';
import 'package:shoply_clone/features/products/view/products_screen.dart';
import 'package:shoply_clone/features/search/view/search_screen.dart';
import 'package:shoply_clone/features/settings/view/settings_screen.dart';
import 'package:shoply_clone/features/signup/view/signup_screen.dart';
import 'package:shoply_clone/features/splash/view/splash_screen.dart';
import 'package:shoply_clone/features/theme/view/theme_screen.dart';
import 'package:shoply_clone/features/update_password/view/update_password_screen.dart';
import 'package:shoply_clone/features/verify_email/view/verify_email_screen.dart';
import 'package:shoply_clone/features/admin/view/admin_screen.dart';
import 'package:shoply_clone/features/admin_orders/view/admin_orders_screen.dart';
import 'package:shoply_clone/features/admin_product_form/view/admin_product_form_screen.dart';
import 'package:shoply_clone/features/admin_products/view/admin_products_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppPages.splashScreen:
        return _page(const SplashScreen());

      case AppPages.onBoardingScreen:
        return _page(const OnboardingScreen());

      case AppPages.loginScreen:
        return _page(const LoginScreen());

      case AppPages.signupScreen:
        return _page(const SignupScreen());

      case AppPages.forgotPasswordScreen:
        final email = settings.arguments as String? ?? '';
        return _page(ForgotPasswordScreen(initialEmail: email));

      case AppPages.verifyEmailScreen:
        return _page(const VerifyEmailScreen());

      case AppPages.mainScreen:
        return _page(const MainScreen());

      case AppPages.productsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _page(
          ProductsScreen(
            title: args['title'] as String,
            categoryId: args['categoryId'] as String?,
          ),
        );

      case AppPages.productDetailsScreen:
        final product = settings.arguments as ProductModel;
        return _page(ProductDetailsScreen(product: product));

      case AppPages.searchScreen:
        return _page(const SearchScreen());

      case AppPages.ordersScreen:
        return _page(const OrdersScreen());

      case AppPages.settingsScreen:
        return _page(const SettingsScreen());

      case AppPages.editProfileScreen:
        return _page(const EditProfileScreen());

      case AppPages.updatePasswordScreen:
        return _page(const UpdatePasswordScreen());

      case AppPages.languageScreen:
        return _page(const LanguageScreen());

      case AppPages.themeScreen:
        return _page(const ThemeScreen());

      case AppPages.aboutScreen:
        return _page(const AboutScreen());
      case AppPages.adminScreen:
        return _page(const AdminScreen());

      case AppPages.adminProductsScreen:
        return _page(const AdminProductsScreen());

      case AppPages.adminProductFormScreen:
        final product = settings.arguments as ProductModel?;
        return _page(AdminProductFormScreen(product: product));

      case AppPages.adminOrdersScreen:
        return _page(const AdminOrdersScreen());
    }
    return null;
  }

  static MaterialPageRoute<dynamic> _page(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}
