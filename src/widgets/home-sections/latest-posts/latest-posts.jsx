import { useNavigate } from 'react-router-dom';
import { PostCard } from 'entities/post';
import { POSTS } from 'shared/api/mocks';
export const LatestPosts = () => {
  const navigate = useNavigate();
  return (
    <section style={{ padding: '80px 0' }}>
      <div style={{ maxWidth: 1230, margin: '0 auto 40px', padding: '0 15px', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', flexWrap: 'wrap', gap: 16 }}>
        <div>
          <div className="section-eyebrow">Our blog</div>
          <h2 className="section-title">Latest posts</h2>
        </div>
        <button className="btn btn-primary" onClick={() => navigate('/blog')}>Go to blog</button>
      </div>
      <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 24 }}>
        {POSTS.slice(0, 3).map(p => <PostCard key={p.id} post={p} onClick={() => navigate(`/blog/${p.id}`)} />)}
      </div>
    </section>
  );
};
