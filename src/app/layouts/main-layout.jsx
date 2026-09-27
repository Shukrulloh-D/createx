import { useState } from 'react';
import { Outlet, useLocation } from 'react-router-dom';
import { Header } from '../../widgets/header';
import { Footer } from '../../widgets/footer';
import { AuthModals } from '../../widgets/auth-modals';
export const MainLayout = () => {
  const [authOpen, setAuthOpen] = useState(false);
  const [authMode, setAuthMode] = useState('login');
  const openAuth = (mode) => { setAuthMode(mode); setAuthOpen(true); };
  return (
    <div>
      <Header onOpenAuth={openAuth} />
      <main><Outlet /></main>
      <Footer />
      <AuthModals isOpen={authOpen} mode={authMode} onClose={() => setAuthOpen(false)} onSwitch={(m) => setAuthMode(m)} />
    </div>
  );
};
