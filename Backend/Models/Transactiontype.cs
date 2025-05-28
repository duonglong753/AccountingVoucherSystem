using System;
using System.Collections.Generic;

namespace AccountingVoucherSystem.Models;

public partial class Transactiontype
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual ICollection<Voucherdetail> Voucherdetails { get; set; } = new List<Voucherdetail>();
}
