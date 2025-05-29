import React, { useEffect, useState } from "react";
import styles from "../../styles/VoucherForm.module.css";
import api from "../../services/api";

const VoucherForm = ({ formData, onChange, mode = "create" }) => {
  const [voucherTypes, setVoucherTypes] = useState([]);

  useEffect(() => {
    fetchVoucherTypes();
  }, []);

  const fetchVoucherTypes = async () => {
    try {
      const res = await api.get("/lookups/voucher-types");
      setVoucherTypes(res.data);
    } catch (error) {
      console.error("Failed to load voucher types", error);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    onChange({ ...formData, [name]: value });
  };

  return (
    <div className={styles.formContainer}>
      <h3 className={styles.formTitle}>
        {mode === "create" ? "Tạo mới" : "Cập nhật"} chứng từ
      </h3>

      <div className={styles.formGroup}>
        <label className={styles.label}>Số chứng từ *</label>
        <input
          type="text"
          name="voucherNumber"
          value={formData.voucherNumber}
          onChange={handleChange}
          className={styles.input}
          required
        />
      </div>

      <div className={styles.formGroup}>
        <label className={styles.label}>Ngày chứng từ *</label>
        <input
          type="date"
          name="voucherDate"
          value={formData.voucherDate}
          onChange={handleChange}
          className={styles.input}
          required
        />
      </div>

      <div className={styles.formGroup}>
        <label className={styles.label}>Loại chứng từ *</label>
        <select
          name="voucherTypeId"
          value={formData.voucherTypeId}
          onChange={handleChange}
          className={styles.input}
          required
        >
          <option value="">-- Chọn loại chứng từ --</option>
          {voucherTypes.map((type) => (
            <option key={type.id} value={type.id}>
              {type.name}
            </option>
          ))}
        </select>
      </div>

      <div className={styles.formGroup}>
        <label className={styles.label}>Diễn giải</label>
        <textarea
          name="description"
          value={formData.description}
          onChange={handleChange}
          className={styles.textarea}
          rows="3"
        ></textarea>
      </div>
    </div>
  );
};

export default VoucherForm;
