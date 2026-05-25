import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BookingCubit extends Cubit<Text> {
  BookingCubit() : super(Text('Book Now')); // false = not booked

  void book() {
    emit(Text('Booked')); // now booked
  }
}