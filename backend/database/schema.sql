DROP TABLE IF EXISTS friendships, workout_logs, user_skills, skill_prerequisites, users, skills;

CREATE TABLE skills (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(20) NOT NULL,
    difficulty INTEGER NOT NULL,
    xp_value INTEGER NOT NULL,
    measure VARCHAR(10) NOT NULL CHECK (measure IN ('reps', 'seconds'))
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    total_xp INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE skill_prerequisites (
    skill_id INTEGER NOT NULL REFERENCES skills(id),
    prerequisite_id INTEGER NOT NULL REFERENCES skills(id),
    PRIMARY KEY (skill_id, prerequisite_id),
    CHECK (skill_id <> prerequisite_id)
);

CREATE TABLE user_skills (
    user_id INTEGER NOT NULL REFERENCES users(id),
    skill_id INTEGER NOT NULL REFERENCES skills(id),
    achieved_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (user_id, skill_id)
);

CREATE TABLE workout_logs (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    skill_id INTEGER NOT NULL REFERENCES skills(id),
    reps INTEGER CHECK (reps > 0),
    seconds INTEGER CHECK (seconds > 0),
    CHECK (reps IS NOT NULL OR seconds IS NOT NULL),
    xp_earned INTEGER NOT NULL,
    logged_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE friendships (
    user_id INTEGER NOT NULL REFERENCES users(id),
    friend_id INTEGER NOT NULL REFERENCES users(id),
    accepted BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (user_id, friend_id),
    CHECK (user_id <> friend_id)
);