import { useParams, useNavigate } from 'react-router-dom';
import { EVENTS } from 'shared/api/mocks';
import { Newsletter } from 'widgets/newsletter';
import { IMAGES } from 'shared/config/images';
import { useState } from 'react';
import { useToast } from 'shared/lib/toast';
export const EventPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const toast = useToast();
  const event = EVENTS.find(e => e.id === Number(id)) || EVENTS[0];
  const [form, setForm] = useState({ name: '', email: '', phone: '' });
  const submit = (e) => { e.preventDefault(); if (!form.name || !form.email.includes('@')) { toast('Fill all fields'); return; } toast('✓ Registered!'); };
  return (
    <div className="pageFadeIn">
      <section style={{ padding: '60px 0', background: '#FEDCD9', textAlign: 'center' }}>
        <div className="section-eyebrow">Online lecture</div>
        <h1 className="section-title" style={{ maxWidth: 900, margin: '0 auto' }}>{event.title}</h1>
      </section>
      <div className="container" style={{ padding: '40px 15px', display: 'grid', gridTemplateColumns: '1fr 380px', gap: 60 }}>
        <div>
          <h2 style={{ fontSize: 28, fontWeight: 900, marginBottom: 24 }}>We will talk about:</h2>
          {[1,2,3,4].map(n => (
            <div key={n} style={{ marginBottom: 20 }}>
              <div style={{ fontWeight: 700, marginBottom: 8 }}><span style={{ color: '#FF3F3A' }}>{n === 1 ? '—' : '+'}</span> Theme {n}. Aliquet lectus urna viverra in odio.</div>
              {n === 1 && <p style={{ color: '#787A80', fontSize: 14, paddingLeft: 24 }}>Nulla amet, sagittis potenti rhoncus sit. Elit lectus nec pulvinar aliquet donec enim, ornare. Lacus facilisi curabitur turpis varius mauris.</p>}
            </div>
          ))}
          <h3 style={{ fontSize: 20, fontWeight: 900, marginTop: 40, marginBottom: 12 }}>Speaker</h3>
          <div style={{ display: 'grid', gridTemplateColumns: '200px 1fr', gap: 24, alignItems: 'center', marginBottom: 40 }}>
            <img src={IMAGES.team6} alt="Speaker" style={{ borderRadius: 8 }} />
            <div>
              <div style={{ fontWeight: 900, fontSize: 20, marginBottom: 8 }}>Kathryn Murphy</div>
              <div style={{ fontSize: 14, color: '#787A80', marginBottom: 12 }}>Analyst and Marketing specialist in IT company</div>
              <p style={{ fontSize: 14, color: '#787A80', lineHeight: 1.7 }}>Mattis adipiscing aliquam eu proin metus a iaculis faucibus. Tempus curabitur venenatis.</p>
            </div>
          </div>
        </div>
        <aside>
          <div style={{ border: '1px solid #E5E8ED', borderRadius: 8, padding: 32, position: 'sticky', top: 120 }}>
            <div style={{ marginBottom: 20 }}>
              <div style={{ fontSize: 12, fontWeight: 700, color: '#787A80', textTransform: 'uppercase' }}>Time</div>
              <div style={{ color: '#FF3F3A', fontWeight: 700 }}>{event.month} {event.day}, {event.time}</div>
            </div>
            <div style={{ marginBottom: 24 }}>
              <div style={{ fontSize: 12, fontWeight: 700, color: '#787A80', textTransform: 'uppercase' }}>Price</div>
              <div style={{ fontSize: 32, fontWeight: 900 }}>Free</div>
            </div>
            <button className="btn btn-primary btn-full" onClick={() => { toast('✓ Registered!'); }}>Join the event</button>
          </div>
        </aside>
      </div>
      <section style={{ padding: '60px 0' }}>
        <div className="container">
          <div className="section-eyebrow">Don't miss the event</div>
          <h2 className="section-title" style={{ marginBottom: 32 }}>Leave a request</h2>
          <form onSubmit={submit} style={{ maxWidth: 500, display: 'flex', flexDirection: 'column', gap: 16 }}>
            <input className="input" placeholder="Full Name" value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} />
            <input className="input" placeholder="Email" type="email" value={form.email} onChange={(e) => setForm({ ...form, email: e.target.value })} />
            <input className="input" placeholder="Phone" value={form.phone} onChange={(e) => setForm({ ...form, phone: e.target.value })} />
            <button className="btn btn-primary" type="submit">Join the event</button>
          </form>
        </div>
      </section>
      <Newsletter />
    </div>
  );
};
