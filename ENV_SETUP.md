# Environment Variables Setup

## GitHub Actions Setup (Production)

1. **Add secrets to your GitHub repository:**
   - Go to Settings > Secrets and variables > Actions
   - Add these secrets:
     - `STATICFORMS_ACCESS_KEY`
     - `RECAPTCHA_SITE_KEY`

2. **Enable GitHub Pages from Actions:**
   - Go to Settings > Pages
   - Source: GitHub Actions

3. **Push to main branch** - the workflow will automatically build and deploy

## Local Development

1. Create a `.env` file in the root directory:
```bash
STATICFORMS_ACCESS_KEY=xxx
RECAPTCHA_SITE_KEY=xxx
```

2. Run Jekyll normally: `bundle exec jekyll serve`

## How it works

- **Local**: Plugin loads `.env` file
- **GitHub Actions**: Plugin uses environment variables from secrets
- Variables replace `${VAR_NAME}` placeholders in `_config.yml`