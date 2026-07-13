# Users Collection

Collection

users

Document ID

Firebase Authentication UID

---

## Common Fields

uid

name

mobile

email

role

active

createdAt

lastLogin

---

## Parent

linkedChildren

Example

[
  "child_001",
  "child_002"
]

---

## Teacher

assignedClassrooms

Example

[
  "nursery_a",
  "kg1_b"
]

designation

---

## Admin

permissions

Example

[
  "all"
]

---

## Rules

One mobile number = One Firebase account.

Each account has one primary role.

Parents can access only linked children.

Teachers can access only assigned classrooms.

Admins have full access.