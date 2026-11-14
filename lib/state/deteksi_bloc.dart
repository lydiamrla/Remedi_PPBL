import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/hasil_deteksi.dart';
import 'deteksi_event.dart';
import 'deteksi_state.dart';

class DeteksiBloc extends Bloc<DeteksiEvent, DeteksiState> {
  DeteksiBloc() : super(DeteksiState()) {
    on<TambahDeteksiEvent>((event, emit) {
      final updated = [event.data, ...state.semuaData];
      emit(state.copyWith(semuaData: updated));
    });

    on<HapusDeteksiEvent>((event, emit) {
      final updated = state.semuaData.where((e) => e.id != event.id).toList();
      emit(state.copyWith(semuaData: updated));
    });

    on<FilterPetakEvent>((event, emit) {
      emit(state.copyWith(filterPetak: event.filterPetak));
    });

    on<MuatSimulasiEvent>((event, emit) {
      final simulasi = buatDataSimulasi();
      emit(state.copyWith(semuaData: [...simulasi, ...state.semuaData]));
    });

    on<HapusSemuaDeteksiEvent>((event, emit) {
      emit(state.copyWith(semuaData: []));
    });
  }
}