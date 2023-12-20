import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../Data/models/watch.dart';
import '../../Data/repository/WatchRepo.dart';

part 'watches_state.dart';

class WatchesCubit extends Cubit<WatchesState> {
  final WatchRepo watchRepo;
   List<Watch> watch=[];

  WatchesCubit(this.watchRepo) : super(WatchesInitial());

  List<Watch> getallWatches() {
    watchRepo.getWatchesList().then((value) {
      emit(WatchesLoaded(value));
      watch = value;
    });

    return watch;
  }
}
