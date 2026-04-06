// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Gaveo';

  @override
  String get navInicio => 'Summary';

  @override
  String get navFijos => 'Fixed';

  @override
  String get navVariables => 'Others';

  @override
  String get navDelivery => 'Delivery';

  @override
  String get navAhorros => 'Savings';

  @override
  String get saldoDisponible => 'Available balance';

  @override
  String porcentajeComprometido(String pct) {
    return '$pct% committed';
  }

  @override
  String get ingresos => 'Income';

  @override
  String get gastosFijos => 'Fixed expenses';

  @override
  String get gastosVariables => 'Variable expenses';

  @override
  String get delivery => 'Delivery';

  @override
  String get ahorros => 'Savings';

  @override
  String get errorGenerico => 'An error occurred';

  @override
  String get reintentar => 'Retry';

  @override
  String get configTitle => 'Settings';

  @override
  String get errorCargarConfig => 'Error loading settings';

  @override
  String get perfil => 'Profile';

  @override
  String get tuNombre => 'Your name';

  @override
  String get campoRequerido => 'Required field';

  @override
  String get moneda => 'Currency';

  @override
  String get codigoMoneda => 'Code (e.g. USD)';

  @override
  String get simbolo => 'Symbol';

  @override
  String get requerido => 'Required';

  @override
  String get seleccionarMoneda => 'Select currency';

  @override
  String get buscarMoneda => 'Search currency...';

  @override
  String get monedaSeleccionada => 'Selected currency';

  @override
  String get sinResultados => 'No results';

  @override
  String get presupuestoDelivery => 'Monthly delivery budget';

  @override
  String get configGuardada => 'Settings saved';

  @override
  String get guardar => 'Save';

  @override
  String get ver => 'See';

  @override
  String get idioma => 'Language';

  @override
  String get bienvenido => 'Welcome to Gaveo!';

  @override
  String get configuraTuPerfil => 'Set up your profile to get started.';

  @override
  String get tuNombreRequerido => 'Your name *';

  @override
  String get presupuestoDeliveryOpcional => 'Monthly amount (optional)';

  @override
  String get comenzar => 'Get started';

  @override
  String get proximamente => 'Coming soon';

  @override
  String get agregar => 'Add';

  @override
  String get editar => 'Edit';

  @override
  String get eliminar => 'Delete';

  @override
  String get cancelar => 'Cancel';

  @override
  String get monto => 'Amount';

  @override
  String get montoInvalido => 'Enter a valid amount';

  @override
  String get notasOpcional => 'Notes (optional)';

  @override
  String get agregarGastoFijo => 'Add fixed expense';

  @override
  String get editarGastoFijo => 'Edit fixed expense';

  @override
  String get sinGastosFijos => 'No fixed expenses';

  @override
  String get sinGastosFijosDesc => 'Tap + to add a recurring expense';

  @override
  String get nombreDelGasto => 'Expense name';

  @override
  String get diaVencimiento => 'Due day (1-31)';

  @override
  String get diaInvalido => 'Invalid day (1-31)';

  @override
  String venceElDia(int dia) {
    return 'Due on day $dia';
  }

  @override
  String get pagado => 'Paid';

  @override
  String get pendiente => 'Pending';

  @override
  String get confirmarEliminar => 'Delete this expense?';

  @override
  String get confirmarEliminarDesc => 'This action cannot be undone.';

  @override
  String get gastoAgregado => 'Expense added';

  @override
  String get gastoActualizado => 'Expense updated';

  @override
  String get gastoEliminado => 'Expense deleted';

  @override
  String get categoria => 'Category';

  @override
  String get catGeneral => 'General';

  @override
  String get catServicios => 'Services';

  @override
  String get catAlquiler => 'Rent';

  @override
  String get catInternet => 'Internet';

  @override
  String get catSeguro => 'Insurance';

  @override
  String get catSalud => 'Health';

  @override
  String get catEducacion => 'Education';

  @override
  String get catSuscripciones => 'Subscriptions';

  @override
  String get agregarIngreso => 'Add income';

  @override
  String get editarIngreso => 'Edit income';

  @override
  String get sinIngresos => 'No income this month';

  @override
  String get sinIngresosDesc => 'Tap + to record income';

  @override
  String get fuente => 'Income source';

  @override
  String get fecha => 'Date';

  @override
  String get ingresoAgregado => 'Income recorded';

  @override
  String get ingresoActualizado => 'Income updated';

  @override
  String get ingresoEliminado => 'Income deleted';

  @override
  String get agregarGastoVariable => 'Add variable expense';

  @override
  String get editarGastoVariable => 'Edit variable expense';

  @override
  String get sinGastosVariables => 'No expenses this month';

  @override
  String get sinGastosVariablesDesc => 'Tap + to record an expense';

  @override
  String get descripcion => 'Description';

  @override
  String get gastoVariableAgregado => 'Expense recorded';

  @override
  String get gastoVariableActualizado => 'Expense updated';

  @override
  String get gastoVariableEliminado => 'Expense deleted';

  @override
  String get catImprevisto => 'Unexpected';

  @override
  String get catComida => 'Food';

  @override
  String get catTransporte => 'Transport';

  @override
  String get catRopa => 'Clothing';

  @override
  String get catEntretenimiento => 'Entertainment';

  @override
  String get catFarmacia => 'Pharmacy';

  @override
  String get catHogar => 'Home';

  @override
  String get catElectricidad => 'Electricity';

  @override
  String get catAgua => 'Water';

  @override
  String get catOtro => 'Other';

  @override
  String get catDelivery => 'Delivery';

  @override
  String get agregarDelivery => 'Add order';

  @override
  String get editarDelivery => 'Edit order';

  @override
  String get sinDelivery => 'No orders this month';

  @override
  String get sinDeliveryDesc => 'Tap + to log an order';

  @override
  String get deliveryAgregado => 'Order recorded';

  @override
  String get deliveryActualizado => 'Order updated';

  @override
  String get deliveryEliminado => 'Order deleted';

  @override
  String get plataformaOpcional => 'Platform (optional)';

  @override
  String get presupuestoNoDefinido => 'No budget defined';

  @override
  String get gastadoLabel => 'Spent';

  @override
  String get presupuestoLabel => 'Budget';

  @override
  String get agregarMeta => 'Add goal';

  @override
  String get editarMeta => 'Edit goal';

  @override
  String get sinAhorros => 'No savings goals';

  @override
  String get sinAhorrosDesc => 'Tap + to create your first goal';

  @override
  String get metaAgregada => 'Goal created';

  @override
  String get metaActualizada => 'Goal updated';

  @override
  String get metaEliminada => 'Goal deleted';

  @override
  String get nombreMeta => 'Goal name';

  @override
  String get montoMensual => 'Monthly savings';

  @override
  String get montoObjetivo => 'Target amount (optional)';

  @override
  String get catAhorro => 'Category';

  @override
  String get catAhorroGeneral => 'General';

  @override
  String get catAhorroVivienda => 'Housing';

  @override
  String get catAhorroTransporte => 'Transport';

  @override
  String get catAhorroViaje => 'Travel';

  @override
  String get catAhorroTecnologia => 'Technology';

  @override
  String get catAhorroEducacion => 'Education';

  @override
  String get catAhorroSalud => 'Health';

  @override
  String get catAhorroEmergencia => 'Emergency';

  @override
  String get catAhorroJubilacion => 'Retirement';

  @override
  String get activo => 'Active';

  @override
  String get inactivo => 'Inactive';

  @override
  String get totalMensual => 'Monthly total';

  @override
  String get metaLabel => 'Target';

  @override
  String get confirmarEliminarMeta => 'Delete this goal?';

  @override
  String hola(String nombre) {
    return 'Hello, $nombre';
  }

  @override
  String get distribucionGastos => 'Expense breakdown';

  @override
  String get sinDatosGrafico => 'No expenses to display';

  @override
  String pagadosDe(int pagados, int total) {
    return '$pagados of $total paid';
  }

  @override
  String gastadoDe(String gastado, String presupuesto) {
    return '$gastado of $presupuesto';
  }

  @override
  String get exportarPDF => 'Export summary';

  @override
  String get generandoPDF => 'Generating summary...';

  @override
  String get resumenMensual => 'Monthly summary';

  @override
  String get notifVencimientoTitle => 'Due today';

  @override
  String notifVencimientoBody(String nombre) {
    return '$nombre is due today';
  }

  @override
  String get historial => 'History';

  @override
  String get gastos => 'Expenses';

  @override
  String get saldo => 'Balance';

  @override
  String get tema => 'Appearance';

  @override
  String get temaClaro => 'Light';

  @override
  String get temaOscuro => 'Dark';

  @override
  String get navIngresos => 'Income';

  @override
  String get mostrarEnInicio => 'Show on home';

  @override
  String get mostrarEnInicioDesc =>
      'Always appears in the dashboard summary regardless of other conditions';

  @override
  String get sinFechaVencimiento => 'No due date';

  @override
  String get diaVencimientoOpcional => 'Due day (optional)';

  @override
  String get limite => 'Monthly limit';

  @override
  String get limiteOpcional => 'Monthly limit (optional)';

  @override
  String get limiteDesc => 'Shows this category on the dashboard with progress';

  @override
  String get configurarCategorias => 'Configure categories';

  @override
  String get seguimiento => 'Tracking';

  @override
  String get dePresupuesto => 'of budget';

  @override
  String get sinLimite => 'No limit';

  @override
  String get verMisFinanzas => 'View my finances';

  @override
  String get estadoDelMes => 'Month status';

  @override
  String get vasBien => 'You\'re on track 🟢';

  @override
  String get casiAlLimite => 'Almost at the limit 🟡';

  @override
  String get presupuestoComprometido => 'Budget committed 🔴';

  @override
  String get comprometido => 'committed';
}
