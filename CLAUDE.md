# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal blog/website built with Hugo static site generator, hosted on GitHub Pages at `xiongchenyu6.github.io`. The site features technical content written in both Markdown and Org-mode formats.

## Development Commands

### Local Development
```bash
# Enter Nix development environment (Hugo is provided via flake.nix)
nix develop

# Start development server with live reload
hugo server

# Start development server including draft posts
hugo server --buildDrafts

# Start development server with all features (recommended for development)
hugo server --buildDrafts --disableFastRender
```

### Building
```bash
# Build the site
hugo

# Build for production with minification
hugo --minify

# Clean build (remove generated files first)
rm -rf public resources
hugo --gc --minify
```

### Deployment
The site automatically deploys via GitHub Actions when pushing to the `main` branch. The workflow uses Hugo v0.145.0 Extended.

### Theme Development
If modifying the LoveIt theme:
```bash
cd themes/LoveIt
npm install
npm run compile  # Compile JavaScript
```

## Content Architecture

### Content Organization
- `/content-org/` - Org-mode source files (primary content source)
  - `/Notes/` - Technical notes that export to `/content/notes/`
  - `all-post.org` - Multi-post file for blog posts
- `/content/` - Hugo-compatible Markdown (generated from org files)
  - `/notes/` - Technical documentation
  - `/posts/` - Blog posts
- `/static/ox-hugo/` - Images exported from org-mode files

### Org-mode Workflow
This project uses ox-hugo to convert Org files to Hugo-compatible Markdown:

1. Edit `.org` files in `/content-org/` using Emacs
2. Files have `org-hugo-auto-export-mode` enabled in Local Variables
3. On save, ox-hugo automatically exports to corresponding `.md` files in `/content/`
4. Both `.org` and `.md` files should be committed to git

### Adding New Content

For a new note:
1. Create `.org` file in `/content-org/Notes/`
2. Add required properties and metadata:
   ```org
   :PROPERTIES:
   :ID:       <unique-id>
   :END:
   #+title: Your Title
   #+date: [2024-01-01 Mon 10:00]
   
   * COMMENT Local Variables
   # Local Variables:
   # eval: (org-hugo-auto-export-mode)
   # End:
   ```

For a new blog post:
1. Add a new heading to `/content-org/all-post.org`
2. Set export properties:
   ```org
   * Your Post Title
   :PROPERTIES:
   :EXPORT_FILE_NAME: your-post-filename
   :EXPORT_DATE: 2024-01-01
   :END:
   ```

## Key Configuration

### Hugo Configuration (`config.toml`)
- Base URL: `https://xiongchenyu6.github.io/`
- Theme: LoveIt (dark mode default)
- Language: Chinese (zh-cn)
- Features: Algolia search, Disqus comments, KaTeX math rendering

### Ox-hugo Configuration (`.dir-locals.el`)
- Base directory: Repository root
- Default section: "notes"
- Author export disabled

## Important Notes

- The site uses Git info for timestamps (`enableGitInfo = true`)
- Images in org files should be placed as attachments or in `/content-org/Notes/i/`
- PlantUML diagrams are supported and rendered to images
- Both source (`.org`) and generated (`.md`) files are version controlled
- The GitHub Actions workflow only builds Hugo; it doesn't convert org→md files