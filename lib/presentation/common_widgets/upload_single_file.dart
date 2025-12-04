import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/constansts/icon_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/svg.dart';

final singleFileProvider =
    StateNotifierProvider.family<SingleFileNotifier, PlatformFile?, String>((ref, label) {
      return SingleFileNotifier();
    });

class SingleFileNotifier extends StateNotifier<PlatformFile?> {
  SingleFileNotifier() : super(null);

  // Function to add new images to the list
  Future<void> addFiles() async {
    final pickedFiles = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
    );
    if (pickedFiles != null && pickedFiles.files.isNotEmpty) {
      state = pickedFiles.files.first;
    } // Add new images to the existing list
  }

  void removeFile() {
    state = null;
  }
}

class UploadSingleFile extends ConsumerWidget {
  final String label;
  const UploadSingleFile({super.key, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileState = ref.watch(singleFileProvider(label));
    return (fileState == null)
        ? Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorsManager.textFormBorderColor.withValues(alpha: 0.5),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SvgPicture.asset(IconManager.doc03),
                SizedBox(width: 8),
                SizedBox(width: Utils.fullWidth(context) * 0.55, child: Text(label, maxLines: null)),
                Spacer(),
                InkWell(
                  onTap: ()=>ref.read(singleFileProvider(label).notifier).addFiles(),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorsManager.successColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconManager.cloudUpload),
                        Text(
                          "Upload File",
                          style: getSmallStyle(color: ColorsManager.whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorsManager.primaryColor,
                width: 0.1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  (fileState.extension == "pdf")
                      ? Icons.picture_as_pdf_outlined
                      : Icons.file_copy_outlined,
                ),
                Text(fileState.name),
                Text(
                  "${(fileState.size / (1024 * 1024)).toStringAsFixed(2)} MB",
                  style: getSmallStyle(),
                ),
                IconButton(
                  onPressed: () =>
                      ref.read(singleFileProvider(label).notifier).removeFile(),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          );
  }
}
