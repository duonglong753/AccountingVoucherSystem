using System;
using System.Collections.Generic;
using AccountingVoucherSystem.Models;
using AccountingVoucherSystem.Services.Implementations;
using Microsoft.EntityFrameworkCore;
using Pomelo.EntityFrameworkCore.MySql.Scaffolding.Internal;

namespace AccountingVoucherSystem.Data;

public partial class AccountingDbContext : DbContext
{
    public AccountingDbContext()
    {
    }

    public AccountingDbContext(DbContextOptions<AccountingDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Account> Accounts { get; set; }

    public virtual DbSet<Transactiontype> Transactiontypes { get; set; }

    public virtual DbSet<Voucher> Vouchers { get; set; }

    public virtual DbSet<Voucherdetail> Voucherdetails { get; set; }

    public virtual DbSet<Vouchertype> Vouchertypes { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseMySql("server=localhost;database=AccountingVoucherSystem;user=root;password=1234", Microsoft.EntityFrameworkCore.ServerVersion.Parse("8.0.42-mysql"));

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .UseCollation("utf8mb4_0900_ai_ci")
            .HasCharSet("utf8mb4");

        modelBuilder.Entity<Account>(entity =>
        {
            entity.HasKey(e => e.Code).HasName("PRIMARY");

            entity.ToTable("accounts");

            entity.Property(e => e.Code).HasMaxLength(20);
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("datetime");
            entity.Property(e => e.IsActive).HasDefaultValueSql("'1'");
            entity.Property(e => e.Name).HasMaxLength(100);
        });

        modelBuilder.Entity<Transactiontype>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("transactiontypes");

            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("datetime");
            entity.Property(e => e.Description).HasMaxLength(255);
            entity.Property(e => e.Name).HasMaxLength(100);
        });

        modelBuilder.Entity<Voucher>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("vouchers");

            entity.HasIndex(e => e.VoucherNumber, "VoucherNumber").IsUnique();

            entity.HasIndex(e => e.VoucherTypeId, "VoucherTypeId");

            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("datetime");
            entity.Property(e => e.Description).HasMaxLength(255);
            entity.Property(e => e.TotalAmount).HasPrecision(18, 2);
            entity.Property(e => e.VoucherDate).HasColumnType("datetime");
            entity.Property(e => e.VoucherNumber).HasMaxLength(20);

            entity.HasOne(d => d.VoucherType).WithMany(p => p.Vouchers)
                .HasForeignKey(d => d.VoucherTypeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("vouchers_ibfk_1");
        });

        modelBuilder.Entity<Voucherdetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("voucherdetails");

            entity.HasIndex(e => e.AccountCode, "AccountCode");

            entity.HasIndex(e => e.TransactionTypeId, "TransactionTypeId");

            entity.HasIndex(e => e.VoucherId, "VoucherId");

            entity.Property(e => e.AccountCode).HasMaxLength(20);
            entity.Property(e => e.Amount).HasPrecision(18, 2);
            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("datetime");
            entity.Property(e => e.Description).HasMaxLength(255);

            entity.HasOne(d => d.AccountCodeNavigation).WithMany(p => p.Voucherdetails)
                .HasForeignKey(d => d.AccountCode)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("voucherdetails_ibfk_2");

            entity.HasOne(d => d.TransactionType).WithMany(p => p.Voucherdetails)
                .HasForeignKey(d => d.TransactionTypeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("voucherdetails_ibfk_3");

            entity.HasOne(d => d.Voucher).WithMany(p => p.Voucherdetails)
                .HasForeignKey(d => d.VoucherId)
                .HasConstraintName("voucherdetails_ibfk_1");
        });

        modelBuilder.Entity<Vouchertype>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("vouchertypes");

            entity.Property(e => e.CreatedAt)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("datetime");
            entity.Property(e => e.Description).HasMaxLength(255);
            entity.Property(e => e.Name).HasMaxLength(100);
        });
        modelBuilder.Entity<VoucherIdResult>().HasNoKey();

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
