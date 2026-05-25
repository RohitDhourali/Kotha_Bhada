import 'package:flutter_application_1/models/propertymodel.dart';
abstract class PropertyState {}
class PropertyInitial extends PropertyState {}
class PropertyLoading extends PropertyState {}
class PropertyLoaded extends PropertyState {

  final List<PropertyModel> properties;

  PropertyLoaded(this.properties);

}
class PropertyError extends PropertyState {
  final String message;

  PropertyError(this.message);
}
class PropertyEmpty extends PropertyState {}
class PropertyDeleted extends PropertyState {
    final List<PropertyModel> properties;

  PropertyDeleted(this.properties);
}