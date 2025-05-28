using System.ComponentModel.DataAnnotations;

namespace AccountingVoucherSystem.Models.DTOs.Requests
{
    public class CreateVoucherRequest
    {
        [Required]
        [StringLength(20)]
        public string VoucherNumber { get; set; }

        [Required]
        public DateTime VoucherDate { get; set; }

        [Required]
        public int VoucherTypeId { get; set; }

        [StringLength(255)]
        public string Description { get; set; }

        public List<CreateVoucherDetailRequest> VoucherDetails { get; set; } = new();
    }
}
