# Guide d'installation et utilisation

## 🎯 Architecture de la solution

Votre documentation utilise une stack moderne, automatisée et sans dépendances externes:

```
Source (docs/)
    ├── *.md (Markdown)
    ├── *.puml (PlantUML)
    └── *.drawio (DrawIO)
           ↓
    [GitHub Actions Workflow]
           ↓
    Génération d'images (SVG)
           ↓
    Build MkDocs
           ↓
    Site statique HTML
           ↓
    Publish sur GitHub Pages
```

## 🚀 Installation locale

### Prérequis système

```bash
# macOS
brew install python3 plantuml openjdk

# Linux (Ubuntu/Debian)
sudo apt-get install python3 python3-pip plantuml default-jre

# Node.js (pour DrawIO)
curl -fsSL https://get.volta.sh | bash
volta install node
```

### Installation du projet

```bash
# 1. Cloner et accéder au repo
cd github-pages

# 2. Exécuter le setup
chmod +x setup.sh
./setup.sh

# 3. Créer venv Python
python3 -m venv venv
source venv/bin/activate  # ou venv\Scripts\activate sur Windows

# 4. Installer les dépendances
pip install -r requirements.txt
```

## 📝 Utilisation

### Développement local

```bash
# Build une fois avec conversion des diagrammes
chmod +x build-docs.sh
./build-docs.sh

# Ou servir en mode live (watch)
mkdocs serve
```

Accédez à: `http://localhost:8000`

### Structure des fichiers

```
docs/
├── index.md                 # Page d'accueil
├── architecture/
│   ├── index.md            # Page principale section
│   ├── overview.md
│   ├── network.md
│   ├── security.md
│   ├── technical.md
│   ├── diagrams.md
│   └── organization.drawio  # Diagramme DrawIO
│
├── component-a/
│   ├── index.md            # Page principale section
│   ├── component-a-processing-rules.md
│   ├── component-a-component-test.md
│   └── component-a.puml    # Diagramme PlantUML
│
└── assets/
    └── diagrams/           # ⚠️ GÉNÉRÉ AUTOMATIQUEMENT
        ├── organization.svg
        └── component-a.svg
```

## 🔄 Workflow automatisé

### 1️⃣ Push sur `main` → Auto-deploy

```bash
git push origin main
```

→ GitHub Actions:
- Convertit `.puml` → `.svg` (PlantUML)
- Convertit `.drawio` → `.svg` (DrawIO)
- Génère le site avec MkDocs
- Publie automatiquement sur GitHub Pages

### 2️⃣ Pull Request → Preview

Chaque PR génère une preview (artifacts tab)

## 📋 Configuration

### mkdocs.yml

Les pages principales sontprise en charge par la clé `nav`:

```yaml
nav:
  - Accueil: index.md
  - Architecture: architecture/index.md
  - Composants: component-a/index.md
```

Ajoutez une nouvelle section:

```yaml
  - [Nom de la section]: [repertoire]/index.md
```

### Tabs dans les pages

Utilisez la syntaxe pour créer des onglets:

```markdown
=== "Onglet 1"
    Contenu 1

=== "Onglet 2"
    ![Diagramme](../assets/diagrams/mon-schema.svg)
```

## 🎨 Références aux diagrammes

⚠️ **Important**: Tous les diagrammes générés sont dans `docs/assets/diagrams/`

```markdown
# Dans docs/architecture/index.md
![Mon diagramme](../assets/diagrams/organization.svg)

# Dans docs/component-a/index.md
![Composant](../assets/diagrams/component-a.svg)
```

## 🔧 Personnalisation

### Thème

Modifiez `mkdocs.yml`:

```yaml
theme:
  palette:
    primary: indigo      # blue, red, green, etc.
    accent: indigo
```

### Logo et favicon

```yaml
theme:
  logo: assets/logo.png
  favicon: assets/favicon.ico
```

### Langue

Changez `language: fr` en `language: en` ou autre code ISO

## 📊 Conversion manuelle des diagrammes

```bash
# PlantUML
plantuml -Tsvg -o docs/assets/diagrams docs/diagram.puml

# DrawIO
drawio -x -f svg -o docs/assets/diagrams/diagram.svg docs/diagram.drawio
```

## 🚨 Troubleshooting

| Problème | Solution |
|----------|----------|
| `plantuml: command not found` | `brew install plantuml` ou `sudo apt install plantuml` |
| `drawio: command not found` | `npm install -g @drawio/cli` |
| Imports markdown dans MkDocs ne marchent pas | MkDocs ne supporte pas l'import de markdown. Copiez le contenu ou utilisez des liens |
| Diagrammes ne s'affichent pas | Vérifiez le chemin relatif (`../assets/diagrams/`) |
| GitHub Pages ne déploie pas | Vérifiez la branche `gh-pages` existe, vérifiez les permissions |

## 🔐 Configuration GitHub Pages

1. Allez dans **Settings** > **Pages**
2. Source: **GitHub Actions**
3. (Devrait être détecté automatiquement)

## 💡 Bonnes pratiques

1. **Nommez cohéremment** les diagrammes (organization.puml, component-a.puml)
2. **Maintenez à jour** du README.md principal
3. **Testez localement** avant de pusher
4. **Documenter le contexte** des diagrammes (pourquoi, pas seulement quoi)
5. **Utilisez Git** pour versionner les .drawio/.puml (tout en texte)

## 📚 Ressources

- [MkDocs Docs](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [PlantUML Guide](https://plantuml.com/guide)
- [DrawIO Docs](https://www.diagrams.net/)

---

**Questions?** Consultez les logs GitHub Actions dans l'onglet "Actions" du repo.
