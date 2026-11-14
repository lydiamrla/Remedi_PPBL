import 'package:flutter/material.dart';
import '../models/hasil_deteksi.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tujuan Aplikasi',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'AgriVision CNN adalah aplikasi pencatatan hasil deteksi penyakit dan hama padi '
              'berbasis model EfficientNet-B0 untuk membantu kelompok tani memantau riwayat '
              'kesehatan tanaman pada Petak 1 dan Petak 2 secara terstruktur.',
            ),
            const SizedBox(height: 20),
            Text(
              'Daftar 5 Kelas Prediksi',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: daftarKelasPadi.length,
                itemBuilder: (context, index) {
                  final kelas = daftarKelasPadi[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(kelas),
                      subtitle: Text(rekomendasiPenanganan[kelas] ?? ''),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}