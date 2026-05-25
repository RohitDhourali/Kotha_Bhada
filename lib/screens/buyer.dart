import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/property_details_cubit.dart';
import '../cubit/property_state.dart';
import 'propertydetails.dart';

class BuyerScreen extends StatefulWidget {
  @override
  _BuyerScreenState createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
 
  @override
void initState() {
  super.initState();
  context.read<PropertyCubit>().fetchProperties();
}@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buyer Screen')),
      body: Column(
        children: [
          Text('Click on property to see the full details'),
          Expanded(
            child: BlocBuilder<PropertyCubit, PropertyState>(
              builder: (context, state) {
                if (state is PropertyLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is PropertyLoaded) {
                  return ListView.builder(
                    itemCount: state.properties.length,

                    itemBuilder: (context, index) {
                      final property = state.properties[index];

                      return Card(
                        child: ListTile(
                          title: Text(property.flatType),

                          subtitle: Text(
                            "${property.address}\nRent: ${property.rent}",
                          ),

                          trailing: Text(property.ownername),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PropertyDetailPage(property: property),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }

                if (state is PropertyError) {
                  return Center(child: Text(state.message));
                }

                return Center(child: Text("Press button to load properties"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
