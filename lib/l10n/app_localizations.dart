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
  /// **'Resumen'**
  String get navInicio;

  /// No description provided for @navFijos.
  ///
  /// In es, this message translates to:
  /// **'Fijos'**
  String get navFijos;

  /// No description provided for @navVariables.
  ///
  /// In es, this message translates to:
  /// **'Varios'**
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
  /// **'{pct}% volando 💸'**
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

  /// No description provided for @ver.
  ///
  /// In es, this message translates to:
  /// **'Ver'**
  String get ver;

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
  /// **'Configura tu perfil para comenzar.'**
  String get configuraTuPerfil;

  /// No description provided for @tuNombreRequerido.
  ///
  /// In es, this message translates to:
  /// **'Tu nombre *'**
  String get tuNombreRequerido;

  /// No description provided for @presupuestoDeliveryOpcional.
  ///
  /// In es, this message translates to:
  /// **'Monto mensual (opcional)'**
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

  /// No description provided for @agregarIngreso.
  ///
  /// In es, this message translates to:
  /// **'Agregar ingreso'**
  String get agregarIngreso;

  /// No description provided for @editarIngreso.
  ///
  /// In es, this message translates to:
  /// **'Editar ingreso'**
  String get editarIngreso;

  /// No description provided for @sinIngresos.
  ///
  /// In es, this message translates to:
  /// **'Sin ingresos este mes'**
  String get sinIngresos;

  /// No description provided for @sinIngresosDesc.
  ///
  /// In es, this message translates to:
  /// **'Tocá + para registrar un ingreso'**
  String get sinIngresosDesc;

  /// No description provided for @fuente.
  ///
  /// In es, this message translates to:
  /// **'Fuente de ingreso'**
  String get fuente;

  /// No description provided for @fecha.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get fecha;

  /// No description provided for @ingresoAgregado.
  ///
  /// In es, this message translates to:
  /// **'Ingreso registrado'**
  String get ingresoAgregado;

  /// No description provided for @ingresoActualizado.
  ///
  /// In es, this message translates to:
  /// **'Ingreso actualizado'**
  String get ingresoActualizado;

  /// No description provided for @ingresoEliminado.
  ///
  /// In es, this message translates to:
  /// **'Ingreso eliminado'**
  String get ingresoEliminado;

  /// No description provided for @agregarGastoVariable.
  ///
  /// In es, this message translates to:
  /// **'Agregar gasto variable'**
  String get agregarGastoVariable;

  /// No description provided for @editarGastoVariable.
  ///
  /// In es, this message translates to:
  /// **'Editar gasto variable'**
  String get editarGastoVariable;

  /// No description provided for @sinGastosVariables.
  ///
  /// In es, this message translates to:
  /// **'Sin gastos este mes'**
  String get sinGastosVariables;

  /// No description provided for @sinGastosVariablesDesc.
  ///
  /// In es, this message translates to:
  /// **'Tocá + para registrar un gasto'**
  String get sinGastosVariablesDesc;

  /// No description provided for @descripcion.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get descripcion;

  /// No description provided for @gastoVariableAgregado.
  ///
  /// In es, this message translates to:
  /// **'Gasto registrado'**
  String get gastoVariableAgregado;

  /// No description provided for @gastoVariableActualizado.
  ///
  /// In es, this message translates to:
  /// **'Gasto actualizado'**
  String get gastoVariableActualizado;

  /// No description provided for @gastoVariableEliminado.
  ///
  /// In es, this message translates to:
  /// **'Gasto eliminado'**
  String get gastoVariableEliminado;

  /// No description provided for @catImprevisto.
  ///
  /// In es, this message translates to:
  /// **'Imprevisto'**
  String get catImprevisto;

  /// No description provided for @catComida.
  ///
  /// In es, this message translates to:
  /// **'Comida'**
  String get catComida;

  /// No description provided for @catTransporte.
  ///
  /// In es, this message translates to:
  /// **'Transporte'**
  String get catTransporte;

  /// No description provided for @catRopa.
  ///
  /// In es, this message translates to:
  /// **'Ropa'**
  String get catRopa;

  /// No description provided for @catEntretenimiento.
  ///
  /// In es, this message translates to:
  /// **'Entretenimiento'**
  String get catEntretenimiento;

  /// No description provided for @catFarmacia.
  ///
  /// In es, this message translates to:
  /// **'Farmacia'**
  String get catFarmacia;

  /// No description provided for @catHogar.
  ///
  /// In es, this message translates to:
  /// **'Hogar'**
  String get catHogar;

  /// No description provided for @catElectricidad.
  ///
  /// In es, this message translates to:
  /// **'Electricidad'**
  String get catElectricidad;

  /// No description provided for @catAgua.
  ///
  /// In es, this message translates to:
  /// **'Agua'**
  String get catAgua;

  /// No description provided for @catOtro.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get catOtro;

  /// No description provided for @catDelivery.
  ///
  /// In es, this message translates to:
  /// **'Delivery'**
  String get catDelivery;

  /// No description provided for @agregarDelivery.
  ///
  /// In es, this message translates to:
  /// **'Agregar pedido'**
  String get agregarDelivery;

  /// No description provided for @editarDelivery.
  ///
  /// In es, this message translates to:
  /// **'Editar pedido'**
  String get editarDelivery;

  /// No description provided for @sinDelivery.
  ///
  /// In es, this message translates to:
  /// **'Sin pedidos este mes'**
  String get sinDelivery;

  /// No description provided for @sinDeliveryDesc.
  ///
  /// In es, this message translates to:
  /// **'Tocá + para registrar un pedido'**
  String get sinDeliveryDesc;

  /// No description provided for @deliveryAgregado.
  ///
  /// In es, this message translates to:
  /// **'Pedido registrado'**
  String get deliveryAgregado;

  /// No description provided for @deliveryActualizado.
  ///
  /// In es, this message translates to:
  /// **'Pedido actualizado'**
  String get deliveryActualizado;

  /// No description provided for @deliveryEliminado.
  ///
  /// In es, this message translates to:
  /// **'Pedido eliminado'**
  String get deliveryEliminado;

  /// No description provided for @plataformaOpcional.
  ///
  /// In es, this message translates to:
  /// **'Plataforma (opcional)'**
  String get plataformaOpcional;

  /// No description provided for @presupuestoNoDefinido.
  ///
  /// In es, this message translates to:
  /// **'Sin presupuesto definido'**
  String get presupuestoNoDefinido;

  /// No description provided for @gastadoLabel.
  ///
  /// In es, this message translates to:
  /// **'Gastado'**
  String get gastadoLabel;

  /// No description provided for @presupuestoLabel.
  ///
  /// In es, this message translates to:
  /// **'Presupuesto'**
  String get presupuestoLabel;

  /// No description provided for @agregarMeta.
  ///
  /// In es, this message translates to:
  /// **'Agregar meta'**
  String get agregarMeta;

  /// No description provided for @editarMeta.
  ///
  /// In es, this message translates to:
  /// **'Editar meta'**
  String get editarMeta;

  /// No description provided for @sinAhorros.
  ///
  /// In es, this message translates to:
  /// **'Sin metas de ahorro'**
  String get sinAhorros;

  /// No description provided for @sinAhorrosDesc.
  ///
  /// In es, this message translates to:
  /// **'Tocá + para crear tu primera meta'**
  String get sinAhorrosDesc;

  /// No description provided for @metaAgregada.
  ///
  /// In es, this message translates to:
  /// **'Meta creada'**
  String get metaAgregada;

  /// No description provided for @metaActualizada.
  ///
  /// In es, this message translates to:
  /// **'Meta actualizada'**
  String get metaActualizada;

  /// No description provided for @metaEliminada.
  ///
  /// In es, this message translates to:
  /// **'Meta eliminada'**
  String get metaEliminada;

  /// No description provided for @nombreMeta.
  ///
  /// In es, this message translates to:
  /// **'Nombre de la meta'**
  String get nombreMeta;

  /// No description provided for @montoMensual.
  ///
  /// In es, this message translates to:
  /// **'Ahorro mensual'**
  String get montoMensual;

  /// No description provided for @montoObjetivo.
  ///
  /// In es, this message translates to:
  /// **'Monto objetivo (opcional)'**
  String get montoObjetivo;

  /// No description provided for @catAhorro.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get catAhorro;

  /// No description provided for @catAhorroGeneral.
  ///
  /// In es, this message translates to:
  /// **'General'**
  String get catAhorroGeneral;

  /// No description provided for @catAhorroVivienda.
  ///
  /// In es, this message translates to:
  /// **'Vivienda'**
  String get catAhorroVivienda;

  /// No description provided for @catAhorroTransporte.
  ///
  /// In es, this message translates to:
  /// **'Transporte'**
  String get catAhorroTransporte;

  /// No description provided for @catAhorroViaje.
  ///
  /// In es, this message translates to:
  /// **'Viaje'**
  String get catAhorroViaje;

  /// No description provided for @catAhorroTecnologia.
  ///
  /// In es, this message translates to:
  /// **'Tecnología'**
  String get catAhorroTecnologia;

  /// No description provided for @catAhorroEducacion.
  ///
  /// In es, this message translates to:
  /// **'Educación'**
  String get catAhorroEducacion;

  /// No description provided for @catAhorroSalud.
  ///
  /// In es, this message translates to:
  /// **'Salud'**
  String get catAhorroSalud;

  /// No description provided for @catAhorroEmergencia.
  ///
  /// In es, this message translates to:
  /// **'Emergencia'**
  String get catAhorroEmergencia;

  /// No description provided for @catAhorroJubilacion.
  ///
  /// In es, this message translates to:
  /// **'Jubilación'**
  String get catAhorroJubilacion;

  /// No description provided for @activo.
  ///
  /// In es, this message translates to:
  /// **'Activo'**
  String get activo;

  /// No description provided for @inactivo.
  ///
  /// In es, this message translates to:
  /// **'Inactivo'**
  String get inactivo;

  /// No description provided for @totalMensual.
  ///
  /// In es, this message translates to:
  /// **'Total mensual'**
  String get totalMensual;

  /// No description provided for @metaLabel.
  ///
  /// In es, this message translates to:
  /// **'Objetivo'**
  String get metaLabel;

  /// No description provided for @confirmarEliminarMeta.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar esta meta?'**
  String get confirmarEliminarMeta;

  /// No description provided for @hola.
  ///
  /// In es, this message translates to:
  /// **'Hola, {nombre}'**
  String hola(String nombre);

  /// No description provided for @distribucionGastos.
  ///
  /// In es, this message translates to:
  /// **'Distribución de gastos'**
  String get distribucionGastos;

  /// No description provided for @sinDatosGrafico.
  ///
  /// In es, this message translates to:
  /// **'Sin gastos para mostrar'**
  String get sinDatosGrafico;

  /// No description provided for @pagadosDe.
  ///
  /// In es, this message translates to:
  /// **'{pagados} de {total} pagados'**
  String pagadosDe(int pagados, int total);

  /// No description provided for @gastadoDe.
  ///
  /// In es, this message translates to:
  /// **'{gastado} de {presupuesto}'**
  String gastadoDe(String gastado, String presupuesto);

  /// No description provided for @exportarPDF.
  ///
  /// In es, this message translates to:
  /// **'Exportar resumen'**
  String get exportarPDF;

  /// No description provided for @generandoPDF.
  ///
  /// In es, this message translates to:
  /// **'Generando resumen...'**
  String get generandoPDF;

  /// No description provided for @resumenMensual.
  ///
  /// In es, this message translates to:
  /// **'Resumen mensual'**
  String get resumenMensual;

  /// No description provided for @notifVencimientoTitle.
  ///
  /// In es, this message translates to:
  /// **'Vencimiento hoy'**
  String get notifVencimientoTitle;

  /// No description provided for @notifVencimientoBody.
  ///
  /// In es, this message translates to:
  /// **'{nombre} vence hoy'**
  String notifVencimientoBody(String nombre);

  /// No description provided for @historial.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get historial;

  /// No description provided for @gastos.
  ///
  /// In es, this message translates to:
  /// **'Gastos'**
  String get gastos;

  /// No description provided for @saldo.
  ///
  /// In es, this message translates to:
  /// **'Saldo'**
  String get saldo;

  /// No description provided for @tema.
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get tema;

  /// No description provided for @temaClaro.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get temaClaro;

  /// No description provided for @temaOscuro.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get temaOscuro;

  /// No description provided for @navIngresos.
  ///
  /// In es, this message translates to:
  /// **'Ingresos'**
  String get navIngresos;

  /// No description provided for @mostrarEnInicio.
  ///
  /// In es, this message translates to:
  /// **'Mostrar en inicio'**
  String get mostrarEnInicio;

  /// No description provided for @mostrarEnInicioDesc.
  ///
  /// In es, this message translates to:
  /// **'Aparece en el resumen del dashboard independientemente de otras condiciones'**
  String get mostrarEnInicioDesc;

  /// No description provided for @sinFechaVencimiento.
  ///
  /// In es, this message translates to:
  /// **'Sin fecha de vencimiento'**
  String get sinFechaVencimiento;

  /// No description provided for @diaVencimientoOpcional.
  ///
  /// In es, this message translates to:
  /// **'Día de vencimiento (opcional)'**
  String get diaVencimientoOpcional;

  /// No description provided for @limite.
  ///
  /// In es, this message translates to:
  /// **'Límite mensual'**
  String get limite;

  /// No description provided for @limiteOpcional.
  ///
  /// In es, this message translates to:
  /// **'Límite mensual (opcional)'**
  String get limiteOpcional;

  /// No description provided for @limiteDesc.
  ///
  /// In es, this message translates to:
  /// **'Muestra esta categoría en el dashboard con progreso'**
  String get limiteDesc;

  /// No description provided for @configurarCategorias.
  ///
  /// In es, this message translates to:
  /// **'Configurar categorías'**
  String get configurarCategorias;

  /// No description provided for @seguimiento.
  ///
  /// In es, this message translates to:
  /// **'Seguimiento'**
  String get seguimiento;

  /// No description provided for @dePresupuesto.
  ///
  /// In es, this message translates to:
  /// **'del presupuesto'**
  String get dePresupuesto;

  /// No description provided for @sinLimite.
  ///
  /// In es, this message translates to:
  /// **'Sin límite'**
  String get sinLimite;

  /// No description provided for @verMisFinanzas.
  ///
  /// In es, this message translates to:
  /// **'Ver mis finanzas'**
  String get verMisFinanzas;

  /// No description provided for @estadoDelMes.
  ///
  /// In es, this message translates to:
  /// **'Estado del mes'**
  String get estadoDelMes;

  /// No description provided for @vasBien.
  ///
  /// In es, this message translates to:
  /// **'Vas bien este mes 🟢'**
  String get vasBien;

  /// No description provided for @casiAlLimite.
  ///
  /// In es, this message translates to:
  /// **'Casi al límite 🟡'**
  String get casiAlLimite;

  /// No description provided for @presupuestoComprometido.
  ///
  /// In es, this message translates to:
  /// **'¡Al límite! 🔴'**
  String get presupuestoComprometido;

  /// No description provided for @comprometido.
  ///
  /// In es, this message translates to:
  /// **'volando 💸'**
  String get comprometido;

  /// No description provided for @helpTitulo.
  ///
  /// In es, this message translates to:
  /// **'Ayuda'**
  String get helpTitulo;

  /// No description provided for @helpDeslizarEliminar.
  ///
  /// In es, this message translates to:
  /// **'Deslizá hacia la izquierda para eliminar un elemento'**
  String get helpDeslizarEliminar;

  /// No description provided for @helpTocarEditar.
  ///
  /// In es, this message translates to:
  /// **'Tocá un elemento para editarlo'**
  String get helpTocarEditar;

  /// No description provided for @helpFijosToggle.
  ///
  /// In es, this message translates to:
  /// **'Tocá el ícono de verificación para marcar el gasto como pagado o pendiente'**
  String get helpFijosToggle;

  /// No description provided for @helpFijosSaldo.
  ///
  /// In es, this message translates to:
  /// **'Los gastos fijos siempre se descuentan del saldo, estén pagados o no'**
  String get helpFijosSaldo;

  /// No description provided for @helpVariablesLimite.
  ///
  /// In es, this message translates to:
  /// **'En el formulario podés definir un límite mensual para cada categoría'**
  String get helpVariablesLimite;

  /// No description provided for @helpVariablesDestacado.
  ///
  /// In es, this message translates to:
  /// **'Activá \'Mostrar en inicio\' para ver la categoría en la sección Seguimiento del Resumen'**
  String get helpVariablesDestacado;

  /// No description provided for @helpDashboardMeses.
  ///
  /// In es, this message translates to:
  /// **'Usá las flechas del encabezado para navegar entre meses'**
  String get helpDashboardMeses;

  /// No description provided for @helpDashboardSeguimiento.
  ///
  /// In es, this message translates to:
  /// **'Las categorías con límite o fijadas al inicio aparecen en la sección Seguimiento'**
  String get helpDashboardSeguimiento;

  /// No description provided for @helpDashboardPDF.
  ///
  /// In es, this message translates to:
  /// **'Exportá el resumen del mes como PDF desde el ícono de documento en el encabezado del Resumen'**
  String get helpDashboardPDF;

  /// No description provided for @helpHistorialNavegar.
  ///
  /// In es, this message translates to:
  /// **'Tocá un mes para ir directamente a él en el Resumen'**
  String get helpHistorialNavegar;

  /// No description provided for @helpAhorroInactivo.
  ///
  /// In es, this message translates to:
  /// **'Las metas inactivas no se incluyen en el total mensual pero permanecen en la lista'**
  String get helpAhorroInactivo;

  /// No description provided for @helpIngresosMes.
  ///
  /// In es, this message translates to:
  /// **'Los ingresos se registran por mes; usá las flechas del Resumen para ver otros períodos'**
  String get helpIngresosMes;
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
