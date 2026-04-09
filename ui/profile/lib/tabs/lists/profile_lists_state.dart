sealed class ProfileListsState {
  const ProfileListsState();
}

class ProfileListsLoading extends ProfileListsState {
  const ProfileListsLoading();
}

class ProfileListsSuccess extends ProfileListsState {
  const ProfileListsSuccess();
}

class ProfileListsError extends ProfileListsState {
  final String message;

  const ProfileListsError(this.message);
}
