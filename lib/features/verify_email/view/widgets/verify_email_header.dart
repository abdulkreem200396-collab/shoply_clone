part of '../verify_email_screen.dart';

class _VerifyEmailHeader extends StatelessWidget {
  const _VerifyEmailHeader();

  @override
  Widget build(BuildContext context) {
    final email = context.read<VerifyEmailCubit>().email;

    return Column(
      children: [
        Icon(
          Icons.mark_email_unread_outlined,
          size: 90,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 24),
        Text(
          'verify_your_email'.tr(),
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          'we_sent_link'.tr(args: [email]),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
