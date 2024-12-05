import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/boilerplate/pagination/models/get_list_request.dart';
import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/results/result.dart';
import '../data/model/auto_complete_model.dart';
import '../data/repositiory/search_repositiory.dart';
import '../data/usecase/auto_complete_search_usecase.dart';
import '../data/usecase/search_usecase.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  PaginationCubit? searchCubit;
  List<AutoCompleteModel>? autoCompleteSearchList = [];
  List<String> selectedBrandIds = [];
  List<String> selectedCategoriesIds = [];
  List<int> selectedCategoriesIntIds = [];
  bool isSwitched = false;
  RangeLabels rangeLabels = const RangeLabels("1000", "300000");
  RangeValues rangeValues = const RangeValues(1000, 300000);
  List<bool> isCheckedList = [];
  int? selectedIndexSortFilter;
  TextEditingController searchController = TextEditingController();

  SearchCubit() : super(SearchInitial());

  SearchParams searchParams = SearchParams(
      request: GetListRequest(),
      brandIds: [],
      priceFrom: 0,
      priceTo: 0,
      categoryIds: [],
      categoryIntIds: [],
      discountFrom: 0,
      discountTo: 0,
      isDiscount: false,
      sortByDiscount: false,
      sortByPriceAsc: false,
      sortByPriceDesc: false,
      sorting: "",
      term: "");

  Future<Result> autoCompleteSearch(term) async {
    emit(SearchLoading());
    Result<List<AutoCompleteModel>> result =
        await AutoCompleteSearchUsecase(SearchRepository()).call(
      params: AutoCompleteSearchParams(
        term: term,
      ),
    );
    if (result.hasDataOnly) {
      autoCompleteSearchList = result.data;
    }
    emit(SearchInitial());
    return result;
  }

  Future<Result> search(data) async {
    searchParams = searchParams.copyWith(request: data);
    return await SearchUsecase(SearchRepository()).call(params: searchParams);
  }

  void toggleBrandSelection(String id, bool isChecked) {
    if (isChecked) {
      selectedBrandIds.add(id);
    } else {
      selectedBrandIds.remove(id);
    }
    emit(UpdateCheckState(selectedBrandIds));
  }

  void toggleCategorySelection(String id, bool isChecked) {
    if (isChecked) {
      selectedCategoriesIds.add(id);
    } else {
      selectedCategoriesIds.remove(id);
    }
    emit(UpdateCheckState(selectedCategoriesIds));
  }

  void switched(value) {
    isSwitched = value;
    emit(UpdateSwitch());
  }

  void range(RangeValues value) {
    double adjustedStart = (value.start / 1000).round() * 1000;
    double adjustedEnd = (value.end / 1000).round() * 1000;

    if (adjustedStart < 1000) adjustedStart = 1000;
    if (adjustedEnd > 300000) adjustedEnd = 300000;

    rangeValues = RangeValues(adjustedStart, adjustedEnd);
    rangeLabels = RangeLabels(
      rangeValues.start.toStringAsFixed(0),
      rangeValues.end.toStringAsFixed(0),
    );
    emit(UpdateRange());
  }



  void initializeList(int length) {
    if (isCheckedList.isEmpty) {
      isCheckedList = List.filled(length, false);
    }
  }

  void switchFilter(int index) {
    for (int i = 0; i < isCheckedList.length; i++) {
      isCheckedList[i] = false;
    }
    isCheckedList[index] = true;
    selectedIndexSortFilter = index;
    emit(UpdateSwitchFilter());
  }

  String? getSelectedItem(List<String> items) {
    return selectedIndexSortFilter != null
        ? items[selectedIndexSortFilter!]
        : null;
  }
}
