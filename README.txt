VANUATU BUSINESS HUB — SUPABASE WEBSITE

Files
- index.html: homepage
- directory.html: approved public business directory
- register.html: free business listing form
- admin-login.html and admin.html: administrator access and review dashboard
- supabase-config.js: browser-safe Supabase project URL and publishable/anon key
- supabase-schema.sql: database schema and row-level security policies
- assets/: approved Hub logo and emblem

IMPORTANT BEFORE DEPLOYMENT
1. Open supabase-config.js and enter your own Supabase Project URL and publishable (or legacy anon) key.
2. If you already configured an earlier copy, copy your edited supabase-config.js into this updated package. The supplied file intentionally contains placeholders.
3. Never put a Supabase secret/service_role key or database password in website files.
4. Confirm the SQL schema and row-level security policies have run successfully.
5. Test a new business submission, public directory visibility, administrator login, approval, rejection and sign-out.
6. Configure the deployed website URL in Supabase Authentication URL Configuration if email/password auth redirects require it.

DEPLOYMENT
Upload the contents of this folder (not the outer folder) to your chosen static website host. Keep all files and the assets folder together.

This website is a starter marketplace. Before a public launch, test all flows and publish a privacy notice and contact details.

REGISTRATION PAGE DESIGN UPDATE
The registration page now places the business form on the left and a Vanuatu photo collage with a welcome message on the right. On smaller screens the image stacks below the form. The collage is stored at assets/vanuatu-business-hub-banner.jpg.

IMPORTANT: If you already entered your own Supabase Project URL and publishable/anon key in supabase-config.js, keep that configured file when replacing your website files. Do not use a service_role or secret key in the website.
