import { useNavigate } from 'react-router-dom';
import { IMAGES } from 'shared/config/images';
export const Hero = () => {
  const navigate = useNavigate();
  return (
    <section style={{ background: 'linear-gradient(135deg, #FEDCD9 0%, #FFF0EE 100%)', padding: '80px 0 100px' }}>
      <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'grid', gridTemplateColumns: '1.2fr 1fr', gap: 40, alignItems: 'center' }}>
        <div>
          <div style={{ display: 'inline-flex', alignItems: 'center', gap: 12, marginBottom: 24, fontSize: 14, fontWeight: 700 }}>
            <span style={{ width: 52, height: 52, borderRadius: '50%', background: '#FF3F3A', color: 'white', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>▶</span>
            Play showreel
          </div>
          <h1 style={{ fontSize: 64, fontWeight: 900, lineHeight: 1.05, letterSpacing: '-2px', marginBottom: 24 }}>Enjoy studying with Createx <span style={{ color: '#FF3F3A' }}>Online Courses</span></h1>
          <div style={{ display: 'flex', gap: 16, marginTop: 32 }}>
            <button className="btn btn-outline" onClick={() => navigate('/about')}>About us</button>
            <button className="btn btn-primary" onClick={() => navigate('/courses')}>Explore courses</button>
          </div>
        </div>
        <img src={IMAGES.heroIllustration} alt="Hero" style={{ width: '100%' }} />
      </div>
    </section>
  );
};
