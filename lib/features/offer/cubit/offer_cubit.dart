import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit() : super(OfferInitial());
  final List<Color> colors = [
    const Color(0xFFddb4f6),
    const Color(0xFFb4c6f6),
    const Color(0xFFffb8c4),
    const Color(0xFFf2c898),
    const Color(0xFFe8c4b4),
    const Color(0xFFffb2ac),
    const Color(0xFFff9eaf),
    const Color(0xFFa3e0f5),
    const Color(0xFFc6c6c6),
    const Color(0xFFedcbc1),
    const Color(0xFFffc99d),
    const Color(0xFFc5e3e1),
    const Color(0xFFc0cfb0),
    const Color(0xFFdcd0c0),
  ];


}
