import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project3/helper/show_Message.dart';
import 'package:project3/screen/home_screen.dart';
import 'package:project3/theme/theme.dart';

class PaymentPage extends StatefulWidget {
  final String price;
  const PaymentPage({
    super.key,
    required this.price,
  });
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final user = FirebaseAuth.instance.currentUser!;
  int type = 1;
  double rentFee = 15.00;
  void handleRadio(Object? e) => setState(() => type = e as int);
  // double calculateTotalPayment() {
  //   return widget.price * widget.selectPeriod + rentFee;
  // }
  Future<void> savePaymentData() async {
    try {
      String paymentTime = DateTime.now().millisecondsSinceEpoch.toString();
      // Create a reference to the 'payments' collection in Firestore
      final payments =
          FirebaseFirestore.instance.collection('payments').doc(paymentTime);

      // Save the price along with payment method and other details
      await payments.set({
        'price': widget.price,
        'payment_method': getPaymentMethod(),
        'timestamp': FieldValue.serverTimestamp(),
        'userId': user.email,
      });
      // Show a success message or navigate away
      showMessage(context, 'Payment confirmed and saved to Firebase!');
      // Navigator.pushNamed(context, HomeScreen.id);
    } catch (e) {
      // Handle errors
      showMessage(context, 'Error saving payment: $e');
    }
  }

  String getPaymentMethod() {
    switch (type) {
      case 1:
        return 'Amazon Pay';
      case 2:
        return 'Credit Card';
      case 3:
        return 'PayPal';
      case 4:
        return 'Google Pay';
      default:
        return 'Unknown';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double totalPayment = calculateTotalPayment();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: lightColorScheme.primary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: type == 1
                        ? Border.all(width: 1, color: Color(0xffDB3022))
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 1,
                                groupValue: type,
                                onChanged: handleRadio,
                                activeColor: Color(0xffDB3022),
                              ),
                              Text(
                                'Amazon Pay',
                                style: type == 1
                                    ? TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 15,
                                      )
                                    : TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/images/amazon-pay.jfif',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: type == 2
                        ? Border.all(width: 1, color: Color(0xffDB3022))
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 2,
                                groupValue: type,
                                onChanged: handleRadio,
                                activeColor: Color(0xffDB3022),
                              ),
                              Text(
                                'Credit Card',
                                style: type == 2
                                    ? TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 15,
                                      )
                                    : TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Image.asset(
                            'assets/images/visa.jfif',
                            width: 35,
                          ),
                          SizedBox(width: 8),
                          Image.asset(
                            'assets/images/mastercard.png',
                            width: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: type == 3
                        ? Border.all(width: 1, color: Color(0xffDB3022))
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 3,
                                groupValue: type,
                                onChanged: handleRadio,
                                activeColor: Color(0xffDB3022),
                              ),
                              Text(
                                'PayPal',
                                style: type == 3
                                    ? TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 15,
                                      )
                                    : TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/images/paypal.png',
                            width: 75,
                            height: 75,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    border: type == 4
                        ? Border.all(width: 1, color: Color(0xffDB3022))
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 4,
                                groupValue: type,
                                onChanged: handleRadio,
                                activeColor: Color(0xffDB3022),
                              ),
                              Text(
                                'Google Pay',
                                style: type == 4
                                    ? TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 15,
                                      )
                                    : TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/images/google-pay.webp',
                            width: 60,
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Selected Period',
                //       style: TextStyle(
                //         fontSize: 15,
                //         fontWeight: FontWeight.w500,
                //         color: Colors.grey,
                //       ),
                //     ),
                //     Text(
                //       '${widget.selectPeriod} months',
                //       //   '\$${subTotal.toStringAsFixed(2)}',
                //       style: TextStyle(
                //         fontSize: 15,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 15),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Sub-Total',
                //       style: TextStyle(
                //         fontSize: 15,
                //         fontWeight: FontWeight.w500,
                //         color: Colors.grey,
                //       ),
                //     ),
                //     Text(
                //       '\$${(widget.price * widget.selectPeriod).toStringAsFixed(2)}',
                //       style: TextStyle(
                //         fontSize: 15,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 15),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Rent Fee',
                //       style: TextStyle(
                //         fontSize: 15,
                //         fontWeight: FontWeight.w500,
                //         color: Colors.grey,
                //       ),
                //     ),
                //     Text(
                //       '\$${rentFee.toStringAsFixed(2)}',
                //       style: TextStyle(
                //         fontSize: 15,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ],
                // ),
                // Divider(
                //   height: 30,
                //   color: Colors.black,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Payment',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.price,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 70),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: savePaymentData,
                    child: Text(
                      'Confirm Payment',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
