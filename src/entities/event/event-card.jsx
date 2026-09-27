export const EventCard = ({ event, onClick }) => (
  <div onClick={onClick} className="hoverLift" style={{ background: 'white', border: '1px solid #E5E8ED', borderRadius: 8, padding: 24, cursor: 'pointer' }}>
    <div style={{ display: 'flex', alignItems: 'baseline', gap: 8, marginBottom: 12 }}>
      <span style={{ fontSize: 28, fontWeight: 900, color: '#FF3F3A', lineHeight: 1 }}>{event.day}</span>
      <span style={{ fontSize: 13, color: '#FF3F3A', fontWeight: 700 }}>{event.month}</span>
    </div>
    <div style={{ fontSize: 13, color: '#787A80', marginBottom: 16 }}>{event.time}</div>
    <div style={{ fontSize: 16, fontWeight: 700, lineHeight: 1.4, marginBottom: 8 }}>{event.title}</div>
    <div style={{ fontSize: 13, color: '#787A80', marginBottom: 20 }}>{event.type}</div>
    <button style={{ width: '100%', padding: 10, border: '1px solid #FF3F3A', color: '#FF3F3A', borderRadius: 4, fontWeight: 700, fontSize: 13, textTransform: 'uppercase' }}>View more</button>
  </div>
);
