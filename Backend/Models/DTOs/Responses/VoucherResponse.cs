namespace AccountingVoucherSystem.Models.DTOs.Responses
{
    public class VoucherResponse
    {
        public int Id { get; set; }
        public string VoucherNumber { get; set; }
        public DateTime VoucherDate { get; set; }
        public int VoucherTypeId { get; set; }
        public string VoucherTypeName { get; set; }
        public string Description { get; set; }
        public decimal TotalAmount { get; set; }
        public DateTime CreatedAt { get; set; }
        public List<VoucherDetailResponse> VoucherDetails { get; set; } = new();
    }
}
