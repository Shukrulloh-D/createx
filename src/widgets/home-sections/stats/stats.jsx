import { STATS } from 'shared/api/mocks';
export const Stats = () => (
  <section style={{ padding: '40px 0 80px' }}>
    <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'flex', justifyContent: 'space-around', flexWrap: 'wrap', gap: 30 }}>
      {STATS.map((s, i) => (
        <div key={i} style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <span style={{ fontSize: 46, fontWeight: 900, lineHeight: 1 }}>{s.number}</span>
          <span style={{ fontSize: 14, color: '#787A80' }}>{s.label}</span>
        </div>
      ))}
    </div>
  </section>
);
