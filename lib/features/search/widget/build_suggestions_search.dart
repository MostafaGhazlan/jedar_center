import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../generated/l10n.dart';
import '../cubit/search_cubit.dart';
import 'auto_complete_card.dart';

class SearchSuggestions {
  Widget buildSuggestions(
    BuildContext context,
    String query,
    Function(String) updateQuery,
    Function(BuildContext) showResults,
  ) {

    if (query.isEmpty) {
      context.read<SearchCubit>().autoCompleteSearch("");
      context.read<SearchCubit>().selectedBrandIds.clear();
      context.read<SearchCubit>().selectedCategoriesIds.clear();
      context.read<SearchCubit>().searchParams.categoryIds = [];
      context.read<SearchCubit>().searchParams.brandIds = [];
    } else {
      context.read<SearchCubit>().autoCompleteSearch(query);
    }

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is SearchError) {
          return Center(
            child: Text(
              S.of(context).error_search,
              style: AppTextStyle.getMediumStyle(color: AppColors.red),
            ),
          );
        }

        final suggestions =
            context.watch<SearchCubit>().autoCompleteSearchList ?? [];

        if (suggestions.isNotEmpty && query != "") {
          context.read<SearchCubit>().searchParams.term = query;
        }

        if (suggestions.isEmpty && query != "") {
          return InkWell(
            onTap: () {
              context.read<SearchCubit>().searchParams.term = query;
              showResults(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppPaddingSize.padding_20,
                right: AppPaddingSize.padding_20,
                top: AppPaddingSize.padding_20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '"$query"',
                    style: AppTextStyle.getMediumStyle(color: AppColors.black),
                  ),
                  const Icon(Icons.arrow_outward_outlined)
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            return AutoCompleteCard(
              autoCompleteModel: suggestions[index],
              onTap: () {
                updateQuery(suggestions[index].name ?? "name");

                context.read<SearchCubit>().searchParams.term =
                    suggestions[index].name;
                if (suggestions[index].type == "Category" &&
                    suggestions[index].type != null) {
                  context
                      .read<SearchCubit>()
                      .selectedCategoriesIds
                      .add(suggestions[index].id!);
                  context.read<SearchCubit>().searchParams.categoryIds = [
                    suggestions[index].id!
                  ];
                }
                if (suggestions[index].type == "Brand" &&
                    suggestions[index].type != null) {
                  context
                      .read<SearchCubit>()
                      .selectedBrandIds
                      .add(suggestions[index].id!);
                  context.read<SearchCubit>().searchParams.brandIds = [
                    suggestions[index].id!
                  ];
                }
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}
