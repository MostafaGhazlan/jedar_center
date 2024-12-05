import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/search_cubit.dart';

class SearchLeading {
  Widget buildLeading(BuildContext context, Function(String) closeSearch) {
    return IconButton(
      onPressed: () {
        closeSearch("");
        final searchCubit = context.read<SearchCubit>();
        searchCubit.selectedBrandIds.clear();
        searchCubit.selectedCategoriesIds.clear();
        searchCubit.searchParams.categoryIds = [];
        searchCubit.searchParams.brandIds = [];
        searchCubit.searchParams.discountFrom = 0;
        searchCubit.searchParams.term = "";
        searchCubit.searchParams.discountTo = 0;
        searchCubit.searchParams.priceFrom = 0;
        searchCubit.searchParams.priceTo = 0;
        searchCubit.searchParams.categoryIntIds = [];
        searchCubit.searchParams.isDiscount = false;
        searchCubit.searchParams.sortByDiscount = false;
        searchCubit.searchParams.sortByPriceAsc = false;
        searchCubit.searchParams.sortByPriceDesc = false;
        searchCubit.isSwitched = false;
        searchCubit.isCheckedList =
            List.filled(searchCubit.isCheckedList.length, false);
        searchCubit.rangeValues = const RangeValues(1000, 300000);
        searchCubit.rangeLabels = const RangeLabels("1000", "300000");
      },
      icon: const Icon(Icons.arrow_back),
    );
  }
}
