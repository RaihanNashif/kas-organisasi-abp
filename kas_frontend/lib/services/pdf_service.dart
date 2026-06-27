import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {

  static Future<void> generateLaporan({

    required String periode,

    required String pemasukan,

    required String pengeluaran,

    required String saldo,

  }) async {

    final pdf = pw.Document();

    pdf.addPage(

      pw.Page(

        build: (context) {

          return pw.Column(

            crossAxisAlignment:
                pw.CrossAxisAlignment.start,

            children: [

              pw.Text(
                "LAPORAN KAS ORGANISASI",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 20),

              pw.Text("Periode : $periode"),

              pw.SizedBox(height: 20),

              pw.Text("Total Pemasukan : $pemasukan"),

              pw.Text("Total Pengeluaran : $pengeluaran"),

              pw.Text("Saldo Akhir : $saldo"),

            ],

          );

        },

      ),

    );

    await Printing.layoutPdf(

      onLayout: (format) async =>
          pdf.save(),

    );

  }

}