import 'package:flutter/material.dart';
import '../models/hasil_deteksi.dart';

class DeteksiCard extends StatelessWidget {
  final HasilDeteksi data;
  final VoidCallback onDelete;

  const DeteksiCard({
    super.key,
    required this.data,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    Color statusColor;
    IconData statusIcon;

    if (data.status == 'Sehat') {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle_outline;
    } else if (data.status == 'Tidak Pasti') {
      statusColor = Colors.orange;
      statusIcon = Icons.help_outline;
    } else {
      statusColor = colors.error;
      statusIcon = Icons.warning_amber_rounded;
    }

    final waktuStr =
        '${data.waktu.day.toString().padLeft(2, '0')}/${data.waktu.month.toString().padLeft(2, '0')}/${data.waktu.year} '
        '${data.waktu.hour.toString().padLeft(2, '0')}:${data.waktu.minute.toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${data.petak} - ${data.kelas}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                  tooltip: 'Hapus data',
                ),
              ],
            ),
            Text(
              data.status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text('Skor: ${data.skor}%'),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: data.skor / 100,
              color: statusColor,
              backgroundColor: statusColor.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 10),
            Text(
              data.rekomendasi,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 6),
            Text(
              '${data.namaPetugas} • $waktuStr',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}