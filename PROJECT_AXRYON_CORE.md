Este es el **Documento Maestro de Arquitectura y Hoja de Ruta** para el proyecto **AXRYON**. Guárdalo en un archivo llamado `PROJECT_AXRYON_CORE.md` en tu carpeta raíz.

---

# 📜 INFORME DEL PROYECTO: AXRYON Learning Ecosystem

## 1. Visión General
**AXRYON** es un ecosistema educativo digital internacional diseñado para la gestión administrativa y pedagógica hiper-localizada. A diferencia de otros LMS, AXRYON se adapta automáticamente según la ubicación geográfica (País, Región, Ciudad, Barrio), ajustando currículos, idiomas (56+) y normativas legales.

## 2. Pilares Estratégicos
*   **Jerarquía de Roles:** SuperAdmin (Global), Director (Institución), Secretaría, Preceptor (por turno), Profesor (por materia), Alumno.
*   **Seguridad Zero-Trust:** Implementación de *Row Level Security* (RLS) en base de datos. Ningún usuario puede acceder a datos fuera de su jerarquía o institución.
*   **SEO 2026:** Optimización para búsqueda semántica, carga instantánea mediante *Edge Runtime* y generación de rutas dinámicas por geolocalización.
*   **Gestión Multimedia:** Sistema inteligente de procesamiento de video (5 min) y audio (largos) de producción propia o terceros, optimizados para bajo consumo de datos.

## 3. Stack Tecnológico Definitivo
*   **Frontend:** Next.js 15+ (App Router).
*   **Backend:** Node.js con NestJS (Arquitectura modular).
*   **Base de Datos:** PostgreSQL (vía Supabase) con RLS activado.
*   **Autenticación:** Clerk (Soporta MFA y seguridad de grado bancario).
*   **Media:** Cloudinary (Transcoding automático de video/audio).
*   **Despliegue:** Vercel (Frontend/Edge) y Render/Supabase (Backend/DB).
*   **Internacionalización:** `next-intl` (Soporte LTR/RTL).

---

# 🛠 PASO A PASO: COMIENZO DEL PROYECTO

### 1. Configuración del Entorno Local
*   **IDE:** Instala **Cursor** (es un fork de VS Code que ya trae la IA integrada y entiende todo tu proyecto mejor que las extensiones básicas). Si prefieres seguir en VS Code, instala la extensión **Cline** (antes Claude Dev).
*   **Subagente de IA:** Configura Cline con la API de **Claude 3.5 Sonnet** (es la más precisa para arquitectura).
*   **Extensiones VS Code:**
    1.  *Prisma:* Para el modelado de base de datos.
    2.  *Tailwind CSS IntelliSense.*
    3.  *ESLint / Prettier.*
    4.  *i18n Ally:* Para gestionar los 56 idiomas.

### 2. Estructura de Carpetas (Arquitectura Profesional)
En Next.js no usamos `BrowserRouter`. La carpeta `app` define las rutas.

### 3. Diferencias Clave (React vs. Next.js)
*   **Helmet:** No se usa. En Next.js usas un objeto `export const metadata` en cada `page.tsx` para el SEO.
*   **BrowserRouter:** Se elimina. Las carpetas dentro de `/app` son las rutas automáticamente.
*   **StrictMode/Context:** Ya no envuelven a toda la App en un `main.jsx`. En Next.js, creas un `providers.tsx` (Client Component) y lo envuelves en el `layout.tsx` de la carpeta raíz.

---

# 🤖 CONFIGURACIÓN DEL SUBAGENTE (IA)

Para que la IA no divague, crea un archivo en la raíz llamado `.cursorrules` (o dile a Cline que lea esto):

**Contenido de Reglas para la IA:**
> "Eres el Arquitecto Senior de AXON. Reglas: 1. Siempre usa TypeScript estricto. 2. Toda consulta a la base de datos debe respetar el RLS de Supabase. 3. El diseño debe ser moderno con Tailwind CSS. 4. Las imágenes y videos se gestionan SOLO vía Cloudinary. 5. El SEO debe cumplir estándares 2026 (Metadata dinámico y JSON-LD). 6. Antes de escribir código, explica la lógica brevemente."

---

# 🚀 ACCIONES INMEDIATAS (Día 1)

1.  **Inicializar Proyecto:** 
    `npx create-next-app@latest axon-platform --typescript --tailwind --eslint`
2.  **Configurar Supabase:** 
    Crea el proyecto en el dashboard de Supabase y obtén las `URL` y `ANON_KEY`.
3.  **Configurar Clerk (Auth):**
    Es vital para la seguridad. Crea una cuenta en Clerk y sigue el wizard para Next.js. Esto reemplaza tus rutas protegidas manuales de React por un Middleware mucho más seguro.
4.  **Primer Archivo de Contexto:** 
    Crea `PROJECT_AXRYON_CORE.md` y pega el informe de arriba.

### ¿Por qué Cloudinary para tus videos/audios?
Como mencionaste que los videos son de 5 min y los audios largos, Cloudinary hará lo siguiente de forma externa (sin cargar tu servidor):
*   Convertirá un video pesado de un profesor a formato `.webm` o `.mp4` optimizado para celulares de baja gama.
*   Generará miniaturas automáticas.
*   Te dará un enlace CDN para que el video cargue instantáneamente en cualquier parte del mundo.