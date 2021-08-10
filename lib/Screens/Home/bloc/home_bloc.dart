import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:weight_app_firebase/DatabaseServices/DatabaseServices.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is AddWeight) {
      yield LoadingState();
      if (event.weight.isEmpty || event.weight.length < 1) {
        yield ErrorState(error: 'Please enter weight');
      }
      try {
        bool response = await DatabaseServices.addWeight(
            weight: event.weight, time: event.time);
        if (response == true) {
          yield InfoMessage(message: 'Weight added');
        } else {
          yield ErrorState(error: 'Weight added failed');
        }
      } catch (e) {
        print(e.toString());
        yield ErrorState(error: 'Weight added failed');
      }
    } else if (event is FetchWeights) {
      try {
        Stream<QuerySnapshot> querySnapshot = DatabaseServices.getWeightData();

        yield WeightsFetched(data: querySnapshot);
      } catch (e) {
        print(e.toString());
      }
    } else if (event is UpdateWeight) {
      yield LoadingState();
      if (event.weight.isEmpty || event.weight.length < 1) {
        yield ErrorState(error: 'Please enter weight');
      }
      try {
        bool response = await DatabaseServices.addWeight(
            weight: event.weight, time: event.time);
        if (response == true) {
          yield InfoMessage(message: 'Weight updated');
        } else {
          yield ErrorState(error: 'Weight update failed');
        }
      } catch (e) {
        print(e.toString());
        yield ErrorState(error: 'Weight update failed');
      }
    } else if (event is DeleteWeight) {
      yield LoadingState();

      try {
        bool response = await DatabaseServices.deleteWeight(id: event.id);
        if (response == true) {
          yield InfoMessage(message: 'Weight deleted');
        } else {
          yield ErrorState(error: 'Weight deletion failed');
        }
      } catch (e) {
        print(e.toString());
        yield ErrorState(error: 'Weight deletion failed');
      }
    }
  }
}
