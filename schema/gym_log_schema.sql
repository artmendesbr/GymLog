CREATE TABLE exercises (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    video_url TEXT,

    CONSTRAINT exercises_pkey PRIMARY KEY (id),
    CONSTRAINT exercises_name_key UNIQUE (name)
);

CREATE TABLE log (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    exercise_id INTEGER NOT NULL,
    weight NUMERIC(5,2) NOT NULL,
    reps INTEGER NOT NULL,
    is_lbs BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT fk_exercise FOREIGN KEY (exercise_id)
        REFERENCES public.exercises(id)
);

CREATE TABLE routines (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    routine_name TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE routine_exercises (
    routine_id INTEGER,
    exercise_id INTEGER,
    rank TEXT,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    
    CONSTRAINT routine_exercises_pkey PRIMARY KEY (routine_id, exercise_id),
    CONSTRAINT routine_exercises_routine_id_fkey FOREIGN KEY (routine_id)
        REFERENCES public.routines(id) ON DELETE CASCADE,
    CONSTRAINT routine_exercises_exercise_id_fkey FOREIGN KEY (exercise_id)
        REFERENCES public.exercises(id) ON DELETE CASCADE
);
