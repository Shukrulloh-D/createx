import { useNavigate } from 'react-router-dom';
import { IMAGES } from 'shared/config/images';
const FEATURES = ['A fermentum in morbi pretium aliquam adipiscing donec tempus.','Vulputate placerat amet pulvinar lorem nisl.','Consequat feugiat habitant gravida quisque elit bibendum id adipiscing sed.','Etiam duis lobortis in fames ultrices commodo nibh.'];
export const Why = () => {
  const navigate = useNavigate();
  return (
    <section style={{ padding: '80px 0' }}>
      <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 80, alignItems: 'center' }}>
        <img src={IMAGES.whyImage} alt="Why" style={{ borderRadius: 8, width: '100%' }} />
        <div>
          <div className="section-eyebrow">Who we are</div>
          <h2 className="section-title" style={{ marginBottom: 24 }}>Why Createx?</h2>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 12, marginBottom: 32 }}>
            {FEATURES.map((f, i) => <div key={i} style={{ display: 'flex', gap: 10, fontSize: 15 }}><span style={{ color: '#FF3F3A', fontWeight: 900 }}>✓</span>{f}</div>)}
          </div>
          <button className="btn btn-primary" onClick={() => navigate('/about')}>More about us</button>
        </div>
      </div>
    </section>
  );
};
