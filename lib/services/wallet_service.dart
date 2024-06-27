// lib/services/wallet_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class WalletService {
  static const String baseUrl = 'https://api.socialverseapp.com/solana/wallet';



  // Create Wallet
  static Future<Map<String, dynamic> > createWallet() async {
      


    final response = await http.post(
      Uri.parse('https://api.socialverseapp.com/user/login'),
      headers: <String, String>{
        //this flic-token is of Sahil's Wallet
        'Flic-Token': 'flic_8ed1ae163d6c85db64177e741b947d433fb21eb848829aed848737067ed0e500',
      },
      body: 
      "{\n    \"wallet_name\": \"Sahil's Wallet\",\n    \"network\": \"devnet\",\n    \"user_pin\": \"111111\"\n}"
          
    );

    print(response.statusCode);
    print(response.headers["location"]);
    print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create wallet');
    }
  }

  // Transfer Balance
  static Future<Map<String, dynamic>> transferBalance(String fromAddress, String toAddress, double amount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transfer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'from_address': fromAddress,
        'to_address': toAddress,
        'amount': amount,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to transfer balance');
    }
  }

  // Retrieve Balance
  static Future<Map<String, dynamic>> retrieveBalance(String address) async {
    final response = await http.get(
      Uri.parse('$baseUrl/balance?address=$address'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve balance');
    }
  }

  // Request Airdrop
  static Future<Map<String, dynamic>> requestAirdrop(String address) async {
    final response = await http.post(
      Uri.parse('$baseUrl/airdrop'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'address': address,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to request airdrop');
    }
  }
}
