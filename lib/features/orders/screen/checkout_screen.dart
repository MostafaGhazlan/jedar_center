import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:flutter_application_1/core/classes/cashe_helper.dart';
import 'package:flutter_application_1/core/constant/app_colors/app_colors.dart';
import 'package:flutter_application_1/core/constant/app_padding/app_padding.dart';
import 'package:flutter_application_1/core/constant/text_styles/app_text_style.dart';
import 'package:flutter_application_1/core/ui/widgets/custom_button.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_application_1/features/orders/cubit/order_cubit.dart';
import 'package:flutter_application_1/features/orders/data/models/order_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/classes/keys.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/utils/functions/app_validators.dart';
import '../../../core/variables/variables.dart';
import '../../../generated/l10n.dart';
import '../../auth/widget/text_field_section.dart';
import 'order_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final double subTotal;
  CheckoutScreen({super.key, required this.subTotal});

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
                                  color: AppColors.pink,
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
                                  subTotal.toString(),
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
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddingSize.padding_8),
                                child: Text(
                                  "${subTotal + 2000}",
                                  style: AppTextStyle.getMediumStyle(
                                      color: AppColors.black,
                                      fontSize: AppPaddingSize.padding_17),
                                ),
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
