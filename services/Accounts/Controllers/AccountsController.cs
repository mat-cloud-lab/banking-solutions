using Microsoft.AspNetCore.Mvc;

namespace Accounts.Controllers;

[ApiController]
[Route("[controller]")]
public class AccountsController : ControllerBase
{
    private readonly ILogger<AccountsController> _logger;

    public AccountsController(ILogger<AccountsController> logger)
    {
        _logger = logger;
    }

    [HttpGet(Name = "GetAccounts")]
    public IEnumerable<Account> Get()
    {
        return Enumerable.Range(1, 5).Select(index => new Account
        {
            Number = index.ToString()
        })
        .ToArray();
    }
}
