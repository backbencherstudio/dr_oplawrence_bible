import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../../data/repository/donation_repository.dart';

class DonationStripeScreen extends StatefulWidget {
  const DonationStripeScreen({super.key});

  @override
  State<DonationStripeScreen> createState() => _DonationStripeScreenState();
}

class _DonationStripeScreenState extends State<DonationStripeScreen> {
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;

  final DonationRepository repository = DonationRepository();

  Future<void> _payWithStripe() async {
    setState(() => _isLoading = true);

    try {
      final amount = double.tryParse(_amountController.text);
      if (amount == null || amount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter a valid amount')),
        );
        setState(() => _isLoading = false);
        return;
      }

      // 1️⃣ Create donation on backend to get clientSecret
      final donation = await repository.createDonation(
        amount: amount,
        currency: "usd",
      );

      if (donation == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create donation')),
        );
        setState(() => _isLoading = false);
        return;
      }

      // 2️⃣ Initialize Stripe PaymentSheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: donation.clientSecret,
          merchantDisplayName: 'My Church Donation',
        ),
      );

      // 3️⃣ Present the PaymentSheet
      try {
        await Stripe.instance.presentPaymentSheet();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment successful!')),
        );
        _amountController.clear();
      } on StripeException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed: ${e.error.localizedMessage}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donate')),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16.0.w),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount (USD)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
             SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _payWithStripe,
                child: _isLoading
                    ?  SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Donate with Stripe'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}