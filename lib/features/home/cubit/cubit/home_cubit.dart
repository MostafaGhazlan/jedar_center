import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
    int carouselIndex = 0;

  HomeCubit() : super(HomeInitial());

    void changeCarouselIndex(int pageIndex) {
    carouselIndex = pageIndex;
    emit(CardChangeIndexState());
  }
}
