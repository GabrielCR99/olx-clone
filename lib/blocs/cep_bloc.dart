import 'package:rxdart/rxdart.dart';
import 'package:xlo/api/api_postal_code.dart';
import 'package:xlo/models/address.dart';
import 'package:xlo/repositories/api_response.dart';

enum CepFieldState { INITIALIZING, INCOMPLETE, INVALID, VALID }

class CepBlocState {
  CepBlocState({this.cepFieldState, this.address, this.cep});

  CepFieldState cepFieldState;
  String cep;
  Address address;
}

class CepBloc {
  CepBloc() {
    onChanged('');
  }

  final BehaviorSubject<CepBlocState> _cepController =
      BehaviorSubject<CepBlocState>();

  Stream<CepBlocState> get outCep => _cepController.stream;

  Future<void> searchCep(String cep) async {
    final ApiResponse apiResponse = await getAddressFromAPI(cep);

    if (apiResponse.isSuccess) {
      _cepController.add(CepBlocState(
          cepFieldState: CepFieldState.VALID,
          cep: cep,
          address: apiResponse.result));
    } else {
      _cepController
          .add(CepBlocState(cepFieldState: CepFieldState.INVALID, cep: cep));
    }
  }

  void onChanged(String cep) {
    cep = cep.trim().replaceAll('-', '').replaceAll('.', '');
    if (cep.isEmpty || cep.length < 8) {
      _cepController
          .add(CepBlocState(cepFieldState: CepFieldState.INCOMPLETE, cep: cep));
    } else {
      searchCep(cep);
    }
  }

  void dispose() {
    _cepController.close();
  }
}
