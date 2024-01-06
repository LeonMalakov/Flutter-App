using Casino.Dto;
using Casino.Services;
using Casino.Utility;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Threading.Tasks;

namespace Casino.Controllers {
    [ApiController]
    [Authorize]
    [Route("app")]
    public sealed class AppController : ControllerBase {
        private readonly IAppService _appService;

        public AppController(IAppService appService) {
            _appService = appService;
        }

        /// <summary>
        /// Возвращает данные айтемов.
        /// </summary>
        /// <returns>Результат</returns>
        /// <remarks>
        /// </remarks>
        /// <response code="200">Все норм</response>
        /// <response code="401">Неавторизован</response>
        [HttpGet("get_items")]
        [Authorize]
        public async Task<IActionResult> GetItems([FromQuery] GetItemsRequest request) {
            if(!ArraySerializationUtility.TryDeserialize(request.ItemIds!, out int[] itemIds)) {
                return BadRequest("");
            }

            var items = await _appService.GetItems(itemIds);
            string json = JsonSerialization.Serialize(items);

            return Ok(json);
        }

        [HttpGet("get_item_id_page")]
        [Authorize]
        public async Task<IActionResult> GetItemIdPage([FromQuery] GetItemIdPageRequest request) {
            var ids = await _appService.GetItemIdPage(request.StartIndex, request.Count);
            string idsStr = ArraySerializationUtility.Serialize(ids);
            return Ok(idsStr);
        }

        [HttpGet("get_favorites")]
        [Authorize]
        public async Task<IActionResult> GetFavorites() {
            if(!ControllerUtility.GetAuthTokenInfo(HttpContext, out _, out int userId)) {
                return Unauthorized();
            }

            var ids = await _appService.GetFavorites(userId);
            string idsStr = ArraySerializationUtility.Serialize(ids);
            return Ok(idsStr);
        }

        [HttpPost("set_favorite")]
        [Authorize]
        public async Task<IActionResult> SetFavorite([FromBody] SetFavoriteRequest request) {
            if (!ControllerUtility.GetAuthTokenInfo(HttpContext, out _, out int userId)) {
                return Unauthorized();
            }

            bool result = await _appService.SetFavorite(userId, request.ItemId, request.IsFavorite);

            if (!result) {
                return BadRequest();
            }
            return Ok();
        }



    }
}
