String getErrorString(String code) {
  switch (code) {
    case 'ERROR_WEAK_PASSWORD':
      return 'weak password.';
    case 'ERROR_INVALID_EMAIL':
      return 'invalid pasword.';
    case 'ERROR_EMAIL_ALREADY_IN_USE':
      return 'already user.';
    case 'ERROR_INVALID_CREDENTIAL':
      return 'invalid credential.';
    case 'ERROR_WRONG_PASSWORD':
      return 'wronng password.';
    case 'ERROR_USER_NOT_FOUND':
      return 'Nuser not found.';
    case 'ERROR_USER_DISABLED':
      return 'user disabled.';
    case 'ERROR_TOO_MANY_REQUESTS':
      return 'too many rwquest.';
    case 'ERROR_OPERATION_NOT_ALLOWED':
      return 'not allowed.';

    default:
      return 'unknown error.';
  }
}
