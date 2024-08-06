import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/vehicle_cubit.dart';
import '../../data/models/vehicle_model.dart';

class CreateVehicleScreen extends StatelessWidget {
  const CreateVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController marcaController = TextEditingController();
    final TextEditingController modeloController = TextEditingController();
    final TextEditingController autonomiaController = TextEditingController();
    final TextEditingController camaraController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: marcaController,
              decoration: const InputDecoration(labelText: 'Marca'),
            ),
            TextField(
              controller: modeloController,
              decoration: const InputDecoration(labelText: 'Modelo'),
            ),
            TextField(
              controller: autonomiaController,
              decoration: const InputDecoration(labelText: 'Autonomía'),
            ),
            TextField(
              controller: camaraController,
              decoration: const InputDecoration(labelText: 'Cámara'),
            ),
            ElevatedButton(
              onPressed: () {
                final vehicle = VehicleModel(
                  marca: marcaController.text,
                  modelo: modeloController.text,
                  autonomia: autonomiaController.text,
                  camara: camaraController.text,
                );
                BlocProvider.of<VehicleCubit>(context).createVehicle(vehicle);
                Navigator.pop(context);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
