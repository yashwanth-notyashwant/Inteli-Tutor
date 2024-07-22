import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:loading_btn/loading_btn.dart';

class DownloadIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: LoadingBtn(
        height: 60,
        borderRadius: 20,
        animate: true,
        color: Color.fromARGB(255, 236, 240, 243),
        width: MediaQuery.of(context).size.width,
        loader: Container(
          padding: const EdgeInsets.all(10),
          width: 40,
          height: 40,
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        onTap: ((startLoading, stopLoading, btnState) async {
          if (btnState == ButtonState.idle) {
            startLoading();

            await _createAndDownloadPDF();
            stopLoading();
          }
        }),
        child: const Text(
          'Download Section',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w300, color: Colors.black),
        ), //add some styles
      ),
    );
  }

  Future<void> _createAndDownloadPDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('This is the specific text in the PDF'),
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/specific_name.pdf");
    await file.writeAsBytes(await pdf.save());

    await OpenFile.open(file.path);
  }
}
