import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FullScreenVerseImage extends StatefulWidget {
  final String backgroundAsset;
  final String title;
  final String verseText;

  const FullScreenVerseImage({
    super.key,
    required this.backgroundAsset,
    required this.title,
    required this.verseText,
  });

  @override
  State<FullScreenVerseImage> createState() => _FullScreenVerseImageState();
}

class _FullScreenVerseImageState extends State<FullScreenVerseImage> {

  final GlobalKey _repaintKey = GlobalKey();

  Future<bool> _requestGalleryPermission() async {
    if (Platform.isIOS) {
      // 1️⃣ Try add-only permission (recommended)
      var status = await Permission.photosAddOnly.request();

      if (status.isGranted) return true;

      log("photosAddOnly denied, requesting full photos permission");

      // 2️⃣ Fallback to full photos permission
      status = await Permission.photos.request();
      return status.isGranted;
    }

    // ANDROID
    if (Platform.isAndroid) {
      var status = await Permission.photos.request();
      return status.isGranted;
    }

    return false;
  }

  Future<void> _saveVerseToGallery() async {
    try {
      // ✅ Permissions
      final hasPermission = await _requestGalleryPermission();
      if (!hasPermission) {
        log("Gallery permission NOT granted");
        openAppSettings();
        return;
      }

      // ✅ Wait for render
      await WidgetsBinding.instance.endOfFrame;

      final boundary = _repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      final bytes = byteData!.buffer.asUint8List();

      final dir = await getTemporaryDirectory();
      final file = File(
        '${dir.path}/verse_${DateTime.now().millisecondsSinceEpoch}.png',
      );

      log("File Saved: ${dir.path}/verse_${DateTime.now().millisecondsSinceEpoch}.png");

      await file.writeAsBytes(bytes);

      await GallerySaver.saveImage(
        file.path,
        albumName: 'Verse Images',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved to Gallery')),
        );
      }
    } catch (e) {
      debugPrint('Save error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _saveVerseToGallery, child: Icon(Icons.download_rounded)),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: RepaintBoundary(
          key: _repaintKey,
          child: Stack(
            children: [
              Positioned.fill(
                child: InkWell(onTap: ()=>Navigator.pop(context), child: Image.asset(widget.backgroundAsset, fit: BoxFit.cover)),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.3,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.verseText,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.merriweather(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              color: Colors.black87,
                              offset: Offset(2, 2),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "~ ${widget.title}",
                          style: GoogleFonts.merriweather(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
