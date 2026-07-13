import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

/// Result returned after a successful [AuthService.verifyOtp] call.
///
/// Kept intentionally minimal — this service does not perform role lookup
/// or profile hydration. That belongs to a higher-level layer.
class AuthResult {
  const AuthResult({required this.user});

  final User user;
}

/// Thin wrapper around [FirebaseAuth] for phone-number authentication.
///
/// Responsibilities are limited to:
/// - requesting an OTP for a phone number
/// - verifying an OTP code
/// - signing out
/// - exposing the current signed-in user
///
/// This service does not know about UI, screens, or navigation, and does
/// not perform role lookup. Those concerns belong to other layers per
/// Engineering Standards (UI and business logic must remain separate).
class AuthService {
  AuthService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  /// Sends an OTP to [phoneNumber].
  ///
  /// [phoneNumber] must be in E.164 format (e.g. "+919876543210").
  ///
  /// [onCodeSent] fires once Firebase has dispatched the SMS, providing the
  /// `verificationId` that must be passed back into [verifyOtp].
  ///
  /// [onAutoVerified] fires on Android devices where Firebase can
  /// auto-detect and verify the SMS without user input. Callers may use
  /// this to skip the manual OTP-entry step.
  ///
  /// [onFailed] fires if Firebase rejects the request (invalid number,
  /// quota exceeded, etc.).
  ///
  /// [onCodeAutoRetrievalTimeout] fires if auto-retrieval times out; the
  /// [verificationId] passed here should still be used for manual
  /// verification.
  Future<void> sendOtp({
    required String phoneNumber,
    required void Function(String verificationId) onCodeSent,
    void Function(AuthResult result)? onAutoVerified,
    void Function(FirebaseAuthException exception)? onFailed,
    void Function(String verificationId)? onCodeAutoRetrievalTimeout,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: timeout,
      verificationCompleted: (PhoneAuthCredential credential) async {
        if (onAutoVerified == null) return;
        final userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        final user = userCredential.user;
        if (user != null) {
          onAutoVerified(AuthResult(user: user));
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        onFailed?.call(exception);
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        onCodeAutoRetrievalTimeout?.call(verificationId);
      },
    );
  }

  /// Verifies [smsCode] against the [verificationId] returned by
  /// [sendOtp]'s `onCodeSent` callback, completing sign-in.
  ///
  /// Throws [FirebaseAuthException] if the code is invalid or expired.
  Future<AuthResult> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-null-after-verification',
        message: 'Sign-in succeeded but no user was returned.',
      );
    }

    return AuthResult(user: user);
  }

  /// Signs the current user out.
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  /// Returns the currently signed-in Firebase [User], or `null` if no user
  /// is signed in.
  User? currentUser() {
    return _firebaseAuth.currentUser;
  }

  /// Emits whenever the auth state changes (sign-in, sign-out, token
  /// refresh with a different user). Exposed for layers that need to
  /// react to auth changes without polling [currentUser].
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}
