using AccountingVoucherSystem.Models.DTOs.Requests;
using AccountingVoucherSystem.Models.DTOs.Responses;

namespace AccountingVoucherSystem.Services.Interfaces
{
    public interface IVoucherService
    {
        Task<int> CreateVoucher(CreateVoucherRequest request);
        Task UpdateVoucher(int id, UpdateVoucherRequest request);
        Task DeleteVoucher(int id);
        Task<VoucherResponse> GetVoucherById(int id);
        Task<PagedResponse<VoucherSummaryResponse>> GetVouchers(SearchVouchersRequest request);

        Task<int> AddVoucherDetail(int voucherId, CreateVoucherDetailRequest request);
        Task UpdateVoucherDetail(int id, UpdateVoucherDetailRequest request);
        Task DeleteVoucherDetail(int id);
        Task<List<VoucherDetailResponse>> GetVoucherDetails(int voucherId);

        /*Task<bool> ValidateVoucherTotal(int voucherId);
        Task<bool> ValidateVoucherDates(DateTime startDate, DateTime endDate);*/
    }
}
