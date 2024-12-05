part of 'shopping_cubit.dart';

@immutable
sealed class ShoppingState {}

final class ShoppingInitial extends ShoppingState {}
final class ShoppingUpdated extends ShoppingState {}
class ShoppingCategorySelected extends ShoppingState {
  final CategoryModel selectedCategory;

  ShoppingCategorySelected(this.selectedCategory);
}