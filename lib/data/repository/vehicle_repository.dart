import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vehicle_model.dart';

class VehicleRepository {
  final String apiUrl;

  VehicleRepository({required this.apiUrl});

  Future<List<VehicleModel>> getAllVehicles() async {
    final response = await http.get(
      Uri.parse('$apiUrl/vehicles'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<VehicleModel>.from(l.map((model) => VehicleModel.fromJson(model)));
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  Future<void> createVehicle(VehicleModel vehicle) async {
    final response = await http.post(
      Uri.parse('$apiUrl/vehicle'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(vehicle.toJson()..remove('id')),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create vehicle');
    }
  }

  Future<void> updateVehicle(VehicleModel vehicle) async {
    final response = await http.put(
      Uri.parse('$apiUrl/vehicle/${vehicle.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(vehicle.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update vehicle');
    }
  }

  Future<void> deleteVehicle(String id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/vehicle/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete vehicle');
    }
  }
}
