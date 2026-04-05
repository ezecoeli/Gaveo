import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../utils/currency_formatter.dart';
import '../../features/configuracion/providers/configuracion_providers.dart';
import '../../features/dashboard/providers/dashboard_summary.dart';

class ReporteService {
  ReporteService._();

  /// Genera y comparte el resumen mensual en PDF.
  static Future<void> compartirResumenMensual({
    required DashboardSummary summary,
    required ConfiguracionData config,
    required int mes,
    required int anio,
    required String locale,
  }) async {
    final pdf = await _buildPdf(
      summary: summary,
      config: config,
      mes: mes,
      anio: anio,
      locale: locale,
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'gaveo_resumen_${anio}_${mes.toString().padLeft(2, '0')}.pdf',
    );
  }

  static Future<pw.Document> _buildPdf({
    required DashboardSummary summary,
    required ConfiguracionData config,
    required int mes,
    required int anio,
    required String locale,
  }) async {
    final fontRegular = await PdfGoogleFonts.notoSansRegular();
    final fontBold = await PdfGoogleFonts.notoSansBold();

    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(
        base: fontRegular,
        bold: fontBold,
      ),
    );
    final simbolo = config.simbolo;
    final mesNombrePDF = DateFormat('MMMM yyyy', locale).format(DateTime(anio, mes));

    // Colors
    const primaryColor = PdfColor.fromInt(0xFF2D6A4F);
    const incomeColor = PdfColor.fromInt(0xFF2D6A4F);
    const expenseColor = PdfColor.fromInt(0xFFE63946);
    const savingsColor = PdfColor.fromInt(0xFF457B9D);
    const textLight = PdfColor.fromInt(0xFF6B7280);
    const bgLight = PdfColor.fromInt(0xFFF8F9FA);

    String fmt(double v) => CurrencyFormatter.format(v, symbol: simbolo);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(20),
                decoration: const pw.BoxDecoration(
                  color: primaryColor,
                  borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Gaveo',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      mesNombrePDF.toUpperCase(),
                      style: const pw.TextStyle(
                        fontSize: 13,
                        color: PdfColors.white,
                      ),
                    ),
                    if (config.nombreUsuario.isNotEmpty) ...[
                      pw.SizedBox(height: 4),
                      pw.Text(
                        config.nombreUsuario,
                        style: const pw.TextStyle(
                          fontSize: 11,
                          color: PdfColors.white,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              pw.SizedBox(height: 24),

              // Saldo disponible
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: bgLight,
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                  border: pw.Border.all(
                    color: summary.saldoDisponible >= 0
                        ? incomeColor
                        : expenseColor,
                    width: 1.5,
                  ),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Saldo disponible',
                        style: const pw.TextStyle(
                            fontSize: 11, color: textLight)),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      fmt(summary.saldoDisponible),
                      style: pw.TextStyle(
                        fontSize: 22,
                        fontWeight: pw.FontWeight.bold,
                        color: summary.saldoDisponible >= 0
                            ? incomeColor
                            : expenseColor,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Tabla de conceptos
              pw.Text('Detalle',
                  style: pw.TextStyle(
                      fontSize: 13, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              _buildRow('Ingresos', fmt(summary.totalIngresos),
                  incomeColor, isHeader: false),
              _buildDivider(),
              _buildRow('Gastos fijos', fmt(summary.totalGastosFijos),
                  expenseColor),
              _buildRow(
                  'Gastos variables', fmt(summary.totalGastosVariables),
                  expenseColor),
              _buildRow('Ahorros', fmt(summary.totalAhorros), savingsColor),
              _buildDivider(),

              // Totales resumen
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total gastos + ahorros',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 12)),
                  pw.Text(
                    fmt(summary.totalGastosFijos +
                        summary.totalGastosVariables +
                        summary.totalAhorros),
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                        color: expenseColor),
                  ),
                ],
              ),

              pw.Spacer(),

              // Footer
              pw.Divider(color: textLight),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Generado por Gaveo',
                      style:
                          const pw.TextStyle(fontSize: 9, color: textLight)),
                  pw.Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
                    style: const pw.TextStyle(fontSize: 9, color: textLight),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  static pw.Widget _buildRow(
    String label,
    String value,
    PdfColor color, {
    bool isHeader = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label,
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight:
                    isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
              )),
          pw.Text(value,
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
                color: color,
              )),
        ],
      ),
    );
  }

  static pw.Widget _buildDivider() =>
      pw.Divider(color: const PdfColor.fromInt(0xFFE5E7EB), height: 1);
}
