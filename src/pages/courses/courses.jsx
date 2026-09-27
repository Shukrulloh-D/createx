import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { CourseCard } from '../../entities/course';
import { COURSES, CATEGORIES } from 'shared/api/mocks';
import { Newsletter } from 'widgets/newsletter';
import { SearchIcon } from 'shared/ui/icon';
export const CoursesPage = () => {
  const navigate = useNavigate();
  const [cat, setCat] = useState('All');
  const [q, setQ] = useState('');
  const [visible, setVisible] = useState(6);
  const filtered = COURSES.filter(c => (cat === 'All' || c.category === cat) && c.title.toLowerCase().includes(q.toLowerCase()));
  return (
    <div className="pageFadeIn">
      <section style={{ padding: '60px 0', background: '#FEDCD9', textAlign: 'center' }}>
        <div className="section-eyebrow">Enjoy your studying!</div>
        <h1 className="section-title">Our online courses</h1>
      </section>
      <div className="container" style={{ padding: '40px 15px' }}>
        <div style={{ display: 'flex', gap: 12, marginBottom: 32, flexWrap: 'wrap', alignItems: 'center' }}>
          {CATEGORIES.map(c => (
            <button key={c} onClick={() => setCat(c)} style={{ padding: '8px 16px', border: '1px solid', borderRadius: 4, fontSize: 13, fontWeight: 700, background: cat === c ? '#FF3F3A' : 'transparent', color: cat === c ? 'white' : '#1E212C', borderColor: cat === c ? '#FF3F3A' : '#E5E8ED' }}>{c}</button>
          ))}
          <div style={{ marginLeft: 'auto', position: 'relative' }}>
            <span style={{ position: 'absolute', left: 12, top: '50%', transform: 'translateY(-50%)', color: '#787A80' }}><SearchIcon /></span>
            <input className="input" placeholder="Search course..." value={q} onChange={(e) => setQ(e.target.value)} style={{ paddingLeft: 40, width: 260 }} />
          </div>
        </div>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 24 }}>
          {filtered.slice(0, visible).map(c => <CourseCard key={c.id} course={c} onClick={() => navigate(`/courses/${c.id}`)} />)}
        </div>
        {filtered.length === 0 && <p style={{ textAlign: 'center', padding: 40, color: '#787A80' }}>No courses found</p>}
        {visible < filtered.length && <div style={{ textAlign: 'center', marginTop: 40 }}><button className="btn btn-ghost" onClick={() => setVisible(v => v + 3)}>Load more ↓</button></div>}
      </div>
      <Newsletter />
    </div>
  );
};
