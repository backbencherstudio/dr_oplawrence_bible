import 'package:dr_oplawrence_bible/core/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonateMoneySystem extends StatefulWidget {
  const DonateMoneySystem({super.key});

  @override
  State<DonateMoneySystem> createState() => _DonateMoneySystemState();
}

class _DonateMoneySystemState extends State<DonateMoneySystem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset('assets/icons/back_arrow.png', scale: 4),
        ),
      ),
      backgroundColor: Color(0xffEBEBEB),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Donate Money',
              style: GoogleFonts.merriweather(
                color: Color(0xffB02626),
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            Divider(color: Color(0xffB02626), thickness: 1),
            SizedBox(height: 10.h),
            Text(
              'Donate with',
              style: GoogleFonts.merriweather(
                color: Color(0xff4A4C56),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width:double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.donationScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffEBEBEB),
                  side: BorderSide(    color: Color(0xff4A4C56),),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/alert_triangle.svg'),
                      Text(
                        'Card',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width:double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.donationScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffEBEBEB),
                  side: BorderSide(    color: Color(0xff4A4C56),),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/alert_triangle.svg'),
                      Text(
                        'Klarna',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
