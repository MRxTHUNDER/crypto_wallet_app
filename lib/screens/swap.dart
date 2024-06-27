import 'package:flutter/material.dart';


class SwapView extends StatefulWidget {
  const SwapView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SwapViewState createState() => _SwapViewState();
}

class _SwapViewState extends State<SwapView> {
  String givingToken = 'VIBLE';
  String receivingToken = 'Uniswap';

  String amountToPay = '0';
  String amountToReceive = '0.00';

  // Conversion rates based on selected receiving token
  static const double uniswapRate = 0.000015;
  static const double tetherRate = 0.000120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swap'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Swap',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'You Pay',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Enter amount',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                amountToPay = value;
                                updateReceiveAmount();
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        DropdownButton<String>(
                          value: givingToken,
                          items: const [
                            DropdownMenuItem(
                              value: 'VIBLE',
                              child: Text('VIBLE'),
                            ),
                            // Add more dropdown items as needed
                          ],
                          onChanged: (value) {
                            setState(() {
                              givingToken = value!;
                              updateReceiveAmount();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'You Receive',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            amountToReceive,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        DropdownButton<String>(
                          value: receivingToken,
                          items: const [
                            DropdownMenuItem(
                              value: 'Uniswap',
                              child:  Text('Uniswap'),
                            ),
                            DropdownMenuItem(
                              value: 'Tether',
                              child: Text('Tether'),
                            ),
                            // Add more dropdown items as needed
                          ],
                          onChanged: (value) {
                            setState(() {
                              receivingToken = value!;
                              updateReceiveAmount();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(thickness: 1),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement swap functionality here
                  },
                  child: const Text('Swap'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateReceiveAmount() {
    double payAmount = double.tryParse(amountToPay) ?? 0;
    double calculatedAmount = 0.00;

    switch (receivingToken) {
      case 'Uniswap':
        calculatedAmount = payAmount * uniswapRate;
        break;
      case 'Tether':
        calculatedAmount = payAmount * tetherRate;
        break;
      // Add more cases for additional receiving tokens
    }

    setState(() {
      amountToReceive = calculatedAmount.toStringAsFixed(6); // Format to 2 decimal places
    });
  }
}