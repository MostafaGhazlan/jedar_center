import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constant/app_icons/app_icons.dart';
import '../cubit/search_cubit.dart';

class SearchActions {
  final Function(BuildContext) onFilter;

  SearchActions({required this.onFilter});

  List<Widget> buildActions(
      BuildContext context, Function(String) onQueryClear) {
    return [
      IconButton(
        onPressed: () async {
          onQueryClear("");
          await context.read<SearchCubit>().autoCompleteSearch("");
        },
        icon: Row(
          children: [
            const Icon(Icons.clear),
            IconButton(
                onPressed: () async {
                  final searchCubit = context.read<SearchCubit>();
                  searchCubit.selectedBrandIds.clear();
                  searchCubit.selectedCategoriesIds.clear();
                  searchCubit.searchParams.categoryIds = [];
                  searchCubit.searchParams.brandIds = [];
                  searchCubit.searchParams.discountFrom = 0;
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
                  searchCubit.rangeValues = const RangeValues(1000,300000);
                  searchCubit.rangeLabels = const RangeLabels("1000", "300000");
                  onFilter(context);
                  await context.read<SearchCubit>().autoCompleteSearch("");
                },
                icon: SvgPicture.asset(filetrIcon))
          ],
        ),
      ),
    ];
  }
}
