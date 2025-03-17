import 'dart:convert';
import 'dart:typed_data';

import 'package:barcode/barcode.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Createqr extends StatefulWidget {
  const Createqr({super.key});

  @override
  State<Createqr> createState() => _CreateqrState();
}

class _CreateqrState extends State<Createqr> {
  final TextEditingController textEditingController = TextEditingController();
  String? svg;

  ColorFilter qrColorFilter(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ColorFilter.mode(
      isDarkMode ? Colors.white : Colors.black,
      BlendMode.srcIn,
    );
  }

  Future<void> saveSvgFile() async {
    if (svg == null) return;

    // Convert SVG string to bytes
    Uint8List svgBytes = Uint8List.fromList(utf8.encode(svg!));

    // Request file save
    await FileSaver.instance.saveFile(
      name: "qr_code",
      bytes: svgBytes,
      ext: "svg",
      mimeType: MimeType.custom,
      customMimeType: "image/svg+xml",
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Makes everything scrollable
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              maxLines: 8,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20), // Add spacing
            ElevatedButton(
              onPressed: () {
                final text = textEditingController.text.trim();
                final dm = Barcode.qrCode();
                final svgData = dm.toSvg(text, width: 200, height: 200);
                setState(() {
                  svg = svgData;
                });
              },
              child: const Text('Generate QR'),
            ),
            const SizedBox(height: 50), // Space before QR code
            if (svg != null)
              ColorFiltered(
                colorFilter: qrColorFilter(context),
                child: SvgPicture.string(svg!),
              ),
            const SizedBox(height: 30),
            SizedBox(
              width: 200,
              height: 35,
              child: FilledButton(
                onPressed: saveSvgFile,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ), // Change radius here
                  ),
                ),
                child: Text("Save QR"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
