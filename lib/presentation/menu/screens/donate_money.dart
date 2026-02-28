import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/route/route_name.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  bool _saveCard = true;
  String _selectedCountry = 'United States';
  final List<String> _countries = [
    'United States',
    'Canada',
    'Mexico',
    'United Kingdom',
  ];

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
               SizedBox(height: 16.h),
               Text(
                'Payment Successful',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
               SizedBox(height: 8.h),
               Text(
                "You've successfully completed your order",
                textAlign: TextAlign.center,
              ),
               SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.parentScreen,
                      (router) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1F3B96),
                  ),
                  child:  Text('Back to Homepage'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEBEBEB),
      appBar: AppBar(
        backgroundColor: const Color(0xffEBEBEB),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset('assets/icons/back_arrow.png', scale: 4),
        ),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Donate Money',
              style: GoogleFonts.merriweather(
                color: const Color(0xffB02626),
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Divider(color: Color(0xffB02626), thickness: 1),
            SizedBox(height: 10.h),
             Text('Add card', style: TextStyle(fontSize: 16.sp)),
             SizedBox(height: 15.h),
             Text(
              'Card information',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
             SizedBox(height: 8.h),
            TextFormField(
              decoration: InputDecoration(
                fillColor: const Color(0xffEBEBEB),
                hintText: 'Card Number',
                suffixIcon: Padding(
                  padding:  EdgeInsets.all(8.0.r),
                  child: SvgPicture.asset('assets/images/Card1.svg'),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
             SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration:  InputDecoration(
                      fillColor: Color(0xffEBEBEB),
                      hintText: 'MM/YY',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                 SizedBox(width: 8.w),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Color(0xffEBEBEB),
                      hintText: 'CVC',
                      suffixIcon: Padding(
                        padding:  EdgeInsets.all(8.0.w),
                        child: SvgPicture.asset('assets/images/Card 2.svg'),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
             SizedBox(height: 24.h),
             Text('Billing address', style: TextStyle(fontSize: 16.sp)),
             SizedBox(height: 8.h),
            DropdownButtonFormField(
              decoration:  InputDecoration(
                fillColor: Color(0xffEBEBEB),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 5.h,
                ),
              ),
              value: _selectedCountry,
              items: _countries.map((country) {
                return DropdownMenuItem(value: country, child: Text(country));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value!;
                });
              },
            ),
             SizedBox(height: 8.h),
             TextField(
              decoration: InputDecoration(
                fillColor: Color(0xffEBEBEB),
                hintText: 'ZIP',
              ),
              keyboardType: TextInputType.number,
            ),
             SizedBox(height: 24.h),
             Text('Amount', style: TextStyle(fontSize: 16)),
             SizedBox(height: 8.h),
            TextFormField(
              decoration: const InputDecoration(
                fillColor: Color(0xffEBEBEB),
                hintText: 'Enter amount',
              ),
              keyboardType: TextInputType.number,
            ),
             SizedBox(height: 16.h),
            Row(
              children: [
                Checkbox(
                  value: _saveCard,
                  onChanged: (value) {
                    setState(() {
                      _saveCard = value!;
                    });
                  },
                ),
                const Text('Save this card for future payments'),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showSuccessDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1F3B96),
                ),
                child:  Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: Text('Pay'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
