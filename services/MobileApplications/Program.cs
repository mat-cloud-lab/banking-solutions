using Microsoft.Azure.NotificationHubs;

var builder = WebApplication
    .CreateBuilder(args);

builder.Configuration.AddJsonFile($"appsettings.{builder.Environment.EnvironmentName}.Private.json");

// Add services to the container.

builder.Services.AddSingleton<INotificationHubClient, NotificationHubClient>(services =>
{
    var connectionString = services.GetRequiredService<IConfiguration>().GetValue<string>("NotificationHub:ConnectionString");
    var hubName = services.GetRequiredService<IConfiguration>().GetValue<string>("NotificationHub:HubName");
    return new NotificationHubClient(connectionString, hubName);
});
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
