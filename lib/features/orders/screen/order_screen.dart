import 'package:flutter_application_1/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/ui/screens/splash_screen.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_text_form_field.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_application_1/features/orders/cubit/order_cubit.dart';
import 'package:flutter_application_1/features/orders/data/models/order_model.dart';
import 'package:flutter_application_1/features/orders/widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/app_padding/app_padding.dart';
import '../../../core/ui/widgets/back_widget.dart';
import '../../../core/ui/widgets/tab_widget.dart';
import '../../../generated/l10n.dart';
import 'order_details.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.evenLighterBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: BackWidget(
          existBack: false,
          title: S.of(context).Orders,
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigation.pushAndRemoveUntil(const SplashScreen());
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddingSize.padding_16,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: AppPaddingSize.padding_20),
                child: CustomTextFormField(
                  hintText: S.of(context).Search,
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (value) {
                    context.read<OrderCubit>().orderCubit!.getList();
                  },
                ),
              ),
              const SizedBox(
                height: AppPaddingSize.padding_20,
              ),
              Expanded(
                child: TabBarWidget(
                  isIndicatorColor: false,
                  isScrollable: true,
                  tabLength: 2,
                  screenTitleList: [
                    S.of(context).Current_Orders,
                    S.of(context).Previous_Orders,
                  ],
                  screenList: [
                    PaginationList<OrderModel>(
                      loadingHeight: 200.h,
                      withPagination: true,
                      onCubitCreated: (cubit) {
                        context.read<OrderCubit>().orderCubit = cubit;
                      },
                      repositoryCallBack: (data) {
                        return context
                            .read<OrderCubit>()
                            .getCurrentOrdersOrder(data);
                      },
                      listBuilder: (list) => ListView.separated(
                        itemBuilder: (context, index) {
                          return OrderCard(
                            existBack: true,
                            onTap: () {
                              Navigation.push(OrderDetails(
                                orderModel: list[index],
                              ));
                            },
                            orderModel: list[index],
                          );
                        },
                        itemCount: list.length,
                        padding: const EdgeInsets.only(
                            bottom: AppPaddingSize.padding_100,
                            top: AppPaddingSize.padding_16),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: AppPaddingSize.padding_16,
                          );
                        },
                      ),
                    ),
                    PaginationList<OrderModel>(
                      loadingHeight: 200.h,
                      withPagination: true,
                      onCubitCreated: (cubit) {
                        context.read<OrderCubit>().orderCubit = cubit;
                      },
                      repositoryCallBack: (data) {
                        return context
                            .read<OrderCubit>()
                            .getPreviousOrdersOrder(data);
                      },
                      listBuilder: (list) => ListView.separated(
                        itemBuilder: (context, index) {
                          return OrderCard(
                            orderModel: list[index],
                          );
                        },
                        itemCount: list.length,
                        padding: const EdgeInsets.only(
                            bottom: AppPaddingSize.padding_100,
                            top: AppPaddingSize.padding_16),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: AppPaddingSize.padding_16,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
