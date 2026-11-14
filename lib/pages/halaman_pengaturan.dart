import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/deteksi_bloc.dart';
import '../state/deteksi_event.dart';
import '../state/theme_cubit.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  void _konfirmasiHapusSemua(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Semua Data?'),
        content: const Text('Semua riwayat deteksi akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              context.read<DeteksiBloc>().add(HapusSemuaDeteksiEvent());
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Semua data berhasil dihapus')),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return SwitchListTile(
                title: const Text('Mode Gelap'),
                value: themeMode == ThemeMode.dark,
                onChanged: (val) =>
                    context.read<ThemeCubit>().toggleTheme(val),
              );
            },
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              context.read<DeteksiBloc>().add(MuatSimulasiEvent());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('10 data simulasi berhasil dimuat')),
              );
            },
            child: const Text('Muat Data Simulasi'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => _konfirmasiHapusSemua(context),
            child: const Text('Hapus Semua Data'),
          ),
        ],
      ),
    );
  }
}