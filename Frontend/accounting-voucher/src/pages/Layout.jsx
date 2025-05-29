import React from "react";
import Header from "../components/common/Header";
import Sidebar from "../components/common/Sidebar";
import styles from "../styles/Layout.module.css";

const Layout = ({ children }) => {
  return (
    <div className={styles.wrapper}>
      <Header />
      <div className={styles.body}>
        <Sidebar />
        <main className={styles.mainContent}>{children}</main>
      </div>
    </div>
  );
};

export default Layout;
