const ph = (label, w = 400, h = 300) => `https://placehold.co/${w}x${h}/F4F5F6/787A80?text=${encodeURIComponent(label)}&font=lato`;
export const IMAGES = {
  heroIllustration: ph('Hero+Illustration', 600, 550),
  whyImage: ph('About+Image', 705, 560),
  course1: ph('Course+1', 390, 240), course2: ph('Course+2', 390, 240), course3: ph('Course+3', 390, 240),
  course4: ph('Course+4', 390, 240), course5: ph('Course+5', 390, 240), course6: ph('Course+6', 390, 240),
  approachIllustration: ph('Approach', 550, 500),
  certificate: ph('Certificate', 705, 500),
  team1: ph('Team+1', 285, 340), team2: ph('Team+2', 285, 340), team3: ph('Team+3', 285, 340), team4: ph('Team+4', 285, 340),
  team5: ph('Team+5', 285, 340), team6: ph('Team+6', 285, 340), team7: ph('Team+7', 285, 340), team8: ph('Team+8', 285, 340),
  post1: ph('Post+1', 390, 300), post2: ph('Post+2', 390, 300), post3: ph('Post+3', 390, 300),
  post4: ph('Post+4', 390, 300), post5: ph('Post+5', 390, 300), post6: ph('Post+6', 390, 300),
  blogSingle: ph('Blog+Single', 810, 360),
  newsletterIllustration: ph('Newsletter', 400, 400),
  mapImage: ph('Map', 705, 412),
  courseHero: ph('Course+Hero', 458, 600),
  courseProgram: ph('Program', 550, 500),
  author: ph('Author', 100, 100),
};
