part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class DataTableState extends HomeState {
  final List<Map<String, dynamic>> listaDatos;

  DataTableState({@required this.listaDatos});
}

class PieChartsState extends HomeState {
  final List<Map<String, dynamic>> listaDatos;

  PieChartsState({@required this.listaDatos});
}

class BarChartsState extends HomeState {
  final List<Map<String, dynamic>> listaDatos;

  BarChartsState({@required this.listaDatos});
}
