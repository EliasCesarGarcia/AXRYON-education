// AXRYON Database Types - Generated from schema.sql
// This file contains TypeScript interfaces for all database tables

// 1. ENUMERATED TYPES
export type UserRoleType = 'superadmin' | 'director' | 'vicedirector' | 'secretaria' | 'preceptor' | 'profesor' | 'alumno';
export type ShiftType = 'manana' | 'tarde' | 'noche' | 'completo';

// 2. GEOGRAPHY
export interface Country {
  id: string;
  name: string;
  iso_code: string;
  phone_code?: string;
}

export interface State {
  id: string;
  country_id: string;
  name: string;
}

export interface City {
  id: string;
  state_id: string;
  name: string;
  zip_code?: string;
}

// 3. INSTITUTIONS
export interface Institution {
  id: string;
  city_id?: string;
  name: string;
  neighborhood?: string;
  address?: string;
  branding_colors: {
    primary: string;
    secondary: string;
  };
  created_at: Date;
}

// 4. USER PROFILES & AUTHENTICATION
export interface Profile {
  id: string;
  institution_id?: string;
  first_name: string;
  last_name: string;
  dni_passport?: string;
  role_name: UserRoleType;
  shift?: ShiftType;
  avatar_url?: string;
  photo_url?: string;
  is_active?: boolean;
  created_at: Date;
}

// 5. STUDENT RECORDS
export interface StudentFile {
  id: string;
  profile_id: string;
  dni_front_url?: string;
  dni_back_url?: string;
  medical_certificate_url?: string;
  home_address?: string;
  home_city_id?: string;
  emergency_contact?: {
    name: string;
    phone: string;
  };
  updated_at: Date;
}

// 6. ACADEMIC STRUCTURE
export interface AcademicLevel {
  id: string;
  institution_id?: string;
  name: string;
  total_years: number;
}

export interface Subject {
  id: string;
  level_id: string;
  name: string;
  year_number: number;
  slug: string;
  description?: string;
  created_at: Date;
}

// 7. PEDAGOGICAL CONTENT
export interface Content {
  id: string;
  subject_id: string;
  author_id?: string;
  period_year: number;
  period_cycle: string;
  title: string;
  body_text?: string;
  video_url?: string;
  audio_url?: string;
  pdf_url?: string;
  slug: string;
  metadata?: Record<string, any>;
  is_published?: boolean;
  created_at: Date;
}

// 8. EVALUATION & TRACKING
export interface Activity {
  id: string;
  content_id: string;
  title: string;
  activity_type?: string;
  max_score?: number;
  due_date?: Date;
}

export interface Grade {
  id: string;
  student_id: string;
  subject_id: string;
  teacher_id: string;
  score: number;
  feedback?: string;
  created_at: Date;
}

// 9. ATTENDANCE
export interface Attendance {
  id: string;
  student_id: string;
  date: Date;
  status: 'presente' | 'ausente' | 'justificado';
  preceptor_id?: string;
}

// 10. AUTH USERS (Supabase Auth)
export interface AuthUser {
  id: string;
  email?: string;
  created_at: Date;
}

// 11. COMBINED TYPES FOR UI
export interface UserWithProfile {
  auth_user: AuthUser;
  profile: Profile;
  institution?: Institution;
  student_file?: StudentFile;
}

export interface ContentWithRelations {
  content: Content;
  subject: Subject;
  author?: Profile;
}

export interface GradeWithRelations {
  grade: Grade;
  student: Profile;
  subject: Subject;
  teacher: Profile;
}