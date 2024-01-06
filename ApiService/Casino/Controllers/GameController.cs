using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace Casino.Controllers {
    [ApiController]
    [Authorize]
    [Route("game")]
    public sealed class GameController {
        /// <summary>
        /// Тестовый метод.
        /// </summary>
        /// <returns>Результат</returns>
        /// <remarks>
        /// Пример: 1234
        ///
        /// </remarks>
        /// <response code="200">Все норм</response>
        /// <response code="401">Неавторизован</response>
        [HttpGet("test")]
        [Authorize]
        public Task<string> Test() {
            return Task.FromResult("Some text test");
        }
    }
}
