import { createContext, useContext, useState } from 'react';
const Ctx = createContext();
export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const login = (email) => setUser({ email, name: 'User' });
  const logout = () => setUser(null);
  return <Ctx.Provider value={{ user, login, logout }}>{children}</Ctx.Provider>;
};
export const useAuth = () => useContext(Ctx);
