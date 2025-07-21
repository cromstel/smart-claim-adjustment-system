# Smart Claim Adjustment System

## Software Owner

**CromStel IT Solutions**

## Supported Languages

- English (en)
- Spanish (es)
- Swedish (sv)
- French (fr)
- German (de)

The app supports dynamic language switching via the language selector in the main app bar. All major UI components are fully internationalized and accessible.

### Adding More Languages

To add a new language:

1. Open `src/i18n.js`.
2. Add a new language key (e.g., `it` for Italian) to the `resources` object with translations for all UI keys.
3. Add an `<option>` for the new language in the language switcher dropdown in `App.js`.

### Accessibility

All UI components are WCAG 2.1 AA compliant, with ARIA roles, keyboard navigation, and screen reader support.

---

For more details, see the full documentation in `/docs`.

## Overview

The Smart Claim Adjustment System is a secure, offline-capable desktop application for small to medium-sized third-party vehicle accident claim adjustment firms. Built with Electron, React, Node.js, and Vite, it streamlines the entire claim lifecycle from intake to closure, with advanced image management, real-time collaboration, and robust security.

## Key Features

- Complete offline capability (no cloud dependency)
- Role-based access control (RBAC) and 2FA security
- Intelligent image processing and vehicle part tagging
- Real-time collaboration and notifications
- Automated reporting and analytics
- AES-256 encryption for data at rest
- MSI installer for easy Windows deployment
- **Modern, responsive UI:** Flat, minimal, and accessible design with glassmorphism, animated accent bar, and 70/30 split login/registration pages
- **Micro-interactions:** Smooth, production-grade animations using framer-motion

## System Architecture

```
Client Tier (Electron Shell)
  - React Frontend (TypeScript, Vite)
  - Redux Toolkit, React Query
  - React Hook Form + Zod
  - Tailwind CSS (customized) + Shadcn UI
  - Framer Motion (micro-interactions)

Application Tier
  - Node.js + Express.js API Server
  - Authentication Middleware (JWT, 2FA)
  - Business Logic Services
  - WebSocket Server (Socket.IO)
  - File Processing Service (Sharp, PDFKit)

Data Tier
  - PostgreSQL (Production), MySQL (Backup), SQLite (Offline)
  - Encrypted Local File Storage
```

## Technology Stack

- **Desktop Framework:** Electron
- **Frontend:** React 18, TypeScript, Vite, Tailwind CSS (customized), Shadcn UI
- **State Management:** Redux Toolkit
- **Data Fetching:** TanStack Query
- **Forms:** React Hook Form + Zod
- **Backend:** Node.js + Express.js
- **Database:** PostgreSQL, MySQL, SQLite
- **ORM:** Prisma
- **Authentication:** JWT, Argon2id, TOTP (2FA)
- **Real-time:** Socket.IO
- **File Processing:** Sharp, PDFKit
- **Security:** AES-256, TLS 1.2+, OpenSSL
- **Animations:** framer-motion
- **Design System Plugins:** @tailwindcss/forms, @tailwindcss/typography, @tailwindcss/line-clamp

## Design System & UI/UX Best Practices

- **Tailwind CSS:** Fully customized with a modern SaaS palette, InterVariable font, glassmorphism, and advanced utility extensions
- **Global/App-wide CSS:** Managed via `index.css` and `App.css` (no legacy/demo styles)
- **Responsive Layout:** 70/30 split for login/registration, mobile-first breakpoints, and full accessibility
- **Micro-interactions:** Framer Motion for animated accent bar, button, and input feedback
- **Plugins:** Forms for beautiful input styling, Typography for docs/help, Line Clamp for text truncation
- **Accessibility:** WCAG 2.1 AA, ARIA, keyboard navigation, and screen reader support
- **Flat, Minimal, Modern:** No drop shadows or legacy gradients; focus on clarity, usability, and visual polish

## Installation

### Prerequisites

- Windows 10/11 (64-bit) or Windows Server 2019/2022
- 4GB RAM (8GB recommended)
- 20GB free disk space
- Node.js (for development only)

### User Installation (MSI)

1. Download the latest MSI installer from the [Releases](#) page.
2. Double-click the installer and follow the setup wizard.
3. Launch the app from the Start Menu or desktop shortcut.

### Initial Configuration

- On first launch, follow the configuration wizard to set up the database, admin user, and security settings.

## Usage Guide

- **Login:** Enter your credentials; 2FA required for admins. Modern login page with animated accent bar, glassmorphism, and 70/30 split layout.
- **Claim Intake:** Use the multi-step wizard to create new claims, upload photos, and tag vehicle parts.
- **Review & Assignment:** Assign claims to adjusters, track status, and collaborate in real time.
- **Reporting:** Access dashboards, generate reports (PDF/CSV), and export data.
- **Offline Mode:** Work seamlessly without internet; data syncs automatically when online.

## Development Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/cromstel/smart-claim-adjustment-system.git
   cd smart-claim-adjustment-system
   ```
2. Install dependencies:
   ```sh
   npm install
   ```
3. Set up environment variables (see `.env.example`).
4. Run the app in development mode:
   ```sh
   npm run dev
   ```
5. Build the MSI installer:
   ```sh
   npm run build && npm run package
   ```

## Testing

- Run all tests:
  ```sh
  npm test
  ```
- Coverage reports and E2E tests are included.

## Contribution Guidelines

- Fork the repo and create a feature branch.
- Follow the code style and documentation standards.
- Submit pull requests with clear descriptions and test coverage.
- All changes require code review and must pass CI checks.

## Support

- For issues, use the [issue tracker](#) or contact support at support@cromstelit.com.
- See the in-app help system and user/admin manuals for guidance.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Contact

- Product Owner: support@cromstelit.com
- Project Sponsor: support@cromstelit.com
- General Inquiries: info@cromstelit.com
