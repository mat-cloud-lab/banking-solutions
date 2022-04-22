using Microsoft.AspNetCore.Mvc;

namespace Customers.Controllers;

[ApiController]
[Route("[controller]")]
public class CustomersController : ControllerBase
{
    private static readonly string[] Names = new[]
    {
        "Adam", "Mateusz", "Dorota"
    };

    private readonly ILogger<CustomersController> _logger;

    public CustomersController(ILogger<CustomersController> logger)
    {
        _logger = logger;
    }

    [HttpGet(Name = "GetCustomers")]
    public IEnumerable<Customer> Get()
    {
        return Enumerable.Range(1, 3).Select(index => new Customer
        {
            Id = index,
            Name = Names[index-1]
        })
        .ToArray();
    }
}
