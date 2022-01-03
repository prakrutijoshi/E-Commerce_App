part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel users;

  const ProfileLoaded(this.users);

  List<Object> get props => [users];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  List<Object> get props => [message];
}

//Image states
class ImageUploading extends ProfileState {}

class ImageUploaded extends ProfileState {}

class ImageUploadError extends ProfileState {
  final String message;

  ImageUploadError({required this.message});

  List<Object> get props => [message];
}
