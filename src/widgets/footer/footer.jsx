import { Link } from 'react-router-dom';
import { useState } from 'react';
import { useToast } from '../../shared/lib/toast';
const fs = { background: '#1E212C', color: 'rgba(255,255,255,0.7)', marginTop: 80 };
const topStyle = { maxWidth: 1230, margin: '0 auto', padding: '60px 15px', display: 'grid', gridTemplateColumns: '1.5fr 1fr 1fr 1fr 1.5fr', gap: 40 };
const colH = { color: 'white', fontSize: 14, fontWeight: 700, marginBottom: 16, textTransform: 'uppercase', letterSpacing: '0.5px' };
const linkStyle = { display: 'block', fontSize: 14, padding: '6px 0', color: 'rgba(255,255,255,0.7)' };
export const Footer = () => {
  const toast = useToast();
  const [email, setEmail] = useState('');
  const subscribe = (e) => { e.preventDefault(); if (!email.includes('@')) { toast('Enter a valid email'); return; } toast('✓ Subscribed!'); setEmail(''); };
  return (
    <footer style={fs}>
      <div style={topStyle}>
        <div>
          <div style={{ fontFamily: 'Lato', color: 'white', fontSize: 22, fontWeight: 900, marginBottom: 16 }}>CREATE<span style={{ color: '#FF3F3A' }}>X</span></div>
          <p style={{ fontSize: 13, lineHeight: 1.6, marginBottom: 20 }}>Createx Online School is a leader in online studying. We have lots of courses from market experts.</p>
          <div style={{ display: 'flex', gap: 16 }}>{['f','t','in','ig','yt','tg'].map(s => <a key={s} href="/" style={{ color: 'rgba(255,255,255,0.6)', fontSize: 14 }}>{s}</a>)}</div>
        </div>
        <div>
          <h4 style={colH}>Site Map</h4>
          <Link to="/about" style={linkStyle}>About Us</Link>
          <Link to="/courses" style={linkStyle}>Courses</Link>
          <Link to="/events" style={linkStyle}>Events</Link>
          <Link to="/blog" style={linkStyle}>Blog</Link>
          <Link to="/contacts" style={linkStyle}>Contacts</Link>
        </div>
        <div>
          <h4 style={colH}>Courses</h4>
          {['Marketing','Management','HR & Recruiting','Design','Development'].map(c => <Link key={c} to="/courses" style={linkStyle}>{c}</Link>)}
        </div>
        <div>
          <h4 style={colH}>Contacts</h4>
          <a href="tel:4055550128" style={linkStyle}>(405) 555-0128</a>
          <a href="mailto:hello@createx.com" style={linkStyle}>hello@createx.com</a>
        </div>
        <div>
          <h4 style={colH}>Newsletter</h4>
          <form onSubmit={subscribe} style={{ display: 'flex', gap: 8 }}>
            <input type="email" placeholder="Email address" value={email} onChange={(e) => setEmail(e.target.value)} style={{ flex: 1, padding: '10px 12px', background: 'rgba(255,255,255,0.08)', border: '1px solid rgba(255,255,255,0.15)', borderRadius: 4, color: 'white', fontSize: 13, outline: 'none' }} />
            <button type="submit" style={{ padding: '10px 16px', background: '#FF3F3A', color: 'white', borderRadius: 4, fontWeight: 700, fontSize: 13 }}>→</button>
          </form>
        </div>
      </div>
      <div style={{ borderTop: '1px solid rgba(255,255,255,0.08)', padding: 20, textAlign: 'center', fontSize: 13, opacity: 0.6 }}>© All rights reserved. Made with ♥ by Createx Studio</div>
    </footer>
  );
};
