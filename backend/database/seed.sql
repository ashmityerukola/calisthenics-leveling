INSERT INTO skills (name, category, difficulty, xp_value, measure) VALUES
    ('Push-up', 'push', 1, 1, 'reps'),
    ('Muscle-up', 'pull', 8, 64, 'reps');

INSERT INTO skill_prerequisites (skill_id, prerequisite_id)
SELECT s.id, p.id FROM skills s, skills p
WHERE s.name = 'Pull-up' AND p.name = 'Negative Pull-up';