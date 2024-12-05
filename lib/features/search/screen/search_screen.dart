import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_application_1/features/search/cubit/search_cubit.dart';
import 'package:flutter_application_1/features/search/data/model/auto_complete_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_icons/app_icons.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/constant/text_styles/app_text_style.dart';
import '../../../core/ui/widgets/custom_text_form_field.dart';
import '../../../generated/l10n.dart';
import '../../root/cubit/root_cubit.dart';
import '../widget/auto_complete_card.dart';
import 'search_result_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late FocusNode _focusNode;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _searchController = context.read<SearchCubit>().searchController;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void onRefresh(
    BuildContext context,
    term,
  ) {
    context.read<SearchCubit>().autoCompleteSearch(term);

    context.read<SearchCubit>().searchCubit?.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: SizedBox(
          height: 50.h,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<RootCubit>().changePageIndex(4);
                },
                icon: SvgPicture.asset(
                  categoriesImage,
                  height: AppPaddingSize.padding_35,
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  hintText: S.of(context).Search,
                  fillColor: AppColors.greyE5,
                  height: 50.h,
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (value) {
                    onRefresh(
                      context,
                      value,
                    );
                  },
                ),
              ),
              const SizedBox(width: AppPaddingSize.padding_10),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none,
                  size: AppPaddingSize.padding_35,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PaginationList<AutoCompleteModel>(
        withEmptyWidget: true,
        noDataWidget: Padding(
          padding: const EdgeInsets.only(
              left: AppPaddingSize.padding_20,
              right: AppPaddingSize.padding_20,
              top: AppPaddingSize.padding_20),
          child: InkWell(
            onTap: () {
              Navigation.push(const SearchResultScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.read<SearchCubit>().searchController.value.text,
                  style: AppTextStyle.getMediumStyle(color: AppColors.black),
                ),
                const Icon(Icons.arrow_outward_outlined)
              ],
            ),
          ),
        ),
        onCubitCreated: (cubit) {
          context.read<SearchCubit>().searchCubit = cubit;
        },
        listBuilder: (list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return AutoCompleteCard(
                onTap: () {
                  Navigation.push(const SearchResultScreen());
                },
                autoCompleteModel: list[index],
              );
            },
          );
        },
        repositoryCallBack: (data) {
          return context.read<SearchCubit>().autoCompleteSearch(
              context.read<SearchCubit>().searchController.value.text);
        },
      ),
    );
  }
}
