import React from "react";
import { Link, useLocation } from "react-router-dom";
import styles from "../../styles/Sidebar.module.css";

const Sidebar = () => {
  const location = useLocation();

  return (
    <aside className={styles.sidebar}>
      <div className={styles.menuTitle}>📁 Menu</div>
      <ul className={styles.menuList}>
        <li>
          <Link
            to="/"
            className={location.pathname === "/" ? styles.active : styles.link}
          >
            Danh sách chứng từ
          </Link>
        </li>
        <li>
          <Link
            to="/create"
            className={
              location.pathname === "/create" ? styles.active : styles.link
            }
          >
            Tạo chứng từ mới
          </Link>
        </li>
      </ul>
    </aside>
  );
};

export default Sidebar;
