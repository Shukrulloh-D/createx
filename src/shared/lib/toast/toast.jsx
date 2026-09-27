import { createContext, useContext, useState, useCallback } from 'react';
const Ctx = createContext();
export const ToastProvider = ({ children }) => {
  const [toasts, setToasts] = useState([]);
  const toast = useCallback((msg) => { const id = Date.now(); setToasts(p => [...p, { id, msg }]); setTimeout(() => setToasts(p => p.filter(t => t.id !== id)), 2500); }, []);
  return <Ctx.Provider value={toast}>{children}{toasts.map(t => <div key={t.id} className="toast">{t.msg}</div>)}</Ctx.Provider>;
};
export const useToast = () => useContext(Ctx);
