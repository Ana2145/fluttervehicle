import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/vehicle_repository.dart';
import 'presentation/screens/vehicle_list_view.dart';
import 'presentation/cubit/vehicle_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => VehicleRepository(
            apiUrl: 'https://h2ciidlhjj.execute-api.us-east-1.amazonaws.com/Prod', // Reemplaza con tu URL para vehículos
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => VehicleCubit(
          vehicleRepository: RepositoryProvider.of<VehicleRepository>(context),
        ),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const VehicleListView(), // Cambia esto para mostrar tu vista
        ),
      ),
    );
  }
}
