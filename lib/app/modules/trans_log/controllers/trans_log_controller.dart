import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ujikom_getx/app/data/models/transactions_model.dart';

class TransLogController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLogs() async* {
    yield* firestore
        .collection("transactions")
        .orderBy("created_at", descending: true)
        .snapshots();
  }

  RxList<TransLogsModel> allLogs = List<TransLogsModel>.empty().obs;

  void downloadCatalog() async {
    final pdf = pw.Document();

    var getData = await firestore.collection("transactions").get();

    // reset all logs
    allLogs([]);
    // isi data allLogs dari database
    for (var element in getData.docs) {
      allLogs.add(TransLogsModel.fromJson(element.data()));
    }

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            List<pw.TableRow> allData = List.generate(allLogs.length, (index) {
              TransLogsModel logs = allLogs[index];
              String formattedDate =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(logs.createdAt);
              return pw.TableRow(children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    "${index + 1}",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    formattedDate,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    logs.namaPelanggan,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    logs.namaProduk,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    "Rp.${logs.hargaProduk}",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    "${logs.berat} Kg",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    "Rp.${logs.totalHarga}",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    logs.id,
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                  ),
                )
              ]);
            });
            return [
              pw.Center(
                  child: pw.Text("TRANSACTION LOGS",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontSize: 16.sp))),
              pw.SizedBox(height: 20.h),
              pw.Table(
                  border: pw.TableBorder.all(
                      color: PdfColor.fromHex("#000000"), width: 2),
                  children: [
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          "No.",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          "Time",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          "Customer",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          "Product",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          "Product Price",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          "Weight Amount",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          "Total Price",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(
                          "Transaction ID",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 7.sp, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ]),
                    ...allData,
                  ])
            ];
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
