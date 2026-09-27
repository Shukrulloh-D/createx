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
