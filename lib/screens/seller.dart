

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/property_details_cubit.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'myproperties.dart';
import 'package:flutter_application_1/models/propertymodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/services/property_services.dart';
import 'package:flutter_application_1/models/propertyrequestmodel.dart';

class Seller extends StatefulWidget {
  const Seller({super.key});

  @override
  State<Seller> createState() => _SellerState();
}

class _SellerState extends State<Seller> {
  final TextEditingController _flatTypeController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerContactController = TextEditingController();


  void save() async {
    final property = PropertyRequestModel(
      flatType: _flatTypeController.text,
      rent: _rentController.text,
      address: _addressController.text,
      description: _descriptionController.text,
      ownername: _ownerNameController.text,
      ownercontact: _ownerContactController.text,
    
    
    );
    await context.read<PropertyCubit>().saveProperty(
      property
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Property saved successfully"), backgroundColor: Colors.green),
    );
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("Add Property"),
        centerTitle: true,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
           

            // Header
            Text(
              "List Your Property",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 25),

            // Form Card
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                children: [
                  // Flat Type
                  TextField(
                    controller: _flatTypeController,
                    decoration: InputDecoration(
                      labelText: "Flat Type",
                      prefixIcon: Icon(Icons.apartment),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Rent
                  TextField(
                    controller: _rentController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Rent",
                      prefixIcon: Icon(Icons.currency_rupee),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Address
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: "Address",
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Description
                  TextField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Description",
                      alignLabelWithHint: true,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(bottom: 50),
                        child: Icon(Icons.description),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Owner Name
                  TextField(
                    controller: _ownerNameController,
                    decoration: InputDecoration(
                      labelText: "Owner Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Owner Contact
                  TextField(
                    controller: _ownerContactController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Owner Contact",
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Submit Button
            CustomButton(text: 'Submit Property', onPressed: save),

            SizedBox(height: 20),
            CustomButton(
              text: 'See your properties',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Myproperties()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
