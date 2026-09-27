import { useNavigate } from 'react-router-dom';
import { CourseCard } from 'entities/course';
import { COURSES } from 'shared/api/mocks';
export const Featured = () => {
  const navigate = useNavigate();
  return (
    <section style={{ padding: '80px 0', background: '#F4F5F6' }}>
      <div style={{ maxWidth: 1230, margin: '0 auto 40px', padding: '0 15px', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', flexWrap: 'wrap', gap: 20 }}>
        <div>
          <div className="section-eyebrow">Ready to learn?</div>
          <h2 className="section-title">Featured Courses</h2>
        </div>
        <button className="btn btn-outline" onClick={() => navigate('/courses')}>View all courses</button>
      </div>
      <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 24 }}>
        {COURSES.slice(0, 6).map(c => <CourseCard key={c.id} course={c} onClick={() => navigate(`/courses/${c.id}`)} />)}
      </div>
    </section>
  );
};
