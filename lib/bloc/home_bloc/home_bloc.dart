import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gshoes/bloc/home_bloc/home_event.dart';
import 'package:gshoes/bloc/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates>{
  HomeBloc():super(InitStates()){
    on<AddToCart>((event, emit){
      for (int i = 0; i<state.id.length;i++) {
        if (event.id == state.id[i]) return;
      }
      state.id.add(event.id);
      state.amount.add(1);
      emit(HomeStates(id: state.id, amount: state.amount));
    });
    on<Remove>((event, emit){
      state.id.removeAt(event.position);
      state.amount.removeAt(event.position);
      emit(HomeStates(id: state.id, amount: state.amount));
    });
    on<Add>((event,emit){
      state.amount[event.position]++;
      emit(HomeStates(id: state.id, amount: state.amount));
    });
    on<Minus>((event,emit){
      if (state.amount[event.position] == 1) {
        state.id.removeAt(event.position);
        state.amount.removeAt(event.position);
        emit(HomeStates(id: state.id, amount: state.amount));
      }
      else{
        state.amount[event.position]--;
      }
      emit(HomeStates(id: state.id, amount: state.amount));
    });
  }
}