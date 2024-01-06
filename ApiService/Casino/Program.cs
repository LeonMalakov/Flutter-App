using Casino;
using Microsoft.AspNetCore.Builder;

var builder = WebApplication.CreateBuilder(args);

var root = new CompositionRoot(builder);
root.Initialize();
var app = await root.Build();

app.Run();