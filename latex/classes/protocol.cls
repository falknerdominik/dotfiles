%%% PROTOCOL
%%
%% This class provides a base for protocols it has no cover sheet
%%
%% author: Dominik Falkner
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ProvidesClass{protocol}[2016/05/23 Simple Class for Protocols]

% define needed latex version
\NeedsTeXFormat{LaTeX2e}

% base class we use to build this
\LoadClass{article}

%%%
%% Loading Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{titlesec}       % customize [subsub | sub]sections
\RequirePackage{listings}       % customize code listings
\RequirePackage{color}          % custom colors (mainly for code-listings)
\RequirePackage{geometry}       % customize page (-margins)
\RequirePackage{graphicx}       % for including images
\RequirePackage{pdfpages}       % for including PDFs
%\RequirePackage{standalone}     % if we include in this document the preample of the included document is ignored

%%%
%% Conf Page - size, margins
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\geometry{a4paper, left=15mm, right=15mm, top=2cm, bottom=2cm}
\setlength\parindent{0pt} % no indents after double linebreak in latex

%%%
%% Conf titlesec - configuration for \[sub]section commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\titleformat{\section}    % customise the headings of a \section
  {
    \huge        % make title large
    \scshape      % small capitals
    \raggedright  % left aligned
  }
  {}{0em}         % Can be used to give a prefix to all sections
  {}              % Can be used to insert code before the heading
  [\titlerule]    % Inserts a horizontal line after the heading

\titleformat{\subsection} % customise the headings of a \subsection
  {\Large\scshape\raggedright}
  {}{0em}
  {}

\titleformat{\subsubsection} % customise the headings of a \subsection
  {\large\scshape\raggedright}
  {}{0em}
  {- }

%%%
%% Conf colors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}

%%%
%% Conf code-listings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\lstdefinestyle{bright}{
  backgroundcolor=\color{white},
  commentstyle=\color{codegreen},
  keywordstyle=\color{blue},
  numberstyle=\tiny\color{codegray},
  stringstyle=\color{red},
  basicstyle=\footnotesize,
  breakatwhitespace=true,
  breaklines=true,
  captionpos=b,
  keepspaces=true,
  numbers=left,
  numbersep=5pt,
  showspaces=false,
  showstringspaces=false,
  showtabs=false,
  tabsize=8
}

\lstset{          % umlauts in code listings
  literate=
    {Ö}{{\"O}}1
    {Ä}{{\"A}}1
    {Ü}{{\"U}}1
    {ß}{{\ss}}1
    {ü}{{\"u}}1
    {ä}{{\"a}}1
    {ö}{{\"o}}1
    {~}{{\textasciitilde}}1,
  style=bright
}
