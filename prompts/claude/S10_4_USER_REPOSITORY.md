TASK S10.4 – User Repository

Objective

Create the Firestore User Repository.

Modify up to 3 files.

Create

lib/features/authentication/repositories/user_repository.dart

Responsibilities

- Read user document from Firestore.
- Get user by Firebase UID.
- Return null if user does not exist.
- Do not perform authentication.
- Do not perform role routing.
- Do not modify UI.

Assume collection name:

users

The repository should expose:

Future<Map<String, dynamic>?> getUser(String uid)

Use clean repository architecture.

Validation

Run flutter analyze.

Report

- Files changed
- Validation
- Time taken
- Known limitations