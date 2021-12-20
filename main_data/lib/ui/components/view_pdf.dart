import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ViewPdf extends StatelessWidget {
  final String cvUrl;
  const ViewPdf({Key? key , required this.cvUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const PDF(
          swipeHorizontal: true,
        ).cachedFromUrl(cvUrl),
      ),
    );
  }
}
