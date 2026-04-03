# Gaveo 💰

Aplicación móvil para la gestión financiera del hogar. Registra ingresos, gastos fijos, gastos variables, delivery y metas de ahorro — todo filtrado por mes.

---

## Características

- **Dashboard mensual**: saldo disponible, % comprometido y resumen de todas las categorías
- **Ingresos**: registro de fuentes de ingreso por mes
- **Gastos fijos**: servicios y cuotas recurrentes con seguimiento de pago
- **Gastos variables**: imprevistos y compras esporádicas
- **Delivery**: control de gasto en apps de envío con presupuesto mensual y alertas
- **Ahorros**: metas de ahorro con monto mensual y objetivo total
- **Navegación por meses**: acceso a historial con límite de 1 mes adelante
- **Internacionalización**: soporte completo para Español e Inglés (ARB files)
- **Selector de moneda**: picker curado con ~40 monedas (LATAM + globales) con bandera, nombre y símbolo

---

## Stack tecnológico

| Capa | Tecnología |
|---|---|
| Framework | Flutter (Dart) |
| Estado | Riverpod v2 + anotaciones `@riverpod` |
| Base de datos | Drift (SQLite tipado) |
| Navegación | GoRouter |
| Gráficos | fl_chart |
| UI | Material 3, google_fonts, flutter_animate |
| Notificaciones | flutter_local_notifications |
| Exportación | pdf + printing |

---

## Requisitos previos

- Flutter SDK (canal stable, versión reciente)
- Dart SDK incluido con Flutter
- Android Studio o Xcode (según plataforma objetivo)

---

## Identificadores

- **Bundle ID / App ID:** `com.gaveo.app`
- **Nombre de paquete Flutter:** `gaveo`

---

## Instalación y ejecución

```bash
# 1. Clonar el repositorio
git clone <url-del-repo>
cd gaveo

# 2. Instalar dependencias
flutter pub get

# 3. Generar código de Drift y Riverpod
dart run build_runner build --delete-conflicting-outputs

# 4. Correr la aplicación
flutter run
```

> **Importante:** El paso 3 es obligatorio antes de cada compilación si se modificaron tablas Drift o providers Riverpod. Los archivos `.g.dart` son generados — no editarlos manualmente.

---

## Estructura del proyecto

```
lib/
├── main.dart                    # Entry point
├── app/
│   ├── app.dart                 # GaveoApp widget raíz
│   ├── router.dart              # Configuración GoRouter
│   └── theme/                   # Colores, tipografía, tema Material 3
├── core/
│   ├── database/                # AppDatabase (Drift) y migraciones
│   ├── utils/                   # Formateadores, extensiones, date utils
│   └── constants/               # Constantes globales (AppConstants, currencies)
├── l10n/                        # ARB files (app_es.arb, app_en.arb) → AppLocalizations
├── features/
│   ├── dashboard/               # Resumen financiero mensual
│   ├── ingresos/                # Gestión de ingresos
│   ├── gastos_fijos/            # Gastos recurrentes + tracking de pago
│   ├── gastos_variables/        # Gastos imprevistos
│   ├── delivery/                # Control de delivery con presupuesto
│   └── ahorros/                 # Metas de ahorro
└── shared/
    ├── widgets/                 # Widgets reutilizables entre features
    └── models/                  # Modelos compartidos
```

Cada feature sigue la estructura `data/` + `providers/` + `presentation/`.

---

## Navegación

- **Nav bar (5 ítems):** Dashboard · Gastos Fijos · Variables · Delivery · Ahorros
- **Ingresos:** accesible tocando la tarjeta de ingresos en el Dashboard
- **Configuración:** ícono de engranaje en el AppBar del Dashboard (nombre, moneda, idioma)

---

## Fórmula del saldo disponible

```
Saldo Disponible =
  totalIngresos
  - totalGastosFijosActivos    ← siempre, pagados o no
  - totalGastosVariables
  - totalDelivery
  - totalAhorrosMensuales
```

---

## Comandos útiles

```bash
# Watch mode (durante desarrollo activo)
dart run build_runner watch --delete-conflicting-outputs

# Regenerar strings de l10n (tras cambios en ARB files)
flutter gen-l10n

# Análisis estático
flutter analyze

# Tests
flutter test
```

---

## Convenciones de código

- **Clases**: `PascalCase`
- **Variables y métodos**: `camelCase`
- **Archivos**: `snake_case`
- Código fuente en inglés; textos de UI en español
- `const` constructores siempre que sea posible
- Widgets > 200 líneas → extraer en sub-widgets
