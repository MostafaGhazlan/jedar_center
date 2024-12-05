import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cart/data/repoisotry/cart_repo.dart';
import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/classes/cashe_helper.dart';
import '../../../core/results/result.dart';
import '../../matrix/data/model/matrix.dart';
import '../data/usecase/promo_code_usecase.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  double total = 0;
  double discountValue = 0;
  String docPromoCode = "";
  TextEditingController promoController = TextEditingController();
  PaginationCubit? cartCubit;
  List<MatrixModel>? matrixModel;
  PromoCodeParams? promoCodeParams;

  Future<Result> checkPromoCode() async {
    if (CacheHelper.cartItem == null || CacheHelper.cartItem!.isEmpty) {
      return Future.error("Cart is empty");
    }

    List<PromoCodeDetailParams> details = CacheHelper.cartItem!.map((item) {
      return PromoCodeDetailParams(
        productId: item.id.toString(),
        unitId: item.sUoMEntry!.toInt(),
        pQty: item.quantity,
        numPerMsr: item.numInSale!.toInt(),
        priceBefDis: item.productPrice!.addPrice1!,
        discountType: 0,
        discountTypeAmount: 0,
        note: "",
      );
    }).toList();

    promoCodeParams = PromoCodeParams(
      docPromoCode: docPromoCode,
      address: "asdasda",
      businessPartnerId: CacheHelper.currentUserInfo?.id ?? "",
      discountType: 0,
      discountTypeAmount: 0,
      latitude: CacheHelper.currentUserInfo?.latitude ?? "",
      longitude: CacheHelper.currentUserInfo?.longitude ?? "",
      note: "",
      phone1: CacheHelper.currentUserInfo?.phoneNumber ?? "7777777777",
      phone2: CacheHelper.currentUserInfo?.mobile ?? "",
      details: details,
    );

    return PromoCodeUsecase(CartRepository()).call(params: promoCodeParams!);
  }

  updateState() {
    emit(CartInitial());
  }

  clearAllCartIten() async {
    try {
      emit(CartLoading());

      await CacheHelper.cartBox.clear();

      emit(CartInitial());
    } catch (e) {
      emit(CartInitial());
    }
  }
}
