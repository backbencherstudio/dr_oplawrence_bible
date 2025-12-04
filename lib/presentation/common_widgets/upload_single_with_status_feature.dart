import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/constansts/icon_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/svg.dart';

final singleFileProvider =
    StateNotifierProvider.family<SingleFileNotifier, PlatformFile?, String>((
      ref,
      label,
    ) {
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

class UploadSingleWithStatusFeature extends ConsumerWidget {
  final String label;
  final String status;
  const UploadSingleWithStatusFeature({
    super.key,
    required this.label,
    required this.status,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsManager.textFormBorderColor.withValues(alpha: 0.5),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               SvgPicture.asset(IconManager.doc03),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, maxLines: null),
                  if(status == "Uploaded" || status == "Pending") ...[
                    Text("View Document", style: getSmallStyle(color: ColorsManager.primaryColor),)
                  ]
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (status == "Pending") ...[
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: ColorsManager.warningColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconManager.alertTriangle,
                        colorFilter: ColorFilter.mode(
                          ColorsManager.orangeTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        status,
                        style: getSmallStyle(color: ColorsManager.orangeTextColor),
                      ),
                    ],
                  ),
                ),
              ] else if (status == "Uploaded") ...[
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: ColorsManager.confirmColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconManager.checkmarkGreen,
                        colorFilter: ColorFilter.mode(
                          ColorsManager.greenTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        status,
                        style: getSmallStyle(color: ColorsManager.greenTextColor),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: ColorsManager.lighterror,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconManager.crossCircle,
                        colorFilter: ColorFilter.mode(
                          ColorsManager.errorColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        status,
                        style: getSmallStyle(color: ColorsManager.errorColor),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () =>
                      ref.read(singleFileProvider(label).notifier).addFiles(),
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
            ],
          ),
        ],
      ),
    );
  }
}
