import '../models/hasil_deteksi.dart';

class DeteksiState {
  final List<HasilDeteksi> semuaData;
  final String filterPetak;

  DeteksiState({
    this.semuaData = const [],
    this.filterPetak = 'Semua',
  });

  List<HasilDeteksi> get dataTersaring {
    if (filterPetak == 'Semua') return semuaData;
    return semuaData.where((e) => e.petak == filterPetak).toList();
  }

  int get totalData => dataTersaring.length;
  int get totalSehat => dataTersaring.where((e) => e.status == 'Sehat').length;
  int get totalPerluTindakan =>
      dataTersaring.where((e) => e.status == 'Perlu Tindakan').length;

  // Untuk Badge pada tab Deteksi (menghitung seluruh data yang Perlu Tindakan)
  int get badgePerluTindakan =>
      semuaData.where((e) => e.status == 'Perlu Tindakan').length;

  DeteksiState copyWith({
    List<HasilDeteksi>? semuaData,
    String? filterPetak,
  }) {
    return DeteksiState(
      semuaData: semuaData ?? this.semuaData,
      filterPetak: filterPetak ?? this.filterPetak,
    );
  }
}