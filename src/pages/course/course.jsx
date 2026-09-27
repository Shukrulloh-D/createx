import { useParams, useNavigate } from 'react-router-dom';
import { useState } from 'react';
import { COURSES } from 'shared/api/mocks';
import { Newsletter } from 'widgets/newsletter';
import { IMAGES } from 'shared/config/images';
import { useToast } from 'shared/lib/toast';
export const CoursePage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const toast = useToast();
  const course = COURSES.find(c => c.id === Number(id)) || COURSES[0];
  const [tab, setTab] = useState('about');
  const related = COURSES.filter(c => c.id !== course.id).slice(0, 2);
  return (
    <div className="pageFadeIn">
      <section style={{ padding: '60px 0', background: '#FEDCD9' }}>
        <div className="container">
          <div className="breadcrumbs"><span>Home</span> / <span>Courses</span> / <span>{course.category}</span></div>
          <div className="section-eyebrow" style={{ marginBottom: 8 }}>Course</div>
          <h1 className="section-title">{course.title}</h1>
        </div>
      </section>
      <div className="container" style={{ padding: '40px 15px', display: 'grid', gridTemplateColumns: '1fr 380px', gap: 60 }}>
        <div>
          <div style={{ display: 'flex', gap: 24, borderBottom: '1px solid #E5E8ED', marginBottom: 32 }}>
            {['about', 'program', 'reviews'].map(t => (
              <button key={t} onClick={() => setTab(t)} style={{ padding: '16px 0', fontWeight: 700, color: tab === t ? '#1E212C' : '#787A80', borderBottom: tab === t ? '2px solid #FF3F3A' : '2px solid transparent', textTransform: 'capitalize' }}>{t}</button>
            ))}
          </div>
          {tab === 'about' && (
            <div>
              <h2 style={{ fontSize: 28, fontWeight: 900, marginBottom: 16 }}>About the course</h2>
              <p style={{ color: '#787A80', lineHeight: 1.7, marginBottom: 24 }}>Bibendum vulputate adipiscing venenatis at est, ut tincidunt. Elementum nisl faucibus id leo turpis ac in malesuad consequat.</p>
              <h3 style={{ fontSize: 20, fontWeight: 900, marginBottom: 12 }}>You will learn:</h3>
              <ul style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
                {['A fermentum in morbi pretium aliquam adipiscing donec tempus.','Vulputate placerat amet pulvinar lorem nisl.','Consequat feugiat habitant gravida quisque elit bibendum.','Etiam duis lobortis in fames ultrices commodo nibh.'].map((t, i) => (
                  <li key={i} style={{ display: 'flex', gap: 10, fontSize: 15 }}><span style={{ color: '#FF3F3A' }}>✓</span>{t}</li>
                ))}
              </ul>
            </div>
          )}
          {tab === 'program' && (
            <div>
              <h2 style={{ fontSize: 28, fontWeight: 900, marginBottom: 16 }}>Course program</h2>
              {[1,2,3,4,5,6,7,8].map(n => (
                <div key={n} style={{ padding: '12px 0', borderBottom: '1px solid #E5E8ED', display: 'flex', gap: 12, alignItems: 'center' }}>
                  <span style={{ color: '#FF3F3A', fontWeight: 900 }}>+</span>
                  <div><div style={{ fontWeight: 700 }}>Lesson {n}. Aliquet lectus urna viverra in odio.</div></div>
                </div>
              ))}
            </div>
          )}
          {tab === 'reviews' && <p style={{ color: '#787A80' }}>No reviews yet.</p>}
        </div>
        <aside>
          <div style={{ border: '1px solid #E5E8ED', borderRadius: 8, padding: 32, position: 'sticky', top: 120 }}>
            <div style={{ marginBottom: 20 }}>
              <div style={{ fontSize: 12, fontWeight: 700, color: '#787A80', textTransform: 'uppercase' }}>Dates</div>
              <div style={{ color: '#FF3F3A', fontWeight: 700 }}>Sept 7 – Nov 2</div>
            </div>
            <div style={{ marginBottom: 20 }}>
              <div style={{ fontSize: 12, fontWeight: 700, color: '#787A80', textTransform: 'uppercase' }}>Duration</div>
              <div style={{ fontWeight: 700 }}>2 months – 8 lessons</div>
            </div>
            <div style={{ marginBottom: 24 }}>
              <div style={{ fontSize: 12, fontWeight: 700, color: '#787A80', textTransform: 'uppercase' }}>Price</div>
              <div style={{ fontSize: 32, fontWeight: 900, color: '#FF3F3A' }}>${course.price} <span style={{ fontSize: 14, color: '#787A80', fontWeight: 400 }}>per month</span></div>
            </div>
            <button className="btn btn-primary btn-full" onClick={() => { toast('✓ Enrolled!'); navigate('/contacts'); }}>Join the course</button>
          </div>
        </aside>
      </div>
      <section style={{ padding: '60px 0', background: '#F4F5F6' }}>
        <div className="container">
          <div className="section-eyebrow">Check other courses</div>
          <h2 className="section-title" style={{ marginBottom: 32 }}>You may also like</h2>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 24 }}>
            {related.map(c => (
              <div key={c.id} onClick={() => navigate(`/courses/${c.id}`)} style={{ display: 'grid', gridTemplateColumns: '214px 1fr', gap: 20, background: 'white', padding: 20, borderRadius: 8, cursor: 'pointer' }} className="hoverLift">
                <img src={c.image} alt={c.title} style={{ width: '100%', aspectRatio: '1', objectFit: 'cover', borderRadius: 4 }} />
                <div style={{ display: 'flex', flexDirection: 'column', justifyContent: 'center', gap: 8 }}>
                  <span className="tag" style={{ width: 'fit-content', background: '#03CEA4' }}>{c.tag}</span>
                  <div style={{ fontWeight: 700 }}>{c.title}</div>
                  <div><span style={{ color: '#FF3F3A', fontWeight: 700 }}>${c.price}</span><span style={{ color: '#787A80', marginLeft: 8, fontSize: 13 }}>| by {c.author}</span></div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>
      <Newsletter />
    </div>
  );
};
