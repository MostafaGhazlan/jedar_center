part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {}
class UpdateSwitch extends SearchState {}
class UpdateSwitchFilter extends SearchState {}
class UpdateRange extends SearchState {}
class UpdateCheckState extends SearchState {
  final List<String> selectedIds;
  UpdateCheckState(this.selectedIds);
}


class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
