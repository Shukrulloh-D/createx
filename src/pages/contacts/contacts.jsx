import { useState } from 'react';
import { Newsletter } from 'widgets/newsletter';
import { IMAGES } from 'shared/config/images';
import { useToast } from 'shared/lib/toast';
export const ContactsPage = () => {
  const toast = useToast();
  const [form, setForm] = useState({ firstName: '', lastName: '', email: '', phone: '', message: '' });
  const submit = (e) => { e.preventDefault(); if (!form.firstName || !form.email.includes('@')) { toast('Fill required fields'); return; } toast('✓ Message sent!'); setForm({ firstName: '', lastName: '', email: '', phone: '', message: '' }); };
  return (
    <div className="pageFadeIn">
      <section style={{ padding: '60px 0', background: '#FEDCD9', textAlign: 'center' }}>
        <div className="section-eyebrow">Contact info</div>
        <h1 className="section-title">Get in touch</h1>
      </section>
      <div className="container" style={{ padding: '40px 15px', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 60 }}>
        <div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 20, marginBottom: 40 }}>
            <div><div style={{ fontSize: 12, color: '#787A80', fontWeight: 700, textTransform: 'uppercase' }}>Talk to us</div><div style={{ color: '#FF3F3A', fontWeight: 700 }}>hello@createx.com</div></div>
            <div><div style={{ fontSize: 12, color: '#787A80', fontWeight: 700, textTransform: 'uppercase' }}>Call us</div><div style={{ color: '#FF3F3A', fontWeight: 700 }}>(405) 555-0128</div></div>
            <div><div style={{ fontSize: 12, color: '#787A80', fontWeight: 700, textTransform: 'uppercase' }}>Address</div><div>2464 Royal Ln. Mesa, New Jersey 45463, USA</div></div>
          </div>
          <div style={{ display: 'flex', gap: 16, marginBottom: 40 }}>{['f','t','in','ig','yt'].map(s => <a key={s} href="/" style={{ color: '#787A80' }}>{s}</a>)}</div>
          <img src={IMAGES.mapImage} alt="Map" style={{ width: '100%', borderRadius: 8 }} />
        </div>
        <div>
          <h2 style={{ fontSize: 28, fontWeight: 900, marginBottom: 24 }}>Drop us a line</h2>
          <form onSubmit={submit} style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 16 }}>
              <input className="input" placeholder="First Name*" value={form.firstName} onChange={(e) => setForm({ ...form, firstName: e.target.value })} />
              <input className="input" placeholder="Last Name*" value={form.lastName} onChange={(e) => setForm({ ...form, lastName: e.target.value })} />
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 16 }}>
              <input className="input" type="email" placeholder="Email*" value={form.email} onChange={(e) => setForm({ ...form, email: e.target.value })} />
              <input className="input" placeholder="Phone" value={form.phone} onChange={(e) => setForm({ ...form, phone: e.target.value })} />
            </div>
            <textarea className="input" placeholder="Message" rows={5} value={form.message} onChange={(e) => setForm({ ...form, message: e.target.value })} />
            <label style={{ display: 'flex', gap: 8, fontSize: 13 }}><input type="checkbox" /> I agree to receive communications from Createx Online School</label>
            <button className="btn btn-primary" type="submit" style={{ width: 'fit-content' }}>Send message</button>
          </form>
        </div>
      </div>
      <Newsletter />
    </div>
  );
};
