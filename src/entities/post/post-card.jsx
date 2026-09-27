export const PostCard = ({ post, onClick }) => (
  <div onClick={onClick} style={{ cursor: 'pointer' }} className="hoverLift">
    <div style={{ position: 'relative', aspectRatio: '390/300', borderRadius: 8, overflow: 'hidden', marginBottom: 16, background: '#F4F5F6' }}>
      <img src={post.image} alt={post.title} style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
      <span style={{ position: 'absolute', top: 12, left: 12, padding: '3px 10px', background: 'white', borderRadius: 4, fontSize: 12, fontWeight: 700 }}>{post.tagType}</span>
    </div>
    <div style={{ display: 'flex', gap: 8, fontSize: 13, color: '#787A80', marginBottom: 10 }}>
      <span style={{ fontWeight: 700, color: '#1E212C' }}>{post.category}</span><span>|</span><span>{post.date}</span>
    </div>
    <h3 style={{ fontSize: 18, fontWeight: 700, lineHeight: 1.4, marginBottom: 10 }}>{post.title}</h3>
    <p style={{ fontSize: 14, color: '#787A80', lineHeight: 1.6, marginBottom: 16 }}>{post.excerpt}</p>
    <div style={{ color: '#FF3F3A', fontWeight: 700, fontSize: 14 }}>{post.action} →</div>
  </div>
);
