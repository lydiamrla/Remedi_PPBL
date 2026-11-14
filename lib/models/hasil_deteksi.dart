import 'dart:math';

const Map<String, String> rekomendasiPenanganan = {
  'Hawar daun bakteri': 'Kurangi pupuk urea, buang air berlebih, bersihkan jerami yang sakit.',
  'Penyakit blas (jamur)': 'Jaga sawah tetap tergenang, semprot obat jamur saat padi keluar malai.',
  'Bercak coklat': 'Tambah pupuk kalium, jaga sawah tetap tergenang.',
  'Normal / Sehat': 'Tanaman sehat. Lanjutkan pemantauan rutin.',
  'Penyakit tungro (virus)': 'Cabut rumpun yang sakit, musim depan pakai varietas tahan.',
};

const List<String> daftarKelasPadi = [
  'Hawar daun bakteri',
  'Penyakit blas (jamur)',
  'Bercak coklat',
  'Normal / Sehat',
  'Penyakit tungro (virus)',
];

class HasilDeteksi {
  final String id;
  final String petak;
  final String kelas;
  final int skor;
  final String namaPetugas;
  final DateTime waktu;

  HasilDeteksi({
    required this.id,
    required this.petak,
    required this.kelas,
    required this.skor,
    required this.namaPetugas,
    required this.waktu,
  });

  String get status {
    if (kelas == 'Normal / Sehat') return 'Sehat';
    if (skor < 50) return 'Tidak Pasti';
    return 'Perlu Tindakan';
  }

  String get rekomendasi {
    if (status == 'Sehat') {
      return 'Lanjutkan pemantauan rutin';
    } else if (status == 'Tidak Pasti') {
      return 'Cek ulang oleh petugas';
    } else {
      final detail = rekomendasiPenanganan[kelas] ?? '';
      return 'Segera tangani: $detail';
    }
  }
}

List<HasilDeteksi> buatDataSimulasi() {
  final random = Random();
  final petakList = ['Petak 1', 'Petak 2'];
  final petugasList = ['Budi', 'Siti', 'Andi', 'Rina'];

  return List.generate(10, (index) {
    final petak = petakList[random.nextInt(petakList.length)];
    final kelas = daftarKelasPadi[random.nextInt(daftarKelasPadi.length)];
    final skor = 30 + random.nextInt(70); // Skor bulat 30 - 99
    final petugas = petugasList[random.nextInt(petugasList.length)];

    return HasilDeteksi(
      id: '${DateTime.now().microsecondsSinceEpoch}_$index',
      petak: petak,
      kelas: kelas,
      skor: skor,
      namaPetugas: petugas,
      waktu: DateTime.now().subtract(Duration(hours: index * 3)),
    );
  });
}