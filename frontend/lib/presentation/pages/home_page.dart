import 'package:dashboard/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:dashboard/presentation/cubit/property_cubit/property_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Manager'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0), // Adding padding
            child: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: BlocBuilder<PropertyCubit, PropertyState>(
        builder: (context, state) {
          if (state is PropertyLoading) {
            // Show a loading spinner while properties are being fetched
            return Center(child: CircularProgressIndicator());
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
                  child: ListTile(
                    title: Text(property.propertyName ?? 'Unnamed Property'),
                    subtitle: Text(
                        '${property.location ?? 'Unknown Location'} - ${property.sizeSqFt ?? 0} SqFt'),
                    trailing: Text('\$${property.price ?? 0}'),
                  ),
                );
              },
            );
          } else {
            // Handle any other state, e.g., initial state where there are no properties loaded yet
            return Center(child: Text('No properties found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PropertyCubit>().fetchProperties(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
