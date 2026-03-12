import 'package:dr_oplawrence_bible/core/network/api_endpoints.dart';

import '../../core/network/api_clients.dart';
import '../models/donate_response.dart';

class DonationRepository {
  Future<DonationResponse?> createDonation({
    required double amount,
    required String currency,
  }) async {
    final body = {
      "amount": amount,
      "currency": currency,
    };
    
    final response = await ApiClient.postRequest(
      endpoints: ApiEndpoints.donateMoney,
      body: body,
    );

    if (response != null) {
      return DonationResponse.fromJson(response);
    }
    return null;
  }
}