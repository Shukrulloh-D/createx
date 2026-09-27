import { RouterProvider } from 'react-router-dom';
import { ToastProvider } from '../shared/lib/toast/toast';
import { AuthProvider } from '../shared/lib/auth/auth-context';
import { router } from './router';
export const App = () => (
  <ToastProvider>
    <AuthProvider>
      <RouterProvider router={router} />
    </AuthProvider>
  </ToastProvider>
);
