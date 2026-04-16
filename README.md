# UOS Thesis Template (서울시립대학교 대학원 학위논문 템플릿)

> LaTeX thesis template for the **University of Seoul (서울시립대학교) Graduate School**, following the official thesis formatting guidelines (대학원 시행세칙 별첨 — 학위논문 체제 및 양식, updated 2024.5.31).

## Features

- ✅ **석사/박사 지원** — `master` (default) and `doctor` options
- ✅ **국문/영문 전환** — `korean` option for Korean UI text
- ✅ **XeLaTeX 컴파일** — Full Korean font support via `kotex`
- ✅ **크로스 플랫폼 폰트 폴백** — Times New Roman → TeX Gyre Termes, Noto Serif CJK KR → NanumMyeongjo → UnBatang
- ✅ **biblatex + biber** — Modern bibliography management
- ✅ **4·6배판 (18.2cm × 25.7cm)** — Official UOS paper size
- ✅ **겹줄 (200% line spacing)** — Per UOS specifications
- ✅ **모든 공식 페이지 포함** — 표지, 제출문, 인준서, 영문초록, 국문초록, 감사문

## Quick Start

### Prerequisites

- [TeX Live](https://www.tug.org/texlive/) 2022+ or [MiKTeX](https://miktex.org/) with XeLaTeX
- Korean fonts: Noto Serif CJK KR (recommended) or NanumMyeongjo
- Biber (for bibliography)

### Compile

```bash
# Option 1: Using latexmk (recommended)
latexmk -xelatex main.tex

# Option 2: Using Make
make

# Option 3: Manual compilation
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex

# Clean build artifacts
make clean
```

### Usage

1. **Clone this template**
   ```bash
   git clone https://github.com/cameleonh/UOS-Thesis-Template.git my-thesis
   cd my-thesis
   ```

2. **Edit `main.tex`** — Fill in your thesis metadata:
   ```latex
   \titleEn{Your Thesis Title}
   \titleKo{논문 제목}
   \authorEn{Your Name}
   \authorKo{성명}
   \departmentEn{Your Department}
   \departmentKo{학과명}
   % ... etc
   ```

3. **Write chapters** in the `chapters/` directory

4. **Add references** to `references.bib`

5. **Compile** with `latexmk -xelatex main.tex`

## File Structure

```
UOS-Thesis-Template/
├── main.tex              # Main document (metadata + structure)
├── uos-thesis.cls        # Document class (formatting engine)
├── references.bib        # Bibliography database
├── .latexmkrc            # latexmk configuration
├── .gitignore            # LaTeX-aware gitignore
├── Makefile              # Convenience build targets
├── LICENSE               # MIT License
├── README.md             # This file
├── chapters/
│   ├── introduction.tex  # Chapter 1 template
│   └── conclusion.tex    # Final chapter template
├── figures/              # Place figures here
│   └── .gitkeep
└── .github/
    ├── ISSUE_TEMPLATE/
    │   ├── bug_report.md
    │   └── feature_request.md
    └── PULL_REQUEST_TEMPLATE.md
```

## Class Options

| Option    | Description                          |
|-----------|--------------------------------------|
| `master`  | Master's thesis (default)            |
| `doctor`  | Doctoral dissertation (5 committee)  |
| `korean`  | Use Korean text for all UI elements  |

### Example: Doctoral dissertation with Korean UI

```latex
\documentclass[doctor, korean]{uos-thesis}
```

## Custom Commands

| Command                  | Description                      |
|--------------------------|----------------------------------|
| `\makecover`             | 표지 (Cover page)                |
| `\makesubmission`        | 제출문 (Submission page)         |
| `\makeapproval`          | 인준서 (Approval page)           |
| `\makeinnercover`        | 속표지 (Inner cover)             |
| `\keywords{...}`         | Keywords (English)               |
| `\keywordsko{...}`       | 주요어 (Korean keywords)         |
| `\specialchapter{...}`   | Unnumbered chapter               |
| `\frontmatter`           | Switch to roman page numbers     |
| `\mainmatter`            | Switch to arabic page numbers    |
| `\backmatter`            | End of main matter               |

## Font Specifications

| Element         | Size  | Weight |
|-----------------|-------|--------|
| Cover title     | 22pt  | Bold   |
| Cover subtitle  | 16pt  | Normal |
| Chapter title   | 16pt  | Bold   |
| Section title   | 14pt  | Bold   |
| Subsection      | 12pt  | Bold   |
| Body text       | 11pt  | Normal |
| Footnote        | 9pt   | Normal |

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `Font not found` error | Install the required fonts or the fallback fonts will be used automatically |
| `Undefined control sequence` | Make sure you're using **XeLaTeX**, not pdfLaTeX |
| Bibliography not showing | Run `biber main` then recompile |
| Overfull hbox warnings | Normal for draft — adjust `\sloppy` if needed |
| Korean text broken | Ensure `kotex` package and Korean fonts are installed |

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request

## License

MIT License — see [LICENSE](LICENSE) for details.

## Acknowledgments

- Original template by [seongminkim16](https://github.com/seongminkim16/University-of-Seoul-Thesis-Template)
- Based on 서울시립대학교 대학원 학위논문 체제 및 양식 (updated 2024.5.31)
