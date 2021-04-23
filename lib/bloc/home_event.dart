part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ShowDataTableEvent extends HomeEvent {}

class ShowChartsEvent extends HomeEvent {
  final bool showBarChart;

  ShowChartsEvent({@required this.showBarChart});
}
