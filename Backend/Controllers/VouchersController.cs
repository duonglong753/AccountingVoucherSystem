using Microsoft.AspNetCore.Mvc;
using AccountingVoucherSystem.Models.DTOs.Requests;
using AccountingVoucherSystem.Models.DTOs.Responses;
using AccountingVoucherSystem.Services.Interfaces;
using System.ComponentModel.DataAnnotations;

namespace AccountingVoucherSystem.Controllers
{
    [ApiController]
    [Route("api/vouchers")]
    public class VouchersController : ControllerBase
    {
        private readonly IVoucherService _voucherService;
        private readonly ILogger<VouchersController> _logger;

        public VouchersController(IVoucherService voucherService, ILogger<VouchersController> logger)
        {
            _voucherService = voucherService;
            _logger = logger;
        }

        [HttpPost]
        public async Task<ActionResult<int>> CreateVoucher([FromBody] CreateVoucherRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var voucherId = await _voucherService.CreateVoucher(request);
                return CreatedAtAction(nameof(GetVoucherById), new { id = voucherId }, voucherId);
            }
            catch (ApplicationException ex)
            {
                _logger.LogWarning(ex, "Business logic error creating voucher");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error creating voucher");
                return StatusCode(500, new { message = "An unexpected error occurred" });
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateVoucher(int id, [FromBody] UpdateVoucherRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                await _voucherService.UpdateVoucher(id, request);
                return NoContent();
            }
            catch (ApplicationException ex)
            {
                _logger.LogWarning(ex, "Business logic error updating voucher {VoucherId}", id);
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error updating voucher {VoucherId}", id);
                return StatusCode(500, new { message = "An unexpected error occurred" });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteVoucher(int id)
        {
            try
            {
                await _voucherService.DeleteVoucher(id);
                return NoContent();
            }
            catch (ApplicationException ex)
            {
                _logger.LogWarning(ex, "Business logic error deleting voucher {VoucherId}", id);
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error deleting voucher {VoucherId}", id);
                return StatusCode(500, new { message = "An unexpected error occurred" });
            }
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<VoucherResponse>> GetVoucherById(int id)
        {
            try
            {
                var voucher = await _voucherService.GetVoucherById(id);
                return Ok(voucher);
            }
            catch (KeyNotFoundException)
            {
                return NotFound(new { message = $"Voucher with ID {id} not found" });
            }
            catch (ApplicationException ex)
            {
                _logger.LogWarning(ex, "Business logic error retrieving voucher {VoucherId}", id);
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error retrieving voucher {VoucherId}", id);
                return StatusCode(500, new { message = "An unexpected error occurred" });
            }
        }

        [HttpGet]
        public async Task<ActionResult<PagedResponse<VoucherSummaryResponse>>> GetVouchers([FromQuery] SearchVouchersRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var result = await _voucherService.GetVouchers(request);
                return Ok(result);
            }
            catch (ApplicationException ex)
            {
                _logger.LogWarning(ex, "Business logic error searching vouchers");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error searching vouchers");
                return StatusCode(500, new { message = "An unexpected error occurred" });
            }
        }
    }
}