using Microsoft.AspNetCore.Mvc;
using AccountingVoucherSystem.Models.DTOs.Responses;
using AccountingVoucherSystem.Services.Interfaces;

namespace AccountingVoucherSystem.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LookupsController : ControllerBase
    {
        private readonly ILookupService _lookupService;
        private readonly ILogger<LookupsController> _logger;

        public LookupsController(ILookupService lookupService, ILogger<LookupsController> logger)
        {
            _lookupService = lookupService;
            _logger = logger;
        }

        [HttpGet("voucher-types")]
        public async Task<ActionResult<List<LookupItem>>> GetVoucherTypes()
        {
            try
            {
                var voucherTypes = await _lookupService.GetVoucherTypes();
                return Ok(voucherTypes);
            }
            catch (ApplicationException ex)
            {
                _logger.LogWarning(ex, "Error retrieving voucher types");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error retrieving voucher types");
                return StatusCode(500, new { message = "An unexpected error occurred" });
            }
        }

        [HttpGet("transaction-types")]
        public async Task<ActionResult<List<LookupItem>>> GetTransactionTypes()
        {
            try
            {
                var transactionTypes = await _lookupService.GetTransactionTypes();
                return Ok(transactionTypes);
            }
            catch (ApplicationException ex)
            {
                _logger.LogWarning(ex, "Error retrieving transaction types");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error retrieving transaction types");
                return StatusCode(500, new { message = "An unexpected error occurred" });
            }
        }

        [HttpGet("accounts/{accountCode}/validate")]
        public async Task<ActionResult<bool>> ValidateAccount(string accountCode)
        {
            if (string.IsNullOrWhiteSpace(accountCode))
            {
                return BadRequest(new { message = "Account code is required" });
            }

            try
            {
                var isValid = await _lookupService.ValidateAccount(accountCode);
                return Ok(new { accountCode, isValid });
            }
            catch (ApplicationException ex)
            {
                _logger.LogWarning(ex, "Error validating account {AccountCode}", accountCode);
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error validating account {AccountCode}", accountCode);
                return StatusCode(500, new { message = "An unexpected error occurred" });
            }
        }
    }
}