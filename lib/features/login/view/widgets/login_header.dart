part of '../login_screen.dart';

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  // بنبدّل اللغة وبنفتح الشاشة من جديد عشان تنبني باللغة الجديدة

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton.icon(
            onPressed: () {
              LanguageHelper.toggle(context, route: AppPages.loginScreen);
            },
            icon: const Icon(Icons.language, size: 20),
            label: Text(isArabic ? 'English' : 'العربية'),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Image.asset('assets/images/shoply_splash.png', height: 110),
        ),
        const SizedBox(height: 16),
        Text(
          'welcome_back'.tr(),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'sign_in_to_continue'.tr(),
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
