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
  String get navInicio => 'Home';

  @override
  String get navFijos => 'Fixed';

  @override
  String get navVariables => 'Variable';

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
  String get idioma => 'Language';

  @override
  String get bienvenido => 'Welcome to Gaveo!';

  @override
  String get configuraTuPerfil => 'Set up your profile to get started.';

  @override
  String get tuNombreRequerido => 'Your name *';

  @override
  String get presupuestoDeliveryOpcional =>
      'Monthly delivery budget (optional)';

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
  String get catOtro => 'Other';

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
  String get emojiMeta => 'Emoji';

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
}
