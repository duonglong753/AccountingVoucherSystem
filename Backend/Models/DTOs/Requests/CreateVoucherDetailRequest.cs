using System.ComponentModel.DataAnnotations;

namespace AccountingVoucherSystem.Models.DTOs.Requests
{
    public class CreateVoucherDetailRequest
    {
        [Required]
        [StringLength(20)]
        public string AccountCode { get; set; }

        [StringLength(255)]
        public string Description { get; set; }

        [Required]
        [Range(0.01, double.MaxValue)]
        public decimal Amount { get; set; }

        [Required]
        public int TransactionTypeId { get; set; }
    }
}
