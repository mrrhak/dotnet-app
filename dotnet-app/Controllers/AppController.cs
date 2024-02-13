using Microsoft.AspNetCore.Mvc;

namespace dotnet_app.Controllers
{
    [ApiController]
    [Route("api/[controller]/[action]")]
    public class AppController(IConfiguration configuration) : ControllerBase
    {
        private readonly IConfiguration _configuration = configuration;

        [HttpGet]
        public IActionResult GetAppColor()
        {
            string? appColor = _configuration.GetValue<string>("AppSetting:AppColor");
            return Ok(new { appColor });
        }
    }
}