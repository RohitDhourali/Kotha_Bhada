import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/propertymodel.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/bookingcubit.dart';
class PropertyDetailPage extends StatelessWidget {
  final PropertyModel property;

  const PropertyDetailPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(property.flatType)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Type: ${property.flatType}"),
            Text("Address: ${property.address}"),
            Text("Rent: ${property.rent}"),
            Text("Owner: ${property.ownername}"),
            Text("Contact: ${property.ownercontact}"),
            Text("Description: ${property.description}"),
            SizedBox(height: 16),
            BlocBuilder<BookingCubit, Text>(
  builder: (context, bookingText) {
    return CustomButton(
      text: bookingText.data ?? "Book Now",
      onPressed: () {
        context.read<BookingCubit>().book();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Booked Successfully!")),
              );
            },
    );
  },
)
          ],
        ),
      ),
    );
  }
}