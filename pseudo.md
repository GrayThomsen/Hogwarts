# Pseudokode for endpoints

Alle endpoints er `async` og pakket i try/catch. Fanger vi en fejl, logges den, og der svares `500 {"error":"Database error"}`. Dette gentages ikke nedenfor.

## Mønster 1: GET alle (liste)

Gælder: `GET /houses`, `GET /students`, `GET /staff`, `GET /classes`, `GET /student_classes`, `GET /teacher_classes`

```
Hent alle rækker fra tabellen (students joines med houses, så husnavn medfølger)
Hvis der ingen rækker er:
    svar 404 med fejlbesked ("Houses not found", "No students found" osv.)
Ellers:
    svar 200 med listen af rækker
```

## Mønster 2: GET én via id

Gælder: `GET /houses/:id`, `GET /students/:id`, `GET /staff/:id`, `GET /classes/:id`

```
Læs :id fra URL'en
Hent rækken med det id (students joines med houses)
Hvis den ikke findes:
    svar 404 ("House not found", "Student not found" osv.)
Ellers:
    svar 200 med rækken
```

## Mønster 3: POST (opret)

Gælder: `POST /students`, `POST /staff`, `POST /classes`

```
Læs felterne fra request body
    students: first_name, last_name, house
    staff:    first_name, last_name, role
    classes:  name
Slå op om en række med samme værdier allerede findes
Hvis den findes:
    svar fejl: 400 for students og staff ("... already exists"),
               409 for classes ("Class with the same name already exists")
Ellers:
    indsæt rækken og få den nye række tilbage (RETURNING *)
    svar 201 med den oprettede række
```

## Mønster 4: PUT (ret)

Gælder: `PUT /students/:id`, `PUT /staff/:id`, `PUT /classes/:id`

```
Læs :id fra URL og de nye værdier fra body
Opdater rækken med det id, og få den opdaterede række tilbage
Hvis ingen række blev opdateret (id findes ikke):
    svar 404 ("Student not found" osv.)
Ellers:
    svar 200 med den opdaterede række
```

## Mønster 5: DELETE via id

Gælder: `DELETE /students/:id`, `DELETE /staff/:id`, `DELETE /classes/:id`

```
Læs :id fra URL
Slet rækken med det id og få den slettede række tilbage
Hvis ingen række blev slettet:
    svar 404 ("... not found")
Ellers:
    svar 200 med den slettede række
```

## Mønster 6: POST på koblingstabeller

Gælder: `POST /student_classes`, `POST /teacher_classes`

```
Læs fra body
    student_classes: student_id, class_id, year
    teacher_classes: teacher_id, class_id
Slå op om kombinationen allerede findes
Hvis den findes:
    svar 409 ("... combination already exists")
Ellers:
    indsæt kombinationen (RETURNING *)
    svar 201 med den oprettede række
```

## Mønster 7: DELETE på koblingstabeller

Gælder: `DELETE /student_classes/:student_id/:class_id/:year`, `DELETE /teacher_classes/:teacher_id/:class_id`

```
Læs alle nøgler fra URL'en (hele den sammensatte nøgle)
Slet rækken der matcher alle nøglerne (RETURNING *)
Hvis ingen række blev slettet:
    svar 404 ("... assignment not found")
Ellers:
    svar 200 med den slettede række
```

## Bemærkninger

- Der findes ingen `/teachers`-endpoints. Lærere er rækker i `staff`; `teacher_classes.teacher_id` peger på et staff-id. `GET /teachers` ville følge mønster 1 og `PUT /teachers/:id` mønster 4.
- Houses er kun læsbare (kun mønster 1 og 2).
- `student_classes` og `teacher_classes` har ingen GET-via-id og ingen PUT.
