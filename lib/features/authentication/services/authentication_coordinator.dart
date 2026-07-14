import '../models/logged_in_user.dart';
import '../repositories/user_repository.dart';
import 'auth_service.dart';

/// Combines Firebase Authentication state with the Firestore user profile
/// to produce a single, typed [LoggedInUser].
class AuthenticationCoordinator {
  const AuthenticationCoordinator({
    required AuthService authService,
    required UserRepository userRepository,
  })  : _authService = authService,
        _userRepository = userRepository;

  final AuthService _authService;
  final UserRepository _userRepository;

  Future<LoggedInUser?> getCurrentUser() async {
    final firebaseUser = _authService.currentUser();

    if (firebaseUser == null) {
      return null;
    }

    final userData =
    await _userRepository.getUser(firebaseUser.uid);

    if (userData == null) {
      return null;
    }

    final mergedData = {
      ...userData,
      'uid': firebaseUser.uid,
    };

    return LoggedInUser.fromMap(mergedData);
  }
}