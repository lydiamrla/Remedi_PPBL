import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_routes.dart';
import '../state/deteksi_bloc.dart';
import '../state/deteksi_event.dart';
import '../state/deteksi_state.dart';
import '../widgets/deteksi_card.dart';
import '../widgets/stat_card.dart';

class HalamanDeteksi extends StatelessWidget {
  const HalamanDeteksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DeteksiBloc, DeteksiState>(
        builder: (context, state) {
          final listData = state.dataTersaring;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Riwayat Deteksi',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Semua', label: Text('Semua')),
                    ButtonSegment(value: 'Petak 1', label: Text('Petak 1')),
                    ButtonSegment(value: 'Petak 2', label: Text('Petak 2')),
                  ],
                  selected: {state.filterPetak},
                  onSelectionChanged: (newSelection) {
                    context
                        .read<DeteksiBloc>()
                        .add(FilterPetakEvent(newSelection.first));
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    StatCard(title: 'Total', count: state.totalData),
                    const SizedBox(width: 8),
                    StatCard(title: 'Sehat', count: state.totalSehat),
                    const SizedBox(width: 8),
                    StatCard(
                        title: 'Perlu Tindakan',
                        count: state.totalPerluTindakan),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: listData.isEmpty
                      ? const Center(child: Text('Belum ada data'))
                      : ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            final item = listData[index];
                            return DeteksiCard(
                              data: item,
                              onDelete: () {
                                context
                                    .read<DeteksiBloc>()
                                    .add(HapusDeteksiEvent(item.id));
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.inputDeteksi);
        },
        icon: const Icon(Icons.add),
        label: const Text('Deteksi Baru'),
      ),
    );
  }
}