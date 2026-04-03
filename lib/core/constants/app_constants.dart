class AppConstants {
  AppConstants._();

  // Configuración keys
  static const String keyMoneda = 'moneda';
  static const String keySimbolo = 'simbolo_moneda';
  static const String keyNombreUsuario = 'nombre_usuario';
  static const String keyPresupuestoDelivery = 'presupuesto_delivery_mensual';
  static const String keyIdioma = 'idioma';

  // Defaults
  static const String defaultMoneda = 'ARS';
  static const String defaultSimbolo = '\$';
  static const double defaultPresupuestoDelivery = 0.0;
  static const String defaultIdioma = 'es';

  // Límites
  static const int maxMesesFuturo = 1;
  static const double warningDeliveryPct = 0.8;
  static const double errorDeliveryPct = 1.0;
}
