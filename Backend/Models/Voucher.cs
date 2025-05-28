using System;
using System.Collections.Generic;

namespace AccountingVoucherSystem.Models;

public partial class Voucher
{
    public int Id { get; set; }

    public string VoucherNumber { get; set; } = null!;

    public DateTime VoucherDate { get; set; }

    public int VoucherTypeId { get; set; }

    public string? Description { get; set; }

    public decimal TotalAmount { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual Vouchertype VoucherType { get; set; } = null!;

    public virtual ICollection<Voucherdetail> Voucherdetails { get; set; } = new List<Voucherdetail>();
}
