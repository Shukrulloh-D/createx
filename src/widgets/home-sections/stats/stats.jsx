import { STATS } from 'shared/api/mocks';
export const Stats = () => (
  <section style={{ padding: '40px 0 80px' }}>
    <div className="container" style={{ display: 'flex', justifyContent: 'space-around', flexWrap: 'wrap', gap: 30 }}>
      {STATS.map((s, i) => (
        <div key={i} style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <span style={{ fontSize: 46, fontWeight: 900, lineHeight: 1 }}>{s.number}</span>
          <span style={{ fontSize: 14, color: '#787A80' }}>{s.label}</span>
        </div>
      ))}
    </div>
  </section>
);
