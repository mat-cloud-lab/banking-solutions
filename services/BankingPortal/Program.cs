using BankingPortal;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllersWithViews();

var config = builder.Configuration.Get<Configuration>();

builder.Services.AddSingleton<accounts_swaggerClient>(
    new accounts_swaggerClient(config.AccountsUri, new HttpClient()));
builder.Services.AddSingleton<customers_swaggerClient>(
    new customers_swaggerClient(config.CustomersUri, new HttpClient()));
builder.Services.AddApplicationInsightsTelemetry();

var app = builder.Build();

// Configure the HTTP request pipeline.
/*if (!app.Environment.IsDevelopment())
{
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}*/

//app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();


app.MapControllerRoute(
    name: "default",
    pattern: "{controller}/{action=Index}/{id?}");

app.MapFallbackToFile("index.html");;

app.Run();
