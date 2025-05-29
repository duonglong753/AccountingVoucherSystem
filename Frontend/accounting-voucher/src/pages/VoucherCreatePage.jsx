import React, { useState } from "react";
import styles from "../styles/VoucherCreatePage.module.css";
import api from "../services/api";
import VoucherForm from "../components/vouchers/VoucherForm";
import VoucherDetailForm from "../components/vouchers/VoucherDetailForm";
import { useNavigate } from "react-router-dom";

const VoucherCreatePage = () => {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    voucherNumber: "",
    voucherDate: "",
    voucherTypeId: "",
    description: "",
  });

  const [details, setDetails] = useState([]);
  const [submitting, setSubmitting] = useState(false);

  const addDetail = () => {
    setDetails([
      ...details,
      {
        accountCode: "",
        description: "",
        amount: "",
        transactionTypeId: "",
      },
    ]);
  };

  const updateDetail = (index, newDetail) => {
    const updated = [...details];
    updated[index] = newDetail;
    setDetails(updated);
  };

  const removeDetail = (index) => {
    const updated = details.filter((_, i) => i !== index);
    setDetails(updated);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSubmitting(true);
    try {
      const payload = {
        ...formData,
        voucherDetails: details,
      };
      await api.post("/vouchers", payload);
      alert("Tạo chứng từ thành công");
      navigate("/");
    } catch (err) {
      console.error("Lỗi khi tạo chứng từ", err);
      alert("Có lỗi xảy ra");
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className={styles.pageContainer}>
      <form onSubmit={handleSubmit} className={styles.voucherFormWrapper}>
        <VoucherForm formData={formData} onChange={setFormData} />

        <div className={styles.detailsSection}>
          <h4>Chi tiết chứng từ</h4>
          {details.map((detail, index) => (
            <VoucherDetailForm
              key={index}
              detail={detail}
              onChange={(newDetail) => updateDetail(index, newDetail)}
              onRemove={() => removeDetail(index)}
            />
          ))}

          <button
            type="button"
            onClick={addDetail}
            className={styles.addDetailBtn}
          >
            + Thêm dòng
          </button>
        </div>

        <div className={styles.submitSection}>
          <button
            type="submit"
            disabled={submitting}
            className={styles.submitBtn}
          >
            {submitting ? "Đang lưu..." : "Lưu chứng từ"}
          </button>
        </div>
      </form>
    </div>
  );
};

export default VoucherCreatePage;
