import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { EventCard } from 'entities/event';
import { EVENTS } from 'shared/api/mocks';
import { Newsletter } from 'widgets/newsletter';
import { SearchIcon } from 'shared/ui/icon';
export const EventsPage = () => {
  const navigate = useNavigate();
  const [type, setType] = useState('all');
  const [q, setQ] = useState('');
  const [view, setView] = useState('grid');
  const filtered = EVENTS.filter(e => (type === 'all' || e.type.toLowerCase().includes(type)) && e.title.toLowerCase().includes(q.toLowerCase()));
  return (
    <div className="pageFadeIn">
      <section style={{ padding: '60px 0', background: '#FEDCD9', textAlign: 'center' }}>
        <div className="section-eyebrow">Our events</div>
        <h1 className="section-title">Lectures, workshops & master-classes</h1>
      </section>
      <div className="container" style={{ padding: '40px 15px' }}>
        <div style={{ display: 'flex', gap: 16, flexWrap: 'wrap', alignItems: 'center', marginBottom: 32 }}>
          <select value={type} onChange={(e) => setType(e.target.value)} className="input" style={{ width: 200 }}>
            <option value="all">All events</option>
            <option value="lecture">Online lecture</option>
            <option value="master">Master-class</option>
            <option value="workshop">Workshop</option>
          </select>
          <select className="input" style={{ width: 200 }}><option>Sort by newest</option><option>Sort by oldest</option></select>
          <div style={{ marginLeft: 'auto', display: 'flex', gap: 12, alignItems: 'center' }}>
            <div style={{ position: 'relative' }}>
              <span style={{ position: 'absolute', left: 12, top: '50%', transform: 'translateY(-50%)', color: '#787A80' }}><SearchIcon /></span>
              <input className="input" placeholder="Search event..." value={q} onChange={(e) => setQ(e.target.value)} style={{ paddingLeft: 40, width: 260 }} />
            </div>
            <button onClick={() => setView('grid')} style={{ padding: 10, background: view === 'grid' ? '#FF3F3A' : 'transparent', color: view === 'grid' ? 'white' : '#1E212C', borderRadius: 4 }}>⊞</button>
            <button onClick={() => setView('list')} style={{ padding: 10, background: view === 'list' ? '#FF3F3A' : 'transparent', color: view === 'list' ? 'white' : '#1E212C', borderRadius: 4 }}>☰</button>
          </div>
        </div>
        {view === 'grid' ? (
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 24 }}>
            {filtered.map(e => <EventCard key={e.id} event={e} onClick={() => navigate(`/events/${e.id}`)} />)}
          </div>
        ) : (
          <div>
            {filtered.map(e => (
              <div key={e.id} style={{ display: 'grid', gridTemplateColumns: '80px 200px 1fr auto', gap: 24, alignItems: 'center', padding: '20px 24px', borderBottom: '1px solid #E5E8ED' }}>
                <div><div style={{ fontSize: 28, fontWeight: 900, color: '#FF3F3A', lineHeight: 1 }}>{e.day}</div><div style={{ fontSize: 12, color: '#787A80' }}>{e.month}</div></div>
                <div><div style={{ fontWeight: 700 }}>{e.time}</div><div style={{ fontSize: 13, color: '#787A80' }}>{e.type}</div></div>
                <div>{e.title}</div>
                <button className="btn btn-outline" onClick={() => navigate(`/events/${e.id}`)}>View more</button>
              </div>
            ))}
          </div>
        )}
      </div>
      <Newsletter />
    </div>
  );
};
