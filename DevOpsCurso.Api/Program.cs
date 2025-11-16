using DevOpsCurso.Api.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// 1) Servicios MVC
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// 2) CORS: permitir Angular en http://localhost:4200
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAngularDev", policy =>
    {
        policy
            .WithOrigins("http://localhost:4200")
            .AllowAnyHeader()
            .AllowAnyMethod();
    });
});

// 3) EF Core + SQL Server
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(
        builder.Configuration.GetConnectionString("DefaultConnection")
    )
);

var app = builder.Build();

// 4) CORS: usar la política (MUY IMPORTANTE, antes de MapControllers)
app.UseCors("AllowAngularDev");

// 5) Swagger solo en Development (opcional, pero útil)
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

// Si no tienes autenticación, esto puedes incluso comentarlo
// app.UseAuthorization();

// 6) Rutas de los controladores
app.MapControllers();

// 7) Run
app.Run();
