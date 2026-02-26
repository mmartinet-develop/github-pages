import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

export default defineConfig({
  integrations: [
    starlight({
      title: "Architecture Documentation",
      description:
        "Documentation architecture complète - Diagrammes et spécifications",
      defaultLocale: "fr",
      locales: {
        fr: {
          label: "Français",
          lang: "fr",
        },
      },
      sidebar: [
        {
          label: "Architecture",
          items: [
            { label: "Vue d'ensemble", link: "/architecture/overview/" },
            { label: "Diagrammes", link: "/architecture/diagrams/" },
            { label: "Réseau", link: "/architecture/network/" },
            { label: "Sécurité", link: "/architecture/security/" },
            { label: "Aspects techniques", link: "/architecture/technical/" },
          ],
        },
        {
          label: "Component A",
          items: [
            { label: "Vue d'ensemble", link: "/component-a/overview/" },
            {
              label: "Règles de traitement",
              link: "/component-a/processing-rules/",
            },
            { label: "Tests", link: "/component-a/tests/" },
          ],
        },
      ],
      customCss: ["./src/styles/custom.css"],
      social: {
        github: "https://github.com",
      },
      head: [],
    }),
  ],
  output: "static",
  outDir: "./dist",
});
