import { useEffect } from 'react';
const ov = { position: 'fixed', inset: 0, background: 'rgba(30,33,44,0.6)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, padding: 20, animation: 'fadeIn 0.2s' };
const ct = { background: 'white', padding: 32, borderRadius: 8, maxWidth: 480, width: '100%', maxHeight: '90vh', overflowY: 'auto', position: 'relative', animation: 'fadeInScale 0.3s' };
const cl = { position: 'absolute', top: 16, right: 16, width: 32, height: 32, borderRadius: '50%', fontSize: 18, color: '#787A80' };
export const Modal = ({ isOpen, onClose, children }) => {
  useEffect(() => {
    const onEsc = (e) => { if (e.key === 'Escape') onClose(); };
    if (isOpen) document.addEventListener('keydown', onEsc);
    return () => document.removeEventListener('keydown', onEsc);
  }, [isOpen, onClose]);
  if (!isOpen) return null;
  return <div style={ov} onClick={onClose}><div style={ct} onClick={(e) => e.stopPropagation()}><button style={cl} onClick={onClose}>✕</button>{children}</div></div>;
};
