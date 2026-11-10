import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/features/product_details/view_model/state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitState());

  int imageIndex = 0;

  void changeImage(int index) {
    imageIndex = index;
    emit(ProductDetailsImageChangedState());
  }
}
