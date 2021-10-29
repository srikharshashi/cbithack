part of 'image_cubit_dart_cubit.dart';

abstract class ImageCubitDartState {}

class ImageCubitDartInitial extends ImageCubitDartState {}

class ImageLoad extends ImageCubitDartState {}

class Imagesuccess extends ImageCubitDartState {
  String photoURL;
  Imagesuccess({
    required this.photoURL,
  });
}

class RegisterinDBLoad extends ImageCubitDartState {}

class RegisterDBComplete extends ImageCubitDartState {
  String name;
  String URl;
  String email;
  RegisterDBComplete({
    required this.name,
    required this.URl,
    required this.email,
  });
}
