import 'package:dashboard/main.dart';
import 'package:dashboard/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:dashboard/presentation/cubit/property_cubit/property_state.dart';
import 'package:dashboard/presentation/pages/create_new_property.dart';
import 'package:dashboard/presentation/pages/login_page.dart';
import 'package:dashboard/presentation/pages/update_property_page.dart';
import 'package:dashboard/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => AdminHomePageState();
}

class AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    BlocProvider.of<PropertyCubit>(context).fetchProperties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Manager'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPropertyPage(),
                  ));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0), // Adding padding
              child: Icon(Icons.add_box_outlined),
            ),
          ),
          GestureDetector(
            onTap: () {
              localDb.remove('jwtKey');
              localDb.remove('userRole');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0), // Adding padding
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: BlocBuilder<PropertyCubit, PropertyState>(
        builder: (context, state) {
          if (state is PropertyDeleteFailure) {
            context.read<PropertyCubit>().fetchProperties();
            Utils.showSnackbar('Unable to delete Property');
          }
          if (state is PropertyLoading) {
            // Show a loading spinner while properties are being fetched
            return const Center(child: CircularProgressIndicator());
          } else if (state is PropertyFailure) {
            // Show an error message if there was a failure
            return Center(child: Text(state.errorMessage));
          } else if (state is PropertySuccess) {
            // Show the ListView when properties are successfully loaded
            return ListView.builder(
              itemCount: state.properties.length,
              itemBuilder: (context, index) {
                final property = state.properties[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.propertyName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Location: ${property.location}'),
                                  Text('Size: ${property.sizeSqFt} SqFt'),
                                  Text('Type: ${property.propertyType}'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Bedrooms: ${property.noOfBedrooms}'),
                                  Text('Bathrooms: ${property.noOfBathrooms}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'AED ${property.price}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdatePropertyPage(
                                                  property: property),
                                        ));
                                  },
                                  tooltip: 'Edit',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Deletion'),
                                          content: Text(
                                              'Are you sure you want to delete ${property.propertyName}?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Delete'),
                                              onPressed: () {
                                                BlocProvider.of<PropertyCubit>(
                                                        context)
                                                    .deleteProperty(
                                                        property.id);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  tooltip: 'Delete',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            // Handle any other state, e.g., initial state where there are no properties loaded yet
            return const Center(child: Text('No properties found'));
          }
        },
      ),
    );
  }
}
