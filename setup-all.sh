#!/bin/bash
set -e
echo "=== Creating folders ==="
mkdir -p src/app/{layouts,router,styles}
mkdir -p src/pages/{home,about,courses,course,events,event,blog,post,contacts,not-found}
mkdir -p src/widgets/{header,footer,newsletter}
mkdir -p src/widgets/home-sections/{hero,stats,why,featured,approach,lectures,certificate,team,testimonials,latest-posts}
mkdir -p src/widgets/auth-modals
mkdir -p src/entities/{course,event,post}
mkdir -p src/shared/ui/{button,input,modal,icon}
mkdir -p src/shared/lib/{hooks,toast,auth}
mkdir -p src/shared/api src/shared/config

echo "=== Global styles ==="
cat > src/app/styles/index.css << 'CSS_END'
:root {
  --primary: #FF3F3A;
  --primary-2: #F75E05;
  --dark: #1E212C;
  --gray: #787A80;
  --gray-light: #9A9CA5;
  --gray-bg: #F4F5F6;
  --border: #E5E8ED;
  --success: #03CEA4;
  --warning: #F89828;
  --purple: #5A87FC;
  --pink: #F52F6E;
}
* { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }
body { font-family: 'Lato', system-ui, sans-serif; background: #fff; color: var(--dark); font-size: 16px; line-height: 1.6; -webkit-font-smoothing: antialiased; }
a { color: inherit; text-decoration: none; }
button { font-family: inherit; cursor: pointer; border: none; background: transparent; }
input, textarea { font-family: inherit; font-size: inherit; }
img { max-width: 100%; display: block; }
ul { list-style: none; }
.container { max-width: 1230px; margin: 0 auto; padding: 0 15px; }
.btn { display: inline-flex; align-items: center; justify-content: center; gap: 8px; padding: 14px 28px; border-radius: 4px; font-weight: 700; font-size: 14px; letter-spacing: 0.5px; text-transform: uppercase; transition: all 0.25s; white-space: nowrap; }
.btn-primary { background: linear-gradient(55deg, var(--primary) 0%, var(--primary-2) 100%); color: white; }
.btn-primary:hover { box-shadow: 0 8px 24px rgba(255,63,58,0.35); transform: translateY(-2px); }
.btn-outline { background: transparent; border: 1px solid var(--primary); color: var(--primary); }
.btn-outline:hover { background: var(--primary); color: white; }
.btn-dark { background: var(--dark); color: white; }
.btn-ghost { background: transparent; color: var(--dark); border: 1px solid var(--border); }
.btn-ghost:hover { border-color: var(--primary); color: var(--primary); }
.btn-full { width: 100%; }
.input { padding: 12px 16px; border: 1px solid var(--border); border-radius: 4px; font-size: 14px; outline: none; transition: border-color 0.2s; width: 100%; background: white; }
.input:focus { border-color: var(--primary); }
.input::placeholder { color: var(--gray-light); }
.toast { position: fixed; bottom: 30px; right: 30px; background: var(--dark); color: white; padding: 14px 22px; border-radius: 4px; font-size: 14px; box-shadow: 0 20px 40px rgba(0,0,0,0.2); z-index: 9999; animation: fadeIn 0.3s; }
.tag { display: inline-block; padding: 2px 10px; font-size: 12px; font-weight: 700; border-radius: 4px; color: white; }
.tag-green { background: var(--success); }
.tag-blue { background: var(--purple); }
.tag-orange { background: var(--warning); }
.tag-pink { background: var(--pink); }
.tag-red { background: var(--primary); }
.breadcrumbs { font-size: 14px; color: var(--gray); padding: 30px 0 20px; display: flex; gap: 8px; align-items: center; }
.breadcrumbs a:hover { color: var(--primary); }
.section-title { font-size: 46px; font-weight: 900; line-height: 1.15; letter-spacing: -0.5px; }
.section-eyebrow { font-size: 14px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 8px; }
@keyframes fadeIn { from { opacity: 0; transform: translateY(15px); } to { opacity: 1; transform: translateY(0); } }
@keyframes fadeInScale { from { opacity: 0; transform: scale(0.95); } to { opacity: 1; transform: scale(1); } }
@keyframes slideInRight { from { opacity: 0; transform: translateX(30px); } to { opacity: 1; transform: translateX(0); } }
.pageFadeIn { animation: fadeIn 0.35s ease; }
.hoverLift { transition: transform 0.25s, box-shadow 0.25s; }
.hoverLift:hover { transform: translateY(-4px); box-shadow: 0 15px 40px rgba(30,33,44,0.1); }
button:active, .btn:active { transform: scale(0.97); }
@media (max-width: 900px) { .section-title { font-size: 32px; } }
CSS_END

echo "=== Shared UI ==="
cat > src/shared/ui/button/button.jsx << 'EOF'
export const Button = ({ children, variant = 'primary', className = '', full, ...props }) => (
  <button className={`btn btn-${variant} ${full ? 'btn-full' : ''} ${className}`} {...props}>{children}</button>
);
EOF
echo "export * from './button';" > src/shared/ui/button/index.js

cat > src/shared/ui/input/input.jsx << 'EOF'
export const Input = ({ label, error, className = '', ...props }) => (
  <div style={{ display: 'flex', flexDirection: 'column', gap: 6, width: '100%' }}>
    {label && <label style={{ fontSize: 14, fontWeight: 500 }}>{label}</label>}
    <input className={`input ${className}`} {...props} />
    {error && <span style={{ color: '#FF3F3A', fontSize: 12 }}>{error}</span>}
  </div>
);
EOF
echo "export * from './input';" > src/shared/ui/input/index.js

cat > src/shared/ui/modal/modal.jsx << 'EOF'
import { useEffect } from 'react';
const ov = { position: 'fixed', inset: 0, background: 'rgba(30,33,44,0.6)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, padding: 20, animation: 'fadeIn 0.2s' };
const ct = { background: 'white', padding: 32, borderRadius: 8, maxWidth: 480, width: '100%', maxHeight: '90vh', overflowY: 'auto', position: 'relative', animation: 'fadeInScale 0.3s' };
const cl = { position: 'absolute', top: 16, right: 16, width: 32, height: 32, borderRadius: '50%', fontSize: 18, color: '#787A80' };
export const Modal = ({ isOpen, onClose, children }) => {
  useEffect(() => {
    const onEsc = (e) => { if (e.key === 'Escape') onClose(); };
    if (isOpen) document.addEventListener('keydown', onEsc);
    return () => document.removeEventListener('keydown', onEsc);
  }, [isOpen, onClose]);
  if (!isOpen) return null;
  return <div style={ov} onClick={onClose}><div style={ct} onClick={(e) => e.stopPropagation()}><button style={cl} onClick={onClose}>✕</button>{children}</div></div>;
};
EOF
echo "export * from './modal';" > src/shared/ui/modal/index.js

cat > src/shared/ui/icon/icons.jsx << 'EOF'
export const SearchIcon = ({ size = 18 }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><circle cx="11" cy="11" r="7" /><path d="m21 21-4.35-4.35" /></svg>);
export const PlayIcon = ({ size = 12 }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="currentColor"><polygon points="6 4 20 12 6 20" /></svg>);
export const ArrowRight = ({ size = 16 }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M5 12h14M12 5l7 7-7 7" /></svg>);
export const ArrowLeft = ({ size = 16 }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M19 12H5M12 19l-7-7 7-7" /></svg>);
export const CheckIcon = ({ size = 16 }) => (<svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"><polyline points="20 6 9 17 4 12" /></svg>);
EOF
echo "export * from './icons';" > src/shared/ui/icon/index.js

echo "=== Libs ==="
cat > src/shared/lib/hooks/use-reveal.js << 'EOF'
import { useEffect, useRef } from 'react';
export const useReveal = (delay = 0) => {
  const ref = useRef(null);
  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    const o = new IntersectionObserver(([e]) => { if (e.isIntersecting) { setTimeout(() => e.target.classList.add('visible'), delay); o.unobserve(e.target); } }, { threshold: 0.1 });
    o.observe(el);
    return () => o.disconnect();
  }, [delay]);
  return ref;
};
EOF
echo "export * from './use-reveal';" > src/shared/lib/hooks/index.js

cat > src/shared/lib/toast/toast.jsx << 'EOF'
import { createContext, useContext, useState, useCallback } from 'react';
const Ctx = createContext();
export const ToastProvider = ({ children }) => {
  const [toasts, setToasts] = useState([]);
  const toast = useCallback((msg) => { const id = Date.now(); setToasts(p => [...p, { id, msg }]); setTimeout(() => setToasts(p => p.filter(t => t.id !== id)), 2500); }, []);
  return <Ctx.Provider value={toast}>{children}{toasts.map(t => <div key={t.id} className="toast">{t.msg}</div>)}</Ctx.Provider>;
};
export const useToast = () => useContext(Ctx);
EOF
echo "export * from './toast';" > src/shared/lib/toast/index.js

cat > src/shared/lib/auth/auth-context.jsx << 'EOF'
import { createContext, useContext, useState } from 'react';
const Ctx = createContext();
export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const login = (email) => setUser({ email, name: 'User' });
  const logout = () => setUser(null);
  return <Ctx.Provider value={{ user, login, logout }}>{children}</Ctx.Provider>;
};
export const useAuth = () => useContext(Ctx);
EOF
echo "export * from './auth-context';" > src/shared/lib/auth/index.js
echo "export * from './hooks'; export * from './toast'; export * from './auth';" > src/shared/lib/index.js

echo "=== Images config ==="
cat > src/shared/config/images.js << 'EOF'
const ph = (label, w = 400, h = 300) => `https://placehold.co/${w}x${h}/F4F5F6/787A80?text=${encodeURIComponent(label)}&font=lato`;
export const IMAGES = {
  heroIllustration: ph('Hero+Illustration', 600, 550),
  whyImage: ph('About+Image', 705, 560),
  course1: ph('Course+1', 390, 240), course2: ph('Course+2', 390, 240), course3: ph('Course+3', 390, 240),
  course4: ph('Course+4', 390, 240), course5: ph('Course+5', 390, 240), course6: ph('Course+6', 390, 240),
  approachIllustration: ph('Approach', 550, 500),
  certificate: ph('Certificate', 705, 500),
  team1: ph('Team+1', 285, 340), team2: ph('Team+2', 285, 340), team3: ph('Team+3', 285, 340), team4: ph('Team+4', 285, 340),
  team5: ph('Team+5', 285, 340), team6: ph('Team+6', 285, 340), team7: ph('Team+7', 285, 340), team8: ph('Team+8', 285, 340),
  post1: ph('Post+1', 390, 300), post2: ph('Post+2', 390, 300), post3: ph('Post+3', 390, 300),
  post4: ph('Post+4', 390, 300), post5: ph('Post+5', 390, 300), post6: ph('Post+6', 390, 300),
  blogSingle: ph('Blog+Single', 810, 360),
  newsletterIllustration: ph('Newsletter', 400, 400),
  mapImage: ph('Map', 705, 412),
  courseHero: ph('Course+Hero', 458, 600),
  courseProgram: ph('Program', 550, 500),
  author: ph('Author', 100, 100),
};
EOF
echo "export * from './images';" > src/shared/config/index.js

echo "=== Mocks ==="
cat > src/shared/api/mocks.js << 'EOF'
import { IMAGES } from 'shared/config/images';
export const COURSES = [
  { id: 1, title: 'The Ultimate Google Ads Training Course', price: 100, author: 'Jerome Bell', category: 'Marketing', tag: 'Marketing', image: IMAGES.course1 },
  { id: 2, title: 'Product Management Fundamentals', price: 480, author: 'Marvin McKinney', category: 'Management', tag: 'Management', image: IMAGES.course2 },
  { id: 3, title: 'HR Management and Analytics', price: 200, author: 'Leslie Alexander Li', category: 'HR & Recruiting', tag: 'HR', image: IMAGES.course3 },
  { id: 4, title: 'Brand Management & PR Communications', price: 530, author: 'Kristin Watson', category: 'Marketing', tag: 'Marketing', image: IMAGES.course4 },
  { id: 5, title: 'Business Development Management', price: 400, author: 'Dianne Russell', category: 'Management', tag: 'Management', image: IMAGES.course5 },
  { id: 6, title: 'Graphic Design Basic', price: 500, author: 'Guy Hawkins', category: 'Design', tag: 'Design', image: IMAGES.course6 },
  { id: 7, title: 'Highload Software Architecture', price: 600, author: 'Brooklyn Simmons', category: 'Development', tag: 'Dev', image: IMAGES.course1 },
  { id: 8, title: 'Human Resources - Selection and Recruitment', price: 150, author: 'Kathryn Murphy', category: 'HR & Recruiting', tag: 'HR', image: IMAGES.course2 },
  { id: 9, title: 'User Experience. Human-centered Design', price: 240, author: 'Cody Fisher', category: 'Design', tag: 'Design', image: IMAGES.course3 },
];
export const EVENTS = [
  { id: 1, day: '05', month: 'August', time: '11:00 - 14:00', title: 'Formation of the organizational structure of the company in the face of uncertainty.', type: 'Online master-class' },
  { id: 2, day: '24', month: 'July', time: '11:00 - 12:30', title: 'Building a customer service department. Best Practices.', type: 'Online lecture' },
  { id: 3, day: '16', month: 'July', time: '10:00 - 13:00', title: 'How to apply methods of speculative design in practice.', type: 'Online workshop' },
  { id: 4, day: '10', month: 'July', time: '9:00 - 14:00', title: 'Find and evaluate: search and assessment tools for candidates.', type: 'Online workshop' },
  { id: 5, day: '27', month: 'June', time: '15:00 - 19:00', title: 'Connection to Microsoft Excel and Google Sheets.', type: 'Online master-class' },
  { id: 6, day: '15', month: 'June', time: '10:00 - 12:00', title: 'Marketing or growth hacking: main differences.', type: 'Online lecture' },
  { id: 7, day: '02', month: 'June', time: '11:00 - 13:00', title: 'How to brief a client and present your design.', type: 'Online lecture' },
  { id: 8, day: '29', month: 'May', time: '11:00 - 12:00', title: 'Who is a project manager and do I want to be PM?', type: 'Online lecture' },
  { id: 9, day: '18', month: 'May', time: '10:00 - 12:00', title: 'The company business page as an additional tool.', type: 'Online lecture' },
];
export const POSTS = [
  { id: 1, category: 'Marketing', date: 'September 4, 2020', readTime: '36 min', title: 'What is traffic arbitrage and does it really make money?', excerpt: 'Pharetra, ullamcorper iaculis viverra parturient sed id sed.', action: 'Listen', tagType: 'Podcast', image: IMAGES.post1 },
  { id: 2, category: 'Management', date: 'August 25, 2020', readTime: '45 min', title: 'What to do and who to talk to if you want to get feedback on the product', excerpt: 'Neque a, senectus consectetur odio in aliquet nec eu.', action: 'Watch', tagType: 'Video', image: IMAGES.post2 },
  { id: 3, category: 'Design', date: 'August 8, 2020', readTime: '36 min', title: 'Should you choose a creative profession?', excerpt: 'Curabitur nisl tincidunt eros venenatis vestibulum ac placerat.', action: 'Read', tagType: 'Article', image: IMAGES.post3 },
  { id: 4, category: 'HR & Recruiting', date: 'August 3, 2020', readTime: '36 min', title: 'HR statistics: job search, interviews, hiring and recruiting', excerpt: 'Massa, lectus nibh consectetur aliquet nunc risus aenean.', action: 'Read', tagType: 'Article', image: IMAGES.post4 },
  { id: 5, category: 'Development', date: 'September 1, 2020', readTime: '54 min', title: 'How to choose the first programming language for a beginner', excerpt: 'Turpis sed at magna laoreet gravida consequat tortor placerat.', action: 'Read', tagType: 'Article', image: IMAGES.post5 },
  { id: 6, category: 'Design', date: 'July 20, 2020', readTime: '36 min', title: 'What are color profiles and how they work in graphic design', excerpt: 'Aliquam vulputate, tortor tempor, orci nisi convallis aenean.', action: 'Listen', tagType: 'Podcast', image: IMAGES.post6 },
];
export const TEAM = [
  { id: 1, name: 'Dianne Russell', role: 'Founder and CEO', image: IMAGES.team1 },
  { id: 2, name: 'Jerome Bell', role: 'Founder and Program Director', image: IMAGES.team2 },
  { id: 3, name: 'Kristin Watson', role: 'Marketer, Curator', image: IMAGES.team3 },
  { id: 4, name: 'Marvin McKinney', role: 'PM, Curator', image: IMAGES.team4 },
  { id: 5, name: 'Leslie Alexander Li', role: 'Curator of HR', image: IMAGES.team5 },
  { id: 6, name: 'Kathryn Murphy', role: 'Marketer', image: IMAGES.team6 },
  { id: 7, name: 'Brooklyn Simmons', role: 'Curator of Dev', image: IMAGES.team7 },
  { id: 8, name: 'Cody Fisher', role: 'UX Designer', image: IMAGES.team8 },
];
export const STATS = [
  { number: 1200, label: 'students graduated' }, { number: 84, label: 'completed courses' },
  { number: 16, label: 'qualified tutors' }, { number: 5, label: 'years of experience' },
];
export const TESTIMONIAL = {
  text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Justo, amet lectus quam viverra mus lobortis fermentum amet, eu. Pulvinar eu sed purus facilisi. Vitae id turpis tempus ornare turpis quis non.',
  author: 'Eleanor Pena', role: 'Position, Course', avatar: IMAGES.author,
};
export const CATEGORIES = ['All', 'Marketing', 'Management', 'HR & Recruiting', 'Design', 'Development'];
EOF
echo "export * from './mocks';" > src/shared/api/index.js

echo "=== Entities ==="
cat > src/entities/course/course-card.jsx << 'EOF'
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
EOF
echo "export * from './course-card';" > src/entities/course/index.js

cat > src/entities/event/event-card.jsx << 'EOF'
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
EOF
echo "export * from './event-card';" > src/entities/event/index.js

cat > src/entities/post/post-card.jsx << 'EOF'
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
EOF
echo "export * from './post-card';" > src/entities/post/index.js

echo "=== Header ==="
cat > src/widgets/header/header.jsx << 'EOF'
import { Link, NavLink, useNavigate } from 'react-router-dom';
import { useAuth } from 'shared/lib/auth';
const headerStyle = { background: 'white', borderBottom: '1px solid #E5E8ED', position: 'sticky', top: 0, zIndex: 100 };
const innerStyle = { maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', height: 90 };
const logoStyle = { fontFamily: 'Lato', fontSize: 24, fontWeight: 900, letterSpacing: '-0.5px' };
const navStyle = { display: 'flex', gap: 28, fontSize: 15, fontWeight: 500 };
const btnStyle = { display: 'inline-flex', alignItems: 'center', gap: 8, padding: '12px 24px', borderRadius: 4, fontWeight: 700, fontSize: 13, textTransform: 'uppercase', background: 'linear-gradient(55deg, #FF3F3A 0%, #F75E05 100%)', color: 'white', letterSpacing: '0.5px' };

export const Header = ({ onOpenAuth }) => {
  const navigate = useNavigate();
  const { user, logout } = useAuth();
  const navItems = [['/about', 'About Us'], ['/courses', 'Courses'], ['/events', 'Events'], ['/blog', 'Blog'], ['/contacts', 'Contacts']];
  return (
    <header style={headerStyle}>
      <div style={innerStyle}>
        <Link to="/" style={logoStyle}>CREATE<span style={{ color: '#FF3F3A' }}>X</span></Link>
        <nav style={navStyle}>
          {navItems.map(([to, label]) => (
            <NavLink key={to} to={to} style={({ isActive }) => ({ color: isActive ? '#FF3F3A' : '#1E212C', padding: '6px 0' })}>{label}</NavLink>
          ))}
        </nav>
        <div style={{ display: 'flex', gap: 16, alignItems: 'center' }}>
          <button style={btnStyle} onClick={() => navigate('/contacts')}>Get consultation</button>
          {user ? (
            <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
              <span style={{ fontSize: 14, fontWeight: 600 }}>👤 {user.name}</span>
              <button onClick={logout} style={{ fontSize: 13, color: '#787A80' }}>Logout</button>
            </div>
          ) : (
            <button onClick={() => onOpenAuth('login')} style={{ fontSize: 14, fontWeight: 500, display: 'flex', alignItems: 'center', gap: 6 }}>
              👤 Log in / Register
            </button>
          )}
        </div>
      </div>
    </header>
  );
};
EOF
echo "export * from './header';" > src/widgets/header/index.js

echo "=== Footer ==="
cat > src/widgets/footer/footer.jsx << 'EOF'
import { Link } from 'react-router-dom';
import { useState } from 'react';
import { useToast } from 'shared/lib/toast';
const fs = { background: '#1E212C', color: 'rgba(255,255,255,0.7)', marginTop: 80 };
const topStyle = { maxWidth: 1230, margin: '0 auto', padding: '60px 15px', display: 'grid', gridTemplateColumns: '1.5fr 1fr 1fr 1fr 1.5fr', gap: 40 };
const colH = { color: 'white', fontSize: 14, fontWeight: 700, marginBottom: 16, textTransform: 'uppercase', letterSpacing: '0.5px' };
const linkStyle = { display: 'block', fontSize: 14, padding: '6px 0', color: 'rgba(255,255,255,0.7)' };
export const Footer = () => {
  const toast = useToast();
  const [email, setEmail] = useState('');
  const subscribe = (e) => { e.preventDefault(); if (!email.includes('@')) { toast('Enter a valid email'); return; } toast('✓ Subscribed!'); setEmail(''); };
  return (
    <footer style={fs}>
      <div style={topStyle}>
        <div>
          <div style={{ fontFamily: 'Lato', color: 'white', fontSize: 22, fontWeight: 900, marginBottom: 16 }}>CREATE<span style={{ color: '#FF3F3A' }}>X</span></div>
          <p style={{ fontSize: 13, lineHeight: 1.6, marginBottom: 20 }}>Createx Online School is a leader in online studying. We have lots of courses from market experts.</p>
          <div style={{ display: 'flex', gap: 16 }}>{['f','t','in','ig','yt','tg'].map(s => <a key={s} href="/" style={{ color: 'rgba(255,255,255,0.6)', fontSize: 14 }}>{s}</a>)}</div>
        </div>
        <div>
          <h4 style={colH}>Site Map</h4>
          <Link to="/about" style={linkStyle}>About Us</Link>
          <Link to="/courses" style={linkStyle}>Courses</Link>
          <Link to="/events" style={linkStyle}>Events</Link>
          <Link to="/blog" style={linkStyle}>Blog</Link>
          <Link to="/contacts" style={linkStyle}>Contacts</Link>
        </div>
        <div>
          <h4 style={colH}>Courses</h4>
          {['Marketing','Management','HR & Recruiting','Design','Development'].map(c => <Link key={c} to="/courses" style={linkStyle}>{c}</Link>)}
        </div>
        <div>
          <h4 style={colH}>Contacts</h4>
          <a href="tel:4055550128" style={linkStyle}>(405) 555-0128</a>
          <a href="mailto:hello@createx.com" style={linkStyle}>hello@createx.com</a>
        </div>
        <div>
          <h4 style={colH}>Newsletter</h4>
          <form onSubmit={subscribe} style={{ display: 'flex', gap: 8 }}>
            <input type="email" placeholder="Email address" value={email} onChange={(e) => setEmail(e.target.value)} style={{ flex: 1, padding: '10px 12px', background: 'rgba(255,255,255,0.08)', border: '1px solid rgba(255,255,255,0.15)', borderRadius: 4, color: 'white', fontSize: 13, outline: 'none' }} />
            <button type="submit" style={{ padding: '10px 16px', background: '#FF3F3A', color: 'white', borderRadius: 4, fontWeight: 700, fontSize: 13 }}>→</button>
          </form>
        </div>
      </div>
      <div style={{ borderTop: '1px solid rgba(255,255,255,0.08)', padding: 20, textAlign: 'center', fontSize: 13, opacity: 0.6 }}>© All rights reserved. Made with ♥ by Createx Studio</div>
    </footer>
  );
};
EOF
echo "export * from './footer';" > src/widgets/footer/index.js

echo "=== Newsletter ==="
cat > src/widgets/newsletter/newsletter.jsx << 'EOF'
import { useState } from 'react';
import { useToast } from 'shared/lib/toast';
export const Newsletter = () => {
  const toast = useToast();
  const [email, setEmail] = useState('');
  const submit = (e) => { e.preventDefault(); if (!email.includes('@')) { toast('Enter a valid email'); return; } toast('✓ Subscribed!'); setEmail(''); };
  return (
    <section style={{ background: '#FEDCD9', padding: '60px 20px', textAlign: 'center', marginTop: 80 }}>
      <div style={{ fontSize: 14, fontWeight: 700, textTransform: 'uppercase', letterSpacing: 1, marginBottom: 8 }}>Don't miss anything</div>
      <h2 style={{ fontSize: 46, fontWeight: 900, maxWidth: 810, margin: '0 auto 32px', lineHeight: 1.15 }}>Subscribe to the Createx School announcements</h2>
      <form onSubmit={submit} style={{ display: 'flex', gap: 12, maxWidth: 600, margin: '0 auto' }}>
        <input type="email" placeholder="Your working email" value={email} onChange={(e) => setEmail(e.target.value)} style={{ flex: 1, padding: '14px 16px', border: '1px solid rgba(255,63,58,0.3)', borderRadius: 4, fontSize: 14, outline: 'none' }} />
        <button type="submit" style={{ padding: '14px 28px', background: '#FF3F3A', color: 'white', borderRadius: 4, fontWeight: 700, fontSize: 14, textTransform: 'uppercase' }}>Subscribe</button>
      </form>
    </section>
  );
};
EOF
echo "export * from './newsletter';" > src/widgets/newsletter/index.js

echo "=== Home sections ==="
cat > src/widgets/home-sections/hero/hero.jsx << 'EOF'
import { useNavigate } from 'react-router-dom';
import { IMAGES } from 'shared/config/images';
export const Hero = () => {
  const navigate = useNavigate();
  return (
    <section style={{ background: 'linear-gradient(135deg, #FEDCD9 0%, #FFF0EE 100%)', padding: '80px 0 100px' }}>
      <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'grid', gridTemplateColumns: '1.2fr 1fr', gap: 40, alignItems: 'center' }}>
        <div>
          <div style={{ display: 'inline-flex', alignItems: 'center', gap: 12, marginBottom: 24, fontSize: 14, fontWeight: 700 }}>
            <span style={{ width: 52, height: 52, borderRadius: '50%', background: '#FF3F3A', color: 'white', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>▶</span>
            Play showreel
          </div>
          <h1 style={{ fontSize: 64, fontWeight: 900, lineHeight: 1.05, letterSpacing: '-2px', marginBottom: 24 }}>Enjoy studying with Createx <span style={{ color: '#FF3F3A' }}>Online Courses</span></h1>
          <div style={{ display: 'flex', gap: 16, marginTop: 32 }}>
            <button className="btn btn-outline" onClick={() => navigate('/about')}>About us</button>
            <button className="btn btn-primary" onClick={() => navigate('/courses')}>Explore courses</button>
          </div>
        </div>
        <img src={IMAGES.heroIllustration} alt="Hero" style={{ width: '100%' }} />
      </div>
    </section>
  );
};
EOF

cat > src/widgets/home-sections/stats/stats.jsx << 'EOF'
import { STATS } from 'shared/api/mocks';
export const Stats = () => (
  <section style={{ padding: '40px 0 80px' }}>
    <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'flex', justifyContent: 'space-around', flexWrap: 'wrap', gap: 30 }}>
      {STATS.map((s, i) => (
        <div key={i} style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <span style={{ fontSize: 46, fontWeight: 900, lineHeight: 1 }}>{s.number}</span>
          <span style={{ fontSize: 14, color: '#787A80' }}>{s.label}</span>
        </div>
      ))}
    </div>
  </section>
);
EOF

cat > src/widgets/home-sections/why/why.jsx << 'EOF'
import { useNavigate } from 'react-router-dom';
import { IMAGES } from 'shared/config/images';
const FEATURES = ['A fermentum in morbi pretium aliquam adipiscing donec tempus.','Vulputate placerat amet pulvinar lorem nisl.','Consequat feugiat habitant gravida quisque elit bibendum id adipiscing sed.','Etiam duis lobortis in fames ultrices commodo nibh.'];
export const Why = () => {
  const navigate = useNavigate();
  return (
    <section style={{ padding: '80px 0' }}>
      <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 80, alignItems: 'center' }}>
        <img src={IMAGES.whyImage} alt="Why" style={{ borderRadius: 8, width: '100%' }} />
        <div>
          <div className="section-eyebrow">Who we are</div>
          <h2 className="section-title" style={{ marginBottom: 24 }}>Why Createx?</h2>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 12, marginBottom: 32 }}>
            {FEATURES.map((f, i) => <div key={i} style={{ display: 'flex', gap: 10, fontSize: 15 }}><span style={{ color: '#FF3F3A', fontWeight: 900 }}>✓</span>{f}</div>)}
          </div>
          <button className="btn btn-primary" onClick={() => navigate('/about')}>More about us</button>
        </div>
      </div>
    </section>
  );
};
EOF

cat > src/widgets/home-sections/featured/featured.jsx << 'EOF'
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
EOF

cat > src/widgets/home-sections/approach/approach.jsx << 'EOF'
import { useState } from 'react';
import { IMAGES } from 'shared/config/images';
const TABS = [
  { key: 'exp', label: 'Experienced Tutors', title: 'Only practicing tutors', text: 'Urna nisi, arcu lacus eget volutpat rhoncus cras nunc viverra. Eget sit eget mus nibh ultrices vitae in tincidunt.' },
  { key: 'fb', label: 'Feedback & Support', title: '24/7 support', text: 'Ut posuere diam id lorem facilisis in nulla tincidunt. Viverra justo, vitae tincidunt turpis eget vel morbi pulvinar vitae.' },
  { key: 'lib', label: '24/7 Online Library', title: 'Accessible library', text: 'Tristique ut dictum urna, lorem aliquam ullamcorper id. Erat erat faucibus volutpat enim non.' },
  { key: 'com', label: 'Community', title: 'Join our community', text: 'Porta ultricies et, nec et magna varius tellus tortor. Nunc, egestas consectetur ut tincidunt nibh.' },
];
export const Approach = () => {
  const [active, setActive] = useState('exp');
  const tab = TABS.find(t => t.key === active);
  return (
    <section style={{ padding: '80px 0' }}>
      <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 80, alignItems: 'center' }}>
        <div>
          <div className="section-eyebrow">Our benefits</div>
          <h2 className="section-title" style={{ marginBottom: 24 }}>That's how we do it</h2>
          <div style={{ display: 'flex', gap: 8, marginBottom: 32, flexWrap: 'wrap' }}>
            {TABS.map(t => (
              <button key={t.key} onClick={() => setActive(t.key)} style={{ padding: '8px 16px', borderRadius: 4, fontSize: 13, fontWeight: 700, border: '1px solid', background: active === t.key ? '#FF3F3A' : 'transparent', color: active === t.key ? 'white' : '#1E212C', borderColor: active === t.key ? '#FF3F3A' : '#E5E8ED' }}>{t.label}</button>
            ))}
          </div>
          <h3 style={{ fontSize: 32, fontWeight: 900, marginBottom: 16 }}>{tab.title}</h3>
          <p style={{ fontSize: 15, color: '#787A80', lineHeight: 1.7 }}>{tab.text}</p>
        </div>
        <img src={IMAGES.approachIllustration} alt="Approach" style={{ width: '100%' }} />
      </div>
    </section>
  );
};
EOF

cat > src/widgets/home-sections/lectures/lectures.jsx << 'EOF'
import { useNavigate } from 'react-router-dom';
import { EVENTS } from 'shared/api/mocks';
export const Lectures = () => {
  const navigate = useNavigate();
  return (
    <section style={{ padding: '80px 0', background: '#FEDCD9' }}>
      <div style={{ maxWidth: 1230, margin: '0 auto 40px', padding: '0 15px', textAlign: 'center' }}>
        <div className="section-eyebrow">Our events</div>
        <h2 className="section-title">Lectures & workshops</h2>
      </div>
      <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', background: 'white', borderRadius: 8 }}>
        {EVENTS.slice(0, 3).map(e => (
          <div key={e.id} style={{ display: 'grid', gridTemplateColumns: '80px 200px 1fr auto', gap: 24, alignItems: 'center', padding: '24px 32px', borderBottom: '1px solid #E5E8ED' }}>
            <div><div style={{ fontSize: 32, fontWeight: 900, color: '#FF3F3A', lineHeight: 1 }}>{e.day}</div><div style={{ fontSize: 12, color: '#787A80', fontWeight: 700, textTransform: 'uppercase' }}>{e.month}</div></div>
            <div><div style={{ fontSize: 14, fontWeight: 700 }}>{e.time}</div><div style={{ fontSize: 13, color: '#787A80' }}>{e.type}</div></div>
            <div style={{ fontWeight: 700 }}>{e.title}</div>
            <button className="btn btn-outline" onClick={() => navigate(`/events/${e.id}`)}>View more</button>
          </div>
        ))}
      </div>
      <div style={{ textAlign: 'center', marginTop: 40 }}>
        <button className="btn btn-primary" onClick={() => navigate('/events')}>Explore all events</button>
      </div>
    </section>
  );
};
EOF

cat > src/widgets/home-sections/certificate/certificate.jsx << 'EOF'
import { IMAGES } from 'shared/config/images';
export const Certificate = () => (
  <section style={{ padding: '80px 0' }}>
    <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 80, alignItems: 'center' }}>
      <div>
        <div className="section-eyebrow">Createx Certificate</div>
        <h2 className="section-title" style={{ marginBottom: 24 }}>Your expertise will be confirmed</h2>
        <p style={{ fontSize: 15, color: '#787A80', marginBottom: 24 }}>We are accredited by international professional organizations and institutes:</p>
        <div style={{ display: 'flex', gap: 24, opacity: 0.7 }}>
          <span style={{ fontSize: 13, fontWeight: 700 }}>Del Mar Strategy</span>
          <span style={{ fontSize: 13, fontWeight: 700 }}>Sentinal Consulting</span>
          <span style={{ fontSize: 13, fontWeight: 700 }}>National</span>
        </div>
      </div>
      <img src={IMAGES.certificate} alt="Certificate" style={{ borderRadius: 8, boxShadow: '0 20px 60px rgba(30,33,44,0.15)' }} />
    </div>
  </section>
);
EOF

cat > src/widgets/home-sections/team/team.jsx << 'EOF'
import { useState } from 'react';
import { TEAM } from 'shared/api/mocks';
export const Team = () => {
  const [page, setPage] = useState(0);
  const perPage = 4;
  const totalPages = Math.ceil(TEAM.length / perPage);
  const visible = TEAM.slice(page * perPage, page * perPage + perPage);
  return (
    <section style={{ padding: '80px 0', background: '#F4F5F6' }}>
      <div style={{ maxWidth: 1230, margin: '0 auto 40px', padding: '0 15px', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', flexWrap: 'wrap', gap: 16 }}>
        <div>
          <div className="section-eyebrow">Best tutors are all here</div>
          <h2 className="section-title">Meet our team</h2>
        </div>
        <div style={{ display: 'flex', gap: 8 }}>
          <button onClick={() => setPage(Math.max(0, page - 1))} style={{ width: 44, height: 44, borderRadius: '50%', fontSize: 18 }}>←</button>
          <button onClick={() => setPage((page + 1) % totalPages)} style={{ width: 44, height: 44, borderRadius: '50%', fontSize: 18, background: '#FF3F3A', color: 'white' }}>→</button>
        </div>
      </div>
      <div style={{ maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: 24 }}>
        {visible.map(t => (
          <div key={t.id} className="hoverLift" style={{ cursor: 'pointer' }}>
            <div style={{ borderRadius: 8, overflow: 'hidden', marginBottom: 16 }}>
              <img src={t.image} alt={t.name} style={{ width: '100%' }} />
            </div>
            <div style={{ fontWeight: 700 }}>{t.name}</div>
            <div style={{ fontSize: 13, color: '#787A80' }}>{t.role}</div>
          </div>
        ))}
      </div>
    </section>
  );
};
EOF

cat > src/widgets/home-sections/testimonials/testimonials.jsx << 'EOF'
import { TESTIMONIAL } from 'shared/api/mocks';
export const Testimonials = () => (
  <section style={{ padding: '80px 0' }}>
    <div style={{ maxWidth: 1230, margin: '0 auto 40px', padding: '0 15px', textAlign: 'center' }}>
      <div className="section-eyebrow">Testimonials</div>
      <h2 className="section-title">What our students say</h2>
    </div>
    <div style={{ maxWidth: 1020, margin: '0 auto', padding: '40px 60px', background: 'white', borderRadius: 8, boxShadow: '0 20px 60px rgba(30,33,44,0.1)', position: 'relative' }}>
      <p style={{ fontSize: 24, lineHeight: 1.5, marginBottom: 24, paddingLeft: 40, position: 'relative' }}>
        <span style={{ position: 'absolute', left: 0, top: -10, fontSize: 60, color: '#FF3F3A', fontFamily: 'Georgia, serif', lineHeight: 1 }}>"</span>
        {TESTIMONIAL.text}
      </p>
      <div style={{ display: 'flex', gap: 16, alignItems: 'center', paddingLeft: 40 }}>
        <img src={TESTIMONIAL.avatar} alt={TESTIMONIAL.author} style={{ width: 60, height: 60, borderRadius: '50%' }} />
        <div><div style={{ fontWeight: 700 }}>{TESTIMONIAL.author}</div><div style={{ fontSize: 13, color: '#787A80' }}>{TESTIMONIAL.role}</div></div>
      </div>
    </div>
  </section>
);
EOF

cat > src/widgets/home-sections/latest-posts/latest-posts.jsx << 'EOF'
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
EOF

echo "=== Auth Modals ==="
cat > src/widgets/auth-modals/auth-modals.jsx << 'EOF'
import { useState } from 'react';
import { useAuth } from 'shared/lib/auth';
import { useToast } from 'shared/lib/toast';
import { Modal } from 'shared/ui/modal';
const inputStyle = { padding: '12px 16px', border: '1px solid #E5E8ED', borderRadius: 4, fontSize: 14, outline: 'none', width: '100%' };
export const AuthModals = ({ isOpen, mode, onClose, onSwitch }) => {
  const { login } = useAuth();
  const toast = useToast();
  const [email, setEmail] = useState('');
  const [pwd, setPwd] = useState('');
  const [name, setName] = useState('');
  const [remember, setRemember] = useState(false);

  const submit = (e) => {
    e.preventDefault();
    if (!email.includes('@')) { toast('Enter valid email'); return; }
    if (pwd.length < 4) { toast('Password too short'); return; }
    if (mode === 'signup' && !name.trim()) { toast('Enter your name'); return; }
    login(email);
    toast(mode === 'login' ? '✓ Signed in!' : '✓ Account created!');
    onClose();
  };

  if (!isOpen) return null;
  const isLogin = mode === 'login';

  return (
    <Modal isOpen={isOpen} onClose={onClose}>
      <h2 style={{ fontSize: 24, fontWeight: 900, marginBottom: 8, textAlign: 'center' }}>{isLogin ? 'Sign In' : 'Sign Up'}</h2>
      <p style={{ fontSize: 13, color: '#787A80', textAlign: 'center', marginBottom: 24 }}>{isLogin ? 'Sign in to access your account' : 'Registration takes less than a minute'}</p>
      <form onSubmit={submit} style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
        {!isLogin && <input style={inputStyle} placeholder="Full Name" value={name} onChange={(e) => setName(e.target.value)} />}
        <input style={inputStyle} placeholder="Email" type="email" value={email} onChange={(e) => setEmail(e.target.value)} />
        <input style={inputStyle} placeholder="Password" type="password" value={pwd} onChange={(e) => setPwd(e.target.value)} />
        <label style={{ display: 'flex', gap: 8, alignItems: 'center', fontSize: 13 }}>
          <input type="checkbox" checked={remember} onChange={(e) => setRemember(e.target.checked)} /> Remember me
        </label>
        <button type="submit" className="btn btn-primary btn-full">{isLogin ? 'Sign In' : 'Sign Up'}</button>
      </form>
      <div style={{ textAlign: 'center', marginTop: 16, fontSize: 13, color: '#787A80' }}>
        {isLogin ? "Don't have an account? " : 'Already have an account? '}
        <button onClick={() => onSwitch(isLogin ? 'signup' : 'login')} style={{ color: '#FF3F3A', fontWeight: 700 }}>{isLogin ? 'Sign up' : 'Sign in'}</button>
      </div>
    </Modal>
  );
};
EOF
echo "export * from './auth-modals';" > src/widgets/auth-modals/index.js

echo "=== Layout ==="
cat > src/app/layouts/main-layout.jsx << 'EOF'
import { useState } from 'react';
import { Outlet, useLocation } from 'react-router-dom';
import { Header } from 'widgets/header';
import { Footer } from 'widgets/footer';
import { AuthModals } from 'widgets/auth-modals';
export const MainLayout = () => {
  const [authOpen, setAuthOpen] = useState(false);
  const [authMode, setAuthMode] = useState('login');
  const openAuth = (mode) => { setAuthMode(mode); setAuthOpen(true); };
  return (
    <div>
      <Header onOpenAuth={openAuth} />
      <main><Outlet /></main>
      <Footer />
      <AuthModals isOpen={authOpen} mode={authMode} onClose={() => setAuthOpen(false)} onSwitch={(m) => setAuthMode(m)} />
    </div>
  );
};
EOF
echo "export * from './main-layout';" > src/app/layouts/index.js

echo "=== Pages ==="
cat > src/pages/home/home.jsx << 'EOF'
import { Hero } from 'widgets/home-sections/hero/hero';
import { Stats } from 'widgets/home-sections/stats/stats';
import { Why } from 'widgets/home-sections/why/why';
import { Featured } from 'widgets/home-sections/featured/featured';
import { Approach } from 'widgets/home-sections/approach/approach';
import { Lectures } from 'widgets/home-sections/lectures/lectures';
import { Certificate } from 'widgets/home-sections/certificate/certificate';
import { Team } from 'widgets/home-sections/team/team';
import { Testimonials } from 'widgets/home-sections/testimonials/testimonials';
import { LatestPosts } from 'widgets/home-sections/latest-posts/latest-posts';
import { Newsletter } from 'widgets/newsletter';
export const HomePage = () => (
  <div className="pageFadeIn">
    <Hero /><Stats /><Why /><Featured /><Approach /><Lectures /><Certificate /><Team /><Testimonials /><LatestPosts /><Newsletter />
  </div>
);
EOF
echo "export * from './home';" > src/pages/home/index.js

cat > src/pages/about/about.jsx << 'EOF'
import { Why } from 'widgets/home-sections/why/why';
import { Stats } from 'widgets/home-sections/stats/stats';
import { Team } from 'widgets/home-sections/team/team';
import { Testimonials } from 'widgets/home-sections/testimonials/testimonials';
import { Newsletter } from 'widgets/newsletter';
import { IMAGES } from 'shared/config/images';
export const AboutPage = () => (
  <div className="pageFadeIn">
    <section style={{ padding: '80px 0', background: '#FEDCD9' }}>
      <div className="container" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 80, alignItems: 'center' }}>
        <div>
          <div className="section-eyebrow">About us</div>
          <h1 className="section-title" style={{ marginBottom: 24 }}>Createx Online School</h1>
          <p style={{ fontSize: 15, color: '#787A80', lineHeight: 1.7, marginBottom: 24 }}>Createx Online School is a leader in online studying. We have lots of courses and programs from the main market experts.</p>
          <div style={{ display: 'flex', gap: 16 }}>
            <button className="btn btn-outline">Explore events</button>
            <button className="btn btn-primary">Browse courses</button>
          </div>
        </div>
        <img src={IMAGES.whyImage} alt="About" style={{ borderRadius: 8 }} />
      </div>
    </section>
    <Stats /><Why /><Team /><Testimonials /><Newsletter />
  </div>
);
EOF
echo "export * from './about';" > src/pages/about/index.js

cat > src/pages/courses/courses.jsx << 'EOF'
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { CourseCard } from 'entities/course';
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
EOF
echo "export * from './courses';" > src/pages/courses/index.js

cat > src/pages/course/course.jsx << 'EOF'
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
EOF
echo "export * from './course';" > src/pages/course/index.js

cat > src/pages/events/events.jsx << 'EOF'
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
EOF
echo "export * from './events';" > src/pages/events/index.js

cat > src/pages/event/event.jsx << 'EOF'
import { useParams, useNavigate } from 'react-router-dom';
import { EVENTS } from 'shared/api/mocks';
import { Newsletter } from 'widgets/newsletter';
import { IMAGES } from 'shared/config/images';
import { useState } from 'react';
import { useToast } from 'shared/lib/toast';
export const EventPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const toast = useToast();
  const event = EVENTS.find(e => e.id === Number(id)) || EVENTS[0];
  const [form, setForm] = useState({ name: '', email: '', phone: '' });
  const submit = (e) => { e.preventDefault(); if (!form.name || !form.email.includes('@')) { toast('Fill all fields'); return; } toast('✓ Registered!'); };
  return (
    <div className="pageFadeIn">
      <section style={{ padding: '60px 0', background: '#FEDCD9', textAlign: 'center' }}>
        <div className="section-eyebrow">Online lecture</div>
        <h1 className="section-title" style={{ maxWidth: 900, margin: '0 auto' }}>{event.title}</h1>
      </section>
      <div className="container" style={{ padding: '40px 15px', display: 'grid', gridTemplateColumns: '1fr 380px', gap: 60 }}>
        <div>
          <h2 style={{ fontSize: 28, fontWeight: 900, marginBottom: 24 }}>We will talk about:</h2>
          {[1,2,3,4].map(n => (
            <div key={n} style={{ marginBottom: 20 }}>
              <div style={{ fontWeight: 700, marginBottom: 8 }}><span style={{ color: '#FF3F3A' }}>{n === 1 ? '—' : '+'}</span> Theme {n}. Aliquet lectus urna viverra in odio.</div>
              {n === 1 && <p style={{ color: '#787A80', fontSize: 14, paddingLeft: 24 }}>Nulla amet, sagittis potenti rhoncus sit. Elit lectus nec pulvinar aliquet donec enim, ornare. Lacus facilisi curabitur turpis varius mauris.</p>}
            </div>
          ))}
          <h3 style={{ fontSize: 20, fontWeight: 900, marginTop: 40, marginBottom: 12 }}>Speaker</h3>
          <div style={{ display: 'grid', gridTemplateColumns: '200px 1fr', gap: 24, alignItems: 'center', marginBottom: 40 }}>
            <img src={IMAGES.team6} alt="Speaker" style={{ borderRadius: 8 }} />
            <div>
              <div style={{ fontWeight: 900, fontSize: 20, marginBottom: 8 }}>Kathryn Murphy</div>
              <div style={{ fontSize: 14, color: '#787A80', marginBottom: 12 }}>Analyst and Marketing specialist in IT company</div>
              <p style={{ fontSize: 14, color: '#787A80', lineHeight: 1.7 }}>Mattis adipiscing aliquam eu proin metus a iaculis faucibus. Tempus curabitur venenatis.</p>
            </div>
          </div>
        </div>
        <aside>
          <div style={{ border: '1px solid #E5E8ED', borderRadius: 8, padding: 32, position: 'sticky', top: 120 }}>
            <div style={{ marginBottom: 20 }}>
              <div style={{ fontSize: 12, fontWeight: 700, color: '#787A80', textTransform: 'uppercase' }}>Time</div>
              <div style={{ color: '#FF3F3A', fontWeight: 700 }}>{event.month} {event.day}, {event.time}</div>
            </div>
            <div style={{ marginBottom: 24 }}>
              <div style={{ fontSize: 12, fontWeight: 700, color: '#787A80', textTransform: 'uppercase' }}>Price</div>
              <div style={{ fontSize: 32, fontWeight: 900 }}>Free</div>
            </div>
            <button className="btn btn-primary btn-full" onClick={() => { toast('✓ Registered!'); }}>Join the event</button>
          </div>
        </aside>
      </div>
      <section style={{ padding: '60px 0' }}>
        <div className="container">
          <div className="section-eyebrow">Don't miss the event</div>
          <h2 className="section-title" style={{ marginBottom: 32 }}>Leave a request</h2>
          <form onSubmit={submit} style={{ maxWidth: 500, display: 'flex', flexDirection: 'column', gap: 16 }}>
            <input className="input" placeholder="Full Name" value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} />
            <input className="input" placeholder="Email" type="email" value={form.email} onChange={(e) => setForm({ ...form, email: e.target.value })} />
            <input className="input" placeholder="Phone" value={form.phone} onChange={(e) => setForm({ ...form, phone: e.target.value })} />
            <button className="btn btn-primary" type="submit">Join the event</button>
          </form>
        </div>
      </section>
      <Newsletter />
    </div>
  );
};
EOF
echo "export * from './event';" > src/pages/event/index.js

cat > src/pages/blog/blog.jsx << 'EOF'
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
EOF
echo "export * from './blog';" > src/pages/blog/index.js

cat > src/pages/post/post.jsx << 'EOF'
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
EOF
echo "export * from './post';" > src/pages/post/index.js

cat > src/pages/contacts/contacts.jsx << 'EOF'
import { useState } from 'react';
import { Newsletter } from 'widgets/newsletter';
import { IMAGES } from 'shared/config/images';
import { useToast } from 'shared/lib/toast';
export const ContactsPage = () => {
  const toast = useToast();
  const [form, setForm] = useState({ firstName: '', lastName: '', email: '', phone: '', message: '' });
  const submit = (e) => { e.preventDefault(); if (!form.firstName || !form.email.includes('@')) { toast('Fill required fields'); return; } toast('✓ Message sent!'); setForm({ firstName: '', lastName: '', email: '', phone: '', message: '' }); };
  return (
    <div className="pageFadeIn">
      <section style={{ padding: '60px 0', background: '#FEDCD9', textAlign: 'center' }}>
        <div className="section-eyebrow">Contact info</div>
        <h1 className="section-title">Get in touch</h1>
      </section>
      <div className="container" style={{ padding: '40px 15px', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 60 }}>
        <div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 20, marginBottom: 40 }}>
            <div><div style={{ fontSize: 12, color: '#787A80', fontWeight: 700, textTransform: 'uppercase' }}>Talk to us</div><div style={{ color: '#FF3F3A', fontWeight: 700 }}>hello@createx.com</div></div>
            <div><div style={{ fontSize: 12, color: '#787A80', fontWeight: 700, textTransform: 'uppercase' }}>Call us</div><div style={{ color: '#FF3F3A', fontWeight: 700 }}>(405) 555-0128</div></div>
            <div><div style={{ fontSize: 12, color: '#787A80', fontWeight: 700, textTransform: 'uppercase' }}>Address</div><div>2464 Royal Ln. Mesa, New Jersey 45463, USA</div></div>
          </div>
          <div style={{ display: 'flex', gap: 16, marginBottom: 40 }}>{['f','t','in','ig','yt'].map(s => <a key={s} href="/" style={{ color: '#787A80' }}>{s}</a>)}</div>
          <img src={IMAGES.mapImage} alt="Map" style={{ width: '100%', borderRadius: 8 }} />
        </div>
        <div>
          <h2 style={{ fontSize: 28, fontWeight: 900, marginBottom: 24 }}>Drop us a line</h2>
          <form onSubmit={submit} style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 16 }}>
              <input className="input" placeholder="First Name*" value={form.firstName} onChange={(e) => setForm({ ...form, firstName: e.target.value })} />
              <input className="input" placeholder="Last Name*" value={form.lastName} onChange={(e) => setForm({ ...form, lastName: e.target.value })} />
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 16 }}>
              <input className="input" type="email" placeholder="Email*" value={form.email} onChange={(e) => setForm({ ...form, email: e.target.value })} />
              <input className="input" placeholder="Phone" value={form.phone} onChange={(e) => setForm({ ...form, phone: e.target.value })} />
            </div>
            <textarea className="input" placeholder="Message" rows={5} value={form.message} onChange={(e) => setForm({ ...form, message: e.target.value })} />
            <label style={{ display: 'flex', gap: 8, fontSize: 13 }}><input type="checkbox" /> I agree to receive communications from Createx Online School</label>
            <button className="btn btn-primary" type="submit" style={{ width: 'fit-content' }}>Send message</button>
          </form>
        </div>
      </div>
      <Newsletter />
    </div>
  );
};
EOF
echo "export * from './contacts';" > src/pages/contacts/index.js

cat > src/pages/not-found/not-found.jsx << 'EOF'
import { useNavigate } from 'react-router-dom';
export const NotFoundPage = () => {
  const navigate = useNavigate();
  return (
    <div className="pageFadeIn" style={{ minHeight: '60vh', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: 60, textAlign: 'center' }}>
      <h1 style={{ fontSize: 180, fontWeight: 900, lineHeight: 1, color: '#FF3F3A', letterSpacing: -10, marginBottom: 24 }}>404</h1>
      <h2 style={{ fontSize: 32, fontWeight: 900, marginBottom: 12 }}>Oops! Page not found</h2>
      <p style={{ color: '#787A80', marginBottom: 32 }}>The page you are looking for might have been removed or temporarily unavailable.</p>
      <button className="btn btn-primary" onClick={() => navigate('/')}>Back to HomePage</button>
    </div>
  );
};
EOF
echo "export * from './not-found';" > src/pages/not-found/index.js

echo "=== Router + App ==="
cat > src/app/router/router.jsx << 'EOF'
import { createBrowserRouter } from 'react-router-dom';
import { MainLayout } from 'app/layouts';
import { HomePage } from 'pages/home';
import { AboutPage } from 'pages/about';
import { CoursesPage } from 'pages/courses';
import { CoursePage } from 'pages/course';
import { EventsPage } from 'pages/events';
import { EventPage } from 'pages/event';
import { BlogPage } from 'pages/blog';
import { PostPage } from 'pages/post';
import { ContactsPage } from 'pages/contacts';
import { NotFoundPage } from 'pages/not-found';

export const router = createBrowserRouter([
  {
    path: '/',
    element: <MainLayout />,
    children: [
      { index: true, element: <HomePage /> },
      { path: 'about', element: <AboutPage /> },
      { path: 'courses', element: <CoursesPage /> },
      { path: 'courses/:id', element: <CoursePage /> },
      { path: 'events', element: <EventsPage /> },
      { path: 'events/:id', element: <EventPage /> },
      { path: 'blog', element: <BlogPage /> },
      { path: 'blog/:id', element: <PostPage /> },
      { path: 'contacts', element: <ContactsPage /> },
      { path: '*', element: <NotFoundPage /> },
    ],
  },
]);
EOF
echo "export * from './router';" > src/app/router/index.js

cat > src/app/app.jsx << 'EOF'
import { RouterProvider } from 'react-router-dom';
import { ToastProvider } from 'shared/lib/toast';
import { AuthProvider } from 'shared/lib/auth';
import { router } from './router';
export const App = () => (
  <ToastProvider>
    <AuthProvider>
      <RouterProvider router={router} />
    </AuthProvider>
  </ToastProvider>
);
EOF

cat > src/main.jsx << 'EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import { App } from 'app/app';
import 'app/styles/index.css';
ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode><App /></React.StrictMode>
);
EOF

echo ""
echo "==================================================="
echo "✅ CREATEX УСТАНОВЛЕН ПОЛНОСТЬЮ"
echo "==================================================="
echo ""
echo "Запусти: npm run dev"
echo ""
