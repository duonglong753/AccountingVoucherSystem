using Microsoft.AspNetCore.Mvc;
using AccountingVoucherSystem.Models.DTOs.Requests;
using AccountingVoucherSystem.Models.DTOs.Responses;
using AccountingVoucherSystem.Services.Interfaces;

namespace AccountingVoucherSystem.Controllers
{
    [ApiController]
    [Route("api/voucher-details")]
    public class VoucherDetailsController : ControllerBase
    {
        private readonly IVoucherService _voucherService;
        private readonly ILogger<VoucherDetailsController> _logger;

        public VoucherDetailsController(IVoucherService voucherService, ILogger<VoucherDetailsController> logger)
        {
            _voucherService = voucherService;
            _logger = logger;
        }

        /*[HttpPost]
        public async Task<ActionResult<int>> AddVoucherDetail(int voucherId, [FromBody] CreateVoucherDetailRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var detailId = await _voucherService.AddVoucherDetail(voucherId, request);
                return CreatedAtAction(nameof(GetVoucherDetails),
                    new { voucherId = voucherId },
                    new { id = detailId });
            }
            catch (ApplicationException ex)
            {
                _logger.LogWarning(ex, "Business logic error adding voucher detail to voucher {VoucherId}", voucherId);
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error adding voucher detail to voucher {VoucherId}", voucherId);
                return StatusCode(500, new { message = "An unexpected error occurred" });
            }
        }*/

        [HttpGet]
        public async Task<ActionResult<List<VoucherDetailResponse>>> GetVoucherDetails(int voucherId)
        {
            try
            {
                var details = await _voucherService.GetVoucherDetails(voucherId);
                return Ok(details);
            }
            catch (ApplicationException ex)
            {
                _logger.LogWarning(ex, "Business logic error retrieving voucher details for voucher {VoucherId}", voucherId);
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error retrieving voucher details for voucher {VoucherId}", voucherId);
                return StatusCode(500, new { message = "An unexpected error occurred" });
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateVoucherDetail(int id, [FromBody] UpdateVoucherDetailRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                await _voucherService.UpdateVoucherDetail(id, request);
                return NoContent();
            }
            catch (ApplicationException ex)
            {
                _logger.LogWarning(ex, "Business logic error updating voucher detail {DetailId}", id);
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error updating voucher detail {DetailId}", id);
                return StatusCode(500, new { message = "An unexpected error occurred" });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteVoucherDetail(int id)
        {
            try
            {
                await _voucherService.DeleteVoucherDetail(id);
                return NoContent();
            }
            catch (ApplicationException ex)
            {
                _logger.LogWarning(ex, "Business logic error deleting voucher detail {DetailId}", id);
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error deleting voucher detail {DetailId}", id);
                return StatusCode(500, new { message = "An unexpected error occurred" });
            }
        }
    }
}