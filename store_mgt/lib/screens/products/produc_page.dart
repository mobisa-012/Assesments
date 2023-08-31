// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All products'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('store_mgt').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if(snapshot.hasError){
                return Text('Error: ${snapshot.error}');
              }
              final documents = snapshot.data!.docs;
              if(documents.isEmpty) {
                return const Center(
                  child: Text(
                    'No products added yet',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount:  documents.length,
                itemBuilder: (context, index) {
                  final document = documents[index];
                  final name = document['name'];
                  final description = document['description'];
                  final date = document['date'];
                  return ListTile(
                    title: Text('$name'),
                    subtitle: Column(
                      children: [
                        Text('$description'),
                        Text('$date')
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showDeleteConfirmationDialog(documents[index].id);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
                );
            },
          ),
        ),
      ),
    );
  }
  Future<void> showDeleteConfirmationDialog(String documentId) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await deleteProduct(documentId);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
  }
  // Inside your _AddProductState class

// Function to delete a product document
Future<void> deleteProduct(String documentId) async {
  try {
    await FirebaseFirestore.instance.collection('store_mgt').doc(documentId).delete();
    print('Product deleted successfully');
    // You might want to update the 'products' list after deleting;
  } catch (e) {
    print('Error deleting product: $e');
  }
}

}