using AccountingVoucherSystem.Models.DTOs.Responses;

namespace AccountingVoucherSystem.Services.Interfaces
{
    public interface ILookupService
    {
        Task<List<LookupItem>> GetVoucherTypes();
        Task<List<LookupItem>> GetTransactionTypes();
        Task<bool> ValidateAccount(string accountCode);
    }
}
