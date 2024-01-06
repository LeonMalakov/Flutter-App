using Casino.AppSettings;
using Casino.Constants;
using Casino.DAL;
using Casino.DAL.Respositories;
using Casino.Services;
using Casino.Utility;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System;
using System.IO;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Casino {
    public sealed class CompositionRoot {
        private readonly WebApplicationBuilder _builder;
        private readonly IServiceCollection _services;
        private readonly ConfigurationManager _configuration;

        public CompositionRoot(WebApplicationBuilder builder) {
            _builder = builder;
            _services = builder.Services;
            _configuration = builder.Configuration;
        }

        public void Initialize() {
            BindSettings();

            _services.AddControllers();

            BindSwagger();

            BindAuth();

            BindDb();

            _services.AddScoped<IAuthService, AuthService>();
            _services.AddScoped<IAppService, AppService>();
        }

        private void BindDb() {
            _services.AddDbContext<ApplicationDbContext>(options => {
                string connectionStr = _configuration[SettingsConstants.DB_CONNECTION_KEY]!;
                Console.WriteLine(connectionStr);
                options.UseNpgsql(connectionStr);
            });

            _services.AddScoped<IAppRepository, AppRepository>();
        }

        public async Task<WebApplication> Build() {
            var app = _builder.Build();

            // Configure the HTTP request pipeline.
            //if (app.Environment.IsDevelopment()) {
            app.UseSwagger();
            app.UseSwaggerUI();
            //}

            app.UseAuthorization();

            app.MapControllers();

            using (var serviceScope = app.Services.GetRequiredService<IServiceScopeFactory>().CreateScope()) {
                var context = serviceScope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
                context.Database.Migrate();
            }

            return app;
        }

        private void BindSwagger() {
            _services.AddEndpointsApiExplorer();
            _services.AddSwaggerGen(x => {
                x.SwaggerDoc("v1", new OpenApiInfo {
                    Title = "API",
                    Version = "v1"
                });

                x.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme() {
                    Name = "Authorization",
                    Type = SecuritySchemeType.ApiKey,
                    In = ParameterLocation.Header,
                    Description = "JWT Auth"
                });

                x.AddSecurityRequirement(new OpenApiSecurityRequirement() {
                    {
                        new OpenApiSecurityScheme() {
                            Reference = new OpenApiReference() {
                                 Type = ReferenceType.SecurityScheme,
                                 Id = "Bearer"
                             }
                        }, new string[] { }
                    }
                });

                // Add xml docs.
                var xmlFilename = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
                x.IncludeXmlComments(Path.Combine(AppContext.BaseDirectory, xmlFilename));
            });
        }

        private void BindSettings() {
            _services.AddOptions();
            _configuration.AddEnvironmentVariables();

            _services.Configure<JwtSettings>(x => {
                x.Issuer = _configuration[SettingsConstants.JWT_ISSUER_KEY];
                x.Key = _configuration[SettingsConstants.JWT_AUTH_KEY_KEY];
                x.RefreshKey = _configuration[SettingsConstants.JWT_REFRESH_KEY_KEY];
            });
        }

        private void BindAuth() {
            _services
                .AddAuthentication(x => {
                    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                })
                .AddJwtBearer(x => {
                    x.RequireHttpsMetadata = false;
                    x.SaveToken = true;
                    x.TokenValidationParameters = JwtUtility.GetValidationParameters(_configuration);
                });
        }

        private void AddNewtonsoftJson(IMvcBuilder builder) {
            /*builder.AddNewtonsoftJson(options => {
                options.SerializerSettings.DateFormatHandling = DateFormatHandling.IsoDateFormat;
                options.SerializerSettings.NullValueHandling = NullValueHandling.Ignore;
                options.SerializerSettings.ContractResolver = new CamelCasePropertyNamesContractResolver();
            });*/
        }
    }
}
