import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/admin/admin_stats.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/theme/app_colors.dart';
import 'package:shoply_clone/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_clone/core/utils/widgets/error_view/error_view.dart';
import 'package:shoply_clone/core/utils/widgets/list_tile/custom_list_tile.dart';
import 'package:shoply_clone/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_clone/features/admin/view_model/cubit.dart';
import 'package:shoply_clone/features/admin/view_model/state.dart';

part 'widgets/admin_stats_grid.dart';
part 'widgets/admin_actions.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit()..load(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'admin_panel'.tr(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            if (state is AdminLoadedState) {
              return RefreshIndicator(
                onRefresh: () => context.read<AdminCubit>().load(),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  children: [
                    _AdminStatsGrid(stats: state.stats),
                    const SizedBox(height: 24),
                    const _AdminActions(),
                  ],
                ),
              );
            }

            if (state is AdminNoAccessState) {
              return EmptyScreen(
                message: 'no_permission'.tr(),
                icon: Icons.lock_outline,
              );
            }

            if (state is AdminErrorState) {
              return ErrorView(
                message: state.message,
                onRetry: () => context.read<AdminCubit>().load(),
              );
            }

            return const CustomLoading();
          },
        ),
      ),
    );
  }
}
