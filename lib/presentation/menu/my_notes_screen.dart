import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyNotesScreen extends StatefulWidget {
  const MyNotesScreen({super.key});

  @override
  State<MyNotesScreen> createState() => _MyNotesScreenState();
}

class _MyNotesScreenState extends State<MyNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffEBEBEB),
        title: Text(
          'My Notes',
          style: GoogleFonts.merriweather(
            color: const Color(0xffB02626),
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Color(0xffEBEBEB),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h,),
            Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              children: [
                Container(
                  width: 85.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/alert_triangle.svg'),
                        Text('Notes'),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 85.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/alert_triangle.svg'),
                        Text('Bookmark'),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 85.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/alert_triangle.svg'),
                        Text('Highlight'),
                      ],
                    ),
                  ),
                ),
              ],
            ),Spacer(),
            
            SizedBox(
              width: 200.w,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, RouteNames.donateMoneySystem);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffCDA434),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Donate Money'),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
