# Demo CV — API .NET + Front Angular + IIS Deployment

Este proyecto es una demostración técnica desarrollada para procesos de selección.  
Incluye una **API en .NET 8**, un **frontend en Angular**, y un conjunto de **scripts DevOps** para automatizar el despliegue en IIS.

## 🚀 Tecnologías utilizadas

### Backend (.NET 8 API)
- ASP.NET Core Web API
- Entity Framework Core
- SQL Server LocalDB
- Swagger para documentación
- Publicado en IIS con `AspNetCoreModuleV2`

### Frontend (Angular)
- Angular CLI
- Servicios HttpClient para consumir la API
- CRUD completo de usuarios
- Configurado para producción con build optimizado
Demo-CV
┣ 📂 DevOpsCurso.Api → API .NET 8
┃ ┣ 📂 Controllers
┃ ┣ 📂 Data
┃ ┣ 📂 Models
┃ ┗ 📜 Program.cs
┣ 📂 devops-front → Front Angular
┃ ┣ 📂 src/app
┃ ┣ 📂 src/environments
┃ ┗ 📜 package.json
┣ 📜 Deploy-Api.ps1
┣ 📜 Deploy-Front.ps1
┣ 📜 Test-Entorno.ps1
┗ 📜 README.md


---

## 🔌 API — Endpoints principales

### ✔️ GET /api/Users
Obtiene la lista de usuarios.

### ✔️ POST /api/Users
Crea un nuevo usuario.

### ✔️ PUT /api/Users/{id}
Actualiza un usuario existente.

### ✔️ DELETE /api/Users/{id}
Elimina un usuario.

---

## 🧩 Ejecución en entorno local

### 🔹 API (.NET 8)

```powershell
cd DevOpsCurso.Api
dotnet run


La API estará disponible en:

http://localhost:5000

🔹 Front Angular
cd devops-front
ng serve --open


Abre en:

http://localhost:4200

🚀 Despliegue en IIS
📌 API

Se publica en:

C:\inetpub\wwwroot\api


Ejecutar:

.\Deploy-Api.ps1

📌 Front

Se publica en:

C:\inetpub\wwwroot\front


Ejecutar:

.\Deploy-Front.ps1

🧪 Test automático del sistema

Se valida:

Servicio W3SVC

Puerto 5000 (API)

Puerto 1433 (SQL Server)

Acceso a /api/Users

Acceso a Front Angular

Ejecutar:

.\Test-Entorno.ps1

📸 Demo del flujo funcional

Arrancar la API

Arrancar el Front

Listar usuarios

Crear usuario desde Angular

Verlo reflejado en SQL Server

Usar PUT y DELETE desde el front

Ejecutar los scripts de despliegue

👤 Autor

SuburbanApps
Proyecto técnico para entrevista: DevOps / Full Stack / IIS / .NET / Angular.
### Infraestructura / DevOps
- IIS 10 como servidor de aplicaciones
- Scripts PowerShell:
  - `Deploy-Api.ps1`
  - `Deploy-Front.ps1`
  - `Test-Entorno.ps1`
- Publicación en `C:\inetpub\wwwroot\api` y `C:\inetpub\wwwroot\front`

---

## 📁 Estructura del proyecto



