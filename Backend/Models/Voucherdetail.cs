using System;
using System.Collections.Generic;

namespace AccountingVoucherSystem.Models;

public partial class Voucherdetail
{
    public int Id { get; set; }

    public int VoucherId { get; set; }

    public string AccountCode { get; set; } = null!;

    public string? Description { get; set; }

    public decimal Amount { get; set; }

    public int TransactionTypeId { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual Account AccountCodeNavigation { get; set; } = null!;

    public virtual Transactiontype TransactionType { get; set; } = null!;

    public virtual Voucher Voucher { get; set; } = null!;
}
