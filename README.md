<!-- TODO SKAL LAVES OM, NU MED MODULER OG SEPERATION OF CONCERNS -->

# Hogwarts API

Dette dokument beskriver de API-ruter, der er implementeret i `server.js`.
Serveren lytter på port `3000` og modtager JSON i request body.
Fejlbeskederne i svarene er på engelsk, som i koden, da det er både moderne og følger konventionerne for velstruktureret kodedesign.

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
- `POST /students` - Opretter en elev med mindst ét af `first_name` og
  `last_name`; `fk_house` og `birthday` kan være `null` eller udelades.
  Findes samme fornavn, efternavn og hus allerede, svares `400` med
  `{"error":"Student already exists"}`. Ellers returneres den oprettede række
  med `201`.
- `PUT /students/:id` - Erstatter elevens felter med samme body som POST.
  Udeladte valgfrie felter sættes til `null`.
  Returnerer den opdaterede række (`200`), eller `404` med
  `{"error":"Student not found"}` hvis id ikke findes.
- `DELETE /students/:id` - Sletter eleven og returnerer rækken (`200`), eller
  `404` med `{"error":"Student not found"}` hvis id ikke findes.

## Staff

- `GET /staff` - Returnerer alt personale (`200`). Findes ingen, svares `404`
  med `{"error":"Staff not found"}`.
- `GET /staff/:id` - Returnerer medarbejderen med det id (`200`). Findes
  vedkommende ikke, svares `404` med `{"error":"Staff member not found"}`.
- `POST /staff` - Opretter en medarbejder. Angiv mindst ét af `first_name` og
  `last_name`, samt `active_status` og `health_status`. `fk_house`, `birthday`,
  `date_of_hiring` og `final_day` kan være `null` eller udelades.
- `PUT /staff/:id` - Erstatter medarbejderens felter med samme body som POST.
  Udeladte valgfrie felter sættes til `null`. Findes id ikke, svares `404`.
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

## Student-subject assignments

- `GET /student_subjects` - Returnerer alle elev-fag-koblinger (`200`).
  Findes ingen, svares `404`.
- `POST /student_subjects` - Opretter en kobling ud fra `fk_student_id`, `fk_subject_id`
  og `year`. Findes kombinationen allerede, svares `409` med
  `{"error":"Student-subject combination already exists"}`. Ellers returneres den
  oprettede række med `201`.
- `DELETE /student_subjects/:fk_student_id/:fk_subject_id/:year` - Sletter den matchende
  kobling og returnerer den (`200`), eller `404` med
  `{"error":"Student-subject assignment not found"}` hvis den ikke findes.

## Staff-subject assignments

- `GET /staff_subjects` - Returnerer alle personale-fag-koblinger (`200`).
  Findes ingen, svares `404` med
  `{"error":"No staff-subject assignments found"}`.
- `POST /staff_subjects` - Opretter en kobling ud fra `fk_staff_id`,
  `fk_subject_id` og valgfrit `role`. Findes kombinationen allerede, svares `409` med
  `{"error":"Staff-subject combination already exists"}`. Ellers returneres den
  oprettede række med `201`.
- `DELETE /staff_subjects/:fk_staff_id/:fk_subject_id` - Sletter den matchende
  kobling og returnerer den (`200`), eller `404` med
  `{"error":"Staff-subject assignment not found"}` hvis den ikke findes.`

 ## Exams
  - `GET /exams` - Returnerer alle eksamener (`200`). Findes ingen, svares `404` med `{"error":"No exams found"}`.
  - `GET /exams/:id` - Returnerer eksamen med det id (`200`). Findes den ikke, svares `404` med `{"error":"Exam not found"}`.
  - `POST /exams` - Opretter en eksamen ud fra `name` og `date`. Findes kombinationen allerede, svares `409` med `{"error":"Exam with the same name and date already exists"}`. Ellers returneres den oprettede række med `201`.
  - `PUT /exams/:id` - Opdaterer eksamens `name` og `date`. Returnerer den opdaterede række (`200`), eller `404` med `{"error":"Exam not found"}` hvis id ikke findes.
  - `DELETE /exams/:id` - Sletter eksamen og returnerer rækken (`200`), eller `404` med `{"error":"Exam not found"}` hvis id ikke findes.

## Kør serveren

1. Installer afhængigheder: `npm install`
2. Opret en `.env`-fil med `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD` og
   `DB_NAME` til en PostgreSQL-database.
3. Indlæs skema og data fra `Database/hogwarts_dump.sql` (og evt.
   `Database/hogwarts_insert.sql`).
4. Start serveren: `node server.js` (lytter på `http://localhost:3000`).

## Til Peter

Endpoints testes manuelt med [Bruno](https://www.usebruno.com/)-samlingen i
`hogwarts-API-test/`.

1. Åbn Bruno og vælg _Open Collection_ -> `hogwarts-API-test`.
2. Vælg miljøet `Developer` (sætter `BaseURL` til `http://localhost:3000`).
3. Med serveren kørende: kør en request (fx `students/Add Student`) eller en
   hel mappe.
4. Bemærk at der er opsat parametre i de fleste Bruno-requests.
5. Tjek statuskode og JSON-svar mod beskrivelserne ovenfor.

Pseudokode _Eller suppekode, ;-)"_ for endpoint-mønstrene findes i [pseudo.md](./pseudo.md).

## Fejl

Create- og update-requests valideres med DTO-skemaer. Ugyldige bodies giver `400`.

Ruter svarer `500` med `{"error":"Database error"}`, hvis en databaseoperation
fejler. Fejlen logges også af serveren. Selvom du (Peter), ikke ønskede at se fejl 500, så er det min fallback-løsning for uforudsete databaseproblemer.
