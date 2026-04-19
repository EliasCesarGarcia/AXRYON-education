-- ==========================================================
-- AXRYON LEARNING ECOSYSTEM - DATABASE SCHEMA (v1.0)
-- Purpouse: Context for AI Sub-agents (Cline/Copilot)
-- Last Update: 2024
-- ==========================================================

-- 1. EXTENSIONS
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. ENUMERATED TYPES (Critical for Logic)
-- Defines the hierarchical roles within the institution
CREATE TYPE public.user_role_type AS ENUM (
  'superadmin', 
  'director', 
  'vicedirector', 
  'secretaria', 
  'preceptor', 
  'profesor', 
  'alumno'
);

-- Defines shifts for administrative and academic staff
CREATE TYPE public.shift_type AS ENUM (
  'manana', 
  'tarde', 
  'noche', 
  'completo'
);

-- 3. GEOGRAPHY (International Support)
CREATE TABLE public.countries (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  name text NOT NULL UNIQUE,
  iso_code text UNIQUE NOT NULL, -- e.g., 'AR', 'ES', 'US'
  phone_code text
);

CREATE TABLE public.states (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  country_id uuid REFERENCES public.countries(id) ON DELETE CASCADE,
  name text NOT NULL
);

CREATE TABLE public.cities (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  state_id uuid REFERENCES public.states(id) ON DELETE CASCADE,
  name text NOT NULL,
  zip_code text
);

-- 4. INSTITUTIONS
CREATE TABLE public.institutions (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  city_id uuid REFERENCES public.cities(id),
  name text NOT NULL,
  neighborhood text,
  address text,
  branding_colors jsonb DEFAULT '{"primary": "#8B5CF6", "secondary": "#14B8A6"}'::jsonb,
  created_at timestamptz DEFAULT now()
);

-- 5. USER PROFILES & AUTHENTICATION
-- Links to auth.users (Supabase Auth)
CREATE TABLE public.profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  institution_id uuid REFERENCES public.institutions(id),
  first_name text NOT NULL,
  last_name text NOT NULL,
  dni_passport text UNIQUE,
  role_name public.user_role_type NOT NULL,
  shift public.shift_type DEFAULT 'manana',
  avatar_url text, -- Creative/UI avatar
  photo_url text,  -- Real official photo for records
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

-- 6. STUDENT RECORDS (Legajos - High Security)
CREATE TABLE public.student_files (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE,
  dni_front_url text, -- Secured in Cloudinary/Private Bucket
  dni_back_url text,
  medical_certificate_url text,
  home_address text,
  home_city_id uuid REFERENCES public.cities(id),
  emergency_contact jsonb, -- {name: string, phone: string}
  updated_at timestamptz DEFAULT now()
);

-- 7. ACADEMIC STRUCTURE
CREATE TABLE public.academic_levels (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  institution_id uuid REFERENCES public.institutions(id),
  name text NOT NULL, -- e.g., "Secundaria", "Primaria"
  total_years integer NOT NULL -- e.g., 6 years
);

CREATE TABLE public.subjects (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  level_id uuid REFERENCES public.academic_levels(id) ON DELETE CASCADE,
  name text NOT NULL,
  year_number integer NOT NULL, -- 1st year, 2nd year...
  slug text UNIQUE, -- SEO 2026: /math-1st-year
  description text,
  created_at timestamptz DEFAULT now()
);

-- 8. PEDAGOGICAL CONTENT (Videos, Audios, PDFs)
CREATE TABLE public.contents (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  subject_id uuid REFERENCES public.subjects(id) ON DELETE CASCADE,
  author_id uuid REFERENCES public.profiles(id),
  period_year integer NOT NULL, -- e.g., 2025
  period_cycle text, -- "1st Trimester", "April", etc.
  title text NOT NULL,
  body_text text, -- Main written content
  video_url text, -- Managed via Cloudinary
  audio_url text,
  pdf_url text,
  slug text UNIQUE, -- SEO 2026: /subject/content-slug
  metadata jsonb DEFAULT '{}'::jsonb, -- For additional SEO/Linguistic data
  is_published boolean DEFAULT false,
  created_at timestamptz DEFAULT now()
);

-- 9. EVALUATION & TRACKING
CREATE TABLE public.activities (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  content_id uuid REFERENCES public.contents(id) ON DELETE CASCADE,
  title text NOT NULL,
  activity_type text, -- 'quiz', 'upload', 'game'
  max_score numeric DEFAULT 10,
  due_date timestamptz
);

CREATE TABLE public.grades (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id uuid REFERENCES public.profiles(id),
  subject_id uuid REFERENCES public.subjects(id),
  teacher_id uuid REFERENCES public.profiles(id),
  score numeric NOT NULL,
  feedback text,
  created_at timestamptz DEFAULT now()
);

-- 10. ATTENDANCE
CREATE TABLE public.attendance (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_id uuid REFERENCES public.profiles(id),
  date date NOT NULL DEFAULT CURRENT_DATE,
  status text CHECK (status IN ('presente', 'ausente', 'justificado')),
  preceptor_id uuid REFERENCES public.profiles(id)
);