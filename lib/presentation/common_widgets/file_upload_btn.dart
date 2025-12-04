import 'package:dotted_border/dotted_border.dart';
import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/constansts/icon_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:dr_oplawrence_bible/presentation/common_widgets/primary_btn.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/svg.dart';

final fileProvider = StateNotifierProvider<FileNotifier, List<PlatformFile>>((
  ref,
) {
  return FileNotifier();
});

class FileNotifier extends StateNotifier<List<PlatformFile>> {
  FileNotifier() : super([]);

  // Function to add new images to the list
  Future<void> addFiles() async {
    final pickedFiles = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png',],
    );
    if (pickedFiles != null && pickedFiles.files.isNotEmpty) {
      state = [...state, ...pickedFiles.files];
    } // Add new images to the existing list
  }

  void removeFile(int index) {
    final updatedList = [...state]..removeAt(index);
    state = updatedList;
  }

  void clearFile() {
    state = []; // Add new images to the existing list
  }
}

class FileUploadBtn extends ConsumerWidget {
  const FileUploadBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileState = ref.watch(fileProvider);
    return (fileState.isEmpty)
        ? DottedBorder(
            options: RectDottedBorderOptions(
              dashPattern: [10, 5],
              strokeWidth: 1,
              padding: EdgeInsets.all(16),
              color: ColorsManager.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(IconManager.file, height: 42, width: 42),
                SizedBox(height: 12),
                Text(
                  'Drag your file(s) to start uploading',
                  style: getExtraMediumStyle(),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'or',
                        style: getMediumStyle(
                          color: ColorsManager.secondaryTextColor,
                        ),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 12),
                PrimaryBtn(
                  text: "Browse Files",
                  isBig: false,
                  color: ColorsManager.primaryColor,
                  onTap: () {
                    ref.read(fileProvider.notifier).addFiles();
                  },
                ),
              ],
            ),
          )
        : ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 16),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: fileState.length + 1,
            itemBuilder: (context, index) {
              if (index == fileState.length) {
                return GestureDetector(
                  onTap: () {
                    ref.read(fileProvider.notifier).addFiles();
                  },
                  child: Container(
                    width: Utils.fullWidth(context) * 0.05,
                    decoration: BoxDecoration(
                      color: ColorsManager.lightBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.add),
                  ),
                );
              } else {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorsManager.primaryColor, width: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        (fileState[index].extension == "pdf")
                            ? Icons.picture_as_pdf_outlined
                            : Icons.file_copy_outlined,
                      ),
                      Text(fileState[index].name),
                      Text("${(fileState[index].size / (1024 * 1024)).toStringAsFixed(2)} MB", style: getSmallStyle(),),
                      IconButton(onPressed: ()=>ref.read(fileProvider.notifier).removeFile(index), icon: Icon(Icons.close))
                    ],
                  ),
                );
              }
            },
          );
  }
}
