export const Button = ({ children, variant = 'primary', className = '', full, ...props }) => (
  <button className={`btn btn-${variant} ${full ? 'btn-full' : ''} ${className}`} {...props}>{children}</button>
);
