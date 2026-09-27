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
