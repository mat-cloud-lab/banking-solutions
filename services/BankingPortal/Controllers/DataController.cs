using Microsoft.AspNetCore.Mvc;

namespace BankingPortal.Controllers;

[ApiController]
[Route("[controller]")]
public class DataController : ControllerBase
{
    private readonly ILogger<DataController> _logger;
    private readonly accounts_swaggerClient _accounts;
    private readonly customers_swaggerClient _customers;

    public DataController(
        ILogger<DataController> logger,
        accounts_swaggerClient accounts,
        customers_swaggerClient customers)
    {
        _logger = logger;
        _accounts = accounts;
        _customers = customers;
    }

    [HttpGet]
    public async Task<Data> Get()
    {
        var accounts = await _accounts.GetAccountsAsync();
        var customers = await _customers.GetCustomersAsync();

        return new Data
        {
            Accounts = accounts.ToArray(),
            Customers = customers.ToArray()
        };
    }
}
