import 'package:flutter/material.dart';
import 'package:sfit/pages/FeedbackPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class PaymentPage extends StatefulWidget {
  final String coachName;

  const PaymentPage({super.key, required this.coachName});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool? rememberVisa = false;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Coach'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Coach: ${widget.coachName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            InkWell(
              onTap: () async {
                LatLng? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationPicker(),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedLocation = result;
                  });
                }
              },
              child: Container(
                height: 180,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey),
                  image: DecorationImage(
                    image: NetworkImage(
                      selectedLocation == null
                          ? 'https://images2.thanhnien.vn/528068263637045248/2024/4/20/google-maps-2-1713580278798-1713580279367384208041.jpg'
                          : 'https://storage0.dms.mpinteractiv.ro/media/401/341/5531/21708679/1/google-maps-2048x1149.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      selectedLocation == null
                          ? 'Pick a Location'
                          : 'Location: ${selectedLocation!.latitude}, ${selectedLocation!.longitude}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Session Subtotal',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$50',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24), // Increased space below "Session Subtotal"
            CheckboxListTile(
              title: const Row(
                children: [
                  Icon(Icons.credit_card),
                  SizedBox(width: 8),
                  Text('Visa'),
                ],
              ),
              value: rememberVisa,
              onChanged: (value) {
                setState(() {
                  rememberVisa = value;
                  if (value == true) {
                    _showVisaPaymentDialog(context);
                  }
                });
              },
            ),
            CheckboxListTile(
              title: const Row(
                children: [
                  Icon(Icons.money),
                  SizedBox(width: 8),
                  Text('Cash'),
                ],
              ),
              value: !rememberVisa!,
              onChanged: (value) {
                setState(() {
                  rememberVisa = !value!;
                });
              },
            ),
            ElevatedButton(
  onPressed: () {
    if (rememberVisa!) {
      if (formKey.currentState != null && formKey.currentState!.validate()) {
        // Show Visa payment dialog
        _showVisaPaymentDialog(context);
      }
    } else {
      // For Cash payment, directly store transaction details
      _storeTransactionDetails();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FeedbackPage(coachName: widget.coachName),
        ),
      );
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.lightBlue,
  ),
  child: const Padding(
    padding: EdgeInsets.all(16.0),
    child: Text(
      'Pay Now',
      style: TextStyle(
        fontSize: 20,
      ),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
Future<void> _showVisaPaymentDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter Credit Card Information'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Credit Card Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter credit card number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: expDateController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(labelText: 'Exp Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiration date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: cvvController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'CVV'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CVV';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState != null && formKey.currentState!.validate()) {
                Navigator.of(context).pop(); // Close the dialog
                _storeTransactionDetails(); // Store transaction details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackPage(coachName: widget.coachName),
                  ),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );
}


void _storeTransactionDetails() {
  String userEmail = FirebaseAuth.instance.currentUser!.email!;
  String? username = FirebaseAuth.instance.currentUser!.displayName;
  String currentDate = DateTime.now().toString();
  String transactionId = UniqueKey().toString();
  String coachName = widget.coachName;
  String sessionSubtotal = '\$50'; // Update this value accordingly
  
  String paymentOption = rememberVisa! ? 'Visa' : 'Cash';
  String maskedCardNumber = rememberVisa!
      ? '**** **** **** ${cardNumberController.text.substring(cardNumberController.text.length - 4)}'
      : 'N/A';
  
  DatabaseReference paymentRef = FirebaseDatabase.instance.reference().child('Payments').push();
  paymentRef.set({
    'userEmail': userEmail,
    'username': username,
    'currentDate': currentDate,
    'transactionId': transactionId,
    'coachName': coachName,
    'sessionSubtotal': sessionSubtotal,
    'paymentOption': paymentOption,
    'creditCardNumber': maskedCardNumber,
  });
}


}

class LocationPicker extends StatelessWidget {
  const LocationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
      ),
      body: FlutterLocationPicker(
        initZoom: 16,
        minZoomLevel: 5,
        maxZoomLevel: 18,
        trackMyPosition: true,
        searchBarBackgroundColor: Colors.white,
        onPicked: (pickedData) {
          Navigator.pop(context, LatLng(pickedData.latLong.latitude, pickedData.latLong.longitude));
        },
      ),
    );
  }
}

