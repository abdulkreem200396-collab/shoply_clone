part of '../onboarding_screen.dart';

class _OnboardingBottom extends StatelessWidget {
  const _OnboardingBottom();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final primary = Theme.of(context).colorScheme.primary;

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final isLast = cubit.isLastPage;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_images.length, (i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cubit.currentIndex == i
                          ? primary
                          : Colors.grey.shade400,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: isLast ? 'get_started'.tr() : 'next'.tr(),
                onPressed: () {
                  if (isLast) {
                    cubit.finish();
                  } else {
                    cubit.next();
                  }
                },
              ),
              const SizedBox(height: 10),
              if (!isLast)
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade600,
                  ),
                  onPressed: cubit.skip,
                  child: Text(
                    'skip'.tr(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
