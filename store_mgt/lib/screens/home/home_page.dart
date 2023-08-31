import 'package:flutter/material.dart';
import 'package:store_mgt/core/cont/margins.dart';
import 'package:store_mgt/screens/add_prodcut/add_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add items'),
      ),
      body:SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                 GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AddProduct()));
                  },
                  // should open to allown client book an appointmetn
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    width: 180,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(200, 115, 64, 255),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 4.0,
                              spreadRadius: 1.1)
                        ]),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.local_hospital_rounded,
                          size: 50,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          'Book an appointment',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            YMargin(y: 10),
            
          ],
        ),
      ))
    );
  }
}