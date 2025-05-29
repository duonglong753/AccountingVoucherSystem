namespace AccountingVoucherSystem.Models.DTOs.Responses
{
    public record AccountValidationResult(
    bool IsValid,
    string AccountCode,
    string AccountName,
    bool IsActive,
    decimal CurrentBalance
    );
}
