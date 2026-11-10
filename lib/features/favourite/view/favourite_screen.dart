import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_clone/core/utils/widgets/network_image/custom_network_image.dart';
import 'package:shoply_clone/features/favourite/view_model/cubit.dart';
import 'package:shoply_clone/features/favourite/view_model/state.dart';

part 'widgets/favourite_card.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        final favourites = context.read<FavouriteCubit>().items;

        if (favourites.isEmpty) {
          return EmptyScreen(
            message: 'no_favourites_yet'.tr(),
            icon: Icons.favorite_border,
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: favourites.length,
          itemBuilder: (context, index) {
            return _FavouriteCard(product: favourites[index]);
          },
        );
      },
    );
  }
}
