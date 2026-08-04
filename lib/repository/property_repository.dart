import 'package:flutter_application_1/services/property_services.dart';
import 'package:flutter_application_1/models/propertymodel.dart';
import 'package:flutter_application_1/models/propertyrequestmodel.dart';

class PropertyRepository {
  final PropertyService _service = PropertyService();

  Future<void> saveProperty(PropertyRequestModel property) async {
    return await _service.saveProperty(property);
  }

  Future<List<PropertyModel>> fetchProperties() async {
    return await _service.fetchProperties();
  }

  Future<List<PropertyModel>> fetchMyProperties() async {
    return await _service.fetchMyProperties();
  }

  Future<void> deleteProperty(String propertyId) async {
    await _service.deleteProperty(propertyId);
  }
}
