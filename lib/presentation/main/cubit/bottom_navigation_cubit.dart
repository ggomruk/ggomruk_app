import 'package:flutter_bloc/flutter_bloc.dart';

enum BottomNav { backtest, trade, history, user }

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  void changeIndex(int index) {
    emit(index);
  }

  int get currentIndex => state;

  BottomNav get currentNav => BottomNav.values[state];
}