// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $IngresosTable extends Ingresos with TableInfo<$IngresosTable, Ingreso> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngresosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fuenteMeta = const VerificationMeta('fuente');
  @override
  late final GeneratedColumn<String> fuente = GeneratedColumn<String>(
      'fuente', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
      'monto', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _mesMeta = const VerificationMeta('mes');
  @override
  late final GeneratedColumn<int> mes = GeneratedColumn<int>(
      'mes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _anioMeta = const VerificationMeta('anio');
  @override
  late final GeneratedColumn<int> anio = GeneratedColumn<int>(
      'anio', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notasMeta = const VerificationMeta('notas');
  @override
  late final GeneratedColumn<String> notas = GeneratedColumn<String>(
      'notas', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, fuente, monto, fecha, mes, anio, notas];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ingresos';
  @override
  VerificationContext validateIntegrity(Insertable<Ingreso> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fuente')) {
      context.handle(_fuenteMeta,
          fuente.isAcceptableOrUnknown(data['fuente']!, _fuenteMeta));
    } else if (isInserting) {
      context.missing(_fuenteMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
          _montoMeta, monto.isAcceptableOrUnknown(data['monto']!, _montoMeta));
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('mes')) {
      context.handle(
          _mesMeta, mes.isAcceptableOrUnknown(data['mes']!, _mesMeta));
    } else if (isInserting) {
      context.missing(_mesMeta);
    }
    if (data.containsKey('anio')) {
      context.handle(
          _anioMeta, anio.isAcceptableOrUnknown(data['anio']!, _anioMeta));
    } else if (isInserting) {
      context.missing(_anioMeta);
    }
    if (data.containsKey('notas')) {
      context.handle(
          _notasMeta, notas.isAcceptableOrUnknown(data['notas']!, _notasMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingreso map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ingreso(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fuente: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fuente'])!,
      monto: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}monto'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      mes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mes'])!,
      anio: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}anio'])!,
      notas: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notas']),
    );
  }

  @override
  $IngresosTable createAlias(String alias) {
    return $IngresosTable(attachedDatabase, alias);
  }
}

class Ingreso extends DataClass implements Insertable<Ingreso> {
  final int id;
  final String fuente;
  final double monto;
  final DateTime fecha;
  final int mes;
  final int anio;
  final String? notas;
  const Ingreso(
      {required this.id,
      required this.fuente,
      required this.monto,
      required this.fecha,
      required this.mes,
      required this.anio,
      this.notas});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fuente'] = Variable<String>(fuente);
    map['monto'] = Variable<double>(monto);
    map['fecha'] = Variable<DateTime>(fecha);
    map['mes'] = Variable<int>(mes);
    map['anio'] = Variable<int>(anio);
    if (!nullToAbsent || notas != null) {
      map['notas'] = Variable<String>(notas);
    }
    return map;
  }

  IngresosCompanion toCompanion(bool nullToAbsent) {
    return IngresosCompanion(
      id: Value(id),
      fuente: Value(fuente),
      monto: Value(monto),
      fecha: Value(fecha),
      mes: Value(mes),
      anio: Value(anio),
      notas:
          notas == null && nullToAbsent ? const Value.absent() : Value(notas),
    );
  }

  factory Ingreso.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ingreso(
      id: serializer.fromJson<int>(json['id']),
      fuente: serializer.fromJson<String>(json['fuente']),
      monto: serializer.fromJson<double>(json['monto']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      mes: serializer.fromJson<int>(json['mes']),
      anio: serializer.fromJson<int>(json['anio']),
      notas: serializer.fromJson<String?>(json['notas']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fuente': serializer.toJson<String>(fuente),
      'monto': serializer.toJson<double>(monto),
      'fecha': serializer.toJson<DateTime>(fecha),
      'mes': serializer.toJson<int>(mes),
      'anio': serializer.toJson<int>(anio),
      'notas': serializer.toJson<String?>(notas),
    };
  }

  Ingreso copyWith(
          {int? id,
          String? fuente,
          double? monto,
          DateTime? fecha,
          int? mes,
          int? anio,
          Value<String?> notas = const Value.absent()}) =>
      Ingreso(
        id: id ?? this.id,
        fuente: fuente ?? this.fuente,
        monto: monto ?? this.monto,
        fecha: fecha ?? this.fecha,
        mes: mes ?? this.mes,
        anio: anio ?? this.anio,
        notas: notas.present ? notas.value : this.notas,
      );
  Ingreso copyWithCompanion(IngresosCompanion data) {
    return Ingreso(
      id: data.id.present ? data.id.value : this.id,
      fuente: data.fuente.present ? data.fuente.value : this.fuente,
      monto: data.monto.present ? data.monto.value : this.monto,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      mes: data.mes.present ? data.mes.value : this.mes,
      anio: data.anio.present ? data.anio.value : this.anio,
      notas: data.notas.present ? data.notas.value : this.notas,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ingreso(')
          ..write('id: $id, ')
          ..write('fuente: $fuente, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('mes: $mes, ')
          ..write('anio: $anio, ')
          ..write('notas: $notas')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fuente, monto, fecha, mes, anio, notas);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ingreso &&
          other.id == this.id &&
          other.fuente == this.fuente &&
          other.monto == this.monto &&
          other.fecha == this.fecha &&
          other.mes == this.mes &&
          other.anio == this.anio &&
          other.notas == this.notas);
}

class IngresosCompanion extends UpdateCompanion<Ingreso> {
  final Value<int> id;
  final Value<String> fuente;
  final Value<double> monto;
  final Value<DateTime> fecha;
  final Value<int> mes;
  final Value<int> anio;
  final Value<String?> notas;
  const IngresosCompanion({
    this.id = const Value.absent(),
    this.fuente = const Value.absent(),
    this.monto = const Value.absent(),
    this.fecha = const Value.absent(),
    this.mes = const Value.absent(),
    this.anio = const Value.absent(),
    this.notas = const Value.absent(),
  });
  IngresosCompanion.insert({
    this.id = const Value.absent(),
    required String fuente,
    required double monto,
    required DateTime fecha,
    required int mes,
    required int anio,
    this.notas = const Value.absent(),
  })  : fuente = Value(fuente),
        monto = Value(monto),
        fecha = Value(fecha),
        mes = Value(mes),
        anio = Value(anio);
  static Insertable<Ingreso> custom({
    Expression<int>? id,
    Expression<String>? fuente,
    Expression<double>? monto,
    Expression<DateTime>? fecha,
    Expression<int>? mes,
    Expression<int>? anio,
    Expression<String>? notas,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fuente != null) 'fuente': fuente,
      if (monto != null) 'monto': monto,
      if (fecha != null) 'fecha': fecha,
      if (mes != null) 'mes': mes,
      if (anio != null) 'anio': anio,
      if (notas != null) 'notas': notas,
    });
  }

  IngresosCompanion copyWith(
      {Value<int>? id,
      Value<String>? fuente,
      Value<double>? monto,
      Value<DateTime>? fecha,
      Value<int>? mes,
      Value<int>? anio,
      Value<String?>? notas}) {
    return IngresosCompanion(
      id: id ?? this.id,
      fuente: fuente ?? this.fuente,
      monto: monto ?? this.monto,
      fecha: fecha ?? this.fecha,
      mes: mes ?? this.mes,
      anio: anio ?? this.anio,
      notas: notas ?? this.notas,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fuente.present) {
      map['fuente'] = Variable<String>(fuente.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (mes.present) {
      map['mes'] = Variable<int>(mes.value);
    }
    if (anio.present) {
      map['anio'] = Variable<int>(anio.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngresosCompanion(')
          ..write('id: $id, ')
          ..write('fuente: $fuente, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('mes: $mes, ')
          ..write('anio: $anio, ')
          ..write('notas: $notas')
          ..write(')'))
        .toString();
  }
}

class $GastosFijosTable extends GastosFijos
    with TableInfo<$GastosFijosTable, GastosFijo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GastosFijosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
      'monto', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _diaVencimientoMeta =
      const VerificationMeta('diaVencimiento');
  @override
  late final GeneratedColumn<int> diaVencimiento = GeneratedColumn<int>(
      'dia_vencimiento', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
      'activo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("activo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('general'));
  static const VerificationMeta _notasMeta = const VerificationMeta('notas');
  @override
  late final GeneratedColumn<String> notas = GeneratedColumn<String>(
      'notas', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mostrarEnInicioMeta =
      const VerificationMeta('mostrarEnInicio');
  @override
  late final GeneratedColumn<bool> mostrarEnInicio = GeneratedColumn<bool>(
      'mostrar_en_inicio', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("mostrar_en_inicio" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nombre,
        monto,
        diaVencimiento,
        activo,
        categoria,
        notas,
        mostrarEnInicio
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gastos_fijos';
  @override
  VerificationContext validateIntegrity(Insertable<GastosFijo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
          _montoMeta, monto.isAcceptableOrUnknown(data['monto']!, _montoMeta));
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('dia_vencimiento')) {
      context.handle(
          _diaVencimientoMeta,
          diaVencimiento.isAcceptableOrUnknown(
              data['dia_vencimiento']!, _diaVencimientoMeta));
    }
    if (data.containsKey('activo')) {
      context.handle(_activoMeta,
          activo.isAcceptableOrUnknown(data['activo']!, _activoMeta));
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    }
    if (data.containsKey('notas')) {
      context.handle(
          _notasMeta, notas.isAcceptableOrUnknown(data['notas']!, _notasMeta));
    }
    if (data.containsKey('mostrar_en_inicio')) {
      context.handle(
          _mostrarEnInicioMeta,
          mostrarEnInicio.isAcceptableOrUnknown(
              data['mostrar_en_inicio']!, _mostrarEnInicioMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GastosFijo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GastosFijo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      monto: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}monto'])!,
      diaVencimiento: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dia_vencimiento']),
      activo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}activo'])!,
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria'])!,
      notas: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notas']),
      mostrarEnInicio: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}mostrar_en_inicio'])!,
    );
  }

  @override
  $GastosFijosTable createAlias(String alias) {
    return $GastosFijosTable(attachedDatabase, alias);
  }
}

class GastosFijo extends DataClass implements Insertable<GastosFijo> {
  final int id;
  final String nombre;
  final double monto;
  final int? diaVencimiento;
  final bool activo;
  final String categoria;
  final String? notas;
  final bool mostrarEnInicio;
  const GastosFijo(
      {required this.id,
      required this.nombre,
      required this.monto,
      this.diaVencimiento,
      required this.activo,
      required this.categoria,
      this.notas,
      required this.mostrarEnInicio});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['monto'] = Variable<double>(monto);
    if (!nullToAbsent || diaVencimiento != null) {
      map['dia_vencimiento'] = Variable<int>(diaVencimiento);
    }
    map['activo'] = Variable<bool>(activo);
    map['categoria'] = Variable<String>(categoria);
    if (!nullToAbsent || notas != null) {
      map['notas'] = Variable<String>(notas);
    }
    map['mostrar_en_inicio'] = Variable<bool>(mostrarEnInicio);
    return map;
  }

  GastosFijosCompanion toCompanion(bool nullToAbsent) {
    return GastosFijosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      monto: Value(monto),
      diaVencimiento: diaVencimiento == null && nullToAbsent
          ? const Value.absent()
          : Value(diaVencimiento),
      activo: Value(activo),
      categoria: Value(categoria),
      notas:
          notas == null && nullToAbsent ? const Value.absent() : Value(notas),
      mostrarEnInicio: Value(mostrarEnInicio),
    );
  }

  factory GastosFijo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GastosFijo(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      monto: serializer.fromJson<double>(json['monto']),
      diaVencimiento: serializer.fromJson<int?>(json['diaVencimiento']),
      activo: serializer.fromJson<bool>(json['activo']),
      categoria: serializer.fromJson<String>(json['categoria']),
      notas: serializer.fromJson<String?>(json['notas']),
      mostrarEnInicio: serializer.fromJson<bool>(json['mostrarEnInicio']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'monto': serializer.toJson<double>(monto),
      'diaVencimiento': serializer.toJson<int?>(diaVencimiento),
      'activo': serializer.toJson<bool>(activo),
      'categoria': serializer.toJson<String>(categoria),
      'notas': serializer.toJson<String?>(notas),
      'mostrarEnInicio': serializer.toJson<bool>(mostrarEnInicio),
    };
  }

  GastosFijo copyWith(
          {int? id,
          String? nombre,
          double? monto,
          Value<int?> diaVencimiento = const Value.absent(),
          bool? activo,
          String? categoria,
          Value<String?> notas = const Value.absent(),
          bool? mostrarEnInicio}) =>
      GastosFijo(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        monto: monto ?? this.monto,
        diaVencimiento:
            diaVencimiento.present ? diaVencimiento.value : this.diaVencimiento,
        activo: activo ?? this.activo,
        categoria: categoria ?? this.categoria,
        notas: notas.present ? notas.value : this.notas,
        mostrarEnInicio: mostrarEnInicio ?? this.mostrarEnInicio,
      );
  GastosFijo copyWithCompanion(GastosFijosCompanion data) {
    return GastosFijo(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      monto: data.monto.present ? data.monto.value : this.monto,
      diaVencimiento: data.diaVencimiento.present
          ? data.diaVencimiento.value
          : this.diaVencimiento,
      activo: data.activo.present ? data.activo.value : this.activo,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      notas: data.notas.present ? data.notas.value : this.notas,
      mostrarEnInicio: data.mostrarEnInicio.present
          ? data.mostrarEnInicio.value
          : this.mostrarEnInicio,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GastosFijo(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('monto: $monto, ')
          ..write('diaVencimiento: $diaVencimiento, ')
          ..write('activo: $activo, ')
          ..write('categoria: $categoria, ')
          ..write('notas: $notas, ')
          ..write('mostrarEnInicio: $mostrarEnInicio')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, monto, diaVencimiento, activo,
      categoria, notas, mostrarEnInicio);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GastosFijo &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.monto == this.monto &&
          other.diaVencimiento == this.diaVencimiento &&
          other.activo == this.activo &&
          other.categoria == this.categoria &&
          other.notas == this.notas &&
          other.mostrarEnInicio == this.mostrarEnInicio);
}

class GastosFijosCompanion extends UpdateCompanion<GastosFijo> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<double> monto;
  final Value<int?> diaVencimiento;
  final Value<bool> activo;
  final Value<String> categoria;
  final Value<String?> notas;
  final Value<bool> mostrarEnInicio;
  const GastosFijosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.monto = const Value.absent(),
    this.diaVencimiento = const Value.absent(),
    this.activo = const Value.absent(),
    this.categoria = const Value.absent(),
    this.notas = const Value.absent(),
    this.mostrarEnInicio = const Value.absent(),
  });
  GastosFijosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required double monto,
    this.diaVencimiento = const Value.absent(),
    this.activo = const Value.absent(),
    this.categoria = const Value.absent(),
    this.notas = const Value.absent(),
    this.mostrarEnInicio = const Value.absent(),
  })  : nombre = Value(nombre),
        monto = Value(monto);
  static Insertable<GastosFijo> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<double>? monto,
    Expression<int>? diaVencimiento,
    Expression<bool>? activo,
    Expression<String>? categoria,
    Expression<String>? notas,
    Expression<bool>? mostrarEnInicio,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (monto != null) 'monto': monto,
      if (diaVencimiento != null) 'dia_vencimiento': diaVencimiento,
      if (activo != null) 'activo': activo,
      if (categoria != null) 'categoria': categoria,
      if (notas != null) 'notas': notas,
      if (mostrarEnInicio != null) 'mostrar_en_inicio': mostrarEnInicio,
    });
  }

  GastosFijosCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<double>? monto,
      Value<int?>? diaVencimiento,
      Value<bool>? activo,
      Value<String>? categoria,
      Value<String?>? notas,
      Value<bool>? mostrarEnInicio}) {
    return GastosFijosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      monto: monto ?? this.monto,
      diaVencimiento: diaVencimiento ?? this.diaVencimiento,
      activo: activo ?? this.activo,
      categoria: categoria ?? this.categoria,
      notas: notas ?? this.notas,
      mostrarEnInicio: mostrarEnInicio ?? this.mostrarEnInicio,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (diaVencimiento.present) {
      map['dia_vencimiento'] = Variable<int>(diaVencimiento.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    if (mostrarEnInicio.present) {
      map['mostrar_en_inicio'] = Variable<bool>(mostrarEnInicio.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GastosFijosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('monto: $monto, ')
          ..write('diaVencimiento: $diaVencimiento, ')
          ..write('activo: $activo, ')
          ..write('categoria: $categoria, ')
          ..write('notas: $notas, ')
          ..write('mostrarEnInicio: $mostrarEnInicio')
          ..write(')'))
        .toString();
  }
}

class $GastosFijosPagosTable extends GastosFijosPagos
    with TableInfo<$GastosFijosPagosTable, GastosFijosPago> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GastosFijosPagosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _gastoFijoIdMeta =
      const VerificationMeta('gastoFijoId');
  @override
  late final GeneratedColumn<int> gastoFijoId = GeneratedColumn<int>(
      'gasto_fijo_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES gastos_fijos (id)'));
  static const VerificationMeta _mesMeta = const VerificationMeta('mes');
  @override
  late final GeneratedColumn<int> mes = GeneratedColumn<int>(
      'mes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _anioMeta = const VerificationMeta('anio');
  @override
  late final GeneratedColumn<int> anio = GeneratedColumn<int>(
      'anio', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pagadoMeta = const VerificationMeta('pagado');
  @override
  late final GeneratedColumn<bool> pagado = GeneratedColumn<bool>(
      'pagado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("pagado" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _fechaPagoMeta =
      const VerificationMeta('fechaPago');
  @override
  late final GeneratedColumn<DateTime> fechaPago = GeneratedColumn<DateTime>(
      'fecha_pago', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, gastoFijoId, mes, anio, pagado, fechaPago];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gastos_fijos_pagos';
  @override
  VerificationContext validateIntegrity(Insertable<GastosFijosPago> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gasto_fijo_id')) {
      context.handle(
          _gastoFijoIdMeta,
          gastoFijoId.isAcceptableOrUnknown(
              data['gasto_fijo_id']!, _gastoFijoIdMeta));
    } else if (isInserting) {
      context.missing(_gastoFijoIdMeta);
    }
    if (data.containsKey('mes')) {
      context.handle(
          _mesMeta, mes.isAcceptableOrUnknown(data['mes']!, _mesMeta));
    } else if (isInserting) {
      context.missing(_mesMeta);
    }
    if (data.containsKey('anio')) {
      context.handle(
          _anioMeta, anio.isAcceptableOrUnknown(data['anio']!, _anioMeta));
    } else if (isInserting) {
      context.missing(_anioMeta);
    }
    if (data.containsKey('pagado')) {
      context.handle(_pagadoMeta,
          pagado.isAcceptableOrUnknown(data['pagado']!, _pagadoMeta));
    }
    if (data.containsKey('fecha_pago')) {
      context.handle(_fechaPagoMeta,
          fechaPago.isAcceptableOrUnknown(data['fecha_pago']!, _fechaPagoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GastosFijosPago map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GastosFijosPago(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      gastoFijoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gasto_fijo_id'])!,
      mes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mes'])!,
      anio: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}anio'])!,
      pagado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pagado'])!,
      fechaPago: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_pago']),
    );
  }

  @override
  $GastosFijosPagosTable createAlias(String alias) {
    return $GastosFijosPagosTable(attachedDatabase, alias);
  }
}

class GastosFijosPago extends DataClass implements Insertable<GastosFijosPago> {
  final int id;
  final int gastoFijoId;
  final int mes;
  final int anio;
  final bool pagado;
  final DateTime? fechaPago;
  const GastosFijosPago(
      {required this.id,
      required this.gastoFijoId,
      required this.mes,
      required this.anio,
      required this.pagado,
      this.fechaPago});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gasto_fijo_id'] = Variable<int>(gastoFijoId);
    map['mes'] = Variable<int>(mes);
    map['anio'] = Variable<int>(anio);
    map['pagado'] = Variable<bool>(pagado);
    if (!nullToAbsent || fechaPago != null) {
      map['fecha_pago'] = Variable<DateTime>(fechaPago);
    }
    return map;
  }

  GastosFijosPagosCompanion toCompanion(bool nullToAbsent) {
    return GastosFijosPagosCompanion(
      id: Value(id),
      gastoFijoId: Value(gastoFijoId),
      mes: Value(mes),
      anio: Value(anio),
      pagado: Value(pagado),
      fechaPago: fechaPago == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaPago),
    );
  }

  factory GastosFijosPago.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GastosFijosPago(
      id: serializer.fromJson<int>(json['id']),
      gastoFijoId: serializer.fromJson<int>(json['gastoFijoId']),
      mes: serializer.fromJson<int>(json['mes']),
      anio: serializer.fromJson<int>(json['anio']),
      pagado: serializer.fromJson<bool>(json['pagado']),
      fechaPago: serializer.fromJson<DateTime?>(json['fechaPago']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gastoFijoId': serializer.toJson<int>(gastoFijoId),
      'mes': serializer.toJson<int>(mes),
      'anio': serializer.toJson<int>(anio),
      'pagado': serializer.toJson<bool>(pagado),
      'fechaPago': serializer.toJson<DateTime?>(fechaPago),
    };
  }

  GastosFijosPago copyWith(
          {int? id,
          int? gastoFijoId,
          int? mes,
          int? anio,
          bool? pagado,
          Value<DateTime?> fechaPago = const Value.absent()}) =>
      GastosFijosPago(
        id: id ?? this.id,
        gastoFijoId: gastoFijoId ?? this.gastoFijoId,
        mes: mes ?? this.mes,
        anio: anio ?? this.anio,
        pagado: pagado ?? this.pagado,
        fechaPago: fechaPago.present ? fechaPago.value : this.fechaPago,
      );
  GastosFijosPago copyWithCompanion(GastosFijosPagosCompanion data) {
    return GastosFijosPago(
      id: data.id.present ? data.id.value : this.id,
      gastoFijoId:
          data.gastoFijoId.present ? data.gastoFijoId.value : this.gastoFijoId,
      mes: data.mes.present ? data.mes.value : this.mes,
      anio: data.anio.present ? data.anio.value : this.anio,
      pagado: data.pagado.present ? data.pagado.value : this.pagado,
      fechaPago: data.fechaPago.present ? data.fechaPago.value : this.fechaPago,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GastosFijosPago(')
          ..write('id: $id, ')
          ..write('gastoFijoId: $gastoFijoId, ')
          ..write('mes: $mes, ')
          ..write('anio: $anio, ')
          ..write('pagado: $pagado, ')
          ..write('fechaPago: $fechaPago')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, gastoFijoId, mes, anio, pagado, fechaPago);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GastosFijosPago &&
          other.id == this.id &&
          other.gastoFijoId == this.gastoFijoId &&
          other.mes == this.mes &&
          other.anio == this.anio &&
          other.pagado == this.pagado &&
          other.fechaPago == this.fechaPago);
}

class GastosFijosPagosCompanion extends UpdateCompanion<GastosFijosPago> {
  final Value<int> id;
  final Value<int> gastoFijoId;
  final Value<int> mes;
  final Value<int> anio;
  final Value<bool> pagado;
  final Value<DateTime?> fechaPago;
  const GastosFijosPagosCompanion({
    this.id = const Value.absent(),
    this.gastoFijoId = const Value.absent(),
    this.mes = const Value.absent(),
    this.anio = const Value.absent(),
    this.pagado = const Value.absent(),
    this.fechaPago = const Value.absent(),
  });
  GastosFijosPagosCompanion.insert({
    this.id = const Value.absent(),
    required int gastoFijoId,
    required int mes,
    required int anio,
    this.pagado = const Value.absent(),
    this.fechaPago = const Value.absent(),
  })  : gastoFijoId = Value(gastoFijoId),
        mes = Value(mes),
        anio = Value(anio);
  static Insertable<GastosFijosPago> custom({
    Expression<int>? id,
    Expression<int>? gastoFijoId,
    Expression<int>? mes,
    Expression<int>? anio,
    Expression<bool>? pagado,
    Expression<DateTime>? fechaPago,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gastoFijoId != null) 'gasto_fijo_id': gastoFijoId,
      if (mes != null) 'mes': mes,
      if (anio != null) 'anio': anio,
      if (pagado != null) 'pagado': pagado,
      if (fechaPago != null) 'fecha_pago': fechaPago,
    });
  }

  GastosFijosPagosCompanion copyWith(
      {Value<int>? id,
      Value<int>? gastoFijoId,
      Value<int>? mes,
      Value<int>? anio,
      Value<bool>? pagado,
      Value<DateTime?>? fechaPago}) {
    return GastosFijosPagosCompanion(
      id: id ?? this.id,
      gastoFijoId: gastoFijoId ?? this.gastoFijoId,
      mes: mes ?? this.mes,
      anio: anio ?? this.anio,
      pagado: pagado ?? this.pagado,
      fechaPago: fechaPago ?? this.fechaPago,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gastoFijoId.present) {
      map['gasto_fijo_id'] = Variable<int>(gastoFijoId.value);
    }
    if (mes.present) {
      map['mes'] = Variable<int>(mes.value);
    }
    if (anio.present) {
      map['anio'] = Variable<int>(anio.value);
    }
    if (pagado.present) {
      map['pagado'] = Variable<bool>(pagado.value);
    }
    if (fechaPago.present) {
      map['fecha_pago'] = Variable<DateTime>(fechaPago.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GastosFijosPagosCompanion(')
          ..write('id: $id, ')
          ..write('gastoFijoId: $gastoFijoId, ')
          ..write('mes: $mes, ')
          ..write('anio: $anio, ')
          ..write('pagado: $pagado, ')
          ..write('fechaPago: $fechaPago')
          ..write(')'))
        .toString();
  }
}

class $GastosVariablesTable extends GastosVariables
    with TableInfo<$GastosVariablesTable, GastosVariable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GastosVariablesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
      'monto', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _mesMeta = const VerificationMeta('mes');
  @override
  late final GeneratedColumn<int> mes = GeneratedColumn<int>(
      'mes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _anioMeta = const VerificationMeta('anio');
  @override
  late final GeneratedColumn<int> anio = GeneratedColumn<int>(
      'anio', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('imprevisto'));
  static const VerificationMeta _notasMeta = const VerificationMeta('notas');
  @override
  late final GeneratedColumn<String> notas = GeneratedColumn<String>(
      'notas', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, descripcion, monto, fecha, mes, anio, categoria, notas];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gastos_variables';
  @override
  VerificationContext validateIntegrity(Insertable<GastosVariable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
          _montoMeta, monto.isAcceptableOrUnknown(data['monto']!, _montoMeta));
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('mes')) {
      context.handle(
          _mesMeta, mes.isAcceptableOrUnknown(data['mes']!, _mesMeta));
    } else if (isInserting) {
      context.missing(_mesMeta);
    }
    if (data.containsKey('anio')) {
      context.handle(
          _anioMeta, anio.isAcceptableOrUnknown(data['anio']!, _anioMeta));
    } else if (isInserting) {
      context.missing(_anioMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    }
    if (data.containsKey('notas')) {
      context.handle(
          _notasMeta, notas.isAcceptableOrUnknown(data['notas']!, _notasMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GastosVariable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GastosVariable(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion'])!,
      monto: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}monto'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      mes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mes'])!,
      anio: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}anio'])!,
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria'])!,
      notas: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notas']),
    );
  }

  @override
  $GastosVariablesTable createAlias(String alias) {
    return $GastosVariablesTable(attachedDatabase, alias);
  }
}

class GastosVariable extends DataClass implements Insertable<GastosVariable> {
  final int id;
  final String descripcion;
  final double monto;
  final DateTime fecha;
  final int mes;
  final int anio;
  final String categoria;
  final String? notas;
  const GastosVariable(
      {required this.id,
      required this.descripcion,
      required this.monto,
      required this.fecha,
      required this.mes,
      required this.anio,
      required this.categoria,
      this.notas});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['descripcion'] = Variable<String>(descripcion);
    map['monto'] = Variable<double>(monto);
    map['fecha'] = Variable<DateTime>(fecha);
    map['mes'] = Variable<int>(mes);
    map['anio'] = Variable<int>(anio);
    map['categoria'] = Variable<String>(categoria);
    if (!nullToAbsent || notas != null) {
      map['notas'] = Variable<String>(notas);
    }
    return map;
  }

  GastosVariablesCompanion toCompanion(bool nullToAbsent) {
    return GastosVariablesCompanion(
      id: Value(id),
      descripcion: Value(descripcion),
      monto: Value(monto),
      fecha: Value(fecha),
      mes: Value(mes),
      anio: Value(anio),
      categoria: Value(categoria),
      notas:
          notas == null && nullToAbsent ? const Value.absent() : Value(notas),
    );
  }

  factory GastosVariable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GastosVariable(
      id: serializer.fromJson<int>(json['id']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      monto: serializer.fromJson<double>(json['monto']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      mes: serializer.fromJson<int>(json['mes']),
      anio: serializer.fromJson<int>(json['anio']),
      categoria: serializer.fromJson<String>(json['categoria']),
      notas: serializer.fromJson<String?>(json['notas']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'descripcion': serializer.toJson<String>(descripcion),
      'monto': serializer.toJson<double>(monto),
      'fecha': serializer.toJson<DateTime>(fecha),
      'mes': serializer.toJson<int>(mes),
      'anio': serializer.toJson<int>(anio),
      'categoria': serializer.toJson<String>(categoria),
      'notas': serializer.toJson<String?>(notas),
    };
  }

  GastosVariable copyWith(
          {int? id,
          String? descripcion,
          double? monto,
          DateTime? fecha,
          int? mes,
          int? anio,
          String? categoria,
          Value<String?> notas = const Value.absent()}) =>
      GastosVariable(
        id: id ?? this.id,
        descripcion: descripcion ?? this.descripcion,
        monto: monto ?? this.monto,
        fecha: fecha ?? this.fecha,
        mes: mes ?? this.mes,
        anio: anio ?? this.anio,
        categoria: categoria ?? this.categoria,
        notas: notas.present ? notas.value : this.notas,
      );
  GastosVariable copyWithCompanion(GastosVariablesCompanion data) {
    return GastosVariable(
      id: data.id.present ? data.id.value : this.id,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      monto: data.monto.present ? data.monto.value : this.monto,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      mes: data.mes.present ? data.mes.value : this.mes,
      anio: data.anio.present ? data.anio.value : this.anio,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      notas: data.notas.present ? data.notas.value : this.notas,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GastosVariable(')
          ..write('id: $id, ')
          ..write('descripcion: $descripcion, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('mes: $mes, ')
          ..write('anio: $anio, ')
          ..write('categoria: $categoria, ')
          ..write('notas: $notas')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, descripcion, monto, fecha, mes, anio, categoria, notas);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GastosVariable &&
          other.id == this.id &&
          other.descripcion == this.descripcion &&
          other.monto == this.monto &&
          other.fecha == this.fecha &&
          other.mes == this.mes &&
          other.anio == this.anio &&
          other.categoria == this.categoria &&
          other.notas == this.notas);
}

class GastosVariablesCompanion extends UpdateCompanion<GastosVariable> {
  final Value<int> id;
  final Value<String> descripcion;
  final Value<double> monto;
  final Value<DateTime> fecha;
  final Value<int> mes;
  final Value<int> anio;
  final Value<String> categoria;
  final Value<String?> notas;
  const GastosVariablesCompanion({
    this.id = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.monto = const Value.absent(),
    this.fecha = const Value.absent(),
    this.mes = const Value.absent(),
    this.anio = const Value.absent(),
    this.categoria = const Value.absent(),
    this.notas = const Value.absent(),
  });
  GastosVariablesCompanion.insert({
    this.id = const Value.absent(),
    required String descripcion,
    required double monto,
    required DateTime fecha,
    required int mes,
    required int anio,
    this.categoria = const Value.absent(),
    this.notas = const Value.absent(),
  })  : descripcion = Value(descripcion),
        monto = Value(monto),
        fecha = Value(fecha),
        mes = Value(mes),
        anio = Value(anio);
  static Insertable<GastosVariable> custom({
    Expression<int>? id,
    Expression<String>? descripcion,
    Expression<double>? monto,
    Expression<DateTime>? fecha,
    Expression<int>? mes,
    Expression<int>? anio,
    Expression<String>? categoria,
    Expression<String>? notas,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descripcion != null) 'descripcion': descripcion,
      if (monto != null) 'monto': monto,
      if (fecha != null) 'fecha': fecha,
      if (mes != null) 'mes': mes,
      if (anio != null) 'anio': anio,
      if (categoria != null) 'categoria': categoria,
      if (notas != null) 'notas': notas,
    });
  }

  GastosVariablesCompanion copyWith(
      {Value<int>? id,
      Value<String>? descripcion,
      Value<double>? monto,
      Value<DateTime>? fecha,
      Value<int>? mes,
      Value<int>? anio,
      Value<String>? categoria,
      Value<String?>? notas}) {
    return GastosVariablesCompanion(
      id: id ?? this.id,
      descripcion: descripcion ?? this.descripcion,
      monto: monto ?? this.monto,
      fecha: fecha ?? this.fecha,
      mes: mes ?? this.mes,
      anio: anio ?? this.anio,
      categoria: categoria ?? this.categoria,
      notas: notas ?? this.notas,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (mes.present) {
      map['mes'] = Variable<int>(mes.value);
    }
    if (anio.present) {
      map['anio'] = Variable<int>(anio.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GastosVariablesCompanion(')
          ..write('id: $id, ')
          ..write('descripcion: $descripcion, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('mes: $mes, ')
          ..write('anio: $anio, ')
          ..write('categoria: $categoria, ')
          ..write('notas: $notas')
          ..write(')'))
        .toString();
  }
}

class $DeliveryGastosTable extends DeliveryGastos
    with TableInfo<$DeliveryGastosTable, DeliveryGasto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeliveryGastosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
      'monto', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _mesMeta = const VerificationMeta('mes');
  @override
  late final GeneratedColumn<int> mes = GeneratedColumn<int>(
      'mes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _anioMeta = const VerificationMeta('anio');
  @override
  late final GeneratedColumn<int> anio = GeneratedColumn<int>(
      'anio', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _plataformaMeta =
      const VerificationMeta('plataforma');
  @override
  late final GeneratedColumn<String> plataforma = GeneratedColumn<String>(
      'plataforma', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, descripcion, monto, fecha, mes, anio, plataforma];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'delivery_gastos';
  @override
  VerificationContext validateIntegrity(Insertable<DeliveryGasto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
          _montoMeta, monto.isAcceptableOrUnknown(data['monto']!, _montoMeta));
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('mes')) {
      context.handle(
          _mesMeta, mes.isAcceptableOrUnknown(data['mes']!, _mesMeta));
    } else if (isInserting) {
      context.missing(_mesMeta);
    }
    if (data.containsKey('anio')) {
      context.handle(
          _anioMeta, anio.isAcceptableOrUnknown(data['anio']!, _anioMeta));
    } else if (isInserting) {
      context.missing(_anioMeta);
    }
    if (data.containsKey('plataforma')) {
      context.handle(
          _plataformaMeta,
          plataforma.isAcceptableOrUnknown(
              data['plataforma']!, _plataformaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeliveryGasto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeliveryGasto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion'])!,
      monto: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}monto'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
      mes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mes'])!,
      anio: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}anio'])!,
      plataforma: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plataforma']),
    );
  }

  @override
  $DeliveryGastosTable createAlias(String alias) {
    return $DeliveryGastosTable(attachedDatabase, alias);
  }
}

class DeliveryGasto extends DataClass implements Insertable<DeliveryGasto> {
  final int id;
  final String descripcion;
  final double monto;
  final DateTime fecha;
  final int mes;
  final int anio;
  final String? plataforma;
  const DeliveryGasto(
      {required this.id,
      required this.descripcion,
      required this.monto,
      required this.fecha,
      required this.mes,
      required this.anio,
      this.plataforma});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['descripcion'] = Variable<String>(descripcion);
    map['monto'] = Variable<double>(monto);
    map['fecha'] = Variable<DateTime>(fecha);
    map['mes'] = Variable<int>(mes);
    map['anio'] = Variable<int>(anio);
    if (!nullToAbsent || plataforma != null) {
      map['plataforma'] = Variable<String>(plataforma);
    }
    return map;
  }

  DeliveryGastosCompanion toCompanion(bool nullToAbsent) {
    return DeliveryGastosCompanion(
      id: Value(id),
      descripcion: Value(descripcion),
      monto: Value(monto),
      fecha: Value(fecha),
      mes: Value(mes),
      anio: Value(anio),
      plataforma: plataforma == null && nullToAbsent
          ? const Value.absent()
          : Value(plataforma),
    );
  }

  factory DeliveryGasto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeliveryGasto(
      id: serializer.fromJson<int>(json['id']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      monto: serializer.fromJson<double>(json['monto']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      mes: serializer.fromJson<int>(json['mes']),
      anio: serializer.fromJson<int>(json['anio']),
      plataforma: serializer.fromJson<String?>(json['plataforma']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'descripcion': serializer.toJson<String>(descripcion),
      'monto': serializer.toJson<double>(monto),
      'fecha': serializer.toJson<DateTime>(fecha),
      'mes': serializer.toJson<int>(mes),
      'anio': serializer.toJson<int>(anio),
      'plataforma': serializer.toJson<String?>(plataforma),
    };
  }

  DeliveryGasto copyWith(
          {int? id,
          String? descripcion,
          double? monto,
          DateTime? fecha,
          int? mes,
          int? anio,
          Value<String?> plataforma = const Value.absent()}) =>
      DeliveryGasto(
        id: id ?? this.id,
        descripcion: descripcion ?? this.descripcion,
        monto: monto ?? this.monto,
        fecha: fecha ?? this.fecha,
        mes: mes ?? this.mes,
        anio: anio ?? this.anio,
        plataforma: plataforma.present ? plataforma.value : this.plataforma,
      );
  DeliveryGasto copyWithCompanion(DeliveryGastosCompanion data) {
    return DeliveryGasto(
      id: data.id.present ? data.id.value : this.id,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      monto: data.monto.present ? data.monto.value : this.monto,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      mes: data.mes.present ? data.mes.value : this.mes,
      anio: data.anio.present ? data.anio.value : this.anio,
      plataforma:
          data.plataforma.present ? data.plataforma.value : this.plataforma,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryGasto(')
          ..write('id: $id, ')
          ..write('descripcion: $descripcion, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('mes: $mes, ')
          ..write('anio: $anio, ')
          ..write('plataforma: $plataforma')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, descripcion, monto, fecha, mes, anio, plataforma);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeliveryGasto &&
          other.id == this.id &&
          other.descripcion == this.descripcion &&
          other.monto == this.monto &&
          other.fecha == this.fecha &&
          other.mes == this.mes &&
          other.anio == this.anio &&
          other.plataforma == this.plataforma);
}

class DeliveryGastosCompanion extends UpdateCompanion<DeliveryGasto> {
  final Value<int> id;
  final Value<String> descripcion;
  final Value<double> monto;
  final Value<DateTime> fecha;
  final Value<int> mes;
  final Value<int> anio;
  final Value<String?> plataforma;
  const DeliveryGastosCompanion({
    this.id = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.monto = const Value.absent(),
    this.fecha = const Value.absent(),
    this.mes = const Value.absent(),
    this.anio = const Value.absent(),
    this.plataforma = const Value.absent(),
  });
  DeliveryGastosCompanion.insert({
    this.id = const Value.absent(),
    required String descripcion,
    required double monto,
    required DateTime fecha,
    required int mes,
    required int anio,
    this.plataforma = const Value.absent(),
  })  : descripcion = Value(descripcion),
        monto = Value(monto),
        fecha = Value(fecha),
        mes = Value(mes),
        anio = Value(anio);
  static Insertable<DeliveryGasto> custom({
    Expression<int>? id,
    Expression<String>? descripcion,
    Expression<double>? monto,
    Expression<DateTime>? fecha,
    Expression<int>? mes,
    Expression<int>? anio,
    Expression<String>? plataforma,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descripcion != null) 'descripcion': descripcion,
      if (monto != null) 'monto': monto,
      if (fecha != null) 'fecha': fecha,
      if (mes != null) 'mes': mes,
      if (anio != null) 'anio': anio,
      if (plataforma != null) 'plataforma': plataforma,
    });
  }

  DeliveryGastosCompanion copyWith(
      {Value<int>? id,
      Value<String>? descripcion,
      Value<double>? monto,
      Value<DateTime>? fecha,
      Value<int>? mes,
      Value<int>? anio,
      Value<String?>? plataforma}) {
    return DeliveryGastosCompanion(
      id: id ?? this.id,
      descripcion: descripcion ?? this.descripcion,
      monto: monto ?? this.monto,
      fecha: fecha ?? this.fecha,
      mes: mes ?? this.mes,
      anio: anio ?? this.anio,
      plataforma: plataforma ?? this.plataforma,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (mes.present) {
      map['mes'] = Variable<int>(mes.value);
    }
    if (anio.present) {
      map['anio'] = Variable<int>(anio.value);
    }
    if (plataforma.present) {
      map['plataforma'] = Variable<String>(plataforma.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeliveryGastosCompanion(')
          ..write('id: $id, ')
          ..write('descripcion: $descripcion, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('mes: $mes, ')
          ..write('anio: $anio, ')
          ..write('plataforma: $plataforma')
          ..write(')'))
        .toString();
  }
}

class $AhorrosMetasTable extends AhorrosMetas
    with TableInfo<$AhorrosMetasTable, AhorrosMeta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AhorrosMetasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _montoMensualMeta =
      const VerificationMeta('montoMensual');
  @override
  late final GeneratedColumn<double> montoMensual = GeneratedColumn<double>(
      'monto_mensual', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _montoObjetivoMeta =
      const VerificationMeta('montoObjetivo');
  @override
  late final GeneratedColumn<double> montoObjetivo = GeneratedColumn<double>(
      'monto_objetivo', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
      'activo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("activo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
      'emoji', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('💰'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, nombre, montoMensual, montoObjetivo, activo, emoji];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ahorros_metas';
  @override
  VerificationContext validateIntegrity(Insertable<AhorrosMeta> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('monto_mensual')) {
      context.handle(
          _montoMensualMeta,
          montoMensual.isAcceptableOrUnknown(
              data['monto_mensual']!, _montoMensualMeta));
    } else if (isInserting) {
      context.missing(_montoMensualMeta);
    }
    if (data.containsKey('monto_objetivo')) {
      context.handle(
          _montoObjetivoMeta,
          montoObjetivo.isAcceptableOrUnknown(
              data['monto_objetivo']!, _montoObjetivoMeta));
    }
    if (data.containsKey('activo')) {
      context.handle(_activoMeta,
          activo.isAcceptableOrUnknown(data['activo']!, _activoMeta));
    }
    if (data.containsKey('emoji')) {
      context.handle(
          _emojiMeta, emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AhorrosMeta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AhorrosMeta(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      montoMensual: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}monto_mensual'])!,
      montoObjetivo: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}monto_objetivo']),
      activo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}activo'])!,
      emoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}emoji'])!,
    );
  }

  @override
  $AhorrosMetasTable createAlias(String alias) {
    return $AhorrosMetasTable(attachedDatabase, alias);
  }
}

class AhorrosMeta extends DataClass implements Insertable<AhorrosMeta> {
  final int id;
  final String nombre;
  final double montoMensual;
  final double? montoObjetivo;
  final bool activo;
  final String emoji;
  const AhorrosMeta(
      {required this.id,
      required this.nombre,
      required this.montoMensual,
      this.montoObjetivo,
      required this.activo,
      required this.emoji});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['monto_mensual'] = Variable<double>(montoMensual);
    if (!nullToAbsent || montoObjetivo != null) {
      map['monto_objetivo'] = Variable<double>(montoObjetivo);
    }
    map['activo'] = Variable<bool>(activo);
    map['emoji'] = Variable<String>(emoji);
    return map;
  }

  AhorrosMetasCompanion toCompanion(bool nullToAbsent) {
    return AhorrosMetasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      montoMensual: Value(montoMensual),
      montoObjetivo: montoObjetivo == null && nullToAbsent
          ? const Value.absent()
          : Value(montoObjetivo),
      activo: Value(activo),
      emoji: Value(emoji),
    );
  }

  factory AhorrosMeta.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AhorrosMeta(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      montoMensual: serializer.fromJson<double>(json['montoMensual']),
      montoObjetivo: serializer.fromJson<double?>(json['montoObjetivo']),
      activo: serializer.fromJson<bool>(json['activo']),
      emoji: serializer.fromJson<String>(json['emoji']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'montoMensual': serializer.toJson<double>(montoMensual),
      'montoObjetivo': serializer.toJson<double?>(montoObjetivo),
      'activo': serializer.toJson<bool>(activo),
      'emoji': serializer.toJson<String>(emoji),
    };
  }

  AhorrosMeta copyWith(
          {int? id,
          String? nombre,
          double? montoMensual,
          Value<double?> montoObjetivo = const Value.absent(),
          bool? activo,
          String? emoji}) =>
      AhorrosMeta(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        montoMensual: montoMensual ?? this.montoMensual,
        montoObjetivo:
            montoObjetivo.present ? montoObjetivo.value : this.montoObjetivo,
        activo: activo ?? this.activo,
        emoji: emoji ?? this.emoji,
      );
  AhorrosMeta copyWithCompanion(AhorrosMetasCompanion data) {
    return AhorrosMeta(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      montoMensual: data.montoMensual.present
          ? data.montoMensual.value
          : this.montoMensual,
      montoObjetivo: data.montoObjetivo.present
          ? data.montoObjetivo.value
          : this.montoObjetivo,
      activo: data.activo.present ? data.activo.value : this.activo,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AhorrosMeta(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('montoMensual: $montoMensual, ')
          ..write('montoObjetivo: $montoObjetivo, ')
          ..write('activo: $activo, ')
          ..write('emoji: $emoji')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, montoMensual, montoObjetivo, activo, emoji);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AhorrosMeta &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.montoMensual == this.montoMensual &&
          other.montoObjetivo == this.montoObjetivo &&
          other.activo == this.activo &&
          other.emoji == this.emoji);
}

class AhorrosMetasCompanion extends UpdateCompanion<AhorrosMeta> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<double> montoMensual;
  final Value<double?> montoObjetivo;
  final Value<bool> activo;
  final Value<String> emoji;
  const AhorrosMetasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.montoMensual = const Value.absent(),
    this.montoObjetivo = const Value.absent(),
    this.activo = const Value.absent(),
    this.emoji = const Value.absent(),
  });
  AhorrosMetasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required double montoMensual,
    this.montoObjetivo = const Value.absent(),
    this.activo = const Value.absent(),
    this.emoji = const Value.absent(),
  })  : nombre = Value(nombre),
        montoMensual = Value(montoMensual);
  static Insertable<AhorrosMeta> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<double>? montoMensual,
    Expression<double>? montoObjetivo,
    Expression<bool>? activo,
    Expression<String>? emoji,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (montoMensual != null) 'monto_mensual': montoMensual,
      if (montoObjetivo != null) 'monto_objetivo': montoObjetivo,
      if (activo != null) 'activo': activo,
      if (emoji != null) 'emoji': emoji,
    });
  }

  AhorrosMetasCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<double>? montoMensual,
      Value<double?>? montoObjetivo,
      Value<bool>? activo,
      Value<String>? emoji}) {
    return AhorrosMetasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      montoMensual: montoMensual ?? this.montoMensual,
      montoObjetivo: montoObjetivo ?? this.montoObjetivo,
      activo: activo ?? this.activo,
      emoji: emoji ?? this.emoji,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (montoMensual.present) {
      map['monto_mensual'] = Variable<double>(montoMensual.value);
    }
    if (montoObjetivo.present) {
      map['monto_objetivo'] = Variable<double>(montoObjetivo.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AhorrosMetasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('montoMensual: $montoMensual, ')
          ..write('montoObjetivo: $montoObjetivo, ')
          ..write('activo: $activo, ')
          ..write('emoji: $emoji')
          ..write(')'))
        .toString();
  }
}

class $ConfiguracionTable extends Configuracion
    with TableInfo<$ConfiguracionTable, ConfiguracionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfiguracionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _claveMeta = const VerificationMeta('clave');
  @override
  late final GeneratedColumn<String> clave = GeneratedColumn<String>(
      'clave', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<String> valor = GeneratedColumn<String>(
      'valor', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, clave, valor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'configuracion';
  @override
  VerificationContext validateIntegrity(Insertable<ConfiguracionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('clave')) {
      context.handle(
          _claveMeta, clave.isAcceptableOrUnknown(data['clave']!, _claveMeta));
    } else if (isInserting) {
      context.missing(_claveMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['valor']!, _valorMeta));
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConfiguracionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConfiguracionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clave: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}clave'])!,
      valor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}valor'])!,
    );
  }

  @override
  $ConfiguracionTable createAlias(String alias) {
    return $ConfiguracionTable(attachedDatabase, alias);
  }
}

class ConfiguracionData extends DataClass
    implements Insertable<ConfiguracionData> {
  final int id;
  final String clave;
  final String valor;
  const ConfiguracionData(
      {required this.id, required this.clave, required this.valor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['clave'] = Variable<String>(clave);
    map['valor'] = Variable<String>(valor);
    return map;
  }

  ConfiguracionCompanion toCompanion(bool nullToAbsent) {
    return ConfiguracionCompanion(
      id: Value(id),
      clave: Value(clave),
      valor: Value(valor),
    );
  }

  factory ConfiguracionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConfiguracionData(
      id: serializer.fromJson<int>(json['id']),
      clave: serializer.fromJson<String>(json['clave']),
      valor: serializer.fromJson<String>(json['valor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clave': serializer.toJson<String>(clave),
      'valor': serializer.toJson<String>(valor),
    };
  }

  ConfiguracionData copyWith({int? id, String? clave, String? valor}) =>
      ConfiguracionData(
        id: id ?? this.id,
        clave: clave ?? this.clave,
        valor: valor ?? this.valor,
      );
  ConfiguracionData copyWithCompanion(ConfiguracionCompanion data) {
    return ConfiguracionData(
      id: data.id.present ? data.id.value : this.id,
      clave: data.clave.present ? data.clave.value : this.clave,
      valor: data.valor.present ? data.valor.value : this.valor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConfiguracionData(')
          ..write('id: $id, ')
          ..write('clave: $clave, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clave, valor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfiguracionData &&
          other.id == this.id &&
          other.clave == this.clave &&
          other.valor == this.valor);
}

class ConfiguracionCompanion extends UpdateCompanion<ConfiguracionData> {
  final Value<int> id;
  final Value<String> clave;
  final Value<String> valor;
  const ConfiguracionCompanion({
    this.id = const Value.absent(),
    this.clave = const Value.absent(),
    this.valor = const Value.absent(),
  });
  ConfiguracionCompanion.insert({
    this.id = const Value.absent(),
    required String clave,
    required String valor,
  })  : clave = Value(clave),
        valor = Value(valor);
  static Insertable<ConfiguracionData> custom({
    Expression<int>? id,
    Expression<String>? clave,
    Expression<String>? valor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clave != null) 'clave': clave,
      if (valor != null) 'valor': valor,
    });
  }

  ConfiguracionCompanion copyWith(
      {Value<int>? id, Value<String>? clave, Value<String>? valor}) {
    return ConfiguracionCompanion(
      id: id ?? this.id,
      clave: clave ?? this.clave,
      valor: valor ?? this.valor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clave.present) {
      map['clave'] = Variable<String>(clave.value);
    }
    if (valor.present) {
      map['valor'] = Variable<String>(valor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfiguracionCompanion(')
          ..write('id: $id, ')
          ..write('clave: $clave, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }
}

class $CategoriasVariablesConfigTable extends CategoriasVariablesConfig
    with
        TableInfo<$CategoriasVariablesConfigTable,
            CategoriasVariablesConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriasVariablesConfigTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _limiteMeta = const VerificationMeta('limite');
  @override
  late final GeneratedColumn<double> limite = GeneratedColumn<double>(
      'limite', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _mostrarEnInicioMeta =
      const VerificationMeta('mostrarEnInicio');
  @override
  late final GeneratedColumn<bool> mostrarEnInicio = GeneratedColumn<bool>(
      'mostrar_en_inicio', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("mostrar_en_inicio" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [categoria, limite, mostrarEnInicio];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categorias_variables_config';
  @override
  VerificationContext validateIntegrity(
      Insertable<CategoriasVariablesConfigData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    } else if (isInserting) {
      context.missing(_categoriaMeta);
    }
    if (data.containsKey('limite')) {
      context.handle(_limiteMeta,
          limite.isAcceptableOrUnknown(data['limite']!, _limiteMeta));
    }
    if (data.containsKey('mostrar_en_inicio')) {
      context.handle(
          _mostrarEnInicioMeta,
          mostrarEnInicio.isAcceptableOrUnknown(
              data['mostrar_en_inicio']!, _mostrarEnInicioMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {categoria};
  @override
  CategoriasVariablesConfigData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriasVariablesConfigData(
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria'])!,
      limite: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}limite']),
      mostrarEnInicio: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}mostrar_en_inicio'])!,
    );
  }

  @override
  $CategoriasVariablesConfigTable createAlias(String alias) {
    return $CategoriasVariablesConfigTable(attachedDatabase, alias);
  }
}

class CategoriasVariablesConfigData extends DataClass
    implements Insertable<CategoriasVariablesConfigData> {
  final String categoria;
  final double? limite;
  final bool mostrarEnInicio;
  const CategoriasVariablesConfigData(
      {required this.categoria, this.limite, required this.mostrarEnInicio});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['categoria'] = Variable<String>(categoria);
    if (!nullToAbsent || limite != null) {
      map['limite'] = Variable<double>(limite);
    }
    map['mostrar_en_inicio'] = Variable<bool>(mostrarEnInicio);
    return map;
  }

  CategoriasVariablesConfigCompanion toCompanion(bool nullToAbsent) {
    return CategoriasVariablesConfigCompanion(
      categoria: Value(categoria),
      limite:
          limite == null && nullToAbsent ? const Value.absent() : Value(limite),
      mostrarEnInicio: Value(mostrarEnInicio),
    );
  }

  factory CategoriasVariablesConfigData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriasVariablesConfigData(
      categoria: serializer.fromJson<String>(json['categoria']),
      limite: serializer.fromJson<double?>(json['limite']),
      mostrarEnInicio: serializer.fromJson<bool>(json['mostrarEnInicio']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'categoria': serializer.toJson<String>(categoria),
      'limite': serializer.toJson<double?>(limite),
      'mostrarEnInicio': serializer.toJson<bool>(mostrarEnInicio),
    };
  }

  CategoriasVariablesConfigData copyWith(
          {String? categoria,
          Value<double?> limite = const Value.absent(),
          bool? mostrarEnInicio}) =>
      CategoriasVariablesConfigData(
        categoria: categoria ?? this.categoria,
        limite: limite.present ? limite.value : this.limite,
        mostrarEnInicio: mostrarEnInicio ?? this.mostrarEnInicio,
      );
  CategoriasVariablesConfigData copyWithCompanion(
      CategoriasVariablesConfigCompanion data) {
    return CategoriasVariablesConfigData(
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      limite: data.limite.present ? data.limite.value : this.limite,
      mostrarEnInicio: data.mostrarEnInicio.present
          ? data.mostrarEnInicio.value
          : this.mostrarEnInicio,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasVariablesConfigData(')
          ..write('categoria: $categoria, ')
          ..write('limite: $limite, ')
          ..write('mostrarEnInicio: $mostrarEnInicio')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(categoria, limite, mostrarEnInicio);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriasVariablesConfigData &&
          other.categoria == this.categoria &&
          other.limite == this.limite &&
          other.mostrarEnInicio == this.mostrarEnInicio);
}

class CategoriasVariablesConfigCompanion
    extends UpdateCompanion<CategoriasVariablesConfigData> {
  final Value<String> categoria;
  final Value<double?> limite;
  final Value<bool> mostrarEnInicio;
  final Value<int> rowid;
  const CategoriasVariablesConfigCompanion({
    this.categoria = const Value.absent(),
    this.limite = const Value.absent(),
    this.mostrarEnInicio = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriasVariablesConfigCompanion.insert({
    required String categoria,
    this.limite = const Value.absent(),
    this.mostrarEnInicio = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : categoria = Value(categoria);
  static Insertable<CategoriasVariablesConfigData> custom({
    Expression<String>? categoria,
    Expression<double>? limite,
    Expression<bool>? mostrarEnInicio,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (categoria != null) 'categoria': categoria,
      if (limite != null) 'limite': limite,
      if (mostrarEnInicio != null) 'mostrar_en_inicio': mostrarEnInicio,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriasVariablesConfigCompanion copyWith(
      {Value<String>? categoria,
      Value<double?>? limite,
      Value<bool>? mostrarEnInicio,
      Value<int>? rowid}) {
    return CategoriasVariablesConfigCompanion(
      categoria: categoria ?? this.categoria,
      limite: limite ?? this.limite,
      mostrarEnInicio: mostrarEnInicio ?? this.mostrarEnInicio,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (limite.present) {
      map['limite'] = Variable<double>(limite.value);
    }
    if (mostrarEnInicio.present) {
      map['mostrar_en_inicio'] = Variable<bool>(mostrarEnInicio.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasVariablesConfigCompanion(')
          ..write('categoria: $categoria, ')
          ..write('limite: $limite, ')
          ..write('mostrarEnInicio: $mostrarEnInicio, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $IngresosTable ingresos = $IngresosTable(this);
  late final $GastosFijosTable gastosFijos = $GastosFijosTable(this);
  late final $GastosFijosPagosTable gastosFijosPagos =
      $GastosFijosPagosTable(this);
  late final $GastosVariablesTable gastosVariables =
      $GastosVariablesTable(this);
  late final $DeliveryGastosTable deliveryGastos = $DeliveryGastosTable(this);
  late final $AhorrosMetasTable ahorrosMetas = $AhorrosMetasTable(this);
  late final $ConfiguracionTable configuracion = $ConfiguracionTable(this);
  late final $CategoriasVariablesConfigTable categoriasVariablesConfig =
      $CategoriasVariablesConfigTable(this);
  late final IngresosDao ingresosDao = IngresosDao(this as AppDatabase);
  late final GastosFijosDao gastosFijosDao =
      GastosFijosDao(this as AppDatabase);
  late final GastosVariablesDao gastosVariablesDao =
      GastosVariablesDao(this as AppDatabase);
  late final CategoriasVariablesConfigDao categoriasVariablesConfigDao =
      CategoriasVariablesConfigDao(this as AppDatabase);
  late final DeliveryDao deliveryDao = DeliveryDao(this as AppDatabase);
  late final AhorrosDao ahorrosDao = AhorrosDao(this as AppDatabase);
  late final ConfiguracionDao configuracionDao =
      ConfiguracionDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        ingresos,
        gastosFijos,
        gastosFijosPagos,
        gastosVariables,
        deliveryGastos,
        ahorrosMetas,
        configuracion,
        categoriasVariablesConfig
      ];
}

typedef $$IngresosTableCreateCompanionBuilder = IngresosCompanion Function({
  Value<int> id,
  required String fuente,
  required double monto,
  required DateTime fecha,
  required int mes,
  required int anio,
  Value<String?> notas,
});
typedef $$IngresosTableUpdateCompanionBuilder = IngresosCompanion Function({
  Value<int> id,
  Value<String> fuente,
  Value<double> monto,
  Value<DateTime> fecha,
  Value<int> mes,
  Value<int> anio,
  Value<String?> notas,
});

class $$IngresosTableFilterComposer
    extends Composer<_$AppDatabase, $IngresosTable> {
  $$IngresosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fuente => $composableBuilder(
      column: $table.fuente, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get monto => $composableBuilder(
      column: $table.monto, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mes => $composableBuilder(
      column: $table.mes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get anio => $composableBuilder(
      column: $table.anio, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notas => $composableBuilder(
      column: $table.notas, builder: (column) => ColumnFilters(column));
}

class $$IngresosTableOrderingComposer
    extends Composer<_$AppDatabase, $IngresosTable> {
  $$IngresosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fuente => $composableBuilder(
      column: $table.fuente, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get monto => $composableBuilder(
      column: $table.monto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mes => $composableBuilder(
      column: $table.mes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get anio => $composableBuilder(
      column: $table.anio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notas => $composableBuilder(
      column: $table.notas, builder: (column) => ColumnOrderings(column));
}

class $$IngresosTableAnnotationComposer
    extends Composer<_$AppDatabase, $IngresosTable> {
  $$IngresosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fuente =>
      $composableBuilder(column: $table.fuente, builder: (column) => column);

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<int> get mes =>
      $composableBuilder(column: $table.mes, builder: (column) => column);

  GeneratedColumn<int> get anio =>
      $composableBuilder(column: $table.anio, builder: (column) => column);

  GeneratedColumn<String> get notas =>
      $composableBuilder(column: $table.notas, builder: (column) => column);
}

class $$IngresosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IngresosTable,
    Ingreso,
    $$IngresosTableFilterComposer,
    $$IngresosTableOrderingComposer,
    $$IngresosTableAnnotationComposer,
    $$IngresosTableCreateCompanionBuilder,
    $$IngresosTableUpdateCompanionBuilder,
    (Ingreso, BaseReferences<_$AppDatabase, $IngresosTable, Ingreso>),
    Ingreso,
    PrefetchHooks Function()> {
  $$IngresosTableTableManager(_$AppDatabase db, $IngresosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngresosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngresosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngresosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> fuente = const Value.absent(),
            Value<double> monto = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int> mes = const Value.absent(),
            Value<int> anio = const Value.absent(),
            Value<String?> notas = const Value.absent(),
          }) =>
              IngresosCompanion(
            id: id,
            fuente: fuente,
            monto: monto,
            fecha: fecha,
            mes: mes,
            anio: anio,
            notas: notas,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String fuente,
            required double monto,
            required DateTime fecha,
            required int mes,
            required int anio,
            Value<String?> notas = const Value.absent(),
          }) =>
              IngresosCompanion.insert(
            id: id,
            fuente: fuente,
            monto: monto,
            fecha: fecha,
            mes: mes,
            anio: anio,
            notas: notas,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$IngresosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IngresosTable,
    Ingreso,
    $$IngresosTableFilterComposer,
    $$IngresosTableOrderingComposer,
    $$IngresosTableAnnotationComposer,
    $$IngresosTableCreateCompanionBuilder,
    $$IngresosTableUpdateCompanionBuilder,
    (Ingreso, BaseReferences<_$AppDatabase, $IngresosTable, Ingreso>),
    Ingreso,
    PrefetchHooks Function()>;
typedef $$GastosFijosTableCreateCompanionBuilder = GastosFijosCompanion
    Function({
  Value<int> id,
  required String nombre,
  required double monto,
  Value<int?> diaVencimiento,
  Value<bool> activo,
  Value<String> categoria,
  Value<String?> notas,
  Value<bool> mostrarEnInicio,
});
typedef $$GastosFijosTableUpdateCompanionBuilder = GastosFijosCompanion
    Function({
  Value<int> id,
  Value<String> nombre,
  Value<double> monto,
  Value<int?> diaVencimiento,
  Value<bool> activo,
  Value<String> categoria,
  Value<String?> notas,
  Value<bool> mostrarEnInicio,
});

final class $$GastosFijosTableReferences
    extends BaseReferences<_$AppDatabase, $GastosFijosTable, GastosFijo> {
  $$GastosFijosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GastosFijosPagosTable, List<GastosFijosPago>>
      _gastosFijosPagosRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.gastosFijosPagos,
              aliasName: $_aliasNameGenerator(
                  db.gastosFijos.id, db.gastosFijosPagos.gastoFijoId));

  $$GastosFijosPagosTableProcessedTableManager get gastosFijosPagosRefs {
    final manager = $$GastosFijosPagosTableTableManager(
            $_db, $_db.gastosFijosPagos)
        .filter((f) => f.gastoFijoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_gastosFijosPagosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GastosFijosTableFilterComposer
    extends Composer<_$AppDatabase, $GastosFijosTable> {
  $$GastosFijosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get monto => $composableBuilder(
      column: $table.monto, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diaVencimiento => $composableBuilder(
      column: $table.diaVencimiento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get activo => $composableBuilder(
      column: $table.activo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notas => $composableBuilder(
      column: $table.notas, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get mostrarEnInicio => $composableBuilder(
      column: $table.mostrarEnInicio,
      builder: (column) => ColumnFilters(column));

  Expression<bool> gastosFijosPagosRefs(
      Expression<bool> Function($$GastosFijosPagosTableFilterComposer f) f) {
    final $$GastosFijosPagosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gastosFijosPagos,
        getReferencedColumn: (t) => t.gastoFijoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GastosFijosPagosTableFilterComposer(
              $db: $db,
              $table: $db.gastosFijosPagos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GastosFijosTableOrderingComposer
    extends Composer<_$AppDatabase, $GastosFijosTable> {
  $$GastosFijosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get monto => $composableBuilder(
      column: $table.monto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diaVencimiento => $composableBuilder(
      column: $table.diaVencimiento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get activo => $composableBuilder(
      column: $table.activo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notas => $composableBuilder(
      column: $table.notas, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get mostrarEnInicio => $composableBuilder(
      column: $table.mostrarEnInicio,
      builder: (column) => ColumnOrderings(column));
}

class $$GastosFijosTableAnnotationComposer
    extends Composer<_$AppDatabase, $GastosFijosTable> {
  $$GastosFijosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<int> get diaVencimiento => $composableBuilder(
      column: $table.diaVencimiento, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<String> get notas =>
      $composableBuilder(column: $table.notas, builder: (column) => column);

  GeneratedColumn<bool> get mostrarEnInicio => $composableBuilder(
      column: $table.mostrarEnInicio, builder: (column) => column);

  Expression<T> gastosFijosPagosRefs<T extends Object>(
      Expression<T> Function($$GastosFijosPagosTableAnnotationComposer a) f) {
    final $$GastosFijosPagosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gastosFijosPagos,
        getReferencedColumn: (t) => t.gastoFijoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GastosFijosPagosTableAnnotationComposer(
              $db: $db,
              $table: $db.gastosFijosPagos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GastosFijosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GastosFijosTable,
    GastosFijo,
    $$GastosFijosTableFilterComposer,
    $$GastosFijosTableOrderingComposer,
    $$GastosFijosTableAnnotationComposer,
    $$GastosFijosTableCreateCompanionBuilder,
    $$GastosFijosTableUpdateCompanionBuilder,
    (GastosFijo, $$GastosFijosTableReferences),
    GastosFijo,
    PrefetchHooks Function({bool gastosFijosPagosRefs})> {
  $$GastosFijosTableTableManager(_$AppDatabase db, $GastosFijosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GastosFijosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GastosFijosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GastosFijosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<double> monto = const Value.absent(),
            Value<int?> diaVencimiento = const Value.absent(),
            Value<bool> activo = const Value.absent(),
            Value<String> categoria = const Value.absent(),
            Value<String?> notas = const Value.absent(),
            Value<bool> mostrarEnInicio = const Value.absent(),
          }) =>
              GastosFijosCompanion(
            id: id,
            nombre: nombre,
            monto: monto,
            diaVencimiento: diaVencimiento,
            activo: activo,
            categoria: categoria,
            notas: notas,
            mostrarEnInicio: mostrarEnInicio,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            required double monto,
            Value<int?> diaVencimiento = const Value.absent(),
            Value<bool> activo = const Value.absent(),
            Value<String> categoria = const Value.absent(),
            Value<String?> notas = const Value.absent(),
            Value<bool> mostrarEnInicio = const Value.absent(),
          }) =>
              GastosFijosCompanion.insert(
            id: id,
            nombre: nombre,
            monto: monto,
            diaVencimiento: diaVencimiento,
            activo: activo,
            categoria: categoria,
            notas: notas,
            mostrarEnInicio: mostrarEnInicio,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GastosFijosTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({gastosFijosPagosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (gastosFijosPagosRefs) db.gastosFijosPagos
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (gastosFijosPagosRefs)
                    await $_getPrefetchedData<GastosFijo, $GastosFijosTable,
                            GastosFijosPago>(
                        currentTable: table,
                        referencedTable: $$GastosFijosTableReferences
                            ._gastosFijosPagosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GastosFijosTableReferences(db, table, p0)
                                .gastosFijosPagosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.gastoFijoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GastosFijosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GastosFijosTable,
    GastosFijo,
    $$GastosFijosTableFilterComposer,
    $$GastosFijosTableOrderingComposer,
    $$GastosFijosTableAnnotationComposer,
    $$GastosFijosTableCreateCompanionBuilder,
    $$GastosFijosTableUpdateCompanionBuilder,
    (GastosFijo, $$GastosFijosTableReferences),
    GastosFijo,
    PrefetchHooks Function({bool gastosFijosPagosRefs})>;
typedef $$GastosFijosPagosTableCreateCompanionBuilder
    = GastosFijosPagosCompanion Function({
  Value<int> id,
  required int gastoFijoId,
  required int mes,
  required int anio,
  Value<bool> pagado,
  Value<DateTime?> fechaPago,
});
typedef $$GastosFijosPagosTableUpdateCompanionBuilder
    = GastosFijosPagosCompanion Function({
  Value<int> id,
  Value<int> gastoFijoId,
  Value<int> mes,
  Value<int> anio,
  Value<bool> pagado,
  Value<DateTime?> fechaPago,
});

final class $$GastosFijosPagosTableReferences extends BaseReferences<
    _$AppDatabase, $GastosFijosPagosTable, GastosFijosPago> {
  $$GastosFijosPagosTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GastosFijosTable _gastoFijoIdTable(_$AppDatabase db) =>
      db.gastosFijos.createAlias($_aliasNameGenerator(
          db.gastosFijosPagos.gastoFijoId, db.gastosFijos.id));

  $$GastosFijosTableProcessedTableManager get gastoFijoId {
    final $_column = $_itemColumn<int>('gasto_fijo_id')!;

    final manager = $$GastosFijosTableTableManager($_db, $_db.gastosFijos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gastoFijoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GastosFijosPagosTableFilterComposer
    extends Composer<_$AppDatabase, $GastosFijosPagosTable> {
  $$GastosFijosPagosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mes => $composableBuilder(
      column: $table.mes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get anio => $composableBuilder(
      column: $table.anio, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pagado => $composableBuilder(
      column: $table.pagado, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaPago => $composableBuilder(
      column: $table.fechaPago, builder: (column) => ColumnFilters(column));

  $$GastosFijosTableFilterComposer get gastoFijoId {
    final $$GastosFijosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gastoFijoId,
        referencedTable: $db.gastosFijos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GastosFijosTableFilterComposer(
              $db: $db,
              $table: $db.gastosFijos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GastosFijosPagosTableOrderingComposer
    extends Composer<_$AppDatabase, $GastosFijosPagosTable> {
  $$GastosFijosPagosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mes => $composableBuilder(
      column: $table.mes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get anio => $composableBuilder(
      column: $table.anio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pagado => $composableBuilder(
      column: $table.pagado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaPago => $composableBuilder(
      column: $table.fechaPago, builder: (column) => ColumnOrderings(column));

  $$GastosFijosTableOrderingComposer get gastoFijoId {
    final $$GastosFijosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gastoFijoId,
        referencedTable: $db.gastosFijos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GastosFijosTableOrderingComposer(
              $db: $db,
              $table: $db.gastosFijos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GastosFijosPagosTableAnnotationComposer
    extends Composer<_$AppDatabase, $GastosFijosPagosTable> {
  $$GastosFijosPagosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get mes =>
      $composableBuilder(column: $table.mes, builder: (column) => column);

  GeneratedColumn<int> get anio =>
      $composableBuilder(column: $table.anio, builder: (column) => column);

  GeneratedColumn<bool> get pagado =>
      $composableBuilder(column: $table.pagado, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaPago =>
      $composableBuilder(column: $table.fechaPago, builder: (column) => column);

  $$GastosFijosTableAnnotationComposer get gastoFijoId {
    final $$GastosFijosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.gastoFijoId,
        referencedTable: $db.gastosFijos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GastosFijosTableAnnotationComposer(
              $db: $db,
              $table: $db.gastosFijos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GastosFijosPagosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GastosFijosPagosTable,
    GastosFijosPago,
    $$GastosFijosPagosTableFilterComposer,
    $$GastosFijosPagosTableOrderingComposer,
    $$GastosFijosPagosTableAnnotationComposer,
    $$GastosFijosPagosTableCreateCompanionBuilder,
    $$GastosFijosPagosTableUpdateCompanionBuilder,
    (GastosFijosPago, $$GastosFijosPagosTableReferences),
    GastosFijosPago,
    PrefetchHooks Function({bool gastoFijoId})> {
  $$GastosFijosPagosTableTableManager(
      _$AppDatabase db, $GastosFijosPagosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GastosFijosPagosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GastosFijosPagosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GastosFijosPagosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> gastoFijoId = const Value.absent(),
            Value<int> mes = const Value.absent(),
            Value<int> anio = const Value.absent(),
            Value<bool> pagado = const Value.absent(),
            Value<DateTime?> fechaPago = const Value.absent(),
          }) =>
              GastosFijosPagosCompanion(
            id: id,
            gastoFijoId: gastoFijoId,
            mes: mes,
            anio: anio,
            pagado: pagado,
            fechaPago: fechaPago,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int gastoFijoId,
            required int mes,
            required int anio,
            Value<bool> pagado = const Value.absent(),
            Value<DateTime?> fechaPago = const Value.absent(),
          }) =>
              GastosFijosPagosCompanion.insert(
            id: id,
            gastoFijoId: gastoFijoId,
            mes: mes,
            anio: anio,
            pagado: pagado,
            fechaPago: fechaPago,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GastosFijosPagosTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({gastoFijoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (gastoFijoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.gastoFijoId,
                    referencedTable:
                        $$GastosFijosPagosTableReferences._gastoFijoIdTable(db),
                    referencedColumn: $$GastosFijosPagosTableReferences
                        ._gastoFijoIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GastosFijosPagosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GastosFijosPagosTable,
    GastosFijosPago,
    $$GastosFijosPagosTableFilterComposer,
    $$GastosFijosPagosTableOrderingComposer,
    $$GastosFijosPagosTableAnnotationComposer,
    $$GastosFijosPagosTableCreateCompanionBuilder,
    $$GastosFijosPagosTableUpdateCompanionBuilder,
    (GastosFijosPago, $$GastosFijosPagosTableReferences),
    GastosFijosPago,
    PrefetchHooks Function({bool gastoFijoId})>;
typedef $$GastosVariablesTableCreateCompanionBuilder = GastosVariablesCompanion
    Function({
  Value<int> id,
  required String descripcion,
  required double monto,
  required DateTime fecha,
  required int mes,
  required int anio,
  Value<String> categoria,
  Value<String?> notas,
});
typedef $$GastosVariablesTableUpdateCompanionBuilder = GastosVariablesCompanion
    Function({
  Value<int> id,
  Value<String> descripcion,
  Value<double> monto,
  Value<DateTime> fecha,
  Value<int> mes,
  Value<int> anio,
  Value<String> categoria,
  Value<String?> notas,
});

class $$GastosVariablesTableFilterComposer
    extends Composer<_$AppDatabase, $GastosVariablesTable> {
  $$GastosVariablesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get monto => $composableBuilder(
      column: $table.monto, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mes => $composableBuilder(
      column: $table.mes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get anio => $composableBuilder(
      column: $table.anio, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notas => $composableBuilder(
      column: $table.notas, builder: (column) => ColumnFilters(column));
}

class $$GastosVariablesTableOrderingComposer
    extends Composer<_$AppDatabase, $GastosVariablesTable> {
  $$GastosVariablesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get monto => $composableBuilder(
      column: $table.monto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mes => $composableBuilder(
      column: $table.mes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get anio => $composableBuilder(
      column: $table.anio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notas => $composableBuilder(
      column: $table.notas, builder: (column) => ColumnOrderings(column));
}

class $$GastosVariablesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GastosVariablesTable> {
  $$GastosVariablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<int> get mes =>
      $composableBuilder(column: $table.mes, builder: (column) => column);

  GeneratedColumn<int> get anio =>
      $composableBuilder(column: $table.anio, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<String> get notas =>
      $composableBuilder(column: $table.notas, builder: (column) => column);
}

class $$GastosVariablesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GastosVariablesTable,
    GastosVariable,
    $$GastosVariablesTableFilterComposer,
    $$GastosVariablesTableOrderingComposer,
    $$GastosVariablesTableAnnotationComposer,
    $$GastosVariablesTableCreateCompanionBuilder,
    $$GastosVariablesTableUpdateCompanionBuilder,
    (
      GastosVariable,
      BaseReferences<_$AppDatabase, $GastosVariablesTable, GastosVariable>
    ),
    GastosVariable,
    PrefetchHooks Function()> {
  $$GastosVariablesTableTableManager(
      _$AppDatabase db, $GastosVariablesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GastosVariablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GastosVariablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GastosVariablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> descripcion = const Value.absent(),
            Value<double> monto = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int> mes = const Value.absent(),
            Value<int> anio = const Value.absent(),
            Value<String> categoria = const Value.absent(),
            Value<String?> notas = const Value.absent(),
          }) =>
              GastosVariablesCompanion(
            id: id,
            descripcion: descripcion,
            monto: monto,
            fecha: fecha,
            mes: mes,
            anio: anio,
            categoria: categoria,
            notas: notas,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String descripcion,
            required double monto,
            required DateTime fecha,
            required int mes,
            required int anio,
            Value<String> categoria = const Value.absent(),
            Value<String?> notas = const Value.absent(),
          }) =>
              GastosVariablesCompanion.insert(
            id: id,
            descripcion: descripcion,
            monto: monto,
            fecha: fecha,
            mes: mes,
            anio: anio,
            categoria: categoria,
            notas: notas,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GastosVariablesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GastosVariablesTable,
    GastosVariable,
    $$GastosVariablesTableFilterComposer,
    $$GastosVariablesTableOrderingComposer,
    $$GastosVariablesTableAnnotationComposer,
    $$GastosVariablesTableCreateCompanionBuilder,
    $$GastosVariablesTableUpdateCompanionBuilder,
    (
      GastosVariable,
      BaseReferences<_$AppDatabase, $GastosVariablesTable, GastosVariable>
    ),
    GastosVariable,
    PrefetchHooks Function()>;
typedef $$DeliveryGastosTableCreateCompanionBuilder = DeliveryGastosCompanion
    Function({
  Value<int> id,
  required String descripcion,
  required double monto,
  required DateTime fecha,
  required int mes,
  required int anio,
  Value<String?> plataforma,
});
typedef $$DeliveryGastosTableUpdateCompanionBuilder = DeliveryGastosCompanion
    Function({
  Value<int> id,
  Value<String> descripcion,
  Value<double> monto,
  Value<DateTime> fecha,
  Value<int> mes,
  Value<int> anio,
  Value<String?> plataforma,
});

class $$DeliveryGastosTableFilterComposer
    extends Composer<_$AppDatabase, $DeliveryGastosTable> {
  $$DeliveryGastosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get monto => $composableBuilder(
      column: $table.monto, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mes => $composableBuilder(
      column: $table.mes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get anio => $composableBuilder(
      column: $table.anio, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get plataforma => $composableBuilder(
      column: $table.plataforma, builder: (column) => ColumnFilters(column));
}

class $$DeliveryGastosTableOrderingComposer
    extends Composer<_$AppDatabase, $DeliveryGastosTable> {
  $$DeliveryGastosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get monto => $composableBuilder(
      column: $table.monto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mes => $composableBuilder(
      column: $table.mes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get anio => $composableBuilder(
      column: $table.anio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get plataforma => $composableBuilder(
      column: $table.plataforma, builder: (column) => ColumnOrderings(column));
}

class $$DeliveryGastosTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeliveryGastosTable> {
  $$DeliveryGastosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<int> get mes =>
      $composableBuilder(column: $table.mes, builder: (column) => column);

  GeneratedColumn<int> get anio =>
      $composableBuilder(column: $table.anio, builder: (column) => column);

  GeneratedColumn<String> get plataforma => $composableBuilder(
      column: $table.plataforma, builder: (column) => column);
}

class $$DeliveryGastosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DeliveryGastosTable,
    DeliveryGasto,
    $$DeliveryGastosTableFilterComposer,
    $$DeliveryGastosTableOrderingComposer,
    $$DeliveryGastosTableAnnotationComposer,
    $$DeliveryGastosTableCreateCompanionBuilder,
    $$DeliveryGastosTableUpdateCompanionBuilder,
    (
      DeliveryGasto,
      BaseReferences<_$AppDatabase, $DeliveryGastosTable, DeliveryGasto>
    ),
    DeliveryGasto,
    PrefetchHooks Function()> {
  $$DeliveryGastosTableTableManager(
      _$AppDatabase db, $DeliveryGastosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeliveryGastosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeliveryGastosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeliveryGastosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> descripcion = const Value.absent(),
            Value<double> monto = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int> mes = const Value.absent(),
            Value<int> anio = const Value.absent(),
            Value<String?> plataforma = const Value.absent(),
          }) =>
              DeliveryGastosCompanion(
            id: id,
            descripcion: descripcion,
            monto: monto,
            fecha: fecha,
            mes: mes,
            anio: anio,
            plataforma: plataforma,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String descripcion,
            required double monto,
            required DateTime fecha,
            required int mes,
            required int anio,
            Value<String?> plataforma = const Value.absent(),
          }) =>
              DeliveryGastosCompanion.insert(
            id: id,
            descripcion: descripcion,
            monto: monto,
            fecha: fecha,
            mes: mes,
            anio: anio,
            plataforma: plataforma,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DeliveryGastosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DeliveryGastosTable,
    DeliveryGasto,
    $$DeliveryGastosTableFilterComposer,
    $$DeliveryGastosTableOrderingComposer,
    $$DeliveryGastosTableAnnotationComposer,
    $$DeliveryGastosTableCreateCompanionBuilder,
    $$DeliveryGastosTableUpdateCompanionBuilder,
    (
      DeliveryGasto,
      BaseReferences<_$AppDatabase, $DeliveryGastosTable, DeliveryGasto>
    ),
    DeliveryGasto,
    PrefetchHooks Function()>;
typedef $$AhorrosMetasTableCreateCompanionBuilder = AhorrosMetasCompanion
    Function({
  Value<int> id,
  required String nombre,
  required double montoMensual,
  Value<double?> montoObjetivo,
  Value<bool> activo,
  Value<String> emoji,
});
typedef $$AhorrosMetasTableUpdateCompanionBuilder = AhorrosMetasCompanion
    Function({
  Value<int> id,
  Value<String> nombre,
  Value<double> montoMensual,
  Value<double?> montoObjetivo,
  Value<bool> activo,
  Value<String> emoji,
});

class $$AhorrosMetasTableFilterComposer
    extends Composer<_$AppDatabase, $AhorrosMetasTable> {
  $$AhorrosMetasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get montoMensual => $composableBuilder(
      column: $table.montoMensual, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get montoObjetivo => $composableBuilder(
      column: $table.montoObjetivo, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get activo => $composableBuilder(
      column: $table.activo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnFilters(column));
}

class $$AhorrosMetasTableOrderingComposer
    extends Composer<_$AppDatabase, $AhorrosMetasTable> {
  $$AhorrosMetasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get montoMensual => $composableBuilder(
      column: $table.montoMensual,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get montoObjetivo => $composableBuilder(
      column: $table.montoObjetivo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get activo => $composableBuilder(
      column: $table.activo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnOrderings(column));
}

class $$AhorrosMetasTableAnnotationComposer
    extends Composer<_$AppDatabase, $AhorrosMetasTable> {
  $$AhorrosMetasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<double> get montoMensual => $composableBuilder(
      column: $table.montoMensual, builder: (column) => column);

  GeneratedColumn<double> get montoObjetivo => $composableBuilder(
      column: $table.montoObjetivo, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);
}

class $$AhorrosMetasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AhorrosMetasTable,
    AhorrosMeta,
    $$AhorrosMetasTableFilterComposer,
    $$AhorrosMetasTableOrderingComposer,
    $$AhorrosMetasTableAnnotationComposer,
    $$AhorrosMetasTableCreateCompanionBuilder,
    $$AhorrosMetasTableUpdateCompanionBuilder,
    (
      AhorrosMeta,
      BaseReferences<_$AppDatabase, $AhorrosMetasTable, AhorrosMeta>
    ),
    AhorrosMeta,
    PrefetchHooks Function()> {
  $$AhorrosMetasTableTableManager(_$AppDatabase db, $AhorrosMetasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AhorrosMetasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AhorrosMetasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AhorrosMetasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<double> montoMensual = const Value.absent(),
            Value<double?> montoObjetivo = const Value.absent(),
            Value<bool> activo = const Value.absent(),
            Value<String> emoji = const Value.absent(),
          }) =>
              AhorrosMetasCompanion(
            id: id,
            nombre: nombre,
            montoMensual: montoMensual,
            montoObjetivo: montoObjetivo,
            activo: activo,
            emoji: emoji,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            required double montoMensual,
            Value<double?> montoObjetivo = const Value.absent(),
            Value<bool> activo = const Value.absent(),
            Value<String> emoji = const Value.absent(),
          }) =>
              AhorrosMetasCompanion.insert(
            id: id,
            nombre: nombre,
            montoMensual: montoMensual,
            montoObjetivo: montoObjetivo,
            activo: activo,
            emoji: emoji,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AhorrosMetasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AhorrosMetasTable,
    AhorrosMeta,
    $$AhorrosMetasTableFilterComposer,
    $$AhorrosMetasTableOrderingComposer,
    $$AhorrosMetasTableAnnotationComposer,
    $$AhorrosMetasTableCreateCompanionBuilder,
    $$AhorrosMetasTableUpdateCompanionBuilder,
    (
      AhorrosMeta,
      BaseReferences<_$AppDatabase, $AhorrosMetasTable, AhorrosMeta>
    ),
    AhorrosMeta,
    PrefetchHooks Function()>;
typedef $$ConfiguracionTableCreateCompanionBuilder = ConfiguracionCompanion
    Function({
  Value<int> id,
  required String clave,
  required String valor,
});
typedef $$ConfiguracionTableUpdateCompanionBuilder = ConfiguracionCompanion
    Function({
  Value<int> id,
  Value<String> clave,
  Value<String> valor,
});

class $$ConfiguracionTableFilterComposer
    extends Composer<_$AppDatabase, $ConfiguracionTable> {
  $$ConfiguracionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clave => $composableBuilder(
      column: $table.clave, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get valor => $composableBuilder(
      column: $table.valor, builder: (column) => ColumnFilters(column));
}

class $$ConfiguracionTableOrderingComposer
    extends Composer<_$AppDatabase, $ConfiguracionTable> {
  $$ConfiguracionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clave => $composableBuilder(
      column: $table.clave, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get valor => $composableBuilder(
      column: $table.valor, builder: (column) => ColumnOrderings(column));
}

class $$ConfiguracionTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConfiguracionTable> {
  $$ConfiguracionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clave =>
      $composableBuilder(column: $table.clave, builder: (column) => column);

  GeneratedColumn<String> get valor =>
      $composableBuilder(column: $table.valor, builder: (column) => column);
}

class $$ConfiguracionTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConfiguracionTable,
    ConfiguracionData,
    $$ConfiguracionTableFilterComposer,
    $$ConfiguracionTableOrderingComposer,
    $$ConfiguracionTableAnnotationComposer,
    $$ConfiguracionTableCreateCompanionBuilder,
    $$ConfiguracionTableUpdateCompanionBuilder,
    (
      ConfiguracionData,
      BaseReferences<_$AppDatabase, $ConfiguracionTable, ConfiguracionData>
    ),
    ConfiguracionData,
    PrefetchHooks Function()> {
  $$ConfiguracionTableTableManager(_$AppDatabase db, $ConfiguracionTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConfiguracionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConfiguracionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConfiguracionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> clave = const Value.absent(),
            Value<String> valor = const Value.absent(),
          }) =>
              ConfiguracionCompanion(
            id: id,
            clave: clave,
            valor: valor,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String clave,
            required String valor,
          }) =>
              ConfiguracionCompanion.insert(
            id: id,
            clave: clave,
            valor: valor,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ConfiguracionTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConfiguracionTable,
    ConfiguracionData,
    $$ConfiguracionTableFilterComposer,
    $$ConfiguracionTableOrderingComposer,
    $$ConfiguracionTableAnnotationComposer,
    $$ConfiguracionTableCreateCompanionBuilder,
    $$ConfiguracionTableUpdateCompanionBuilder,
    (
      ConfiguracionData,
      BaseReferences<_$AppDatabase, $ConfiguracionTable, ConfiguracionData>
    ),
    ConfiguracionData,
    PrefetchHooks Function()>;
typedef $$CategoriasVariablesConfigTableCreateCompanionBuilder
    = CategoriasVariablesConfigCompanion Function({
  required String categoria,
  Value<double?> limite,
  Value<bool> mostrarEnInicio,
  Value<int> rowid,
});
typedef $$CategoriasVariablesConfigTableUpdateCompanionBuilder
    = CategoriasVariablesConfigCompanion Function({
  Value<String> categoria,
  Value<double?> limite,
  Value<bool> mostrarEnInicio,
  Value<int> rowid,
});

class $$CategoriasVariablesConfigTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriasVariablesConfigTable> {
  $$CategoriasVariablesConfigTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get limite => $composableBuilder(
      column: $table.limite, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get mostrarEnInicio => $composableBuilder(
      column: $table.mostrarEnInicio,
      builder: (column) => ColumnFilters(column));
}

class $$CategoriasVariablesConfigTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriasVariablesConfigTable> {
  $$CategoriasVariablesConfigTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get limite => $composableBuilder(
      column: $table.limite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get mostrarEnInicio => $composableBuilder(
      column: $table.mostrarEnInicio,
      builder: (column) => ColumnOrderings(column));
}

class $$CategoriasVariablesConfigTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriasVariablesConfigTable> {
  $$CategoriasVariablesConfigTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<double> get limite =>
      $composableBuilder(column: $table.limite, builder: (column) => column);

  GeneratedColumn<bool> get mostrarEnInicio => $composableBuilder(
      column: $table.mostrarEnInicio, builder: (column) => column);
}

class $$CategoriasVariablesConfigTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriasVariablesConfigTable,
    CategoriasVariablesConfigData,
    $$CategoriasVariablesConfigTableFilterComposer,
    $$CategoriasVariablesConfigTableOrderingComposer,
    $$CategoriasVariablesConfigTableAnnotationComposer,
    $$CategoriasVariablesConfigTableCreateCompanionBuilder,
    $$CategoriasVariablesConfigTableUpdateCompanionBuilder,
    (
      CategoriasVariablesConfigData,
      BaseReferences<_$AppDatabase, $CategoriasVariablesConfigTable,
          CategoriasVariablesConfigData>
    ),
    CategoriasVariablesConfigData,
    PrefetchHooks Function()> {
  $$CategoriasVariablesConfigTableTableManager(
      _$AppDatabase db, $CategoriasVariablesConfigTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriasVariablesConfigTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriasVariablesConfigTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriasVariablesConfigTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> categoria = const Value.absent(),
            Value<double?> limite = const Value.absent(),
            Value<bool> mostrarEnInicio = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriasVariablesConfigCompanion(
            categoria: categoria,
            limite: limite,
            mostrarEnInicio: mostrarEnInicio,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String categoria,
            Value<double?> limite = const Value.absent(),
            Value<bool> mostrarEnInicio = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriasVariablesConfigCompanion.insert(
            categoria: categoria,
            limite: limite,
            mostrarEnInicio: mostrarEnInicio,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoriasVariablesConfigTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CategoriasVariablesConfigTable,
        CategoriasVariablesConfigData,
        $$CategoriasVariablesConfigTableFilterComposer,
        $$CategoriasVariablesConfigTableOrderingComposer,
        $$CategoriasVariablesConfigTableAnnotationComposer,
        $$CategoriasVariablesConfigTableCreateCompanionBuilder,
        $$CategoriasVariablesConfigTableUpdateCompanionBuilder,
        (
          CategoriasVariablesConfigData,
          BaseReferences<_$AppDatabase, $CategoriasVariablesConfigTable,
              CategoriasVariablesConfigData>
        ),
        CategoriasVariablesConfigData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$IngresosTableTableManager get ingresos =>
      $$IngresosTableTableManager(_db, _db.ingresos);
  $$GastosFijosTableTableManager get gastosFijos =>
      $$GastosFijosTableTableManager(_db, _db.gastosFijos);
  $$GastosFijosPagosTableTableManager get gastosFijosPagos =>
      $$GastosFijosPagosTableTableManager(_db, _db.gastosFijosPagos);
  $$GastosVariablesTableTableManager get gastosVariables =>
      $$GastosVariablesTableTableManager(_db, _db.gastosVariables);
  $$DeliveryGastosTableTableManager get deliveryGastos =>
      $$DeliveryGastosTableTableManager(_db, _db.deliveryGastos);
  $$AhorrosMetasTableTableManager get ahorrosMetas =>
      $$AhorrosMetasTableTableManager(_db, _db.ahorrosMetas);
  $$ConfiguracionTableTableManager get configuracion =>
      $$ConfiguracionTableTableManager(_db, _db.configuracion);
  $$CategoriasVariablesConfigTableTableManager get categoriasVariablesConfig =>
      $$CategoriasVariablesConfigTableTableManager(
          _db, _db.categoriasVariablesConfig);
}

mixin _$IngresosDaoMixin on DatabaseAccessor<AppDatabase> {
  $IngresosTable get ingresos => attachedDatabase.ingresos;
}
mixin _$GastosFijosDaoMixin on DatabaseAccessor<AppDatabase> {
  $GastosFijosTable get gastosFijos => attachedDatabase.gastosFijos;
  $GastosFijosPagosTable get gastosFijosPagos =>
      attachedDatabase.gastosFijosPagos;
}
mixin _$GastosVariablesDaoMixin on DatabaseAccessor<AppDatabase> {
  $GastosVariablesTable get gastosVariables => attachedDatabase.gastosVariables;
}
mixin _$CategoriasVariablesConfigDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriasVariablesConfigTable get categoriasVariablesConfig =>
      attachedDatabase.categoriasVariablesConfig;
}
mixin _$DeliveryDaoMixin on DatabaseAccessor<AppDatabase> {
  $DeliveryGastosTable get deliveryGastos => attachedDatabase.deliveryGastos;
}
mixin _$AhorrosDaoMixin on DatabaseAccessor<AppDatabase> {
  $AhorrosMetasTable get ahorrosMetas => attachedDatabase.ahorrosMetas;
}
mixin _$ConfiguracionDaoMixin on DatabaseAccessor<AppDatabase> {
  $ConfiguracionTable get configuracion => attachedDatabase.configuracion;
}
