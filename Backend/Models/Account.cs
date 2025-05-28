using System;
using System.Collections.Generic;

namespace AccountingVoucherSystem.Models;

public partial class Account
{
    public string Code { get; set; } = null!;

    public string Name { get; set; } = null!;

    public bool? IsActive { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual ICollection<Voucherdetail> Voucherdetails { get; set; } = new List<Voucherdetail>();
}
