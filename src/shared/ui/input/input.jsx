export const Input = ({ label, error, className = '', ...props }) => (
  <div style={{ display: 'flex', flexDirection: 'column', gap: 6, width: '100%' }}>
    {label && <label style={{ fontSize: 14, fontWeight: 500 }}>{label}</label>}
    <input className={`input ${className}`} {...props} />
    {error && <span style={{ color: '#FF3F3A', fontSize: 12 }}>{error}</span>}
  </div>
);
