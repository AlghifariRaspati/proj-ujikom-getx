import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CashierHomeController extends GetxController {
  void downloadCatalog() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Column(children: [
              pw.Center(
                  child: pw.Text("LAUNDRY LOGS",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle())),
              pw.SizedBox(height: 20),
              pw.Table(
                  border: pw.TableBorder.all(
                      color: PdfColor.fromHex("#000000"), width: 2),
                  children: [
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          "No.",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          "Product Name",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(
                          "Product Price",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold),
                        ),
                      )
                    ]),
                    ...List.generate(5, (index) {
                      return pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(20),
                          child: pw.Text(
                            "${index + 1}",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(20),
                          child: pw.Text(
                            "APAAJA",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(20),
                          child: pw.Text(
                            "Rp. ${index + 2345}",
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold),
                          ),
                        )
                      ]);
                    })
                  ])
            ]);
          }),
    );

    //save
    Uint8List bytes = await pdf.save();

    //for empty directory file
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mydocument.pdf');

    // insert data bytes -> empty file
    await file.writeAsBytes(bytes);

    //open pdf file
    await OpenFile.open(file.path);
  }
}
