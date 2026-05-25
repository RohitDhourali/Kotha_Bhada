import 'package:flutter_application_1/models/propertymodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/repository/property_repository.dart';
import 'property_state.dart';
import 'package:flutter_application_1/models/propertyrequestmodel.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit() : super(PropertyInitial());

  final PropertyRepository repository = PropertyRepository();
  Future<void> saveProperty(PropertyRequestModel property) async {
    try {
      emit(PropertyLoading());

      await repository.saveProperty(property);

      emit(PropertyLoaded([])); // Emit loaded state to refresh UI
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  Future<void> fetchProperties() async {
    try {
      emit(PropertyLoading());

      final properties = await repository.fetchProperties();
      if (properties.isEmpty) {
        emit(PropertyEmpty());
      } else {
        emit(PropertyLoaded(properties));
      }
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  Future<void> fetchMyProperties() async {
    try {
      emit(PropertyLoading());

      final properties = await repository.fetchMyProperties();
      if (properties.isEmpty) {
        emit(PropertyEmpty());
      } else {
        emit(PropertyLoaded(properties));
      }
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  Future<void> deleteProperty(String propertyId) async {
    try {
      await repository.deleteProperty(propertyId);
      // Fetch the updated list of properties after deletion
     await fetchMyProperties();
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }
  Future<void> bookProperties() async {
    emit(PropertyLoading());
    
  }
}
