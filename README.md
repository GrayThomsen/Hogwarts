<!-- TODO SKAL LAVES OM, NU MED MODULER OG SEPERATION OF CONCERNS -->

# Hogwarts API

Dette dokument beskriver de API-ruter, der er implementeret i `server.js`.
Serveren lytter på port `3000` og modtager JSON i request body.
Fejlbeskederne i svarene er på engelsk, som i koden.

## Houses

- `GET /houses` - Returnerer alle huse (`200`). Findes der ingen, svares `404`
  med `{"error":"Houses not found"}`.
- `GET /houses/:id` - Returnerer huset med det id (`200`). Findes det ikke,
  svares `404` med `{"error":"House not found"}`.

## Students

- `GET /students` - Returnerer alle elever inkl. husnavn (via join med houses) (`200`). Findes ingen,
  svares `404` med `{"error":"No students found"}`.
- `GET /students/:id` - Returnerer eleven med det id inkl. husnavn (`200`).
  Findes eleven ikke, svares `404` med `{"error":"Student not found"}`.
- `POST /students` - Opretter en elev ud fra `first_name`, `last_name` og
  `house`. Findes samme fornavn, efternavn og hus allerede, svares `400` med
  `{"error":"Student already exists"}`. Ellers returneres den oprettede række
  med `201`.
- `PUT /students/:id` - Erstatter elevens `first_name`, `last_name` og `house`.
  Returnerer den opdaterede række (`200`), eller `404` med
  `{"error":"Student not found"}` hvis id ikke findes.
- `DELETE /students/:id` - Sletter eleven og returnerer rækken (`200`), eller
  `404` med `{"error":"Student not found"}` hvis id ikke findes.

## Staff


- `GET /staff` - Returnerer alt personale (`200`). Findes ingen, svares `404`
  med `{"error":"Staff not found"}`.
- `GET /staff/:id` - Returnerer medarbejderen med det id (`200`). Findes
  vedkommende ikke, svares `404` med `{"error":"Staff member not found"}`.
- `POST /staff` - Opretter en medarbejder ud fra `first_name`, `last_name` og
  `role`. Findes samme fornavn, efternavn og rolle allerede, svares `400` med
  `{"error":"Staff member already exists"}`. Ellers returneres den oprettede
  række med `201`.
- `PUT /staff/:id` - Erstatter `first_name`, `last_name` og `role`. Returnerer
  den opdaterede række (`200`), eller `404` med
  `{"error":"Staff member not found"}` hvis id ikke findes.
- `DELETE /staff/:id` - Sletter medarbejderen og returnerer rækken (`200`),
  eller `404` med `{"error":"Staff member not found"}` hvis id ikke findes.

## Classes

- `GET /classes` - Returnerer alle fag/klasser (`200`). Findes ingen, svares
  `404` med `{"error":"No classes found"}`.
- `GET /classes/:id` - Returnerer klassen med det id (`200`). Findes den ikke,
  svares `404` med `{"error":"Class not found"}`.
- `POST /classes` - Opretter en klasse ud fra `name`. Findes navnet allerede,
  svares `409` med `{"error":"Class with the same name already exists"}`.
  Ellers returneres den oprettede række med `201`.
- `PUT /classes/:id` - Opdaterer klassens `name`. Returnerer den opdaterede
  række (`200`), eller `404` med `{"error":"Class not found"}` hvis id ikke
  findes.
- `DELETE /classes/:id` - Sletter klassen og returnerer rækken (`200`), eller
  `404` med `{"error":"Class not found"}` hvis id ikke findes.

## Student-class assignments

- `GET /student_classes` - Returnerer alle elev-klasse-koblinger (`200`).
  Findes ingen, svares `404` med `{"error":"No student-class assignments found"}`.
- `POST /student_classes` - Opretter en kobling ud fra `student_id`, `class_id`
  og `year`. Findes kombinationen allerede, svares `409` med
  `{"error":"Student-class combination already exists"}`. Ellers returneres den
  oprettede række med `201`.
- `DELETE /student_classes/:student_id/:class_id/:year` - Sletter den matchende
  kobling og returnerer den (`200`), eller `404` med
  `{"error":"Student-class assignment not found"}` hvis den ikke findes.

## Teacher-class assignments

- `GET /teacher_classes` - Returnerer alle lærer-klasse-koblinger (`200`).
  Findes ingen, svares `404` med
  `{"error":"No teacher-class assignments found"}`.
- `POST /teacher_classes` - Opretter en kobling ud fra `teacher_id` og
  `class_id`. Findes kombinationen allerede, svares `409` med
  `{"error":"Teacher-class combination already exists"}`. Ellers returneres den
  oprettede række med `201`.
- `DELETE /teacher_classes/:teacher_id/:class_id` - Sletter den matchende
  kobling og returnerer den (`200`), eller `404` med
  `{"error":"Teacher-class assignment not found"}` hvis den ikke findes.

## Kør serveren

1. Installer afhængigheder: `npm install`
2. Opret en `.env`-fil med `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD` og
   `DB_NAME` til en PostgreSQL-database.
3. Indlæs skema og data fra `Database/hogwarts_dump.sql` (og evt.
   `Database/hogwarts_insert.sql`).
4. Start serveren: `node server.js` (lytter på `http://localhost:3000`).

## Test

Endpoints testes manuelt med [Bruno](https://www.usebruno.com/)-samlingen i
`hogwarts-API-test/`.

1. Åbn Bruno og vælg _Open Collection_ -> `hogwarts-API-test`.
2. Vælg miljøet `Developer` (sætter `BaseURL` til `http://localhost:3000`).
3. Med serveren kørende: kør en request (fx `students/Add Student`) eller en
   hel mappe.
4. Tjek statuskode og JSON-svar mod beskrivelserne ovenfor.

Foreslået rækkefølge: opret (`POST`), læs (`GET`), ret (`PUT`), slet
(`DELETE`). Test også fejlsituationer: ukendte id'er (`404`) og dobbelt-`POST`
(`400`/`409`).

Pseudokode for endpoint-mønstrene findes i [pseudo.md](./pseudo.md).

## Fejl

Ruter svarer `500` med `{"error":"Database error"}`, hvis en databaseoperation
fejler. Fejlen logges også af serveren.
