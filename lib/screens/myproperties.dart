import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/cubit/property_details_cubit.dart';
import 'package:flutter_application_1/cubit/property_state.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';

class Myproperties extends StatefulWidget {
  const Myproperties({super.key});

  @override
  State<Myproperties> createState() => _MypropertiesState();
}

class _MypropertiesState extends State<Myproperties> {
  @override
  void initState() {
    super.initState();
    context.read<PropertyCubit>().fetchMyProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Properties")),

      body: Column(
        children: [
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
                          trailing: SizedBox(
                            width: 180,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Edit Button
                                SizedBox(
                                  width: 80,
                                  child: CustomButton(
                                    text: 'Edit',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    onPressed: () {
                                      // Navigate to edit screen
                                    },
                                  ),
                                ),

                                SizedBox(width: 10),

                                // Delete Button
                                SizedBox(
                                  width: 90,
                                  child: CustomButton(
                                    text: 'Delete',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    onPressed: () async {
                                      final bool?
                                      confirmDelete = await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Delete Property"),
                                            content: Text(
                                              "Are you sure you want to delete this property?",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, false);
                                                },
                                                child: Text("Cancel"),
                                              ),

                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, true);
                                                },
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      if (confirmDelete == true) {
                                        context
                                            .read<PropertyCubit>()
                                            .deleteProperty(property.id);

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Property deleted successfully",
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                if (state is PropertyDeleted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Property deleted successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                if (state is PropertyEmpty) {
                  return Center(child: Text("No properties found"));
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
