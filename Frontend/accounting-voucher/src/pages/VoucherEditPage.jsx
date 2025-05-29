import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api from "../services/api";
import styles from "../styles/VoucherEditPage.module.css";
import VoucherForm from "../components/vouchers/VoucherForm";
import VoucherDetailForm from "../components/vouchers/VoucherDetailForm";

const VoucherEditPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    voucherNumber: "",
    voucherDate: "",
    voucherTypeId: "",
    description: "",
  });
  const [details, setDetails] = useState([]);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    fetchVoucher();
  }, [id]);

  const fetchVoucher = async () => {
    try {
      const res = await api.get(`/vouchers/${id}`);
      const {
        voucherNumber,
        voucherDate,
        voucherTypeId,
        description,
        voucherDetails,
      } = res.data;
      setFormData({
        voucherNumber,
        voucherDate: voucherDate.slice(0, 10),
        voucherTypeId,
        description,
      });
      setDetails(voucherDetails);
    } catch (err) {
      console.error("Lỗi tải dữ liệu chứng từ", err);
      alert("Không tìm thấy chứng từ");
      navigate("/");
    } finally {
      setLoading(false);
    }
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
      await api.put(`/api/vouchers/${id}`, formData);
      for (const d of details) {
        if (d.id) {
          await api.put(`/api/voucher-details/${d.id}`, d);
        }
        // else {
        //   await api.post(`/api/vouchers/${id}/voucherDetails`, d);
        // }
      }
      alert("Cập nhật chứng từ thành công");
      navigate("/");
    } catch (err) {
      console.error("Lỗi cập nhật chứng từ", err);
      alert("Có lỗi xảy ra");
    } finally {
      setSubmitting(false);
    }
  };

  if (loading) return <p>Đang tải dữ liệu...</p>;

  return (
    <div className={styles.pageContainer}>
      <form onSubmit={handleSubmit} className={styles.voucherFormWrapper}>
        <VoucherForm formData={formData} onChange={setFormData} mode="edit" />

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
        </div>

        <div className={styles.submitSection}>
          <button
            type="submit"
            disabled={submitting}
            className={styles.submitBtn}
          >
            {submitting ? "Đang lưu..." : "Lưu thay đổi"}
          </button>
        </div>
      </form>
    </div>
  );
};

export default VoucherEditPage;
