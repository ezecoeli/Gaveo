import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// Título de la app
  ///
  /// In es, this message translates to:
  /// **'Gaveo'**
  String get appTitle;

  /// No description provided for @navInicio.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navInicio;

  /// No description provided for @navFijos.
  ///
  /// In es, this message translates to:
  /// **'Fijos'**
  String get navFijos;

  /// No description provided for @navVariables.
  ///
  /// In es, this message translates to:
  /// **'Variables'**
  String get navVariables;

  /// No description provided for @navDelivery.
  ///
  /// In es, this message translates to:
  /// **'Delivery'**
  String get navDelivery;

  /// No description provided for @navAhorros.
  ///
  /// In es, this message translates to:
  /// **'Ahorros'**
  String get navAhorros;

  /// No description provided for @saldoDisponible.
  ///
  /// In es, this message translates to:
  /// **'Saldo disponible'**
  String get saldoDisponible;

  /// No description provided for @porcentajeComprometido.
  ///
  /// In es, this message translates to:
  /// **'{pct}% comprometido'**
  String porcentajeComprometido(String pct);

  /// No description provided for @ingresos.
  ///
  /// In es, this message translates to:
  /// **'Ingresos'**
  String get ingresos;

  /// No description provided for @gastosFijos.
  ///
  /// In es, this message translates to:
  /// **'Gastos fijos'**
  String get gastosFijos;

  /// No description provided for @gastosVariables.
  ///
  /// In es, this message translates to:
  /// **'Gastos variables'**
  String get gastosVariables;

  /// No description provided for @delivery.
  ///
  /// In es, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @ahorros.
  ///
  /// In es, this message translates to:
  /// **'Ahorros'**
  String get ahorros;

  /// No description provided for @errorGenerico.
  ///
  /// In es, this message translates to:
  /// **'Ocurrió un error'**
  String get errorGenerico;

  /// No description provided for @reintentar.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get reintentar;

  /// No description provided for @configTitle.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get configTitle;

  /// No description provided for @errorCargarConfig.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar configuración'**
  String get errorCargarConfig;

  /// No description provided for @perfil.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get perfil;

  /// No description provided for @tuNombre.
  ///
  /// In es, this message translates to:
  /// **'Tu nombre'**
  String get tuNombre;

  /// No description provided for @campoRequerido.
  ///
  /// In es, this message translates to:
  /// **'Campo requerido'**
  String get campoRequerido;

  /// No description provided for @moneda.
  ///
  /// In es, this message translates to:
  /// **'Moneda'**
  String get moneda;

  /// No description provided for @codigoMoneda.
  ///
  /// In es, this message translates to:
  /// **'Código (ej: ARS)'**
  String get codigoMoneda;

  /// No description provided for @simbolo.
  ///
  /// In es, this message translates to:
  /// **'Símbolo'**
  String get simbolo;

  /// No description provided for @requerido.
  ///
  /// In es, this message translates to:
  /// **'Requerido'**
  String get requerido;

  /// No description provided for @seleccionarMoneda.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar moneda'**
  String get seleccionarMoneda;

  /// No description provided for @buscarMoneda.
  ///
  /// In es, this message translates to:
  /// **'Buscar moneda...'**
  String get buscarMoneda;

  /// No description provided for @monedaSeleccionada.
  ///
  /// In es, this message translates to:
  /// **'Moneda seleccionada'**
  String get monedaSeleccionada;

  /// No description provided for @sinResultados.
  ///
  /// In es, this message translates to:
  /// **'Sin resultados'**
  String get sinResultados;

  /// No description provided for @presupuestoDelivery.
  ///
  /// In es, this message translates to:
  /// **'Presupuesto mensual de delivery'**
  String get presupuestoDelivery;

  /// No description provided for @configGuardada.
  ///
  /// In es, this message translates to:
  /// **'Configuración guardada'**
  String get configGuardada;

  /// No description provided for @guardar.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get guardar;

  /// No description provided for @idioma.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get idioma;

  /// No description provided for @bienvenido.
  ///
  /// In es, this message translates to:
  /// **'¡Bienvenido a Gaveo!'**
  String get bienvenido;

  /// No description provided for @configuraTuPerfil.
  ///
  /// In es, this message translates to:
  /// **'Configurá tu perfil para comenzar.'**
  String get configuraTuPerfil;

  /// No description provided for @tuNombreRequerido.
  ///
  /// In es, this message translates to:
  /// **'Tu nombre *'**
  String get tuNombreRequerido;

  /// No description provided for @presupuestoDeliveryOpcional.
  ///
  /// In es, this message translates to:
  /// **'Presupuesto delivery mensual (opcional)'**
  String get presupuestoDeliveryOpcional;

  /// No description provided for @comenzar.
  ///
  /// In es, this message translates to:
  /// **'Comenzar'**
  String get comenzar;

  /// No description provided for @proximamente.
  ///
  /// In es, this message translates to:
  /// **'Próximamente'**
  String get proximamente;

  /// No description provided for @agregar.
  ///
  /// In es, this message translates to:
  /// **'Agregar'**
  String get agregar;

  /// No description provided for @editar.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get editar;

  /// No description provided for @eliminar.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get eliminar;

  /// No description provided for @cancelar.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancelar;

  /// No description provided for @monto.
  ///
  /// In es, this message translates to:
  /// **'Monto'**
  String get monto;

  /// No description provided for @montoInvalido.
  ///
  /// In es, this message translates to:
  /// **'Ingresá un monto válido'**
  String get montoInvalido;

  /// No description provided for @notasOpcional.
  ///
  /// In es, this message translates to:
  /// **'Notas (opcional)'**
  String get notasOpcional;

  /// No description provided for @agregarGastoFijo.
  ///
  /// In es, this message translates to:
  /// **'Agregar gasto fijo'**
  String get agregarGastoFijo;

  /// No description provided for @editarGastoFijo.
  ///
  /// In es, this message translates to:
  /// **'Editar gasto fijo'**
  String get editarGastoFijo;

  /// No description provided for @sinGastosFijos.
  ///
  /// In es, this message translates to:
  /// **'Sin gastos fijos'**
  String get sinGastosFijos;

  /// No description provided for @sinGastosFijosDesc.
  ///
  /// In es, this message translates to:
  /// **'Tocá + para agregar un gasto recurrente'**
  String get sinGastosFijosDesc;

  /// No description provided for @nombreDelGasto.
  ///
  /// In es, this message translates to:
  /// **'Nombre del gasto'**
  String get nombreDelGasto;

  /// No description provided for @diaVencimiento.
  ///
  /// In es, this message translates to:
  /// **'Día de vencimiento (1-31)'**
  String get diaVencimiento;

  /// No description provided for @diaInvalido.
  ///
  /// In es, this message translates to:
  /// **'Día inválido (1-31)'**
  String get diaInvalido;

  /// No description provided for @venceElDia.
  ///
  /// In es, this message translates to:
  /// **'Vence el día {dia}'**
  String venceElDia(int dia);

  /// No description provided for @pagado.
  ///
  /// In es, this message translates to:
  /// **'Pagado'**
  String get pagado;

  /// No description provided for @pendiente.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get pendiente;

  /// No description provided for @confirmarEliminar.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar este gasto?'**
  String get confirmarEliminar;

  /// No description provided for @confirmarEliminarDesc.
  ///
  /// In es, this message translates to:
  /// **'Esta acción no se puede deshacer.'**
  String get confirmarEliminarDesc;

  /// No description provided for @gastoAgregado.
  ///
  /// In es, this message translates to:
  /// **'Gasto agregado'**
  String get gastoAgregado;

  /// No description provided for @gastoActualizado.
  ///
  /// In es, this message translates to:
  /// **'Gasto actualizado'**
  String get gastoActualizado;

  /// No description provided for @gastoEliminado.
  ///
  /// In es, this message translates to:
  /// **'Gasto eliminado'**
  String get gastoEliminado;

  /// No description provided for @categoria.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get categoria;

  /// No description provided for @catGeneral.
  ///
  /// In es, this message translates to:
  /// **'General'**
  String get catGeneral;

  /// No description provided for @catServicios.
  ///
  /// In es, this message translates to:
  /// **'Servicios'**
  String get catServicios;

  /// No description provided for @catAlquiler.
  ///
  /// In es, this message translates to:
  /// **'Alquiler'**
  String get catAlquiler;

  /// No description provided for @catInternet.
  ///
  /// In es, this message translates to:
  /// **'Internet'**
  String get catInternet;

  /// No description provided for @catSeguro.
  ///
  /// In es, this message translates to:
  /// **'Seguro'**
  String get catSeguro;

  /// No description provided for @catSalud.
  ///
  /// In es, this message translates to:
  /// **'Salud'**
  String get catSalud;

  /// No description provided for @catEducacion.
  ///
  /// In es, this message translates to:
  /// **'Educación'**
  String get catEducacion;

  /// No description provided for @catSuscripciones.
  ///
  /// In es, this message translates to:
  /// **'Suscripciones'**
  String get catSuscripciones;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
