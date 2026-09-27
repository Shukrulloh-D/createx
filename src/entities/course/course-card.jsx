const cardStyle = { background: 'white', border: '1px solid #E5E8ED', borderRadius: 8, overflow: 'hidden', cursor: 'pointer', transition: 'all 0.25s' };
const imgWrap = { aspectRatio: '390/240', overflow: 'hidden', background: '#F4F5F6', position: 'relative' };
const tagColors = { Marketing: '#03CEA4', Management: '#5A87FC', 'HR': '#F89828', Design: '#F52F6E', Dev: '#FF3F3A' };
export const CourseCard = ({ course, onClick }) => (
  <div style={cardStyle} onClick={onClick} className="hoverLift">
    <div style={imgWrap}>
      <img src={course.image} alt={course.title} style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
      <span className="tag" style={{ position: 'absolute', top: 12, left: 12, background: tagColors[course.tag] || '#FF3F3A' }}>{course.tag}</span>
    </div>
    <div style={{ padding: 20 }}>
      <h3 style={{ fontSize: 18, fontWeight: 700, lineHeight: 1.4, marginBottom: 12 }}>{course.title}</h3>
      <div><span style={{ color: '#FF3F3A', fontWeight: 700, fontSize: 18 }}>${course.price}</span><span style={{ color: '#787A80', fontSize: 14, marginLeft: 8 }}>| by {course.author}</span></div>
    </div>
  </div>
);
