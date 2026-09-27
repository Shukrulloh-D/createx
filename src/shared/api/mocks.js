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
  { id: 1, category: 'Marketing', date: 'September 4, 2020', readTime: '36 min', title: 'What is traffic arbitrage and does it really make money?', excerpt: 'Pharetra, ullamcorper iaculis viverra parturient sed id sed.', action: 'Listen', tagType: 'Podcast', image: IMAGES.blog1 },
  { id: 2, category: 'Management', date: 'August 25, 2020', readTime: '45 min', title: 'What to do and who to talk to if you want to get feedback on the product', excerpt: 'Neque a, senectus consectetur odio in aliquet nec eu.', action: 'Watch', tagType: 'Video', image: IMAGES.blog2 },
  { id: 3, category: 'Design', date: 'August 8, 2020', readTime: '36 min', title: 'Should you choose a creative profession?', excerpt: 'Curabitur nisl tincidunt eros venenatis vestibulum ac placerat.', action: 'Read', tagType: 'Article', image: IMAGES.blog3 },
  { id: 4, category: 'HR & Recruiting', date: 'August 3, 2020', readTime: '36 min', title: 'HR statistics: job search, interviews, hiring and recruiting', excerpt: 'Massa, lectus nibh consectetur aliquet nunc risus aenean.', action: 'Read', tagType: 'Article', image: IMAGES.blog4 },
  { id: 5, category: 'Development', date: 'September 1, 2020', readTime: '54 min', title: 'How to choose the first programming language for a beginner', excerpt: 'Turpis sed at magna laoreet gravida consequat tortor placerat.', action: 'Read', tagType: 'Article', image: IMAGES.blog5 },
  { id: 6, category: 'Design', date: 'July 20, 2020', readTime: '36 min', title: 'What are color profiles and how they work in graphic design', excerpt: 'Aliquam vulputate, tortor tempor, orci nisi convallis aenean.', action: 'Listen', tagType: 'Podcast', image: IMAGES.blog6 },
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
