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
    'United Kingdom'
  ];

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              const SizedBox(height: 16),
              const Text(
                'Payment Successful',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "You've successfully completed your order",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                        context, RouteNames.parentScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1F3B96),
                  ),
                  child: const Text('Back to Homepage'),
                ),
              )
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Donate Money',
              style: GoogleFonts.merriweather(
                color: const Color(0xffB02626),
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Divider(color: Color(0xffB02626), thickness: 1),
            SizedBox(height: 10.h),
            const Text('Add card', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 15),
            const Text(
              'Card information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                fillColor: const Color(0xffEBEBEB),
                hintText: 'Card Number',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('assets/images/Card1.svg'),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      fillColor: Color(0xffEBEBEB),
                      hintText: 'MM/YY',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    decoration:  InputDecoration(
                      fillColor: Color(0xffEBEBEB),
                      hintText: 'CVC',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/images/Card 2.svg'),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Billing address', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                fillColor: Color(0xffEBEBEB),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
              value: _selectedCountry,
              items: _countries.map((country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value!;
                });
              },
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                fillColor: Color(0xffEBEBEB),
                hintText: 'ZIP',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            const Text('Amount', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                fillColor: Color(0xffEBEBEB),
                hintText: 'Enter amount',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
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
