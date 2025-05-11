
# kobi

A new Flutter project.

## Getting Started

A pixel-perfect, animated Flutter mini-app that simulates expense tracking. Built from scratch with scalable architecture, smooth UI transitions, and API-simulated data using a local JSON file. Responsive across mobile and tablet screens, with platform-aware UX for both Android and iOS.

---

## 🚀 Setup Instructions

1. **Clone the project**
   ```bash
   git clone https://github.com/isaacjosh71/kobi.git
   cd kobi

##  Libraries Used
| Package                        | Purpose                               |
| ------------------------------ | ------------------------------------- |
| `flutter_bloc`                 | State management with Cubit           |
| `flutter_screenutil`           | Responsive UI scaling                 |
| `http`                         | Simulated API structure (unused live) |
| `intl`                         | Date & time formatting                |
| `fl_chart`                     | Donut/pie chart rendering             |
| `shimmer`                      | Loading placeholders                  |
| `fluttertoast`                 | In-app toast messaging                |
| `smooth_page_indicator`        | Page dots (future use)                |
| `page_transition`              | Animated navigation                   |
| `flutter_easyloading`          | Loading overlays (optional)           |
| `flutter_svg`                  | Rendering SVG assets                  |
| `equatable`                    | Value equality in models              |
| `flutter_staggered_animations` | Animated list items                   |

## Architecture & State Management
Architecture: Modular clean folder structure:

/models, /screens, /widgets, /cubit,

State Management: Cubit via flutter_bloc

Navigation: Platform-aware back behavior using Platform.isIOS

Responsiveness: flutter_screenutil ensures layout scales across mobile/tablet

Animations: AnimatedOpacity, Hero, and flutter_staggered_animations for visual polish

## API Simulation

Transactions are loaded from a local JSON file:
assets/transactions.json

Monthly filtering logic via dropdown:

All April May

Each transaction includes:

ID, title, subtitle, amount, category, date, status

## Visuals: Chart + Filters

Donut Pie Chart:

Built using fl_chart

Colors mapped to specific categories (e.g. subscription, music)

Rotates based on current filter:

"All" → 180°

"April" → 90°

"May" → 270°

Legend:

Dynamically built under chart using Wrap

Matches slice colors with categories

Total Expense Display:

Dynamically calculated and centered in chart

Tab Filtering:

Dropdown menu replaces toggle

Tabs: All, April, May — triggers Cubit filter update
