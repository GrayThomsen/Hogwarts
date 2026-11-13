# Hogwarts PostgreSQL database

Use these SQL identifiers when generating queries, API handlers, or data access code for the Hogwarts project. The database is `hogwarts` and the schema is `public`. This reference comes from the schema design and seed SQL. Use the live schema or checked-in DDL to confirm types and constraints where they matter.

## Tables and columns

| Table | Columns used in the project |
|---|---|
| `houses` | `id`, `name`, `fk_founder`, `fk_head_of_house`, `fk_house_ghost`, `sigil`, `colours` |
| `staff` | `id`, `first_name`, `last_name`, `fk_house`, `active_status`, `health_status`, `birthday`, `date_of_hiring`, `final_day` |
| `students` | `id`, `first_name`, `last_name`, `fk_house`, `birthday` |
| `wands` | `id`, `wood`, `core`, `length`, `fk_student_owner`, `fk_staff_owner` |
| `subject_type` | `id`, `name`, `ects` |
| `subjects` | `id`, `name`, `start_year`, `end_year`, `fk_type`, `fk_required_grade` |
| `grades` | `id`, `name`, `symbol`, `outcome` |
| `qualifications` | `id`, `name`, `description` |
| `regulators` | `id`, `name`, `authority_level` |
| `staff_subjects` | `fk_staff_id`, `fk_subject_id`, `role` |
| `students_subjects` | `fk_student_id`, `fk_subject_id`, `year` |
| `exams` | `id`, `fk_student`, `fk_subject`, `fk_grade`, `date`, `fk_qualifications`, `fk_regulators` |

The exam table is `exams`. Its foreign keys use the column names shown above. The two subject junction tables use the `_id` suffix shown in the table.

## Foreign keys

| Source columns | Target |
|---|---|
| `students.fk_house`, `staff.fk_house` | `houses.id` |
| `houses.fk_founder`, `houses.fk_head_of_house`, `houses.fk_house_ghost` | `staff.id` |
| `wands.fk_student_owner` | `students.id` |
| `wands.fk_staff_owner` | `staff.id` |
| `subjects.fk_type` | `subject_type.id` |
| `subjects.fk_required_grade` | `grades.id` |
| `staff_subjects.fk_staff_id` | `staff.id` |
| `students_subjects.fk_student_id`, `exams.fk_student` | `students.id` |
| `staff_subjects.fk_subject_id`, `students_subjects.fk_subject_id`, `exams.fk_subject` | `subjects.id` |
| `exams.fk_grade` | `grades.id` |
| `exams.fk_qualifications` | `qualifications.id` |
| `exams.fk_regulators` | `regulators.id` |

## Query conventions

- Use IDs for joins and parameterize user-supplied values with PostgreSQL placeholders such as `$1`. Let PostgreSQL generate identity IDs on inserts. Resolve lookup IDs by stable values such as house name, qualification name, or grade symbol.
- A subject name can occur in several rows. For example, Potions has a years 1–5 row and a years 6–7 row. Use `subjects.id` for references. To find a specific course by name, include `start_year` and `end_year`.
- `students_subjects.year` is a Hogwarts year level from 1 to 7. The enrollment seed identifies a row by student, subject, and year. A student can take the same subject in several year levels.
- `staff_subjects` represents teaching assignments across the book era. Multiple staff can be linked to the same subject. The table has no assignment year. The seeded role is `Teacher`.
- A wand uses one owner column when assigned. Seed data also includes an unowned wand with both owner columns `NULL`. Use two `LEFT JOIN`s for a complete wand inventory. Length is stored in inches.
- Founders and house ghosts are stored in `staff` and linked through `houses`. Ghosts use `health_status = 'Deceased'` and can have `active_status = true`. Birthdays and employment dates can be missing. `final_day` represents the end of Hogwarts service.
- `exams` stores individual student results. The seed uses year 5 enrollments for O.W.L.s and year 7 enrollments for N.E.W.T.s. It skips existing student–subject–qualification combinations. The regulator comes from the exam row. Dates and grades in the generated exam seed are sample data.
- `subjects.fk_required_grade` is an entry prerequisite for the advanced course. `exams.fk_grade` is the actual exam result. Join `grades` under two aliases if both are needed.

## Lookup values

| Lookup | Seed values |
|---|---|
| Houses | Gryffindor, Hufflepuff, Ravenclaw, Slytherin |
| Subject types | Mandatory, Elective, Course, Practical, Extracurricular |
| Qualifications | O.W.L., N.E.W.T., Certification |
| Regulators | Wizarding Examinations Authority, Department of Magical Transportation, Hogwarts School of Witchcraft and Wizardry |
| Grade symbols, best to worst | O (Outstanding), E (Exceeds Expectations), A (Acceptable), P (Poor), D (Dreadful), T (Troll) |

Compare grades by the order above. Grade IDs are generated and can vary between databases. `A` is the lowest passing grade. Course prerequisites can be stricter.

## Example queries

```sql
-- A student's enrolled subjects at a given Hogwarts year level.
select s.id, s.name, s.start_year, s.end_year, t.name as subject_type
from public.students_subjects as enrollment
join public.subjects as s on s.id = enrollment.fk_subject_id
join public.subject_type as t on t.id = s.fk_type
where enrollment.fk_student_id = $1
  and enrollment.year = $2
order by s.name;
```

```sql
-- A student's exam results with readable lookup values.
select e.id, e.date as exam_date, s.name as subject,
       q.name as qualification, g.symbol as grade,
       r.name as regulator
from public.exams as e
join public.subjects as s on s.id = e.fk_subject
join public.qualifications as q on q.id = e.fk_qualifications
join public.grades as g on g.id = e.fk_grade
left join public.regulators as r on r.id = e.fk_regulators
where e.fk_student = $1
order by e.date, s.name;
```
