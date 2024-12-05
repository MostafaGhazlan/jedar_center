import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/shopping/data/repository/category_repository.dart';
import 'package:flutter_application_1/features/shopping/data/usecase/all_category_usecase.dart';
import 'package:flutter_application_1/features/shopping/data/usecase/category_and_family_usecase.dart';
import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/results/result.dart';
import '../data/model/category.dart';
import '../data/usecase/all_category_for_search_usecase.dart';
part 'shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit() : super(ShoppingInitial());
  PaginationCubit? categoryCubit;
  CategoryModel? selectedIndex;
  List<CategoryModel> categoriesWithNoChildren = [];
  List<CategoryModel> categoriesWithChildren = [];
  final List<Color> shoppingCardsColors = [
    const Color(0xFFf973a5),
    const Color(0xFFfdc2d6),
    const Color(0xFFfa9cbc),
    const Color(0xFFfdc2d6),
  ];

  Future<Result> fetchAllCategory(data) async {
    return await AllCategoryUsecase(CategoryRepository())
        .call(params: AllCategoryParams(request: data));
  }

  void selectCategory(CategoryModel category) {
    selectedIndex = category;
    emit(ShoppingCategorySelected(selectedIndex!));
  }

  Future<Result> fetchCategoryAndFamily(categoryId) async {
    return await CategoryAndFamilyUsecase(CategoryRepository())
        .call(params: CategoryAndFamilyParams(categoryId: categoryId));
  }

    Future<Result> fetchAllCategoryForSearch(data) async {
    return await AllCategoryForSearchUsecase(CategoryRepository())
        .call(params: AllCategoryForSearchParams(request: data));
  }
}
