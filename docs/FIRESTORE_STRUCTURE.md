# Firestore Structure

## Collections

users/

children/

classrooms/

attendance/

flow_events/

memories/

teacher_notes/

parent_story/

---

## users

Document ID = Firebase Auth UID

Fields

- role (admin, teacher, parent)
- name
- phone
- email
- active

---

## children

Fields

- firstName
- lastName
- dob
- classroomId
- parentIds
- medicalNotes
- allergies
- active

---

## classrooms

Fields

- name
- ageGroup
- teacherIds
- childIds

---

## attendance

Fields

- childId
- date
- arrivalTime
- pickupTime
- status

---

## flow_events

Fields

- childId
- type
- timestamp
- completed
- exception

---

## memories

Fields

- childId
- imageUrl
- audience
- timestamp

---

## teacher_notes

Fields

- childId
- teacherId
- note
- timestamp

---

## parent_story

Fields

- childId
- emoji
- title
- description
- timestamp