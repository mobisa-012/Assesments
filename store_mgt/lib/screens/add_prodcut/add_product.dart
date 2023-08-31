import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_mgt/core/cont/margins.dart';
import 'package:store_mgt/core/data/item_data.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final typeController = TextEditingController();
  final brandController = TextEditingController();
  final supplierNameControllr = TextEditingController();
  final quantityController = TextEditingController();
  final wareHouseController =  TextEditingController();
  final dateController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    typeController.dispose();
    brandController.dispose();
    supplierNameControllr.dispose();
    quantityController.dispose();
    wareHouseController.dispose();
    dateController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Product Details'),
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller:  nameController,
                  decoration: InputDecoration(
                      labelText: 'Enter product name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                YMargin(y: 8),
                TextFormField(
                  controller:  typeController,
                  decoration: InputDecoration(
                      labelText: 'Enter product name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                YMargin(y: 8),
                TextFormField(
                  controller:  brandController,
                  decoration: InputDecoration(
                      labelText: 'Enter product name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                YMargin(y: 8),
                TextFormField(
                  controller:  supplierNameControllr,
                  decoration: InputDecoration(
                      labelText: 'Enter product name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                YMargin(y: 8),
                TextFormField(
                  controller:  descriptionController,
                  decoration: InputDecoration(
                      labelText: 'Enter product name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                YMargin(y: 8),
                TextFormField(
                  controller:  quantityController,
                  decoration: InputDecoration(
                      labelText: 'Enter product name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                YMargin(y: 8),
                TextFormField(
                  controller:  priceController,
                  decoration: InputDecoration(
                      labelText: 'Enter product name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                YMargin(y: 8),
                TextFormField(
                  controller:  wareHouseController,
                  decoration: InputDecoration(
                      labelText: 'Enter product name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                YMargin(y: 8),
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: const Icon(Icons.calendar_month_outlined),
                      labelText: 'Date'),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2027));
                    if (pickedDate != null) {
                      setState(() {
                        dateController.text =
                            DateFormat('yyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter date';
                    }
                    return null;
                  },
                ),                
                YMargin(y: 15),
                ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()) {
                      ItemsData itemsData = ItemsData(
                        name: nameController.text, 
                        price: priceController.text, 
                        brand: brandController.text, 
                        date: dateController.text, 
                        description: descriptionController.text, 
                        quantity: quantityController.text, 
                        supplier: supplierNameControllr.text, 
                        type: typeController.text, 
                        wareHouse: wareHouseController.text
                        );
                        FirebaseFirestore.instance.collection('store_mgt')
                        .add(itemsData.toJson())
                        .then((value) {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Product details'),
                                content: const Text(
                                  'Product details added successfully',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.deepPurpleAccent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Ok',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ))
                                ],
                              );
                            },
                            );
                        }).catchError((e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Product details'),
                                content: Text(
                                  'Failed to add Product details $e.\n Contact support.',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.deepPurpleAccent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Ok'))
                                ],
                              );
                            });
                        });
                    }
                  },
                   style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: Colors.deepPurpleAccent,
                      minimumSize: Size(MediaQuery.of(context).size.width, 55),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text('Add Product',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}