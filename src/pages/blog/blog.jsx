import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { PostCard } from 'entities/post';
import { POSTS } from 'shared/api/mocks';
import { Newsletter } from 'widgets/newsletter';
import { SearchIcon } from 'shared/ui/icon';
export const BlogPage = () => {
  const navigate = useNavigate();
  const [cat, setCat] = useState('All');
  const cats = ['All', 'Article', 'Video', 'Podcast'];
  const filtered = POSTS.filter(p => cat === 'All' || p.tagType === cat);
  return (
    <div className="pageFadeIn">
      <section style={{ padding: '60px 0', background: '#FEDCD9', textAlign: 'center' }}>
        <div className="section-eyebrow">Our blog</div>
        <h1 className="section-title">Createx School Journal</h1>
      </section>
      <div className="container" style={{ padding: '40px 15px' }}>
        <div style={{ display: 'flex', gap: 12, alignItems: 'center', marginBottom: 32, flexWrap: 'wrap' }}>
          {cats.map(c => (
            <button key={c} onClick={() => setCat(c)} style={{ padding: '8px 16px', border: '1px solid', borderRadius: 4, fontSize: 13, fontWeight: 700, background: cat === c ? '#FF3F3A' : 'transparent', color: cat === c ? 'white' : '#1E212C', borderColor: cat === c ? '#FF3F3A' : '#E5E8ED' }}>{c}</button>
          ))}
          <div style={{ marginLeft: 'auto', position: 'relative' }}>
            <span style={{ position: 'absolute', left: 12, top: '50%', transform: 'translateY(-50%)', color: '#787A80' }}><SearchIcon /></span>
            <input className="input" placeholder="Search blog..." style={{ paddingLeft: 40, width: 240 }} />
          </div>
        </div>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 24 }}>
          {filtered.map(p => <PostCard key={p.id} post={p} onClick={() => navigate(`/blog/${p.id}`)} />)}
        </div>
      </div>
      <Newsletter />
    </div>
  );
};
