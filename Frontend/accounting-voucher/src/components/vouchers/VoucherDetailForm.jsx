import React, { useEffect, useState } from "react";
import styles from "../../styles/VoucherDetailForm.module.css";
import api from "../../services/api";

const VoucherDetailForm = ({ detail, onChange, onRemove }) => {
  const [transactionTypes, setTransactionTypes] = useState([]);
  const [accounts, setAccounts] = useState([]);

  useEffect(() => {
    fetchLookups();
  }, []);

  const fetchLookups = async () => {
    try {
      const [ttRes, accRes] = await Promise.all([
        api.get("/lookups/transaction-types"),
        api.get("/lookups/accounts"),
      ]);
      setTransactionTypes(ttRes.data);
      setAccounts(accRes.data);
    } catch (error) {
      console.error("Failed to load lookup data", error);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    onChange({ ...detail, [name]: value });
  };

  return (
    <div className={styles.detailRow}>
      <select
        name="accountCode"
        value={detail.accountCode}
        onChange={handleChange}
        required
      >
        <option value="">-- Tài khoản --</option>
        {accounts.map((a) => (
          <option key={a.id} value={a.id}>
            {a.description}
          </option>
        ))}
      </select>

      <input
        type="text"
        name="description"
        value={detail.description}
        onChange={handleChange}
        placeholder="Diễn giải"
      />

      <input
        type="number"
        name="amount"
        value={detail.amount}
        onChange={handleChange}
        placeholder="Số tiền"
        min="0.01"
        step="0.01"
        required
      />

      <select
        name="transactionTypeId"
        value={detail.transactionTypeId}
        onChange={handleChange}
        required
      >
        <option value="">-- Loại giao dịch --</option>
        {transactionTypes.map((tt) => (
          <option key={tt.id} value={tt.id}>
            {tt.name}
          </option>
        ))}
      </select>

      <button type="button" onClick={onRemove} className={styles.removeBtn}>
        X
      </button>
    </div>
  );
};

export default VoucherDetailForm;
