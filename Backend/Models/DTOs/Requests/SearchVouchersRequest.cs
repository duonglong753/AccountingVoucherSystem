namespace AccountingVoucherSystem.Models.DTOs.Requests
{
    public class SearchVouchersRequest
    {
        public string? VoucherNumber { get; set; }
        public int? VoucherTypeId { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public int PageNumber { get; set; } = 1;
        public int PageSize { get; set; } = 10;
    }
}
