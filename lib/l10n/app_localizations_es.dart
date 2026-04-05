// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Gaveo';

  @override
  String get navInicio => 'Inicio';

  @override
  String get navFijos => 'Fijos';

  @override
  String get navVariables => 'Variables';

  @override
  String get navDelivery => 'Delivery';

  @override
  String get navAhorros => 'Ahorros';

  @override
  String get saldoDisponible => 'Saldo disponible';

  @override
  String porcentajeComprometido(String pct) {
    return '$pct% comprometido';
  }

  @override
  String get ingresos => 'Ingresos';

  @override
  String get gastosFijos => 'Gastos fijos';

  @override
  String get gastosVariables => 'Gastos variables';

  @override
  String get delivery => 'Delivery';

  @override
  String get ahorros => 'Ahorros';

  @override
  String get errorGenerico => 'Ocurrió un error';

  @override
  String get reintentar => 'Reintentar';

  @override
  String get configTitle => 'Configuración';

  @override
  String get errorCargarConfig => 'Error al cargar configuración';

  @override
  String get perfil => 'Perfil';

  @override
  String get tuNombre => 'Tu nombre';

  @override
  String get campoRequerido => 'Campo requerido';

  @override
  String get moneda => 'Moneda';

  @override
  String get codigoMoneda => 'Código (ej: ARS)';

  @override
  String get simbolo => 'Símbolo';

  @override
  String get requerido => 'Requerido';

  @override
  String get seleccionarMoneda => 'Seleccionar moneda';

  @override
  String get buscarMoneda => 'Buscar moneda...';

  @override
  String get monedaSeleccionada => 'Moneda seleccionada';

  @override
  String get sinResultados => 'Sin resultados';

  @override
  String get presupuestoDelivery => 'Presupuesto mensual de delivery';

  @override
  String get configGuardada => 'Configuración guardada';

  @override
  String get guardar => 'Guardar';

  @override
  String get idioma => 'Idioma';

  @override
  String get bienvenido => '¡Bienvenido a Gaveo!';

  @override
  String get configuraTuPerfil => 'Configura tu perfil para comenzar.';

  @override
  String get tuNombreRequerido => 'Tu nombre *';

  @override
  String get presupuestoDeliveryOpcional => 'Monto mensual (opcional)';

  @override
  String get comenzar => 'Comenzar';

  @override
  String get proximamente => 'Próximamente';

  @override
  String get agregar => 'Agregar';

  @override
  String get editar => 'Editar';

  @override
  String get eliminar => 'Eliminar';

  @override
  String get cancelar => 'Cancelar';

  @override
  String get monto => 'Monto';

  @override
  String get montoInvalido => 'Ingresá un monto válido';

  @override
  String get notasOpcional => 'Notas (opcional)';

  @override
  String get agregarGastoFijo => 'Agregar gasto fijo';

  @override
  String get editarGastoFijo => 'Editar gasto fijo';

  @override
  String get sinGastosFijos => 'Sin gastos fijos';

  @override
  String get sinGastosFijosDesc => 'Tocá + para agregar un gasto recurrente';

  @override
  String get nombreDelGasto => 'Nombre del gasto';

  @override
  String get diaVencimiento => 'Día de vencimiento (1-31)';

  @override
  String get diaInvalido => 'Día inválido (1-31)';

  @override
  String venceElDia(int dia) {
    return 'Vence el día $dia';
  }

  @override
  String get pagado => 'Pagado';

  @override
  String get pendiente => 'Pendiente';

  @override
  String get confirmarEliminar => '¿Eliminar este gasto?';

  @override
  String get confirmarEliminarDesc => 'Esta acción no se puede deshacer.';

  @override
  String get gastoAgregado => 'Gasto agregado';

  @override
  String get gastoActualizado => 'Gasto actualizado';

  @override
  String get gastoEliminado => 'Gasto eliminado';

  @override
  String get categoria => 'Categoría';

  @override
  String get catGeneral => 'General';

  @override
  String get catServicios => 'Servicios';

  @override
  String get catAlquiler => 'Alquiler';

  @override
  String get catInternet => 'Internet';

  @override
  String get catSeguro => 'Seguro';

  @override
  String get catSalud => 'Salud';

  @override
  String get catEducacion => 'Educación';

  @override
  String get catSuscripciones => 'Suscripciones';

  @override
  String get agregarIngreso => 'Agregar ingreso';

  @override
  String get editarIngreso => 'Editar ingreso';

  @override
  String get sinIngresos => 'Sin ingresos este mes';

  @override
  String get sinIngresosDesc => 'Tocá + para registrar un ingreso';

  @override
  String get fuente => 'Fuente de ingreso';

  @override
  String get fecha => 'Fecha';

  @override
  String get ingresoAgregado => 'Ingreso registrado';

  @override
  String get ingresoActualizado => 'Ingreso actualizado';

  @override
  String get ingresoEliminado => 'Ingreso eliminado';

  @override
  String get agregarGastoVariable => 'Agregar gasto variable';

  @override
  String get editarGastoVariable => 'Editar gasto variable';

  @override
  String get sinGastosVariables => 'Sin gastos este mes';

  @override
  String get sinGastosVariablesDesc => 'Tocá + para registrar un gasto';

  @override
  String get descripcion => 'Descripción';

  @override
  String get gastoVariableAgregado => 'Gasto registrado';

  @override
  String get gastoVariableActualizado => 'Gasto actualizado';

  @override
  String get gastoVariableEliminado => 'Gasto eliminado';

  @override
  String get catImprevisto => 'Imprevisto';

  @override
  String get catComida => 'Comida';

  @override
  String get catTransporte => 'Transporte';

  @override
  String get catRopa => 'Ropa';

  @override
  String get catEntretenimiento => 'Entretenimiento';

  @override
  String get catFarmacia => 'Farmacia';

  @override
  String get catHogar => 'Hogar';

  @override
  String get catElectricidad => 'Electricidad';

  @override
  String get catAgua => 'Agua';

  @override
  String get catOtro => 'Otro';

  @override
  String get agregarDelivery => 'Agregar pedido';

  @override
  String get editarDelivery => 'Editar pedido';

  @override
  String get sinDelivery => 'Sin pedidos este mes';

  @override
  String get sinDeliveryDesc => 'Tocá + para registrar un pedido';

  @override
  String get deliveryAgregado => 'Pedido registrado';

  @override
  String get deliveryActualizado => 'Pedido actualizado';

  @override
  String get deliveryEliminado => 'Pedido eliminado';

  @override
  String get plataformaOpcional => 'Plataforma (opcional)';

  @override
  String get presupuestoNoDefinido => 'Sin presupuesto definido';

  @override
  String get gastadoLabel => 'Gastado';

  @override
  String get presupuestoLabel => 'Presupuesto';

  @override
  String get agregarMeta => 'Agregar meta';

  @override
  String get editarMeta => 'Editar meta';

  @override
  String get sinAhorros => 'Sin metas de ahorro';

  @override
  String get sinAhorrosDesc => 'Tocá + para crear tu primera meta';

  @override
  String get metaAgregada => 'Meta creada';

  @override
  String get metaActualizada => 'Meta actualizada';

  @override
  String get metaEliminada => 'Meta eliminada';

  @override
  String get nombreMeta => 'Nombre de la meta';

  @override
  String get montoMensual => 'Ahorro mensual';

  @override
  String get montoObjetivo => 'Monto objetivo (opcional)';

  @override
  String get emojiMeta => 'Emoji';

  @override
  String get activo => 'Activo';

  @override
  String get inactivo => 'Inactivo';

  @override
  String get totalMensual => 'Total mensual';

  @override
  String get metaLabel => 'Objetivo';

  @override
  String get confirmarEliminarMeta => '¿Eliminar esta meta?';

  @override
  String hola(String nombre) {
    return 'Hola, $nombre';
  }

  @override
  String get distribucionGastos => 'Distribución de gastos';

  @override
  String get sinDatosGrafico => 'Sin gastos para mostrar';

  @override
  String pagadosDe(int pagados, int total) {
    return '$pagados de $total pagados';
  }

  @override
  String gastadoDe(String gastado, String presupuesto) {
    return '$gastado de $presupuesto';
  }

  @override
  String get exportarPDF => 'Exportar resumen';

  @override
  String get generandoPDF => 'Generando resumen...';

  @override
  String get resumenMensual => 'Resumen mensual';

  @override
  String get notifVencimientoTitle => 'Vencimiento hoy';

  @override
  String notifVencimientoBody(String nombre) {
    return '$nombre vence hoy';
  }

  @override
  String get historial => 'Historial';

  @override
  String get gastos => 'Gastos';

  @override
  String get saldo => 'Saldo';

  @override
  String get tema => 'Apariencia';

  @override
  String get temaClaro => 'Claro';

  @override
  String get temaOscuro => 'Oscuro';

  @override
  String get temaSistema => 'Sistema';
}
