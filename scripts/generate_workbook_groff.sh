#!/bin/bash

OUTPUT_DIR="resources/assets/action-kit/power-mapping-lab"
PDF_FILE="$OUTPUT_DIR/workbook.pdf"
GROFF_FILE="workbook.ms"

mkdir -p "$OUTPUT_DIR"

cat <<EOF > "$GROFF_FILE"
.ig
Power Mapping Workbook
Tangency Action Kit
..
.nr PS 12
.nr VS 16
.fam H
.
.ds CH
.ds CF Tangency Action Kit - Power Mapping Lab
.
.TL
POWER MAPPING LAB
.
.AU
Action Kit Workbook
.
.NH
BRAINSTORMING ROSTER
.LP
Before mapping, list everyone who might care. Don't self-edit yet. Mark their potential category (Ally/Opponent/Target).
.
.TS
tab(|);
cw(2.5i) | cw(1.5i) | cw(2.5i)
l | l | l.
_
NAME / ORGANIZATION | CATEGORY | WHY DO THEY CARE?
_
.sp 0.3i
| |
_
.sp 0.3i
| |
_
.sp 0.3i
| |
_
.sp 0.3i
| |
_
.sp 0.3i
| |
_
.sp 0.3i
| |
_
.sp 0.3i
| |
_
.sp 0.3i
| |
_
.sp 0.3i
| |
_
.sp 0.3i
| |
_
.TE
.bp
.NH
TARGET ANALYSIS PROFILE
.LP
Deep dive on your PRIMARY TARGET - the person who can say "yes".
.sp 1
.B "PRIMARY TARGET NAME:"
____________________________________________________
.sp 0.5
.B "TITLE / ROLE:"
____________________________________________________
.sp 0.5
.B "DECISION POWER:"
(What specific demand can they grant?)
.sp 2
.B "1. SELF-INTEREST"
(What do they want? Votes, money, reputation, legacy?)
.sp 1
______________________________________________________________________
.sp 0.5
______________________________________________________________________
.sp 0.5
______________________________________________________________________
.sp 2
.B "2. INFLUENCERS"
(Who do they listen to? Donors, spouse, advisors?)
.sp 1
______________________________________________________________________
.sp 0.5
______________________________________________________________________
.sp 0.5
______________________________________________________________________
.sp 2
.B "3. PRESSURE POINTS"
(Upcoming elections, shareholder meetings, public events?)
.sp 1
______________________________________________________________________
.sp 0.5
______________________________________________________________________
.bp
.NH
STRATEGY SELECTION GRID
.LP
Map stakeholders based on Influence vs. Support to choose your tactic.
.sp 1
.TS
center box;
cb | cb
c | c.
OPPONENTS | CHAMPIONS
(High Influence / Oppose) | (High Influence / Support)
Tactic: Isolate & Pressure | Tactic: Activate & Lead
_
DETRACTORS | ALLIES
(Low Influence / Oppose) | (Low Influence / Support)
Tactic: Monitor | Tactic: Educate & Empower
.TE
.sp 2
.B "KEY ACTIONS & ASSIGNMENTS:"
.sp 1
______________________________________________________________________
.sp 0.5
______________________________________________________________________
.sp 0.5
______________________________________________________________________
.sp 0.5
______________________________________________________________________
EOF

# Generate PDF using groff
groff -ms -Tpdf "$GROFF_FILE" > "$PDF_FILE"
rm "$GROFF_FILE"

echo "Generated PDF at $PDF_FILE"
ls -l "$PDF_FILE"
