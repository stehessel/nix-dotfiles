{inputs}: {
  marketplaces = {
    opendatahub-skills = "opendatahub-io/skills-registry";
    ponytail = "DietrichGebert/ponytail";
    samber = "samber/cc";
    tag1consulting = "tag1consulting/claude-plugins";
  };

  skills.supabase-postgres-best-practices = "${inputs.supabase-agent-skills}/skills/supabase-postgres-best-practices";

  sources = {
    cc-skills-golang = inputs.cc-skills-golang.outPath;
    ponytail = inputs.ponytail.outPath;
    superpowers = inputs.superpowers.outPath;
  };
}
