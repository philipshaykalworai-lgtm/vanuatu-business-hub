// Add your Supabase Project URL and anon/public key here.
// Supabase Dashboard > Project Settings > API.
// It is safe to use the anon/public key in a browser ONLY with the RLS policies
// in supabase-schema.sql enabled. NEVER put a service_role key in this file.
window.VBH_SUPABASE_URL = "PASTE_YOUR_PROJECT_URL_HERE";
window.VBH_SUPABASE_ANON_KEY = "PASTE_YOUR_ANON_PUBLIC_KEY_HERE";
window.vbhSupabaseReady = function () {
  return window.supabase &&
    window.VBH_SUPABASE_URL.startsWith("https://") &&
    !window.VBH_SUPABASE_URL.includes("PASTE_") &&
    window.VBH_SUPABASE_ANON_KEY &&
    !window.VBH_SUPABASE_ANON_KEY.includes("PASTE_");
};
