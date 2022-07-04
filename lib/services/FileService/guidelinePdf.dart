import 'package:helbage/model/IModel.dart';
import 'package:helbage/model/guideLineModel.dart';
import 'package:helbage/services/FileService/pdfServices.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class guidelinePdf implements pdfServices {
  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      {
        var permissionGranted = true;
      }
      ;
    }
  }

  @override
  Future<bool> toPDF(IModel workingGuideline) async {
    _getStoragePermission();
    workingGuideline as guidelineModel;
    // Directory.current = new Directory('/storage/emulated/0/');
    // var dir = new Directory("helbage");
    // dir.create();

    String time = DateTime.now().toString();
    PdfDocument document = PdfDocument();

    //header
    final PdfPageTemplateElement headerTemplate =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
    headerTemplate.graphics.drawString("Title: ${workingGuideline.title}",
        PdfStandardFont(PdfFontFamily.helvetica, 20));
    document.template.top = headerTemplate;
    //body
    PdfPage page = document.pages.add();
    PdfLayoutResult layoutResult = PdfTextElement(
            text: workingGuideline.content,
            font: PdfStandardFont(PdfFontFamily.helvetica, 15),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                0, 0, page.getClientSize().width, page.getClientSize().height),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
    //body
    // document.pages.add().graphics.drawString(
    // "Author: ${workingGuideline.author} ${workingGuideline.content}",
    // PdfStandardFont(PdfFontFamily.helvetica, 12),
    // brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    // bounds: const Rect.fromLTWH(0, 0, 150, 20));

    //footer

    final PdfPageTemplateElement footerTemplate =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
    footerTemplate.graphics.drawString(
        time.toString(), PdfStandardFont(PdfFontFamily.helvetica, 15));
    document.template.bottom = footerTemplate;
    var path = (await getExternalStorageDirectory())!.path;
    // var filetime = time.toString().replaceAll(":", ".");
    File file = File('$path/$time.pdf');

    file.writeAsBytes(await document.save(), flush: true);
    document.dispose();

    if (await File('$path/$time.pdf').exists()) {
      return true;
    } else {
      return false;
    }
  }
}
