# Gaveo

Aplicación móvil para la gestión financiera del hogar. Registra ingresos, gastos fijos, gastos variables y metas de ahorro mensualmente.

---

## Características

- **Dashboard mensual**: saldo disponible, % comprometido y resumen de todas las categorías con gráfico de distribución
- **Ingresos**: registro de fuentes de ingreso por mes
- **Gastos fijos**: servicios y cuotas recurrentes con seguimiento de pago mes a mes
- **Gastos variables**: imprevistos y compras esporádicas por categoría (incluye delivery como subcategoría)
- **Ahorros**: metas de ahorro con monto mensual y objetivo total
- **Historial**: resumen de los últimos 12 meses; toca un mes para navegar directo a él
- **Notificaciones locales**: aviso el día que vence cada gasto fijo
- **Exportación PDF**: resumen mensual completo compartible desde el Dashboard
- **Internacionalización**: soporte completo Español / Inglés (ARB files)
- **Selector de moneda**: picker curado con ~40 monedas (LATAM + globales)
- **Tema claro/oscuro**: selector en Configuración, sincronizado con el sistema

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
git clone https://github.com/ezecoeli/Gaveo.git
cd Gaveo

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
│   ├── database/                # AppDatabase (Drift) + 6 DAOs
│   ├── services/                # NotificationService, ReporteService
│   ├── utils/                   # Formateadores, extensiones, date utils
│   └── constants/               # AppConstants, lista de monedas curadas
├── l10n/                        # ARB files (app_es.arb, app_en.arb) → AppLocalizations
└── features/
    ├── dashboard/               # Resumen financiero mensual + gráfico
    ├── ingresos/                # Gestión de ingresos
    ├── gastos_fijos/            # Gastos recurrentes + tracking de pago
    ├── gastos_variables/        # Gastos imprevistos por categoría (incl. delivery)
    ├── ahorros/                 # Metas de ahorro
    ├── historial/               # Resumen de los últimos 12 meses
    └── configuracion/           # Perfil, moneda, idioma, tema
```

Cada feature sigue la estructura `data/` + `providers/` + `presentation/`.

---

## Navegación

- **Nav bar (5 ítems):** Resumen · Gastos Fijos · Varios · Ingresos · Ahorros
- **Historial:** botón de historial en el AppBar del Dashboard
- **Configuración:** ícono de engranaje en el AppBar del Dashboard (nombre, moneda, idioma, tema)

---

## Fórmula del saldo disponible

```
Saldo Disponible =
  totalIngresos
  - totalGastosFijosActivos    ← siempre, pagados o no
  - totalGastosVariables       ← incluye gastos con categoría 'delivery'
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
