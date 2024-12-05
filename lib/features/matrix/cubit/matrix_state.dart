part of 'matrix_cubit.dart';

@immutable
sealed class MatrixState {}

final class MatrixInitial extends MatrixState {}

class FavoritLoading extends MatrixState {}

class AddCartLoading extends MatrixState {}

class ChangeConterState extends MatrixState {}

class UpdateItemState extends MatrixState {}

class MatrixError extends MatrixState {}
class UpdateMatrixDetailsState extends MatrixState {}
