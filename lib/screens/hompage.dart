// lib/screens/homepage.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:wallet_app/screens/send_address.dart';
import 'package:wallet_app/screens/send_username.dart';
import 'package:wallet_app/screens/swap.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_app/services/wallet_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}


class _HomeViewState extends State<HomeView> {
  String _walletAddress = '0x5BDb...56218';
  double _balance = 0.0;
  String _statusMessage = '';
  Map? mapResource= null  ;
  

  // Future apicall() async{
  //   http.Response response;
  //   response= await http.get(Uri.parse("https://reqres.in/api/users/2"));

  //   print(response);
  //   if(response.statusCode == 200){
  //     setState(() {
  //       mapResource = json.decode(response.body);
  //     });
    
  //   }
  //   print(response);
  // }

// @override
//   void initState() {
//     
//     super.initState();
//     apicall();
//   }

  void _createWallet() async {

    try {
      final response = await WalletService.createWallet();
      setState(() {
        _walletAddress = response['walletName'];
        //map = _walletAddress['wallet'];

        _statusMessage = 'Wallet Created Successfully';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error creating wallet: $e';
      });
    }
  }
  @override
  void initState() {
    
    super.initState();
    _createWallet();
  }

  // void _retrieveBalance() async {
  //   try {
  //     final response = await WalletService.retrieveBalance(_walletAddress);
  //     setState(() {
  //       _balance = response['balance'];
  //       _statusMessage = 'Balance Retrieved Successfully';
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _statusMessage = 'Error retrieving balance: $e';
  //     });
  //   }
  // }

  // void _requestAirdrop() async {
  //   try {
  //     final response = await WalletService.requestAirdrop(_walletAddress);
  //     _retrieveBalance(); // Refresh balance after airdrop
  //     setState(() {
  //       _statusMessage = 'Airdrop Requested Successfully';
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _statusMessage = 'Error requesting airdrop: $e';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        actions: const [
          Icon(Icons.more_horiz),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Balance',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 153, 97, 97),
                      
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _balance.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text( 
                _walletAddress,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => buildBottomSheet(context),
                        );
                      },
                      child: const Text('Send'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const SwapView());
                      },
                      child: const Text('Swap'),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _createWallet,
                    child: const Text('Create Wallet'),
                  ),
                  // TextButton(
                  //   onPressed: _retrieveBalance,
                  //   child: Text('Retrieve Balance'),
                  // ),
                  // TextButton(
                  //   onPressed: _requestAirdrop,
                  //   child: Text('Request Airdrop'),
                  // ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tokens',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Activity',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      'V',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VIBLE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$0.00',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.purple[100],
                    ),
                    child: const Center(
                      child: Text(
                        'MATIC',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MATIC',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$0.00',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                _statusMessage,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget buildBottomSheet(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          
          TextButton(
            onPressed: () {
              Get.to(() => sendAddress());
              //Navigator.pop(context); // Close the bottom sheet
            },
            child: const Row(
              children: [
                Icon(Icons.account_box),
                SizedBox(width: 5),
                Text('Address'),
              ],
            ),
          ),
        TextButton(
            onPressed: () {
              Get.to(() => sendUsername());
              //Navigator.pop(context); // Close the bottom sheet
            },
            child: const Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 5),
                Text('Username'),
              ],
            ),
        ),
        ],
      ),
    );
  }
