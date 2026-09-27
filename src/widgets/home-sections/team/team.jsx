import { useState } from 'react';
import { TEAM } from 'shared/api/mocks';
export const Team = () => {
  const [page, setPage] = useState(0);
  const perPage = 4;
  const totalPages = Math.ceil(TEAM.length / perPage);
  const visible = TEAM.slice(page * perPage, page * perPage + perPage);
  return (
    <section style={{ padding: '80px 0', background: '#F4F5F6' }}>
      <div className="container" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', flexWrap: 'wrap', gap: 16, marginBottom: 40 }}>
        <div>
          <div className="section-eyebrow">Best tutors are all here</div>
          <h2 className="section-title">Meet our team</h2>
        </div>
        <div style={{ display: 'flex', gap: 8 }}>
          <button onClick={() => setPage(Math.max(0, page - 1))} style={{ width: 44, height: 44, borderRadius: '50%', fontSize: 18, cursor: 'pointer' }}>LEFT</button>
          <button onClick={() => setPage((page + 1) % totalPages)} style={{ width: 44, height: 44, borderRadius: '50%', fontSize: 18, background: '#FF3F3A', color: 'white', cursor: 'pointer' }}>RIGHT</button>
        </div>
      </div>
      <div className="container" style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: 24 }}>
        {visible.map(t => (
          <div key={t.id} className="hoverLift" style={{ cursor: 'pointer' }}>
            <div style={{ borderRadius: 8, overflow: 'hidden', marginBottom: 16 }}>
              <img src={t.image} alt={t.name} style={{ width: '100%' }} />
            </div>
            <div style={{ fontWeight: 700 }}>{t.name}</div>
            <div style={{ fontSize: 13, color: '#787A80' }}>{t.role}</div>
          </div>
        ))}
      </div>
    </section>
  );
};
