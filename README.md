# Kyle Hancock - Portfolio

I’m a Senior Technology Leader with over 20 years of experience across enterprise technology, software development, and cloud infrastructure. My background spans architecture, delivery, and operations, with a strong focus on building scalable, reliable systems across diverse environments.

## How many ways can you deploy a simple web app?

I work across many different technology stacks, and one constant I’ve learned is that there are countless ways to solve the same problem. This repository demonstrates a number of those approaches by showcasing multiple ways to host and deploy a simple portfolio site using different technologies and platforms.

GitHub Actions is used to provide automated, and contextual deployments. Only the components affected by a change are redeployed—for example, updates to AWS infrastructure do not trigger Azure deployments, while changes to the core React application result in redeployments across all environments. This approach keeps deployments efficient, and predictable, while highlighting the flexibility of modern tooling.

## 🌐 Live Site

👉 **[www.kylehancock.com](https://www.kylehancock.com)** (GitHub Pages)

Alternative URLs:
- [kylehancock.com](https://kylehancock.com) (redirects to www)
- [kahancock.github.io/portfolio](https://kahancock.github.io/portfolio) (redirects to kylehancock.com)
    - **Deployment**: GitHub Actions
    - **Infrastructure**: GitHub Pages
- [aws.kylehancock.com](https://aws.kylehancock.com) (Simple S3 + CloudFront)
    - **Deployment**: Terraform & GitHub Actions
    - **Infrastructure**: CloudFront CDN, S3 Static Hosting, Route53, ACM
- [azure.kylehancock.com](azure.kylehancock.com) (Simple Azure static web app)
    - **Deployment**: Terraform & GitHub Actions
    - **Infrastructure**: Azure Static web app w/custom domain

## ✨ UI Features

- **🌙 Dark Mode Default** – Professional dark theme with light mode toggle
- **📱 Fully Responsive** – Optimized for mobile, tablet, and desktop
- **⚡ Blazing Fast** – Powered by Astro for superior performance
- **🎨 Modern Design** – Clean layout with glassmorphism effects
- **✨ Smooth Animations** – Interactive UI powered by Framer Motion
- **🔍 SEO Optimized** – Structured content and meta tags
- **🎓 License Tracking** – Dedicated section for certifications and licenses

## 🏗️ Architecture

### Tech Stack
- **Framework**: Astro 5.x (Static Site Generator)
- **UI Library**: React 19
- **Styling**: Tailwind CSS 4.x
- **Animations**: Framer Motion
- **Content**: MDX for case studies
- **Icons**: Lucide React

### Project Structure
```
portfolio/
├── .github/
│   └── workflows/
│       ├── gh-deploy.yml           # GitHub Pages deployment
│       ├── aws-deploy.yml          # AWS S3 + CloudFront deployment
│       ├── azure-deploy.yml        # Azure Static Web App deployment
│       └── gcp-deploy.yml          # Google Cloud deployment
├── terraform/
│   ├── aws/
│   │   ├── main.tf                # AWS infrastructure
│   │   ├── variables.tf           # AWS variables
│   │   ├── outputs.tf             # AWS outputs
│   │   ├── terraform.tfvars       # AWS values
│   │   └── bootstrap/             # AWS initialization
│   ├── azure/
│   │   ├── main.tf                # Azure infrastructure
│   │   ├── variables.tf           # Azure variables
│   │   └── outputs.tf             # Azure outputs
│   └── gcp/
│       └── [GCP configuration]
├── src/
│   ├── components/
│   │   ├── ui/                    # Reusable UI components
│   │   ├── HeroSection.tsx        # Landing section with profile
│   │   ├── ExperienceSection.tsx  # Professional experience
│   │   ├── SkillsSection.tsx      # Technical skills
│   │   ├── LicensesSection.tsx    # Certifications & licenses
│   │   ├── EducationSection.tsx   # Academic background
│   │   └── Footer.tsx             # Contact information
│   ├── layouts/
│   │   └── Layout.astro           # Base layout with theme system
│   ├── pages/
│   │   └── index.astro            # Homepage
│   ├── lib/
│   │   ├── data.ts                # Content configuration
│   │   └── utils.ts               # Utility functions
│   └── styles/
│       └── global.css             # Global styles and theme
├── astro.config.mjs               # Astro configuration
├── package.json                   # Dependencies & scripts
└── tsconfig.json                  # TypeScript configuration
```

## 🚀 Local Development

### Prerequisites
- Node.js 20+
- npm

### Setup
```bash
# Clone the repository
git clone https://github.com/kahancock/portfolio.git
cd portfolio

# Install dependencies
npm install

# Start development server
npm run dev
```

Visit `http://localhost:4321` to view the site.

### Build Commands
```bash
# Build for production
npm run build

# Preview production build
npm run preview
```

## ⚙️ Customization

All content is managed through `src/lib/data.ts`.

### Deployment Pipelines

The repository uses **intelligent path-based triggering** to deploy only affected components:

#### GitHub Pages Deployment (`gh-deploy.yml`)
- **Trigger**: Changes to source code or workflows (ignores terraform/\* and *.md)
- **Process**:
  1. Checkout code
  2. Install dependencies
  3. Build Astro site
  4. Deploy to GitHub Pages
- **Live at**: [www.kylehancock.com](https://www.kylehancock.com)

#### AWS Deployment (`aws-deploy.yml`)
- **Trigger**: Changes to source code, AWS terraform, or workflows (ignores azure/\*, gcp/\*, and *.md)
- **Process**:
  1. Terraform Plan (validate infrastructure changes)
  2. Build Astro site
  3. Terraform Apply (if infrastructure changes detected)
  4. Sync files to S3 with optimized cache headers
  5. Create CloudFront invalidation
- **Infrastructure**: CloudFront CDN, S3 Static Hosting, Route53, ACM
- **Live at**: [aws.kylehancock.com](https://aws.kylehancock.com)

#### Azure Deployment (`azure-deploy.yml`)
- **Trigger**: Changes to source code, Azure terraform, or workflows (ignores aws/\*, gcp/\*, and *.md)
- **Process**:
  1. Terraform Plan (validate infrastructure changes)
  2. Build Astro site
  3. Terraform Apply (if infrastructure changes detected)
  4. Deploy to Azure Static Web App
- **Infrastructure**: Azure Static Web App with custom domain
- **Live at**: [azure.kylehancock.com](https://azure.kylehancock.com)

#### Google Cloud Deployment (`gcp-deploy.yml`) - WIP
- **Trigger**: Changes to source code, GCP terraform, or workflows (ignores aws/\*, azure/\*, and *.md)
- **Process**:
  1. Terraform Plan (validate infrastructure changes)
  2. Build Astro site
  3. Terraform Apply (if infrastructure changes detected)
  4. Deploy to Google Cloud Storage
- **Infrastructure**: Cloud Storage, Cloud CDN, Cloud Load Balancing
- **Live at**: [gcp.kylehancock.com](https://gcp.kylehancock.com) (pending)

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

**Template Credits:**
- Original portfolio template by **Rishikesh S** ([rishikesh2003](https://github.com/rishikesh2003))
- Template repository: [my-portfolio](https://github.com/rishikesh2003/my-portfolio)

**Technologies:**
- [Astro](https://astro.build/) - Static Site Generator
- [React](https://reactjs.org/) - UI Library  
- [Tailwind CSS](https://tailwindcss.com/) - Styling
- [Framer Motion](https://www.framer.com/motion/) - Animations
- [Lucide Icons](https://lucide.dev/) - Icon Library
- [AWS](https://aws.amazon.com//) - Amazon Web Services
- [Azure](https://azure.microsoft.com/) - Microsoft Azure
- [GitHub Pages](https://pages.github.com/) - GitHub Pages
- [Terraform](https://www.terraform.io/) - Infrastructure as Code

---

## 📞 Contact

**Kyle Hancock**
- 🌐 Website: [www.kylehancock.com](https://www.kylehancock.com)
- 📧 Email: [kyle@kylehancock.com](mailto:kyle@kylehancock.com)
- 💼 LinkedIn: [kyle-a-hancock](https://www.linkedin.com/in/kyle-a-hancock/)
- 🐙 GitHub: [kahancock](https://github.com/kahancock)

---

*Built with ❤️ using modern web technologies*
