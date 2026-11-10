import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/admin/request_admin_product.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/features/admin_product_form/repo/admin_product_form_repo.dart';
import 'package:shoply_clone/features/admin_product_form/view_model/state.dart';

class AdminProductFormCubit extends Cubit<AdminProductFormState> {
  AdminProductFormCubit({this.product}) : super(AdminProductFormInitState()) {
    final p = product;
    if (p != null) {
      nameController.text = p.name;
      nameArController.text = p.nameAr;
      descriptionController.text = p.description;
      descriptionArController.text = p.descriptionAr;
      priceController.text = p.price.toString();
      for (var i = 0; i < imageControllers.length; i++) {
        imageControllers[i].text = i < p.images.length ? p.images[i] : '';
      }
      categoryId = p.categoryId;
      isTrending = p.isTrending;
    }
  }

  final ProductModel? product;
  final _adminProductFormRepo = AdminProductFormRepo();

  final nameController = TextEditingController();
  final nameArController = TextEditingController();
  final descriptionController = TextEditingController();
  final descriptionArController = TextEditingController();
  final priceController = TextEditingController();
  final imageControllers = List.generate(3, (_) => TextEditingController());
  final formKey = GlobalKey<FormState>();

  String categoryId = '';
  bool isTrending = false;

  bool get isEditing => product != null;

  void setCategory(String id) {
    categoryId = id;
    emit(AdminProductFormChangedState());
  }

  void setTrending(bool value) {
    isTrending = value;
    emit(AdminProductFormChangedState());
  }

  Future<void> save() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (categoryId.isEmpty) {
      emit(AdminProductFormErrorState(message: 'category_required'.tr()));
      return;
    }

    emit(AdminProductFormSavingState());

    final images = imageControllers
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    final result = await _adminProductFormRepo.save(
      id: product?.id,
      request: RequestAdminProduct(
        name: nameController.text.trim(),
        nameAr: nameArController.text.trim(),
        description: descriptionController.text.trim(),
        descriptionAr: descriptionArController.text.trim(),
        price: double.parse(priceController.text.trim().replaceAll(',', '.')),
        images: images,
        categoryId: categoryId,
        isTrending: isTrending,
      ),
    );
    if (isClosed) return;

    result.fold(
      (message) => emit(AdminProductFormErrorState(message: message)),
      (_) => emit(AdminProductFormSavedState()),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    nameArController.dispose();
    descriptionController.dispose();
    descriptionArController.dispose();
    priceController.dispose();
    for (final controller in imageControllers) {
      controller.dispose();
    }
    return super.close();
  }
}
