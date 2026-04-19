# 🧠 MEMORIA DE DESARROLLO - AXRYON

## 📅 Última Actualización: 2024-XX-XX (Sesión 1)

## 🎯 Estado del Proyecto
- **Nombre:** AXRYON Learning Ecosystem.
- **Etapa:** Fase 1 - Arquitectura de Datos e Infraestructura.
- **Tecnologías:** Next.js 15 (App Router), Node.js (NestJS), Supabase (PostgreSQL), Tailwind CSS, Clerk (Auth), Cloudinary (Media).

## ✅ Tareas Completadas
1.  **Definición de Marca:** Cambio de AXON a AXRYON. Eslogan y paleta de colores definidos.
2.  **Infraestructura de Datos:** 
    - Esquema SQL completo creado y sincronizado en `/database/schema.sql`.
    - Jerarquía Geográfica: País > Estado > Ciudad > Institución > Barrio.
    - Sistema de Roles: Superadmin, Director, Vicedirector, Secretaria, Preceptor, Profesor, Alumno.
    - Sistema de Turnos: Columna independiente (Mañana, Tarde, Noche, Completo).
    - Estructura Pedagógica: Niveles, Materias y Contenidos Multimedia listos.
3.  **Seguridad:** Configuración de RLS (Row Level Security) iniciada para evitar invasión de materias entre profesores.

## 📂 Archivos de Contexto Creados
- `PROJECT_AXRYON_CORE.md`: Visión general y reglas de oro.
- `database/schema.sql`: Estructura técnica real de la base de datos.
- `.cursorrules`: Instrucciones de comportamiento para la IA.

## 🚀 Próximos Pasos (Para la próxima sesión)
1.  **Generación de Tipos:** Crear `src/types/database.ts` basado en el esquema SQL.
2.  **Configuración de Auth:** Implementar Clerk y vincularlo con la tabla `public.profiles` de Supabase.
3.  **Frontend Base:** Crear la estructura de carpetas de Next.js 15 y el Layout principal que soporte RTL (Árabe/Hebreo).
4.  **Middleware de Roles:** Programar la lógica que redirige al usuario según su Rol y Turno.

## ⚠️ Notas Especiales
- Recordar que los contenidos Multimedia (Videos de 5 min y Audios largos) se gestionarán vía Cloudinary.
- El SEO 2026 debe ser prioritario en la creación de las rutas dinámicas por ubicación.