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
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
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
                            height: 250.h,
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
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(height: AppPaddingSize.padding_10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.greyAD)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_8),
                              child: Text(
                                S.of(context).Pay_through,
                                style: AppTextStyle.getBoldStyle(
                                    color: AppColors.black,
                                    fontSize: AppPaddingSize.padding_13),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppPaddingSize.padding_10,
                                  left: AppPaddingSize.padding_10,
                                  right: AppPaddingSize.padding_10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.money,
                                    size: AppPaddingSize.padding_12,
                                  ),
                                  const SizedBox(
                                      width: AppPaddingSize.padding_10),
                                  Text(
                                    S.of(context).Cash_payment,
                                    style: AppTextStyle.getMediumStyle(
                                        color: AppColors.black,
                                        fontSize: AppPaddingSize.padding_13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.greyAD)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                  AppPaddingSize.padding_8),
                              child: Text(
                                S.of(context).Shipping_Addres,
                                style: AppTextStyle.getBoldStyle(
                                    color: AppColors.black,
                                    fontSize: AppPaddingSize.padding_13),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).User_Name,
                                    style: AppTextStyle.getMediumStyle(
                                        color: AppColors.grey72,
                                        fontSize: AppPaddingSize.padding_13),
                                  ),
                                  Text(
                                    CacheHelper.currentUserInfo?.name ?? "Name",
                                    style: AppTextStyle.getMediumStyle(
                                        color: AppColors.black,
                                        fontSize: AppPaddingSize.padding_13),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).Shipping_Addres,
                                    style: AppTextStyle.getMediumStyle(
                                        color: AppColors.grey72,
                                        fontSize: AppPaddingSize.padding_13),
                                  ),
                                  const SizedBox(
                                    width: AppPaddingSize.padding_5,
                                  ),
                                  Expanded(
                                    child: CustomTextFormField(
                                      textAlign: TextAlign.center,
                                      hintText: S.of(context).Enter_address,
                                      onChanged: (value) {
                                        CacheHelper.currentUserInfo?.address =
                                            value;
                                      },
                                      validator: (value) {
                                        return AppValidators.validateFillFields(
                                            context, value);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) {
                            context.read<CartCubit>().docPromoCode = value;
                            context.read<CartCubit>().updateState();
                          },
                          controller: context.read<CartCubit>().promoController,
                          decoration: InputDecoration(
                              hintStyle: AppTextStyle.getMediumStyle(
                                  color: AppColors.black),
                              labelText: S.of(context).Enter_Code,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                  color: AppColors.greyAD,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                  color: AppColors.greyAD,
                                  width: 2.0,
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CreateModel<OrderModel>(
                                  onSuccess: (model) {
                                    netAmount = model.netAmount ?? 0;
                                    context.read<OrderCubit>().discountType =
                                        model.discountType ?? 0;
                                    context
                                            .read<OrderCubit>()
                                            .discountTypeAmount =
                                        model.discountTypeAmount ?? 0;
                                    Dialogs.showSnackBar(
                                        message:
                                            S.of(context).promocode_Successfly);
                                    context.read<CartCubit>().docPromoCode = "";
                                    context.read<CartCubit>().updateState();
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
                                  child: Text(
                                    S.of(context).Apply,
                                    style: AppTextStyle.getBoldStyle(
                                        color: AppColors.primary,
                                        fontSize: AppPaddingSize.padding_13),
                                  ),
                                ),
                              )),
                        )),
                    const SizedBox(height: AppPaddingSize.padding_10),
                    Padding(
                      padding: const EdgeInsets.all(AppPaddingSize.padding_8),
                      child: Text(
                        S.of(context).Payment_Summary,
                        style: AppTextStyle.getBoldStyle(
                            color: AppColors.black,
                            fontSize: AppPaddingSize.padding_17),
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
                                      fontSize: AppPaddingSize.padding_13),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddingSize.padding_8),
                                child: Text(
                                  S.of(context).Delivery_Charges,
                                  style: AppTextStyle.getMediumStyle(
                                      color: AppColors.greyA4,
                                      fontSize: AppPaddingSize.padding_13),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddingSize.padding_8),
                                child: Text(
                                  S.of(context).Service_Fees,
                                  style: AppTextStyle.getMediumStyle(
                                      color: AppColors.greyA4,
                                      fontSize: AppPaddingSize.padding_13),
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
                                      fontSize: AppPaddingSize.padding_13),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddingSize.padding_8),
                                child: Text(
                                  "1000 ${S.of(context).IQD}",
                                  style: AppTextStyle.getMediumStyle(
                                      color: AppColors.greyA4,
                                      fontSize: AppPaddingSize.padding_13),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddingSize.padding_8),
                                child: Text(
                                  "1000 ${S.of(context).IQD}",
                                  style: AppTextStyle.getMediumStyle(
                                      color: AppColors.greyA4,
                                      fontSize: AppPaddingSize.padding_13),
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
                context.read<CartCubit>().docPromoCode = "";
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
                text: S.of(context).Checkout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
