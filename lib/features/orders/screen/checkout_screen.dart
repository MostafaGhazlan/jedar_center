import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:flutter_application_1/core/classes/cashe_helper.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_button.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_application_1/core/utils/functions/currency_formatter.dart';
import 'package:flutter_application_1/features/orders/cubit/order_cubit.dart';
import 'package:flutter_application_1/features/orders/data/models/order_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/classes/keys.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/widgets/custom_text_form_field.dart';
import '../../../core/utils/functions/app_validators.dart';
import '../../../core/variables/variables.dart';
import '../../../generated/l10n.dart';
import '../../auth/widget/text_field_section.dart';
import '../../cart/cubit/cart_cubit.dart';
import 'order_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final double subTotal;
  const CheckoutScreen({super.key, required this.subTotal});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double? netAmount = 0;

  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.evenLighterBackground,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).Checkout,
          style: AppTextStyle.getBoldStyle(
              color: AppColors.black, fontSize: AppPaddingSize.padding_17),
        ),
      ),
      body: Form(
        key: Keys.formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    currentLocation == null
                        ? const SizedBox.shrink()
                        : SizedBox(
                            height: 300.h,
                            child: Card(
                              color: AppColors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: FlutterMap(
                                      mapController: mapController,
                                      options: MapOptions(
                                        initialCenter: currentLocation!,
                                        initialZoom: 15,
                                        onMapReady: () {
                                          mapController.move(
                                              currentLocation!, 15);
                                        },
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                          userAgentPackageName:
                                              "aastico.hadetha.hbh",
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                              point: currentLocation!,
                                              child: const Icon(
                                                Icons.location_pin,
                                                color: Colors.red,
                                                size: 40,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                      height: AppPaddingSize.padding_10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_pin,
                                        color: AppColors.black,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                AppPaddingSize.padding_8),
                                            child: Text(
                                              CacheHelper.currentUserInfo
                                                      ?.address ??
                                                  "Address",
                                              style:
                                                  AppTextStyle.getMediumStyle(
                                                      color: AppColors.black,
                                                      fontSize: AppPaddingSize
                                                          .padding_19),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                AppPaddingSize.padding_8),
                                            child: Text(
                                              CacheHelper.currentUserInfo
                                                      ?.phoneNumber ??
                                                  "phone",
                                              style:
                                                  AppTextStyle.getMediumStyle(
                                                      color: AppColors.black,
                                                      fontSize: AppPaddingSize
                                                          .padding_19),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(
                                            AppPaddingSize.padding_8),
                                        child: Text(
                                          "Change",
                                          style: AppTextStyle.getMediumStyle(
                                              color: AppColors.orange,
                                              fontSize:
                                                  AppPaddingSize.padding_19),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(height: AppPaddingSize.padding_10),
                    TextFieldSection(
                      validator: (value) =>
                          AppValidators.validateFillFields(context, value),
                      onChanged: (p0) {
                        CacheHelper.currentUserInfo?.address = p0;
                      },
                      hintText: S.of(context).Enter_address,
                      title: S.of(context).Enter_address,
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                useSafeArea: true,
                                enableDrag: false,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                clipBehavior: Clip.antiAlias,
                                builder: (context) {
                                  return SizedBox(
                                    height: 100.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomTextFormField(
                                            onChanged: (value) {
                                              context
                                                  .read<CartCubit>()
                                                  .docPromoCode = value;
                                              context
                                                  .read<CartCubit>()
                                                  .updateState();
                                            },
                                            controller: context
                                                .read<CartCubit>()
                                                .promoController,
                                            hintText: S.of(context).Enter_Code,
                                            hintStyle:
                                                AppTextStyle.getMediumStyle(
                                                    color: AppColors.black),
                                            textAlign: TextAlign.center,
                                            borderColor: AppColors.primary,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(),
                                          ),
                                        ),
                                        CreateModel<OrderModel>(
                                            onSuccess: (model) {
                                              netAmount = model.netAmount ?? 0;
                                              context
                                                      .read<OrderCubit>()
                                                      .discountType =
                                                  model.discountType ?? 0;
                                              context
                                                      .read<OrderCubit>()
                                                      .discountTypeAmount =
                                                  model.discountTypeAmount ?? 0;
                                              Dialogs.showSnackBar(
                                                  message:
                                                      "the promocode Actived Successfly");
                                              context
                                                  .read<CartCubit>()
                                                  .docPromoCode = "";
                                              context
                                                  .read<CartCubit>()
                                                  .updateState();
                                              Navigation.pop();
                                            },
                                            onError: (val) {
                                              Dialogs.showErrorSnackBar(
                                                  message: val.toString());
                                            },
                                            useCaseCallBack: (model) {
                                              return context
                                                  .read<CartCubit>()
                                                  .checkPromoCode();
                                            },
                                            withValidation: false,
                                            child: CustomButton(
                                              text: "Check",
                                              w: 100.w,
                                            ))
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 200.w,
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Add Promo Code",
                                          style: AppTextStyle.getMediumStyle(
                                              color: AppColors.white,
                                              fontSize:
                                                  AppPaddingSize.padding_15)),
                                      const Spacer(),
                                      context.read<CartCubit>().docPromoCode ==
                                              ""
                                          ? const SizedBox.shrink()
                                          : const Icon(
                                              Icons.circle,
                                              color: AppColors.red,
                                              size: AppPaddingSize.padding_10,
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppPaddingSize.padding_10),
                    Padding(
                      padding: const EdgeInsets.all(AppPaddingSize.padding_8),
                      child: Text(
                        S.of(context).Pay_through,
                        style: AppTextStyle.getBoldStyle(
                            color: AppColors.black,
                            fontSize: AppPaddingSize.padding_19),
                      ),
                    ),
                    const SizedBox(height: AppPaddingSize.padding_10),
                    Card(
                      color: AppColors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.money,
                                    size: AppPaddingSize.padding_20,
                                  ),
                                  const SizedBox(
                                      width: AppPaddingSize.padding_10),
                                  Text(
                                    S.of(context).Cash_payment,
                                    style: AppTextStyle.getMediumStyle(
                                        color: AppColors.black,
                                        fontSize: AppPaddingSize.padding_17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.all(AppPaddingSize.padding_8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  AppPaddingSize.padding_20),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height: AppPaddingSize.padding_20,
                                width: AppPaddingSize.padding_20,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  border: Border.all(
                                    color: AppColors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      AppPaddingSize.padding_20),
                                ),
                                child: const SizedBox.shrink(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppPaddingSize.padding_10),
                    Padding(
                      padding: const EdgeInsets.all(AppPaddingSize.padding_8),
                      child: Text(
                        S.of(context).Payment_Summary,
                        style: AppTextStyle.getBoldStyle(
                            color: AppColors.black,
                            fontSize: AppPaddingSize.padding_19),
                      ),
                    ),
                    const SizedBox(height: AppPaddingSize.padding_10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddingSize.padding_8),
                                child: Text(
                                  S.of(context).Subtotal,
                                  style: AppTextStyle.getMediumStyle(
                                      color: AppColors.greyA4,
                                      fontSize: AppPaddingSize.padding_15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddingSize.padding_8),
                                child: Text(
                                  S.of(context).Delivery_Charges,
                                  style: AppTextStyle.getMediumStyle(
                                      color: AppColors.greyA4,
                                      fontSize: AppPaddingSize.padding_15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddingSize.padding_8),
                                child: Text(
                                  S.of(context).Service_Fees,
                                  style: AppTextStyle.getMediumStyle(
                                      color: AppColors.greyA4,
                                      fontSize: AppPaddingSize.padding_15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddingSize.padding_8),
                                child: Text(
                                  S.of(context).Total_Amount,
                                  style: AppTextStyle.getMediumStyle(
                                      color: AppColors.black,
                                      fontSize: AppPaddingSize.padding_17),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddingSize.padding_8),
                                child: Text(
                                  CurrencyFormatter.formatCurrency(
                                      amount: widget.subTotal,
                                      symbol: S.of(context).IQD),
                                  style: AppTextStyle.getMediumStyle(
                                      color: AppColors.greyA4,
                                      fontSize: AppPaddingSize.padding_15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddingSize.padding_8),
                                child: Text(
                                  "1000 ${S.of(context).IQD}",
                                  style: AppTextStyle.getMediumStyle(
                                      color: AppColors.greyA4,
                                      fontSize: AppPaddingSize.padding_15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddingSize.padding_8),
                                child: Text(
                                  "1000 ${S.of(context).IQD}",
                                  style: AppTextStyle.getMediumStyle(
                                      color: AppColors.greyA4,
                                      fontSize: AppPaddingSize.padding_15),
                                ),
                              ),
                              BlocBuilder<CartCubit, CartState>(
                                builder: (context, state) {
                                  return Padding(
                                    padding: const EdgeInsets.all(
                                        AppPaddingSize.padding_8),
                                    child: Text(
                                      CurrencyFormatter.formatCurrency(
                                          amount: netAmount == 0
                                              ? widget.subTotal + 2000
                                              : netAmount ?? 0 + 2000,
                                          symbol: S.of(context).IQD),
                                      style: AppTextStyle.getMediumStyle(
                                          color: AppColors.black,
                                          fontSize: AppPaddingSize.padding_17),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CreateModel<OrderModel>(
              onTap: () {
                return (Keys.formKey.currentState?.validate() ?? false);
              },
              withValidation: true,
              onSuccess: (OrderModel model) async {
                await CacheHelper.cartBox.clear();
                if (context.mounted) {
                  Dialogs.showSnackBar(
                    message: S.of(context).Success,
                    typeSnackBar: AnimatedSnackBarType.success,
                  );
                }

                CacheHelper.cartBox.clear();
                CacheHelper.cartItem?.clear();
                Navigation.pushReplacement(const OrderScreen());
              },
              onError: (val) {
                Dialogs.showSnackBar(
                    message: '$val', typeSnackBar: AnimatedSnackBarType.error);
              },
              useCaseCallBack: (model) {
                if (CacheHelper.token == null) {
                  return Dialogs.showErrorSnackBar(
                      message: S.of(context).Please_Login_First);
                } else {
                  return context.read<OrderCubit>().createOrder();
                }
              },
              child: CustomButton(
                text: S.of(context).Submet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
