namespace AccountingVoucherSystem.Models.DTOs.Responses
{
    public class VoucherDetailResponse
    {
        public int Id { get; set; }
        public int VoucherId { get; set; }
        public string VoucherNumber { get; set; }
        public string AccountCode { get; set; }
        public string AccountName { get; set; }
        public string Description { get; set; }
        public decimal Amount { get; set; }
        public int TransactionTypeId { get; set; }
        public string TransactionTypeName { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
