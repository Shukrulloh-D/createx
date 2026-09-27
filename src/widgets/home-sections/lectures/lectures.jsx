import { useNavigate } from 'react-router-dom';
import { EVENTS } from 'shared/api/mocks';
export const Lectures = () => {
  const navigate = useNavigate();
  return (
    <section style={{ padding: '80px 0', background: '#FEDCD9' }}>
      <div style={{ maxWidth: 1230, margin: '0 auto 40px', padding: '0 15px', textAlign: 'center' }}>
        <div className="section-eyebrow">Our events</div>
        <h2 className="section-title">Lectures & workshops</h2>
      </div>
      <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', background: 'white', borderRadius: 8 }}>
        {EVENTS.slice(0, 3).map(e => (
          <div key={e.id} style={{ display: 'grid', gridTemplateColumns: '80px 200px 1fr auto', gap: 24, alignItems: 'center', padding: '24px 32px', borderBottom: '1px solid #E5E8ED' }}>
            <div><div style={{ fontSize: 32, fontWeight: 900, color: '#FF3F3A', lineHeight: 1 }}>{e.day}</div><div style={{ fontSize: 12, color: '#787A80', fontWeight: 700, textTransform: 'uppercase' }}>{e.month}</div></div>
            <div><div style={{ fontSize: 14, fontWeight: 700 }}>{e.time}</div><div style={{ fontSize: 13, color: '#787A80' }}>{e.type}</div></div>
            <div style={{ fontWeight: 700 }}>{e.title}</div>
            <button className="btn btn-outline" onClick={() => navigate(`/events/${e.id}`)}>View more</button>
          </div>
        ))}
      </div>
      <div style={{ textAlign: 'center', marginTop: 40 }}>
        <button className="btn btn-primary" onClick={() => navigate('/events')}>Explore all events</button>
      </div>
    </section>
  );
};
