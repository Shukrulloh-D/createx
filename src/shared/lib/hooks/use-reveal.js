import { useEffect, useRef } from 'react';
export const useReveal = (delay = 0) => {
  const ref = useRef(null);
  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    const o = new IntersectionObserver(([e]) => { if (e.isIntersecting) { setTimeout(() => e.target.classList.add('visible'), delay); o.unobserve(e.target); } }, { threshold: 0.1 });
    o.observe(el);
    return () => o.disconnect();
  }, [delay]);
  return ref;
};
