import 'package:flutter/material.dart';
import '../app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Selamat Datang di AgriVision CNN',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Card(
            color: colors.surfaceContainerLow,
            child: const ListTile(
              leading: Icon(Icons.memory),
              title: Text('Model: EfficientNet-B0'),
              subtitle: Text('5 kelas (4 penyakit + 1 Normal / Sehat)'),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.tentang);
            },
            child: const Text('Tentang Aplikasi'),
          ),
        ],
      ),
    );
  }
}