{inputs}: {
  marketplaces = {
    opendatahub-skills = "opendatahub-io/skills-registry";
    ponytail = "DietrichGebert/ponytail";
    samber = "samber/cc";
    tag1consulting = "tag1consulting/claude-plugins";
  };

  sources = {
    cc-skills-golang = inputs.cc-skills-golang.outPath;
    ponytail = inputs.ponytail.outPath;
    superpowers = inputs.superpowers.outPath;
  };
}
