using System;
using System.Collections.Generic;

namespace AccountingVoucherSystem.Models;

public partial class Vouchertype
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual ICollection<Voucher> Vouchers { get; set; } = new List<Voucher>();
}
