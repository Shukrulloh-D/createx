import { TESTIMONIAL } from 'shared/api/mocks';
export const Testimonials = () => (
  <section style={{ padding: '80px 0' }}>
    <div style={{ maxWidth: 1230, margin: '0 auto 40px', padding: '0 15px', textAlign: 'center' }}>
      <div className="section-eyebrow">Testimonials</div>
      <h2 className="section-title">What our students say</h2>
    </div>
    <div style={{ maxWidth: 1020, margin: '0 auto', padding: '40px 60px', background: 'white', borderRadius: 8, boxShadow: '0 20px 60px rgba(30,33,44,0.1)', position: 'relative' }}>
      <p style={{ fontSize: 24, lineHeight: 1.5, marginBottom: 24, paddingLeft: 40, position: 'relative' }}>
        <span style={{ position: 'absolute', left: 0, top: -10, fontSize: 60, color: '#FF3F3A', fontFamily: 'Georgia, serif', lineHeight: 1 }}>"</span>
        {TESTIMONIAL.text}
      </p>
      <div style={{ display: 'flex', gap: 16, alignItems: 'center', paddingLeft: 40 }}>
        <img src={TESTIMONIAL.avatar} alt={TESTIMONIAL.author} style={{ width: 60, height: 60, borderRadius: '50%' }} />
        <div><div style={{ fontWeight: 700 }}>{TESTIMONIAL.author}</div><div style={{ fontSize: 13, color: '#787A80' }}>{TESTIMONIAL.role}</div></div>
      </div>
    </div>
  </section>
);
