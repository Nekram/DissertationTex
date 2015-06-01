%% uafthesis.cls -- curt a.l. szuberla  1996/11/13
%% 
%%        produces a UAF approved thesis format; kludged from the
%%        std. latex2e report.cls and from ucthesis.cls; uses many
%%        features of the former and is not so complex as the
%%        latter; for my comments, see the "%%" marks
%%
%%  Edited by Matt Heavner 1999/02/05
%%        Add index (so it'll show up on the toc)
%%        Increment the version number
%%  Edited by Dana Moudry 2002/12/18
%%
%%  Edited by Ryan Woodard 2004/8/16
%%        Made all fonts the same size so that Craven will shut up.
%%
%%  Edited by Ryan Woodard 2006/8/3
%%        Added 'Page' right aligned over page numbers in Table
%%        of Contents, List of Figures, etc.
%%
%%  Edited by Bob McNabb 2013/6/18 (s/t Ronni Grapenthin)
%%	  Changed "chapter" Table of Contents entry to include bold dots,
%%		and include the word "Chapter" before the chapter number. Also
%%		changed the spacing so that it's more like the GS's example
%%	  Added "frontchapter" Table of Contents entry to do the exact same thing
%%		as the "chapter" entry, but without the word "Chapter" in the ToC
%%	  Included \flypage, to insert the required blank pages at the beginning (and end)
%%		of everything. YOU WILL HAVE TO INSERT THESE IN YOUR thesis.tex FILE, before
%%		\makesig, and just before \end{document}. The good news is, they don't mess up the
%%		page counting. 
%%	  Removed "Table of Contents" entry from the Table of Contents,
%%	  	because this is just way too meta to think about.
%%	  Changed default options to reflect current whims of graduate school, including margins and all
%%		that jazz.
%%	  NB: The chapteruaf* hack below will only add "page" to the top of the FIRST page of the ToC, etc.
%%		If the present incarnation of Holy Mother Graduate School requires "page" on EACH
%%		page of the ToC, etc., then insert the following line into your actual thesis.tex file:
%%			\addtocontents{toc}{\protect\afterpage{~\hfill{Page}\par\medskip}} % for the toc
%%			\addtocontents{lof}{\protect\afterpage{~\hfill{Page}\par\medskip}} % for the lof
%%		If your thesis is table-heavy (or appendix, extra material, whatever) for some reason, 
%%		change {lof} to {lot}, etc.You will probably have to play around with it some,
%%		but the following locations worked for me:
%%			{toc} after the acknowledgements
%%			{lof} and {toc} after Chapter 2 (first "real" chapter)
%%		This is a semi ugly hack, but it gets results, and will hopefully spare you the pain that I
%%			(and others) have suffered.
%%	  Added "Department" as a variable, thus removing the hard-wired "Physics" option.
%%	  Futzed with spacing on sig page, now all lines are aligned and the same length, so that no one feels
%%		inadequate. Also added a second \makesig macro (\makenamedsig), which puts the names that you specify
%%		on the page. This is not required by the Grad school, but it looks nice. Just pray that the Dept. Chair
%%		isn't out of town when you turn in your thesis.


\NeedsTeXFormat{LaTeX2e} 
%% have to require "afterpage" to get the stupid 'Page' heading in the ToC, LoF, LoT, etc.
\usepackage{afterpage}
\usepackage[switch]{lineno}
\usepackage{tocloft}% http://ctan.org/pkg/tocloft
%\usepackage[nottoc,notlot,notlof,section,numbib]{tocbibind}
\ProvidesClass{uafthesis}
%%              [2004/08/17 v4.9 UAF thesis class]
%%              [2002/12/18 v4.8 UAF thesis class]
%%              [1999/02/05 v4.7 UAF thesis class]
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@openright
\newif\if@openbib
\newif\if@arabic
\newif\if@chapterone
\@chapteronetrue
\@arabicfalse
\@openbibfalse

% inserts a totally blank page 
\newcommand{\blankpage}{
\newpage
\thispagestyle{empty}
\mbox{}
\newpage
}
% inserts two totally blank pages - a fly page! bah-dah!
\newcommand{\flypage}{
\blankpage\blankpage
}

%% options have been reduced to what is reasonable for a uaf thesis
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}\linenumbers\modulolinenumbers[5]}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{\@openbibtrue}
\DeclareOption{arabic}{\@arabictrue}
%% As of June 2013, UAF theses are Two-sided, opening right. So, these are our default options.
\ExecuteOptions{11pt,twoside,final,openright}
\ProcessOptions

%% too lazy to deconvolve columnar options, so hard-wired to onecolumn!
\@twocolumnfalse
\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}
\input{size1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}

%% typset the thing in 1.5ish spacing; but provide for singlespaced
%% captions; redefine to 2.0, etc. if you don't like 1.37
\renewcommand\baselinestretch{1.37}
\def\ssp{\def\baselinestretch{1.0}\large\normalsize}
\def\dsp{\def\baselinestretch{1.37}\large\normalsize}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}

%% need this, because UAF wants blank pages to remain virginal and unnumbered.
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \hbox{}
    \thispagestyle{empty}
    \newpage
    \if@twocolumn\hbox{}\newpage\fi\fi\fi}

%% declarations used to declare arguments needed for the 
%% construction of the front matter.  
%%   The year the degree will be officially conferred
\def\degreeyear#1{\gdef\@degreeyear{#1}}
%%   The month the degree will be officially conferred
\def\degreemonth#1{\gdef\@degreemonth{#1}}
%%   The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}
%%   All previous degrees: one per line in chronological order
\def\prevdegrees#1{\gdef\@prevdegrees{#1}}
%%   The number of committee members, which provides for the
%%    correct number of lines on the signature page.  INCLUDE THE
%%    CHAIR IN THIS NUMBER! 
\def\@numberofmembers{3}
\def\numberofmembers#1{\gdef\@numberofmembers{#1}}
%%   The name of your department
\def\department#1{\gdef\@department{#1}}
%%   The name of your college or school
\def\college#1{\gdef\@college{#1}}
%%   The names of your committee members, the Chair of the Department, the Dean of the College,
%%	and the Dean of the Graduate School. Be sure to spell names right, and include titles.
\def\gsdean#1{\gdef\@gsdean{#1}} % the grad school dean's name 
\def\colldean#1{\gdef\@colldean{#1}} % the dean of the college's name 
\def\depchair#1{\gdef\@depchair{#1}} % the department chair's name
\def\commchair#1{\gdef\@commchair{#1}} % the committee chair's name

%% This isn't elegant, but I don't care. Only use as many as you have to.
%% Since we're only going up to 6 committee members total, we only have 5 non-advisors.
\def\comone#1{\gdef\@comone{#1}}
\def\comtwo#1{\gdef\@comtwo{#1}}
\def\comthree#1{\gdef\@comthree{#1}}
\def\comfour#1{\gdef\@comfour{#1}}
\def\comfive #1{\gdef\@comfive{#1}}

%% \maketitle makes titlepage. requires all the above macros 
%% page gets set to 3
\def\maketitle{
{   \let\footnotesize\small
    \let\footnoterule\relax
    \if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
    \setcounter{page}{3} 
    \thispagestyle{empty}
    \addcontentsline{toc}{frontchapter}{\titlename}
    \null\vfill
  \begin{center}
    { {\expandafter\uppercase\expandafter{\@title}} \par}
    \bigskip \bigskip \medskip 
        A \par 
        \medskip 
        THESIS \par
    \bigskip \bigskip \medskip 
        Presented to the Faculty \par
        \medskip
        of the University of Alaska Fairbanks \par
    \bigskip \medskip
        in Partial Fulfillment of the Requirements \par
        \medskip
        for the Degree of \par
    \bigskip \bigskip \medskip 
    {\expandafter\uppercase\expandafter{\@degree}} \par
    \bigskip \bigskip \bigskip 
    By \par
    \bigskip 
    {\@author}, {\@prevdegrees} \par
    \bigskip \bigskip
    Fairbanks, Alaska \par
    \bigskip 
    {\@degreemonth} {\@degreeyear}
  \end{center}
    \vfill\null
\setcounter{footnote}{0}
}\newpage \thispagestyle{empty}~ %a blank page that will serve as the back of the title page
\newpage}

%% The \makesig macro emits a UAF-approved signature page ready for
%% your committee's signature.  requires the the \title, \author, and
%% \college macros have been defined.  (this bastard finally is
%% independant of the font you choose for the thesis!)
\def\makesig{
\setcounter{page}{1}
\thispagestyle{empty}
\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
\addcontentsline{toc}{frontchapter}{\signame}

\begin{center}
    { \large {\expandafter\uppercase\expandafter{\@title}} \par}
    \bigskip \bigskip
    By \par
    \bigskip \bigskip
    {\@author} \par
    \bigskip \bigskip \medskip
\vspace{.25in}
\end{center}

\noindent\hspace{.25in}RECOMMENDED:\hspace{.45in}\rule{3.75in}{.05mm}\hspace{.25in}\vskip2.5ex\relax
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip2.5ex\relax
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip2.5ex\relax

\ifnum \@numberofmembers = 3
\vskip-3.5ex\relax
\noindent\hskip2in\relax Advisory Committee Chair \vskip2.5ex
\fi

\ifnum \@numberofmembers = 4
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\hskip2in\relax Advisory Committee Chair \vskip2.5ex
\fi

\ifnum \@numberofmembers = 5
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip2.5ex\relax
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\hskip2in\relax Advisory Committee Chair \vskip2.5ex
\fi

\ifnum \@numberofmembers = 6
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip2.5ex\relax
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip2.5ex\relax
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\hskip2in\relax Advisory Committee Chair \vskip2.5ex
\fi
%% here's where we put the chair of the department
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}
\vskip-1ex\relax\noindent\hskip2in\relax Chair, Department of {\@department} \vskip1.5ex

\bigskip \bigskip \par

\noindent\hspace{.25in}APPROVED: \hspace{.8in} \rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\phantom{\hspace{.25in}APPROVED: \hspace{.8in} }Dean, {\@college}\hspace{.25in}\vskip2.5ex\relax
\noindent\phantom{\hspace{.25in}APPROVED: \hspace{.8in} }\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\phantom{\hspace{.25in}APPROVED: \hspace{.8in} }Dean of the Graduate School\hspace{.25in}\vskip2.5ex\relax
\noindent\phantom{\hspace{.25in}APPROVED: \hspace{.8in} }\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\phantom{\hspace{.25in}APPROVED: \hspace{.8in} }Date
\newpage \thispagestyle{empty}~ % a blank page that serves as the backside of the signature page
\newpage}

%% The \makenamedsig macro emits a UAF-approved signature page ready for
%% your committee's signature, with committee member names printed under each line.
%% This requires that the \title, \author, and \college macros have been defined,
%% and of course names for all parties (see above for the macro names)
%% (this bastard finally is independent of the font you choose for the thesis!)
%% It's also independent of department! Woo!
\def\makenamedsig{
\setcounter{page}{1}
\thispagestyle{empty}
\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
\addcontentsline{toc}{frontchapter}{\signame}

\begin{center}
    { \large {\expandafter\uppercase\expandafter{\@title}} \par}
    \bigskip \bigskip
    By \par
    \bigskip \bigskip
    {\@author} \par
    \bigskip  \medskip
\vspace{.25in}
\end{center}

\noindent\hspace{.25in}RECOMMENDED:\hspace{.45in}\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\hskip2in{\@comone}\relax\vskip1.5ex\relax
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\hskip2in{\@comtwo}\relax\vskip1.5ex\relax
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\hskip2in{\@comthree}\relax\vskip1.5ex\relax

\ifnum \@numberofmembers = 3
\vskip-3ex\relax\noindent\hskip2in\relax{\@commchair}\relax\vskip-1ex\relax
\noindent\hskip2in\relax Advisory Committee Chair \vskip2.5ex
\fi

\ifnum \@numberofmembers = 4
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\hskip2in\relax{\@commchair}\relax\vskip-1ex\relax
\noindent\hskip2in\relax Advisory Committee Chair \vskip2.5ex
\fi

\ifnum \@numberofmembers = 5
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\hskip2in{\@comfour}\relax\vskip1.5ex\relax
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\hskip2in\relax{\@commchair}\relax\vskip-1ex\relax
\noindent\hskip2in\relax Advisory Committee Chair \vskip2.5ex
\fi

\ifnum \@numberofmembers = 6
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\hskip2in{\@comfour}\relax\vskip1.5ex\relax
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\hskip2in{\@comfive}\relax\vskip1.5ex\relax
\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\hskip2in\relax{\@commchair}\relax\vskip-1ex
\noindent\hskip2in\relax Advisory Committee Chair \vskip2.5ex
\fi

\noindent\phantom{\hspace{.25in}RECOMMENDED:\hspace{.45in}}\rule{3.75in}{.05mm}\hspace{.25in}
\vskip-1ex\relax\noindent\hskip2in\relax{\@depchair}\relax
\vskip-1ex\relax\noindent\hskip2in\relax Chair, Department of {\@department} \vskip1.5ex

\bigskip \bigskip \par

\noindent\hspace{.25in}APPROVED: \hspace{.8in} \rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\phantom{\hspace{.25in}APPROVED: \hspace{.8in} }{\@colldean}\relax\vskip-1ex
\noindent\phantom{\hspace{.25in}APPROVED: \hspace{.8in} }Dean, {\@college}\hspace{.25in}\vskip2.5ex\relax
\noindent\phantom{\hspace{.25in}APPROVED: \hspace{.8in} }\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\phantom{\hspace{.25in}APPROVED: \hspace{.8in} }{\@gsdean}\relax\vskip-1ex
\noindent\phantom{\hspace{.25in}APPROVED: \hspace{.8in} }Dean of the Graduate School\hspace{.25in}\vskip2.5ex\relax
\noindent\phantom{\hspace{.25in}APPROVED: \hspace{.8in} }\rule{3.75in}{.05mm}\hspace{.25in}\vskip-1ex\relax
\noindent\phantom{\hspace{.25in}APPROVED: \hspace{.8in} }Date
\newpage \thispagestyle{empty}~ % a blank page that serves as the backside of the signature page
\newpage}

%% the abstract goes here and gets its page set to 5, as req'd (note:
%% abstract and acknowledgements are frontschap's --> defined later)
\newenvironment{abstract}{
\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
\setcounter{page}{5}\frontchap*{\abstractname}
\addcontentsline{toc}{frontchapter}{\abstractname}
}
{\newpage\renewcommand{\thepage}{\arabic{page}}}

%% after the acknowledgements we reset to arabic page #'s if req'd
\newenvironment{acknowledgements}
{
\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
\newpage\addcontentsline{toc}{frontchapter}{\acknowledgename}
\frontchap*{\acknowledgename}
}
{\newpage\renewcommand{\thepage}{\arabic{page}}}

%% a page for quotes, etc. is allowed here; it is unnumbered
%%      but page counter advances
\newenvironment{quotepage}
{
\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
\frontchap*{\relax}\thispagestyle{empty}
}
{\newpage\renewcommand{\thepage}{\arabic{page}}}

%% just for heavner
\newenvironment{preface}
{
\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
\newpage\addcontentsline{toc}{frontchapter}{\prefname}
\frontchap*{\prefname}
}
{\newpage\renewcommand{\thepage}{\arabic{page}}}

%% Index (use /index in text, 
%% have \begin{nindex}\printindex\end{nindex} (after Bib)
\newenvironment{nindex}
{
%\if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
%%\newpage\addcontentsline{toc}{section}{\indname}
\newpage\addcontentsline{toc}{frontchapter}{\indname}
%%\frontchap*{\prefname}
}
%%{\newpage\renewcommand{\thepage}{\arabic{page}}}

%%%%%%%%%%%%%%%
\if@twoside
    \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\thepage\hfil\slshape\leftmark}%
      \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \let\@mkboth\markboth
      \def\chaptermark##1{%
        \markboth {\uppercase{\ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ \fi
            ##1}}{}}%
      \def\sectionmark##1{%
        \markright {\uppercase{\ifnum \c@secnumdepth >\z@
            \thesection. \ \fi
            ##1}}}}
\else
    \def\ps@headings{%
      \let\@oddfoot\@empty
      \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \let\@mkboth\markboth
      \def\chaptermark##1{%
        \markright {\uppercase{\ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ \fi
            ##1}}}}
\fi
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }

\newcommand\chaptermark[1]{}
\setcounter{secnumdepth}{2}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand\thepart          {\Roman{part}}
\renewcommand\thechapter       {\arabic{chapter}}
\renewcommand\thesection       {\thechapter.\arabic{section}}
\renewcommand\thesubsection    {\thesection.\arabic{subsection}}
\renewcommand\thesubsubsection {\thesubsection .\arabic{subsubsection}}
\renewcommand\theparagraph     {\thesubsubsection.\arabic{paragraph}}
\renewcommand\thesubparagraph  {\theparagraph.\arabic{subparagraph}}
\newcommand\@chapapp{\chaptername}
\newcommand\part{\cleardoublepage
                 \thispagestyle{myheadings}%
                 \if@twocolumn
                     \onecolumn
                     \@tempswatrue
                   \else
                     \@tempswafalse
                 \fi
                 \hbox{}\vfil
                 \secdef\@part\@spart}
\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}
    {\centering
     \interlinepenalty \@M
     \reset@font
     \ifnum \c@secnumdepth >-2\relax
       \normalsize\bfseries \partname~\thepart
       \par
     \fi
     \normalsize \bfseries #2\par}%
    \@endpart}
\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \reset@font
     \normalsize \bfseries #1\par}%
    \@endpart}
\def\@endpart{\vfil\newpage
              \if@twoside
                \hbox{}%
                \thispagestyle{empty}%
                \newpage
              \fi
              \if@tempswa
                \twocolumn
              \fi}
%% God bless the person at 
%% http://theoval.sys.uea.ac.uk/~nlct/latex/thesis/node8.html
%% Essentially, to add the word 'Page' right aligned on the
%% same line as 'Table of Contents' we have to some of this.
%% The upshot is that I will define a new \chapteruaf, \schapteruaf,
%% and \@makeschapterheaduaf.
%%
%%    The first argument to \secdef tells LATEX what to do if
%%    the unstarred version is used, and the second argument
%%    tells LATEX what to do if the starred version is used. So
%%    the command
%%     \chapter{Introduction}
%%    will use the command \@chapter, whereas the command
%%     \chapter*{Acknowledgements}
%%    will use the command \@schapter. The commands \@chapter
%%    and \@schapter use the commands \@makechapterhead and
%%    \@makeschapterhead, respectively, to format the chapter
%%    heading, so if you want to change the chapter format, you
%%    will need to redefine the commands \@makechapterhead and
%%    \@makeschapterhead. The easiest way to do this is to look
%%    for the code for these commands in report.cls and copy
%%    them over to your new class file, mythesis, described
%%    earlier, and edit the appropriate formatting commands.
%%
%% This is a total hack, but to maintain 'Table of Contents' in
%% center of page and to position 'Page' correctly, I had to
%% use vspace and hspace through trial and error until it looked
%% correct.  If you print it out and hold a ruler to the lines
%% and margins, it should be pretty good.  But if you do not like
%% it then you can change the hspace and vspace arguments by
%% a whee little bit.
%%
%% Updated to use flushright environment, which will keep it 
%%

\newcommand\chapteruaf{
\if@arabic\relax\else\if@chapterone\setcounter{page}{1}\else\relax\fi\fi
\@chapteronefalse
                    %\if@openright\cleardoublepage\else\clearpage\fi
			\clearpage
                    \thispagestyle{myheadings}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapteruaf}
\def\@schapteruaf#1{\if@twocolumn
                   \@topnewpage[\@makeschapterheaduaf{#1}]%
		   \@afterheading
                 \else
                   \@makeschapterheaduaf{#1}%
                   \@afterheading
                 \fi}

\def\@makeschapterheaduaf#1{%
  {\parindent \z@ \centering
    \reset@font
    \normalsize %\bfseries  
	\textbf{#1}\par
    %\vspace{-18.3pt}
	%\hspace{143mm} 
	\begin{flushright}Page\end{flushright}\vspace*{-13.3pt}
    \nobreak
  }
}

\newcommand\chapter{
\if@arabic\relax\else\if@chapterone\setcounter{page}{1}\else\relax\fi\fi
\@chapteronefalse
                    \if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{myheadings}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{#1}
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\vspace{10\p@}}%
                    \addtocontents{lot}{\protect\vspace{10\p@}}%
                    \addtocontents{lom}{\protect\vspace{10\p@}}%
                    \addtocontents{loa}{\protect\vspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
\def\@makechapterhead#1{%
  {\parindent \z@ \centering \reset@font
    \ifnum \c@secnumdepth >\m@ne
         \normalsize\bfseries \@chapapp{} \thechapter
         \par
       \fi
    \normalsize \bfseries #1\par
    \nobreak
  }}
\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\def\@makeschapterhead#1{%
  {\parindent \z@ \centering
    \reset@font
    \normalsize \bfseries  #1\par
    \nobreak
  }}

%% here's the frontchap stuff, TOTALLY the same as a chapter, but with 
%% centered chapter title
\newcommand\frontchap{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{myheadings}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@frontchap\@sfrontchap}
\def\@frontchap[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{frontchap}%
                         \typeout{\@chapapp\space\thefrontchap.}%
                         \addcontentsline{toc}{frontchap}%
                                   {\protect\numberline{\thefrontchap}#1}%
                    \else
                      \addcontentsline{toc}{frontchap}{#1}
                    \fi
                    \frontchapmark{#1}%
                    \addtocontents{lof}{\protect\vspace{10\p@}}%
                    \addtocontents{lom}{\protect\vspace{10\p@}}%
                    \addtocontents{lot}{\protect\vspace{10\p@}}%
                    \addtocontents{loa}{\protect\vspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makefrontchaphead{#2}]%
                    \else
                      \@makefrontchaphead{#2}%
                      \@afterheading
                    \fi}
\def\@makefrontchaphead#1{%
  {\parindent \z@ \centering \reset@font
    \ifnum \c@secnumdepth >\m@ne
         \normalsize\bfseries \@chapapp{} \thefrontchap
         \par
       \fi
    \centering \bfseries #1\par
    \nobreak
  }}
\def\@sfrontchap#1{\if@twocolumn
                   \@topnewpage[\@makesfrontchaphead{#1}]%
                 \else
                   \@makesfrontchaphead{#1}%
                   \@afterheading
                 \fi}
\def\@makesfrontchaphead#1{%
%% put these suckers at top of page
%%  \vspace*{50\p@}%
  {\parindent \z@ \centering
    \reset@font
    \begin{center}
    \normalsize \bfseries  #1\end{center}\par
    \nobreak
%%    \vskip 40\p@
  }}

\newcommand{\appchapter}[1]{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{myheadings}%
	\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
		 \begin{center} \bfseries Appendix\space\thechapter \\ #1 \end{center}
                          \addcontentsline{loa}{frontchapter}%
                                   {Appendix \protect\numberline{\thechapter}#1}%
        \else
                 \addcontentsline{loa}{frontchapter}{Appendix \protect\numberline{\thechapter}#1}
	\fi
	
	\setcounter{section}{0}
    	%\begin{center}\normalsize\bfseries
	%	Appendix \thechapter \\ #1 \end{center}
	%\addcontentsline{loa}{frontchapter}{Appendix \protect\numberline{\thechapter} #1}
	%\ifnum \c@secnumdepth >\m@ne
	%	\stepcounter{chapter}\setcounter{section}{1}
}
\newcommand{\appsection}[1]{% addcontents line to loa, not toc; left justified, bold, etc.
	\refstepcounter{section}
		\begin{flushleft} \bfseries {\thesection\protect\space\space}#1 \end{flushleft}
			\addcontentsline{loa}{section}{\protect\numberline{\thesection}#1}
	\setcounter{subsection}{0}
}
\newcommand{\appsubsection}[1]{
	\refstepcounter{subsection}
	\begin{flushleft} \bfseries {\thesubsection\protect\space\space}#1 \end{flushleft}
	\addcontentsline{loa}{subsection}{\protect\numberline{\thesubsection} #1}
	\setcounter{subsubsection}{0}
}
\newcommand{\appsubsubsection}[1]{
	\refstepcounter{subsubsection}
	\begin{flushleft} \bfseries {\thesubsubsection\protect\space\space}#1 \end{flushleft}
	\addcontentsline{loa}{subsection}{\protect\numberline{\thesubsubsection} #1}
	
}

\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {0.1ex }%
                                   {\reset@font\normalsize\bfseries}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\reset@font\normalsize\bfseries}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\reset@font\normalsize\bfseries}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\reset@font\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\reset@font\normalsize\bfseries}}
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength\leftmargin    {\leftmargini}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\arabic{enumi}}
\renewcommand\theenumii{\alph{enumii}}
\renewcommand\theenumiii{\roman{enumiii}}
\renewcommand\theenumiv{\Alph{enumiv}}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{$\m@th\bullet$}
\newcommand\labelitemii{\normalfont\bfseries --}
\newcommand\labelitemiii{$\m@th\ast$}
\newcommand\labelitemiv{$\m@th\cdot$}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\newenvironment{verse}
               {\let\\=\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item[]}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item[]}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item[]}
               {\endlist}
\newcommand\appendix{\par
  \setcounter{chapter}{0}%
  %\setcounter{section}{1}%
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\Alph{chapter}}
  \addcontentsline{toc}{frontchapter}{Appendix}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset{equation}{chapter}
\renewcommand\theequation{\thechapter.\arabic{equation}}
\newcounter{figure}[chapter]
\renewcommand\thefigure{\thechapter.\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand\thetable{\thechapter.\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1. #2}%
  \ifdim \wd\@tempboxa >\hsize
    {\ssp#1. #2\par}
  \else
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\def\cal{\protect\pcal}
\newcommand{\pcal}{\@fontswitch{\relax}{\mathcal}}
\def\mit{\protect\pmit}
\newcommand{\pmit}{\@fontswitch{\relax}{\mathnormal}}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg {2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}

\newcommand\tableofcontents{%
    \@chapteronefalse
    \if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
  \newpage%\addcontentsline{toc}{chapter}{\contentsname}  %added by LEif
	
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapteruaf*{\contentsname
        \@mkboth{\uppercase{\contentsname}}{\uppercase{\contentsname}}}%
    \@chapteronetrue
    %\cftaftertoctitle
    \@starttoc{toc} 
    \if@restonecol\twocolumn\fi
    \newpage\renewcommand{\thepage}{\arabic{page}}}

\newcommand\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \setlength\@tempdima{3em}%
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \normalsize \bfseries #1\hfil \hbox to\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}
    \endgroup
  \fi}
\newcommand\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
%    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{1.5em}%
%    \begingroup
%      \parindent \z@ \rightskip \@pnumwidth
%      \parfillskip -\@pnumwidth
%      \leavevmode \bfseries
%     \advance\leftskip\@tempdima
%      \hskip -\leftskip
	\begingroup
	\bfseries
      {\@dottedtocline{0}{0.0em}{1.5em}{Chapter #1}{\textbf{#2}}}
	\endgroup
%#1\nobreak\hfil \nobreak\hbox to\@pnumwidth{\hss #2}\par
%      \penalty\@highpenalty  
%    \endgroup
  \fi}
\newcommand\l@frontchapter[2]{%
  \ifnum \c@tocdepth >\m@ne
%    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{1.5em}%
%    \begingroup
%      \parindent \z@ \rightskip \@pnumwidth
%      \parfillskip -\@pnumwidth
%      \leavevmode \bfseries
%     \advance\leftskip\@tempdima
%      \hskip -\leftskip
	\begingroup
	\bfseries
      {\@dottedtocline{0}{0.0em}{1.5em}{#1}{\textbf{#2}}}
	\endgroup
%#1\nobreak\hfil \nobreak\hbox to\@pnumwidth{\hss #2}\par
%      \penalty\@highpenalty  
%    \endgroup
  \fi}
\newcommand\l@appendix[2]{%
  \ifnum \c@tocdepth >\m@ne
%    \addpenalty{-\@highpenalty}%
    \setlength\@tempdima{1.5em}%
%    \begingroup
%      \parindent \z@ \rightskip \@pnumwidth
%      \parfillskip -\@pnumwidth
%      \leavevmode \bfseries
%     \advance\leftskip\@tempdima
%      \hskip -\leftskip
	\begingroup
      {\@dottedtocline{0}{0.0em}{1.5em}{Appendix #1}{{#2}}}
	\endgroup
%#1\nobreak\hfil \nobreak\hbox to\@pnumwidth{\hss #2}\par
%      \penalty\@highpenalty  
%    \endgroup
  \fi}
\newcommand\l@section      {\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\l@subsection   {\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand\l@paragraph    {\@dottedtocline{4}{10em}{5em}}
\newcommand\l@subparagraph {\@dottedtocline{5}{12em}{6em}}
\newcommand\listofappendices{%
    \@chapteronefalse
    \if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapteruaf*{\listappname
      \@mkboth{\uppercase{\listappname}}%
              {\uppercase{\listappname}}}%
    \@chapteronetrue
    %% get this in contents as a section
    \addcontentsline{toc}{frontchapter}{\listappname}
    %\cftafterloftitle
    \@starttoc{loa}%
    \if@restonecol\twocolumn\fi
    \newpage\renewcommand{\thepage}{\arabic{page}}}
\newcommand\listofothermaterials{%
    \@chapteronefalse
    \if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapteruaf*{\listothermatname
      \@mkboth{\uppercase{\listothermatname}}%
              {\uppercase{\listothermatname}}}%
    \@chapteronetrue
    %% get this in contents as a section
    \addcontentsline{toc}{frontchapter}{\listothermatname}
    %\cftafterloftitle
    \@starttoc{lom}%
    \if@restonecol\twocolumn\fi
    \newpage\renewcommand{\thepage}{\arabic{page}}}
\newcommand\listoffigures{%
    \@chapteronefalse
    \if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapteruaf*{\listfigurename
      \@mkboth{\uppercase{\listfigurename}}%
              {\uppercase{\listfigurename}}}%
    \@chapteronetrue
    %% get this in contents as a section
    \addcontentsline{toc}{frontchapter}{\listfigurename}
    %\cftafterloftitle
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    \newpage\renewcommand{\thepage}{\arabic{page}}}
\newcommand\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \@chapteronefalse
    \if@arabic\relax\else\renewcommand{\thepage}{\roman{page}}\fi
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapteruaf*{\listtablename
      \@mkboth{\uppercase{\listtablename}}{\uppercase{\listtablename}}}%
    %% get this in contents as a section
    \@chapteronetrue
    \addcontentsline{toc}{frontchapter}{\listtablename}
    %\cftafterloftitle
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \newpage\renewcommand{\thepage}{\arabic{page}}}
\let\l@table\l@figure
\newdimen\bibindent
\bibindent=1.5em
\newenvironment{thebibliography}[1]
     {\section{\bibname
	\addcontentsline{toc}{section}{\bibname}        
	\@mkboth{\uppercase{\bibname}}{\uppercase{\bibname}}}%
      \list{\@biblabel{\arabic{enumiv}}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \if@openbib
              \advance\leftmargin\bibindent
              \itemindent -\bibindent
              \listparindent \itemindent
              \parsep \z@
            \fi
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\arabic{enumiv}}}%
      \if@openbib
        \renewcommand\newblock{\par}
      \else
        \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
      \fi
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.=\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\newcommand\newblock{}
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\uppercase{\indexname}}%
                        {\uppercase{\indexname}}%
                \thispagestyle{myheadings}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem  {\par\hangindent 40\p@}
\newcommand\subitem   {\par\hangindent 40\p@ \hspace*{20\p@}}
\newcommand\subsubitem{\par\hangindent 40\p@ \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}
\@addtoreset{footnote}{chapter}
\long\def\@makefntext#1{%
    \parindent 1em%
    \noindent
    \hbox to 1.8em{\hss\@makefnmark}#1}

%% this little gem provides for single-spaced footnotes
\long\def\@footnotetext#1{\insert\footins{\ssp\reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
   \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
    {\rule{\z@}{\footnotesep}\ignorespaces
      #1\strut}}}


%% change names here if'n you'd rather call 'em by a different name
\newcommand\contentsnameblah{Blah of Contents}
\newcommand\contentsname{Table of Contents}
\newcommand\signame{Signature Page}
\newcommand\titlename{Title Page}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\listothermatname{List of Other Materials}
\newcommand\listappname{List of Appendices}
\newcommand\bibname{References}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
\newcommand\acknowledgename{Acknowledgements}
\newcommand\prefname{Preface}
\newcommand\indname{Index}

%% get bibliography in contents as a section (robustly)
\renewcommand\bibliography[1]{
        \newpage
                \addcontentsline{toc}{section}{\bibname}
\if@filesw
  \immediate\write\@auxout{\string\bibdata{#1}}\fi
  \@input@{\jobname.bbl}}
        

\newcommand\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{myheadings}
\pagenumbering{arabic}      % Arabic page numbers
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi

%% here's where we meet the page layout requirements of the grad school
\oddsidemargin 0.5in   %   Note that \oddsidemargin = \evensidemargin
   \evensidemargin 0.0in
   \marginparwidth 0pt
\marginparsep 10pt      % Horizontal space between outer margin and 
                        % marginal note
\topmargin 0.0in        %    Nominal distance from top of page to top of
                        %    box containing running head.
\headheight 12pt        %    Height of box containing running head.
\headsep 25pt           %    Space between running head and text.
\topskip = 11pt         %    '\baselineskip' for first line of page.
                        % Bottom of page:
\footskip 30pt          %    Distance from baseline of box containing
                        %    foot to baseline of last line of text.
\textheight = 8.5truein
%\advance\textheight by \topskip
\textwidth 6.0truein     % Width of text line.
                         % For two-column mode: 
\columnsep 10pt          %    Space between columns 
\columnseprule 0pt       %    Width of rule between columns.
 
%% force a raggedbottom here so page numbers at fronts o' chap's don't
%% spill over bottom margins
\raggedbottom

%% lastly, get page numbers where we want 'em (mixed top-right/bottom-
%% center) (the arabic/roman controversy is solved in each frontmatter
%% section so that separate parts can be consistently produced)
\pagestyle{myheadings}

\endinput
%% that's all she wrote
