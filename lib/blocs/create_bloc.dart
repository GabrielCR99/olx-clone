import 'package:rxdart/rxdart.dart';
import 'package:xlo/models/ad.dart';

enum CreateState { IDLE, LOADING, DONE }

class CreateBloc {
  final BehaviorSubject<CreateState> _stateController =
      BehaviorSubject<CreateState>.seeded(CreateState.IDLE);

  Stream get outState => _stateController.stream;

  Future<bool> saveAd(Ad ad) async {
    _stateController.add(CreateState.LOADING);

    await Future.delayed(Duration(seconds: 3));

    _stateController.add(CreateState.DONE);
    return true;
  }

  void dispose() {
    _stateController.close();
  }
}
