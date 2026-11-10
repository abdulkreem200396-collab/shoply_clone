abstract class AdminProductFormState {}

class AdminProductFormInitState extends AdminProductFormState {}

class AdminProductFormChangedState extends AdminProductFormState {}

class AdminProductFormSavingState extends AdminProductFormState {}

class AdminProductFormSavedState extends AdminProductFormState {}

class AdminProductFormErrorState extends AdminProductFormState {
  AdminProductFormErrorState({required this.message});

  final String message;
}
