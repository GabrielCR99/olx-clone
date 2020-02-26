enum LoginState { IDLE, LOADING, LOADING_FACEBOOK, ERROR, DONE }

class LoginBlocState {
  LoginState state;
  String errorMessage;

  LoginBlocState(this.state, {this.errorMessage});
}
