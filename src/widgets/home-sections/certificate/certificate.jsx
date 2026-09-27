import { IMAGES } from 'shared/config/images';
export const Certificate = () => (
  <section style={{ padding: '80px 0' }}>
    <div className="container" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 80, alignItems: 'center' }}>
      <div>
        <div className="section-eyebrow">Createx Certificate</div>
        <h2 className="section-title" style={{ marginBottom: 24 }}>Your expertise will be confirmed</h2>
        <p style={{ fontSize: 15, color: '#787A80', marginBottom: 24 }}>We are accredited by international professional organizations and institutes:</p>
        <div style={{ display: 'flex', gap: 24, opacity: 0.7 }}>
          <span style={{ fontSize: 13, fontWeight: 700 }}>Del Mar Strategy</span>
          <span style={{ fontSize: 13, fontWeight: 700 }}>Sentinal Consulting</span>
          <span style={{ fontSize: 13, fontWeight: 700 }}>National</span>
        </div>
      </div>
      <img src={IMAGES.certificate} alt="Certificate" style={{ borderRadius: 8, boxShadow: '0 20px 60px rgba(30,33,44,0.15)' }} />
    </div>
  </section>
);
