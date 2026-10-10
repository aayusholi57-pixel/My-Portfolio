// Optional dynamic homepage project rendering. Include this before </body> after
// configuring admin-config.js. Falls back to existing static cards if config/network fails.
(async function(){
 const cfg=window.PORTFOLIO_ADMIN_CONFIG||{};
 if(!window.supabase||!cfg.url||!cfg.anonKey||cfg.url.includes('YOUR_')||cfg.anonKey.includes('YOUR_'))return;
 try{
  const db=window.supabase.createClient(cfg.url,cfg.anonKey);
  const {data,error}=await db.from('portfolio_projects').select('id,title,icon,description,tags,repo_url,demo_url,sort_order').eq('published',true).order('sort_order').order('created_at');
  if(error||!data||!data.length)return;
  const root=document.querySelector('#projects .projects');if(!root)return;
  const frag=document.createDocumentFragment();
  data.forEach((p,i)=>{
   const article=document.createElement('article');article.className='project';
   const top=document.createElement('div');top.className='project-top';
   const idx=document.createElement('span');idx.className='project-index';idx.textContent='PROJECT / '+String(i+1).padStart(2,'0');
   const icon=document.createElement('span');icon.className='project-icon';icon.textContent=p.icon||'✦';top.append(idx,icon);
   const h=document.createElement('h3');h.textContent=p.title;
   const desc=document.createElement('p');desc.textContent=p.description;
   const tags=document.createElement('div');tags.className='tags';(p.tags||[]).slice(0,12).forEach(t=>{const el=document.createElement('span');el.className='tag';el.textContent=t;tags.append(el)});
   article.append(top,h,desc,tags);
   const links=document.createElement('div');links.className='actions';
   [[p.repo_url,'View repository ↗'],[p.demo_url,'Live demo ↗']].forEach(([url,label])=>{if(!url)return;try{const u=new URL(url);if(!['http:','https:'].includes(u.protocol))return;const a=document.createElement('a');a.className='text-link';a.href=u.href;a.target='_blank';a.rel='noreferrer';a.textContent=label;links.append(a)}catch{}});
   article.append(links);frag.append(article);
  });
  root.replaceChildren(frag);
  window.dispatchEvent(new CustomEvent("portfolio-projects-updated"));
 }catch(e){console.warn('Portfolio CMS unavailable; showing static projects.',e)}
})();
