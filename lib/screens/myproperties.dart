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
      appBar: AppBar(title: const Text('My Properties')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<PropertyCubit, PropertyState>(
          builder: (context, state) {
            if (state is PropertyLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PropertyLoaded) {
              return ListView.builder(
                itemCount: state.properties.length,
                itemBuilder: (context, index) {
                  final property = state.properties[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      title: Text(
                        property.flatType,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${property.address}\nRent: ${property.rent}',
                        style: const TextStyle(height: 1.4),
                      ),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          SizedBox(
                            width: 72,
                            child: CustomButton(
                              text: 'Edit',
                              backgroundColor: Theme.of(context).colorScheme.secondary,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            width: 72,
                            child: CustomButton(
                              text: 'Delete',
                              backgroundColor: Colors.redAccent,
                              onPressed: () async {
                                final bool? confirmDelete = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Delete Property'),
                                      content: const Text(
                                        'Are you sure you want to delete this property?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, true),
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirmDelete == true) {
                                  context.read<PropertyCubit>().deleteProperty(property.id);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            if (state is PropertyEmpty) {
              return const Center(child: Text('No properties found'));
            }

            if (state is PropertyError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text('Press button to load properties'));
          },
        ),
      ),
    );
  }
}
