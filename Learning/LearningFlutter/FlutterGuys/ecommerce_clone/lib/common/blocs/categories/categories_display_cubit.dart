import 'package:ecommerce_clone/common/blocs/categories/categories_display_state.dart';
import 'package:ecommerce_clone/domain/category/usecases/get_categories_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesDisplayCubit extends Cubit<CategoriesDisplayState> {
  CategoriesDisplayCubit({required this.getCategoriesUseCase})
    : super(CategoriesDisplayLoadingState());

  final GetCategoriesUseCase getCategoriesUseCase;

  void displayCategories() async {
    var returnedData = await getCategoriesUseCase.call();
    returnedData.fold(
      (error) {
        emit(CategoriesDisplayLoadErrorState());
      },
      (data) {
        emit(CategoriesDisplayLoadSuccessState(categories: data));
      },
    );
  }
}
