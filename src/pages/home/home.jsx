import { Hero } from '../../widgets/home-sections/hero/hero';
import { Stats } from '../../widgets/home-sections/stats/stats';
import { Why } from '../../widgets/home-sections/why/why';
import { Featured } from '../../widgets/home-sections/featured/featured';
import { Approach } from '../../widgets/home-sections/approach/approach';
import { Lectures } from '../../widgets/home-sections/lectures/lectures';
import { Certificate } from '../../widgets/home-sections/certificate/certificate';
import { Team } from '../../widgets/home-sections/team/team';
import { Testimonials } from '../../widgets/home-sections/testimonials/testimonials';
import { LatestPosts } from '../../widgets/home-sections/latest-posts/latest-posts';
import { Newsletter } from '../../widgets/newsletter';
export const HomePage = () => (
  <div className="pageFadeIn">
    <Hero /><Stats /><Why /><Featured /><Approach /><Lectures /><Certificate /><Team /><Testimonials /><LatestPosts /><Newsletter />
  </div>
);
