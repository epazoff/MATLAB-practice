function [pic,etac] = comp_map_11_11(mcwant, Ncwant)
%  The corrected mass flow is in kg/s

allmc = [
30.2469
31.3128
32.5126
33.5852
34.3936
35.0729
35.8861
36.039
36.3155
43.1132
45.3685
47.4964
49.0981
50.5725
52.0507
53.1375
53.8262
54.25
54.5378
57.4397
59.8241
61.5521
63.017
64.2168
65.8223
67.4287
68.7768
69.7268
70.4098
71.2335
72.1959
72.6205
72.2905
74.806
76.4001
77.8621
79.5939
80.7956
82.2672
83.4746
84.549
85.6282
86.7084
87.7923
88.749
89.4359
90.2662
90.8267
91.3825
87.309
91.279
93.0018
95.256
97.2477
98.9749
101.103
102.836
103.907
104.979
106.184
106.995
107.948
108.232
108.786
109.077];


allpic = [5.79198
5.43284
5.00173
4.38975
3.77725
3.05613
2.26303
1.46862
0.999566
8.63492
8.24201
7.66824
7.02118
6.19325
5.22084
4.06705
2.98471
1.93798
1.03547
11.1918
10.9075
10.4774
10.0107
9.57958
8.78804
7.96037
6.91546
5.94201
5.0764
3.88597
2.44294
1.36008
13.8941
13.6462
13.2881
12.9298
12.3552
11.8519
11.1323
10.4122
9.72801
8.86319
7.96224
6.91681
5.69051
4.68041
3.23713
2.01005
0.963575
16.3516
15.5968
15.1286
14.4439
13.6865
12.9649
11.9544
10.9071
9.96751
9.02794
7.97997
6.85909
5.19553
4.03777
2.48226
0.926403
    ];


allrpm = [4000
4000
4000
4000
4000
4000
4000
4000
4000
6000
6000
6000
6000
6000
6000
6000
6000
6000
6000
8000
8000
8000
8000
8000
8000
8000
8000
8000
8000
8000
8000
8000
10000
10000
10000
10000
10000
10000
10000
10000
10000
10000
10000
10000
10000
10000
10000
10000
10000
12000
12000
12000
12000
12000
12000
12000
12000
12000
12000
12000
12000
12000
12000
12000
12000];

allmc2 = [71.9067
74.1439
78.489
83.7547
90.471
98.636
106.409
108.78
111.158
111.17
109.348
107.784
104.777
101.507
97.973
94.1694
89.9743
85.7822
81.589
78.8379
74.3665
69.8921
65.5441
61.0583
56.8386
50.7683
44.8281
38.3597
31.4915
26.3407
23.0367
21.7096
22.2254
24.9813
27.4778
30.8938
60.4644
65.2009
69.4131
74.8146
81.1414
87.205
93.0055
95.1183
95.788
95.1468
93.454
90.9727
87.3049
83.1089
78.7799
73.6606
69.9756
64.0421
57.4436
51.2413
43.5874
36.4626
32.3711
31.0478
31.8267
34.3185
38.257
42.7228
46.9274
50.3425
55.7297
59.8213
62.1876
65.7434
70.0933
75.2393
78.6734
80.5277
80.6722
80.0272
78.7257
75.3211
70.7261
67.7033
64.4059
59.9192
54.5053
50.5411
48.1633
48.5443
50.637
53.2599
55.0914
58.1113
64.2178];

allpic2 = [13.4238
13.7172
14.1953
14.8198
15.5194
16.3663
17.0679
17.2894
17.2218
16.7883
15.7733
14.9755
13.8498
12.6513
11.4522
10.4694
9.30523
8.03266
6.79621
5.95996
5.26481
4.67803
4.30823
4.1549
3.92985
3.7734
3.68945
3.60445
3.66317
3.68914
3.791
4.04125
4.51186
5.16751
5.64203
6.29897
11.6673
12.3269
12.8409
13.3211
13.7671
14.1764
14.549
14.5532
14.1933
13.4696
12.5632
11.5107
10.3837
9.25558
8.16335
6.99733
6.52047
6.18367
6.02618
5.86946
5.67377
5.44299
5.36268
5.46845
5.9757
6.63083
7.50554
8.41742
9.22041
9.91348
10.9355
11.0158
11.4179
11.7861
12.0837
12.2383
12.2089
11.9958
11.5265
10.9473
10.2223
9.13186
8.11136
7.56356
7.41257
7.29536
7.28469
7.38525
7.41669
7.99541
8.75812
9.44962
10.1034
10.7596
9.54346];


alleff = [0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.82
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.84
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.86
0.88];

% get pic from mc2 and Nc2
pic = griddata(allmc, allrpm, allpic, mcwant, Ncwant);

% once pic is known find the efficiency that goes with it
etac = griddata(allmc2, allpic2, alleff, mcwant,pic);