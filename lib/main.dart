import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_routes.dart';
import 'app_theme.dart';
import 'pages/halaman_input_deteksi.dart';
import 'pages/halaman_tentang.dart';
import 'pages/main_navigation.dart';
import 'state/deteksi_bloc.dart';
import 'state/theme_cubit.dart';

void main() {
  runApp(const AgriVisionApp());
}

class AgriVisionApp extends StatelessWidget {
  const AgriVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DeteksiBloc()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'AgriVision CNN',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            initialRoute: AppRoutes.beranda,
            routes: {
              AppRoutes.beranda: (_) => const MainNavigation(),
              AppRoutes.tentang: (_) => const HalamanTentang(),
              AppRoutes.inputDeteksi: (_) => const HalamanInputDeteksi(),
            },
          );
        },
      ),
    );
  }
}