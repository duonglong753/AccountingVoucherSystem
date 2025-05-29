using AccountingVoucherSystem.Data;
using AccountingVoucherSystem.Models.DTOs.Requests;
using AccountingVoucherSystem.Models.DTOs.Responses;
using AccountingVoucherSystem.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using MySqlConnector;
using System.Data;

namespace AccountingVoucherSystem.Services.Implementations
{
    public class VoucherService : IVoucherService
    {
        private readonly AccountingDbContext _context;
        private readonly ILogger<VoucherService> _logger;

        public VoucherService(AccountingDbContext context, ILogger<VoucherService> logger)
        {
            _context = context;
            _logger = logger;
        }

        #region Voucher Methods

        public async Task<int> CreateVoucher(CreateVoucherRequest request)
        {
            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                            "CALL sp_Voucher_Create(@p_VoucherNumber, @p_VoucherDate, @p_VoucherTypeId, @p_Description)",
                            new MySqlParameter("@p_VoucherNumber", request.VoucherNumber),
                            new MySqlParameter("@p_VoucherDate", request.VoucherDate),
                            new MySqlParameter("@p_VoucherTypeId", request.VoucherTypeId),
                            new MySqlParameter("@p_Description", request.Description ?? string.Empty));

                var voucherIdResult = await _context.Database
                            .SqlQueryRaw<VoucherIdResult>("SELECT Id as VoucherId FROM Vouchers WHERE VoucherNumber = @voucherNumber ORDER BY Id DESC LIMIT 1",
                                new MySqlParameter("@voucherNumber", request.VoucherNumber))
                            .FirstOrDefaultAsync();

                var voucherId = voucherIdResult?.VoucherId ?? 0;

                if (voucherId == 0)
                {
                    throw new ApplicationException("Failed to create voucher");
                }

                // Add voucher details
                foreach (var detail in request.VoucherDetails)
                {
                    await AddVoucherDetail(voucherId, detail);
                }

                _logger.LogInformation("Voucher created successfully with ID: {VoucherId}", voucherId);
                return voucherId;
            }
            catch (MySqlException ex)
            {
                _logger.LogError(ex, "Error creating voucher with number: {VoucherNumber}", request.VoucherNumber);
                throw new ApplicationException(ex.Message);
            }
        }

        public async Task UpdateVoucher(int id, UpdateVoucherRequest request)
        {
            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "CALL sp_Voucher_Update(@p_VoucherId, @p_VoucherNumber, @p_VoucherDate, @p_VoucherTypeId, @p_Description)",
                    new MySqlParameter("@p_VoucherId", id),
                    new MySqlParameter("@p_VoucherNumber", request.VoucherNumber),
                    new MySqlParameter("@p_VoucherDate", request.VoucherDate),
                    new MySqlParameter("@p_VoucherTypeId", request.VoucherTypeId),
                    new MySqlParameter("@p_Description", request.Description ?? string.Empty));

                _logger.LogInformation("Voucher updated successfully with ID: {VoucherId}", id);
            }
            catch (MySqlException ex)
            {
                _logger.LogError(ex, "Error updating voucher with ID: {VoucherId}", id);
                throw new ApplicationException(ex.Message);
            }
        }

        public async Task DeleteVoucher(int id)
        {
            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "CALL sp_Voucher_Delete(@p_VoucherId)",
                    new MySqlParameter("@p_VoucherId", id));

                _logger.LogInformation("Voucher deleted successfully with ID: {VoucherId}", id);
            }
            catch (MySqlException ex)
            {
                _logger.LogError(ex, "Error deleting voucher with ID: {VoucherId}", id);
                throw new ApplicationException(ex.Message);
            }
        }

        public async Task<VoucherResponse> GetVoucherById(int id)
        {
            try
            {
                var vouchers = (await _context.Database.SqlQueryRaw<VoucherResponse>("CALL sp_Voucher_GetById({0})", id).ToListAsync());
                var voucher = vouchers.FirstOrDefault();
                if (voucher == null)
                {
                    throw new KeyNotFoundException($"Voucher with ID {id} not found");
                }

                //voucher.VoucherDetails = await GetVoucherDetails(id);
                return voucher;
            }
            catch (MySqlException ex)
            {
                _logger.LogError(ex, "Error retrieving voucher with ID: {VoucherId}", id);
                throw new ApplicationException(ex.Message);
            }
        }

        public async Task<PagedResponse<VoucherSummaryResponse>> GetVouchers(SearchVouchersRequest request)
        {
            try
            {
                var parameters = new List<MySqlParameter>
                {
                    new("@p_VoucherNumber", request.VoucherNumber ?? (object)DBNull.Value),
                    new("@p_VoucherTypeId", request.VoucherTypeId ?? (object)DBNull.Value),
                    new("@p_StartDate", request.StartDate ?? (object)DBNull.Value),
                    new("@p_EndDate", request.EndDate ?? (object)DBNull.Value),
                    new("@p_PageNumber", request.PageNumber),
                    new("@p_PageSize", request.PageSize)
                };

                var result = await _context.Database
                            .SqlQueryRaw<VoucherSummaryResponse>(
                                @"CALL sp_Voucher_GetAll(@p_VoucherNumber, @p_VoucherTypeId, @p_StartDate, @p_EndDate, @p_PageNumber, @p_PageSize)",
                                parameters.ToArray())
                            .ToListAsync();

                var totalCount = result.FirstOrDefault()?.TotalCount ?? 0;

                return new PagedResponse<VoucherSummaryResponse>
                {
                    Items = result,
                    TotalCount = totalCount,
                    PageNumber = request.PageNumber,
                    PageSize = request.PageSize   
                };
            }
            catch (MySqlException ex)
            {
                _logger.LogError(ex, "Error searching vouchers");
                throw new ApplicationException(ex.Message);
            }
        }

        #endregion

        #region Voucher Detail Methods

        public async Task<int> AddVoucherDetail(int voucherId, CreateVoucherDetailRequest request)
        {
            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "CALL sp_VoucherDetail_Create(@p_VoucherId, @p_AccountCode, @p_Description, @p_Amount, @p_TransactionTypeId)",
                    new MySqlParameter("@p_VoucherId", voucherId),
                    new MySqlParameter("@p_AccountCode", request.AccountCode),
                    new MySqlParameter("@p_Description", request.Description ?? string.Empty),
                    new MySqlParameter("@p_Amount", request.Amount),
                    new MySqlParameter("@p_TransactionTypeId", request.TransactionTypeId)
                    );
                var voucherDetailIdResult = await _context.Database
                            .SqlQueryRaw<VoucherIdResult>("SELECT Id as VoucherId FROM VoucherDetails WHERE VoucherId = @voucherId ORDER BY Id DESC LIMIT 1",
                                new MySqlParameter("@voucherId", voucherId))
                            .FirstOrDefaultAsync();

                var voucherDetailId = voucherDetailIdResult?.VoucherId ?? 0;

                if (voucherDetailId == 0)
                {
                    throw new ApplicationException("Failed to create voucher detail");
                }
                _logger.LogInformation("Voucher detail created successfully with ID: {VoucherDetailId} for Voucher ID: {VoucherId}", voucherDetailId, voucherId);
                return voucherDetailId;
            }
            catch (MySqlException ex)
            {
                _logger.LogError(ex, "Error creating voucher detail for Voucher ID: {VoucherId}", voucherId);
                throw new ApplicationException(ex.Message);
            }
        }

        public async Task UpdateVoucherDetail(int id, UpdateVoucherDetailRequest request)
        {
            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "CALL sp_VoucherDetail_Update(@p_VoucherDetailId, @p_AccountCode, @p_Description, @p_Amount, @p_TransactionTypeId)",
                    new MySqlParameter("@p_VoucherDetailId", id),
                    new MySqlParameter("@p_AccountCode", request.AccountCode),
                    new MySqlParameter("@p_Description", request.Description ?? string.Empty),
                    new MySqlParameter("@p_Amount", request.Amount),
                    new MySqlParameter("@p_TransactionTypeId", request.TransactionTypeId));

                _logger.LogInformation("Voucher detail updated successfully with ID: {VoucherDetailId}", id);
            }
            catch (MySqlException ex)
            {
                _logger.LogError(ex, "Error updating voucher detail with ID: {VoucherDetailId}", id);
                throw new ApplicationException(ex.Message);
            }
        }

        public async Task DeleteVoucherDetail(int id)
        {
            try
            {
                await _context.Database.ExecuteSqlRawAsync(
                    "CALL sp_VoucherDetail_Delete(@p_VoucherDetailId)",
                    new MySqlParameter("@p_VoucherDetailId", id));

                _logger.LogInformation("Voucher detail deleted successfully with ID: {VoucherDetailId}", id);
            }
            catch (MySqlException ex)
            {
                _logger.LogError(ex, "Error deleting voucher detail with ID: {VoucherDetailId}", id);
                throw new ApplicationException(ex.Message);
            }
        }

        public async Task<List<VoucherDetailResponse>> GetVoucherDetails(int voucherId)
        {
            try
            {
                var details = await _context.Set<VoucherDetailResponse>()
                    .FromSqlRaw("CALL sp_VoucherDetail_GetByVoucherId({0})", voucherId)
                    .ToListAsync();

                return details;
            }
            catch (MySqlException ex)
            {
                _logger.LogError(ex, "Error retrieving voucher details for Voucher ID: {VoucherId}", voucherId);
                throw new ApplicationException(ex.Message);
            }
        }

        #endregion
    }
    public class VoucherIdResult
    {
        public int VoucherId { get; set; }
    }
    public class VoucherDetailIdResult
    {
        public int VoucherDetailId { get; set; }
    }
}