import '../models/logged_in_user.dart';
import '../repositories/user_repository.dart';
import 'auth_service.dart';

/// Combines Firebase Authentication state with the Firestore user profile
/// to produce a single, typed [LoggedInUser].
///
/// This coordinator does not perform navigation, UI work, or role routing.
/// It only answers one question: "who, if anyone, is currently logged in
/// and what does their profile look like?"
class AuthenticationCoordinator {
  const AuthenticationCoordinator({
    required AuthService authService,
    required UserRepository userRepository,
  })  : _authService = authService,
        _userRepository = userRepository;

  final AuthService _authService;
  final UserRepository _userRepository;

  /// Returns the currently authenticated [LoggedInUser], or `null` if:
  /// - no Firebase user is signed in, or
  /// - no matching Firestore user document exists.
  Future<LoggedInUser?> getCurrentUser() async {
    final firebaseUser = _authService.currentUser();
    if (firebaseUser == null) {
      return null;
    }

    final userData = await _userRepository.getUser(firebaseUser.uid);
    if (userData == null) {
      return null;
    }

    // Ensure `uid` reflects the authenticated Firebase user even if the
    // Firestore document omits or duplicates it, since the auth UID is the
    // source of truth for identity.
    final mergedData = {
      ...userData,
      'uid': firebaseUser.uid,
    };

    return LoggedInUser.fromMap(mergedData);
  }
}
