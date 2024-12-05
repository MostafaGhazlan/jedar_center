import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_colors/app_colors.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/ui/widgets/custom_text_form_field.dart';
import '../../../generated/l10n.dart';
import '../cubit/search_cubit.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
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
      body: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: SizedBox(
          height: 50.h,
          child: Row(
            children: [
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
    );
  }
}
