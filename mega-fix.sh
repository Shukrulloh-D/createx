set -e
cd ~/Createx 2>/dev/null || true

# ============================================================
# 1. Чистим старые скрипты
# ============================================================
rm -f setup.sh setup2.sh setup-all.sh widgets.sh fix.sh setup-part2.sh 2>/dev/null || true
echo "[1/6] Cleanup done"

# ============================================================
# 2. Vite + jsconfig с алиасами
# ============================================================
cat > vite.config.js << 'ENDVITE'
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { fileURLToPath, URL } from 'node:url';

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      'app': fileURLToPath(new URL('./src/app', import.meta.url)),
      'pages': fileURLToPath(new URL('./src/pages', import.meta.url)),
      'widgets': fileURLToPath(new URL('./src/widgets', import.meta.url)),
      'features': fileURLToPath(new URL('./src/features', import.meta.url)),
      'entities': fileURLToPath(new URL('./src/entities', import.meta.url)),
      'shared': fileURLToPath(new URL('./src/shared', import.meta.url)),
    },
  },
});
ENDVITE

cat > jsconfig.json << 'ENDJS'
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "app/*": ["src/app/*"],
      "pages/*": ["src/pages/*"],
      "widgets/*": ["src/widgets/*"],
      "features/*": ["src/features/*"],
      "entities/*": ["src/entities/*"],
      "shared/*": ["src/shared/*"]
    }
  },
  "include": ["src/**/*"]
}
ENDJS
echo "[2/6] Config done"

# ============================================================
# 3. Логотип в public/, favicon
# ============================================================
if [ -f "public/images/logo.svg" ]; then
  mv public/images/logo.svg public/logo.svg
fi

cat > index.html << 'ENDHTML'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/logo.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Createx — Online Courses</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700;900&display=swap" rel="stylesheet" />
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
ENDHTML
echo "[3/6] HTML done"

# ============================================================
# 4. Переименование картинок с плохими именами
# ============================================================
cd public/images

rename() {
  if [ -f "$1" ] && [ "$1" != "$2" ]; then
    mv "$1" "$2" && echo "  $1 -> $2"
  fi
}

# Team (аватары — из твоего скрина видно что там люди)
rename "[[.png" "team-1.png"
rename "]]p.png" "team-2.png"
rename "222.png" "team-3.png"
rename "123213123 (1).png" "team-4.png"
rename "ddd (1).png" "team-5.png"
rename "fdfdf.png" "team-6.png"
rename "rprrr.png" "team-7.png"
rename "jhnhmhnh.png" "team-8.png"

# Карта и сертификат
rename "image(11).png" "map.png"
rename "image(1).png" "certificate.png"

# Спикер / куратор
rename "curator-image.png" "curator.png"

# Play button (в hero)
rename "hover.png" "play-button.png"

# Testimonial аватар
rename "hover (1).png" "testimonial-avatar.png"

# Иллюстрации (главные, по порядку)
rename "illustration.png" "hero.png"
rename "illustration(1).png" "why.png"
rename "illustration(2).png" "course-1.png"
rename "illustration(3).png" "course-2.png"
rename "illustration(4).png" "course-3.png"
rename "illustration(5).png" "course-4.png"
rename "illustration(6).png" "course-5.png"
rename "illustration(7).png" "course-6.png"
rename "illustration(8).png" "approach.png"
rename "illustration(9).png" "blog-1.png"
rename "illustration(10).png" "blog-2.png"
rename "illustration(11).png" "blog-3.png"

# Блог (наушники, растения, диплом)
rename "ds.png" "blog-4.png"
rename "fddvd.png" "blog-5.png"
rename "fnbfng.png" "blog-6.png"
rename "cxvzxcv.png" "blog-7.png"
rename "sadasas (1).png" "blog-8.png"
rename "sofsd (1).png" "blog-9.png"
rename "qqq.png" "blog-10.png"
rename "werqwer.jpg" "blog-11.jpg"

# Остальные аватары
rename "image(2).png" "avatar-1.png"
rename "image(3).png" "avatar-2.png"
rename "image(4).png" "avatar-3.png"
rename "image(10).png" "avatar-4.png"
rename "image.jpg" "keyboard.jpg"
rename "image(9).png" "keyboard-2.png"

# Декоративные
rename "image(5).png" "decor-1.png"
rename "image(6).png" "decor-2.png"
rename "image(7).png" "decor-3.png"
rename "image(8).png" "decor-4.png"
rename "Vector.png" "decor-circle.png"
rename "adsd.jpg" "office.jpg"
rename "image(1).jpg" "office-1.jpg"
rename "image(2).jpg" "office-2.jpg"

cd ../..
echo "[4/6] Renames done"

# ============================================================
# 5. Обновляем config/images.js
# ============================================================
mkdir -p src/shared/config

cat > src/shared/config/images.js << 'ENDIMG'
// ВСЕ КАРТИНКИ ПРОЕКТА — меняется только тут
const img = (name) => `/images/${name}`;

export const IMAGES = {
  logo: '/logo.svg',

  // Hero (главная)
  hero: img('hero.png'),
  playButton: img('play-button.png'),

  // Why Createx
  why: img('why.png'),

  // Featured Courses (6)
  course1: img('course-1.png'),
  course2: img('course-2.png'),
  course3: img('course-3.png'),
  course4: img('course-4.png'),
  course5: img('course-5.png'),
  course6: img('course-6.png'),

  // Approach illustration
  approach: img('approach.png'),

  // Certificate
  certificate: img('certificate.png'),

  // Team (8)
  team1: img('team-1.png'),
  team2: img('team-2.png'),
  team3: img('team-3.png'),
  team4: img('team-4.png'),
  team5: img('team-5.png'),
  team6: img('team-6.png'),
  team7: img('team-7.png'),
  team8: img('team-8.png'),

  // Benefit icons
  iconStructure: img('ic-structure.png'),
  iconChat: img('ic-chat.png'),
  iconTarget: img('ic-target.png'),
  iconCalendar: img('ic-calendar.png'),

  // Contacts map
  map: img('map.png'),

  // Blog / Posts
  blog1: img('blog-1.png'),
  blog2: img('blog-2.png'),
  blog3: img('blog-3.png'),
  blog4: img('blog-4.png'),
  blog5: img('blog-5.png'),
  blog6: img('blog-6.png'),

  // Avatars
  avatar1: img('avatar-1.png'),
  avatar2: img('avatar-2.png'),
  avatar3: img('avatar-3.png'),
  avatar4: img('avatar-4.png'),
  curator: img('curator.png'),
  testimonialAvatar: img('testimonial-avatar.png'),

  // Newsletter
  newsletterIllustration: img('illustration.png'),

  // Course page
  courseHero: img('course-4.png'),
};
ENDIMG

echo "export * from './images';" > src/shared/config/index.js
echo "[5/6] Config done"

# ============================================================
# 6. Header с логотипом как img
# ============================================================
cat > src/widgets/header/header.jsx << 'ENDHEADER'
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
ENDHEADER

echo "export * from './header';" > src/widgets/header/index.js
echo "[6/6] Header done"

echo ""
echo "======================================"
echo "ALL DONE"
echo "======================================"
echo ""
echo "Теперь Ctrl+C на dev-сервере и:"
echo "  npm run dev"
echo ""
