part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final SellerModel seller;

  const ProfileLoaded(this.seller);

  List<Object> get props => [seller];
}

class ProfileImageUploading extends ProfileState {}

class ProfileImageUploaded extends ProfileState {}

class ProfileImageUploadError extends ProfileState {}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {}

class ProfileUpdateError extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  List<Object> get props => [message];
}
