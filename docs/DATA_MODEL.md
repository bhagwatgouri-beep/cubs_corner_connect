# Data Model

## Core Entities

### Child

- id
- firstName
- lastName
- dateOfBirth
- classroomId
- parentIds
- medicalNotes
- allergies
- active

---

### Parent

- id
- name
- phone
- email
- children

---

### Teacher

- id
- name
- phone
- classroomIds
- active

---

### Classroom

- id
- name
- ageGroup
- teacherIds
- childIds

---

### Attendance

- id
- childId
- date
- status
- arrivalTime
- pickupTime

---

### FlowEvent

- id
- childId
- type
- timestamp
- completed
- exceptions

---

### Memory

- id
- childId
- imageUrl
- audience
- timestamp

---

### TeacherNote

- id
- childId
- teacherId
- note
- timestamp

---

### ParentStoryItem

- id
- childId
- title
- description
- emoji
- timestamp