import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/constansts/icon_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/utils.dart';
import 'package:dr_oplawrence_bible/presentation/common_widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

// final fileProvider = StateNotifierProvider<FileFunction, PickerState>(
//   (ref) => FileFunction(),
// );

// class PickerState {
//   final XFile? singleImage;
//   final List<XFile>? multipleImage;
//   final PlatformFile? singleFile;
//   final List<PlatformFile>? multipleFile;

//   const PickerState({
//     this.singleImage,
//     this.multipleImage,
//     this.singleFile,
//     this.multipleFile,
//   });

//   PickerState copyWith({
//     XFile? singleImage,
//     List<XFile>? multipleImage,
//     PlatformFile? singleFile,
//     List<PlatformFile>? multipleFile,
//   }) {
//     return PickerState(
//       singleImage: singleImage ?? this.singleImage,
//       multipleImage: multipleImage ?? this.multipleImage,
//       singleFile: singleFile ?? this.singleFile,
//       multipleFile: multipleFile ?? this.multipleFile,
//     );
//   }
// }

// class FileFunction extends StateNotifier<PickerState> {
//   FileFunction() : super(const PickerState());

//   final picker = ImagePicker();

//   Future<void> pickSingleImage() async {
//     final image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       state = state.copyWith(singleImage: image);
//     }
//   }

//   Future<void> pickMultipleImage() async {
//     final images = await picker.pickMultiImage();
//     if (images.isNotEmpty) {
//       state = state.copyWith(multipleImage: images);
//     }
//   }

//   Future<void> pickSingleFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'doc', 'docx'],
//     );
//     if (result != null && result.files.isNotEmpty) {
//       state = state.copyWith(singleFile: result.files.first);
//     }
//   }

//   Future<void> pickMultipleFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'doc', 'docx'],
//     );
//     if (result != null && result.files.isNotEmpty) {
//       state = state.copyWith(multipleFile: result.files);
//     }
//   }

//   void clearPicker() {
//     state = const PickerState();
//   }
// }

final imageProvider = StateNotifierProvider<ImageNotifier, List<XFile>>((ref) {
  return ImageNotifier();
});

class ImageNotifier extends StateNotifier<List<XFile>> {
  ImageNotifier() : super([]);

  final ImagePicker picker = ImagePicker();

  // Function to add new images to the list
  Future<void> addImages() async {
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    state = [...state, ...pickedFiles]; // Add new images to the existing list
  }

  void removeImageAt(int index) {
    final updatedList = [...state]..removeAt(index);
    state = updatedList;
  }

  void clearImages() {
    state = []; // Add new images to the existing list
  }
}

class CustomImagePicker extends ConsumerWidget {
  const CustomImagePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileState = ref.watch(imageProvider);
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
                    ref.read(imageProvider.notifier).addImages();
                  },
                ),
              ],
            ),
          )
        : GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: fileState.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              if (index == fileState.length) {
                return GestureDetector(
                  onTap: () {
                    ref.read(imageProvider.notifier).addImages();
                  },
                  child: Container(
                    width: Utils.fullWidth(context) * 0.3,
                    decoration: BoxDecoration(
                      color: ColorsManager.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.add),
                  ),
                );
              } else {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(fileState[index].path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        onPressed: () async {
                          ref.read(imageProvider.notifier).removeImageAt(index);
                        },
                        icon: Icon(
                          Icons.close,
                          color: ColorsManager.whiteColor,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          );
  }
}
