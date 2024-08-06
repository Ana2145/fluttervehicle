import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/vehicle_repository.dart';
import '../cubit/vehicle_cubit.dart';
import '../cubit/vehicle_state.dart';
import '../../data/models/vehicle_model.dart';
import 'create_vehicle_screen.dart';
import 'edit_vehicle_screen.dart';

class VehicleListView extends StatelessWidget {
  const VehicleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle List'),
      ),
      body: BlocProvider(
        create: (context) => VehicleCubit(
          vehicleRepository: RepositoryProvider.of<VehicleRepository>(context),
        ),
        child: const VehicleListScreen(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateVehicleScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleCubit = BlocProvider.of<VehicleCubit>(context);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            vehicleCubit.fetchAllVehicles();
          },
          child: const Text('Fetch Vehicles'),
        ),
        Expanded(
          child: BlocBuilder<VehicleCubit, VehicleState>(
            builder: (context, state) {
              if (state is VehicleLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is VehicleSuccess) {
                final vehicles = state.vehicles;
                return ListView.builder(
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = vehicles[index];
                    return ListTile(
                      title: Text(vehicle.marca),
                      subtitle: Text(vehicle.modelo),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditVehicleScreen(vehicle: vehicle)),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              vehicleCubit.deleteVehicle(vehicle.id!);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is VehicleError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(child: Text('Press the button to fetch vehicles'));
            },
          ),
        ),
      ],
    );
  }
}
