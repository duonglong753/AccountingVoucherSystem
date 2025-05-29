using AccountingVoucherSystem.Data;
using AccountingVoucherSystem.Models.DTOs.Responses;
using AccountingVoucherSystem.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using MySqlConnector;
using System.Data;

namespace AccountingVoucherSystem.Services.Implementations
{
    public class LookupService : ILookupService
    {
        private readonly AccountingDbContext _context;
        private readonly ILogger<LookupService> _logger;

        public LookupService(AccountingDbContext context, ILogger<LookupService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task<List<LookupItem>> GetVoucherTypes()
        {
            try
            {
                var voucherTypes = await _context.Database.SqlQueryRaw<LookupItem>("CALL sp_GetVoucherTypes()").ToListAsync();

                _logger.LogInformation("Retrieved {Count} voucher types", voucherTypes.Count);
                return voucherTypes;
            }
            catch (MySqlException ex)
            {
                _logger.LogError(ex, "Error retrieving voucher types");
                throw new ApplicationException("Error retrieving voucher types");
            }
        }

        public async Task<List<LookupItem>> GetTransactionTypes()
        {
            try
            {
                var transactionTypes = await _context.Database.SqlQueryRaw<LookupItem>("CALL sp_GetTransactionTypes()").ToListAsync();

                _logger.LogInformation("Retrieved {Count} transaction types", transactionTypes.Count);
                return transactionTypes;
            }
            catch (MySqlException ex)
            {
                _logger.LogError(ex, "Error retrieving transaction types");
                throw new ApplicationException("Error retrieving transaction types");
            }
        }

        public async Task<bool> ValidateAccount(string accountCode)
        {
            try
            {
                var isValidParam = new MySqlParameter("@p_IsValid", MySqlDbType.Bit)
                {
                    Direction = ParameterDirection.Output
                };

                await _context.Database.ExecuteSqlRawAsync(
                    "CALL sp_Account_Validate(@p_AccountCode, @p_IsValid)",
                    new MySqlParameter("@p_AccountCode", accountCode),
                    isValidParam);

                var isValid = Convert.ToBoolean(isValidParam.Value);
                _logger.LogInformation("Account validation for {AccountCode}: {IsValid}", accountCode, isValid);
                return isValid;
            }
            catch (MySqlException ex)
            {
                _logger.LogError(ex, "Error validating account with code: {AccountCode}", accountCode);
                throw new ApplicationException($"Error validating account: {accountCode}");
            }
        }
    }
}