import { useState } from 'react';
import { IMAGES } from 'shared/config/images';
const TABS = [
  { key: 'exp', label: 'Experienced Tutors', title: 'Only practicing tutors', text: 'Urna nisi, arcu lacus eget volutpat rhoncus cras nunc viverra. Eget sit eget mus nibh ultrices vitae in tincidunt.' },
  { key: 'fb', label: 'Feedback & Support', title: '24/7 support', text: 'Ut posuere diam id lorem facilisis in nulla tincidunt. Viverra justo, vitae tincidunt turpis eget vel morbi pulvinar vitae.' },
  { key: 'lib', label: '24/7 Online Library', title: 'Accessible library', text: 'Tristique ut dictum urna, lorem aliquam ullamcorper id. Erat erat faucibus volutpat enim non.' },
  { key: 'com', label: 'Community', title: 'Join our community', text: 'Porta ultricies et, nec et magna varius tellus tortor. Nunc, egestas consectetur ut tincidunt nibh.' },
];
export const Approach = () => {
  const [active, setActive] = useState('exp');
  const tab = TABS.find(t => t.key === active);
  return (
    <section style={{ padding: '80px 0' }}>
      <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 80, alignItems: 'center' }}>
        <div>
          <div className="section-eyebrow">Our benefits</div>
          <h2 className="section-title" style={{ marginBottom: 24 }}>That's how we do it</h2>
          <div style={{ display: 'flex', gap: 8, marginBottom: 32, flexWrap: 'wrap' }}>
            {TABS.map(t => (
              <button key={t.key} onClick={() => setActive(t.key)} style={{ padding: '8px 16px', borderRadius: 4, fontSize: 13, fontWeight: 700, border: '1px solid', background: active === t.key ? '#FF3F3A' : 'transparent', color: active === t.key ? 'white' : '#1E212C', borderColor: active === t.key ? '#FF3F3A' : '#E5E8ED' }}>{t.label}</button>
            ))}
          </div>
          <h3 style={{ fontSize: 32, fontWeight: 900, marginBottom: 16 }}>{tab.title}</h3>
          <p style={{ fontSize: 15, color: '#787A80', lineHeight: 1.7 }}>{tab.text}</p>
        </div>
        <img src={IMAGES.approachIllustration} alt="Approach" style={{ width: '100%' }} />
      </div>
    </section>
  );
};
