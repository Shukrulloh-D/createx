import { createBrowserRouter } from 'react-router-dom';
import { MainLayout } from '../layouts/main-layout';
import { HomePage } from '../../pages/home';
import { AboutPage } from '../../pages/about';
import { CoursesPage } from '../../pages/courses';
import { CoursePage } from '../../pages/course';
import { EventsPage } from '../../pages/events';
import { EventPage } from '../../pages/event';
import { BlogPage } from '../../pages/blog';
import { PostPage } from '../../pages/post';
import { ContactsPage } from '../../pages/contacts';
import { NotFoundPage } from '../../pages/not-found';

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
