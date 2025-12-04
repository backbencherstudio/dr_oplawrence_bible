import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final tabProvider = StateProvider.autoDispose<int>((ref)=> 0);

class ScrollableTabView extends ConsumerWidget {
  final List<String> tabs;
  const ScrollableTabView({super.key, required this.tabs,});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final tabStatus = ref.watch(tabProvider);
          return InkWell(
            onTap: (){
              ref.read(tabProvider.notifier).state = index;
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (tabStatus == index) ? ColorsManager.primaryColor : ColorsManager.whiteColor,
                borderRadius: BorderRadius.circular(8),
                border: (tabStatus != index) ? Border.all(width: 1, color: ColorsManager.primaryColor) : null,
              ),
              child: Text(tabs[index], style: getSmallStyle(color: (tabStatus == index) ? ColorsManager.whiteColor : ColorsManager.primaryTextColor),),
            ),
          );
        }),
      ),
    );
  }
}
