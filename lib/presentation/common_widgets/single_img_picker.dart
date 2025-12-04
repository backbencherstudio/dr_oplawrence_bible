import 'dart:io';
import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/constansts/image_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

final singleimageProvider = StateNotifierProvider<ImageNotifier, XFile?>((ref) {
  return ImageNotifier();
});

class ImageNotifier extends StateNotifier<XFile?> {
  ImageNotifier() : super(null);

  final ImagePicker picker = ImagePicker();

  // Function to add new images to the list
  Future<void> addImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    state = pickedFile; // Add new images to the existing list
  }

  void removeImage() {
    state = null;
  }
}

class SingleImgPicker extends ConsumerWidget {
  const SingleImgPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileState = ref.watch(singleimageProvider);
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Positioned(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (fileState == null)
                  ? Image.asset(ImageManager.editUser)
                  : Image.file(File(fileState.path), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: ()=>ref.read(singleimageProvider.notifier).addImage(),
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ColorsManager.primaryColor,
                ),
                child: Icon(Icons.edit, color: ColorsManager.whiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
