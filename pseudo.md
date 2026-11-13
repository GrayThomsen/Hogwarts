# Pseudokode for endpoints

Alle endpoints er `async` og pakket i try/catch. Fanger vi en fejl, logges den, og der svares `500 {"error":"Database error"}`. Dette gentages ikke nedenfor.

## Mønster 1: GET alle (liste)

Gælder: `GET /houses`, `GET /students`, `GET /staff`, `GET /classes`, `GET /student_subjects`, `GET /staff_subjects`, `GET /exams`

```
Hent alle rækker fra tabellen (students joines med houses, så husnavn medfølger)
Hvis der ingen rækker er:
    svar 404 med fejlbesked ("Houses not found", "No students found" osv.)
Ellers:
    svar 200 med listen af rækker
```

## Mønster 2: GET én via id

Gælder: `GET /houses/:id`, `GET /students/:id`, `GET /staff/:id`, `GET /classes/:id`, `GET /student_subjects/:id`, `GET /staff_subjects/:id`, `GET /exams/:id`

```
Læs :id fra URL'en
Hent rækken med det id (students joines med houses)
Hvis den ikke findes:
    svar 404 ("House not found", "Student not found" osv.)
Ellers:
    svar 200 med rækken
```

## Mønster 3: POST (opret)

Gælder: `POST /students`, `POST /staff`, `POST /subjects`, `POST /exams`, `POST /student_subjects`, `POST /staff_subjects`

```
Læs felterne fra request body
    students: first_name, last_name, house
    staff:    first_name, last_name, role
    subjects:  name
    exams:    name, date
    student_subjects: student_id, subject_id, year
    staff_subjects: staff_id, subject_id, role
Slå op om en række med samme værdier allerede findes
Hvis den findes:
    svar fejl: 400 for students og staff ("... already exists"),
               409 for classes ("Class with the same name already exists"),
               409 for exams ("Exam with the same name and date already exists"),
               409 for student_subjects ("Student-subject combination already exists"),
               409 for staff_subjects ("Staff-subject combination already exists")
Ellers:
    indsæt rækken og få den nye række tilbage (RETURNING *)
    svar 201 med den oprettede række
```

## Mønster 4: PUT (ret)

Gælder: `PUT /students/:id`, `PUT /staff/:id`, `PUT /subjects/:id`, `PUT /exams/:id`

```
Læs :id fra URL og de nye værdier fra body
Opdater rækken med det id, og få den opdaterede række tilbage
Hvis ingen række blev opdateret (id findes ikke):
    svar 404 ("Student not found" osv., "Exam not found")
Ellers:
    svar 200 med den opdaterede række
```

## Mønster 5: DELETE via id

Gælder: `DELETE /students/:id`, `DELETE /staff/:id`, `DELETE /subjects/:id`, `DELETE /exams/:id`

```
Læs :id fra URL
Slet rækken med det id og få den slettede række tilbage
Hvis ingen række blev slettet:
    svar 404 ("... not found", "Exam not found", "Student-subject assignment not found", "Staff-subject assignment not found")
Ellers:
    svar 200 med den slettede række
```

## Mønster 6: POST på koblingstabeller

Gælder: `POST /student_subjects`, `POST /staff_subjects`

```
Læs fra body
    student_subjects: student_id, subject_id, year
    staff_subjects: staff_id, subject_id, role
Slå op om kombinationen allerede findes
Hvis den findes:
    svar 409 ("... combination already exists")
Ellers:
    indsæt kombinationen (RETURNING *)
    svar 201 med den oprettede række
```

## Mønster 7: DELETE på koblingstabeller

Gælder: `DELETE /student_subjects/:student_id/:subject_id/:year`, `DELETE /staff_subjects/:staff_id/:subject_id`

```
Læs alle nøgler fra URL'en (hele den sammensatte nøgle)
Slet rækken der matcher alle nøglerne (RETURNING *)
Hvis ingen række blev slettet:
    svar 404 ("... assignment not found")
Ellers:
    svar 200 med den slettede række
```

## Ærlig tale

At skrive pseudo løbende har været sindsygt svært og jeg er ikke sikker på at jeg har opdateret alle de rigtige steder. Har forsøgt at arbejde uden AI autofinishing, hvilket også betyder at der sikkert er steder hvor noget mangler.
Hvis du bemærker noget, så giv endelig besked.
Vh. Emil