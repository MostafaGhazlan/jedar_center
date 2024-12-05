import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/orders/data/models/order_model.dart';
import 'package:flutter_application_1/features/orders/data/repoistory/order_repo.dart';
import 'package:flutter_application_1/features/orders/data/usecase/get_current_orders_usecase.dart';

import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/classes/cashe_helper.dart';
import '../../../core/results/result.dart';
import '../data/usecase/get_one_order_usecase.dart';
import '../data/usecase/create_order_usecase.dart';
import '../data/usecase/get_previous_order_usecase.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  PaginationCubit? orderCubit;
  double subTotal = 0.0;
  double total = 0.0;
  OrderCubit() : super(OrderInitial());
CreateOrderParams? createOrderParams;

Future<Result> createOrder() async {
  if (CacheHelper.cartItem == null || CacheHelper.cartItem!.isEmpty) {
    return Future.error("Cart is empty");
  }

  List<OrderDetailParams> details = CacheHelper.cartItem!.map((item) {
    return OrderDetailParams(
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

  createOrderParams = CreateOrderParams(
    address: CacheHelper.currentUserInfo?.address ?? "",
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

  return CreateOrderUsecase(OrderRepository())
      .call(params: createOrderParams!);
}


  Future<Result> getCurrentOrdersOrder(data) async {
    return await GetCurrentOrdersUsecase(OrderRepository())
        .call(params: GetCurrentOrdersParams(request: data));
  }

  Future<Result> getPreviousOrdersOrder(data) async {
    return await GetPreviousOrdersUsecase(OrderRepository())
        .call(params: GetPreviousOrdersParams(request: data));
  }

  Future<Result> getOneOrdersOrder(orderId) async {
    emit(OrderLoadingState());
    final result = await GetOneOrderUseCase(OrderRepository())
        .call(params: GetOneOrderParams(orderId: orderId));
    emit(OrderUpdatedState());
    return result;
  }

  void updateTotals(OrderModel? order) {
    total = 0.0;
    subTotal = 0.0;
    double newTotal = 0.0;
    double newSubTotal = 0.0;

    if (order != null) {
      newTotal += order.netAmount ?? 0.0;
      newSubTotal += order.totalAmount ?? 0.0;
    }

    total = newTotal;
    subTotal = newSubTotal;
    emit(OrderUpdatedState());
  }
}
