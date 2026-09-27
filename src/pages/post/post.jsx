import { useParams, useNavigate } from 'react-router-dom';
import { POSTS } from 'shared/api/mocks';
import { Newsletter } from 'widgets/newsletter';
import { IMAGES } from 'shared/config/images';
export const PostPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const post = POSTS.find(p => p.id === Number(id)) || POSTS[0];
  const related = POSTS.filter(p => p.id !== post.id).slice(0, 3);
  return (
    <div className="pageFadeIn">
      <div className="container" style={{ padding: '40px 15px', display: 'grid', gridTemplateColumns: '1fr 380px', gap: 60 }}>
        <article>
          <div className="breadcrumbs"><span>{post.tagType}</span> / <span>{post.category}</span></div>
          <h1 style={{ fontSize: 40, fontWeight: 900, lineHeight: 1.2, marginBottom: 16 }}>{post.title}</h1>
          <div style={{ display: 'flex', gap: 16, fontSize: 14, color: '#787A80', marginBottom: 32 }}>
            <span>📅 {post.date}</span><span>⏱ {post.readTime}</span>
          </div>
          <img src={post.image} alt={post.title} style={{ width: '100%', borderRadius: 8, marginBottom: 32 }} />
          <p style={{ fontSize: 16, lineHeight: 1.7, marginBottom: 16 }}>Vulputate vitae pellentesque scelerisque luctus consequat mattis pellentesque dui odio. Interdum aenean sit malesuada ornare sed gravida rhoncus, congue. Purus auctor nullam diam quis est hendrerit ac euismod.</p>
          <p style={{ fontSize: 16, lineHeight: 1.7, marginBottom: 16, color: '#787A80' }}>At facilisi sapien posuere eget nunc senectus proin nullam. Tortor senectus in et sagittis, vitae diam cras dignissim. Varius adipiscing eget diam nisi. Orci, consectetur vulputate metus ornare pharetra, neque, fermentum.</p>
          <blockquote style={{ padding: 24, background: '#FEDCD9', borderRadius: 8, fontSize: 20, fontStyle: 'italic', margin: '24px 0' }}>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Justo, amet lectus quam viverra mus lobortis fermentum amet, eu.
          </blockquote>
          <p style={{ fontSize: 16, lineHeight: 1.7, color: '#787A80' }}>Mauris amet arcu nisl vel dictum tellus. Sed rhoncus, ut sed id ut erat mattis. Vitae mus blandit in neque amet non fringilla blandit.</p>
        </article>
        <aside>
          <div style={{ position: 'sticky', top: 120 }}>
            <div style={{ marginBottom: 32 }}>
              <div style={{ fontSize: 12, fontWeight: 700, color: '#787A80', textTransform: 'uppercase', marginBottom: 12 }}>Author</div>
              <div style={{ display: 'flex', gap: 12, alignItems: 'center' }}>
                <img src={IMAGES.author} alt="Author" style={{ width: 60, height: 60, borderRadius: '50%' }} />
                <div><div style={{ fontWeight: 700 }}>Kristin Watson</div><div style={{ fontSize: 13, color: '#787A80' }}>Curator of Marketing Course</div></div>
              </div>
            </div>
            <div>
              <div style={{ fontSize: 12, fontWeight: 700, color: '#787A80', textTransform: 'uppercase', marginBottom: 12 }}>Trending articles</div>
              {related.slice(0, 3).map(p => (
                <div key={p.id} onClick={() => navigate(`/blog/${p.id}`)} style={{ display: 'grid', gridTemplateColumns: '80px 1fr', gap: 12, marginBottom: 16, cursor: 'pointer' }}>
                  <img src={p.image} alt={p.title} style={{ width: '100%', aspectRatio: '1', objectFit: 'cover', borderRadius: 4 }} />
                  <div><div style={{ fontSize: 12, color: '#787A80' }}>{p.date}</div><div style={{ fontSize: 14, fontWeight: 700, lineHeight: 1.3 }}>{p.title}</div></div>
                </div>
              ))}
            </div>
          </div>
        </aside>
      </div>
      <Newsletter />
    </div>
  );
};
