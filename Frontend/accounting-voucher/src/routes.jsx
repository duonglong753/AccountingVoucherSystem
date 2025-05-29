import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import VoucherListPage from './pages/VoucherListPage';
import VoucherCreatePage from './pages/VoucherCreatePage';
import VoucherEditPage from './pages/VoucherEditPage';
import Layout from './pages/Layout';

const AppRoutes = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Layout><VoucherListPage /></Layout>} />
        <Route path="/create" element={<Layout><VoucherCreatePage /></Layout>} />
        <Route path="/edit/:id" element={<Layout><VoucherEditPage /></Layout>} />
      </Routes>
    </Router>
  );
};

export default AppRoutes;
