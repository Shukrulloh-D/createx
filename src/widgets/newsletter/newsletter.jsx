import { useState } from 'react';
import { useToast } from 'shared/lib/toast';
export const Newsletter = () => {
  const toast = useToast();
  const [email, setEmail] = useState('');
  const submit = (e) => { e.preventDefault(); if (!email.includes('@')) { toast('Enter a valid email'); return; } toast('Subscribed!'); setEmail(''); };
  return (
    <section style={{ background: '#FEDCD9', padding: '60px 20px', textAlign: 'center', marginTop: 80 }}>
      <div className="section-eyebrow">Do not miss anything</div>
      <h2 style={{ fontSize: 46, fontWeight: 900, maxWidth: 810, margin: '0 auto 32px', lineHeight: 1.15 }}>Subscribe to the Createx School announcements</h2>
      <form onSubmit={submit} style={{ display: 'flex', gap: 12, maxWidth: 600, margin: '0 auto' }}>
        <input type="email" placeholder="Your working email" value={email} onChange={(e) => setEmail(e.target.value)} style={{ flex: 1, padding: '14px 16px', border: '1px solid rgba(255,63,58,0.3)', borderRadius: 4, fontSize: 14, outline: 'none' }} />
        <button type="submit" style={{ padding: '14px 28px', background: '#FF3F3A', color: 'white', borderRadius: 4, fontWeight: 700, fontSize: 14, textTransform: 'uppercase', cursor: 'pointer', border: 'none' }}>Subscribe</button>
      </form>
    </section>
  );
};
