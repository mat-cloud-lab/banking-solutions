using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.NotificationHubs;
using MobileApplications.Models;

namespace MobileApplications.Controllers;

[ApiController]
[Route("[controller]")]
public class NotificationsController : ControllerBase
{
    private readonly INotificationHubClient hub;

    public NotificationsController(INotificationHubClient hub)
    {
        this.hub = hub;
    }

    [HttpPost("registrations")]
    public async Task<FcmRegistrationDescription> Register([FromBody] RegistrationModel registration)
    {
        var result = await this.hub.CreateFcmNativeRegistrationAsync(registration.Token, registration.Tags);

        return result;
    }

    [HttpGet("registrations")]
    public async Task<IEnumerable<RegistrationDescription>> GetAllRegistrations()
    {
        var result = await this.hub.GetAllRegistrationsAsync(100);

        return result;
    }

    [HttpGet("registrations/{id}")]
    public async Task<FcmRegistrationDescription> GetRegistration(string id)
    {
        var result = await this.hub.GetRegistrationAsync<FcmRegistrationDescription>(id);

        return result;
    }

    [HttpPost("messages")]
    public async Task<FcmRegistrationDescription> SendMessage([FromBody] MessageModel message)
    {
        var result = await this.hub.CreateFcmNativeRegistrationAsync(registration.Token, registration.Tags);

        return result;
    }
}
