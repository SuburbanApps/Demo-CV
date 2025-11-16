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

### Infraestructura / DevOps
- IIS 10 como servidor de aplicaciones
- Scripts PowerShell:
  - `Deploy-Api.ps1`
  - `Deploy-Front.ps1`
  - `Test-Entorno.ps1`
- Publicación en `C:\inetpub\wwwroot\api` y `C:\inetpub\wwwroot\front`

---

## 📁 Estructura del proyecto

