<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org1d046ec">1. Description</a></li>
<li><a href="#org0c040f6">2. Files in the repository</a></li>
<li><a href="#orgc338e0c">3. Codebook</a></li>
<li><a href="#org2eadbf1">4. Sources</a></li>
<li><a href="#orgab94a44">5. Acknowledgements</a></li>
</ul>
</div>
</div>
Title: Recent Mexican election vote returns repository
Author: Eric Magar
Date: <span class="timestamp-wrapper"><span class="timestamp">&lt;2017-10-23 Mon&gt;</span></span>

email: emagar at itam dot mx

*WORK IN PROGRESS*

&#x2014;


<a id="org1d046ec"></a>

# Description

The repository contains voting data for recent Mexican elections at some levels. Data is from many sources. More recent years tend to be coded from official vote returns. Earlier elections tend to be from secondary sources (see Souces section). Data inludes district-level federal deputy vote returns since 1979 and district-level presidential vote returns since 2006; and municipality-level municipal president vote returns (except in the state of Nayarit, votes cast for municipal president also elect a municipal council in a fused ballot). 


<a id="org0c040f6"></a>

# Files in the repository

In general, file names identify the office elected (e.g., df, dl, pr, ay, etc. for diputados federales, diputados locales, presidente, ayuntamiento, etc. respectively), followed by the unit of observation (df, mu, se, ca for distrito federal, municipio, seccion, casilla respectively), followed by the years included. 

-   aymu1977-on.csv
-   dfdf1979-on.csv
-   prdf2006-on.csv


<a id="orgc338e0c"></a>

# Codebook

-   *edon* = state number 1:32.
-   *edo* = state abbreviation.
-   *disn* = district number.
-   *yr*, *mo*, *dy* = year, month, day of the election.
-   *cab* = cabecera, district's administrative center.
-   *circ* = PR district (circunscripcion electoral, 2nd tier).
-   *v01*, *v02*, &#x2026; = raw vote for candidate 1, 2, etc.
-   *l01*, *l02*, &#x2026; = label of candidate 1's, 2's, &#x2026; party.
-   *c01*, *c02*, &#x2026; = candidate 1's, 2's, &#x2026; name.
-   *s01*, *s02*, &#x2026; = suplente (substitute) for candidate 1, 2, etc.
-   *efec* = effective votes, total raw votes minus votes for write-in candidates and invalid ballots.
-   *nr* = votes for write-in candidates.
-   *nul* = invalid ballots.
-   *tot* = total raw votes.
-   *lisnom* = eligible voters.
-   *nota* = notes.
-   *fuente* = source.


<a id="org2eadbf1"></a>

# Sources


<a id="orgab94a44"></a>

# Acknowledgements

Eric Magar acknowledges financial support from the Asociación Mexicana de Cultura A.C. and CONACYT's Sistema Nacional de Investigadores. He is responsible for mistakes and shortcomings in the data. 

