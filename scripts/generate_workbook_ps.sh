#!/bin/bash

OUTPUT_DIR="resources/assets/action-kit/power-mapping-lab"
PS_FILE="$OUTPUT_DIR/workbook.ps"
PDF_FILE="$OUTPUT_DIR/workbook.pdf"

mkdir -p "$OUTPUT_DIR"

# Begin PostScript generation
cat <<EOF > "$PS_FILE"
%!PS-Adobe-3.0
%%Title: Power Mapping Workbook
%%Creator: Tangency Foundation
%%Pages: 3
%%EndComments

/inch { 72 mul } def
/margin 0.75 inch def
/pageWidth 8.5 inch def
/pageHeight 11 inch def
/contentWidth pageWidth margin 2 mul sub def

/Helvetica-Bold findfont 24 scalefont setfont
/Helvetica findfont 12 scalefont setfont
/Helvetica-Oblique findfont 10 scalefont setfont

% --- Helper Functions ---
/centerText { 
    dup stringwidth pop 
    pageWidth exch sub 2 div 
    exch moveto show 
} def

/rightAlignText {
    dup stringwidth pop
    pageWidth margin sub exch sub
    exch moveto show
} def

/drawLine {
    newpath
    moveto
    lineto
    stroke
} def

/drawBox {
    newpath
    4 2 roll moveto
    dup 0 exch rlineto
    exch 0 rlineto
    neg 0 exch rlineto
    closepath
    stroke
} def

/drawFilledBox {
    newpath
    4 2 roll moveto
    dup 0 exch rlineto
    exch 0 rlineto
    neg 0 exch rlineto
    closepath
    fill
} def

% --- Page 1: Brainstorming Roster ---
%%Page: 1 1
/Helvetica-Bold findfont 24 scalefont setfont
margin pageHeight margin sub 20 sub moveto (Stakeholder Brainstorming Roster) show

/Helvetica findfont 12 scalefont setfont
margin pageHeight margin sub 50 sub moveto (Before mapping, list everyone who might care. Don't self-edit yet.) show

% Table Header
/yPos pageHeight margin sub 80 sub def
/rowHeight 30 def

0.5 setlinewidth
margin yPos moveto contentWidth 0 rlineto stroke

/Helvetica-Bold findfont 10 scalefont setfont
margin 5 add yPos 10 add moveto (NAME / ORGANIZATION) show
margin 200 add yPos 10 add moveto (CATEGORY) show
margin 350 add yPos 10 add moveto (WHY THEY CARE / NOTES) show

% Draw Rows
/Helvetica findfont 12 scalefont setfont
20 {
    /yPos yPos rowHeight sub def
    0.25 setlinewidth
    margin yPos moveto contentWidth 0 rlineto stroke
    
    % Vertical lines (optional, kept simple for now)
    % margin 190 add yPos moveto 0 rowHeight rlineto stroke
    % margin 340 add yPos moveto 0 rowHeight rlineto stroke
} repeat

% Footer
/Helvetica-Oblique findfont 9 scalefont setfont
margin 30 moveto (Tangency Action Kit - Power Mapping Lab) show
(Page 1) rightAlignText 30

showpage

% --- Page 2: Target Analysis Profile ---
%%Page: 2 2

/Helvetica-Bold findfont 24 scalefont setfont
margin pageHeight margin sub 20 sub moveto (Target Analysis Profile) show

/Helvetica findfont 12 scalefont setfont
margin pageHeight margin sub 50 sub moveto (Deep dive on your PRIMARY TARGET - the person who can say "yes".) show

% Photo Box
0.9 setgray
margin pageHeight margin sub 180 sub 100 100 drawFilledBox
0 setgray
0.5 setlinewidth
margin pageHeight margin sub 180 sub 100 100 drawBox

/Helvetica findfont 10 scalefont setfont
margin 15 add pageHeight margin sub 135 sub moveto (ATTACH PHOTO) show

% Fields next to photo
/fieldX margin 120 add def
/fieldY pageHeight margin sub 100 sub def

/Helvetica-Bold findfont 11 scalefont setfont
fieldX fieldY moveto (NAME:) show
0.5 setlinewidth
fieldX 40 add fieldY moveto contentWidth 120 sub 40 sub 0 rlineto stroke

/fieldY fieldY 40 sub def
fieldX fieldY moveto (TITLE / ROLE:) show
fieldX 75 add fieldY moveto contentWidth 120 sub 75 sub 0 rlineto stroke

/fieldY fieldY 40 sub def
fieldX fieldY moveto (DECISION POWER:) show
fieldX 105 add fieldY moveto contentWidth 120 sub 105 sub 0 rlineto stroke

% Analysis Sections
/yStart pageHeight margin sub 220 sub def

/drawSection {
    /Helvetica-Bold findfont 12 scalefont setfont
    margin yStart moveto show
    /yStart yStart 20 sub def
    
    /Helvetica-Oblique findfont 10 scalefont setfont
    margin yStart moveto show
    /yStart yStart 10 sub def
    
    0.25 setlinewidth
    4 {
        /yStart yStart 25 sub def
        margin yStart moveto contentWidth 0 rlineto stroke
    } repeat
    /yStart yStart 40 sub def
} def

(1. Self-Interest) (What do they want? Votes, money, reputation, legacy?) drawSection
(2. Influencers) (Who do they listen to? Donors, spouse, advisors?) drawSection
(3. Pressure Points) (Upcoming elections, shareholder meetings, public events?) drawSection

% Footer
/Helvetica-Oblique findfont 9 scalefont setfont
margin 30 moveto (Tangency Action Kit - Power Mapping Lab) show
(Page 2) rightAlignText 30

showpage

% --- Page 3: Strategy Matrix ---
%%Page: 3 3

/Helvetica-Bold findfont 24 scalefont setfont
margin pageHeight margin sub 20 sub moveto (Strategy Selection Matrix) show

/Helvetica findfont 12 scalefont setfont
margin pageHeight margin sub 50 sub moveto (Map stakeholders based on Influence vs. Support to choose your tactic.) show

% Matrix
/matrixSize 400 def
/matrixX pageWidth matrixSize sub 2 div def
/matrixY pageHeight margin sub 100 sub matrixSize sub def
/midX matrixX matrixSize 2 div add def
/midY matrixY matrixSize 2 div add def

% Draw Box
1 setlinewidth
matrixX matrixY matrixSize matrixSize drawBox

% Axes
2 setlinewidth
matrixX midY moveto matrixSize 0 rlineto stroke % Horizontal
midX matrixY moveto 0 matrixSize rlineto stroke % Vertical

% Labels
/Helvetica-Bold findfont 12 scalefont setfont
midX 40 sub matrixY matrixSize add 10 add moveto (High Influence) show
midX 40 sub matrixY 20 sub moveto (Low Influence) show

matrixX 60 sub midY 5 sub moveto (Oppose) show
matrixX matrixSize add 10 add midY 5 sub moveto (Support) show

% Quadrant Labels
/Helvetica-Bold findfont 14 scalefont setfont
0.4 setgray
matrixX 20 add matrixY matrixSize add 30 sub moveto (OPPONENTS) show
matrixX matrixSize 2 div add 20 add matrixY matrixSize add 30 sub moveto (CHAMPIONS) show
matrixX 20 add matrixY 20 add moveto (DETRACTORS) show
matrixX matrixSize 2 div add 20 add matrixY 20 add moveto (ALLIES) show

/Helvetica-Oblique findfont 10 scalefont setfont
0.5 setgray
matrixX 20 add matrixY matrixSize add 45 sub moveto (Isolate & Pressure) show
matrixX matrixSize 2 div add 20 add matrixY matrixSize add 45 sub moveto (Activate & Lead) show
matrixX 20 add matrixY 35 add moveto (Monitor) show
matrixX matrixSize 2 div add 20 add matrixY 35 add moveto (Educate & Empower) show

0 setgray

% Action List
/yStart matrixY 50 sub def
/Helvetica-Bold findfont 12 scalefont setfont
margin yStart moveto (Key Actions & Assignments:) show

/yStart yStart 10 sub def
0.25 setlinewidth
4 {
    /yStart yStart 30 sub def
    margin yStart moveto contentWidth 0 rlineto stroke
} repeat

% Footer
/Helvetica-Oblique findfont 9 scalefont setfont
margin 30 moveto (Tangency Action Kit - Power Mapping Lab) show
(Page 3) rightAlignText 30

showpage
EOF

# Convert to PDF
pstopdf "$PS_FILE" -o "$PDF_FILE"
rm "$PS_FILE" # Cleanup PS file

echo "Generated $PDF_FILE"
