import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/classes/cashe_helper.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  clearAllWishlist() async {
    try {
      emit(WishlistLoading());

      await CacheHelper.wishlistBox.clear();

      emit(WishlistInitial());
    } catch (e) {
      emit(WishlistInitial());
    }
  }
}
