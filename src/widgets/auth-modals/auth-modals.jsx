import { useState } from 'react';
import { useAuth } from '../../shared/lib/auth';
import { useToast } from '../../shared/lib/toast';
import { Modal } from '../../shared/ui/modal';
const inputStyle = { padding: '12px 16px', border: '1px solid #E5E8ED', borderRadius: 4, fontSize: 14, outline: 'none', width: '100%' };
export const AuthModals = ({ isOpen, mode, onClose, onSwitch }) => {
  const { login } = useAuth();
  const toast = useToast();
  const [email, setEmail] = useState('');
  const [pwd, setPwd] = useState('');
  const [name, setName] = useState('');
  const submit = (e) => {
    e.preventDefault();
    if (!email.includes('@')) { toast('Enter valid email'); return; }
    if (pwd.length < 4) { toast('Password too short'); return; }
    if (mode === 'signup' && !name.trim()) { toast('Enter your name'); return; }
    login(email);
    toast(mode === 'login' ? 'Signed in!' : 'Account created!');
    onClose();
  };
  if (!isOpen) return null;
  const isLogin = mode === 'login';
  return (
    <Modal isOpen={isOpen} onClose={onClose}>
      <h2 style={{ fontSize: 24, fontWeight: 900, marginBottom: 8, textAlign: 'center' }}>{isLogin ? 'Sign In' : 'Sign Up'}</h2>
      <p style={{ fontSize: 13, color: '#787A80', textAlign: 'center', marginBottom: 24 }}>{isLogin ? 'Sign in to access your account' : 'Registration takes less than a minute'}</p>
      <form onSubmit={submit} style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
        {!isLogin && <input style={inputStyle} placeholder="Full Name" value={name} onChange={(e) => setName(e.target.value)} />}
        <input style={inputStyle} placeholder="Email" type="email" value={email} onChange={(e) => setEmail(e.target.value)} />
        <input style={inputStyle} placeholder="Password" type="password" value={pwd} onChange={(e) => setPwd(e.target.value)} />
        <button type="submit" className="btn btn-primary btn-full">{isLogin ? 'Sign In' : 'Sign Up'}</button>
      </form>
      <div style={{ textAlign: 'center', marginTop: 16, fontSize: 13, color: '#787A80' }}>
        {isLogin ? "Don't have an account? " : 'Already have an account? '}
        <button onClick={() => onSwitch(isLogin ? 'signup' : 'login')} style={{ color: '#FF3F3A', fontWeight: 700, background: 'none', border: 'none', cursor: 'pointer' }}>{isLogin ? 'Sign up' : 'Sign in'}</button>
      </div>
    </Modal>
  );
};
