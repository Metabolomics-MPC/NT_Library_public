# MPC MS2 database

Metabolite identification requires high-quality reference libraries obtained from chemical standards. This repository stores the public part of the MPCs reference library containing MS2 and RT information. The library is available in different formats, e.g., MassBank records or .msp files.
The library is generated on two Sciex ZenoTOF 7600 instruments, one for reversed-phase separation and one for hydrophilic liquid interaction chromatography-based separation. MS2 spectra are generated with CID and EAD and different collision or kinetic energies, and experts from the MPC manually curate data.

## RP methodology

Reversed-phase analysis has been carried out using a Sciex ExionLC AD coupled to a Sciex ZenoTOF 7600 (Sciex Darmstadt, Germany). Separation was achieved on a Phenomenex Kinetex C18 column (100 mm x 2.1 mm ID, 1.7 µm particle size) (Phenomenex, Aschaffenburg, Germany) using a linear gradient from eluent A (100% H2O + 0.1% formic acid) to eluent B (100% ACN + 0.1% formic acid). The following gradient was used: 95/5 at 0.0 min, 95/5 at 1.5 min, 0.1/99.9 at 10.0 min, 0.1/99.9 at 12.0 min, 95/5 at 12.1 min. The column was re-equlibrated for 2.9 minutes and flow rate was set to 0.500 mL/min and column temperature at 40°C. Analysis was performed in positive and negative ionization mode using the same LC method. Detailed method parameters can be found in [1]. 

## HILIC methodology

HILIC separation has been carried out using an Agilent 1290 Infinity II BioLC (Agilent Technologies, Waldbronn, Germany) coupled to a Sciex ZenoTOF 7600 (Sciex, Darmstadt, Germany). Separate LC methods for positive and negative ionization mode have been used. Separation for metabolites from positive ionization mode have been performed on an Agilent Infinity Poroshell 120 HILIC-Z column (100 mm x 2.1 mm, 2.7 µm particle size, PEEK-lined) (Agilent Technologies, Waldbronn, Germany) using a linear gradient with eluent A (100% H2O + 10 mM ammonium formate / 0.1% formic acid) and eluent B (10% H2O / 90% ACN + 10 mM ammonium formate / 0.1% formic acid). The following gradient was used: 0/100 at 0.0 min, 0/100 at 2.0 min, 90/10 at 7.5 min, 90/10 at 9.0 min, 0/100 at 10 min. The column was re-equlibrated for 5 minutes and the flow rate was set to 0.500 mL/min and column temperature at 40°C. Separation of metabolites from negative ionization mode have been performed on a Waters Atlantis Premier BEH Z-HILIC (100 mm x 2.1 mm, 1.7 µm particle size) (Waters, Eschborn, Germany) using a linear gradient with eluent A (100% H2O + 10 mM ammonium acetate, pH 9.0) and eluent B (10% H2O / 90% ACN + 10 mM ammonium acetate, pH 9.0). The following gradient was used: 0/100 at 0.0 min, 0/100 at 2.0 min, 90/10 at 7.5 min, 90/10 at 9.0 min, 0/100 at 10 min. The column was re-equlibrated for 5 minutes and the flow rate was set to 0.500 mL/min and column temperature at 40°C. Detailed method parameters can be found in [1]. 

## Energy ranges and adducts

Fragmentation spectra were collected using CID and EAD. In the case of CID two collision energy ramps are used in CID: 35 eV +/- 15 eV or 50 eV +/- 20 eV. In EAD spectra were collected at kinetic energies of 12 eV, 16 eV and 24 eV. In case of RP analysis the following adducts were considered: [M+H]<sup>+</sup>, [M+Na]<sup>+</sup>, [M-H]<sup>-</sup> and [M+FA-H]<sup>-</sup>. For positive HILIC analysis the following adducts were considered: [M+H]<sup>+</sup>, [M+Na]<sup>+</sup>, [M+NH4]<sup>+</sup>. For negative HILIC analysis, the following adducts were considered: [M-H]<sup>-</sup>, [M+HAc-H]<sup>-</sup>. 

## Metabolite IDs

Each metabolite in  the database receives a unique identifier. A central list is maintained, and new entries are checked against existing ones based on their InChIKey to ensure no duplication.

## ID suffixes

Each spectrum can be uniquely identified by the metabolite ID and a suffix specific to the LC method, fragmentation method and energy range. The table below summarizes all suffixes.

| LC method | ionization mode | ion source | fragmentation | energy range | adduct | suffix |
|:----------|:----------------|:-----------|:--------------|:-------------|:-------|:-------|
|RP|Pos|ESI|CID|CE35CES15|[M+H]<sup>+</sup>|001|
|RP|Pos|ESI|CID|CE35CES15|[M+Na]<sup>+</sup>|002|
|RP|Neg|ESI|CID|CE35CES15|[M-H]<sup>-</sup>|003|
|RP|Neg|ESI|CID|CE35CES15|[M+FA-H]<sup>-</sup>|004|
|RP|Pos|ESI|CID|CE50CES20|[M+H]<sup>+</sup>|005|
|RP|Pos|ESI|CID|CE50CES20|[M+Na]<sup>+</sup>|006|
|RP|Neg|ESI|CID|CE50CES20|[M-H]<sup>-</sup>|007|
|RP|Neg|ESI|CID|CE50CES20|[M+FA-H]<sup>-</sup>|008|
|RP|Pos|ESI|EAD|KE12|[M+H]<sup>+</sup>|009|
|RP|Pos|ESI|EAD|KE12|[M+Na]<sup>+</sup>|010|
|RP|Neg|ESI|EAD|KE12|[M-H]<sup>-</sup>|011|
|RP|Neg|ESI|EAD|KE12|[M+FA-H]<sup>-</sup>|012|
|RP|Pos|ESI|EAD|KE16|[M+H]<sup>+</sup>|013|
|RP|Pos|ESI|EAD|KE16|[M+Na]<sup>+</sup>|014|
|RP|Neg|ESI|EAD|KE16|[M-H]<sup>-</sup>|015|
|RP|Neg|ESI|EAD|KE16|[M+FA-H]<sup>-</sup>|016|
|RP|Pos|ESI|EAD|KE24|[M+H]<sup>+</sup>|017|
|RP|Pos|ESI|EAD|KE24|[M+Na]<sup>+</sup>|018|
|RP|Neg|ESI|EAD|KE24|[M-H]<sup>-</sup>|019|
|RP|Neg|ESI|EAD|KE24|[M+FA-H]<sup>-</sup>|020|
|HILIC|Pos|ESI|CID|CE35CES15|[M+H]<sup>+</sup>|021|
|HILIC|Pos|ESI|CID|CE35CES15|[M+Na]<sup>+</sup>|022|
|HILIC|Pos|ESI|CID|CE35CES15|[M+NH4]<sup>+</sup>|023|
|HILIC|Neg|ESI|CID|CE35CES15|[M-H]<sup>-</sup>|024|
|HILIC|Neg|ESI|CID|CE35CES15|[M+HAc-H]<sup>-</sup>|025|
|HILIC|Pos|ESI|CID|CE50CES20|[M+H]<sup>+</sup>|026|
|HILIC|Pos|ESI|CID|CE50CES20|[M+Na]<sup>+</sup>|027|
|HILIC|Pos|ESI|CID|CE50CES20|[M+NH4]<sup>+</sup>|028|
|HILIC|Neg|ESI|CID|CE50CES20|[M-H]<sup>-</sup>|029|
|HILIC|Neg|ESI|CID|CE50CES20|[M+HAc-H]<sup>-</sup>|030|
|HILIC|Pos|ESI|EAD|KE12|[M+H]<sup>+</sup>|031|
|HILIC|Pos|ESI|EAD|KE12|[M+Na]<sup>+</sup>|032|
|HILIC|Pos|ESI|EAD|KE12|[M+NH4]<sup>+</sup>|033|
|HILIC|Neg|ESI|EAD|KE12|[M-H]<sup>-</sup>|034|
|HILIC|Neg|ESI|EAD|KE12|[M+HAc-H]<sup>-</sup>|035|
|HILIC|Pos|ESI|EAD|KE16|[M+H]<sup>+</sup>|036|
|HILIC|Pos|ESI|EAD|KE16|[M+Na]<sup>+</sup>|037|
|HILIC|Pos|ESI|EAD|KE16|[M+HAc-H]<sup>-</sup>|038|
|HILIC|Neg|ESI|EAD|KE16|[M-H]<sup>-</sup>|039|
|HILIC|Neg|ESI|EAD|KE16|[M+HAc-H]<sup>-</sup>|040|
|HILIC|Pos|ESI|EAD|KE24|[M+H]<sup>+</sup>|041|
|HILIC|Pos|ESI|EAD|KE24|[M+Na]<sup>+</sup>|042|
|HILIC|Pos|ESI|EAD|KE24|[M+NH4]<sup>+</sup>|043|
|HILIC|Neg|ESI|EAD|KE24|[M-H]<sup>-</sup>|044|
|HILIC|Neg|ESI|EAD|KE24|[M+HAc-H]<sup>-</sup>|045|

## Literature

[1] Anna Artati, Pauline Couacault, Michael Witting, Non-targeted Metabolomics using the Sciex ZenoTOF 7600, MiMB
