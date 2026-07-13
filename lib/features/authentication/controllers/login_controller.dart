import '../services/auth_service.dart';

class LoginController {
  LoginController({
    AuthService? authService,
  }) : _authService = authService ?? AuthService();

  final AuthService _authService;

  Future<void> sendOtp({
    required String phoneNumber,
    required void Function(String verificationId) onCodeSent,
    required void Function(String message) onError,
  }) async {
    try {
      await _authService.sendOtp(
        phoneNumber: phoneNumber,
        onCodeSent: onCodeSent,
        onFailed: (exception) {
          onError(exception.message ?? 'Unable to send OTP');
        },
      );
    } catch (e) {
      onError(e.toString());
    }
  }
}