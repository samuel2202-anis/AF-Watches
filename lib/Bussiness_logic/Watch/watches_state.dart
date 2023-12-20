
part of 'watches_cubit.dart';


@immutable
abstract class WatchesState {}

class WatchesInitial extends WatchesState {}

class WatchesLoaded extends WatchesState{
  final List<Watch> watches;

  WatchesLoaded(this.watches);
}