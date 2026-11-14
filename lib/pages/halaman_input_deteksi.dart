import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/hasil_deteksi.dart';
import '../state/deteksi_bloc.dart';
import '../state/deteksi_event.dart';

class HalamanInputDeteksi extends StatefulWidget {
  const HalamanInputDeteksi({super.key});

  @override
  State<HalamanInputDeteksi> createState() => _HalamanInputDeteksiState();
}

class _HalamanInputDeteksiState extends State<HalamanInputDeteksi> {
  String _selectedPetak = 'Petak 1';
  String _selectedKelas = daftarKelasPadi.first;
  final TextEditingController _skorController = TextEditingController();
  final TextEditingController _petugasController = TextEditingController();
  bool _dataSudahBenar = false;

  String? _errorSkor;
  String? _errorPetugas;

  @override
  void dispose() {
    _skorController.dispose();
    _petugasController.dispose();
    super.dispose();
  }

  bool _validasiInput() {
    setState(() {
      _errorSkor = null;
      _errorPetugas = null;

      final skorInt = int.tryParse(_skorController.text.trim());
      if (skorInt == null || skorInt < 0 || skorInt > 100) {
        _errorSkor = 'Skor harus berupa angka bulat 0 - 100';
      }

      if (_petugasController.text.trim().isEmpty) {
        _errorPetugas = 'Nama petugas tidak boleh kosong';
      }
    });

    return _errorSkor == null && _errorPetugas == null;
  }

  void _konfirmasiSimpan() {
    if (!_validasiInput()) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Simpan'),
        content: const Text('Apakah Anda yakin ingin menyimpan hasil deteksi ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              final hasil = HasilDeteksi(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                petak: _selectedPetak,
                kelas: _selectedKelas,
                skor: int.parse(_skorController.text.trim()),
                namaPetugas: _petugasController.text.trim(),
                waktu: DateTime.now(),
              );

              context.read<DeteksiBloc>().add(TambahDeteksiEvent(hasil));

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data tersimpan')),
              );
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Deteksi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Petak', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: const Text('Petak 1'),
              value: 'Petak 1',
              groupValue: _selectedPetak,
              onChanged: (val) => setState(() => _selectedPetak = val!),
            ),
            RadioListTile<String>(
              title: const Text('Petak 2'),
              value: 'Petak 2',
              groupValue: _selectedPetak,
              onChanged: (val) => setState(() => _selectedPetak = val!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedKelas,
              decoration: const InputDecoration(
                labelText: 'Kelas',
                border: OutlineInputBorder(),
              ),
              items: daftarKelasPadi
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedKelas = val!),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _skorController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Skor Deteksi (%)',
                border: const OutlineInputBorder(),
                errorText: _errorSkor,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _petugasController,
              decoration: InputDecoration(
                labelText: 'Nama Petugas',
                border: const OutlineInputBorder(),
                errorText: _errorPetugas,
              ),
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text('Data sudah benar'),
              value: _dataSudahBenar,
              onChanged: (val) => setState(() => _dataSudahBenar = val ?? false),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _dataSudahBenar ? _konfirmasiSimpan : null,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}