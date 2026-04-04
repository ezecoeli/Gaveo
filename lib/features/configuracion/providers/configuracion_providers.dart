import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';

part 'configuracion_providers.g.dart';

// ── Modelo ────────────────────────────────────────────────────────────────────

class ConfiguracionData {
  final String nombreUsuario;
  final String moneda;
  final String simbolo;
  final double presupuestoDelivery;
  final String idioma;
  final String tema; // 'light' | 'dark' | 'system'

  const ConfiguracionData({
    required this.nombreUsuario,
    required this.moneda,
    required this.simbolo,
    required this.presupuestoDelivery,
    this.idioma = AppConstants.defaultIdioma,
    this.tema = AppConstants.defaultTema,
  });

  bool get estaConfigurado => nombreUsuario.isNotEmpty;

  static const ConfiguracionData defaults = ConfiguracionData(
    nombreUsuario: '',
    moneda: AppConstants.defaultMoneda,
    simbolo: AppConstants.defaultSimbolo,
    presupuestoDelivery: AppConstants.defaultPresupuestoDelivery,
    idioma: AppConstants.defaultIdioma,    tema: AppConstants.defaultTema,  );
}

// ── Notifier ──────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
class ConfiguracionNotifier extends _$ConfiguracionNotifier {
  @override
  Stream<ConfiguracionData> build() {
    final db = ref.watch(appDatabaseProvider);
    return db.configuracionDao.watchConfiguracion().map((map) {
      return ConfiguracionData(
        nombreUsuario: map[AppConstants.keyNombreUsuario] ?? '',
        moneda: map[AppConstants.keyMoneda] ?? AppConstants.defaultMoneda,
        simbolo: map[AppConstants.keySimbolo] ?? AppConstants.defaultSimbolo,
        presupuestoDelivery: double.tryParse(
              map[AppConstants.keyPresupuestoDelivery] ?? '0',
            ) ??
            0.0,
        idioma: map[AppConstants.keyIdioma] ?? AppConstants.defaultIdioma,
        tema: map[AppConstants.keyTema] ?? AppConstants.defaultTema,
      );
    });
  }

  Future<void> guardar({
    required String nombreUsuario,
    required String moneda,
    required String simbolo,
    required double presupuestoDelivery,
    String idioma = AppConstants.defaultIdioma,
    String tema = AppConstants.defaultTema,
  }) async {
    final dao = ref.read(appDatabaseProvider).configuracionDao;
    await dao.setValor(AppConstants.keyNombreUsuario, nombreUsuario);
    await dao.setValor(AppConstants.keyMoneda, moneda);
    await dao.setValor(AppConstants.keySimbolo, simbolo);
    await dao.setValor(
      AppConstants.keyPresupuestoDelivery,
      presupuestoDelivery.toString(),
    );
    await dao.setValor(AppConstants.keyIdioma, idioma);
    await dao.setValor(AppConstants.keyTema, tema);
  }
}
