import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_clone/core/utils/widgets/snack_bar/custom_snack_bar.dart';
import 'package:shoply_clone/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_clone/features/admin_product_form/view_model/cubit.dart';
import 'package:shoply_clone/features/admin_product_form/view_model/state.dart';
import 'package:shoply_clone/features/categories/view_model/cubit.dart';
import 'package:shoply_clone/features/categories/view_model/state.dart';

part 'widgets/admin_product_form_body.dart';

class AdminProductFormScreen extends StatelessWidget {
  const AdminProductFormScreen({super.key, this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminProductFormCubit(product: product),
      child: Builder(
        builder: (context) {
          final cubit = context.read<AdminProductFormCubit>();

          return Scaffold(
            appBar: AppBar(
              title: Text(
                (cubit.isEditing ? 'edit_product' : 'add_product').tr(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: BlocListener<AdminProductFormCubit, AdminProductFormState>(
              listener: (context, state) {
                if (state is AdminProductFormSavedState) {
                  Navigator.pop(context, true);
                } else if (state is AdminProductFormErrorState) {
                  CustomSnackBar.show(context, state.message);
                }
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: cubit.formKey,
                    child: const _AdminProductFormBody(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
