part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}
final class OrderUpdatedState extends OrderState {}
final class OrderLoadingState extends OrderState {}
