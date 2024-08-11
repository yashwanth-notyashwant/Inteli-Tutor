import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:loading_btn/loading_btn.dart';

// ignore: must_be_immutable
class DownloadIconButton extends StatelessWidget {
  String title;
  String desc;
  DownloadIconButton(this.title, this.desc);
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

    // Helper function to split text into chunks
    List<String> _splitText(String text, int chunkSize) {
      List<String> chunks = [];
      int start = 0;
      while (start < text.length) {
        int end = start + chunkSize;
        if (end > text.length) end = text.length;
        chunks.add(text.substring(start, end));
        start = end;
      }
      return chunks;
    }

    // Define your text chunk size based on your font size and page size
    const int chunkSize = 1500; // Adjust as needed
    List<String> textChunks = _splitText(desc, chunkSize);

    for (String chunk in textChunks) {
      pdf.addPage(
        pw.MultiPage(
          build: (pw.Context context) => [
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Text(
                    title,
                    style: pw.TextStyle(
                        fontSize: 26, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Text(
                    chunk,
                    style: pw.TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/specific_name.pdf");
    await file.writeAsBytes(await pdf.save());

    await OpenFile.open(file.path);
  }
}
