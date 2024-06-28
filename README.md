# SQL-Project

# Úvod
#### Toto je jeden ze dvou projektu za účelem obdržení certifikace z kurzu "Datová Akademie" od společnosti Engeto. 
#### První částí kurzu jsem se zabývali základy SQL (strukturovaný dotazovací jazyk). Tento projekt zahrnuje vše, co jsme v kurzu probrali a co jsme se naučili ohledně SQL.
#### Já jsem se do tohoto kurzu přihlásila z několika důvodů:
#### 1.	Naučit se PowerBi (pro rozvoj na mé dané pracovní pozici jako Analytik Kmenových Dat)
#### 2.	Výuka formou Online
#### 3.	Kurz nabízel náhled i do jiných odvětví datové analýzy (Excel, SQL).
#### Jsem ráda, že jsem tento kurz absolvovala, protože mám teď ponětí o více směrech než jenom PowerBi.
#### Vypracování tohoto SQL projektu mi trvalo hodně dlouho. Potřebovala jsem si přehrát všechny lekce a zapsat si vše co se probralo. První pokusy vytvoření primární tabulky nebyly lehké. Vytvořila jsem minimálně 20 verzí, než jsem dopracovala k závěrečné verzi, kterou Vám předávám. Dala jsem do toho vše 😊
 
# Zadání SQL projektu:
#### Vypracovat dvě vlastní tabulky z předem určených zdrojů dat. Tabulky pojmenovat:
#### 1. t_{jmeno}_{prijmeni}_project_SQL_primary_final (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky)
#### 2. t_{jmeno}_{prijmeni}_project_SQL_secondary_final (pro dodatečná data o dalších evropských státech). 
#### Ty dvě vytvořené tabulky použít k zodpovězení těchto pěti výzkumných otázek:
#####   1.	Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
#####   2.	Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
#####   3.	Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
#####   4.	Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
#####   5.	Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
 
#### Zdrojem dat jsou k dispozici následujíci existující databáze: 
##### 1.	czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
##### 2.	czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.
##### 3.	czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.
##### 4.	czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.
##### 5.	czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.
##### 6.	czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
##### 7.	czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.
#### Číselníky sdílených informací o ČR:
##### 8.	czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2.
##### 9.	czechia_district – Číselník okresů České republiky dle normy LAU.
#### Dodatečné tabulky:
##### 10.	countries – Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
##### 11.	economies – HDP, GINI, daňová zátěž atd. pro daný stát a rok.

# Vytvořeni Primární tabulky t_lenka_babboni_project_sql_primary_final:

#### Všechny dostupná zdrojová data jsem zanalyzovala abych pochopila zdroj a význam daných hodnot. K tomu jsem si vytvořila excelovou tabulku s vysvětlivkami. Po analýze a pochopeni všech dat jsem uvážila, že k vytvoření první tabulky potřebuji data pouze z níže uvedených zdrojů. Data z těchto zdrojů odpoví na otázky 1-4.
##### czechia_payroll - Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
##### – sloupce:
###### •	payroll_year – měřitelné období
###### •	value – průměrná mzda
###### •	value_type_code = 5958 (= průměrná mzda. Versus value_type_code 316, který určuje počet zaměstnanců a tuto informaci k odpovězeni dotazu nepotřebujeme)
###### •	industry_branch_code – kód pro odvětví
##### czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.
##### -	Sloupce:
###### •	Name  - název odvětví
###### •	Code – abych sloučila název odvětví s kódem z czechia_payroll tabulky
##### czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
##### -	Sloupce:
###### •	Category_code – kód pro potravinu
###### •	Value – cena pro potravinu
###### •	Date_from – měřitelné období
##### czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.
##### -	Sloupce:
###### •	Name – název potraviny
###### •	Code – abych sloučila název potraviny s kódem z czechia_price tabulky

#### Ve vytvořené tabulce jsem zobrazila následující sloupce s relevantními daty:
##### 1.	název odvětví
##### 2.	průměrný plat za dané odvětví v daném roce
##### 3.	daný rok pro průměrný plat v daném odvětví
##### 4.	název potraviny
##### 5.	průměrná cena potraviny v daném roce 
##### 6.	daný rok pro průměrnou cenu dané potraviny
#### Všechny data jsem sloučila na základě roku, u kterého jsem sjednotila formátovaní.
#### Protože zadání znělo vybrat pouze společné roky pro platy a ceny potravin, vyfiltrovala jsem data pouze pro rok 2006 až 2018.
#### Data jsem seskupila podle názvu odvětví, potraviny a roku.

# Vytvořeni Sekundární tabulky t_lenka_babboni_project_sql_secondary_final:

#### Sekundární tabulku jsem vytvořila pouze k zodpovězení dotazu na pátou otázku:
###### Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
#### Ze zadáni jsem pochopila, že musíme vytvořit tabulku, kde potřebujeme vědět narůst či pokles Hrubého Domácího Produktu mezi roky a srovnatelnými s roky měřeni mezd a potravin (tudíž 2006–2018 a pouze pro Českou republiku).
#### K vypracování sekundární tabulky jsme použila pouze data z jednoho datového zdroje: 
###### economies – HDP, GINI, daňová zátěž atd. pro daný stát a rok. 
#### Vytvořila jsem tabulku, kde je jasně viditelný percentuální rozdíl Hrubého Domácího Produktu mezi měřitelnými roky.
#### Ve vytvořené tabulce jsem zobrazila následující sloupce s relevantními daty:
##### 1.	Stát
##### 2.	Měřený rok
##### 3.	Předchozí měřený rok
##### 4.	HDP za měřený rok
##### 5.	HDP za předchozí měřený rok
##### 6.	Percentuální rozdíl mezi měřenými roky.
####  Data jsou vyfiltrované pouze pro Českou republiku a roční rozmezí 2006–2018.

# Výzkumné otázky:

## 1.	Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
#### Ano, z celkového hlediska lze říct, ze ceny mezd průběžně rostou. Avšak jsou odvětví, ve kterých dochází k častým poklesům:
#### -	V peněžnictví a pojišťovnictví došlo k nejčastějším poklesům průměrné mzdy mezi měřitelnými roky
#### -	Dalšími odvětvími, kde došlo k několika poklesům průměrné mzdy jsou:
#### •	Výroba a rozvod elektřiny, plynu, tepla a klimatiz. Vzduchu
#### •	Stavebnictví
#### Nejkritičtějším rokem na pracovním trhu byl rok 2013, kdy klesl průměrný plat ve 14 z 19 odvětvích.

## 2.	Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
#### První srovnatelné období je rok 2006 a poslední srovnatelné období je rok 2018. Množství chleba a mléka jsem počítala na základě minimální mzdy v daném měřitelném roce, aby bylo stejné určené množství pro všechny.
#### Minimální množství pro rok 2006 je 603 ks chleba a 727 listru mléka.
#### Minimální množství pro rok 2018 je 743 ks chleba a 905 listru mléka.

## 3.	Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuálně meziroční nárůst)?
#### I zde jsem se soustředila pouze na první a poslední měřitelné období (2006 a 2018) a vypočítala jsem percentuální rozdíl v každé kategorii.
#### U brambor konzumních je nulový nárůst ceny a u cukru krystal je dokonce 17procentní pokles ceny.

## 4.	Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
#### Ano. Je to rok 2007, kde byl percentuální narůst mezd o 8 procent, ale ceny potravin šly nahoru o 13 procent.

## 5.	Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem? 
#### Srovnala jsem rozdíly meziročních průměrných mezd a potravin z primární tabulky a percentuální rozdíl meziročního HDP ze sekundární tabulky a ve výsledku vidím inkonzistenci, ze které nevidím vliv nárůstu HDP na ceny mezd a potravin.
