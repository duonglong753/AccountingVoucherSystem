namespace AccountingVoucherSystem.Models.DTOs.Responses
{
    public record VoucherValidationResult(
    int VoucherId,
    bool IsTotalValid,
    bool AreDatesValid
    //List<VoucherDetailValidation> InvalidDetails
    );
}
