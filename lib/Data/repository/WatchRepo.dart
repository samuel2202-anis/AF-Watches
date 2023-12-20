import 'package:af_watches2/Data/models/watch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WatchRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Watch>> getWatchesList() async {
    final watchesListData = await _firestore.collection('Watches').orderBy('id',descending: true).get();
    final watchesList = watchesListData.docs
        .map((watchesData) => Watch.fromMap(watchesData))
        .toList();
    return watchesList;
  }
}
