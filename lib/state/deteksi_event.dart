import '../models/hasil_deteksi.dart';

abstract class DeteksiEvent {}

class TambahDeteksiEvent extends DeteksiEvent {
  final HasilDeteksi data;
  TambahDeteksiEvent(this.data);
}

class HapusDeteksiEvent extends DeteksiEvent {
  final String id;
  HapusDeteksiEvent(this.id);
}

class FilterPetakEvent extends DeteksiEvent {
  final String filterPetak; // 'Semua', 'Petak 1', 'Petak 2'
  FilterPetakEvent(this.filterPetak);
}

class MuatSimulasiEvent extends DeteksiEvent {}

class HapusSemuaDeteksiEvent extends DeteksiEvent {}