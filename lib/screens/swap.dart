import 'package:flutter/material.dart';


class SwapView extends StatefulWidget {
  @override
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
        title: Text('Swap'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Swap',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
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
                            decoration: InputDecoration(
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
                        SizedBox(
                          width: 5,
                        ),
                        DropdownButton<String>(
                          value: givingToken,
                          items: [
                            DropdownMenuItem(
                              child: Text('VIBLE'),
                              value: 'VIBLE',
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
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
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
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        DropdownButton<String>(
                          value: receivingToken,
                          items: [
                            DropdownMenuItem(
                              child: Text('Uniswap'),
                              value: 'Uniswap',
                            ),
                            DropdownMenuItem(
                              child: Text('Tether'),
                              value: 'Tether',
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
                Divider(thickness: 1),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement swap functionality here
                  },
                  child: Text('Swap'),
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