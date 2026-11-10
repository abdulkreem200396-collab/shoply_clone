part of '../admin_product_form_screen.dart';

String? _linkValidator(String? value, {required bool required}) {
  final text = (value ?? '').trim();
  if (text.isEmpty) {
    return required ? 'image_required'.tr() : null;
  }
  if (!text.startsWith('http')) return 'image_url_invalid'.tr();
  return null;
}

class _AdminProductFormBody extends StatelessWidget {
  const _AdminProductFormBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdminProductFormCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: cubit.nameController,
          hintText: 'product_name'.tr(),
          prefixIcon: Icons.shopping_bag_outlined,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'product_name_required'.tr();
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: cubit.nameArController,
          hintText: 'product_name_ar'.tr(),
          prefixIcon: Icons.translate,
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: cubit.descriptionController,
          hintText: 'product_description'.tr(),
          prefixIcon: Icons.notes,
          maxLines: 3,
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: cubit.descriptionArController,
          hintText: 'product_description_ar'.tr(),
          prefixIcon: Icons.translate,
          maxLines: 3,
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: cubit.priceController,
          hintText: 'price'.tr(),
          prefixIcon: Icons.attach_money,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            final parsed = double.tryParse(
              (value ?? '').trim().replaceAll(',', '.'),
            );
            if (parsed == null || parsed <= 0) return 'price_invalid'.tr();
            return null;
          },
        ),
        const SizedBox(height: 20),
        Text(
          'category'.tr(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, categoriesState) {
            if (categoriesState is! CategoriesLoadedState) {
              return const SizedBox(
                height: 40,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              );
            }

            return BlocBuilder<AdminProductFormCubit, AdminProductFormState>(
              builder: (context, state) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: categoriesState.categories.map((category) {
                    return ChoiceChip(
                      label: Text(category.localizedName),
                      selected: cubit.categoryId == category.id,
                      onSelected: (_) => cubit.setCategory(category.id),
                    );
                  }).toList(),
                );
              },
            );
          },
        ),
        const SizedBox(height: 20),
        for (var i = 0; i < cubit.imageControllers.length; i++) ...[
          CustomTextField(
            controller: cubit.imageControllers[i],
            hintText: '${'image_url'.tr()} ${i + 1}',
            prefixIcon: Icons.image_outlined,
            keyboardType: TextInputType.url,
            validator: (value) => _linkValidator(value, required: i == 0),
          ),
          const SizedBox(height: 14),
        ],
        BlocBuilder<AdminProductFormCubit, AdminProductFormState>(
          builder: (context, state) {
            return SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('show_in_trending'.tr()),
              value: cubit.isTrending,
              onChanged: cubit.setTrending,
            );
          },
        ),
        const SizedBox(height: 16),
        BlocBuilder<AdminProductFormCubit, AdminProductFormState>(
          builder: (context, state) {
            return CustomButton(
              text: 'save'.tr(),
              isLoading: state is AdminProductFormSavingState,
              onPressed: cubit.save,
            );
          },
        ),
      ],
    );
  }
}
