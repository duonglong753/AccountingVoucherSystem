import React, { useEffect, useState } from "react";
import styles from "../styles/VoucherListPage.module.css";
import api from "../services/api";
import dayjs from "dayjs";

const VoucherListPage = () => {
  const [vouchers, setVouchers] = useState([]);
  const [loading, setLoading] = useState(false);
  const [voucherTypes, setVoucherTypes] = useState([]);
  const [search, setSearch] = useState({
    voucherNumber: "",
    voucherTypeId: "",
    startDate: "",
    endDate: "",
  });
  const [pagination, setPagination] = useState({
    pageNumber: 1,
    pageSize: 10,
    totalCount: 0,
  });

  useEffect(() => {
    fetchVoucherTypes();
    fetchVouchers();
  }, [pagination.pageNumber]);

  const fetchVoucherTypes = async () => {
    try {
      const res = await api.get("/lookups/voucher-types");
      setVoucherTypes(res.data);
    } catch (err) {
      console.error("Failed to fetch voucher types", err);
    }
  };

  const fetchVouchers = async () => {
    setLoading(true);
    try {
      const res = await api.get("/vouchers", {
        params: {
          ...search,
          pageNumber: pagination.pageNumber,
          pageSize: pagination.pageSize,
        },
      });
      setVouchers(res.data.items);
      setPagination((prev) => ({ ...prev, totalCount: res.data.totalCount }));
    } catch (err) {
      console.error("Failed to fetch vouchers", err);
    } finally {
      setLoading(false);
    }
  };

  const handleSearchChange = (e) => {
    setSearch({ ...search, [e.target.name]: e.target.value });
  };

  const handleSearchSubmit = (e) => {
    e.preventDefault();
    setPagination({ ...pagination, pageNumber: 1 });
    fetchVouchers();
  };

  return (
    <div className={styles.container}>
      <h2 className={styles.title}>Danh sách chứng từ</h2>

      <form className={styles.searchForm} onSubmit={handleSearchSubmit}>
        <input
          type="text"
          name="voucherNumber"
          placeholder="Số chứng từ"
          value={search.voucherNumber}
          onChange={handleSearchChange}
        />
        <select
          name="voucherTypeId"
          value={search.voucherTypeId}
          onChange={handleSearchChange}
        >
          <option value="">-- Loại chứng từ --</option>
          {voucherTypes.map((type) => (
            <option key={type.id} value={type.id}>
              {type.name}
            </option>
          ))}
        </select>
        <input
          type="date"
          name="startDate"
          value={search.startDate}
          onChange={handleSearchChange}
        />
        <input
          type="date"
          name="endDate"
          value={search.endDate}
          onChange={handleSearchChange}
        />
        <button type="submit">Tìm kiếm</button>
      </form>

      {loading ? (
        <p>Đang tải dữ liệu...</p>
      ) : (
        <table className={styles.voucherTable}>
          <thead>
            <tr>
              <th>Số chứng từ</th>
              <th>Ngày chứng từ</th>
              <th>Loại</th>
              <th>Diễn giải</th>
              <th>Tổng tiền</th>
              <th>Ngày tạo</th>
            </tr>
          </thead>
          <tbody>
            {vouchers.map((v) => (
              <tr key={v.id}>
                <td>{v.voucherNumber}</td>
                <td>{dayjs(v.voucherDate).format("DD/MM/YYYY")}</td>
                <td>{v.voucherTypeName}</td>
                <td>{v.description}</td>
                <td>{v.totalAmount.toLocaleString()}</td>
                <td>{dayjs(v.createdAt).format("DD/MM/YYYY HH:mm")}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}

      <div className={styles.pagination}>
        <button
          disabled={pagination.pageNumber <= 1}
          onClick={() =>
            setPagination((prev) => ({
              ...prev,
              pageNumber: prev.pageNumber - 1,
            }))
          }
        >
          Trước
        </button>
        <span>
          Trang {pagination.pageNumber} /{" "}
          {Math.ceil(pagination.totalCount / pagination.pageSize)}
        </span>
        <button
          disabled={
            pagination.pageNumber >=
            Math.ceil(pagination.totalCount / pagination.pageSize)
          }
          onClick={() =>
            setPagination((prev) => ({
              ...prev,
              pageNumber: prev.pageNumber + 1,
            }))
          }
        >
          Sau
        </button>
      </div>
    </div>
  );
};

export default VoucherListPage;
