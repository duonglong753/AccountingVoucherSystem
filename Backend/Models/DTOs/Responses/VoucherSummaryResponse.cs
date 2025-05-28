namespace AccountingVoucherSystem.Models.DTOs.Responses
{
    public class VoucherSummaryResponse
    {
        public int Id { get; set; }
        public string VoucherNumber { get; set; }
        public DateTime VoucherDate { get; set; }
        public int VoucherTypeId { get; set; }
        public string VoucherTypeName { get; set; }
        public string Description { get; set; }
        public decimal TotalAmount { get; set; }
        public int DetailCount { get; set; }
        public DateTime CreatedAt { get; set; }
    }

}
