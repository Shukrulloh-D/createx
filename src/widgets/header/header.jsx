import { Link, NavLink, useNavigate } from 'react-router-dom';
import { useAuth } from 'shared/lib/auth';

const styles = {
  header: { background: 'white', borderBottom: '1px solid #E5E8ED', position: 'sticky', top: 0, zIndex: 100 },
  inner: { maxWidth: 1230, margin: '0 auto', padding: '0 15px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', height: 90 },
  logo: { display: 'flex', alignItems: 'center' },
  logoImg: { height: 30 },
  nav: { display: 'flex', gap: 28, fontSize: 15, fontWeight: 500 },
  actions: { display: 'flex', gap: 16, alignItems: 'center' },
  authBtn: { fontSize: 14, fontWeight: 500, background: 'none', border: 'none', cursor: 'pointer', color: '#1E212C' },
  logoutBtn: { fontSize: 13, color: '#787A80', background: 'none', border: 'none', cursor: 'pointer' },
};

const NAV = [
  { to: '/about', label: 'About Us' },
  { to: '/courses', label: 'Courses' },
  { to: '/events', label: 'Events' },
  { to: '/blog', label: 'Blog' },
  { to: '/contacts', label: 'Contacts' },
];

export const Header = ({ onOpenAuth }) => {
  const navigate = useNavigate();
  const { user, logout } = useAuth();

  return (
    <header style={styles.header}>
      <div style={styles.inner}>
        <Link to="/" style={styles.logo}>
          <img src="/logo.svg" alt="Createx" style={styles.logoImg} />
        </Link>

        <nav style={styles.nav}>
          {NAV.map(item => (
            <NavLink
              key={item.to}
              to={item.to}
              style={({ isActive }) => ({ color: isActive ? '#FF3F3A' : '#1E212C' })}
            >
              {item.label}
            </NavLink>
          ))}
        </nav>

        <div style={styles.actions}>
          <button className="btn btn-primary" onClick={() => navigate('/contacts')}>
            Get consultation
          </button>
          {user ? (
            <>
              <span style={{ fontSize: 14, fontWeight: 600 }}>{user.name || 'User'}</span>
              <button style={styles.logoutBtn} onClick={logout}>Logout</button>
            </>
          ) : (
            <button style={styles.authBtn} onClick={() => onOpenAuth('login')}>
              Log in / Register
            </button>
          )}
        </div>
      </div>
    </header>
  );
};
