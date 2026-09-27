import { Why } from 'widgets/home-sections/why/why';
import { Stats } from 'widgets/home-sections/stats/stats';
import { Team } from 'widgets/home-sections/team/team';
import { Testimonials } from 'widgets/home-sections/testimonials/testimonials';
import { Newsletter } from 'widgets/newsletter';
import { IMAGES } from 'shared/config/images';
export const AboutPage = () => (
  <div className="pageFadeIn">
    <section style={{ padding: '80px 0', background: '#FEDCD9' }}>
      <div className="container" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 80, alignItems: 'center' }}>
        <div>
          <div className="section-eyebrow">About us</div>
          <h1 className="section-title" style={{ marginBottom: 24 }}>Createx Online School</h1>
          <p style={{ fontSize: 15, color: '#787A80', lineHeight: 1.7, marginBottom: 24 }}>Createx Online School is a leader in online studying. We have lots of courses and programs from the main market experts.</p>
          <div style={{ display: 'flex', gap: 16 }}>
            <button className="btn btn-outline">Explore events</button>
            <button className="btn btn-primary">Browse courses</button>
          </div>
        </div>
        <img src={IMAGES.whyImage} alt="About" style={{ borderRadius: 8 }} />
      </div>
    </section>
    <Stats /><Why /><Team /><Testimonials /><Newsletter />
  </div>
);
