import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/property_details_cubit.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'myproperties.dart';
import 'package:flutter_application_1/models/propertyrequestmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    try {
      await context.read<PropertyCubit>().saveProperty(property);
      _flatTypeController.clear();
      _rentController.clear();
      _addressController.clear();
      _descriptionController.clear();
      _ownerNameController.clear();
      _ownerContactController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Property saved successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save property: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _flatTypeController.dispose();
    _rentController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _ownerNameController.dispose();
    _ownerContactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Your Property'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Share your space with ease.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildTextField(
                    controller: _flatTypeController,
                    label: 'Flat Type',
                    icon: Icons.apartment_outlined,
                  ),
                  const SizedBox(height: 18),
                  _buildTextField(
                    controller: _rentController,
                    label: 'Rent',
                    icon: Icons.currency_rupee,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 18),
                  _buildTextField(
                    controller: _addressController,
                    label: 'Address',
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 42),
                        child: Icon(Icons.description_outlined),
                      ),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _buildTextField(
                    controller: _ownerNameController,
                    label: 'Owner Name',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 18),
                  _buildTextField(
                    controller: _ownerContactController,
                    label: 'Owner Contact',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(text: 'Submit Property', onPressed: save),
            const SizedBox(height: 16),
            CustomButton(
              text: 'See your properties',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Myproperties()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}
