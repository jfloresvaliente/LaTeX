function [data, auxData, metaData, txtData, weights] = mydata_Engraulis_ringens
%% set other metadata
metaData.phylum     = 'Chordata'; 
metaData.class      = 'Actinopterygii'; 
metaData.order      = 'Clupeiformes'; 
metaData.family     = 'Engraulidae';
metaData.species    = 'Engraulis_ringens'; 
metaData.species_en = 'Peruvian anchovy'; 

metaData.T_typical  = C2K(18); % K, body temp
metaData.data_0     = {'ab'; 'am'; 'Lp'; 'Li'; 'Wwb'; 'Wwi'; 'Ri'}; 
metaData.data_1     = {'t-L'; 'L-Ww'}; 
metaData.COMPLETE   = 2.5; % using criteria of LikaKear2011
metaData.author     = {'Arturo Aguirre'};        
metaData.date_subm  = [2019 04 01];                           
metaData.email      = {'aaguirre@imarpe.gob.pe'};                 
metaData.address    = {'IMARPE, Callao'};

%% set data
% zero-variate data

data.ah       = 2.3; units.ah      = 'd'; label.ah      = 'age at hatching';    bibkey.ah     = 'WareMend1981';
temp.ah       = C2K(18); units.temp.ah = 'K';label.temp.ah = 'temperature'; 

data.tb       = 4.4;
units.tb      = 'd';
label.tb      = 'time at birth since hatching';
bibkey.tb     = 'WareMend1981'; 
temp.tb       = C2K(18);
units.temp.tb = 'K';
label.temp.tb = 'temperature';
comment.tb    = '3.5 to 6.8 days after hatching';

data.tj       = 80;
units.tj      = 'd';
label.tj      = 'time since hatching at end metamorphosis';
bibkey.tj     = 'MoreClar2011';
temp.tj       = C2K(16);
units.temp.tj = 'K';
label.temp.tj = 'temperature';
comment.tj    = '';

data.tp       = 1*365;
units.tp      = 'd';
label.tp      = 'time since birth at puberty';
bibkey.tp     = 'MarzShin2009';
temp.tp       = C2K(16);
units.temp.tp = 'K';
label.temp.tp = 'temperature';
comment.tp    = 'no temperature available, used the mean temperature of peruvian eosystem';

data.am       = 4*365;
units.am      = 'd';
label.am      = 'life span';
bibkey.am     = 'MarzShin2009';
temp.am       = C2K(16);
units.temp.am = 'K';
label.temp.am = 'temperature';
comment.am    = 'no temperature available, used the mean temperature of peruvian eosystem';

data.E0 = 1;   units.E0 = 'J';   label.E0 = 'egg energy content';       bibkey.E0 = 'guess';
  comment.E0 = 'other anchovy eggs close to 1 J';

data.V0       = 0.00033;
units.V0      = 'cm^3';
label.V0      = 'egg volume';
bibkey.V0     = 'RiouOfel2021';

data.Lh       = 0.3;
units.Lh      = 'cm';
label.Lh      = 'standard length at hatch';
bibkey.Lh     = 'RiouOfel2021';

data.Lb       = 0.4;
units.Lb      = 'cm';
label.Lb      = 'standard (notocordal) length at yolk-absorption';
bibkey.Lb     = 'WareMend1981';

data.Lj       = 3;
units.Lj      = 'cm';
label.Lj      = 'standard length at metamorphosis';
bibkey.Lj     = 'MoreClar2011';
%temp.Lj       = C2K(16);

data.Lp       = 10;%12; guess Laure
units.Lp      = 'cm';
label.Lp      = 'total length at puberty';
bibkey.Lp     = 'fishbase';
comment.Lp    = 'must be lower than reported length at first reproduction (12 cm TL) in Fishbase';

data.Li       = 19;%20.5; guess Laure
units.Li      = 'cm';
label.Li      = 'ultimate total length';
bibkey.Li     = 'MarzShin2009';

%data.Ww0 = 0.3*0.001025;   units.Ww0 = 'g';   label.Ww0 = 'egg wet weight';            bibkey.Ww0 = 'Llanos2014';
% data.Wwj = ;   units.Wwj = 'g';   label.Wwj = 'wet weight at metamorphosis';    bibkey.Wwj = '';
% data.Wwp = ;   units.Wwp = 'g';   label.Wwp = 'wet weight at puberty';          bibkey.Wwp = '';

%data.Wwi = 56; units.Wwi = 'g';    label.Wwi = 'ultimate wet weight';
%bibkey.Wwi = 'PaloMuck1987'; LAURE: if we check the length-weight
%relationship it gives 45g (W = 0.02150.*[12:19].^2.604 or W =
%0.00674.*[12:19].^3 provides similar results. Same ref in Fishbase
data.Wwi = 45; units.Wwi = 'g';    label.Wwi = 'ultimate wet weight';    bibkey.Wwi = 'PaloMuck1987';
  
%data.Ri = 30000*20/365; bibkey.Ri = 'AlheAlegPROCOPA';
data.Ri = 0.1369.* data.Li.^4.2494 * 20 / 365;   units.Ri = '#/d';  label.Ri = 'maximum reprod rate';    bibkey.Ri = 'PereBuit2000';   
  comment.Ri = 'spawnings every 6.2 day during 2 periods of 60 days per year corresponds to 20 batches';
  temp.Ri = C2K(16); units.temp.Ri = 'K'; label.temp.Ri = 'temperature';
% Se debe colocar la info de 20 bactches por a�o, justificar el periodo de
% 2 meses de desove principales. N_B = 2*60/6.2
% if we use PereBuit (Informe Imarpe 2000 154) Fecundity per batch at total
% length is 0.1369.* data.Li.^4.2494
  
% uni-variate data

% time-length
tL_FB = [ ... % age (y), total length (cm), avg temp (deg C), L_inf (TL cm), k (y-1), t0 (y), VB curve number (1 to 6), ref
1	11.16540883	17	19.5	0.85	0	1	1
2	15.93767128	17	19.5	0.85	0	1	1
3	17.97740751	17	19.5	0.85	0	1	1
4	18.84922124	17	19.5	0.85	0	1	1
1	10.74939634	17	18.5	0.87	0	2	1
2	15.25287259	17	18.5	0.87	0	2	1
3	17.13961094	17	18.5	0.87	0	2	1
4	17.9300629	17	18.5	0.87	0	2	1
1	9.60292874	18	18.2	0.75	0	3	1
2	14.13903109	18	18.2	0.75	0	3	1
3	16.28173411	18	18.2	0.75	0	3	1
4	17.29387536	18	18.2	0.75	0	3	1
1	11.16622413	18	19.8	0.83	0	4	2
2	16.03524819	18	19.8	0.83	0	4	2
3	18.15838266	18	19.8	0.83	0	4	2
4	19.08417393	18	19.8	0.83	0	4	2
1	11.27901427	20	20	0.83	0	5	2
2	16.1972204	20	20	0.83	0	5	2
3	18.34180067	20	20	0.83	0	5	2
4	19.27694336	20	20	0.83	0	5	2
1	12.96600922	20	20.5	1.001	0	6	2
2	17.7311699	20	20.5	1.001	0	6	2
3	19.48242241	20	20.5	1.001	0	6	2
4	20.12602829	20	20.5	1.001	0	6	2
];

 data.tL = tL_FB(1:4,[1,2]);
 data.tL(:,1) = data.tL(:,1) .* 365; % years to days
 units.tL = {'d', 'cm'}; label.tL = {'time since birth', 'total length'};  
 temp.tL = C2K(16);  units.temp.tL = 'K'; label.temp.tL = 'temperature'; % same as zerovariate data
 bibkey.tL = 'Fishbase'; % ref 1
 %we add metamorphosis to constrain the estimation
data.tL = [[data.tj data.Lj * 1.141]; data.tL]; % conversion from SL to TL ref Fishbase TL = 1.141 SL
TC_tL= tempcorr(temp.tL, temp.tj, 9000); % check for T_A = 9000K
data.tL(1,1) = data.tL(1,1) / TC_tL; %correction of age at metamorphosis

data.tL_larv_highT = [ % time since hatch (d); standard length (cm)
0	0.3653
0	0.3675
0	0.3626
0	0.3585
0	0.3612
0	0.3404
0	0.3628
0	0.3336
0	0.3633
0	0.3582
0	0.3706
0	0.3729
0	0.369
0	0.3726
0	0.3901
0	0.3918
0	0.3662
0	0.2871
0	0.4025
0	0.2822
0	0.3786
0	0.3647
0	0.3681
4	0.4263
4	0.3992
4	0.4228
4	0.5208
4	0.5012
4	0.4351
4	0.4608
4	0.4001
4	0.4982
4	0.4852
5	0.5234
5	0.4865
5	0.5026
5	0.4799
5	0.5418
5	0.538
5	0.5585
11	0.8581
11	0.8803
11	0.891
11	0.7403
11	1.0529
11	0.8984
11	1.0262
11	0.84
11	0.9251
11	0.813
11	0.9109
11	0.9527
11	0.8612
12	0.9228
12	0.8507
12	0.6765
12	0.8326
12	0.9708
12	0.8124
12	0.7705
12	0.8151
12	0.7141
12	0.7001
19	1.2754
19	1.1911
19	1.1621
19	1.1283
19	1.246
19	1.3706
19	1.2236
19	1.0893
19	1.2838
19	1.1196
19	1.2051
26	1.3558
26	1.5027
26	1.4334
26	1.4733
26	1.2944
26	1.4202
26	1.6701
26	1.7034
26	1.849
26	1.7012
26	1.5582];  
for i=2:size(data.tL_larv_highT,1); if data.tL_larv_highT(i,1)<=data.tL_larv_highT(i-1,1); data.tL_larv_highT(i,1)=data.tL_larv_highT(i-1,1)+1e-3;end;end
units.tL_larv_highT   = {'d', 'cm'};  label.tL_larv_highT = {'time since hatching', 'standard length', '18.5 C'};  
temp.tL_larv_highT    = C2K(18.5);  units.temp.tL_larv_highT = 'K'; label.temp.tL_larv_highT = 'temperature';
bibkey.tL_larv_highT = 'RiouOfel2021';


data.tL_larv_lowT = [ % time since hatching d, standard length cm
8	0.4045
8	0.5254
8	0.5322
11	0.5343
11	0.5431
11	0.5799
17	0.6631
17	0.8126
17	0.7915
17	0.5038
17	0.5958
17	0.5449
24	1.0108
24	0.9449
24	0.6064
24	0.8379
24	1.0477
24	1.0781
24	1.1711
24	1.0785
24	1.0329
24	0.8123
31	1.1071
31	1.0117
31	1.2131
31	1.1086
31	1.1175
31	1.2745
31	1.2837
31	1.1877
31	1.134
31	1.2973
31	1.0665
31	0.9507
31	1.2379];
for i=2:size(data.tL_larv_lowT,1); if data.tL_larv_lowT(i,1)<=data.tL_larv_lowT(i-1,1); data.tL_larv_lowT(i,1)=data.tL_larv_lowT(i-1,1)+1e-3;end;end
units.tL_larv_lowT   = {'d', 'cm'};  label.tL_larv_lowT = {'time since hatching', 'standard length', '14.5 C'};  
temp.tL_larv_lowT    = C2K(14.5);  units.temp.tL_larv_lowT = 'K'; label.temp.tL_larv_lowT = 'temperature';
bibkey.tL_larv_lowT = 'RiouOfel2021';

data.LW = [ ... %LongitudTotal cm, PesoTotal_g
12.3	12
12.3	12.7
12.6	13.2
12.7	11.8
12.7	16.1
12.9	12.7
12.9	14.5
13.2	16.2
13.6	15.1
13.6	19.3
13.8	17
13.9	21
14.1	19.1
14.1	20.6
14.3	22.2
14.3	23
14.4	23.5
14.5	23.9
14.6	24
14.6	25.3
14.8	23.7
14.9	22.1
14.9	25.1
14.9	25.1
14.9	25.9
14.9	25.9
14.9	26.4
15.1	23.3
15.1	25.4
15.1	26.5
15.1	26.5
15.1	27.3
15.1	29.1
15.2	25.1
15.2	27.7
15.2	28.2
15.3	24.9
15.3	28
15.3	30.9
15.3	31.5
15.4	25.8
15.4	29.5
15.4	29.5
15.4	29.8
15.4	30.1
15.4	33.1
15.5	25.7
15.5	26.6
15.5	29.5
15.5	33.8
15.6	26
15.6	32.7
15.6	33.3
15.7	27.4
15.7	30.1
15.7	30.1
15.7	30.7
15.7	30.7
15.8	30.2
15.8	30.9
15.9	28.7
15.9	32.1
15.9	32.7
15.9	33.9
16.1	32.2
16.2	29.7
16.2	31
16.2	31.3
16.2	34
16.2	36.8
16.4	32.7
16.4	33.6
16.4	34.4
16.4	36.1
16.4	36.1
16.5	36.2
16.5	38.5
16.6	34.9
16.6	35.5
16.7	36.6
16.8	36.8
16.9	35
16.9	41.5];
 units.LW = {'cm', 'g'}; label.LW = {'total length', 'total weight'};  
 bibkey.LW = 'Mina1968';
% Agregar dato de columna A, sobre huevos por  batch [lonitud, peso total, peso sin gonada, # huevos/batch (A)]
%  para poder comparar con IGS

% length-fecundity
data.LN_2 = [... % Total length (cm), number of eggs per batch (#)
13	5616
13.5	5605
13.5	8431
13.5	10856
13.5	13391
13.5	14722
14	12832
14	11811
14	11064
14	10571
14	10097
14	9003
14	8365
14	7909
14	5940
14.5	8172
14.5	9211
14.5	10196
14.5	10870
14.5	12475
14.5	13642
15	12245
15	11479
15	9984
15	20233
15	19025
15.5	21094
15.5	19901
15.5	18280
15.5	17256
15.5	24076
16	24294
16	22658
16	21679
16	20624
16	19906
16	19508
16	18438
16	17153
16	16419
16	15578
16	14905
16.5	24054
16.5	22051
16.5	20873
16.5	18855
16.5	16684
16.5	14742
15.5	28426
15.5	27335
15.5	26230
15.5	25210
15.5	15343
15.5	14879
15.5	14284
15.5	13142
15.5	11667
15.5	11013
15.5	10406
16	9777
16	12763
16	13357
16.5	27822
16.5	29734
17	20241
17.5	15881
17.5	18496
17.5	22728
17.5	26129
18	29161
];
units.LN_2 = {'cm', '#'}; label.LN_2 = {'total length', 'number of oocytes per batch'};
temp.LN_2 = C2K(16);  units.temp.LN_2 = 'K'; label.temp.LN_2 = 'temperature';
bibkey.LN_2 = 'PereBuit2000';
comment.LN_2 = 'Assumes 20 spawning batches per year under IMARPE expert knowledge'; 


%% set weights for all real data
weights = setweights(data, []);
weights.tL = 10 * weights.tL;
weights.Lj = 0 * weights.Lj;
weights.tj = 0 * weights.tj;
weights.tp = 0 * weights.tp;
weights.V0 = 0 * weights.V0;
weights.Ri = 0 * weights.Ri;
weights.tL_larv_lowT = 2 * weights.tL_larv_lowT;
weights.tL_larv_highT = 3 * weights.tL_larv_highT;

%% set pseudodata and respective weights
[data, units, label, weights] = addpseudodata(data, units, label, weights);
%weights.psd.kap = 0 * weights.psd.kap;

%% pack auxData and txtData for output
auxData.temp = temp;
txtData.units = units;
txtData.label = label;
txtData.bibkey = bibkey;
txtData.comment = comment;

%% Group plots
set1 = {'tL_larv_highT','tL_larv_lowT'}; subtitle1 = {'Data for high, low temp'};
metaData.grp.sets = {set1};
metaData.grp.subtitle = {subtitle1};

%% References
bibkey = 'Wiki'; type = 'Misc'; bib = ...
'howpublished = {\url{https://en.wikipedia.org/wiki/Engraulis_japonicus}}';  
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Kooy2010'; type = 'Book'; bib = [ ...  % used in setting of chemical parameters and pseudodata
'author = {Kooijman, S.A.L.M.}, ' ...
'year = {2010}, ' ...
'title  = {Dynamic Energy Budget theory for metabolic organisation}, ' ...
'publisher = {Cambridge Univ. Press, Cambridge}, ' ...
'pages = {Table 4.2 (page 150), 8.1 (page 300)}, ' ...
'howpublished = {\url{http://www.bio.vu.nl/thb/research/bib/Kooy2010.html}}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
% bibkey = 'Fuku1983'; type = 'Article'; bib = [ ...  
% 'author = {O. Fukuhara}, ' ...
% 'year = {1983}, ' ...
% 'title = {Development and growth of laboratory reared \emph{Engraulis japonica} ({H}outtuyn) larvae}, ' ... 
% 'journal = {J. Fish Biol.}, ' ...
% 'volume = {23}, '...
% 'pages = {641-652}'];
% metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
% bibkey = 'FukuTaka1988'; type = 'Article'; bib = [ ...  
% 'author = {O. Fukuhara and K. Takao}, ' ...
% 'year = {1988}, ' ...
% 'title = {Growth and larval behaviour of \emph{Engraulis japonica} in captivity}, ' ... 
% 'journal = {J. Appl. Ichthyol.}, ' ...
% 'volume = 4, '...
% 'pages = {158-167}'];
% metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'fishbase'; type = 'Misc'; bib = ...
'howpublished = {\url{https://www.fishbase.se/summary/Engraulis-japonicus.html}}';  
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'BuitPere2000'; type = 'Article'; bib = [ ...  
'author = {Buitron and Perea}, ' ...
'year = {2000}, ' ...
'title = {Condici�n reproductiva y fecuniad de anchoveta Engraulis ringens en el mar peruano durante la primavera 1999}, ' ... 
'journal = {IMARPE reports.}, ' ...
'volume = , '...
'pages = {42-45}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'WareMend1981'; type = 'Article'; bib = [ ...  
'author = {Ware, D. and de Mendiola, B. and Newhouse, D.}, ' ...
'year = {1981}, ' ...
'title = {Behaviour of first-feeding Peruvian anchoveta larvae, Engraulis ringens J.}, ' ... 
'journal = {IMARPE reports.}, ' ...
'volume = , '...
'pages = {80-87}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'MoreClar2011'; type = 'Article'; bib = [ ...    
'author = {Moreno, P. and Claramunt, G. and Castro, L.}, ' ...
'year  = {2011}, ' ...
'title = {Transition period from larva to juvenile in anchoveta Engraulis ringens. Length or age related?}, ' ...  
'journal = {Journal of Fish Biology}, ' ...
'volume = {78}, ' ...
'pages = {825--837}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'MarzShin2009'; type = 'Article'; bib = [ ...    
'author = {Marzloff, M. and Shin, Y. and Tam, J. and Travers, M. and Bertrand, A.}, ' ...
'year  = {2009}, ' ...
'title = {Trophic structure of the Peruvian marine ecosystem in 2000-2006: Insights on the effects of management scenarios for the hake fishery using the IBM trophic model Osmose}, ' ...
'journal = {Journal of Marine Systems}, ' ...
'volume = {75}, ' ...
'pages = {290--304}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'RiouOfel2021'; type = 'Article'; bib = [ ...    
'author = {Rioual, F. and Ofelio, C. and Rosado-Salazar, M. and Dionicio-Acedo, J. and Peck, M. and Aguirre-Velarde, A.}, ' ...
'year  = {2021}, ' ...
'title = {Embryonic development and effect of temperature on larval growth of the Peruvian anchovy Engraulis ringens}, ' ...
'journal = {Journal of Fish Biology}, ' ...
'volume = {}, ' ...
'pages = {1--18}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'PaloMuck1987'; type = 'Article'; bib = [ ...    
'author = {Palomares, D. and Muck, P. and Mendo, J. and Chuman, E. and Gomez, O. and Pauly, D.}, ' ...
'year  = {1987}, ' ...
'title = {Growth of the Peruvian Anchovy (Engraulis ringens), 1953 to 1982}, ' ...
'journal = {The Peruvian Anchovy and its Upwelling Ecosystem: Three Decades of Change}, ' ...
'volume = {}, ' ...
'pages = {117--141}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'CernPlaz2016'; type = 'Article'; bib = [ ...    
'author = {Cerna, F. and Plaza, G.}, ' ...
'year  = {2016}, ' ...
'title = {Daily growth patterns of juveniles and adults of the Peruvian anchovy (Engraulis ringens) in northern Chile}, ' ...
'journal = {Marine and Freshwater Research}, ' ...
'volume = {67}, ' ...
'pages = {899--912}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'Mina1968'; type = 'Article'; bib = [ ...    
'author = {Minano, J.}, ' ...
'year  = {1968}, ' ...
'title = {Estudio de la fecundiadad y ciclo sexual de la anchoveta (Engraulis ringens. J.) en la zona de Chimbote}, ' ...
'journal = {Boletin del Instituto del Mar del Peru}, ' ...
'volume = {1}, ' ...
'pages = {505--552}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
