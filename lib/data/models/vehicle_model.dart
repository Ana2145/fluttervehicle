class VehicleModel {
  final String? id;
  final String marca;
  final String modelo;
  final String autonomia;
  final String camara;

  // Constructor del objeto
  VehicleModel({
    this.id,
    required this.marca,
    required this.modelo,
    required this.autonomia,
    required this.camara,
  });

  // Método para convertir el objeto JSON a un VehicleModel
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      marca: json['marca'],
      modelo: json['modelo'],
      autonomia: json['autonomia'],
      camara: json['camara'],
    );
  }

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'autonomia': autonomia,
      'camara': camara,
    };
  }
}
