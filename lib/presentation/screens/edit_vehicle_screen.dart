import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/vehicle_cubit.dart';
import '../../data/models/vehicle_model.dart';

class EditVehicleScreen extends StatelessWidget {
  final VehicleModel vehicle;

  const EditVehicleScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final TextEditingController marcaController = TextEditingController(text: vehicle.marca);
    final TextEditingController modeloController = TextEditingController(text: vehicle.modelo);
    final TextEditingController autonomiaController = TextEditingController(text: vehicle.autonomia);
    final TextEditingController camaraController = TextEditingController(text: vehicle.camara);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Vehicle'),
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
                final updatedVehicle = VehicleModel(
                  id: vehicle.id,
                  marca: marcaController.text,
                  modelo: modeloController.text,
                  autonomia: autonomiaController.text,
                  camara: camaraController.text,
                );
                BlocProvider.of<VehicleCubit>(context).updateVehicle(updatedVehicle);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
