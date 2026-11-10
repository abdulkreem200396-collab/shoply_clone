part of '../onboarding_screen.dart';

class _OnboardingHeader extends StatelessWidget {
  const _OnboardingHeader();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return PageView.builder(
      controller: cubit.pageController,
      itemCount: _images.length,
      onPageChanged: cubit.onPageChanged,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(_images[index], height: 300),
              const SizedBox(height: 16),
              Text(
                'onboard_title_${index + 1}'.tr(),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'onboard_desc_${index + 1}'.tr(),
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
