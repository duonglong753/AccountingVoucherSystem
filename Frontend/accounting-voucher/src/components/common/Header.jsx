import React from "react";
import styles from "../../styles/Header.module.css";
import { Link } from "react-router-dom";

const Header = () => {
  return (
    <header className={styles.header}>
      <div className={styles.logo}>📄 Voucher System</div>
      <nav className={styles.nav}>
        <Link to="/" className={styles.link}>
          Danh sách
        </Link>
        <Link to="/create" className={styles.link}>
          Tạo mới
        </Link>
      </nav>
    </header>
  );
};

export default Header;
