import 'package:calculator_app/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  static const String id = '/history_screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: kTransparentColor,
        appBar: AppBar(
          backgroundColor: kTransparentColor,
          title: const Text('Calculation History'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('result').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final calculations = snapshot.data!.docs;
            if (calculations.isEmpty) {
              return const Center(
                child: Text('No calculations found.'),
              );
            }

            // Reverse the order of calculations
            calculations
                .sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

            return ListView.builder(
              itemCount: calculations.length,
              itemBuilder: (context, index) {
                final calculation = calculations[index];
                final userInput = calculation['user_input'];
                final result = calculation['result'];
                return ListTile(
                  title: Text('Input: $userInput'),
                  subtitle: Text('Result: $result'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
