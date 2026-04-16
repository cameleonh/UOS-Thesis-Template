%% uos-thesis.cls
%% LaTeX class for University of Seoul (서울시립대학교) Graduate School Thesis
%% Based on 대학원 시행세칙 별첨 — 학위논문 체제 및 양식
%%
%% Compile with: xelatex or lualatex (required for Korean font support)
%% Or use: latexmk -xelatex main.tex
%%
%% Options:
%%   master  — Master's thesis (default)
%%   doctor  — Doctoral dissertation
%%   korean  — Use Korean UI text throughout
%%
%% Copyright (c) 2026 cameleonh. MIT License.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uos-thesis}[2026/04/16 University of Seoul Thesis Class v1.1.0]

%% ============================================================
%% §1  Class Options
%% ============================================================
\newif\if@master    \@mastertrue
\newif\if@doctor    \@doctorfalse
\newif\if@korean    \@koreanfalse
\newif\if@hassubtitle \@hassubtitlefalse

\DeclareOption{master}{\@mastertrue\@doctorfalse}
\DeclareOption{doctor}{\@doctortrue\@masterfalse}
\DeclareOption{korean}{\@koreantrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass[11pt]{report}

%% ============================================================
%% §2  Page Geometry (4·6배판 18.2cm × 25.7cm, updated 2024.5.31)
%% ============================================================
\RequirePackage[
  paperwidth=18.2cm,
  paperheight=25.7cm,
  top=3.0cm,
  bottom=3.0cm,
  left=2.5cm,
  right=2.5cm,
  headheight=14pt,
]{geometry}

%% ============================================================
%% §3  Font Setup (XeLaTeX / LuaLaTeX)
%% ============================================================
\RequirePackage{fontspec}
\RequirePackage{kotex}          % Korean language support

% --- Serif (English) ---
% Primary: Times New Roman. Fallback: TeX Gyre Termes (free equivalent).
\IfFontExistsTF{Times New Roman}{%
  \setmainfont{Times New Roman}[
    BoldFont=Times New Roman Bold,
    ItalicFont=Times New Roman Italic,
    BoldItalicFont=Times New Roman Bold Italic,
  ]%
}{%
  \IfFontExistsTF{TeX Gyre Termes}{%
    \setmainfont{TeX Gyre Termes}%
  }{%
    % Ultimate fallback: Computer Modern (always available)
  }%
}

% --- Serif (Korean, 명조체 계열) ---
% Primary: Noto Serif CJK KR. Fallback: NanumMyeongjo → UnBatang.
\IfFontExistsTF{Noto Serif CJK KR}{%
  \setmainhangulfont{Noto Serif CJK KR}[
    BoldFont=Noto Serif CJK KR Bold,
  ]%
}{%
  \IfFontExistsTF{NanumMyeongjo}{%
    \setmainhangulfont{NanumMyeongjo}[
      BoldFont=NanumMyeongjo Bold,
    ]%
  }{%
    \IfFontExistsTF{UnBatang}{%
      \setmainhangulfont{UnBatang}%
    }{%
      % kotex will use its default
    }%
  }%
}

%% ============================================================
%% §4  Line Spacing (200% = double spacing per UOS spec)
%% ============================================================
\RequirePackage{setspace}
\doublespacing

%% ============================================================
%% §5  Core Packages
%% ============================================================
\RequirePackage{graphicx}
\graphicspath{{figures/}}

\RequirePackage{amsmath,amssymb,amsfonts}

\RequirePackage{xcolor}          % must load before hyperref

%% ============================================================
%% §6  Table Packages
%% ============================================================
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{caption}
\RequirePackage{subcaption}

%% ============================================================
%% §7  TOC / Section Formatting
%% ============================================================
\RequirePackage{tocloft}
\RequirePackage{titletoc}
\RequirePackage{titlesec}
\RequirePackage{tocbibind}       % add TOC/LOT/LOF to TOC

%% ============================================================
%% §8  Header / Footer
%% ============================================================
\RequirePackage{fancyhdr}

%% ============================================================
%% §9  Algorithm Packages
%% ============================================================
\RequirePackage{algorithm}
\RequirePackage{algorithmic}

%% ============================================================
%% §10 Utility Packages
%% ============================================================
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage{xparse}

%% ============================================================
%% §11 Bibliography (biblatex + biber)
%% ============================================================
\RequirePackage[
  backend=biber,
  style=numeric,
  sorting=nyt,
  maxbibnames=99,
]{biblatex}

\defbibheading{bibintoc}[\bibname]{%
  \chapter*{\hfill #1 \hfill}%
  \addcontentsline{toc}{chapter}{#1}%
  \markboth{#1}{#1}%
}

%% ============================================================
%% §12 Hyperref (MUST load last among packages)
%% ============================================================
\RequirePackage[
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=blue,
  bookmarks=true,
  bookmarksnumbered=true,
  pdfauthor={\@authorEn},
  pdftitle={\@titleEn},
]{hyperref}

%% ============================================================
%% §13  Font Size Commands (UOS specifications)
%% ============================================================
%  Cover title:     22pt
%  Cover subtitle:  16pt
%  Body/Abstract:   11pt (base)
%  Chapter title:   16pt
%  Section title:   14pt
%  Subsection:      12pt
%  Subsubsection:   11pt
%  Footnote:         9pt

% Chapter title: 16pt bold, left-aligned
\titleformat{\chapter}[display]
  {\normalfont\fontsize{16}{20}\bfseries}
  {\chaptername\ \thechapter}{0.5em}{}
\titlespacing*{\chapter}{0pt}{-20pt}{20pt}

% Section title: 14pt bold
\titleformat{\section}
  {\normalfont\fontsize{14}{18}\bfseries}
  {\thesection}{1em}{}
\titlespacing*{\section}{0pt}{12pt}{6pt}

% Subsection title: 12pt bold
\titleformat{\subsection}
  {\normalfont\fontsize{12}{16}\bfseries}
  {\thesubsection}{1em}{}
\titlespacing*{\subsection}{0pt}{10pt}{4pt}

% Subsubsection
\titleformat{\subsubsection}
  {\normalfont\fontsize{11}{15}\bfseries}
  {\thesubsubsection}{1em}{}
\titlespacing*{\subsubsection}{0pt}{8pt}{4pt}

% Footnote size: 9pt
\renewcommand{\footnotesize}{\fontsize{9}{11}\selectfont}

%% ============================================================
%% §14  Page Styles
%% ============================================================
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[C]{\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}

\fancypagestyle{empty}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}

\pagestyle{plain}

%% ============================================================
%% §15  Table of Contents Formatting
%% ============================================================
\renewcommand{\cftchapfont}{\bfseries}
\renewcommand{\cftchappagefont}{\bfseries}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\setlength{\cftbeforechapskip}{6pt}

% TOC/LOT/LOF heading names
\if@korean
  \renewcommand{\contentsname}{차례}
  \renewcommand{\listtablename}{표 차례}
  \renewcommand{\listfigurename}{그림 차례}
\else
  \renewcommand{\contentsname}{Contents}
  \renewcommand{\listtablename}{List of Tables}
  \renewcommand{\listfigurename}{List of Figures}
\fi

% Center the TOC/LOT/LOF chapter titles
\renewcommand{\cfttoctitlefont}{\hfill\fontsize{16}{20}\bfseries}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftlottitlefont}{\hfill\fontsize{16}{20}\bfseries}
\renewcommand{\cftafterlottitle}{\hfill}
\renewcommand{\cftloftitlefont}{\hfill\fontsize{16}{20}\bfseries}
\renewcommand{\cftafterloftitle}{\hfill}

%% ============================================================
%% §16  Metadata Commands
%% ============================================================
\newcommand{\@titleEn}{}
\newcommand{\@titleKo}{}
\newcommand{\@subtitleEn}{}
\newcommand{\@authorEn}{}
\newcommand{\@authorKo}{}
\newcommand{\@departmentEn}{}
\newcommand{\@departmentKo}{}
\newcommand{\@advisorEn}{}
\newcommand{\@advisorKo}{}
\newcommand{\@degreeEn}{}
\newcommand{\@degreeKo}{}
\newcommand{\@degreeFieldEn}{}
\newcommand{\@degreeFieldKo}{}
\newcommand{\@submissionDate}{}
\newcommand{\@approvalDate}{}
\newcommand{\@coverDate}{}
\newcommand{\@committeeChair}{}
\newcommand{\@committeeMemberA}{}
\newcommand{\@committeeMemberB}{}

% Doctor-only committee members
\newcommand{\@committeeMemberC}{}
\newcommand{\@committeeMemberD}{}

\newcommand{\titleEn}[1]{\renewcommand{\@titleEn}{#1}}
\newcommand{\titleKo}[1]{\renewcommand{\@titleKo}{#1}}
\newcommand{\subtitleEn}[1]{\renewcommand{\@subtitleEn}{#1}\@hassubtitletrue}
\newcommand{\authorEn}[1]{\renewcommand{\@authorEn}{#1}}
\newcommand{\authorKo}[1]{\renewcommand{\@authorKo}{#1}}
\newcommand{\departmentEn}[1]{\renewcommand{\@departmentEn}{#1}}
\newcommand{\departmentKo}[1]{\renewcommand{\@departmentKo}{#1}}
\newcommand{\advisorEn}[1]{\renewcommand{\@advisorEn}{#1}}
\newcommand{\advisorKo}[1]{\renewcommand{\@advisorKo}{#1}}
\newcommand{\degreeEn}[1]{\renewcommand{\@degreeEn}{#1}}
\newcommand{\degreeKo}[1]{\renewcommand{\@degreeKo}{#1}}
\newcommand{\degreeFieldEn}[1]{\renewcommand{\@degreeFieldEn}{#1}}
\newcommand{\degreeFieldKo}[1]{\renewcommand{\@degreeFieldKo}{#1}}
\newcommand{\submissionDate}[1]{\renewcommand{\@submissionDate}{#1}}
\newcommand{\approvalDate}[1]{\renewcommand{\@approvalDate}{#1}}
\newcommand{\coverDate}[1]{\renewcommand{\@coverDate}{#1}}
\newcommand{\committeeChair}[1]{\renewcommand{\@committeeChair}{#1}}
\newcommand{\committeeMemberA}[1]{\renewcommand{\@committeeMemberA}{#1}}
\newcommand{\committeeMemberB}[1]{\renewcommand{\@committeeMemberB}{#1}}
\newcommand{\committeeMemberC}[1]{\renewcommand{\@committeeMemberC}{#1}}
\newcommand{\committeeMemberD}[1]{\renewcommand{\@committeeMemberD}{#1}}

%% ============================================================
%% §17  Cover Page (표지) — no page number
%% ============================================================
\newcommand{\makecover}{%
  \newgeometry{top=3cm, bottom=3cm, left=2cm, right=2cm}%
  \begin{titlepage}%
    \begin{center}
      \vspace{1.0cm}%
      {\fontsize{14}{18}\selectfont
        \if@doctor
          \if@korean 박사학위논문\else Doctoral Dissertation\fi
        \else
          \if@korean 석사학위논문\else Master Thesis\fi
        \fi
      }%
      \vspace{1.5cm}%

      {\fontsize{22}{28}\selectfont\bfseries \@titleEn \par}%
      \if@hassubtitle
        \vspace{0.5cm}%
        {\fontsize{16}{22}\selectfont : \@subtitleEn \par}%
      \fi

      \vfill

      {\fontsize{14}{18}\selectfont
        \if@korean 저자:\else by\fi
      }\\[0.8cm]%
      {\fontsize{16}{22}\selectfont \@authorEn}%

      \vfill

      {\fontsize{14}{18}\selectfont
        \if@korean
          \@departmentKo\\[0.3cm]%
          서울시립대학교 대학원
        \else
          Department of \@departmentEn\\[0.3cm]%
          The Graduate School of the University of Seoul
        \fi
      }%

      \vspace{1.5cm}
      {\fontsize{14}{18}\selectfont \@coverDate}%
    \end{center}
  \end{titlepage}%
  \restoregeometry%
}

%% ============================================================
%% §18  Submission Page (제출문) — no page number
%% ============================================================
\newcommand{\makesubmission}{%
  \newgeometry{top=3cm, bottom=3cm, left=3cm, right=3cm}%
  \thispagestyle{empty}%
  \begin{spacing}{1.3}%
  \begin{center}
    \vspace{2cm}%

    {\fontsize{16}{22}\selectfont \@titleEn \par}%
    \if@hassubtitle
      \vspace{0.3cm}%
      {\fontsize{13}{18}\selectfont : \@subtitleEn \par}%
    \fi

    \vspace{1.2cm}
    {\fontsize{12}{16}\selectfont
      \if@korean 저자:\else by\fi
    }\\[0.4cm]%
    {\fontsize{14}{18}\selectfont \@authorEn}%

    \vspace{1.5cm}
    {\fontsize{12}{16}\selectfont
      \if@korean
        서울시립대학교 대학원 \@departmentKo에\\
        \@degreeKo 학위논문으로 제출함
      \else
        A \if@doctor Doctoral Dissertation\else Master Thesis\fi\ 
        submitted to the Department of \@departmentEn\\
        at the Graduate School of the University of Seoul\\
        in partial fulfillment of the requirements for the\\
        degree of \@degreeEn
      \fi
    }%

    \vspace{1.2cm}
    {\fontsize{12}{16}\selectfont \@submissionDate}%

    \vspace{1.5cm}
    {\fontsize{12}{16}\selectfont
      \if@korean
        지도교수 승인\\[0.4cm]
        \@advisorKo\\[0.2cm]
        지도교수
      \else
        Approved by\\[0.4cm]
        \@advisorEn\\[0.2cm]
        Advisor
      \fi
    }%
  \end{center}
  \end{spacing}%
  \clearpage%
  \restoregeometry%
}

%% ============================================================
%% §19  Approval Page (인준서) — no page number
%% ============================================================
\newcommand{\makeapproval}{%
  \newgeometry{top=3cm, bottom=3cm, left=3cm, right=3cm}%
  \thispagestyle{empty}%
  \begin{spacing}{1.0}%
  \begin{center}
    \vspace{2.5cm}%

    {\fontsize{14}{18}\selectfont
      \if@korean
        본 \if@doctor 박사\else 석사\fi 학위논문을 인준함
      \else
        This certifies that the
        \if@doctor doctoral dissertation\else master thesis\fi\ of\\[0.5cm]
        \@authorEn~is approved.
      \fi
    }%

    \vspace{2.5cm}

    % Committee Chair
    \rule{7cm}{0.4pt}\\[0.2cm]%
    {\fontsize{12}{16}\selectfont
      \if@korean 심사위원장:\else Thesis Committee Chair:\fi\ \@committeeChair}%

    \vspace{1.5cm}

    % Committee Member A
    \rule{7cm}{0.4pt}\\[0.2cm]%
    {\fontsize{12}{16}\selectfont
      \if@korean 심사위원:\else Thesis Committee Member:\fi\ \@committeeMemberA}%

    \vspace{1.5cm}

    % Committee Member B
    \rule{7cm}{0.4pt}\\[0.2cm]%
    {\fontsize{12}{16}\selectfont
      \if@korean 심사위원:\else Thesis Committee Member:\fi\ \@committeeMemberB}%

    % Doctor: additional members C & D
    \if@doctor
      \vspace{1.5cm}
      \rule{7cm}{0.4pt}\\[0.2cm]%
      {\fontsize{12}{16}\selectfont
        \if@korean 심사위원:\else Thesis Committee Member:\fi\ \@committeeMemberC}%

      \vspace{1.5cm}
      \rule{7cm}{0.4pt}\\[0.2cm]%
      {\fontsize{12}{16}\selectfont
        \if@korean 심사위원:\else Thesis Committee Member:\fi\ \@committeeMemberD}%
    \fi

    \vfill

    {\fontsize{12}{16}\selectfont
      \if@korean
        서울시립대학교 대학원\\[0.3cm]%
      \else
        The Graduate School of the University of Seoul\\[0.3cm]%
      \fi
      \@approvalDate
    }%
  \end{center}
  \end{spacing}%
  \clearpage%
  \restoregeometry%
}

%% ============================================================
%% §20  Abstract (영문초록 — front matter) — no page number
%% ============================================================
\renewenvironment{abstract}{%
  \clearpage
  \thispagestyle{empty}%
  \begin{center}
    \vspace{0.5cm}%
    {\fontsize{16}{20}\selectfont\bfseries
      \if@korean 요약\else Abstract\fi
    }\\[0.8cm]%
  \end{center}
  \begin{spacing}{1.3}%
  \fontsize{11}{14}\selectfont
  \noindent
}{%
  \end{spacing}%
  \clearpage
}

%% ============================================================
%% §21  Keywords Commands
%% ============================================================
\newcommand{\keywords}[1]{%
  \vspace{1cm}%
  \noindent\textbf{\if@korean 주요어\else Keywords\fi}: #1%
}

\newcommand{\keywordsko}[1]{%
  \vspace{1cm}%
  \noindent\textbf{주요어}: #1%
}

%% ============================================================
%% §22  Inner Cover Page (속표지 — identical to cover)
%% ============================================================
\newcommand{\makeinnercover}{%
  \makecover
}

%% ============================================================
%% §23  Korean Abstract (국문초록 — back matter)
%% ============================================================
\newenvironment{abstractko}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{초록}%
  \thispagestyle{plain}%
  \begin{center}
    \vspace{0.5cm}%
    {\fontsize{16}{20}\selectfont\bfseries 초\quad 록}\\[0.8cm]%
  \end{center}
  \begin{spacing}{1.3}%
  \fontsize{11}{14}\selectfont
  \noindent
}{%
  \end{spacing}%
  \clearpage
}

%% ============================================================
%% §24  Acknowledgments
%% ============================================================
\newenvironment{acknowledgments}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{%
    \if@korean 감사의 글\else Acknowledgments\fi
  }%
  \begin{center}
    {\fontsize{16}{20}\selectfont\bfseries
      \if@korean 감사의 글\else Acknowledgments\fi
    }\\[1cm]%
  \end{center}
  \begin{spacing}{1.6}%
  \fontsize{11}{14}\selectfont
}{%
  \end{spacing}%
  \clearpage
}

%% ============================================================
%% §25  Front / Main / Back Matter Switches
%% ============================================================
\newcommand{\frontmatter}{%
  \cleardoublepage
  \pagenumbering{roman}%
}

\newcommand{\mainmatter}{%
  \cleardoublepage
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
}

\newcommand{\backmatter}{%
  \cleardoublepage
}

%% ============================================================
%% §26  Unnumbered Special Chapter Helper
%% ============================================================
\newcommand{\specialchapter}[1]{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}%
  \begin{center}
    {\fontsize{16}{20}\selectfont\bfseries #1}\\[1cm]%
  \end{center}
}

\endinput
