namespace DevOpsCurso.Api.Models
{
    public class User
    {
        public int Id { get; set; }               // coincide con tu tabla SQL
        public string Name { get; set; } = string.Empty;
    }
}