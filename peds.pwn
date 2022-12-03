#include <a_samp>
#include <FCNPC>
#include <foreach>

#define function%0(%1) forward%0(%1); public%0(%1)

new money_pickup[MAX_PLAYERS] = {-1, ...};

enum npcInfo
{
	npc_Name[MAX_PLAYER_NAME],
	npc_Skin,
	Float:npc_TargetDist,
	Float:npc_X,
	Float:npc_Y,
	Float:npc_Z,
	Float:npc_A,
	weaponnpcid,
	npc_ID
}

new npc[][npcInfo] = {
	{"Pedestrian_alhambra_1", 2, 15.0, 1829.0376,-1724.2073,13.5469,172.9064,0},
	{"Pedestrian_alhambra_2", 7, 15.0, 1829.3373,-1744.0007,13.5469,358.4577,0},
	{"Pedestrian_major_1", 23, 15.0, 1420.8108,-1584.4639,13.5469,185.6047,0},
	{"Pedestrian_major_2", 41, 15.0, 1422.0692,-1740.3816,13.5469,283.3656,0},
	{"Pedestrian_major_3", 44, 15.0, 1537.3142,-1740.3983,13.5469,0.4464,0},
	{"Pedestrian_major_4", 43, 15.0, 1536.7340,-1585.5454,13.5469,2.9530,0},
	{"Pedestrian_major_5", 47, 15.0, 1483.6631,-1610.8466,14.0393,159.9345,0},
	{"Pedestrian_major_6", 55, 15.0, 1484.0264,-1676.6455,14.0469,189.0747,0},
	{"Pedestrian_alhambra_3", 56, 15.0, 1933.1835,-1619.9907,13.5391,266.7766,0},
	{"Pedestrian_alhambra_4", 190, 15.0, 1949.4403,-1743.0580,13.5469,180.6091,0},
	{"Pedestrian_prea_1", 85, 15.0, 1681.3740,-1585.8608,13.5469,179.0807,0},
	{"Pedestrian_prea_2", 79, 15.0, 1742.9073,-1591.5424,13.5439,174.3807,0},
	{"Pedestrian_prea_3", 122, 15.0, 1741.2233,-1739.0149,13.5469,176.8873,0},
	{"Pedestrian_prea_4", 136, 15.0, 1681.4899,-1740.0146,13.5590,358.9124,0},
    {"Pedestrian_pregl_1", 6, 15.0, 2079.9355,-1376.8184,23.9987,180.4605,0},
    {"Pedestrian_pregl_2", 7, 15.0, 2263.0144,-1376.9508,23.9823,82.7230,0},
    {"Pedestrian_pregl_3", 14, 15.0, 2264.0920,-1227.9930,23.9766,92.1793,0},
    {"Pedestrian_pregl_4", 15, 15.0, 2178.7988,-1257.8750,23.9778,268.9010,0},
    {"Pedestrian_pregl_5", 21, 15.0, 2079.7339,-1227.8716,23.9766,182.7101,0},
    {"Pedestrian_prgl2_1", 29, 15.0, 2334.7510,-1492.1539,24.0044,358.7075,0},
    {"Pedestrian_prgl2_2", 37, 15.0, 2422.3596,-1452.3146,24.0096,273.2952,0},
    {"Pedestrian_prgl2_3", 35, 15.0, 2383.5698,-1391.8702,24.0329,89.7036,0},
    {"Pedestrian_prgl2_4", 53, 15.0, 2438.3882,-1512.5706,23.9932,90.6436,0},
    {"Pedestrian_grove_1", 9, 15.0, 2254.3884,-1666.4169,15.4690,78.3300,0},
    {"Pedestrian_grove_2", 10, 15.0, 2350.9810,-1667.0916,13.5469,182.0210,0},
    {"Pedestrian_grove_3", 13, 15.0, 2371.8909,-1695.5531,13.4716,269.7552,0},
    {"Pedestrian_grove_4", 20, 15.0, 2406.4121,-1756.7699,13.5469,206.7745,0},
    {"Pedestrian_grove_5", 22, 15.0, 2253.0432,-1742.1621,13.5469,1.5393,0},
    {"Pedestrian_grove_6", 46, 15.0, 2226.8774,-1699.6871,13.7538,354.6459,0},
    {"Pedestrian_glenp_1", 51, 15.0, 1967.8705,-1301.6317,23.9837,266.1067,0},
    {"Pedestrian_glenp_2", 53, 15.0, 2058.9541,-1143.8591,23.8984,152.7023,0},
    {"Pedestrian_glenp_3", 61, 15.0, 2028.1210,-1165.5778,22.0727,110.0886,0},
    {"Pedestrian_glenp_4", 65, 15.0, 2005.2762,-1186.7554,20.0234,145.4956,0},
    {"Pedestrian_glenp_5", 69, 15.0, 1887.5042,-1268.4724,13.5469,271.2236,0},
    {"Pedestrian_glenp_6", 71, 15.0, 1859.7393,-1245.6707,14.2109,0.2111,0},
    {"Pedestrian_vinewood_1", 73, 15.0, 516.9893,-1212.2113,44.2202,287.1628,0},
    {"Pedestrian_vinewood_2", 75, 15.0, 386.7436,-1228.6584,52.5793,27.8996,0},
    {"Pedestrian_vinewood_3", 79, 15.0, 171.2327,-1391.3322,48.3281,39.2517,0},
    {"Pedestrian_vinewood_4", 94, 15.0, 225.2717,-1313.1869,55.9934,27.2747,0},
    {"Pedestrian_vinewood_5", 24, 15.0, 271.8044,-1245.2720,73.8353,312.2912,0},
    {"Pedestrian_vinewood_6", 27, 15.0, 371.2009,-1166.5931,78.2870,321.2719,0},
    {"Pedestrian_grovecluck_1", 133, 15.0, 2421.2151,-1885.8774,13.5469,181.0540,0},
    {"Pedestrian_grovecluck_2", 135, 15.0, 2368.0759,-1934.1711,13.5469,93.3972,0},
    {"Pedestrian_grovecluck_3", 137, 15.0, 2405.7456,-1980.4506,13.5469,114.2384,0},
    {"Pedestrian_grovecluck_4", 143, 15.0, 2305.5427,-1964.2297,13.5717,126.4375,0},
    {"Pedestrian_grovecluck_5", 148, 15.0, 2296.5037,-1901.9596,13.5850,92.5882,0},
    {"Pedestrian_grovecluck_6", 152, 15.0, 2207.7925,-1936.1647,13.5469,187.5511,0},
    {"Pedestrian_marina_1", 65, 15.0, 789.3992,-1629.3615,13.3828,268.8918,0},
    {"Pedestrian_marina_2", 67, 15.0, 739.3969,-1666.2673,10.6621,1.8986,0},
    {"Pedestrian_marina_3", 69, 15.0, 802.4042,-1762.0770,13.5469,348.1393,0},
    {"Pedestrian_marina_4", 84, 15.0, 745.4694,-1669.7550,4.1558,205.8780,0},
    {"Pedestrian_marina_5", 88, 15.0, 676.8501,-1719.4725,8.6992,223.8270,0},
    {"Pedestrian_marina_6", 93, 15.0, 642.4741,-1723.7279,14.0731,351.7580,0},
    {"Pedestrian_marina_7", 94, 15.0, 646.0323,-1593.7917,15.7191,269.2045,0},
    {"Pedestrian_marina_8", 95, 15.0, 746.5423,-1578.4102,14.1363,269.8621,0},
    {"Pedestrian_marina_9", 96, 15.0, 708.1379,-1436.0104,13.5391,194.4280,0},
    {"Pedestrian_marina_10", 122, 15.0,769.1869,-1542.2876,13.5469,164.5484,0},
    {"Pedestrian_cbeach_1", 45, 15.0,362.7839,-1861.5585,7.8359,1.8716,0},
    {"Pedestrian_cbeach_2", 92, 15.0,377.1489,-1946.6036,7.8359,188.5967,0},
    {"Pedestrian_cbeach_3", 97, 15.0,397.0294,-2013.8910,7.8359,88.3290,0},
    {"Pedestrian_cbeach_4", 140, 15.0,351.0923,-2084.8289,7.8301,191.1033,0},
    {"Pedestrian_rodeo_1", 147, 15.0,459.1479,-1571.6117,25.5411,87.1748,0},
    {"Pedestrian_rodeo_2", 148, 15.0,419.7747,-1550.5602,27.5781,44.2478,0},
    {"Pedestrian_rodeo_3", 150, 15.0,314.5111,-1592.4413,33.2109,126.6552,0},
    {"Pedestrian_rodeo_4", 161, 15.0,330.4363,-1524.4794,35.8400,338.4471,0},
    {"Pedestrian_rodeo_5", 170, 15.0,379.1410,-1518.1765,32.7312,226.8994,0},
    {"Pedestrian_rodeo_6", 179, 15.0,430.7235,-1448.7976,30.5781,311.1868,0},
    {"Pedestrian_hospitalls_1", 180, 15.0,1187.8456,-1287.5787,13.5541,209.0764,0},
    {"Pedestrian_hospitalls_2", 181, 15.0,1213.8900,-1345.2806,13.5721,181.8162,0},
    {"Pedestrian_hospitalls_3", 182, 15.0,1267.8092,-1412.3247,13.2833,267.9837,0},
    {"Pedestrian_hospitalls_4", 183, 15.0,1248.3098,-1328.2773,13.3883,274.2505,0},
    {"Pedestrian_trade_1", 184, 15.0,909.1410,-1386.5073,13.5534,92.4667,0},
    {"Pedestrian_trade_2", 185, 15.0,887.0135,-1359.7833,13.7978,87.7667,0},
    {"Pedestrian_trade_3", 186, 15.0,903.7175,-1311.9811,13.5469,12.2526,0},
    {"Pedestrian_trade_4", 187, 15.0,805.4054,-1335.0598,13.5469,215.9211,0},
    {"Pedestrian_trade_5", 188, 15.0,789.2946,-1387.2456,13.7266,324.0222,0},
    {"Pedestrian_losflor_1", 190, 15.0,2746.1653,-1264.9506,59.7481,266.6689,0},
    {"Pedestrian_losflor_2", 191, 15.0,2745.6904,-1250.5403,59.7188,273.5622,0},
    {"Pedestrian_losflor_3", 192, 15.0,2789.6636,-1377.8600,21.4144,206.4355,0},
    {"Pedestrian_losflor_4", 193, 15.0,2804.6382,-1377.7412,21.4075,278.2621,0},
    {"Pedestrian_westcoast_1", 195, 15.0,2938.4651,-1505.6382,11.0469,166.9939,0},
    {"Pedestrian_westcoast_2", 202, 15.0,2913.3296,-1568.9167,11.0469,164.4872,0},
    {"Pedestrian_westcoast_3", 206, 15.0,2885.0386,-1593.2607,21.5313,70.1730,0},
    {"Pedestrian_westcoast_4", 208, 15.0,2834.2161,-1586.3358,11.0938,255.9581,0},
    {"Pedestrian_westcoast_5", 210, 15.0,2875.9919,-1572.3213,11.0842,342.4389,0},
    {"Pedestrian_westcoast_6", 211, 15.0,2864.3899,-1496.8168,10.8984,346.5123,0},
    {"Pedestrian_willowf_1", 227, 15.0,2706.2236,-2041.4678,13.5469,178.7679,0},
    {"Pedestrian_willowf_2", 228, 15.0,2799.6125,-2032.4882,13.5547,270.5755,0},
    {"Pedestrian_willowf_3", 229, 15.0,2815.9983,-1969.7418,11.0940,89.8038,0},
    {"Pedestrian_willowf_4", 230, 15.0,2806.3455,-1905.4739,13.5469,272.4555,0},
    {"Pedestrian_willowf_5", 231, 15.0,2761.8633,-1943.8059,13.5469,91.0571,0},
    {"Pedestrian_willowf_6", 232, 15.0,2706.5620,-1944.0938,13.5469,178.7913,0},
    {"Pedestrian_willowf_7", 233, 15.0,2640.6594,-1996.4750,13.5547,93.9333,0},
    {"Pedestrian_centre_1", 234, 15.0,1030.5569,-948.1165,42.6050,271.6937,0},
    {"Pedestrian_centre_2", 235, 15.0,1094.4608,-964.7598,42.4138,269.1202,0},
    {"Pedestrian_centre_3", 236, 15.0,1151.7017,-935.7966,43.1463,274.0051,0},
    {"Pedestrian_centre_4", 237, 15.0,1318.2113,-913.9108,37.7404,268.4918,0},
    {"Pedestrian_centre_5", 238, 15.0,1359.7006,-924.3317,34.3759,260.6585,0},
    {"Pedestrian_centre_6", 239, 15.0,1032.2507,-973.1421,42.6125,278.1198,0},
    {"Pedestrian_centre_7", 241, 15.0,1286.7510,-939.8834,41.5986,96.1570,0}
};

new npc_coll_timer;
new npcmoneytimer;
public OnFilterScriptInit()
{
	SetTimer("spawnNPC",1500,0);
 	return 1;
}

public OnFilterScriptExit()
{
    for (new npcid = 0; npcid < sizeof(npc); npcid++) {
	FCNPC_Destroy(npc[npcid][npc_ID]), DeletePVar(npc[npcid][npc_ID],"alhambra"), DeletePVar(npc[npcid][npc_ID],"major"), DeletePVar(npc[npcid][npc_ID],"nearalhambra");
    DeletePVar(npc[npcid][npc_ID],"preglen"), DeletePVar(npc[npcid][npc_ID],"prgl2"), DeletePVar(npc[npcid][npc_ID],"grove"), DeletePVar(npc[npcid][npc_ID],"glenpark"), DeletePVar(npc[npcid][npc_ID],"vinewood");
    DeletePVar(npc[npcid][npc_ID],"grove_cluck"), DeletePVar(npc[npcid][npc_ID],"marina"), DeletePVar(npc[npcid][npc_ID],"circle_beach"), DeletePVar(npc[npcid][npc_ID],"rodeo"), DeletePVar(npc[npcid][npc_ID],"hospital_ls"), DeletePVar(npc[npcid][npc_ID],"check_coll");
    DeletePVar(npc[npcid][npc_ID],"current_target_x"), DeletePVar(npc[npcid][npc_ID],"current_target_y"), DeletePVar(npc[npcid][npc_ID],"current_target_z");
    DeletePVar(npc[npcid][npc_ID],"moneyinwallet"), DeletePVar(npc[npcid][npc_ID],"alive_npc"), DeletePVar(npc[npcid][npc_ID],"fighter"), DeletePVar(npc[npcid][npc_ID],"dropmoney");
    }
    KillTimer(npc_coll_timer);
    KillTimer(npcmoneytimer);
}

public FCNPC_OnReachDestination(npcid)
{
	if(GetPVarInt(npcid,"alhambra")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1829.9950,-1760.0022,13.5469))
	    {
	        switch(random(4))
	        {
	            case 0: FCNPC_GoTo(npcid,1812.9298,-1759.7233,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1812.9298), SetPVarFloat(npcid,"current_target_y", -1759.7233), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1829.7218,-1744.5909,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.7218), SetPVarFloat(npcid,"current_target_y", -1744.5909), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1904.1957,-1759.8704,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1904.1957), SetPVarFloat(npcid,"current_target_y", -1759.8704), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 3: FCNPC_GoTo(npcid,1933.4224,-1760.1542,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1933.4224), SetPVarFloat(npcid,"current_target_y", -1760.1542), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1904.2627,-1759.8518,13.5469))
	    {
	        switch(random(4))
	        {
	            case 0: FCNPC_GoTo(npcid,1904.2562,-1745.4161,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1904.2562), SetPVarFloat(npcid,"current_target_y", -1745.4161), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1933.3798,-1760.0865,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1933.3798), SetPVarFloat(npcid,"current_target_y", -1760.0865), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1829.8628,-1759.7537,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.8628), SetPVarFloat(npcid,"current_target_y", -1759.7537), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 3: FCNPC_GoTo(npcid,1812.9792,-1759.7826,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1812.9792), SetPVarFloat(npcid,"current_target_y", -1759.7826), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1933.4537,-1760.1401,13.5469))
	    {
	        switch(random(4))
	        {
	            case 0: FCNPC_GoTo(npcid,1933.4324,-1744.2166,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1933.4324), SetPVarFloat(npcid,"current_target_y", -1744.2166), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1904.3510,-1759.8057,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1904.3510), SetPVarFloat(npcid,"current_target_y", -1759.8057), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1829.9629,-1759.7933,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.9629), SetPVarFloat(npcid,"current_target_y", -1759.7933), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 3: FCNPC_GoTo(npcid,1813.5674,-1759.6136,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1813.5674), SetPVarFloat(npcid,"current_target_y", -1759.6136), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1813.0219,-1759.6382,13.5469))
	    {
	        switch(random(5))
	        {
	            case 0: FCNPC_GoTo(npcid,1830.0922,-1759.7162,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1830.0922), SetPVarFloat(npcid,"current_target_y", -1759.7162), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1813.2515,-1744.6459,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1813.2515), SetPVarFloat(npcid,"current_target_y", -1744.6459), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1813.6249,-1723.9733,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1813.6249), SetPVarFloat(npcid,"current_target_y", -1723.9733), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 3: FCNPC_GoTo(npcid,1814.0408,-1620.3715,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1814.0408), SetPVarFloat(npcid,"current_target_y", -1620.3715), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 4: FCNPC_GoTo(npcid,1814.1233,-1603.3546,13.5313,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1814.1233), SetPVarFloat(npcid,"current_target_y", -1603.3546), SetPVarFloat(npcid,"current_target_z", 13.5313);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1813.2826,-1744.6697,13.5469))
	    {
	        switch(random(3))
	        {
	            case 0: FCNPC_GoTo(npcid,1812.9712,-1759.7014,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1812.9712), SetPVarFloat(npcid,"current_target_y", -1759.7014), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1813.5978,-1723.9745,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1813.5978), SetPVarFloat(npcid,"current_target_y", -1723.9745), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1829.6292,-1744.5846,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.6292), SetPVarFloat(npcid,"current_target_y", -1744.5846), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1813.6108,-1724.0106,13.5469))
	    {
	        switch(random(3))
	        {
	            case 0: FCNPC_GoTo(npcid,1813.2799,-1744.5896,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1813.2799), SetPVarFloat(npcid,"current_target_y", -1744.5896), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1828.7970,-1723.6626,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1828.7970), SetPVarFloat(npcid,"current_target_y", -1723.6626), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1814.0504,-1620.3835,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1814.0504), SetPVarFloat(npcid,"current_target_y", -1620.3835), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1814.0054,-1620.4043,13.5469))
	    {
	        switch(random(3))
	        {
	            case 0: FCNPC_GoTo(npcid,1814.1333,-1603.5050,13.5313,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1814.1333), SetPVarFloat(npcid,"current_target_y", -1603.5050), SetPVarFloat(npcid,"current_target_z", 13.5313);
	            case 1: FCNPC_GoTo(npcid,1829.7209,-1620.1632,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.7209), SetPVarFloat(npcid,"current_target_y", -1620.1632), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1813.6238,-1723.9640,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1813.6238), SetPVarFloat(npcid,"current_target_y", -1723.9640), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1814.2013,-1603.3708,13.5313))
	    {
	        switch(random(2))
	        {
	            case 0: FCNPC_GoTo(npcid,1829.7108,-1604.1376,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.7108), SetPVarFloat(npcid,"current_target_y", -1604.1376), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1813.9475,-1620.3829,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1813.9475), SetPVarFloat(npcid,"current_target_y", -1620.3829), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1829.7578,-1744.6980,13.5469))
	    {
	        switch(random(4))
	        {
	            case 0: FCNPC_GoTo(npcid,1829.7875,-1760.1333,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.7875), SetPVarFloat(npcid,"current_target_y", -1760.1333), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1813.5435,-1744.3984,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1813.5435), SetPVarFloat(npcid,"current_target_y", -1744.3984), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1829.1156,-1724.5345,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.1156), SetPVarFloat(npcid,"current_target_y", -1724.5345), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 3: FCNPC_GoTo(npcid,1904.5465,-1745.4180,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1904.5465), SetPVarFloat(npcid,"current_target_y", -1745.4180), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1829.1400,-1724.5438,13.5469))
	    {
	        switch(random(3))
	        {
	            case 0: FCNPC_GoTo(npcid,1813.5459,-1724.3369,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1813.5459), SetPVarFloat(npcid,"current_target_y", -1724.3369), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1829.7263,-1744.6223,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.7263), SetPVarFloat(npcid,"current_target_y", -1744.6223), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1829.6129,-1620.2985,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.6129), SetPVarFloat(npcid,"current_target_y", -1620.2985), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1829.6129,-1620.2985,13.5469))
	    {
	        switch(random(4))
	        {
	            case 0: FCNPC_GoTo(npcid,1829.7601,-1604.0880,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.7601), SetPVarFloat(npcid,"current_target_y", -1604.0880), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1814.0649,-1620.3401,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1814.0649), SetPVarFloat(npcid,"current_target_y", -1620.3401), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1829.1632,-1724.5475,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.1632), SetPVarFloat(npcid,"current_target_y", -1724.5475), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 3: FCNPC_GoTo(npcid,1933.8080,-1620.1312,13.5391,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1933.8080), SetPVarFloat(npcid,"current_target_y", -1620.1312), SetPVarFloat(npcid,"current_target_z", 13.5391);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1829.7297,-1604.1720,13.5469))
	    {
	        switch(random(3))
	        {
	            case 0: FCNPC_GoTo(npcid,1813.9928,-1603.6653,13.5313,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1813.9928), SetPVarFloat(npcid,"current_target_y", -1603.6653), SetPVarFloat(npcid,"current_target_z", 13.5313);
	            case 1: FCNPC_GoTo(npcid,1829.6108,-1620.3927,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.6108), SetPVarFloat(npcid,"current_target_y", -1620.3927), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1934.4374,-1605.0013,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1934.4374), SetPVarFloat(npcid,"current_target_y", -1605.0013), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1934.4440,-1605.5062,13.5469))
	    {
	        switch(random(3))
	        {
	            case 0: FCNPC_GoTo(npcid,1829.7391,-1604.1361,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.7391), SetPVarFloat(npcid,"current_target_y", -1604.1361), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1934.1086,-1620.8339,13.5391,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1934.1086), SetPVarFloat(npcid,"current_target_y", -1620.8339), SetPVarFloat(npcid,"current_target_z", 13.5391);
	            case 2: FCNPC_GoTo(npcid,1945.9237,-1610.9242,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1945.9237), SetPVarFloat(npcid,"current_target_y", -1610.9242), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1945.9771,-1610.6907,13.5469))
	    {
	        switch(random(2))
	        {
	            case 0: FCNPC_GoTo(npcid,1934.2826,-1605.4961,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1934.2826), SetPVarFloat(npcid,"current_target_y", -1605.4961), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1949.1768,-1620.5823,13.5332,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1949.1768), SetPVarFloat(npcid,"current_target_y", -1620.5823), SetPVarFloat(npcid,"current_target_z", 13.5332);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1949.1782,-1620.6169,13.5334))
	    {
	        switch(random(3))
	        {
	            case 0: FCNPC_GoTo(npcid,1945.9944,-1610.6294,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1945.9944), SetPVarFloat(npcid,"current_target_y", -1610.6294), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1934.1774,-1620.9276,13.5391,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1934.1774), SetPVarFloat(npcid,"current_target_y", -1620.9276), SetPVarFloat(npcid,"current_target_z", 13.5391);
	            case 2: FCNPC_GoTo(npcid,1949.4645,-1744.1210,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1949.4645), SetPVarFloat(npcid,"current_target_y", -1744.1210), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1949.4037,-1744.1741,13.5469)) 
	    {
	        switch(random(2))
	        {
	            case 0: FCNPC_GoTo(npcid,1949.2632,-1620.5702,13.5332,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1949.2632), SetPVarFloat(npcid,"current_target_y", -1620.5702), SetPVarFloat(npcid,"current_target_z", 13.5332);
	            case 1: FCNPC_GoTo(npcid,1933.6672,-1743.9524,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1933.6672), SetPVarFloat(npcid,"current_target_y", -1743.9524), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1934.0004,-1620.7505,13.5391)) 
	    {
	        switch(random(4))
	        {
	            case 0: FCNPC_GoTo(npcid,1949.1897,-1620.4839,13.5328,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1949.1897), SetPVarFloat(npcid,"current_target_y", -1620.4839), SetPVarFloat(npcid,"current_target_z", 13.5328);
	            case 1: FCNPC_GoTo(npcid,1829.7781,-1620.2943,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.7781), SetPVarFloat(npcid,"current_target_y", -1620.2943), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1933.7511,-1743.9061,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1933.7511), SetPVarFloat(npcid,"current_target_y", -1743.9061), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 3: FCNPC_GoTo(npcid,1933.6779,-1759.9141,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1933.6779), SetPVarFloat(npcid,"current_target_y", -1759.9141), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1933.6038,-1743.8064,13.5469)) 
	    {
	        switch(random(2))
	        {
	            case 0: FCNPC_GoTo(npcid,1934.0421,-1620.8523,13.5391,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1934.0421), SetPVarFloat(npcid,"current_target_y", -1620.8523), SetPVarFloat(npcid,"current_target_z", 13.5391);
	            case 1: FCNPC_GoTo(npcid,1933.5667,-1760.0735,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1933.5667), SetPVarFloat(npcid,"current_target_y", -1760.0735), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1904.6311,-1745.5001,13.5469)) 
	    {
	        switch(random(3))
	        {
	            case 0: FCNPC_GoTo(npcid,1904.6436,-1759.9642,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1904.6436), SetPVarFloat(npcid,"current_target_y", -1759.9642), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 1: FCNPC_GoTo(npcid,1933.8308,-1744.2821,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1933.8308), SetPVarFloat(npcid,"current_target_y", -1744.2821), SetPVarFloat(npcid,"current_target_z", 13.5469);
	            case 2: FCNPC_GoTo(npcid,1829.6294,-1744.6154,13.5469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1829.6294), SetPVarFloat(npcid,"current_target_y", -1744.6154), SetPVarFloat(npcid,"current_target_z", 13.5469);
	        }
	    }
	}
	if(GetPVarInt(npcid,"major")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1536.7402,-1585.3601,13.5469))
	    {
	        switch(random(3))
	        {
	            case 0: FCNPC_GoTo(npcid,1536.730834,-1600.944213,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.730834), SetPVarFloat(npcid,"current_target_y", -1600.944213), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1521.281494,-1585.495483,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1521.281494), SetPVarFloat(npcid,"current_target_y", -1585.495483), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1520.657226,-1601.409301,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.657226), SetPVarFloat(npcid,"current_target_y", -1601.409301), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1536.7900,-1600.8998,13.5469))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1536.671020,-1585.409667,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.671020), SetPVarFloat(npcid,"current_target_y", -1585.409667), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1520.695800,-1601.460083,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.695800), SetPVarFloat(npcid,"current_target_y", -1601.460083), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1537.001586,-1619.265136,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1537.001586), SetPVarFloat(npcid,"current_target_y", -1619.265136), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1537.0015,-1619.2653,13.5469)) 
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1536.702026,-1601.019775,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.702026), SetPVarFloat(npcid,"current_target_y", -1601.019775), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1536.882446,-1636.851074,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.882446), SetPVarFloat(npcid,"current_target_y", -1636.851074), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1520.526855,-1619.054565,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.526855), SetPVarFloat(npcid,"current_target_y", -1619.054565), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1536.9164,-1636.8296,13.5469))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1537.025146,-1619.179443,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1537.025146), SetPVarFloat(npcid,"current_target_y", -1619.179443), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1520.408081,-1636.501220,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.408081), SetPVarFloat(npcid,"current_target_y", -1636.501220), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1536.582885,-1659.612792,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.582885), SetPVarFloat(npcid,"current_target_y", -1659.612792), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1536.5908,-1659.7997,13.5469))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1540.832275,-1665.934204,13.551464,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1540.832275), SetPVarFloat(npcid,"current_target_y", -1665.934204), SetPVarFloat(npcid,"current_target_z", 13.551464);
				case 1: FCNPC_GoTo(npcid,1520.522949,-1659.478393,13.539275,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.522949), SetPVarFloat(npcid,"current_target_y", -1659.478393), SetPVarFloat(npcid,"current_target_z", 13.539275);
				case 2: FCNPC_GoTo(npcid,1536.922119,-1636.823852,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.922119), SetPVarFloat(npcid,"current_target_y", -1636.823852), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1540.8533,-1665.9707,13.5514)) //6
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1536.686401,-1659.840454,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.686401), SetPVarFloat(npcid,"current_target_y", -1659.840454), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1540.912597,-1683.835693,13.551621,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1540.912597), SetPVarFloat(npcid,"current_target_y", -1683.835693), SetPVarFloat(npcid,"current_target_z", 13.551621);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1540.8651,-1683.9843,13.5514)) //7
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1540.892211,-1666.088134,13.551581,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1540.892211), SetPVarFloat(npcid,"current_target_y", -1666.088134), SetPVarFloat(npcid,"current_target_z", 13.551581);
				case 1: FCNPC_GoTo(npcid,1536.425537,-1684.239257,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.425537), SetPVarFloat(npcid,"current_target_y", -1684.239257), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1536.2059,-1684.2755,13.5469)) //8
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1540.835571,-1683.987304,13.551470,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1540.835571), SetPVarFloat(npcid,"current_target_y", -1683.987304), SetPVarFloat(npcid,"current_target_z", 13.551470);
				case 1: FCNPC_GoTo(npcid,1520.422729,-1683.949951,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.422729), SetPVarFloat(npcid,"current_target_y", -1683.949951), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1536.136108,-1697.907958,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.136108), SetPVarFloat(npcid,"current_target_y", -1697.907958), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1536.1296,-1697.9672,13.5469)) //9
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1536.201416,-1684.349731,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.201416), SetPVarFloat(npcid,"current_target_y", -1684.349731), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1520.507690,-1698.138671,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.507690), SetPVarFloat(npcid,"current_target_y", -1698.138671), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1537.392089,-1723.015869,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1537.392089), SetPVarFloat(npcid,"current_target_y", -1723.015869), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1537.3921,-1723.0159,13.5469)) //10
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1537.382324,-1740.505859,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1537.382324), SetPVarFloat(npcid,"current_target_y", -1740.505859), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1520.735595,-1724.559936,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.735595), SetPVarFloat(npcid,"current_target_y", -1724.559936), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1536.354125,-1697.900390,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.354125), SetPVarFloat(npcid,"current_target_y", -1697.900390), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1537.3726,-1740.3951,13.5469)) //11
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1537.224487,-1723.223144,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1537.224487), SetPVarFloat(npcid,"current_target_y", -1723.223144), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1519.790405,-1740.732910,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1519.790405), SetPVarFloat(npcid,"current_target_y", -1740.732910), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1521.0371,-1585.2615,13.5469)) //2 ряд 1
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1520.645019,-1601.442504,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.645019), SetPVarFloat(npcid,"current_target_y", -1601.442504), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1483.260375,-1584.563354,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.260375), SetPVarFloat(npcid,"current_target_y", -1584.563354), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1438.316650,-1584.601318,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1438.316650), SetPVarFloat(npcid,"current_target_y", -1584.601318), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1520.6167,-1601.4443,13.5469)) //2 ряд 2
	    {
	        switch(random(5))
	        {
				case 0: FCNPC_GoTo(npcid,1536.976318,-1601.181396,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.976318), SetPVarFloat(npcid,"current_target_y", -1601.181396), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1521.113647,-1585.386596,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1521.113647), SetPVarFloat(npcid,"current_target_y", -1585.386596), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1483.519775,-1600.395263,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.519775), SetPVarFloat(npcid,"current_target_y", -1600.395263), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1472.824096,-1599.748413,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1472.824096), SetPVarFloat(npcid,"current_target_y", -1599.748413), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 4: FCNPC_GoTo(npcid,1520.483764,-1618.971313,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.483764), SetPVarFloat(npcid,"current_target_y", -1618.971313), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1520.4836,-1618.9714,13.5469)) //2 ряд 3
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1515.928710,-1619.023193,14.096975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1515.928710), SetPVarFloat(npcid,"current_target_y", -1619.023193), SetPVarFloat(npcid,"current_target_z", 14.096975);
				case 1: FCNPC_GoTo(npcid,1520.630737,-1601.547851,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.630737), SetPVarFloat(npcid,"current_target_y", -1601.547851), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1536.967773,-1619.200561,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.967773), SetPVarFloat(npcid,"current_target_y", -1619.200561), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1520.381835,-1636.616943,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.381835), SetPVarFloat(npcid,"current_target_y", -1636.616943), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1520.3463,-1636.4451,13.5469)) //2 ряд 4
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1520.533813,-1618.999145,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.533813), SetPVarFloat(npcid,"current_target_y", -1618.999145), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1516.073730,-1636.491699,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1516.073730), SetPVarFloat(npcid,"current_target_y", -1636.491699), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1536.840576,-1636.874877,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.840576), SetPVarFloat(npcid,"current_target_y", -1636.874877), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1520.516967,-1659.589233,13.539275,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.516967), SetPVarFloat(npcid,"current_target_y", -1659.589233), SetPVarFloat(npcid,"current_target_z", 13.539275);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1520.4255,-1659.4099,13.5392)) //2 ряд 5
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1520.358764,-1636.535034,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.358764), SetPVarFloat(npcid,"current_target_y", -1636.535034), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1536.541259,-1659.701904,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.541259), SetPVarFloat(npcid,"current_target_y", -1659.701904), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1520.476806,-1683.854370,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.476806), SetPVarFloat(npcid,"current_target_y", -1683.854370), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1520.5333,-1683.8278,13.5469)) //2 ряд 6
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1520.474853,-1659.622802,13.539275,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.474853), SetPVarFloat(npcid,"current_target_y", -1659.622802), SetPVarFloat(npcid,"current_target_z", 13.539275);
				case 1: FCNPC_GoTo(npcid,1536.167236,-1684.200073,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.167236), SetPVarFloat(npcid,"current_target_y", -1684.200073), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1520.528198,-1698.186523,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.528198), SetPVarFloat(npcid,"current_target_y", -1698.186523), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1520.5099,-1698.0770,13.5469)) //2 ряд 7
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1520.484863,-1683.908203,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.484863), SetPVarFloat(npcid,"current_target_y", -1683.908203), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1536.189208,-1698.002197,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.189208), SetPVarFloat(npcid,"current_target_y", -1698.002197), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1515.860961,-1698.280273,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1515.860961), SetPVarFloat(npcid,"current_target_y", -1698.280273), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 3: FCNPC_GoTo(npcid,1520.484741,-1724.444335,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.484741), SetPVarFloat(npcid,"current_target_y", -1724.444335), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1520.4303,-1724.5988,13.54699)) //2 ряд 8
	    {
	        switch(random(5))
	        {
				case 0: FCNPC_GoTo(npcid,1520.472412,-1698.148315,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.472412), SetPVarFloat(npcid,"current_target_y", -1698.148315), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1537.321777,-1723.095703,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1537.321777), SetPVarFloat(npcid,"current_target_y", -1723.095703), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1519.960205,-1740.631591,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1519.960205), SetPVarFloat(npcid,"current_target_y", -1740.631591), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1514.060180,-1725.056030,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1514.060180), SetPVarFloat(npcid,"current_target_y", -1725.056030), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 4: FCNPC_GoTo(npcid,1450.120849,-1724.681030,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.120849), SetPVarFloat(npcid,"current_target_y", -1724.681030), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1519.7341,-1740.7266,13.5469)) //2 ряд 9
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1520.543823,-1724.448608,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.543823), SetPVarFloat(npcid,"current_target_y", -1724.448608), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1537.519287,-1740.452148,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1537.519287), SetPVarFloat(npcid,"current_target_y", -1740.452148), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1483.688476,-1740.362548,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.688476), SetPVarFloat(npcid,"current_target_y", -1740.362548), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1515.8267,-1618.9891,14.0469)) //3 ряд 1
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1520.380981,-1618.954223,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.380981), SetPVarFloat(npcid,"current_target_y", -1618.954223), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1511.172119,-1611.144653,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1511.172119), SetPVarFloat(npcid,"current_target_y", -1611.144653), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1510.994873,-1636.816528,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1510.994873), SetPVarFloat(npcid,"current_target_y", -1636.816528), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1515.9524,-1636.4836,14.0469)) //3 ряд 2
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1520.268310,-1636.499023,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.268310), SetPVarFloat(npcid,"current_target_y", -1636.499023), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1511.049682,-1636.754882,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1511.049682), SetPVarFloat(npcid,"current_target_y", -1636.754882), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1511.183105,-1611.173095,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1511.183105), SetPVarFloat(npcid,"current_target_y", -1611.173095), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1513.4982,-1698.2570,14.0469)) //3 ряд 3
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1520.399291,-1698.107910,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.399291), SetPVarFloat(npcid,"current_target_y", -1698.107910), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1504.973388,-1678.406372,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1504.973388), SetPVarFloat(npcid,"current_target_y", -1678.406372), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1513.668090,-1718.046142,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1513.668090), SetPVarFloat(npcid,"current_target_y", -1718.046142), SetPVarFloat(npcid,"current_target_z", 14.046975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1513.6190,-1718.1251,14.0469)) //3 ряд 4
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1513.918090,-1725.063964,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1513.918090), SetPVarFloat(npcid,"current_target_y", -1725.063964), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1513.519531,-1698.143798,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1513.519531), SetPVarFloat(npcid,"current_target_y", -1698.143798), SetPVarFloat(npcid,"current_target_z", 14.046975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1513.8353,-1725.1051,13.5469)) //3 ряд 5
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1513.604370,-1718.102294,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1513.604370), SetPVarFloat(npcid,"current_target_y", -1718.102294), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1520.504394,-1724.492309,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.504394), SetPVarFloat(npcid,"current_target_y", -1724.492309), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1483.169799,-1724.743041,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.169799), SetPVarFloat(npcid,"current_target_y", -1724.743041), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1511.1904,-1611.1426,14.0469)) //4 ряд 1
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1510.944091,-1636.737670,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1510.944091), SetPVarFloat(npcid,"current_target_y", -1636.737670), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1483.547973,-1610.950073,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.547973), SetPVarFloat(npcid,"current_target_y", -1610.950073), SetPVarFloat(npcid,"current_target_z", 14.039397);
				case 2: FCNPC_GoTo(npcid,1473.062011,-1610.984008,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.062011), SetPVarFloat(npcid,"current_target_y", -1610.984008), SetPVarFloat(npcid,"current_target_z", 14.039397);
				case 3: FCNPC_GoTo(npcid,1515.698852,-1618.935546,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1515.698852), SetPVarFloat(npcid,"current_target_y", -1618.935546), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1510.9423,-1636.7065,14.0469)) //4 ряд 2
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1515.790039,-1636.509033,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1515.790039), SetPVarFloat(npcid,"current_target_y", -1636.509033), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1500.295654,-1636.677124,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1500.295654), SetPVarFloat(npcid,"current_target_y", -1636.677124), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1511.066406,-1611.252075,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1511.066406), SetPVarFloat(npcid,"current_target_y", -1611.252075), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1504.8676,-1678.4386,14.0469)) //4 ряд 3
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1513.473999,-1698.231933,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1513.473999), SetPVarFloat(npcid,"current_target_y", -1698.231933), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1500.752929,-1676.853149,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1500.752929), SetPVarFloat(npcid,"current_target_y", -1676.853149), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1500.3134,-1636.6356,14.0469)) //5 ряд 1
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1510.892089,-1636.789306,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1510.892089), SetPVarFloat(npcid,"current_target_y", -1636.789306), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1493.184082,-1631.276855,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1493.184082), SetPVarFloat(npcid,"current_target_y", -1631.276855), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1500.161254,-1656.126220,14.035796,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1500.161254), SetPVarFloat(npcid,"current_target_y", -1656.126220), SetPVarFloat(npcid,"current_target_z", 14.035796);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1500.2411,-1656.0759,14.0350)) //5 ряд 2
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1500.288696,-1636.638305,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1500.288696), SetPVarFloat(npcid,"current_target_y", -1636.638305), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1500.586059,-1676.867431,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1500.586059), SetPVarFloat(npcid,"current_target_y", -1676.867431), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1459.809570,-1656.452880,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.809570), SetPVarFloat(npcid,"current_target_y", -1656.452880), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1500.6399,-1676.9264,14.0469)) //5 ряд 3
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1500.205200,-1656.068969,14.035387,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1500.205200), SetPVarFloat(npcid,"current_target_y", -1656.068969), SetPVarFloat(npcid,"current_target_z", 14.035387);
				case 1: FCNPC_GoTo(npcid,1504.820556,-1678.459106,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1504.820556), SetPVarFloat(npcid,"current_target_y", -1678.459106), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1474.573486,-1676.614746,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1474.573486), SetPVarFloat(npcid,"current_target_y", -1676.614746), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 3: FCNPC_GoTo(npcid,1459.302124,-1676.408935,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.302124), SetPVarFloat(npcid,"current_target_y", -1676.408935), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1493.0551,-1631.2461,14.0469)) //6 ряд 1
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1500.221191,-1636.666748,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1500.221191), SetPVarFloat(npcid,"current_target_y", -1636.666748), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1483.706665,-1610.945800,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.706665), SetPVarFloat(npcid,"current_target_y", -1610.945800), SetPVarFloat(npcid,"current_target_z", 14.039397);
				case 2: FCNPC_GoTo(npcid,1472.919555,-1611.033447,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1472.919555), SetPVarFloat(npcid,"current_target_y", -1611.033447), SetPVarFloat(npcid,"current_target_z", 14.039397);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1483.2065,-1584.8250,13.5469)) //7 ряд 1
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1520.979614,-1585.143920,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.979614), SetPVarFloat(npcid,"current_target_y", -1585.143920), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1438.499267,-1584.655761,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1438.499267), SetPVarFloat(npcid,"current_target_y", -1584.655761), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1420.918457,-1584.561279,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1420.918457), SetPVarFloat(npcid,"current_target_y", -1584.561279), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1483.474609,-1600.219726,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.474609), SetPVarFloat(npcid,"current_target_y", -1600.219726), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1483.4243,-1600.5259,13.5469)) //7 ряд 2
	    {
	        switch(random(5))
	        {
				case 0: FCNPC_GoTo(npcid,1483.246337,-1584.914672,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.246337), SetPVarFloat(npcid,"current_target_y", -1584.914672), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1520.772705,-1601.467773,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.772705), SetPVarFloat(npcid,"current_target_y", -1601.467773), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1483.545654,-1606.319824,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.545654), SetPVarFloat(npcid,"current_target_y", -1606.319824), SetPVarFloat(npcid,"current_target_z", 14.039397);
				case 3: FCNPC_GoTo(npcid,1438.426513,-1599.567382,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1438.426513), SetPVarFloat(npcid,"current_target_y", -1599.567382), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 4: FCNPC_GoTo(npcid,1421.232666,-1600.383911,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.232666), SetPVarFloat(npcid,"current_target_y", -1600.383911), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1483.5261,-1606.2596,14.0393)) //7 ряд 3
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1483.429077,-1600.412475,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.429077), SetPVarFloat(npcid,"current_target_y", -1600.412475), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1483.589599,-1610.865112,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.589599), SetPVarFloat(npcid,"current_target_y", -1610.865112), SetPVarFloat(npcid,"current_target_z", 14.039397);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1483.5591,-1610.8674,14.0393)) //7 ряд 4
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1483.475219,-1606.579345,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.475219), SetPVarFloat(npcid,"current_target_y", -1606.579345), SetPVarFloat(npcid,"current_target_z", 14.039397);
				case 1: FCNPC_GoTo(npcid,1473.033447,-1610.987670,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.033447), SetPVarFloat(npcid,"current_target_y", -1610.987670), SetPVarFloat(npcid,"current_target_z", 14.039397);
				case 2: FCNPC_GoTo(npcid,1492.922973,-1631.035888,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1492.922973), SetPVarFloat(npcid,"current_target_y", -1631.035888), SetPVarFloat(npcid,"current_target_z", 14.046975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1483.9775,-1676.4338,14.0469)) //7 ряд 5
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1474.721313,-1676.634155,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1474.721313), SetPVarFloat(npcid,"current_target_y", -1676.634155), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1459.314697,-1676.380004,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.314697), SetPVarFloat(npcid,"current_target_y", -1676.380004), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1500.579956,-1676.893920,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1500.579956), SetPVarFloat(npcid,"current_target_y", -1676.893920), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 3: FCNPC_GoTo(npcid,1484.518310,-1686.797851,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1484.518310), SetPVarFloat(npcid,"current_target_y", -1686.797851), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1484.4940,-1686.8193,14.0469)) //7 ряд 6
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1484.079711,-1676.467407,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1484.079711), SetPVarFloat(npcid,"current_target_y", -1676.467407), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1484.939697,-1697.463623,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1484.939697), SetPVarFloat(npcid,"current_target_y", -1697.463623), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1472.256347,-1686.758056,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1472.256347), SetPVarFloat(npcid,"current_target_y", -1686.758056), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1484.7887,-1697.2269,14.0469)) //7 ряд 7
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1484.534667,-1686.875000,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1484.534667), SetPVarFloat(npcid,"current_target_y", -1686.875000), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1473.092895,-1697.344238,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.092895), SetPVarFloat(npcid,"current_target_y", -1697.344238), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1483.640991,-1707.653320,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.640991), SetPVarFloat(npcid,"current_target_y", -1707.653320), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1483.6088,-1707.7974,14.0469)) //7 ряд 8
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1484.900390,-1697.376464,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1484.900390), SetPVarFloat(npcid,"current_target_y", -1697.376464), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1483.289794,-1718.065429,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.289794), SetPVarFloat(npcid,"current_target_y", -1718.065429), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1473.041381,-1707.410766,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.041381), SetPVarFloat(npcid,"current_target_y", -1707.410766), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1483.2424,-1717.9690,14.0469)) //7 ряд 9
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1483.602783,-1707.656982,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.602783), SetPVarFloat(npcid,"current_target_y", -1707.656982), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1483.269531,-1724.514404,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.269531), SetPVarFloat(npcid,"current_target_y", -1724.514404), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1450.254028,-1717.658081,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.254028), SetPVarFloat(npcid,"current_target_y", -1717.658081), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 3: FCNPC_GoTo(npcid,1513.526611,-1718.113769,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1513.526611), SetPVarFloat(npcid,"current_target_y", -1718.113769), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1483.2479,-1724.6576,13.5469)) //7 ряд 10
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1483.192260,-1718.066406,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.192260), SetPVarFloat(npcid,"current_target_y", -1718.066406), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1483.629150,-1740.482666,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.629150), SetPVarFloat(npcid,"current_target_y", -1740.482666), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1520.469604,-1724.468139,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.469604), SetPVarFloat(npcid,"current_target_y", -1724.468139), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1437.771362,-1725.034912,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.771362), SetPVarFloat(npcid,"current_target_y", -1725.034912), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1483.5914,-1740.4105,13.5469)) //7 ряд 11
	    {
	        switch(random(5))
	        {
				case 0: FCNPC_GoTo(npcid,1483.177246,-1724.865112,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.177246), SetPVarFloat(npcid,"current_target_y", -1724.865112), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1473.548461,-1740.845092,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.548461), SetPVarFloat(npcid,"current_target_y", -1740.845092), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1437.660034,-1740.661132,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.660034), SetPVarFloat(npcid,"current_target_y", -1740.661132), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1422.073120,-1740.372436,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1422.073120), SetPVarFloat(npcid,"current_target_y", -1740.372436), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 4: FCNPC_GoTo(npcid,1537.483276,-1740.565429,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1537.483276), SetPVarFloat(npcid,"current_target_y", -1740.565429), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1472.5687,-1599.5836,13.5469)) //8 ряд 1
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1483.320922,-1600.389160,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.320922), SetPVarFloat(npcid,"current_target_y", -1600.389160), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1472.715087,-1606.101684,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1472.715087), SetPVarFloat(npcid,"current_target_y", -1606.101684), SetPVarFloat(npcid,"current_target_z", 14.039397);
				case 2: FCNPC_GoTo(npcid,1438.288208,-1599.525512,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1438.288208), SetPVarFloat(npcid,"current_target_y", -1599.525512), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1421.359130,-1600.346923,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.359130), SetPVarFloat(npcid,"current_target_y", -1600.346923), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1472.7985,-1606.0598,14.0393)) //8 ряд 2
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1472.575683,-1599.714355,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1472.575683), SetPVarFloat(npcid,"current_target_y", -1599.714355), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1472.969604,-1610.796264,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1472.969604), SetPVarFloat(npcid,"current_target_y", -1610.796264), SetPVarFloat(npcid,"current_target_z", 14.039397);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1472.9033,-1611.0375,14.0393)) //8 ряд 3
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1472.769653,-1606.130615,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1472.769653), SetPVarFloat(npcid,"current_target_y", -1606.130615), SetPVarFloat(npcid,"current_target_z", 14.039397);
				case 1: FCNPC_GoTo(npcid,1465.544921,-1627.197631,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1465.544921), SetPVarFloat(npcid,"current_target_y", -1627.197631), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1474.5485,-1676.6799,14.0469)) //8 ряд 4
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1500.629882,-1676.883789,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1500.629882), SetPVarFloat(npcid,"current_target_y", -1676.883789), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1483.891235,-1676.500000,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.891235), SetPVarFloat(npcid,"current_target_y", -1676.500000), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1459.264526,-1676.431152,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.264526), SetPVarFloat(npcid,"current_target_y", -1676.431152), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1472.4091,-1686.7970,14.0469)) //8 ряд 5
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1474.523925,-1676.511230,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1474.523925), SetPVarFloat(npcid,"current_target_y", -1676.511230), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1484.578735,-1686.857788,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1484.578735), SetPVarFloat(npcid,"current_target_y", -1686.857788), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1473.028808,-1697.486083,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.028808), SetPVarFloat(npcid,"current_target_y", -1697.486083), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1472.9794,-1697.3302,14.0469)) //8 ряд 6
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1472.277709,-1686.827270,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1472.277709), SetPVarFloat(npcid,"current_target_y", -1686.827270), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1484.739624,-1697.392700,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1484.739624), SetPVarFloat(npcid,"current_target_y", -1697.392700), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1473.004150,-1707.471801,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.004150), SetPVarFloat(npcid,"current_target_y", -1707.471801), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1473.0848,-1707.1176,14.0469)) //8 ряд 7
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1473.015258,-1697.330078,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.015258), SetPVarFloat(npcid,"current_target_y", -1697.330078), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1483.520385,-1707.741210,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.520385), SetPVarFloat(npcid,"current_target_y", -1707.741210), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1473.519531,-1717.945190,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.519531), SetPVarFloat(npcid,"current_target_y", -1717.945190), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1473.4675,-1717.8334,14.0469)) //8 ряд 8
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1473.022949,-1707.225463,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.022949), SetPVarFloat(npcid,"current_target_y", -1707.225463), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1473.720947,-1724.463745,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.720947), SetPVarFloat(npcid,"current_target_y", -1724.463745), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1450.241577,-1717.628051,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.241577), SetPVarFloat(npcid,"current_target_y", -1717.628051), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 3: FCNPC_GoTo(npcid,1513.578247,-1718.068115,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1513.578247), SetPVarFloat(npcid,"current_target_y", -1718.068115), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1473.7354,-1724.5647,13.5469)) //8 ряд 9
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1473.488891,-1718.076293,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.488891), SetPVarFloat(npcid,"current_target_y", -1718.076293), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1473.439941,-1740.871704,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.439941), SetPVarFloat(npcid,"current_target_y", -1740.871704), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1513.926757,-1725.036499,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1513.926757), SetPVarFloat(npcid,"current_target_y", -1725.036499), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1450.234130,-1724.728149,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.234130), SetPVarFloat(npcid,"current_target_y", -1724.728149), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1473.4574,-1740.9375,13.5469)) //8 ряд 10
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1473.704101,-1724.612792,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.704101), SetPVarFloat(npcid,"current_target_y", -1724.612792), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1519.909912,-1740.688232,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1519.909912), SetPVarFloat(npcid,"current_target_y", -1740.688232), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1437.605468,-1740.801147,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.605468), SetPVarFloat(npcid,"current_target_y", -1740.801147), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1465.5239,-1627.3103,14.0469)) //9 ряд 1
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1473.058715,-1610.921752,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.058715), SetPVarFloat(npcid,"current_target_y", -1610.921752), SetPVarFloat(npcid,"current_target_z", 14.039397);
				case 1: FCNPC_GoTo(npcid,1483.481689,-1610.973266,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.481689), SetPVarFloat(npcid,"current_target_y", -1610.973266), SetPVarFloat(npcid,"current_target_z", 14.039397);
				case 2: FCNPC_GoTo(npcid,1459.884521,-1634.743774,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.884521), SetPVarFloat(npcid,"current_target_y", -1634.743774), SetPVarFloat(npcid,"current_target_z", 14.046975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1459.8425,-1634.7020,14.0469)) //10 ряд 1
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1465.452514,-1627.328857,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1465.452514), SetPVarFloat(npcid,"current_target_y", -1627.328857), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1443.730102,-1629.822265,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1443.730102), SetPVarFloat(npcid,"current_target_y", -1629.822265), SetPVarFloat(npcid,"current_target_z", 14.039397);
				case 2: FCNPC_GoTo(npcid,1459.716064,-1656.473999,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.716064), SetPVarFloat(npcid,"current_target_y", -1656.473999), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 3: FCNPC_GoTo(npcid,1459.259399,-1676.216430,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.259399), SetPVarFloat(npcid,"current_target_y", -1676.216430), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1459.7524,-1656.5216,14.0469)) //10 ряд 2
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1459.873168,-1634.700561,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.873168), SetPVarFloat(npcid,"current_target_y", -1634.700561), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1500.160400,-1656.176635,14.035803,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1500.160400), SetPVarFloat(npcid,"current_target_y", -1656.176635), SetPVarFloat(npcid,"current_target_z", 14.035803);
				case 2: FCNPC_GoTo(npcid,1459.252563,-1676.231079,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.252563), SetPVarFloat(npcid,"current_target_y", -1676.231079), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1459.2438,-1676.4668,14.0469)) //10 ряд 3
	    {
	        switch(random(5))
	        {
				case 0: FCNPC_GoTo(npcid,1459.766601,-1656.470947,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.766601), SetPVarFloat(npcid,"current_target_y", -1656.470947), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1459.790161,-1634.850219,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.790161), SetPVarFloat(npcid,"current_target_y", -1634.850219), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 2: FCNPC_GoTo(npcid,1450.775146,-1678.891723,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.775146), SetPVarFloat(npcid,"current_target_y", -1678.891723), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 3: FCNPC_GoTo(npcid,1474.660766,-1676.645507,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1474.660766), SetPVarFloat(npcid,"current_target_y", -1676.645507), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 4: FCNPC_GoTo(npcid,1500.697631,-1676.854248,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1500.697631), SetPVarFloat(npcid,"current_target_y", -1676.854248), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1450.5747,-1679.0890,14.0501)) //11 ряд 1
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1459.190307,-1676.397949,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.190307), SetPVarFloat(npcid,"current_target_y", -1676.397949), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1450.701782,-1688.192504,14.053194,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.701782), SetPVarFloat(npcid,"current_target_y", -1688.192504), SetPVarFloat(npcid,"current_target_z", 14.053194);
				case 2: FCNPC_GoTo(npcid,1450.315185,-1717.469726,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.315185), SetPVarFloat(npcid,"current_target_y", -1717.469726), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1450.4961,-1688.1288,14.0531)) //11 ряд 2
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1450.658569,-1679.148437,14.050120,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.658569), SetPVarFloat(npcid,"current_target_y", -1679.148437), SetPVarFloat(npcid,"current_target_z", 14.050120);
				case 1: FCNPC_GoTo(npcid,1443.725219,-1688.231689,14.053194,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1443.725219), SetPVarFloat(npcid,"current_target_y", -1688.231689), SetPVarFloat(npcid,"current_target_z", 14.053194);
				case 2: FCNPC_GoTo(npcid,1450.314331,-1717.454345,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.314331), SetPVarFloat(npcid,"current_target_y", -1717.454345), SetPVarFloat(npcid,"current_target_z", 14.046975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1450.2715,-1717.5222,14.0469)) //11 ряд 3
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1450.627685,-1688.199096,14.053194,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.627685), SetPVarFloat(npcid,"current_target_y", -1688.199096), SetPVarFloat(npcid,"current_target_z", 14.053194);
				case 1: FCNPC_GoTo(npcid,1450.157592,-1724.564453,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.157592), SetPVarFloat(npcid,"current_target_y", -1724.564453), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1473.484985,-1717.972412,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.484985), SetPVarFloat(npcid,"current_target_y", -1717.972412), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1450.1240,-1724.7876,13.5469)) //11 ряд 4
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1450.235107,-1717.682006,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.235107), SetPVarFloat(npcid,"current_target_y", -1717.682006), SetPVarFloat(npcid,"current_target_z", 14.046975);
				case 1: FCNPC_GoTo(npcid,1437.407714,-1724.792968,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.407714), SetPVarFloat(npcid,"current_target_y", -1724.792968), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1421.385864,-1723.920776,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.385864), SetPVarFloat(npcid,"current_target_y", -1723.920776), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1520.476562,-1724.518066,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.476562), SetPVarFloat(npcid,"current_target_y", -1724.518066), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1443.6598,-1629.7437,14.0393)) //12 ряд 1
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1437.098876,-1629.675903,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.098876), SetPVarFloat(npcid,"current_target_y", -1629.675903), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1459.859252,-1634.782470,14.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1459.859252), SetPVarFloat(npcid,"current_target_y", -1634.782470), SetPVarFloat(npcid,"current_target_z", 14.046975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1443.5299,-1688.2096,14.0531)) //12 ряд 2
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1437.556884,-1688.357299,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.556884), SetPVarFloat(npcid,"current_target_y", -1688.357299), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1450.674682,-1688.274169,14.053194,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.674682), SetPVarFloat(npcid,"current_target_y", -1688.274169), SetPVarFloat(npcid,"current_target_z", 14.053194);
				case 2: FCNPC_GoTo(npcid,1450.635498,-1679.044189,14.050448,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.635498), SetPVarFloat(npcid,"current_target_y", -1679.044189), SetPVarFloat(npcid,"current_target_z", 14.050448);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1438.4019,-1584.7544,13.5469)) //13 ряд 1
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1483.090087,-1584.918701,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.090087), SetPVarFloat(npcid,"current_target_y", -1584.918701), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1536.846191,-1585.306640,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1536.846191), SetPVarFloat(npcid,"current_target_y", -1585.306640), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1421.144653,-1584.699951,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.144653), SetPVarFloat(npcid,"current_target_y", -1584.699951), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1438.394897,-1599.424682,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1438.394897), SetPVarFloat(npcid,"current_target_y", -1599.424682), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1438.4036,-1599.4703,13.5469)) //13 ряд 2
	    {
	        switch(random(5))
	        {
				case 0: FCNPC_GoTo(npcid,1438.365966,-1584.806152,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1438.365966), SetPVarFloat(npcid,"current_target_y", -1584.806152), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1421.242187,-1600.337402,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.242187), SetPVarFloat(npcid,"current_target_y", -1600.337402), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1483.333251,-1600.361938,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1483.333251), SetPVarFloat(npcid,"current_target_y", -1600.361938), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1520.655761,-1601.539794,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1520.655761), SetPVarFloat(npcid,"current_target_y", -1601.539794), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 4: FCNPC_GoTo(npcid,1437.157104,-1629.493652,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.157104), SetPVarFloat(npcid,"current_target_y", -1629.493652), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1437.1592,-1629.6981,13.5469)) //13 ряд 3
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1438.394775,-1599.535400,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1438.394775), SetPVarFloat(npcid,"current_target_y", -1599.535400), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1443.679809,-1629.722534,14.039397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1443.679809), SetPVarFloat(npcid,"current_target_y", -1629.722534), SetPVarFloat(npcid,"current_target_z", 14.039397);
				case 2: FCNPC_GoTo(npcid,1437.622070,-1641.159545,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.622070), SetPVarFloat(npcid,"current_target_y", -1641.159545), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1437.6367,-1641.0648,13.5469)) //13 ряд 4
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1437.225219,-1629.710205,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.225219), SetPVarFloat(npcid,"current_target_y", -1629.710205), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1437.943359,-1660.154785,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.943359), SetPVarFloat(npcid,"current_target_y", -1660.154785), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1437.8826,-1660.1459,13.5469)) //13 ряд 5
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1437.666503,-1641.066040,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.666503), SetPVarFloat(npcid,"current_target_y", -1641.066040), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1438.432373,-1599.743530,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1438.432373), SetPVarFloat(npcid,"current_target_y", -1599.743530), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1421.712524,-1659.582397,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.712524), SetPVarFloat(npcid,"current_target_y", -1659.582397), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1437.361450,-1688.165405,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.361450), SetPVarFloat(npcid,"current_target_y", -1688.165405), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1437.4073,-1688.2334,13.5469)) //13 ряд 6
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1437.822143,-1660.212768,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.822143), SetPVarFloat(npcid,"current_target_y", -1660.212768), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1443.516357,-1688.240844,14.053194,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1443.516357), SetPVarFloat(npcid,"current_target_y", -1688.240844), SetPVarFloat(npcid,"current_target_z", 14.053194);
				case 2: FCNPC_GoTo(npcid,1437.813110,-1725.086181,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.813110), SetPVarFloat(npcid,"current_target_y", -1725.086181), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1437.553466,-1740.536743,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.553466), SetPVarFloat(npcid,"current_target_y", -1740.536743), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1437.7316,-1724.9520,13.5469)) //13 ряд 7
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1437.371826,-1688.183471,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.371826), SetPVarFloat(npcid,"current_target_y", -1688.183471), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1450.109252,-1724.687255,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1450.109252), SetPVarFloat(npcid,"current_target_y", -1724.687255), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1421.693969,-1723.830200,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.693969), SetPVarFloat(npcid,"current_target_y", -1723.830200), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1437.661010,-1740.571777,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.661010), SetPVarFloat(npcid,"current_target_y", -1740.571777), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1437.5798,-1740.7107,13.5469)) //13 ряд 8
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1437.802001,-1725.025268,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.802001), SetPVarFloat(npcid,"current_target_y", -1725.025268), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1421.833129,-1740.358886,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.833129), SetPVarFloat(npcid,"current_target_y", -1740.358886), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1473.425415,-1740.896362,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1473.425415), SetPVarFloat(npcid,"current_target_y", -1740.896362), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1420.9705,-1584.5808,13.5469)) //14 ряд 1
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1438.222290,-1584.562500,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1438.222290), SetPVarFloat(npcid,"current_target_y", -1584.562500), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1421.200927,-1600.223999,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.200927), SetPVarFloat(npcid,"current_target_y", -1600.223999), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1421.1287,-1600.3228,13.5469)) //14 ряд 2
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1420.996337,-1584.623901,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1420.996337), SetPVarFloat(npcid,"current_target_y", -1584.623901), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1438.417358,-1599.554321,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1438.417358), SetPVarFloat(npcid,"current_target_y", -1599.554321), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1422.015747,-1640.820556,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1422.015747), SetPVarFloat(npcid,"current_target_y", -1640.820556), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1422.0245,-1640.9233,13.5469)) //14 ряд 3
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1421.078491,-1600.397094,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.078491), SetPVarFloat(npcid,"current_target_y", -1600.397094), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1437.579711,-1641.192993,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.579711), SetPVarFloat(npcid,"current_target_y", -1641.192993), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1421.627197,-1659.536132,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.627197), SetPVarFloat(npcid,"current_target_y", -1659.536132), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1421.6621,-1659.5094,13.5469)) //14 ряд 4
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1421.936157,-1640.924194,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.936157), SetPVarFloat(npcid,"current_target_y", -1640.924194), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1437.811645,-1660.356445,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.811645), SetPVarFloat(npcid,"current_target_y", -1660.356445), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1421.589355,-1723.783569,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.589355), SetPVarFloat(npcid,"current_target_y", -1723.783569), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1421.6563,-1723.7434,13.5469)) //14 ряд 5
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1421.631713,-1659.676757,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.631713), SetPVarFloat(npcid,"current_target_y", -1659.676757), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1437.823974,-1724.902099,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.823974), SetPVarFloat(npcid,"current_target_y", -1724.902099), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1421.995849,-1740.368896,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.995849), SetPVarFloat(npcid,"current_target_y", -1740.368896), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
		}
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1421.9440,-1740.3174,13.5469)) //14 ряд 6
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1421.579956,-1723.857299,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1421.579956), SetPVarFloat(npcid,"current_target_y", -1723.857299), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1437.537841,-1740.753784,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1437.537841), SetPVarFloat(npcid,"current_target_y", -1740.753784), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
		}
	}
	if(GetPVarInt(npcid,"nearalnambra")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1681.522949,-1740.156005,13.558902))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1680.870239,-1724.100219,13.555035,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1680.870239), SetPVarFloat(npcid,"current_target_y", -1724.100219), SetPVarFloat(npcid,"current_target_z", 13.555035);
				case 1: FCNPC_GoTo(npcid,1698.031372,-1739.820678,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1698.031372), SetPVarFloat(npcid,"current_target_y", -1739.820678), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1697.623291,-1724.133178,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.623291), SetPVarFloat(npcid,"current_target_y", -1724.133178), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1680.949340,-1724.108764,13.555191)) //
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1681.500976,-1740.153198,13.558889,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.500976), SetPVarFloat(npcid,"current_target_y", -1740.153198), SetPVarFloat(npcid,"current_target_z", 13.558889);
				case 1: FCNPC_GoTo(npcid,1697.641601,-1724.147338,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.641601), SetPVarFloat(npcid,"current_target_y", -1724.147338), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1681.854370,-1701.233154,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.854370), SetPVarFloat(npcid,"current_target_y", -1701.233154), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1681.766113,-1667.202148,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.766113), SetPVarFloat(npcid,"current_target_y", -1667.202148), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1681.914184,-1701.170288,13.546975)) //
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1680.978149,-1723.878906,13.554679,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1680.978149), SetPVarFloat(npcid,"current_target_y", -1723.878906), SetPVarFloat(npcid,"current_target_z", 13.554679);
				case 1: FCNPC_GoTo(npcid,1697.403564,-1698.877685,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.403564), SetPVarFloat(npcid,"current_target_y", -1698.877685), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1681.759277,-1667.212768,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.759277), SetPVarFloat(npcid,"current_target_y", -1667.212768), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1681.855102,-1650.365234,13.539179,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.855102), SetPVarFloat(npcid,"current_target_y", -1650.365234), SetPVarFloat(npcid,"current_target_z", 13.539179);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1681.788818,-1667.256225,13.546975))//
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1681.854370,-1700.956298,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.854370), SetPVarFloat(npcid,"current_target_y", -1700.956298), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1696.661743,-1666.741333,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1696.661743), SetPVarFloat(npcid,"current_target_y", -1666.741333), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1681.896484,-1650.318359,13.539179,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.896484), SetPVarFloat(npcid,"current_target_y", -1650.318359), SetPVarFloat(npcid,"current_target_z", 13.539179);
				case 3: FCNPC_GoTo(npcid,1681.812255,-1628.515625,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.812255), SetPVarFloat(npcid,"current_target_y", -1628.515625), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1681.948364,-1650.476196,13.539179)) //
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1681.816162,-1667.318237,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.816162), SetPVarFloat(npcid,"current_target_y", -1667.318237), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1696.890014,-1650.839477,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1696.890014), SetPVarFloat(npcid,"current_target_y", -1650.839477), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1681.761108,-1628.614746,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.761108), SetPVarFloat(npcid,"current_target_y", -1628.614746), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1681.654541,-1599.532104,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.654541), SetPVarFloat(npcid,"current_target_y", -1599.532104), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1681.809814,-1628.601074,13.546975)) //
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1681.829223,-1650.333007,13.539179,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.829223), SetPVarFloat(npcid,"current_target_y", -1650.333007), SetPVarFloat(npcid,"current_target_z", 13.539179);
				case 1: FCNPC_GoTo(npcid,1697.113037,-1621.307983,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.113037), SetPVarFloat(npcid,"current_target_y", -1621.307983), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1681.433105,-1599.420898,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.433105), SetPVarFloat(npcid,"current_target_y", -1599.420898), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1681.132568,-1586.174560,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.132568), SetPVarFloat(npcid,"current_target_y", -1586.174560), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1681.464843,-1599.418212,13.546975)) //
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1681.701904,-1628.524658,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.701904), SetPVarFloat(npcid,"current_target_y", -1628.524658), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1697.732055,-1600.138427,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.732055), SetPVarFloat(npcid,"current_target_y", -1600.138427), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1681.124389,-1586.138183,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.124389), SetPVarFloat(npcid,"current_target_y", -1586.138183), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1681.236694,-1586.154541,13.546975))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1681.278320,-1599.375488,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.278320), SetPVarFloat(npcid,"current_target_y", -1599.375488), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1698.595214,-1584.631958,13.544487,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1698.595214), SetPVarFloat(npcid,"current_target_y", -1584.631958), SetPVarFloat(npcid,"current_target_z", 13.544487);
				case 2: FCNPC_GoTo(npcid,1697.633544,-1600.097534,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.633544), SetPVarFloat(npcid,"current_target_y", -1600.097534), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1698.179443,-1739.957275,13.546975))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1681.493652,-1740.106323,13.558941,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.493652), SetPVarFloat(npcid,"current_target_y", -1740.106323), SetPVarFloat(npcid,"current_target_z", 13.558941);
				case 1: FCNPC_GoTo(npcid,1697.654418,-1724.158569,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.654418), SetPVarFloat(npcid,"current_target_y", -1724.158569), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1741.406616,-1739.139892,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1741.406616), SetPVarFloat(npcid,"current_target_y", -1739.139892), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1697.659423,-1724.190429,13.546975))//
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1698.175781,-1739.744995,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1698.175781), SetPVarFloat(npcid,"current_target_y", -1739.744995), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1680.929443,-1723.983642,13.554852,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1680.929443), SetPVarFloat(npcid,"current_target_y", -1723.983642), SetPVarFloat(npcid,"current_target_z", 13.554852);
				case 2: FCNPC_GoTo(npcid,1703.836181,-1724.443847,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1703.836181), SetPVarFloat(npcid,"current_target_y", -1724.443847), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1741.032958,-1724.437377,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1741.032958), SetPVarFloat(npcid,"current_target_y", -1724.437377), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1697.428588,-1698.964965,13.546975))//
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1697.649780,-1724.085083,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.649780), SetPVarFloat(npcid,"current_target_y", -1724.085083), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1681.861328,-1701.089477,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.861328), SetPVarFloat(npcid,"current_target_y", -1701.089477), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1703.768798,-1692.848266,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1703.768798), SetPVarFloat(npcid,"current_target_y", -1692.848266), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1697.282348,-1685.971801,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.282348), SetPVarFloat(npcid,"current_target_y", -1685.971801), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1697.339843,-1686.091186,13.546975))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1697.381347,-1698.845947,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.381347), SetPVarFloat(npcid,"current_target_y", -1698.845947), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1709.815917,-1693.131591,13.515702,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1709.815917), SetPVarFloat(npcid,"current_target_y", -1693.131591), SetPVarFloat(npcid,"current_target_z", 13.515702);
				case 2: FCNPC_GoTo(npcid,1696.863159,-1666.694702,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1696.863159), SetPVarFloat(npcid,"current_target_y", -1666.694702), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1696.951904,-1666.835815,13.546975))//
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1697.289306,-1686.079223,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.289306), SetPVarFloat(npcid,"current_target_y", -1686.079223), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1681.816284,-1667.227294,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.816284), SetPVarFloat(npcid,"current_target_y", -1667.227294), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1697.037353,-1650.725952,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.037353), SetPVarFloat(npcid,"current_target_y", -1650.725952), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1697.078613,-1621.367675,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.078613), SetPVarFloat(npcid,"current_target_y", -1621.367675), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1697.057250,-1650.788452,13.546975))//
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1696.904052,-1666.734985,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1696.904052), SetPVarFloat(npcid,"current_target_y", -1666.734985), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1681.948730,-1650.468017,13.539179,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.948730), SetPVarFloat(npcid,"current_target_y", -1650.468017), SetPVarFloat(npcid,"current_target_z", 13.539179);
				case 2: FCNPC_GoTo(npcid,1697.129394,-1621.157836,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.129394), SetPVarFloat(npcid,"current_target_y", -1621.157836), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1697.190307,-1608.080932,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.190307), SetPVarFloat(npcid,"current_target_y", -1608.080932), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1697.149414,-1621.267333,13.546975))//
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1696.955810,-1650.680297,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1696.955810), SetPVarFloat(npcid,"current_target_y", -1650.680297), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1681.784912,-1628.431518,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.784912), SetPVarFloat(npcid,"current_target_y", -1628.431518), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1711.623168,-1621.421875,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1711.623168), SetPVarFloat(npcid,"current_target_y", -1621.421875), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1697.240234,-1608.129638,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.240234), SetPVarFloat(npcid,"current_target_y", -1608.129638), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1697.244018,-1608.139282,13.546975))//
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1697.114624,-1621.170166,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.114624), SetPVarFloat(npcid,"current_target_y", -1621.170166), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1712.057617,-1613.019287,13.554743,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1712.057617), SetPVarFloat(npcid,"current_target_y", -1613.019287), SetPVarFloat(npcid,"current_target_z", 13.554743);
				case 2: FCNPC_GoTo(npcid,1697.711547,-1599.966552,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.711547), SetPVarFloat(npcid,"current_target_y", -1599.966552), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1698.542114,-1585.315185,13.543166,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1698.542114), SetPVarFloat(npcid,"current_target_y", -1585.315185), SetPVarFloat(npcid,"current_target_z", 13.543166);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1697.812622,-1600.204467,13.546975))//
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1697.117919,-1608.129638,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.117919), SetPVarFloat(npcid,"current_target_y", -1608.129638), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1681.346557,-1599.412109,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.346557), SetPVarFloat(npcid,"current_target_y", -1599.412109), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1698.515991,-1585.317504,13.543168,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1698.515991), SetPVarFloat(npcid,"current_target_y", -1585.317504), SetPVarFloat(npcid,"current_target_z", 13.543168);
				case 3: FCNPC_GoTo(npcid,1716.659790,-1602.023193,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1716.659790), SetPVarFloat(npcid,"current_target_y", -1602.023193), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1698.587036,-1585.298339,13.543189))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1697.758178,-1599.949707,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.758178), SetPVarFloat(npcid,"current_target_y", -1599.949707), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1681.051269,-1585.490234,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1681.051269), SetPVarFloat(npcid,"current_target_y", -1585.490234), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1718.009643,-1586.793945,13.541673,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1718.009643), SetPVarFloat(npcid,"current_target_y", -1586.793945), SetPVarFloat(npcid,"current_target_z", 13.541673);

	        }
	    }
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1703.781982,-1724.501586,13.546975))//
	    {
	        switch(random(5))
	        {
				case 0: FCNPC_GoTo(npcid,1697.692138,-1724.192749,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.692138), SetPVarFloat(npcid,"current_target_y", -1724.192749), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1698.021240,-1739.898559,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1698.021240), SetPVarFloat(npcid,"current_target_y", -1739.898559), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1718.699462,-1711.393310,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1718.699462), SetPVarFloat(npcid,"current_target_y", -1711.393310), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 3: FCNPC_GoTo(npcid,1740.984985,-1724.374755,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1740.984985), SetPVarFloat(npcid,"current_target_y", -1724.374755), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 4: FCNPC_GoTo(npcid,1703.771484,-1692.882080,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1703.771484), SetPVarFloat(npcid,"current_target_y", -1692.882080), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1703.873291,-1692.917480,13.546975))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1703.755004,-1724.565063,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1703.755004), SetPVarFloat(npcid,"current_target_y", -1724.565063), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1709.801635,-1693.159301,13.515607,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1709.801635), SetPVarFloat(npcid,"current_target_y", -1693.159301), SetPVarFloat(npcid,"current_target_z", 13.515607);
				case 2: FCNPC_GoTo(npcid,1697.291015,-1698.960083,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.291015), SetPVarFloat(npcid,"current_target_y", -1698.960083), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1709.978393,-1693.178100,13.515542))//
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1703.912841,-1692.890136,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1703.912841), SetPVarFloat(npcid,"current_target_y", -1692.890136), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1719.746459,-1694.000610,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1719.746459), SetPVarFloat(npcid,"current_target_y", -1694.000610), SetPVarFloat(npcid,"current_target_z", 13.500100);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1719.628906,-1693.902587,13.500100))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1709.782104,-1693.180541,13.515534,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1709.782104), SetPVarFloat(npcid,"current_target_y", -1693.180541), SetPVarFloat(npcid,"current_target_z", 13.515534);
				case 1: FCNPC_GoTo(npcid,1718.781860,-1711.313842,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1718.781860), SetPVarFloat(npcid,"current_target_y", -1711.313842), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 2: FCNPC_GoTo(npcid,1725.225585,-1685.262817,13.531485,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1725.225585), SetPVarFloat(npcid,"current_target_y", -1685.262817), SetPVarFloat(npcid,"current_target_z", 13.531485);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1718.826538,-1711.450317,13.500100))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1719.713867,-1693.723876,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1719.713867), SetPVarFloat(npcid,"current_target_y", -1693.723876), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 1: FCNPC_GoTo(npcid,1725.807495,-1711.976928,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1725.807495), SetPVarFloat(npcid,"current_target_y", -1711.976928), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 2: FCNPC_GoTo(npcid,1703.696899,-1724.318481,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1703.696899), SetPVarFloat(npcid,"current_target_y", -1724.318481), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1725.772827,-1712.012817,13.500100))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1718.910034,-1711.434936,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1718.910034), SetPVarFloat(npcid,"current_target_y", -1711.434936), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 1: FCNPC_GoTo(npcid,1725.162841,-1700.387084,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1725.162841), SetPVarFloat(npcid,"current_target_y", -1700.387084), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 2: FCNPC_GoTo(npcid,1740.894409,-1724.530639,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1740.894409), SetPVarFloat(npcid,"current_target_y", -1724.530639), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1725.189208,-1700.465087,13.500100))//
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1725.473144,-1711.998168,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1725.473144), SetPVarFloat(npcid,"current_target_y", -1711.998168), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 1: FCNPC_GoTo(npcid,1724.975585,-1685.330200,13.530959,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1724.975585), SetPVarFloat(npcid,"current_target_y", -1685.330200), SetPVarFloat(npcid,"current_target_z", 13.530959);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1725.369873,-1685.367187,13.530670))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1725.177978,-1700.355346,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1725.177978), SetPVarFloat(npcid,"current_target_y", -1700.355346), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 1: FCNPC_GoTo(npcid,1719.623291,-1693.998535,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1719.623291), SetPVarFloat(npcid,"current_target_y", -1693.998535), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 2: FCNPC_GoTo(npcid,1741.134399,-1685.327270,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1741.134399), SetPVarFloat(npcid,"current_target_y", -1685.327270), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1741.260253,-1739.183593,13.546975))//
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1698.403198,-1739.432495,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1698.403198), SetPVarFloat(npcid,"current_target_y", -1739.432495), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1741.038208,-1724.436767,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1741.038208), SetPVarFloat(npcid,"current_target_y", -1724.436767), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1741.094848,-1724.398803,13.546975))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1741.200195,-1739.149536,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1741.200195), SetPVarFloat(npcid,"current_target_y", -1739.149536), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1703.700683,-1724.513549,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1703.700683), SetPVarFloat(npcid,"current_target_y", -1724.513549), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1741.161254,-1685.425415,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1741.161254), SetPVarFloat(npcid,"current_target_y", -1685.425415), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
  		if(IsPlayerInRangeOfPoint(npcid,3.0,1741.196533,-1685.293579,13.546975))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1741.005371,-1724.279907,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1741.005371), SetPVarFloat(npcid,"current_target_y", -1724.279907), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1725.213378,-1685.228881,13.531750,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1725.213378), SetPVarFloat(npcid,"current_target_y", -1685.228881), SetPVarFloat(npcid,"current_target_z", 13.531750);
				case 2: FCNPC_GoTo(npcid,1740.771484,-1622.724731,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1740.771484), SetPVarFloat(npcid,"current_target_y", -1622.724731), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1740.799926,-1622.772216,13.546975))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1741.013061,-1685.225463,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1741.013061), SetPVarFloat(npcid,"current_target_y", -1685.225463), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1740.563842,-1613.882080,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1740.563842), SetPVarFloat(npcid,"current_target_y", -1613.882080), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1732.625732,-1622.698242,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1732.625732), SetPVarFloat(npcid,"current_target_y", -1622.698242), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1740.512695,-1613.905761,13.546975))//
     	{
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1740.768554,-1622.678466,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1740.768554), SetPVarFloat(npcid,"current_target_y", -1622.678466), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1741.583007,-1606.343750,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1741.583007), SetPVarFloat(npcid,"current_target_y", -1606.343750), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1732.201293,-1614.053466,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1732.201293), SetPVarFloat(npcid,"current_target_y", -1614.053466), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1741.631103,-1606.263671,13.546975))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1740.523071,-1613.899658,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1740.523071), SetPVarFloat(npcid,"current_target_y", -1613.899658), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1742.741699,-1591.415893,13.543972,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1742.741699), SetPVarFloat(npcid,"current_target_y", -1591.415893), SetPVarFloat(npcid,"current_target_z", 13.543972);
				case 2: FCNPC_GoTo(npcid,1724.563720,-1603.111206,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1724.563720), SetPVarFloat(npcid,"current_target_y", -1603.111206), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1742.804443,-1591.546508,13.544101))//
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1741.623413,-1606.261718,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1741.623413), SetPVarFloat(npcid,"current_target_y", -1606.261718), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1718.141967,-1586.791503,13.541706,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1718.141967), SetPVarFloat(npcid,"current_target_y", -1586.791503), SetPVarFloat(npcid,"current_target_z", 13.541706);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1732.255981,-1614.191040,13.546975))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1740.354003,-1613.904052,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1740.354003), SetPVarFloat(npcid,"current_target_y", -1613.904052), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1732.464721,-1622.754150,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1732.464721), SetPVarFloat(npcid,"current_target_y", -1622.754150), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1723.950683,-1603.510253,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1723.950683), SetPVarFloat(npcid,"current_target_y", -1603.510253), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1732.621948,-1622.898071,13.546975))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1740.488037,-1622.768066,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1740.488037), SetPVarFloat(npcid,"current_target_y", -1622.768066), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1732.267822,-1613.991699,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1732.267822), SetPVarFloat(npcid,"current_target_y", -1613.991699), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1721.511840,-1622.655029,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1721.511840), SetPVarFloat(npcid,"current_target_y", -1622.655029), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1724.573608,-1603.193725,13.546975))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1732.320434,-1614.029663,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1732.320434), SetPVarFloat(npcid,"current_target_y", -1614.029663), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1716.658325,-1608.210693,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1716.658325), SetPVarFloat(npcid,"current_target_y", -1608.210693), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1716.873779,-1602.007324,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1716.873779), SetPVarFloat(npcid,"current_target_y", -1602.007324), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1721.711181,-1622.626342,13.546975))//
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1732.355224,-1622.956298,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1732.355224), SetPVarFloat(npcid,"current_target_y", -1622.956298), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1711.497802,-1621.854248,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1711.497802), SetPVarFloat(npcid,"current_target_y", -1621.854248), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1718.220214,-1586.861938,13.541725))//
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1742.777954,-1591.355957,13.543848,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1742.777954), SetPVarFloat(npcid,"current_target_y", -1591.355957), SetPVarFloat(npcid,"current_target_z", 13.543848);
				case 1: FCNPC_GoTo(npcid,1716.707275,-1601.865966,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1716.707275), SetPVarFloat(npcid,"current_target_y", -1601.865966), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1724.511962,-1603.177490,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1724.511962), SetPVarFloat(npcid,"current_target_y", -1603.177490), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1698.594970,-1585.233520,13.543313,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1698.594970), SetPVarFloat(npcid,"current_target_y", -1585.233520), SetPVarFloat(npcid,"current_target_z", 13.543313);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1716.864990,-1602.023803,13.546975))//
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1718.183227,-1586.719116,13.541716,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1718.183227), SetPVarFloat(npcid,"current_target_y", -1586.719116), SetPVarFloat(npcid,"current_target_z", 13.541716);
				case 1: FCNPC_GoTo(npcid,1716.643310,-1608.032714,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1716.643310), SetPVarFloat(npcid,"current_target_y", -1608.032714), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1724.536743,-1603.085449,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1724.536743), SetPVarFloat(npcid,"current_target_y", -1603.085449), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,1697.836791,-1600.022460,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.836791), SetPVarFloat(npcid,"current_target_y", -1600.022460), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1716.649169,-1608.297851,13.546975))//
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1716.777832,-1602.120605,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1716.777832), SetPVarFloat(npcid,"current_target_y", -1602.120605), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1712.068359,-1612.963256,13.554743,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1712.068359), SetPVarFloat(npcid,"current_target_y", -1612.963256), SetPVarFloat(npcid,"current_target_z", 13.554743);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1712.302001,-1613.228881,13.554743))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1716.330810,-1608.280273,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1716.330810), SetPVarFloat(npcid,"current_target_y", -1608.280273), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1697.111083,-1607.818481,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.111083), SetPVarFloat(npcid,"current_target_y", -1607.818481), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1711.771484,-1621.312133,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1711.771484), SetPVarFloat(npcid,"current_target_y", -1621.312133), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1711.849487,-1621.453002,13.546975))//
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1712.260864,-1613.160400,13.554743,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1712.260864), SetPVarFloat(npcid,"current_target_y", -1613.160400), SetPVarFloat(npcid,"current_target_z", 13.554743);
				case 1: FCNPC_GoTo(npcid,1721.553955,-1622.802124,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1721.553955), SetPVarFloat(npcid,"current_target_y", -1622.802124), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1697.087524,-1621.287231,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1697.087524), SetPVarFloat(npcid,"current_target_y", -1621.287231), SetPVarFloat(npcid,"current_target_z", 13.546975);

	        }
	    }
	}
	if(GetPVarInt(npcid,"preglen")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2263.902343,-1228.094604,23.976661))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2183.445556,-1227.254394,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2183.445556), SetPVarFloat(npcid,"current_target_y", -1227.254394), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 1: FCNPC_GoTo(npcid,2263.365966,-1260.976318,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.365966), SetPVarFloat(npcid,"current_target_y", -1260.976318), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 2: FCNPC_GoTo(npcid,2263.206542,-1292.836791,23.987068,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.206542), SetPVarFloat(npcid,"current_target_y", -1292.836791), SetPVarFloat(npcid,"current_target_z", 23.987068);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2183.489013,-1227.376953,23.976661))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2263.844970,-1228.086669,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.844970), SetPVarFloat(npcid,"current_target_y", -1228.086669), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 1: FCNPC_GoTo(npcid,2167.687255,-1228.639648,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2167.687255), SetPVarFloat(npcid,"current_target_y", -1228.639648), SetPVarFloat(npcid,"current_target_z", 23.976661);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2167.611572,-1228.592041,23.976661))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2183.452636,-1227.291137,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2183.452636), SetPVarFloat(npcid,"current_target_y", -1227.291137), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 1: FCNPC_GoTo(npcid,2079.841796,-1228.125122,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.841796), SetPVarFloat(npcid,"current_target_y", -1228.125122), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 2: FCNPC_GoTo(npcid,2166.030029,-1249.115722,23.983993,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2166.030029), SetPVarFloat(npcid,"current_target_y", -1249.115722), SetPVarFloat(npcid,"current_target_z", 23.983993);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2079.739746,-1228.094604,23.976661))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2167.643798,-1228.542480,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2167.643798), SetPVarFloat(npcid,"current_target_y", -1228.542480), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 1: FCNPC_GoTo(npcid,2079.173828,-1292.690673,23.980117,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.173828), SetPVarFloat(npcid,"current_target_y", -1292.690673), SetPVarFloat(npcid,"current_target_z", 23.980117);
				case 2: FCNPC_GoTo(npcid,2079.329589,-1308.702026,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.329589), SetPVarFloat(npcid,"current_target_y", -1308.702026), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    } //ряд 1
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2263.310546,-1260.852416,23.976661))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2263.864257,-1228.201171,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.864257), SetPVarFloat(npcid,"current_target_y", -1228.201171), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 1: FCNPC_GoTo(npcid,2263.175781,-1292.724365,23.986948,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.175781), SetPVarFloat(npcid,"current_target_y", -1292.724365), SetPVarFloat(npcid,"current_target_z", 23.986948);
				case 2: FCNPC_GoTo(npcid,2221.200195,-1261.310424,23.902709,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2221.200195), SetPVarFloat(npcid,"current_target_y", -1261.310424), SetPVarFloat(npcid,"current_target_z", 23.902709);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2221.303955,-1261.226928,23.902912))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2263.210205,-1260.872436,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.210205), SetPVarFloat(npcid,"current_target_y", -1260.872436), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 1: FCNPC_GoTo(npcid,2178.804687,-1257.916015,23.977920,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2178.804687), SetPVarFloat(npcid,"current_target_y", -1257.916015), SetPVarFloat(npcid,"current_target_z", 23.977920);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2178.798095,-1257.899414,23.977928))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2221.095458,-1261.252441,23.894151,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2221.095458), SetPVarFloat(npcid,"current_target_y", -1261.252441), SetPVarFloat(npcid,"current_target_z", 23.894151);
				case 1: FCNPC_GoTo(npcid,2166.073486,-1249.039550,23.983938,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2166.073486), SetPVarFloat(npcid,"current_target_y", -1249.039550), SetPVarFloat(npcid,"current_target_z", 23.983938);
				case 2: FCNPC_GoTo(npcid,2174.837890,-1271.956665,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.837890), SetPVarFloat(npcid,"current_target_y", -1271.956665), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 3: FCNPC_GoTo(npcid,2162.670166,-1260.631835,23.976551,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2162.670166), SetPVarFloat(npcid,"current_target_y", -1260.631835), SetPVarFloat(npcid,"current_target_z", 23.976551);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2165.990234,-1248.973754,23.983890))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2167.647705,-1228.699951,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2167.647705), SetPVarFloat(npcid,"current_target_y", -1228.699951), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 1: FCNPC_GoTo(npcid,2178.697998,-1257.869628,23.977943,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2178.697998), SetPVarFloat(npcid,"current_target_y", -1257.869628), SetPVarFloat(npcid,"current_target_z", 23.977943);
				case 2: FCNPC_GoTo(npcid,2162.633789,-1260.671630,23.976522,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2162.633789), SetPVarFloat(npcid,"current_target_y", -1260.671630), SetPVarFloat(npcid,"current_target_z", 23.976522);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2162.723632,-1260.639282,23.976545))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2178.629882,-1257.890258,23.977931,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2178.629882), SetPVarFloat(npcid,"current_target_y", -1257.890258), SetPVarFloat(npcid,"current_target_z", 23.977931);
				case 1: FCNPC_GoTo(npcid,2165.995361,-1249.156860,23.984024,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2165.995361), SetPVarFloat(npcid,"current_target_y", -1249.156860), SetPVarFloat(npcid,"current_target_z", 23.984024);
				case 2: FCNPC_GoTo(npcid,2159.104248,-1292.659179,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.104248), SetPVarFloat(npcid,"current_target_y", -1292.659179), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 3: FCNPC_GoTo(npcid,2079.654785,-1260.823120,23.983385,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.654785), SetPVarFloat(npcid,"current_target_y", -1260.823120), SetPVarFloat(npcid,"current_target_z", 23.983385);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2079.682617,-1260.830200,23.983465))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2162.559570,-1260.632080,23.976551,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2162.559570), SetPVarFloat(npcid,"current_target_y", -1260.632080), SetPVarFloat(npcid,"current_target_z", 23.976551);
				case 1: FCNPC_GoTo(npcid,2079.722656,-1228.257812,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.722656), SetPVarFloat(npcid,"current_target_y", -1228.257812), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 2: FCNPC_GoTo(npcid,2079.080566,-1292.420898,23.980033,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.080566), SetPVarFloat(npcid,"current_target_y", -1292.420898), SetPVarFloat(npcid,"current_target_z", 23.980033);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2263.114990,-1292.709106,23.986862))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2263.229980,-1260.849609,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.229980), SetPVarFloat(npcid,"current_target_y", -1260.849609), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 1: FCNPC_GoTo(npcid,2174.617675,-1292.604614,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.617675), SetPVarFloat(npcid,"current_target_y", -1292.604614), SetPVarFloat(npcid,"current_target_z", 23.976661);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2174.617675,-1292.604614,23.976661))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2262.941894,-1292.785888,23.986707,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2262.941894), SetPVarFloat(npcid,"current_target_y", -1292.785888), SetPVarFloat(npcid,"current_target_z", 23.986707);
				case 1: FCNPC_GoTo(npcid,2158.987060,-1292.648681,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2158.987060), SetPVarFloat(npcid,"current_target_y", -1292.648681), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 2: FCNPC_GoTo(npcid,2174.769042,-1271.863891,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.769042), SetPVarFloat(npcid,"current_target_y", -1271.863891), SetPVarFloat(npcid,"current_target_z", 23.976661);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2174.723876,-1271.844238,23.976661))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2178.706787,-1257.979736,23.977888,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2178.706787), SetPVarFloat(npcid,"current_target_y", -1257.979736), SetPVarFloat(npcid,"current_target_z", 23.977888);
				case 1: FCNPC_GoTo(npcid,2162.607421,-1260.576293,23.976593,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2162.607421), SetPVarFloat(npcid,"current_target_y", -1260.576293), SetPVarFloat(npcid,"current_target_z", 23.976593);
				case 2: FCNPC_GoTo(npcid,2174.484863,-1292.274414,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.484863), SetPVarFloat(npcid,"current_target_y", -1292.274414), SetPVarFloat(npcid,"current_target_z", 23.976661);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2159.101806,-1292.598144,23.976661))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2174.498291,-1292.474731,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.498291), SetPVarFloat(npcid,"current_target_y", -1292.474731), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 1: FCNPC_GoTo(npcid,2162.753662,-1260.865234,23.976381,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2162.753662), SetPVarFloat(npcid,"current_target_y", -1260.865234), SetPVarFloat(npcid,"current_target_z", 23.976381);
				case 2: FCNPC_GoTo(npcid,2159.156250,-1308.737304,23.983257,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.156250), SetPVarFloat(npcid,"current_target_y", -1308.737304), SetPVarFloat(npcid,"current_target_z", 23.983257);
				case 3: FCNPC_GoTo(npcid,2079.089111,-1292.893432,23.980369,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.089111), SetPVarFloat(npcid,"current_target_y", -1292.893432), SetPVarFloat(npcid,"current_target_z", 23.980369);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2079.089111,-1292.893432,23.980369))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2079.267578,-1308.539672,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.267578), SetPVarFloat(npcid,"current_target_y", -1308.539672), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2158.695800,-1292.574462,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2158.695800), SetPVarFloat(npcid,"current_target_y", -1292.574462), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 2: FCNPC_GoTo(npcid,2079.598144,-1260.932128,23.983219,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.598144), SetPVarFloat(npcid,"current_target_y", -1260.932128), SetPVarFloat(npcid,"current_target_z", 23.983219);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2263.016601,-1308.510742,23.984474))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2263.075439,-1376.788330,23.982528,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.075439), SetPVarFloat(npcid,"current_target_y", -1376.788330), SetPVarFloat(npcid,"current_target_z", 23.982528);
				case 1: FCNPC_GoTo(npcid,2263.357910,-1340.234252,23.984270,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.357910), SetPVarFloat(npcid,"current_target_y", -1340.234252), SetPVarFloat(npcid,"current_target_z", 23.984270);
				case 2: FCNPC_GoTo(npcid,2229.680419,-1308.611816,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2229.680419), SetPVarFloat(npcid,"current_target_y", -1308.611816), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 3: FCNPC_GoTo(npcid,2174.855468,-1308.619506,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.855468), SetPVarFloat(npcid,"current_target_y", -1308.619506), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2229.609863,-1308.526000,23.984474))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2263.059082,-1308.500732,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.059082), SetPVarFloat(npcid,"current_target_y", -1308.500732), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2217.345458,-1377.035522,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2217.345458), SetPVarFloat(npcid,"current_target_y", -1377.035522), SetPVarFloat(npcid,"current_target_z", 24.000099);
				case 2: FCNPC_GoTo(npcid,2174.978271,-1308.487182,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.978271), SetPVarFloat(npcid,"current_target_y", -1308.487182), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 3: FCNPC_GoTo(npcid,2208.105712,-1308.499511,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2208.105712), SetPVarFloat(npcid,"current_target_y", -1308.499511), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2208.105712,-1308.499511,23.984474))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2229.565185,-1308.482299,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2229.565185), SetPVarFloat(npcid,"current_target_y", -1308.482299), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2174.739501,-1308.492309,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.739501), SetPVarFloat(npcid,"current_target_y", -1308.492309), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 2: FCNPC_GoTo(npcid,2207.959716,-1341.076293,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2207.959716), SetPVarFloat(npcid,"current_target_y", -1341.076293), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2174.758544,-1308.436767,23.984474))
	    {
	        switch(random(6))
	        {
				case 0: FCNPC_GoTo(npcid,2207.942138,-1308.354248,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2207.942138), SetPVarFloat(npcid,"current_target_y", -1308.354248), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2229.599365,-1308.544067,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2229.599365), SetPVarFloat(npcid,"current_target_y", -1308.544067), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 2: FCNPC_GoTo(npcid,2174.477539,-1292.536865,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.477539), SetPVarFloat(npcid,"current_target_y", -1292.536865), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 3: FCNPC_GoTo(npcid,2159.118408,-1308.593505,23.983951,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.118408), SetPVarFloat(npcid,"current_target_y", -1308.593505), SetPVarFloat(npcid,"current_target_z", 23.983951);
				case 4: FCNPC_GoTo(npcid,2174.248535,-1341.642456,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.248535), SetPVarFloat(npcid,"current_target_y", -1341.642456), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 5: FCNPC_GoTo(npcid,2174.340087,-1376.555053,23.990449,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.340087), SetPVarFloat(npcid,"current_target_y", -1376.555053), SetPVarFloat(npcid,"current_target_z", 23.990449);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2159.152343,-1308.533569,23.984050))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2159.015625,-1292.751342,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.015625), SetPVarFloat(npcid,"current_target_y", -1292.751342), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 1: FCNPC_GoTo(npcid,2174.818603,-1308.493652,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.818603), SetPVarFloat(npcid,"current_target_y", -1308.493652), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 2: FCNPC_GoTo(npcid,2159.177734,-1342.445678,23.996713,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.177734), SetPVarFloat(npcid,"current_target_y", -1342.445678), SetPVarFloat(npcid,"current_target_z", 23.996713);
				case 3: FCNPC_GoTo(npcid,2159.134277,-1376.538818,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.134277), SetPVarFloat(npcid,"current_target_y", -1376.538818), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2079.315429,-1308.619873,23.984474))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2079.149902,-1292.565063,23.980054,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.149902), SetPVarFloat(npcid,"current_target_y", -1292.565063), SetPVarFloat(npcid,"current_target_z", 23.980054);
				case 1: FCNPC_GoTo(npcid,2079.458007,-1342.147583,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.458007), SetPVarFloat(npcid,"current_target_y", -1342.147583), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 2: FCNPC_GoTo(npcid,2079.954833,-1376.820068,23.998760,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.954833), SetPVarFloat(npcid,"current_target_y", -1376.820068), SetPVarFloat(npcid,"current_target_z", 23.998760);
				case 3: FCNPC_GoTo(npcid,2159.049804,-1308.612060,23.983879,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.049804), SetPVarFloat(npcid,"current_target_y", -1308.612060), SetPVarFloat(npcid,"current_target_z", 23.983879);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2263.255615,-1340.131225,23.984418))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2257.281982,-1340.103759,23.983324,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2257.281982), SetPVarFloat(npcid,"current_target_y", -1340.103759), SetPVarFloat(npcid,"current_target_z", 23.983324);
				case 1: FCNPC_GoTo(npcid,2263.047851,-1376.775512,23.982564,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.047851), SetPVarFloat(npcid,"current_target_y", -1376.775512), SetPVarFloat(npcid,"current_target_z", 23.982564);
				case 2: FCNPC_GoTo(npcid,2263.041259,-1308.484741,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.041259), SetPVarFloat(npcid,"current_target_y", -1308.484741), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2257.277832,-1339.970581,23.983291))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2263.117187,-1340.079956,23.984622,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.117187), SetPVarFloat(npcid,"current_target_y", -1340.079956), SetPVarFloat(npcid,"current_target_z", 23.984622);
				case 1: FCNPC_GoTo(npcid,2256.940429,-1319.068969,23.978187,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2256.940429), SetPVarFloat(npcid,"current_target_y", -1319.068969), SetPVarFloat(npcid,"current_target_z", 23.978187);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2256.851074,-1319.041503,23.978179))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2257.273681,-1339.957031,23.983287,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2257.273681), SetPVarFloat(npcid,"current_target_y", -1339.957031), SetPVarFloat(npcid,"current_target_z", 23.983287);
				case 1: FCNPC_GoTo(npcid,2229.556884,-1308.494140,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2229.556884), SetPVarFloat(npcid,"current_target_y", -1308.494140), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2207.825439,-1341.027099,23.984474))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2220.698974,-1346.399169,23.984861,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2220.698974), SetPVarFloat(npcid,"current_target_y", -1346.399169), SetPVarFloat(npcid,"current_target_z", 23.984861);
				case 1: FCNPC_GoTo(npcid,2173.991455,-1341.558959,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2173.991455), SetPVarFloat(npcid,"current_target_y", -1341.558959), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2220.592773,-1346.464233,23.984878))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2229.612304,-1308.598754,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2229.612304), SetPVarFloat(npcid,"current_target_y", -1308.598754), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2207.853759,-1340.996948,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2207.853759), SetPVarFloat(npcid,"current_target_y", -1340.996948), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 2: FCNPC_GoTo(npcid,2217.304931,-1376.868286,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2217.304931), SetPVarFloat(npcid,"current_target_y", -1376.868286), SetPVarFloat(npcid,"current_target_z", 24.000099);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2174.102783,-1341.606323,23.984474))
	    {
	        switch(random(5))
	        {
				case 0: FCNPC_GoTo(npcid,2207.869628,-1341.021118,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2207.869628), SetPVarFloat(npcid,"current_target_y", -1341.021118), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2159.145263,-1342.365600,23.996618,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.145263), SetPVarFloat(npcid,"current_target_y", -1342.365600), SetPVarFloat(npcid,"current_target_z", 23.996618);
				case 2: FCNPC_GoTo(npcid,2174.751953,-1308.750610,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.751953), SetPVarFloat(npcid,"current_target_y", -1308.750610), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 3: FCNPC_GoTo(npcid,2174.449218,-1292.357666,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.449218), SetPVarFloat(npcid,"current_target_y", -1292.357666), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 4: FCNPC_GoTo(npcid,2174.274414,-1376.549804,23.990600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.274414), SetPVarFloat(npcid,"current_target_y", -1376.549804), SetPVarFloat(npcid,"current_target_z", 23.990600);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2159.227783,-1342.348266,23.996858))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2174.116455,-1341.654541,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.116455), SetPVarFloat(npcid,"current_target_y", -1341.654541), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2159.104003,-1376.332763,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.104003), SetPVarFloat(npcid,"current_target_y", -1376.332763), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 2: FCNPC_GoTo(npcid,2079.360351,-1342.139404,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.360351), SetPVarFloat(npcid,"current_target_y", -1342.139404), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2079.393310,-1342.079956,23.984474))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2159.150878,-1342.374755,23.996633,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.150878), SetPVarFloat(npcid,"current_target_y", -1342.374755), SetPVarFloat(npcid,"current_target_z", 23.996633);
				case 1: FCNPC_GoTo(npcid,2079.282958,-1308.632324,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.282958), SetPVarFloat(npcid,"current_target_y", -1308.632324), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 2: FCNPC_GoTo(npcid,2079.858886,-1376.815429,23.998912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.858886), SetPVarFloat(npcid,"current_target_y", -1376.815429), SetPVarFloat(npcid,"current_target_z", 23.998912);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2263.018798,-1376.790161,23.982568))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2263.243652,-1340.058349,23.984437,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.243652), SetPVarFloat(npcid,"current_target_y", -1340.058349), SetPVarFloat(npcid,"current_target_z", 23.984437);
				case 1: FCNPC_GoTo(npcid,2262.994873,-1308.651855,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2262.994873), SetPVarFloat(npcid,"current_target_y", -1308.651855), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 2: FCNPC_GoTo(npcid,2217.196533,-1376.896972,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2217.196533), SetPVarFloat(npcid,"current_target_y", -1376.896972), SetPVarFloat(npcid,"current_target_z", 24.000099);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2217.196533,-1376.896972,24.000099))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2263.093505,-1376.797973,23.982503,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2263.093505), SetPVarFloat(npcid,"current_target_y", -1376.797973), SetPVarFloat(npcid,"current_target_z", 23.982503);
				case 1: FCNPC_GoTo(npcid,2220.645751,-1346.337524,23.984846,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2220.645751), SetPVarFloat(npcid,"current_target_y", -1346.337524), SetPVarFloat(npcid,"current_target_z", 23.984846);
				case 2: FCNPC_GoTo(npcid,2229.605957,-1308.634155,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2229.605957), SetPVarFloat(npcid,"current_target_y", -1308.634155), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2174.407714,-1376.495117,23.990182))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2174.108154,-1341.819335,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.108154), SetPVarFloat(npcid,"current_target_y", -1341.819335), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2159.250732,-1376.472900,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.250732), SetPVarFloat(npcid,"current_target_y", -1376.472900), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2159.250732,-1376.472900,23.984474))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2174.324707,-1376.529052,23.990442,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2174.324707), SetPVarFloat(npcid,"current_target_y", -1376.529052), SetPVarFloat(npcid,"current_target_z", 23.990442);
				case 1: FCNPC_GoTo(npcid,2159.245605,-1342.371215,23.996912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.245605), SetPVarFloat(npcid,"current_target_y", -1342.371215), SetPVarFloat(npcid,"current_target_z", 23.996912);
				case 2: FCNPC_GoTo(npcid,2079.793457,-1376.794433,23.998973,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.793457), SetPVarFloat(npcid,"current_target_y", -1376.794433), SetPVarFloat(npcid,"current_target_z", 23.998973);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2079.793457,-1376.794433,23.998973))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2159.052246,-1376.535888,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2159.052246), SetPVarFloat(npcid,"current_target_y", -1376.535888), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2079.335449,-1342.200927,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.335449), SetPVarFloat(npcid,"current_target_y", -1342.200927), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 2: FCNPC_GoTo(npcid,2079.074951,-1292.693725,23.980241,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.074951), SetPVarFloat(npcid,"current_target_y", -1292.693725), SetPVarFloat(npcid,"current_target_z", 23.980241);
	        }
	    }
	}
	if(GetPVarInt(npcid,"prgl2")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2335.097412,-1392.966308,23.920774))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2350.562011,-1392.500244,23.990589,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.562011), SetPVarFloat(npcid,"current_target_y", -1392.500244), SetPVarFloat(npcid,"current_target_z", 23.990589);
				case 1: FCNPC_GoTo(npcid,2384.157958,-1392.223144,24.035354,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2384.157958), SetPVarFloat(npcid,"current_target_y", -1392.223144), SetPVarFloat(npcid,"current_target_z", 24.035354);
				case 2: FCNPC_GoTo(npcid,2334.819335,-1475.374877,24.000020,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.819335), SetPVarFloat(npcid,"current_target_y", -1475.374877), SetPVarFloat(npcid,"current_target_z", 24.000020);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2350.529541,-1392.536010,23.990602))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2335.088623,-1392.851196,23.922998,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2335.088623), SetPVarFloat(npcid,"current_target_y", -1392.851196), SetPVarFloat(npcid,"current_target_z", 23.922998);
				case 1: FCNPC_GoTo(npcid,2350.236083,-1473.957153,23.828224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.236083), SetPVarFloat(npcid,"current_target_y", -1473.957153), SetPVarFloat(npcid,"current_target_z", 23.828224);
				case 2: FCNPC_GoTo(npcid,2384.123535,-1392.076171,24.035774,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2384.123535), SetPVarFloat(npcid,"current_target_y", -1392.076171), SetPVarFloat(npcid,"current_target_z", 24.035774);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2384.064941,-1392.084472,24.035350))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2398.230224,-1391.321655,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.230224), SetPVarFloat(npcid,"current_target_y", -1391.321655), SetPVarFloat(npcid,"current_target_z", 24.000099);
				case 1: FCNPC_GoTo(npcid,2350.603515,-1392.481567,23.990552,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.603515), SetPVarFloat(npcid,"current_target_y", -1392.481567), SetPVarFloat(npcid,"current_target_z", 23.990552);
				case 2: FCNPC_GoTo(npcid,2384.166259,-1429.721923,24.007911,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2384.166259), SetPVarFloat(npcid,"current_target_y", -1429.721923), SetPVarFloat(npcid,"current_target_z", 24.007911);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2398.160400,-1391.235107,24.000099))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2384.074951,-1392.128417,24.035223,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2384.074951), SetPVarFloat(npcid,"current_target_y", -1392.128417), SetPVarFloat(npcid,"current_target_z", 24.035223);
				case 1: FCNPC_GoTo(npcid,2398.562988,-1429.592285,23.992301,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.562988), SetPVarFloat(npcid,"current_target_y", -1429.592285), SetPVarFloat(npcid,"current_target_z", 23.992301);
				case 2: FCNPC_GoTo(npcid,2398.482177,-1402.298706,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.482177), SetPVarFloat(npcid,"current_target_y", -1402.298706), SetPVarFloat(npcid,"current_target_z", 24.000099);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2398.329589,-1402.256469,24.000099))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2383.612060,-1402.121337,24.004657,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2383.612060), SetPVarFloat(npcid,"current_target_y", -1402.121337), SetPVarFloat(npcid,"current_target_z", 24.004657);
				case 1: FCNPC_GoTo(npcid,2398.134765,-1391.269287,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.134765), SetPVarFloat(npcid,"current_target_y", -1391.269287), SetPVarFloat(npcid,"current_target_z", 24.000099);
				case 2: FCNPC_GoTo(npcid,2398.450439,-1429.371337,23.992301,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.450439), SetPVarFloat(npcid,"current_target_y", -1429.371337), SetPVarFloat(npcid,"current_target_z", 23.992301);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2383.630126,-1401.943603,24.004684))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2383.855224,-1392.515991,24.032072,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2383.855224), SetPVarFloat(npcid,"current_target_y", -1392.515991), SetPVarFloat(npcid,"current_target_z", 24.032072);
				case 1: FCNPC_GoTo(npcid,2398.442382,-1402.225463,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.442382), SetPVarFloat(npcid,"current_target_y", -1402.225463), SetPVarFloat(npcid,"current_target_z", 24.000099);
				case 2: FCNPC_GoTo(npcid,2384.178466,-1429.725708,24.007911,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2384.178466), SetPVarFloat(npcid,"current_target_y", -1429.725708), SetPVarFloat(npcid,"current_target_z", 24.007911);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2384.142578,-1429.663940,24.007911))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2398.478515,-1429.377075,23.992301,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.478515), SetPVarFloat(npcid,"current_target_y", -1429.377075), SetPVarFloat(npcid,"current_target_z", 23.992301);
				case 1: FCNPC_GoTo(npcid,2383.479003,-1402.083984,24.004461,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2383.479003), SetPVarFloat(npcid,"current_target_y", -1402.083984), SetPVarFloat(npcid,"current_target_z", 24.004461);
				case 2: FCNPC_GoTo(npcid,2385.838623,-1446.427368,24.007911,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2385.838623), SetPVarFloat(npcid,"current_target_y", -1446.427368), SetPVarFloat(npcid,"current_target_z", 24.007911);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2398.294433,-1429.510009,23.992301))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2398.216064,-1391.313354,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.216064), SetPVarFloat(npcid,"current_target_y", -1391.313354), SetPVarFloat(npcid,"current_target_z", 24.000099);
				case 1: FCNPC_GoTo(npcid,2384.062255,-1429.642822,24.007911,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2384.062255), SetPVarFloat(npcid,"current_target_y", -1429.642822), SetPVarFloat(npcid,"current_target_z", 24.007911);
				case 2: FCNPC_GoTo(npcid,2398.888183,-1436.619140,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.888183), SetPVarFloat(npcid,"current_target_y", -1436.619140), SetPVarFloat(npcid,"current_target_z", 24.000099);
				case 3: FCNPC_GoTo(npcid,2400.476562,-1451.847534,24.001119,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2400.476562), SetPVarFloat(npcid,"current_target_y", -1451.847534), SetPVarFloat(npcid,"current_target_z", 24.001119);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2398.780517,-1436.484497,24.000099))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2398.092285,-1402.244995,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.092285), SetPVarFloat(npcid,"current_target_y", -1402.244995), SetPVarFloat(npcid,"current_target_z", 24.000099);
				case 1: FCNPC_GoTo(npcid,2400.452880,-1451.839965,24.001136,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2400.452880), SetPVarFloat(npcid,"current_target_y", -1451.839965), SetPVarFloat(npcid,"current_target_z", 24.001136);
				case 2: FCNPC_GoTo(npcid,2438.509765,-1436.846801,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.509765), SetPVarFloat(npcid,"current_target_y", -1436.846801), SetPVarFloat(npcid,"current_target_z", 24.000099);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2438.511230,-1436.780517,24.000099))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2438.712158,-1452.392822,24.006628,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.712158), SetPVarFloat(npcid,"current_target_y", -1452.392822), SetPVarFloat(npcid,"current_target_z", 24.006628);
				case 1: FCNPC_GoTo(npcid,2398.981689,-1436.518066,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.981689), SetPVarFloat(npcid,"current_target_y", -1436.518066), SetPVarFloat(npcid,"current_target_z", 24.000099);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2385.805908,-1446.393676,24.007911))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2383.714843,-1429.561645,24.007911,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2383.714843), SetPVarFloat(npcid,"current_target_y", -1429.561645), SetPVarFloat(npcid,"current_target_z", 24.007911);
				case 1: FCNPC_GoTo(npcid,2400.480224,-1451.760498,24.001117,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2400.480224), SetPVarFloat(npcid,"current_target_y", -1451.760498), SetPVarFloat(npcid,"current_target_z", 24.001117);
				case 2: FCNPC_GoTo(npcid,2385.908447,-1474.832031,23.803758,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2385.908447), SetPVarFloat(npcid,"current_target_y", -1474.832031), SetPVarFloat(npcid,"current_target_z", 23.803758);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2400.349609,-1451.758789,24.001213))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2385.752685,-1446.415405,24.007911,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2385.752685), SetPVarFloat(npcid,"current_target_y", -1446.415405), SetPVarFloat(npcid,"current_target_z", 24.007911);
				case 1: FCNPC_GoTo(npcid,2423.331054,-1452.125976,24.010807,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.331054), SetPVarFloat(npcid,"current_target_y", -1452.125976), SetPVarFloat(npcid,"current_target_z", 24.010807);
				case 2: FCNPC_GoTo(npcid,2398.922119,-1436.548339,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.922119), SetPVarFloat(npcid,"current_target_y", -1436.548339), SetPVarFloat(npcid,"current_target_z", 24.000099);
				case 3: FCNPC_GoTo(npcid,2398.468261,-1429.684692,23.992301,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2398.468261), SetPVarFloat(npcid,"current_target_y", -1429.684692), SetPVarFloat(npcid,"current_target_z", 23.992301);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2423.197509,-1452.085327,24.010620))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2400.456787,-1451.794067,24.001134,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2400.456787), SetPVarFloat(npcid,"current_target_y", -1451.794067), SetPVarFloat(npcid,"current_target_z", 24.001134);
				case 1: FCNPC_GoTo(npcid,2438.601562,-1452.355468,24.006790,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.601562), SetPVarFloat(npcid,"current_target_y", -1452.355468), SetPVarFloat(npcid,"current_target_z", 24.006790);
				case 2: FCNPC_GoTo(npcid,2423.251708,-1475.186889,23.849042,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.251708), SetPVarFloat(npcid,"current_target_y", -1475.186889), SetPVarFloat(npcid,"current_target_z", 23.849042);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2438.622558,-1452.367065,24.006755))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2438.451416,-1436.887573,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.451416), SetPVarFloat(npcid,"current_target_y", -1436.887573), SetPVarFloat(npcid,"current_target_z", 24.000099);
				case 1: FCNPC_GoTo(npcid,2438.771240,-1496.467529,23.994009,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.771240), SetPVarFloat(npcid,"current_target_y", -1496.467529), SetPVarFloat(npcid,"current_target_z", 23.994009);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2334.762695,-1475.442382,24.000001))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2335.019042,-1392.993286,23.917697,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2335.019042), SetPVarFloat(npcid,"current_target_y", -1392.993286), SetPVarFloat(npcid,"current_target_z", 23.917697);
				case 1: FCNPC_GoTo(npcid,2350.172851,-1473.870727,23.828224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.172851), SetPVarFloat(npcid,"current_target_y", -1473.870727), SetPVarFloat(npcid,"current_target_z", 23.828224);
				case 2: FCNPC_GoTo(npcid,2385.863281,-1474.768310,23.803369,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2385.863281), SetPVarFloat(npcid,"current_target_y", -1474.768310), SetPVarFloat(npcid,"current_target_z", 23.803369);
				case 3: FCNPC_GoTo(npcid,2334.853515,-1492.319946,24.004491,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.853515), SetPVarFloat(npcid,"current_target_y", -1492.319946), SetPVarFloat(npcid,"current_target_z", 24.004491);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2350.134033,-1473.879394,23.828224))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2350.452148,-1392.714355,23.990566,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.452148), SetPVarFloat(npcid,"current_target_y", -1392.714355), SetPVarFloat(npcid,"current_target_z", 23.990566);
				case 1: FCNPC_GoTo(npcid,2385.903076,-1474.711914,23.803024,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2385.903076), SetPVarFloat(npcid,"current_target_y", -1474.711914), SetPVarFloat(npcid,"current_target_z", 23.803024);
				case 2: FCNPC_GoTo(npcid,2423.274169,-1475.134277,23.847358,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.274169), SetPVarFloat(npcid,"current_target_y", -1475.134277), SetPVarFloat(npcid,"current_target_z", 23.847358);
				case 3: FCNPC_GoTo(npcid,2350.291992,-1516.800292,24.007318,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.291992), SetPVarFloat(npcid,"current_target_y", -1516.800292), SetPVarFloat(npcid,"current_target_z", 24.007318);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2385.817138,-1474.751831,23.803268))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2385.792724,-1446.359619,24.007911,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2385.792724), SetPVarFloat(npcid,"current_target_y", -1446.359619), SetPVarFloat(npcid,"current_target_z", 24.007911);
				case 1: FCNPC_GoTo(npcid,2350.228759,-1473.893066,23.828224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.228759), SetPVarFloat(npcid,"current_target_y", -1473.893066), SetPVarFloat(npcid,"current_target_z", 23.828224);
				case 2: FCNPC_GoTo(npcid,2334.820800,-1475.384155,24.000030,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.820800), SetPVarFloat(npcid,"current_target_y", -1475.384155), SetPVarFloat(npcid,"current_target_z", 24.000030);
				case 3: FCNPC_GoTo(npcid,2423.203613,-1475.111328,23.846624,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.203613), SetPVarFloat(npcid,"current_target_y", -1475.111328), SetPVarFloat(npcid,"current_target_z", 23.846624);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2423.203613,-1475.111328,23.846624))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2423.247802,-1452.185668,24.010662,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.247802), SetPVarFloat(npcid,"current_target_y", -1452.185668), SetPVarFloat(npcid,"current_target_z", 24.010662);
				case 1: FCNPC_GoTo(npcid,2385.937988,-1474.766845,23.803359,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2385.937988), SetPVarFloat(npcid,"current_target_y", -1474.766845), SetPVarFloat(npcid,"current_target_z", 23.803359);
				case 2: FCNPC_GoTo(npcid,2423.683837,-1516.642211,24.007917,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.683837), SetPVarFloat(npcid,"current_target_y", -1516.642211), SetPVarFloat(npcid,"current_target_z", 24.007917);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2438.635253,-1496.396118,23.994123))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2423.607666,-1497.824829,23.992307,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.607666), SetPVarFloat(npcid,"current_target_y", -1497.824829), SetPVarFloat(npcid,"current_target_z", 23.992307);
				case 1: FCNPC_GoTo(npcid,2438.690429,-1452.420043,24.006633,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.690429), SetPVarFloat(npcid,"current_target_y", -1452.420043), SetPVarFloat(npcid,"current_target_z", 24.006633);
				case 2: FCNPC_GoTo(npcid,2438.928955,-1513.100830,23.992206,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.928955), SetPVarFloat(npcid,"current_target_y", -1513.100830), SetPVarFloat(npcid,"current_target_z", 23.992206);
				case 3: FCNPC_GoTo(npcid,2438.009033,-1532.221923,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.009033), SetPVarFloat(npcid,"current_target_y", -1532.221923), SetPVarFloat(npcid,"current_target_z", 24.000099);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2423.697265,-1497.726440,23.992307))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2423.308593,-1475.098510,23.846214,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.308593), SetPVarFloat(npcid,"current_target_y", -1475.098510), SetPVarFloat(npcid,"current_target_z", 23.846214);
				case 1: FCNPC_GoTo(npcid,2438.619384,-1496.393920,23.994140,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.619384), SetPVarFloat(npcid,"current_target_y", -1496.393920), SetPVarFloat(npcid,"current_target_z", 23.994140);
				case 2: FCNPC_GoTo(npcid,2423.666259,-1516.580322,24.007768,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.666259), SetPVarFloat(npcid,"current_target_y", -1516.580322), SetPVarFloat(npcid,"current_target_z", 24.007768);
				case 3: FCNPC_GoTo(npcid,2423.461181,-1532.160888,24.004272,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.461181), SetPVarFloat(npcid,"current_target_y", -1532.160888), SetPVarFloat(npcid,"current_target_z", 24.004272);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2438.773681,-1512.908691,23.992536))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2438.735107,-1496.511108,23.994085,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.735107), SetPVarFloat(npcid,"current_target_y", -1496.511108), SetPVarFloat(npcid,"current_target_z", 23.994085);
				case 1: FCNPC_GoTo(npcid,2423.545410,-1516.666381,24.007619,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.545410), SetPVarFloat(npcid,"current_target_y", -1516.666381), SetPVarFloat(npcid,"current_target_z", 24.007619);
				case 2: FCNPC_GoTo(npcid,2438.338378,-1532.427734,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.338378), SetPVarFloat(npcid,"current_target_y", -1532.427734), SetPVarFloat(npcid,"current_target_z", 24.000099);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2423.666015,-1516.604248,24.007808))
	    {
	        switch(random(5))
	        {
				case 0: FCNPC_GoTo(npcid,2438.836914,-1512.817382,23.992525,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.836914), SetPVarFloat(npcid,"current_target_y", -1512.817382), SetPVarFloat(npcid,"current_target_z", 23.992525);
				case 1: FCNPC_GoTo(npcid,2423.523437,-1497.719848,23.992307,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.523437), SetPVarFloat(npcid,"current_target_y", -1497.719848), SetPVarFloat(npcid,"current_target_z", 23.992307);
				case 2: FCNPC_GoTo(npcid,2423.301269,-1475.166748,23.848398,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.301269), SetPVarFloat(npcid,"current_target_y", -1475.166748), SetPVarFloat(npcid,"current_target_z", 23.848398);
				case 3: FCNPC_GoTo(npcid,2423.403320,-1532.079589,24.004268,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.403320), SetPVarFloat(npcid,"current_target_y", -1532.079589), SetPVarFloat(npcid,"current_target_z", 24.004268);
				case 4: FCNPC_GoTo(npcid,2407.000976,-1516.808349,23.999292,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2407.000976), SetPVarFloat(npcid,"current_target_y", -1516.808349), SetPVarFloat(npcid,"current_target_z", 23.999292);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2407.000976,-1516.808349,23.999292))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2423.683349,-1516.677246,24.007976,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.683349), SetPVarFloat(npcid,"current_target_y", -1516.677246), SetPVarFloat(npcid,"current_target_z", 24.007976);
				case 1: FCNPC_GoTo(npcid,2406.854980,-1531.773315,23.992305,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.854980), SetPVarFloat(npcid,"current_target_y", -1531.773315), SetPVarFloat(npcid,"current_target_z", 23.992305);
				case 2: FCNPC_GoTo(npcid,2383.681640,-1516.473388,23.994403,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2383.681640), SetPVarFloat(npcid,"current_target_y", -1516.473388), SetPVarFloat(npcid,"current_target_z", 23.994403);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2383.727050,-1516.351684,23.994777))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2407.000732,-1516.744628,23.999292,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2407.000732), SetPVarFloat(npcid,"current_target_y", -1516.744628), SetPVarFloat(npcid,"current_target_z", 23.999292);
				case 1: FCNPC_GoTo(npcid,2350.318847,-1516.726806,24.007093,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.318847), SetPVarFloat(npcid,"current_target_y", -1516.726806), SetPVarFloat(npcid,"current_target_z", 24.007093);
				case 2: FCNPC_GoTo(npcid,2380.657226,-1532.258544,23.992305,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2380.657226), SetPVarFloat(npcid,"current_target_y", -1532.258544), SetPVarFloat(npcid,"current_target_z", 23.992305);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2350.305175,-1516.760498,24.007198))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2350.069091,-1473.849609,23.828224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.069091), SetPVarFloat(npcid,"current_target_y", -1473.849609), SetPVarFloat(npcid,"current_target_z", 23.828224);
				case 1: FCNPC_GoTo(npcid,2383.470214,-1516.476196,23.993623,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2383.470214), SetPVarFloat(npcid,"current_target_y", -1516.476196), SetPVarFloat(npcid,"current_target_z", 23.993623);
				case 2: FCNPC_GoTo(npcid,2335.279541,-1516.811157,23.992309,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2335.279541), SetPVarFloat(npcid,"current_target_y", -1516.811157), SetPVarFloat(npcid,"current_target_z", 23.992309);
				case 3: FCNPC_GoTo(npcid,2350.407226,-1532.045288,24.007009,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.407226), SetPVarFloat(npcid,"current_target_y", -1532.045288), SetPVarFloat(npcid,"current_target_z", 24.007009);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2335.345947,-1516.714965,23.992309))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2334.716552,-1492.249389,24.004375,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.716552), SetPVarFloat(npcid,"current_target_y", -1492.249389), SetPVarFloat(npcid,"current_target_z", 24.004375);
				case 1: FCNPC_GoTo(npcid,2334.993164,-1532.036743,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.993164), SetPVarFloat(npcid,"current_target_y", -1532.036743), SetPVarFloat(npcid,"current_target_z", 24.000099);
				case 2: FCNPC_GoTo(npcid,2350.268310,-1516.817993,24.007402,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.268310), SetPVarFloat(npcid,"current_target_y", -1516.817993), SetPVarFloat(npcid,"current_target_z", 24.007402);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2334.891113,-1532.117919,24.000099))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2335.202636,-1516.836791,23.992309,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2335.202636), SetPVarFloat(npcid,"current_target_y", -1516.836791), SetPVarFloat(npcid,"current_target_z", 23.992309);
				case 1: FCNPC_GoTo(npcid,2334.719970,-1475.377319,23.999902,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.719970), SetPVarFloat(npcid,"current_target_y", -1475.377319), SetPVarFloat(npcid,"current_target_z", 23.999902);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2350.347900,-1532.001953,24.007217))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2334.849365,-1532.099975,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.849365), SetPVarFloat(npcid,"current_target_y", -1532.099975), SetPVarFloat(npcid,"current_target_z", 24.000099);
				case 1: FCNPC_GoTo(npcid,2350.257812,-1516.395996,24.005788,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.257812), SetPVarFloat(npcid,"current_target_y", -1516.395996), SetPVarFloat(npcid,"current_target_z", 24.005788);
				case 2: FCNPC_GoTo(npcid,2380.641601,-1532.360839,23.992305,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2380.641601), SetPVarFloat(npcid,"current_target_y", -1532.360839), SetPVarFloat(npcid,"current_target_z", 23.992305);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2380.641601,-1532.360839,23.992305))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2350.401855,-1531.991699,24.007148,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.401855), SetPVarFloat(npcid,"current_target_y", -1531.991699), SetPVarFloat(npcid,"current_target_z", 24.007148);
				case 1: FCNPC_GoTo(npcid,2383.635253,-1516.154785,23.994777,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2383.635253), SetPVarFloat(npcid,"current_target_y", -1516.154785), SetPVarFloat(npcid,"current_target_z", 23.994777);
				case 2: FCNPC_GoTo(npcid,2406.789550,-1531.828125,23.992305,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.789550), SetPVarFloat(npcid,"current_target_y", -1531.828125), SetPVarFloat(npcid,"current_target_z", 23.992305);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2406.789550,-1531.828125,23.992305))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2380.603759,-1532.228881,23.992305,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2380.603759), SetPVarFloat(npcid,"current_target_y", -1532.228881), SetPVarFloat(npcid,"current_target_z", 23.992305);
				case 1: FCNPC_GoTo(npcid,2407.050781,-1516.886962,23.999097,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2407.050781), SetPVarFloat(npcid,"current_target_y", -1516.886962), SetPVarFloat(npcid,"current_target_z", 23.999097);
				case 2: FCNPC_GoTo(npcid,2423.479248,-1532.110717,24.004402,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.479248), SetPVarFloat(npcid,"current_target_y", -1532.110717), SetPVarFloat(npcid,"current_target_z", 24.004402);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2423.479248,-1532.110717,24.004402))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2406.830078,-1531.791748,23.992305,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.830078), SetPVarFloat(npcid,"current_target_y", -1531.791748), SetPVarFloat(npcid,"current_target_z", 23.992305);
				case 1: FCNPC_GoTo(npcid,2380.775390,-1532.173950,23.992305,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2380.775390), SetPVarFloat(npcid,"current_target_y", -1532.173950), SetPVarFloat(npcid,"current_target_z", 23.992305);
				case 2: FCNPC_GoTo(npcid,2438.017578,-1532.084716,24.000099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.017578), SetPVarFloat(npcid,"current_target_y", -1532.084716), SetPVarFloat(npcid,"current_target_z", 24.000099);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2438.017578,-1532.084716,24.000099))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2423.349853,-1532.169555,24.003984,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.349853), SetPVarFloat(npcid,"current_target_y", -1532.169555), SetPVarFloat(npcid,"current_target_z", 24.003984);
				case 1: FCNPC_GoTo(npcid,2438.967529,-1513.049804,23.992197,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2438.967529), SetPVarFloat(npcid,"current_target_y", -1513.049804), SetPVarFloat(npcid,"current_target_z", 23.992197);
				case 2: FCNPC_GoTo(npcid,2423.717773,-1516.701538,24.008100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2423.717773), SetPVarFloat(npcid,"current_target_y", -1516.701538), SetPVarFloat(npcid,"current_target_z", 24.008100);
			}
		}
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2334.840820,-1493.041625,24.003948))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2335.152832,-1516.851074,23.992309,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2335.152832), SetPVarFloat(npcid,"current_target_y", -1516.851074), SetPVarFloat(npcid,"current_target_z", 23.992309);
				case 1: FCNPC_GoTo(npcid,2334.814697,-1475.452514,24.000072,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.814697), SetPVarFloat(npcid,"current_target_y", -1475.452514), SetPVarFloat(npcid,"current_target_z", 24.000072);
	        }
	    }
	}
	if(GetPVarInt(npcid,"grove")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2421.152587,-1756.352050,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2421.114013,-1744.663696,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.114013), SetPVarFloat(npcid,"current_target_y", -1744.663696), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2406.380126,-1756.682006,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.380126), SetPVarFloat(npcid,"current_target_y", -1756.682006), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2406.897949,-1744.616088,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.897949), SetPVarFloat(npcid,"current_target_y", -1744.616088), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2421.124755,-1744.467773,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2421.061035,-1756.209960,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.061035), SetPVarFloat(npcid,"current_target_y", -1756.209960), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2421.286865,-1740.264648,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.286865), SetPVarFloat(npcid,"current_target_y", -1740.264648), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2406.444580,-1739.287231,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.444580), SetPVarFloat(npcid,"current_target_y", -1739.287231), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2421.202392,-1740.098266,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2406.514648,-1739.248657,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.514648), SetPVarFloat(npcid,"current_target_y", -1739.248657), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2421.199951,-1744.357666,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.199951), SetPVarFloat(npcid,"current_target_y", -1744.357666), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2421.169189,-1756.283203,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.169189), SetPVarFloat(npcid,"current_target_y", -1756.283203), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2416.885498,-1724.234497,13.731306,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2416.885498), SetPVarFloat(npcid,"current_target_y", -1724.234497), SetPVarFloat(npcid,"current_target_z", 13.731306);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2416.887207,-1724.197998,13.731383))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2421.194335,-1740.194458,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.194335), SetPVarFloat(npcid,"current_target_y", -1740.194458), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2410.872314,-1723.946655,13.677264,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2410.872314), SetPVarFloat(npcid,"current_target_y", -1723.946655), SetPVarFloat(npcid,"current_target_z", 13.677264);
				case 2: FCNPC_GoTo(npcid,2406.062255,-1724.399414,13.617669,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.062255), SetPVarFloat(npcid,"current_target_y", -1724.399414), SetPVarFloat(npcid,"current_target_z", 13.617669);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2406.444335,-1756.698974,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2420.977783,-1756.404296,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2420.977783), SetPVarFloat(npcid,"current_target_y", -1756.404296), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2406.760009,-1744.754272,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.760009), SetPVarFloat(npcid,"current_target_y", -1744.754272), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2377.510498,-1756.456542,13.542018,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2377.510498), SetPVarFloat(npcid,"current_target_y", -1756.456542), SetPVarFloat(npcid,"current_target_z", 13.542018);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2406.841796,-1744.694213,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2406.378417,-1756.843627,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.378417), SetPVarFloat(npcid,"current_target_y", -1756.843627), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2406.149902,-1724.445190,13.618288,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.149902), SetPVarFloat(npcid,"current_target_y", -1724.445190), SetPVarFloat(npcid,"current_target_z", 13.618288);
				case 2: FCNPC_GoTo(npcid,2421.084960,-1744.453002,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.084960), SetPVarFloat(npcid,"current_target_y", -1744.453002), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2377.135986,-1744.517089,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2377.135986), SetPVarFloat(npcid,"current_target_y", -1744.517089), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2406.389404,-1739.186157,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2406.346435,-1756.812377,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.346435), SetPVarFloat(npcid,"current_target_y", -1756.812377), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2421.104492,-1740.219726,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.104492), SetPVarFloat(npcid,"current_target_y", -1740.219726), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2376.904296,-1738.872802,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2376.904296), SetPVarFloat(npcid,"current_target_y", -1738.872802), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2406.141357,-1724.390869,13.618836,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.141357), SetPVarFloat(npcid,"current_target_y", -1724.390869), SetPVarFloat(npcid,"current_target_z", 13.618836);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2406.141357,-1724.390869,13.618836))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2410.807617,-1723.860595,13.676978,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2410.807617), SetPVarFloat(npcid,"current_target_y", -1723.860595), SetPVarFloat(npcid,"current_target_z", 13.676978);
				case 1: FCNPC_GoTo(npcid,2416.672607,-1724.204833,13.728438,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2416.672607), SetPVarFloat(npcid,"current_target_y", -1724.204833), SetPVarFloat(npcid,"current_target_z", 13.728438);
				case 2: FCNPC_GoTo(npcid,2406.408203,-1739.257690,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.408203), SetPVarFloat(npcid,"current_target_y", -1739.257690), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2376.504394,-1724.656127,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2376.504394), SetPVarFloat(npcid,"current_target_y", -1724.656127), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2410.887451,-1723.916870,13.677550))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2416.980712,-1724.169067,13.732704,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2416.980712), SetPVarFloat(npcid,"current_target_y", -1724.169067), SetPVarFloat(npcid,"current_target_z", 13.732704);
				case 1: FCNPC_GoTo(npcid,2406.280029,-1724.414184,13.620413,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.280029), SetPVarFloat(npcid,"current_target_y", -1724.414184), SetPVarFloat(npcid,"current_target_z", 13.620413);
				case 2: FCNPC_GoTo(npcid,2406.395019,-1739.227905,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.395019), SetPVarFloat(npcid,"current_target_y", -1739.227905), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2409.808349,-1695.856689,13.574965,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2409.808349), SetPVarFloat(npcid,"current_target_y", -1695.856689), SetPVarFloat(npcid,"current_target_z", 13.574965);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2409.808349,-1695.856689,13.574965))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2371.950195,-1695.664062,13.473778,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.950195), SetPVarFloat(npcid,"current_target_y", -1695.664062), SetPVarFloat(npcid,"current_target_z", 13.473778);
				case 1: FCNPC_GoTo(npcid,2350.333251,-1695.790405,13.464787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.333251), SetPVarFloat(npcid,"current_target_y", -1695.790405), SetPVarFloat(npcid,"current_target_z", 13.464787);
				case 2: FCNPC_GoTo(npcid,2410.918701,-1723.740112,13.678647,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2410.918701), SetPVarFloat(npcid,"current_target_y", -1723.740112), SetPVarFloat(npcid,"current_target_z", 13.678647);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2377.517333,-1756.394409,13.541943))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2406.480712,-1756.673950,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.480712), SetPVarFloat(npcid,"current_target_y", -1756.673950), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2377.045410,-1744.367553,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2377.045410), SetPVarFloat(npcid,"current_target_y", -1744.367553), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2371.743896,-1756.990112,13.542670,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.743896), SetPVarFloat(npcid,"current_target_y", -1756.990112), SetPVarFloat(npcid,"current_target_z", 13.542670);
				case 3: FCNPC_GoTo(npcid,2351.412841,-1756.089233,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.412841), SetPVarFloat(npcid,"current_target_y", -1756.089233), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2377.005126,-1744.576416,13.546975))
	    {
	        switch(random(5))
	        {
				case 0: FCNPC_GoTo(npcid,2377.477539,-1756.343017,13.541880,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2377.477539), SetPVarFloat(npcid,"current_target_y", -1756.343017), SetPVarFloat(npcid,"current_target_z", 13.541880);
				case 1: FCNPC_GoTo(npcid,2371.891601,-1744.915893,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.891601), SetPVarFloat(npcid,"current_target_y", -1744.915893), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2351.536621,-1744.945922,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.536621), SetPVarFloat(npcid,"current_target_y", -1744.945922), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2406.758300,-1744.650024,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.758300), SetPVarFloat(npcid,"current_target_y", -1744.650024), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 4: FCNPC_GoTo(npcid,2376.470703,-1724.301269,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2376.470703), SetPVarFloat(npcid,"current_target_y", -1724.301269), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2377.130126,-1738.918823,13.546975))
	    {
	        switch(random(5))
	        {
				case 0: FCNPC_GoTo(npcid,2406.330078,-1739.247680,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.330078), SetPVarFloat(npcid,"current_target_y", -1739.247680), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2377.541259,-1756.482055,13.542050,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2377.541259), SetPVarFloat(npcid,"current_target_y", -1756.482055), SetPVarFloat(npcid,"current_target_z", 13.542050);
				case 2: FCNPC_GoTo(npcid,2376.998779,-1744.632446,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2376.998779), SetPVarFloat(npcid,"current_target_y", -1744.632446), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2351.769287,-1738.910034,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.769287), SetPVarFloat(npcid,"current_target_y", -1738.910034), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 4: FCNPC_GoTo(npcid,2376.464843,-1724.242065,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2376.464843), SetPVarFloat(npcid,"current_target_y", -1724.242065), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2376.446289,-1724.433227,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2371.365478,-1724.693725,13.473967,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.365478), SetPVarFloat(npcid,"current_target_y", -1724.693725), SetPVarFloat(npcid,"current_target_z", 13.473967);
				case 1: FCNPC_GoTo(npcid,2406.148925,-1724.500854,13.617594,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.148925), SetPVarFloat(npcid,"current_target_y", -1724.500854), SetPVarFloat(npcid,"current_target_z", 13.617594);
				case 2: FCNPC_GoTo(npcid,2371.877929,-1739.300048,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.877929), SetPVarFloat(npcid,"current_target_y", -1739.300048), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2371.740234,-1757.024658,13.542713))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2406.386962,-1756.762695,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.386962), SetPVarFloat(npcid,"current_target_y", -1756.762695), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2351.616210,-1756.100830,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.616210), SetPVarFloat(npcid,"current_target_y", -1756.100830), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2371.881591,-1744.871215,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.881591), SetPVarFloat(npcid,"current_target_y", -1744.871215), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2371.881591,-1744.871215,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2406.652587,-1744.626586,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.652587), SetPVarFloat(npcid,"current_target_y", -1744.626586), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2351.529785,-1744.968872,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.529785), SetPVarFloat(npcid,"current_target_y", -1744.968872), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2371.716064,-1757.010864,13.542695,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.716064), SetPVarFloat(npcid,"current_target_y", -1757.010864), SetPVarFloat(npcid,"current_target_z", 13.542695);
				case 3: FCNPC_GoTo(npcid,2371.448974,-1724.537109,13.479095,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.448974), SetPVarFloat(npcid,"current_target_y", -1724.537109), SetPVarFloat(npcid,"current_target_z", 13.479095);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2371.824707,-1739.453857,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2371.771972,-1756.994873,13.542675,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.771972), SetPVarFloat(npcid,"current_target_y", -1756.994873), SetPVarFloat(npcid,"current_target_z", 13.542675);
				case 1: FCNPC_GoTo(npcid,2406.287597,-1739.273315,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.287597), SetPVarFloat(npcid,"current_target_y", -1739.273315), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2351.505615,-1739.062622,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.505615), SetPVarFloat(npcid,"current_target_y", -1739.062622), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2371.519775,-1724.565307,13.478172,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.519775), SetPVarFloat(npcid,"current_target_y", -1724.565307), SetPVarFloat(npcid,"current_target_z", 13.478172);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2371.519775,-1724.565307,13.478172))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2371.882568,-1739.446655,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.882568), SetPVarFloat(npcid,"current_target_y", -1739.446655), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2406.135986,-1724.453613,13.617998,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.135986), SetPVarFloat(npcid,"current_target_y", -1724.453613), SetPVarFloat(npcid,"current_target_z", 13.617998);
				case 2: FCNPC_GoTo(npcid,2351.518066,-1723.889526,13.540369,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.518066), SetPVarFloat(npcid,"current_target_y", -1723.889526), SetPVarFloat(npcid,"current_target_z", 13.540369);
				case 3: FCNPC_GoTo(npcid,2371.882812,-1695.521728,13.471182,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.882812), SetPVarFloat(npcid,"current_target_y", -1695.521728), SetPVarFloat(npcid,"current_target_z", 13.471182);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2371.882812,-1695.521728,13.471182))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2409.794921,-1695.654541,13.557544,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2409.794921), SetPVarFloat(npcid,"current_target_y", -1695.654541), SetPVarFloat(npcid,"current_target_z", 13.557544);
				case 1: FCNPC_GoTo(npcid,2350.319824,-1695.744628,13.464908,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.319824), SetPVarFloat(npcid,"current_target_y", -1695.744628), SetPVarFloat(npcid,"current_target_z", 13.464908);
				case 2: FCNPC_GoTo(npcid,2371.445556,-1724.589965,13.477364,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.445556), SetPVarFloat(npcid,"current_target_y", -1724.589965), SetPVarFloat(npcid,"current_target_z", 13.477364);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2351.525146,-1756.105346,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2371.801757,-1756.950927,13.542622,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.801757), SetPVarFloat(npcid,"current_target_y", -1756.950927), SetPVarFloat(npcid,"current_target_z", 13.542622);
				case 1: FCNPC_GoTo(npcid,2351.658203,-1744.901245,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.658203), SetPVarFloat(npcid,"current_target_y", -1744.901245), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2335.199462,-1756.694946,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2335.199462), SetPVarFloat(npcid,"current_target_y", -1756.694946), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2351.600585,-1745.095825,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2351.479980,-1756.173217,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.479980), SetPVarFloat(npcid,"current_target_y", -1756.173217), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2334.648193,-1745.164794,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.648193), SetPVarFloat(npcid,"current_target_y", -1745.164794), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2371.691162,-1744.872558,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.691162), SetPVarFloat(npcid,"current_target_y", -1744.872558), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2351.311523,-1723.814331,13.540309,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.311523), SetPVarFloat(npcid,"current_target_y", -1723.814331), SetPVarFloat(npcid,"current_target_z", 13.540309);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2351.820800,-1738.989624,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2351.614501,-1744.995239,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.614501), SetPVarFloat(npcid,"current_target_y", -1744.995239), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2371.845214,-1739.317749,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.845214), SetPVarFloat(npcid,"current_target_y", -1739.317749), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2334.305419,-1739.002441,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.305419), SetPVarFloat(npcid,"current_target_y", -1739.002441), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2351.324218,-1723.845581,13.540281,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.324218), SetPVarFloat(npcid,"current_target_y", -1723.845581), SetPVarFloat(npcid,"current_target_z", 13.540281);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2351.324218,-1723.845581,13.540281))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2371.595947,-1724.653076,13.475298,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.595947), SetPVarFloat(npcid,"current_target_y", -1724.653076), SetPVarFloat(npcid,"current_target_z", 13.475298);
				case 1: FCNPC_GoTo(npcid,2351.777587,-1738.878295,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.777587), SetPVarFloat(npcid,"current_target_y", -1738.878295), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2334.031982,-1723.975585,13.538571,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.031982), SetPVarFloat(npcid,"current_target_y", -1723.975585), SetPVarFloat(npcid,"current_target_z", 13.538571);
				case 3: FCNPC_GoTo(npcid,2350.414794,-1695.752197,13.459259,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.414794), SetPVarFloat(npcid,"current_target_y", -1695.752197), SetPVarFloat(npcid,"current_target_z", 13.459259);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2350.414794,-1695.752197,13.459259))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2371.757568,-1695.675292,13.472484,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2371.757568), SetPVarFloat(npcid,"current_target_y", -1695.675292), SetPVarFloat(npcid,"current_target_z", 13.472484);
				case 1: FCNPC_GoTo(npcid,2351.434570,-1723.767333,13.540457,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.434570), SetPVarFloat(npcid,"current_target_y", -1723.767333), SetPVarFloat(npcid,"current_target_z", 13.540457);
				case 2: FCNPC_GoTo(npcid,2334.627929,-1696.113037,13.450198,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.627929), SetPVarFloat(npcid,"current_target_y", -1696.113037), SetPVarFloat(npcid,"current_target_z", 13.450198);
				case 3: FCNPC_GoTo(npcid,2334.246582,-1667.254882,13.615392,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.246582), SetPVarFloat(npcid,"current_target_y", -1667.254882), SetPVarFloat(npcid,"current_target_z", 13.615392);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2335.104248,-1756.529296,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2351.495605,-1756.651733,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.495605), SetPVarFloat(npcid,"current_target_y", -1756.651733), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2320.333007,-1756.555908,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2320.333007), SetPVarFloat(npcid,"current_target_y", -1756.555908), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2334.565429,-1745.021484,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.565429), SetPVarFloat(npcid,"current_target_y", -1745.021484), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2334.565429,-1745.021484,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2335.173339,-1756.521240,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2335.173339), SetPVarFloat(npcid,"current_target_y", -1756.521240), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2320.767333,-1742.230102,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2320.767333), SetPVarFloat(npcid,"current_target_y", -1742.230102), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2351.474365,-1744.966064,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.474365), SetPVarFloat(npcid,"current_target_y", -1744.966064), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2334.272949,-1724.082885,13.538264,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.272949), SetPVarFloat(npcid,"current_target_y", -1724.082885), SetPVarFloat(npcid,"current_target_z", 13.538264);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2334.344970,-1739.076538,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2351.558349,-1738.954833,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.558349), SetPVarFloat(npcid,"current_target_y", -1738.954833), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2335.067626,-1756.280151,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2335.067626), SetPVarFloat(npcid,"current_target_y", -1756.280151), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2320.773193,-1742.230957,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2320.773193), SetPVarFloat(npcid,"current_target_y", -1742.230957), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2334.399414,-1723.976562,13.535958,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.399414), SetPVarFloat(npcid,"current_target_y", -1723.976562), SetPVarFloat(npcid,"current_target_z", 13.535958);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2334.399414,-1723.976562,13.535958))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2334.373046,-1738.968994,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.373046), SetPVarFloat(npcid,"current_target_y", -1738.968994), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2351.404541,-1723.923095,13.540245,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2351.404541), SetPVarFloat(npcid,"current_target_y", -1723.923095), SetPVarFloat(npcid,"current_target_z", 13.540245);
				case 2: FCNPC_GoTo(npcid,2319.517578,-1724.018432,13.496075,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2319.517578), SetPVarFloat(npcid,"current_target_y", -1724.018432), SetPVarFloat(npcid,"current_target_z", 13.496075);
				case 3: FCNPC_GoTo(npcid,2334.676269,-1696.186767,13.454369,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.676269), SetPVarFloat(npcid,"current_target_y", -1696.186767), SetPVarFloat(npcid,"current_target_z", 13.454369);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2334.527832,-1696.139892,13.444546))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2334.285400,-1724.009033,13.538345,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.285400), SetPVarFloat(npcid,"current_target_y", -1724.009033), SetPVarFloat(npcid,"current_target_z", 13.538345);
				case 1: FCNPC_GoTo(npcid,2350.286865,-1695.710571,13.466391,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.286865), SetPVarFloat(npcid,"current_target_y", -1695.710571), SetPVarFloat(npcid,"current_target_z", 13.466391);
				case 2: FCNPC_GoTo(npcid,2334.539306,-1667.208007,13.606846,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.539306), SetPVarFloat(npcid,"current_target_y", -1667.208007), SetPVarFloat(npcid,"current_target_z", 13.606846);
				case 3: FCNPC_GoTo(npcid,2296.372558,-1695.477050,13.510393,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.372558), SetPVarFloat(npcid,"current_target_y", -1695.477050), SetPVarFloat(npcid,"current_target_z", 13.510393);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2334.310791,-1667.210693,13.613448))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2334.695312,-1696.156250,13.455021,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.695312), SetPVarFloat(npcid,"current_target_y", -1696.156250), SetPVarFloat(npcid,"current_target_z", 13.455021);
				case 1: FCNPC_GoTo(npcid,2350.425781,-1695.677490,13.457460,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.425781), SetPVarFloat(npcid,"current_target_y", -1695.677490), SetPVarFloat(npcid,"current_target_z", 13.457460);
				case 2: FCNPC_GoTo(npcid,2325.111816,-1650.348510,13.889121,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2325.111816), SetPVarFloat(npcid,"current_target_y", -1650.348510), SetPVarFloat(npcid,"current_target_z", 13.889121);
				case 3: FCNPC_GoTo(npcid,2325.122314,-1666.453002,13.946190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2325.122314), SetPVarFloat(npcid,"current_target_y", -1666.453002), SetPVarFloat(npcid,"current_target_z", 13.946190);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2320.576660,-1756.552124,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2335.169189,-1756.370117,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2335.169189), SetPVarFloat(npcid,"current_target_y", -1756.370117), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2305.742431,-1756.700317,13.622200,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.742431), SetPVarFloat(npcid,"current_target_y", -1756.700317), SetPVarFloat(npcid,"current_target_z", 13.622200);
				case 2: FCNPC_GoTo(npcid,2320.706542,-1742.305786,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2320.706542), SetPVarFloat(npcid,"current_target_y", -1742.305786), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2320.706542,-1742.305786,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2334.664306,-1745.360473,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.664306), SetPVarFloat(npcid,"current_target_y", -1745.360473), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2334.289794,-1738.788940,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.289794), SetPVarFloat(npcid,"current_target_y", -1738.788940), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2320.605468,-1756.405639,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2320.605468), SetPVarFloat(npcid,"current_target_y", -1756.405639), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2319.309326,-1724.055419,13.494865,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2319.309326), SetPVarFloat(npcid,"current_target_y", -1724.055419), SetPVarFloat(npcid,"current_target_z", 13.494865);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2319.441650,-1724.097656,13.493482))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2333.944580,-1723.948974,13.538668,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2333.944580), SetPVarFloat(npcid,"current_target_y", -1723.948974), SetPVarFloat(npcid,"current_target_z", 13.538668);
				case 1: FCNPC_GoTo(npcid,2296.148925,-1724.398803,13.483623,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.148925), SetPVarFloat(npcid,"current_target_y", -1724.398803), SetPVarFloat(npcid,"current_target_z", 13.483623);
				case 2: FCNPC_GoTo(npcid,2320.785888,-1742.279541,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2320.785888), SetPVarFloat(npcid,"current_target_y", -1742.279541), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2305.812011,-1756.614257,13.618644))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2320.881835,-1756.619384,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2320.881835), SetPVarFloat(npcid,"current_target_y", -1756.619384), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2259.854492,-1756.625366,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2259.854492), SetPVarFloat(npcid,"current_target_y", -1756.625366), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2305.326660,-1742.269531,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.326660), SetPVarFloat(npcid,"current_target_y", -1742.269531), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2305.326660,-1742.269531,13.546975))
	    {
	        switch(random(6))
	        {
				case 0: FCNPC_GoTo(npcid,2305.753417,-1756.595336,13.618513,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.753417), SetPVarFloat(npcid,"current_target_y", -1756.595336), SetPVarFloat(npcid,"current_target_z", 13.618513);
				case 1: FCNPC_GoTo(npcid,2320.665771,-1742.277221,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2320.665771), SetPVarFloat(npcid,"current_target_y", -1742.277221), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2319.390625,-1723.919921,13.499300,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2319.390625), SetPVarFloat(npcid,"current_target_y", -1723.919921), SetPVarFloat(npcid,"current_target_z", 13.499300);
				case 3: FCNPC_GoTo(npcid,2298.236328,-1739.046875,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2298.236328), SetPVarFloat(npcid,"current_target_y", -1739.046875), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 4: FCNPC_GoTo(npcid,2298.026367,-1745.495239,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2298.026367), SetPVarFloat(npcid,"current_target_y", -1745.495239), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 5: FCNPC_GoTo(npcid,2296.296875,-1724.608276,13.476765,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.296875), SetPVarFloat(npcid,"current_target_y", -1724.608276), SetPVarFloat(npcid,"current_target_z", 13.476765);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2298.047607,-1745.344116,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2305.614990,-1756.476440,13.615663,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.614990), SetPVarFloat(npcid,"current_target_y", -1756.476440), SetPVarFloat(npcid,"current_target_z", 13.615663);
				case 1: FCNPC_GoTo(npcid,2296.259277,-1724.557495,13.478427,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.259277), SetPVarFloat(npcid,"current_target_y", -1724.557495), SetPVarFloat(npcid,"current_target_z", 13.478427);
				case 2: FCNPC_GoTo(npcid,2305.309082,-1742.223510,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.309082), SetPVarFloat(npcid,"current_target_y", -1742.223510), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2298.298828,-1738.832641,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2298.291015,-1745.131958,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2298.291015), SetPVarFloat(npcid,"current_target_y", -1745.131958), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2305.291503,-1742.112304,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.291503), SetPVarFloat(npcid,"current_target_y", -1742.112304), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2296.133789,-1724.636718,13.475833,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.133789), SetPVarFloat(npcid,"current_target_y", -1724.636718), SetPVarFloat(npcid,"current_target_z", 13.475833);
				case 3: FCNPC_GoTo(npcid,2259.217285,-1739.196289,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2259.217285), SetPVarFloat(npcid,"current_target_y", -1739.196289), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2296.263671,-1724.560424,13.478331))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2319.436523,-1723.968017,13.497726,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2319.436523), SetPVarFloat(npcid,"current_target_y", -1723.968017), SetPVarFloat(npcid,"current_target_z", 13.497726);
				case 1: FCNPC_GoTo(npcid,2305.391601,-1742.211547,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.391601), SetPVarFloat(npcid,"current_target_y", -1742.211547), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2258.855224,-1724.199462,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2258.855224), SetPVarFloat(npcid,"current_target_y", -1724.199462), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2296.325683,-1695.254638,13.508097,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.325683), SetPVarFloat(npcid,"current_target_y", -1695.254638), SetPVarFloat(npcid,"current_target_z", 13.508097);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2296.325683,-1695.254638,13.508097))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2296.498046,-1690.072998,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.498046), SetPVarFloat(npcid,"current_target_y", -1690.072998), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2296.229003,-1724.426025,13.482731,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.229003), SetPVarFloat(npcid,"current_target_y", -1724.426025), SetPVarFloat(npcid,"current_target_z", 13.482731);
				case 2: FCNPC_GoTo(npcid,2334.477539,-1695.776000,13.435427,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.477539), SetPVarFloat(npcid,"current_target_y", -1695.776000), SetPVarFloat(npcid,"current_target_z", 13.435427);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2296.490234,-1690.158935,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2296.382568,-1695.352294,13.507810,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.382568), SetPVarFloat(npcid,"current_target_y", -1695.352294), SetPVarFloat(npcid,"current_target_z", 13.507810);
				case 1: FCNPC_GoTo(npcid,2228.140380,-1689.563842,14.006610,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2228.140380), SetPVarFloat(npcid,"current_target_y", -1689.563842), SetPVarFloat(npcid,"current_target_z", 14.006610);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2260.134277,-1756.197875,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2305.718505,-1756.737792,13.623692,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.718505), SetPVarFloat(npcid,"current_target_y", -1756.737792), SetPVarFloat(npcid,"current_target_z", 13.623692);
				case 1: FCNPC_GoTo(npcid,2223.766601,-1757.437377,13.562600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2223.766601), SetPVarFloat(npcid,"current_target_y", -1757.437377), SetPVarFloat(npcid,"current_target_z", 13.562600);
				case 2: FCNPC_GoTo(npcid,2259.594970,-1744.934448,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2259.594970), SetPVarFloat(npcid,"current_target_y", -1744.934448), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2259.594970,-1744.934448,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2298.241210,-1745.424560,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2298.241210), SetPVarFloat(npcid,"current_target_y", -1745.424560), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2259.984375,-1756.253784,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2259.984375), SetPVarFloat(npcid,"current_target_y", -1756.253784), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2258.690185,-1724.486450,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2258.690185), SetPVarFloat(npcid,"current_target_y", -1724.486450), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2259.106201,-1739.093383,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2298.382812,-1739.014038,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2298.382812), SetPVarFloat(npcid,"current_target_y", -1739.014038), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2259.908691,-1756.154418,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2259.908691), SetPVarFloat(npcid,"current_target_y", -1756.154418), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2258.726074,-1724.468139,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2258.726074), SetPVarFloat(npcid,"current_target_y", -1724.468139), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2253.135253,-1742.292724,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2253.135253), SetPVarFloat(npcid,"current_target_y", -1742.292724), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2253.135253,-1742.292724,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2258.710205,-1724.275634,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2258.710205), SetPVarFloat(npcid,"current_target_y", -1724.275634), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2259.165527,-1738.942138,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2259.165527), SetPVarFloat(npcid,"current_target_y", -1738.942138), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2259.366943,-1744.702880,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2259.366943), SetPVarFloat(npcid,"current_target_y", -1744.702880), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2259.905761,-1756.085205,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2259.905761), SetPVarFloat(npcid,"current_target_y", -1756.085205), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2223.823486,-1757.060424,13.562600))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2260.081787,-1756.703857,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2260.081787), SetPVarFloat(npcid,"current_target_y", -1756.703857), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2224.291015,-1742.299316,13.562375,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2224.291015), SetPVarFloat(npcid,"current_target_y", -1742.299316), SetPVarFloat(npcid,"current_target_z", 13.562375);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2224.272705,-1742.194335,13.562427))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2253.266113,-1742.020019,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2253.266113), SetPVarFloat(npcid,"current_target_y", -1742.020019), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2223.754638,-1757.247070,13.562600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2223.754638), SetPVarFloat(npcid,"current_target_y", -1757.247070), SetPVarFloat(npcid,"current_target_z", 13.562600);
				case 2: FCNPC_GoTo(npcid,2224.970947,-1724.100708,13.562600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2224.970947), SetPVarFloat(npcid,"current_target_y", -1724.100708), SetPVarFloat(npcid,"current_target_z", 13.562600);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2224.970947,-1724.100708,13.562600))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2224.364013,-1742.270385,13.562275,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2224.364013), SetPVarFloat(npcid,"current_target_y", -1742.270385), SetPVarFloat(npcid,"current_target_z", 13.562275);
				case 1: FCNPC_GoTo(npcid,2258.778564,-1724.393066,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2258.778564), SetPVarFloat(npcid,"current_target_y", -1724.393066), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2226.799316,-1699.678100,13.754001,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2226.799316), SetPVarFloat(npcid,"current_target_y", -1699.678100), SetPVarFloat(npcid,"current_target_z", 13.754001);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2226.859130,-1699.647094,13.754478))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2224.971191,-1724.107299,13.562600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2224.971191), SetPVarFloat(npcid,"current_target_y", -1724.107299), SetPVarFloat(npcid,"current_target_z", 13.562600);
				case 1: FCNPC_GoTo(npcid,2228.098144,-1689.584838,14.005461,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2228.098144), SetPVarFloat(npcid,"current_target_y", -1689.584838), SetPVarFloat(npcid,"current_target_z", 14.005461);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2228.098144,-1689.584838,14.005461))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2296.547851,-1690.121215,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.547851), SetPVarFloat(npcid,"current_target_y", -1690.121215), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2226.900390,-1699.653442,13.754380,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2226.900390), SetPVarFloat(npcid,"current_target_y", -1699.653442), SetPVarFloat(npcid,"current_target_z", 13.754380);
				case 2: FCNPC_GoTo(npcid,2235.151855,-1661.791137,15.476662,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2235.151855), SetPVarFloat(npcid,"current_target_y", -1661.791137), SetPVarFloat(npcid,"current_target_z", 15.476662);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2235.041259,-1661.811767,15.476662))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2228.111083,-1689.537353,14.008021,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2228.111083), SetPVarFloat(npcid,"current_target_y", -1689.537353), SetPVarFloat(npcid,"current_target_z", 14.008021);
				case 1: FCNPC_GoTo(npcid,2239.776123,-1662.443725,15.476662,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2239.776123), SetPVarFloat(npcid,"current_target_y", -1662.443725), SetPVarFloat(npcid,"current_target_z", 15.476662);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2239.776123,-1662.443725,15.476662))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2235.077148,-1661.795166,15.476662,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2235.077148), SetPVarFloat(npcid,"current_target_y", -1661.795166), SetPVarFloat(npcid,"current_target_z", 15.476662);
				case 1: FCNPC_GoTo(npcid,2243.316162,-1646.666870,15.479201,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2243.316162), SetPVarFloat(npcid,"current_target_y", -1646.666870), SetPVarFloat(npcid,"current_target_z", 15.479201);
				case 2: FCNPC_GoTo(npcid,2254.257812,-1666.452636,15.469103,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2254.257812), SetPVarFloat(npcid,"current_target_y", -1666.452636), SetPVarFloat(npcid,"current_target_z", 15.469103);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2243.078369,-1646.483886,15.479259))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2239.965332,-1662.400878,15.476662,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2239.965332), SetPVarFloat(npcid,"current_target_y", -1662.400878), SetPVarFloat(npcid,"current_target_z", 15.476662);
				case 1: FCNPC_GoTo(npcid,2256.432617,-1650.595092,15.475997,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2256.432617), SetPVarFloat(npcid,"current_target_y", -1650.595092), SetPVarFloat(npcid,"current_target_z", 15.475997);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2254.273193,-1666.510620,15.469103))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2239.917480,-1662.531982,15.476662,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2239.917480), SetPVarFloat(npcid,"current_target_y", -1662.531982), SetPVarFloat(npcid,"current_target_z", 15.476662);
				case 1: FCNPC_GoTo(npcid,2256.489257,-1650.876708,15.475983,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2256.489257), SetPVarFloat(npcid,"current_target_y", -1650.876708), SetPVarFloat(npcid,"current_target_z", 15.475983);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2256.489257,-1650.876708,15.475983))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2243.136962,-1646.545898,15.479245,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2243.136962), SetPVarFloat(npcid,"current_target_y", -1646.545898), SetPVarFloat(npcid,"current_target_z", 15.479245);
				case 1: FCNPC_GoTo(npcid,2254.333740,-1666.314208,15.469103,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2254.333740), SetPVarFloat(npcid,"current_target_y", -1666.314208), SetPVarFloat(npcid,"current_target_z", 15.469103);
				case 2: FCNPC_GoTo(npcid,2271.562011,-1650.836547,15.307945,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2271.562011), SetPVarFloat(npcid,"current_target_y", -1650.836547), SetPVarFloat(npcid,"current_target_z", 15.307945);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2271.808837,-1651.013916,15.299630))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2256.361572,-1650.762817,15.476015,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2256.361572), SetPVarFloat(npcid,"current_target_y", -1650.762817), SetPVarFloat(npcid,"current_target_z", 15.476015);
				case 1: FCNPC_GoTo(npcid,2275.055419,-1666.910034,15.330854,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2275.055419), SetPVarFloat(npcid,"current_target_y", -1666.910034), SetPVarFloat(npcid,"current_target_z", 15.330854);
				case 2: FCNPC_GoTo(npcid,2296.955566,-1651.086059,14.787962,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.955566), SetPVarFloat(npcid,"current_target_y", -1651.086059), SetPVarFloat(npcid,"current_target_z", 14.787962);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2275.081298,-1666.661376,15.330657))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2254.201660,-1666.432861,15.469103,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2254.201660), SetPVarFloat(npcid,"current_target_y", -1666.432861), SetPVarFloat(npcid,"current_target_z", 15.469103);
				case 1: FCNPC_GoTo(npcid,2271.715820,-1650.843750,15.306904,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2271.715820), SetPVarFloat(npcid,"current_target_y", -1650.843750), SetPVarFloat(npcid,"current_target_z", 15.306904);
				case 2: FCNPC_GoTo(npcid,2297.435302,-1666.803710,14.835536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2297.435302), SetPVarFloat(npcid,"current_target_y", -1666.803710), SetPVarFloat(npcid,"current_target_z", 14.835536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2297.435302,-1666.803710,14.835536))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2275.079833,-1666.923950,15.330669,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2275.079833), SetPVarFloat(npcid,"current_target_y", -1666.923950), SetPVarFloat(npcid,"current_target_z", 15.330669);
				case 1: FCNPC_GoTo(npcid,2296.843017,-1650.906372,14.789296,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.843017), SetPVarFloat(npcid,"current_target_y", -1650.906372), SetPVarFloat(npcid,"current_target_z", 14.789296);
				case 2: FCNPC_GoTo(npcid,2324.944335,-1666.913452,13.952582,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2324.944335), SetPVarFloat(npcid,"current_target_y", -1666.913452), SetPVarFloat(npcid,"current_target_z", 13.952582);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2296.867187,-1650.931884,14.788776))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2271.720703,-1650.837646,15.307126,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2271.720703), SetPVarFloat(npcid,"current_target_y", -1650.837646), SetPVarFloat(npcid,"current_target_z", 15.307126);
				case 1: FCNPC_GoTo(npcid,2297.351074,-1666.845825,14.838067,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2297.351074), SetPVarFloat(npcid,"current_target_y", -1666.845825), SetPVarFloat(npcid,"current_target_z", 14.838067);
				case 2: FCNPC_GoTo(npcid,2325.101562,-1650.779418,13.874503,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2325.101562), SetPVarFloat(npcid,"current_target_y", -1650.779418), SetPVarFloat(npcid,"current_target_z", 13.874503);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2325.039550,-1650.115478,13.900451))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2325.070068,-1666.836914,13.948066,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2325.070068), SetPVarFloat(npcid,"current_target_y", -1666.836914), SetPVarFloat(npcid,"current_target_z", 13.948066);
				case 1: FCNPC_GoTo(npcid,2296.789550,-1651.029296,14.793645,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.789550), SetPVarFloat(npcid,"current_target_y", -1651.029296), SetPVarFloat(npcid,"current_target_z", 14.793645);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2324.990722,-1666.649047,13.950916))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2324.975585,-1650.395141,13.893486,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2324.975585), SetPVarFloat(npcid,"current_target_y", -1650.395141), SetPVarFloat(npcid,"current_target_z", 13.893486);
				case 1: FCNPC_GoTo(npcid,2297.559814,-1666.747314,14.831795,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2297.559814), SetPVarFloat(npcid,"current_target_y", -1666.747314), SetPVarFloat(npcid,"current_target_z", 14.831795);
				case 2: FCNPC_GoTo(npcid,2334.124023,-1667.170532,13.615393,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.124023), SetPVarFloat(npcid,"current_target_y", -1667.170532), SetPVarFloat(npcid,"current_target_z", 13.615393);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2258.750000,-1724.263671,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2296.153076,-1724.647094,13.475494,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.153076), SetPVarFloat(npcid,"current_target_y", -1724.647094), SetPVarFloat(npcid,"current_target_z", 13.475494);
				case 1: FCNPC_GoTo(npcid,2259.216796,-1739.177124,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2259.216796), SetPVarFloat(npcid,"current_target_y", -1739.177124), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2224.979980,-1724.096557,13.562600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2224.979980), SetPVarFloat(npcid,"current_target_y", -1724.096557), SetPVarFloat(npcid,"current_target_z", 13.562600);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2351.038085,-1666.909057,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2334.242187,-1667.323364,13.616964,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2334.242187), SetPVarFloat(npcid,"current_target_y", -1667.323364), SetPVarFloat(npcid,"current_target_z", 13.616964);
				case 1: FCNPC_GoTo(npcid,2350.306640,-1695.619018,13.463802,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2350.306640), SetPVarFloat(npcid,"current_target_y", -1695.619018), SetPVarFloat(npcid,"current_target_z", 13.463802);
	        }
	    }
	}
	if(GetPVarInt(npcid,"glenpark")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2079.439208,-1130.639404,23.903121))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2058.765869,-1127.999389,23.898536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2058.765869), SetPVarFloat(npcid,"current_target_y", -1127.999389), SetPVarFloat(npcid,"current_target_z", 23.898536);
				case 1: FCNPC_GoTo(npcid,2079.892333,-1143.958618,23.903804,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.892333), SetPVarFloat(npcid,"current_target_y", -1143.958618), SetPVarFloat(npcid,"current_target_z", 23.903804);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2058.705566,-1127.985595,23.898536))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2079.283203,-1130.610717,23.902997,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.283203), SetPVarFloat(npcid,"current_target_y", -1130.610717), SetPVarFloat(npcid,"current_target_z", 23.902997);
				case 1: FCNPC_GoTo(npcid,2058.760009,-1143.761474,23.898536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2058.760009), SetPVarFloat(npcid,"current_target_y", -1143.761474), SetPVarFloat(npcid,"current_target_z", 23.898536);
				case 2: FCNPC_GoTo(npcid,2034.898315,-1128.467285,24.520898,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2034.898315), SetPVarFloat(npcid,"current_target_y", -1128.467285), SetPVarFloat(npcid,"current_target_z", 24.520898);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2034.898315,-1128.467285,24.520898))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2058.534667,-1128.049804,23.898536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2058.534667), SetPVarFloat(npcid,"current_target_y", -1128.049804), SetPVarFloat(npcid,"current_target_z", 23.898536);
				case 1: FCNPC_GoTo(npcid,2034.513427,-1143.409790,24.531173,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2034.513427), SetPVarFloat(npcid,"current_target_y", -1143.409790), SetPVarFloat(npcid,"current_target_z", 24.531173);
				case 2: FCNPC_GoTo(npcid,2005.668579,-1128.485229,25.353086,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2005.668579), SetPVarFloat(npcid,"current_target_y", -1128.485229), SetPVarFloat(npcid,"current_target_z", 25.353086);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2005.668579,-1128.485229,25.353086))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2034.787109,-1128.520385,24.523990,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2034.787109), SetPVarFloat(npcid,"current_target_y", -1128.520385), SetPVarFloat(npcid,"current_target_z", 24.523990);
				case 1: FCNPC_GoTo(npcid,2005.518188,-1143.206298,25.346824,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2005.518188), SetPVarFloat(npcid,"current_target_y", -1143.206298), SetPVarFloat(npcid,"current_target_z", 25.346824);
				case 2: FCNPC_GoTo(npcid,1978.891113,-1128.527709,25.980772,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1978.891113), SetPVarFloat(npcid,"current_target_y", -1128.527709), SetPVarFloat(npcid,"current_target_z", 25.980772);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1978.891113,-1128.527709,25.980772))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2005.460693,-1128.600830,25.358186,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2005.460693), SetPVarFloat(npcid,"current_target_y", -1128.600830), SetPVarFloat(npcid,"current_target_z", 25.358186);
				case 1: FCNPC_GoTo(npcid,1978.205688,-1143.064941,25.980806,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1978.205688), SetPVarFloat(npcid,"current_target_y", -1143.064941), SetPVarFloat(npcid,"current_target_z", 25.980806);
				case 2: FCNPC_GoTo(npcid,1962.866821,-1128.215576,25.976558,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1962.866821), SetPVarFloat(npcid,"current_target_y", -1128.215576), SetPVarFloat(npcid,"current_target_z", 25.976558);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1962.866821,-1128.215576,25.976558))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1978.801269,-1128.481933,25.980730,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1978.801269), SetPVarFloat(npcid,"current_target_y", -1128.481933), SetPVarFloat(npcid,"current_target_z", 25.980730);
				case 1: FCNPC_GoTo(npcid,1962.404052,-1143.101562,25.974290,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1962.404052), SetPVarFloat(npcid,"current_target_y", -1143.101562), SetPVarFloat(npcid,"current_target_z", 25.974290);
				case 2: FCNPC_GoTo(npcid,1909.600585,-1128.103149,24.721105,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1909.600585), SetPVarFloat(npcid,"current_target_y", -1128.103149), SetPVarFloat(npcid,"current_target_z", 24.721105);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1909.600585,-1128.103149,24.721105))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1962.815673,-1128.262939,25.976520,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1962.815673), SetPVarFloat(npcid,"current_target_y", -1128.262939), SetPVarFloat(npcid,"current_target_z", 25.976520);
				case 1: FCNPC_GoTo(npcid,1909.264648,-1142.552856,24.713119,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1909.264648), SetPVarFloat(npcid,"current_target_y", -1142.552856), SetPVarFloat(npcid,"current_target_z", 24.713119);
				case 2: FCNPC_GoTo(npcid,1874.967163,-1128.153076,23.905839,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1874.967163), SetPVarFloat(npcid,"current_target_y", -1128.153076), SetPVarFloat(npcid,"current_target_z", 23.905839);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1874.967163,-1128.153076,23.905839))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1909.661621,-1128.167968,24.722629,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1909.661621), SetPVarFloat(npcid,"current_target_y", -1128.167968), SetPVarFloat(npcid,"current_target_z", 24.722629);
				case 1: FCNPC_GoTo(npcid,1874.471435,-1144.194946,23.898536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1874.471435), SetPVarFloat(npcid,"current_target_y", -1144.194946), SetPVarFloat(npcid,"current_target_z", 23.898536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2079.772216,-1144.029174,23.903842))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2079.540283,-1130.513427,23.903343,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.540283), SetPVarFloat(npcid,"current_target_y", -1130.513427), SetPVarFloat(npcid,"current_target_z", 23.903343);
				case 1: FCNPC_GoTo(npcid,2079.176757,-1186.998901,23.821058,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.176757), SetPVarFloat(npcid,"current_target_y", -1186.998901), SetPVarFloat(npcid,"current_target_z", 23.821058);
				case 2: FCNPC_GoTo(npcid,2058.718017,-1143.660156,23.898536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2058.718017), SetPVarFloat(npcid,"current_target_y", -1143.660156), SetPVarFloat(npcid,"current_target_z", 23.898536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2058.718017,-1143.660156,23.898536))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2058.669433,-1127.930053,23.898536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2058.669433), SetPVarFloat(npcid,"current_target_y", -1127.930053), SetPVarFloat(npcid,"current_target_z", 23.898536);
				case 1: FCNPC_GoTo(npcid,2079.865478,-1144.044921,23.903881,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.865478), SetPVarFloat(npcid,"current_target_y", -1144.044921), SetPVarFloat(npcid,"current_target_z", 23.903881);
				case 2: FCNPC_GoTo(npcid,2059.116210,-1188.476562,23.832458,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2059.116210), SetPVarFloat(npcid,"current_target_y", -1188.476562), SetPVarFloat(npcid,"current_target_z", 23.832458);
				case 3: FCNPC_GoTo(npcid,2034.484619,-1143.355102,24.531976,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2034.484619), SetPVarFloat(npcid,"current_target_y", -1143.355102), SetPVarFloat(npcid,"current_target_z", 24.531976);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2034.484619,-1143.355102,24.531976))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2034.742797,-1128.725952,24.525222,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2034.742797), SetPVarFloat(npcid,"current_target_y", -1128.725952), SetPVarFloat(npcid,"current_target_z", 24.525222);
				case 1: FCNPC_GoTo(npcid,2058.761230,-1143.621582,23.898536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2058.761230), SetPVarFloat(npcid,"current_target_y", -1143.621582), SetPVarFloat(npcid,"current_target_z", 23.898536);
				case 2: FCNPC_GoTo(npcid,2005.610351,-1143.095947,25.344266,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2005.610351), SetPVarFloat(npcid,"current_target_y", -1143.095947), SetPVarFloat(npcid,"current_target_z", 25.344266);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2005.511840,-1143.141479,25.347021))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2034.583740,-1143.403076,24.529214,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2034.583740), SetPVarFloat(npcid,"current_target_y", -1143.403076), SetPVarFloat(npcid,"current_target_z", 24.529214);
				case 1: FCNPC_GoTo(npcid,2005.488159,-1128.704223,25.356756,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2005.488159), SetPVarFloat(npcid,"current_target_y", -1128.704223), SetPVarFloat(npcid,"current_target_z", 25.356756);
				case 2: FCNPC_GoTo(npcid,1978.457519,-1143.124389,25.981395,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1978.457519), SetPVarFloat(npcid,"current_target_y", -1143.124389), SetPVarFloat(npcid,"current_target_z", 25.981395);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1978.457519,-1143.124389,25.981395))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2005.402832,-1143.108520,25.350091,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2005.402832), SetPVarFloat(npcid,"current_target_y", -1143.108520), SetPVarFloat(npcid,"current_target_z", 25.350091);
				case 1: FCNPC_GoTo(npcid,1978.746215,-1128.492187,25.980609,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1978.746215), SetPVarFloat(npcid,"current_target_y", -1128.492187), SetPVarFloat(npcid,"current_target_z", 25.980609);
				case 2: FCNPC_GoTo(npcid,1962.556030,-1143.118530,25.974071,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1962.556030), SetPVarFloat(npcid,"current_target_y", -1143.118530), SetPVarFloat(npcid,"current_target_z", 25.974071);
				case 3: FCNPC_GoTo(npcid,1975.808959,-1165.218872,26.087980,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1975.808959), SetPVarFloat(npcid,"current_target_y", -1165.218872), SetPVarFloat(npcid,"current_target_z", 26.087980);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1962.444580,-1143.084838,25.974180))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1978.339477,-1143.140136,25.981235,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1978.339477), SetPVarFloat(npcid,"current_target_y", -1143.140136), SetPVarFloat(npcid,"current_target_z", 25.981235);
				case 1: FCNPC_GoTo(npcid,1962.876708,-1128.357421,25.976161,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1962.876708), SetPVarFloat(npcid,"current_target_y", -1128.357421), SetPVarFloat(npcid,"current_target_z", 25.976161);
				case 2: FCNPC_GoTo(npcid,1961.522216,-1168.879028,26.115724,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1961.522216), SetPVarFloat(npcid,"current_target_y", -1168.879028), SetPVarFloat(npcid,"current_target_z", 26.115724);
				case 3: FCNPC_GoTo(npcid,1909.399902,-1142.751342,24.716495,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1909.399902), SetPVarFloat(npcid,"current_target_y", -1142.751342), SetPVarFloat(npcid,"current_target_z", 24.716495);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1909.399902,-1142.751342,24.716495))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1962.307373,-1143.161743,25.974603,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1962.307373), SetPVarFloat(npcid,"current_target_y", -1143.161743), SetPVarFloat(npcid,"current_target_z", 25.974603);
				case 1: FCNPC_GoTo(npcid,1909.612792,-1128.071411,24.721410,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1909.612792), SetPVarFloat(npcid,"current_target_y", -1128.071411), SetPVarFloat(npcid,"current_target_z", 24.721410);
				case 2: FCNPC_GoTo(npcid,1874.387084,-1143.827026,23.898536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1874.387084), SetPVarFloat(npcid,"current_target_y", -1143.827026), SetPVarFloat(npcid,"current_target_z", 23.898536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1874.387084,-1143.827026,23.898536))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1909.060424,-1142.886840,24.708040,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1909.060424), SetPVarFloat(npcid,"current_target_y", -1142.886840), SetPVarFloat(npcid,"current_target_z", 24.708040);
				case 1: FCNPC_GoTo(npcid,1874.884765,-1127.831420,23.907630,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1874.884765), SetPVarFloat(npcid,"current_target_y", -1127.831420), SetPVarFloat(npcid,"current_target_z", 23.907630);
				case 2: FCNPC_GoTo(npcid,1874.349975,-1167.737060,23.834569,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1874.349975), SetPVarFloat(npcid,"current_target_y", -1167.737060), SetPVarFloat(npcid,"current_target_z", 23.834569);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1975.662719,-1165.133911,26.087503))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1977.989868,-1142.960693,25.980157,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1977.989868), SetPVarFloat(npcid,"current_target_y", -1142.960693), SetPVarFloat(npcid,"current_target_z", 25.980157);
				case 1: FCNPC_GoTo(npcid,1961.526123,-1169.041503,26.116598,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1961.526123), SetPVarFloat(npcid,"current_target_y", -1169.041503), SetPVarFloat(npcid,"current_target_z", 26.116598);
				case 2: FCNPC_GoTo(npcid,1977.296752,-1195.617309,25.861196,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1977.296752), SetPVarFloat(npcid,"current_target_y", -1195.617309), SetPVarFloat(npcid,"current_target_z", 25.861196);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1977.302856,-1195.617431,25.861188))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1976.180419,-1165.148315,26.087583,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1976.180419), SetPVarFloat(npcid,"current_target_y", -1165.148315), SetPVarFloat(npcid,"current_target_z", 26.087583);
				case 1: FCNPC_GoTo(npcid,1962.093872,-1195.665405,25.870393,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1962.093872), SetPVarFloat(npcid,"current_target_y", -1195.665405), SetPVarFloat(npcid,"current_target_z", 25.870393);
				case 2: FCNPC_GoTo(npcid,1978.432250,-1216.476806,25.340053,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1978.432250), SetPVarFloat(npcid,"current_target_y", -1216.476806), SetPVarFloat(npcid,"current_target_z", 25.340053);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1978.432250,-1216.476806,25.340053))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1977.226928,-1195.653076,25.860767,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1977.226928), SetPVarFloat(npcid,"current_target_y", -1195.653076), SetPVarFloat(npcid,"current_target_z", 25.860767);
				case 1: FCNPC_GoTo(npcid,1964.228881,-1218.996093,25.310331,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1964.228881), SetPVarFloat(npcid,"current_target_y", -1218.996093), SetPVarFloat(npcid,"current_target_z", 25.310331);
				case 2: FCNPC_GoTo(npcid,1983.275024,-1253.035400,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1983.275024), SetPVarFloat(npcid,"current_target_y", -1253.035400), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1961.507080,-1169.041259,26.116596))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1962.323364,-1143.103759,25.974433,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1962.323364), SetPVarFloat(npcid,"current_target_y", -1143.103759), SetPVarFloat(npcid,"current_target_z", 25.974433);
				case 1: FCNPC_GoTo(npcid,1975.783569,-1165.150268,26.087594,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1975.783569), SetPVarFloat(npcid,"current_target_y", -1165.150268), SetPVarFloat(npcid,"current_target_z", 26.087594);
				case 2: FCNPC_GoTo(npcid,1962.043701,-1195.587402,25.871440,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1962.043701), SetPVarFloat(npcid,"current_target_y", -1195.587402), SetPVarFloat(npcid,"current_target_z", 25.871440);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1962.043701,-1195.587402,25.871440))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1961.746704,-1169.159423,26.117231,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1961.746704), SetPVarFloat(npcid,"current_target_y", -1169.159423), SetPVarFloat(npcid,"current_target_z", 26.117231);
				case 1: FCNPC_GoTo(npcid,1977.255615,-1195.603393,25.861412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1977.255615), SetPVarFloat(npcid,"current_target_y", -1195.603393), SetPVarFloat(npcid,"current_target_z", 25.861412);
				case 2: FCNPC_GoTo(npcid,1964.086791,-1219.126586,25.307273,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1964.086791), SetPVarFloat(npcid,"current_target_y", -1219.126586), SetPVarFloat(npcid,"current_target_z", 25.307273);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1964.086791,-1219.126586,25.307273))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1962.132812,-1195.746948,25.869310,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1962.132812), SetPVarFloat(npcid,"current_target_y", -1195.746948), SetPVarFloat(npcid,"current_target_z", 25.869310);
				case 1: FCNPC_GoTo(npcid,1978.551513,-1216.522949,25.338399,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1978.551513), SetPVarFloat(npcid,"current_target_y", -1216.522949), SetPVarFloat(npcid,"current_target_z", 25.338399);
				case 2: FCNPC_GoTo(npcid,1968.340820,-1253.455322,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1968.340820), SetPVarFloat(npcid,"current_target_y", -1253.455322), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2059.083251,-1188.635864,23.826133))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2058.726074,-1143.725341,23.898536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2058.726074), SetPVarFloat(npcid,"current_target_y", -1143.725341), SetPVarFloat(npcid,"current_target_z", 23.898536);
				case 1: FCNPC_GoTo(npcid,2079.220214,-1187.085449,23.821186,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.220214), SetPVarFloat(npcid,"current_target_y", -1187.085449), SetPVarFloat(npcid,"current_target_z", 23.821186);
				case 2: FCNPC_GoTo(npcid,2049.543212,-1188.618408,23.756748,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2049.543212), SetPVarFloat(npcid,"current_target_y", -1188.618408), SetPVarFloat(npcid,"current_target_z", 23.756748);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2079.365234,-1186.891601,23.820901))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2079.929199,-1143.955932,23.903810,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.929199), SetPVarFloat(npcid,"current_target_y", -1143.955932), SetPVarFloat(npcid,"current_target_z", 23.903810);
				case 1: FCNPC_GoTo(npcid,2079.574462,-1212.842529,23.968011,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.574462), SetPVarFloat(npcid,"current_target_y", -1212.842529), SetPVarFloat(npcid,"current_target_z", 23.968011);
				case 2: FCNPC_GoTo(npcid,2059.317626,-1188.559814,23.832416,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2059.317626), SetPVarFloat(npcid,"current_target_y", -1188.559814), SetPVarFloat(npcid,"current_target_z", 23.832416);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2049.538330,-1188.599121,23.757181))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2058.977539,-1188.615478,23.825988,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2058.977539), SetPVarFloat(npcid,"current_target_y", -1188.615478), SetPVarFloat(npcid,"current_target_z", 23.825988);
				case 1: FCNPC_GoTo(npcid,2046.769409,-1205.182983,23.412509,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2046.769409), SetPVarFloat(npcid,"current_target_y", -1205.182983), SetPVarFloat(npcid,"current_target_z", 23.412509);
				case 2: FCNPC_GoTo(npcid,2042.480224,-1176.322753,23.135162,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2042.480224), SetPVarFloat(npcid,"current_target_y", -1176.322753), SetPVarFloat(npcid,"current_target_z", 23.135162);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2046.940917,-1205.116821,23.412864))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2049.446289,-1188.522705,23.760419,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2049.446289), SetPVarFloat(npcid,"current_target_y", -1188.522705), SetPVarFloat(npcid,"current_target_z", 23.760419);
				case 1: FCNPC_GoTo(npcid,2040.952270,-1214.842651,23.017490,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2040.952270), SetPVarFloat(npcid,"current_target_y", -1214.842651), SetPVarFloat(npcid,"current_target_z", 23.017490);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2040.952270,-1214.842651,23.017490))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,2033.401489,-1221.309448,22.540943,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2033.401489), SetPVarFloat(npcid,"current_target_y", -1221.309448), SetPVarFloat(npcid,"current_target_z", 22.540943);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2033.296386,-1221.569702,22.524892))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,2020.914672,-1226.526367,21.864971,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2020.914672), SetPVarFloat(npcid,"current_target_y", -1226.526367), SetPVarFloat(npcid,"current_target_z", 21.864971);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2020.851806,-1226.546752,21.861782))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1999.161865,-1231.230468,20.782333,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1999.161865), SetPVarFloat(npcid,"current_target_y", -1231.230468), SetPVarFloat(npcid,"current_target_z", 20.782333);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1999.161865,-1231.230468,20.782333))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1995.836791,-1217.451049,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1995.836791), SetPVarFloat(npcid,"current_target_y", -1217.451049), SetPVarFloat(npcid,"current_target_z", 20.023536);
				case 1: FCNPC_GoTo(npcid,1965.979736,-1236.145996,20.057003,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1965.979736), SetPVarFloat(npcid,"current_target_y", -1236.145996), SetPVarFloat(npcid,"current_target_z", 20.057003);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1965.979736,-1236.145996,20.057003))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1957.106445,-1236.537231,19.810028,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1957.106445), SetPVarFloat(npcid,"current_target_y", -1236.537231), SetPVarFloat(npcid,"current_target_z", 19.810028);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1957.106445,-1236.537231,19.810028))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1946.458496,-1237.688110,19.105020,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1946.458496), SetPVarFloat(npcid,"current_target_y", -1237.688110), SetPVarFloat(npcid,"current_target_z", 19.105020);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1946.458496,-1237.688110,19.105020))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1924.982055,-1239.225341,17.311143,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1924.982055), SetPVarFloat(npcid,"current_target_y", -1239.225341), SetPVarFloat(npcid,"current_target_z", 17.311143);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1924.982177,-1239.225219,17.311151))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1909.713012,-1238.267944,16.066457,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1909.713012), SetPVarFloat(npcid,"current_target_y", -1238.267944), SetPVarFloat(npcid,"current_target_z", 16.066457);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1909.713012,-1238.267944,16.066457))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1900.042236,-1237.000610,15.455031,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1900.042236), SetPVarFloat(npcid,"current_target_y", -1237.000610), SetPVarFloat(npcid,"current_target_z", 15.455031);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1900.042236,-1237.000610,15.455031))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1894.299682,-1252.991699,13.556337,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1894.299682), SetPVarFloat(npcid,"current_target_y", -1252.991699), SetPVarFloat(npcid,"current_target_z", 13.556337);
				case 1: FCNPC_GoTo(npcid,1890.616821,-1232.616333,15.272900,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1890.616821), SetPVarFloat(npcid,"current_target_y", -1232.616333), SetPVarFloat(npcid,"current_target_z", 15.272900);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1890.575683,-1232.559326,15.276140))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1886.114868,-1226.634155,15.705263,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1886.114868), SetPVarFloat(npcid,"current_target_y", -1226.634155), SetPVarFloat(npcid,"current_target_z", 15.705263);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1886.033569,-1226.550415,15.713225))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1883.478515,-1217.197998,17.212854,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1883.478515), SetPVarFloat(npcid,"current_target_y", -1217.197998), SetPVarFloat(npcid,"current_target_z", 17.212854);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1883.478515,-1217.197998,17.212854))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1886.201660,-1201.865234,20.166479,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1886.201660), SetPVarFloat(npcid,"current_target_y", -1201.865234), SetPVarFloat(npcid,"current_target_z", 20.166479);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1886.201660,-1201.865234,20.166479))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1890.775756,-1189.373168,22.453918,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1890.775756), SetPVarFloat(npcid,"current_target_y", -1189.373168), SetPVarFloat(npcid,"current_target_z", 22.453918);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1890.775756,-1189.373168,22.453918))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1895.843017,-1179.222167,23.824853,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1895.843017), SetPVarFloat(npcid,"current_target_y", -1179.222167), SetPVarFloat(npcid,"current_target_z", 23.824853);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1895.843017,-1179.222167,23.824853))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1872.389160,-1177.463989,23.828224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1872.389160), SetPVarFloat(npcid,"current_target_y", -1177.463989), SetPVarFloat(npcid,"current_target_z", 23.828224);
				case 1: FCNPC_GoTo(npcid,1900.733398,-1171.878051,24.286117,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1900.733398), SetPVarFloat(npcid,"current_target_y", -1171.878051), SetPVarFloat(npcid,"current_target_z", 24.286117);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1900.733398,-1171.878051,24.286117))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1908.966308,-1164.728515,23.902549,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1908.966308), SetPVarFloat(npcid,"current_target_y", -1164.728515), SetPVarFloat(npcid,"current_target_z", 23.902549);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1908.966308,-1164.728515,23.902549))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1922.498901,-1160.058227,22.550436,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1922.498901), SetPVarFloat(npcid,"current_target_y", -1160.058227), SetPVarFloat(npcid,"current_target_z", 22.550436);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1922.490112,-1160.135742,22.550697))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1944.332763,-1157.842041,21.148857,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1944.332763), SetPVarFloat(npcid,"current_target_y", -1157.842041), SetPVarFloat(npcid,"current_target_z", 21.148857);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1944.402709,-1157.839965,21.147829))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1951.697631,-1157.958129,21.033634,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1951.697631), SetPVarFloat(npcid,"current_target_y", -1157.958129), SetPVarFloat(npcid,"current_target_z", 21.033634);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1951.697631,-1157.958129,21.033634))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1951.996582,-1179.121337,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1951.996582), SetPVarFloat(npcid,"current_target_y", -1179.121337), SetPVarFloat(npcid,"current_target_z", 20.023536);
				case 1: FCNPC_GoTo(npcid,1961.402099,-1157.319091,20.963844,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1961.402099), SetPVarFloat(npcid,"current_target_y", -1157.319091), SetPVarFloat(npcid,"current_target_z", 20.963844);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1961.402099,-1157.319091,20.963846))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1989.810302,-1157.144409,20.995679,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1989.810302), SetPVarFloat(npcid,"current_target_y", -1157.144409), SetPVarFloat(npcid,"current_target_z", 20.995679);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1989.810302,-1157.144409,20.995679))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,2003.599609,-1158.311035,21.163507,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2003.599609), SetPVarFloat(npcid,"current_target_y", -1158.311035), SetPVarFloat(npcid,"current_target_z", 21.163507);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2003.599609,-1158.311035,21.163507))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,2016.550537,-1161.560668,21.549364,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2016.550537), SetPVarFloat(npcid,"current_target_y", -1161.560668), SetPVarFloat(npcid,"current_target_z", 21.549364);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2016.550537,-1161.560668,21.549364))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,2027.984863,-1165.478149,22.064552,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2027.984863), SetPVarFloat(npcid,"current_target_y", -1165.478149), SetPVarFloat(npcid,"current_target_z", 22.064552);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2027.984863,-1165.478149,22.064552))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,2042.560302,-1176.528320,23.150321,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2042.560302), SetPVarFloat(npcid,"current_target_y", -1176.528320), SetPVarFloat(npcid,"current_target_z", 23.150321);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2042.560302,-1176.528320,23.150321))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,2049.331542,-1188.618286,23.761196,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2049.331542), SetPVarFloat(npcid,"current_target_y", -1188.618286), SetPVarFloat(npcid,"current_target_z", 23.761196);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1995.882812,-1217.461059,20.023536))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1999.174438,-1231.159667,20.784828,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1999.174438), SetPVarFloat(npcid,"current_target_y", -1231.159667), SetPVarFloat(npcid,"current_target_z", 20.784828);
				case 1: FCNPC_GoTo(npcid,1983.838867,-1221.234985,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1983.838867), SetPVarFloat(npcid,"current_target_y", -1221.234985), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1983.838867,-1221.234985,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1959.869018,-1222.477661,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1959.869018), SetPVarFloat(npcid,"current_target_y", -1222.477661), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1959.869018,-1222.477661,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1943.444702,-1216.502075,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1943.444702), SetPVarFloat(npcid,"current_target_y", -1216.502075), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1943.444702,-1216.502075,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1933.598754,-1210.729003,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1933.598754), SetPVarFloat(npcid,"current_target_y", -1210.729003), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1933.598754,-1210.729003,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1928.075805,-1202.354858,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1928.075805), SetPVarFloat(npcid,"current_target_y", -1202.354858), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1928.075805,-1202.354858,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1928.959472,-1194.848510,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1928.959472), SetPVarFloat(npcid,"current_target_y", -1194.848510), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1928.959472,-1194.848510,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1933.815063,-1188.173706,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1933.815063), SetPVarFloat(npcid,"current_target_y", -1188.173706), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1933.815063,-1188.173706,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1940.865600,-1183.011840,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1940.865600), SetPVarFloat(npcid,"current_target_y", -1183.011840), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1940.865600,-1183.011840,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1952.061035,-1179.149658,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1952.061035), SetPVarFloat(npcid,"current_target_y", -1179.149658), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1952.061035,-1179.149658,20.023536))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1951.351074,-1157.980590,21.037326,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1951.351074), SetPVarFloat(npcid,"current_target_y", -1157.980590), SetPVarFloat(npcid,"current_target_z", 21.037326);
				case 1: FCNPC_GoTo(npcid,1968.348999,-1177.266601,20.030841,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1968.348999), SetPVarFloat(npcid,"current_target_y", -1177.266601), SetPVarFloat(npcid,"current_target_z", 20.030841);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1968.348999,-1177.266601,20.030841))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1978.856567,-1177.334228,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1978.856567), SetPVarFloat(npcid,"current_target_y", -1177.334228), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1978.856567,-1177.334228,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1983.607788,-1177.512084,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1983.607788), SetPVarFloat(npcid,"current_target_y", -1177.512084), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1983.607788,-1177.512084,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1992.929321,-1180.484008,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1992.929321), SetPVarFloat(npcid,"current_target_y", -1180.484008), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1992.929321,-1180.484008,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,2005.342773,-1186.742797,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2005.342773), SetPVarFloat(npcid,"current_target_y", -1186.742797), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2005.342773,-1186.742797,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,2012.268676,-1194.240112,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2012.268676), SetPVarFloat(npcid,"current_target_y", -1194.240112), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2012.268676,-1194.240112,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,2013.294311,-1203.786010,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2013.294311), SetPVarFloat(npcid,"current_target_y", -1203.786010), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2013.294311,-1203.786010,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,2006.596801,-1212.093872,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2006.596801), SetPVarFloat(npcid,"current_target_y", -1212.093872), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2006.534667,-1212.126342,20.023536))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1995.887451,-1217.710449,20.023536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1995.887451), SetPVarFloat(npcid,"current_target_y", -1217.710449), SetPVarFloat(npcid,"current_target_z", 20.023536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2079.614746,-1212.904418,23.968008))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2079.207031,-1186.927246,23.820953,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.207031), SetPVarFloat(npcid,"current_target_y", -1186.927246), SetPVarFloat(npcid,"current_target_z", 23.820953);
				case 1: FCNPC_GoTo(npcid,2079.824462,-1228.524414,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.824462), SetPVarFloat(npcid,"current_target_y", -1228.524414), SetPVarFloat(npcid,"current_target_z", 23.976661);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2079.824462,-1228.524414,23.976661))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2079.632568,-1213.066406,23.968105,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.632568), SetPVarFloat(npcid,"current_target_y", -1213.066406), SetPVarFloat(npcid,"current_target_z", 23.968105);
				case 1: FCNPC_GoTo(npcid,2059.397216,-1233.592163,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2059.397216), SetPVarFloat(npcid,"current_target_y", -1233.592163), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2059.397216,-1233.592163,23.984474))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2059.068115,-1188.810058,23.827365,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2059.068115), SetPVarFloat(npcid,"current_target_y", -1188.810058), SetPVarFloat(npcid,"current_target_z", 23.827365);
				case 1: FCNPC_GoTo(npcid,2079.716308,-1228.561889,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.716308), SetPVarFloat(npcid,"current_target_y", -1228.561889), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 2: FCNPC_GoTo(npcid,2059.239501,-1252.934082,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2059.239501), SetPVarFloat(npcid,"current_target_y", -1252.934082), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2078.624511,-1252.624633,23.980367))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2079.757812,-1228.553833,23.976661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2079.757812), SetPVarFloat(npcid,"current_target_y", -1228.553833), SetPVarFloat(npcid,"current_target_z", 23.976661);
				case 1: FCNPC_GoTo(npcid,2078.971679,-1269.037963,23.981380,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2078.971679), SetPVarFloat(npcid,"current_target_y", -1269.037963), SetPVarFloat(npcid,"current_target_z", 23.981380);
				case 2: FCNPC_GoTo(npcid,2059.353515,-1252.916748,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2059.353515), SetPVarFloat(npcid,"current_target_y", -1252.916748), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2059.268554,-1252.921508,23.984474))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2078.637695,-1252.601074,23.980405,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2078.637695), SetPVarFloat(npcid,"current_target_y", -1252.601074), SetPVarFloat(npcid,"current_target_z", 23.980405);
				case 1: FCNPC_GoTo(npcid,2059.591308,-1233.784667,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2059.591308), SetPVarFloat(npcid,"current_target_y", -1233.784667), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 2: FCNPC_GoTo(npcid,2059.069824,-1268.948852,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2059.069824), SetPVarFloat(npcid,"current_target_y", -1268.948852), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 3: FCNPC_GoTo(npcid,2020.979736,-1253.826293,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2020.979736), SetPVarFloat(npcid,"current_target_y", -1253.826293), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2020.979736,-1253.826293,23.984474))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2059.186035,-1252.906860,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2059.186035), SetPVarFloat(npcid,"current_target_y", -1252.906860), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2021.177368,-1268.339233,23.977954,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2021.177368), SetPVarFloat(npcid,"current_target_y", -1268.339233), SetPVarFloat(npcid,"current_target_z", 23.977954);
				case 2: FCNPC_GoTo(npcid,1983.242431,-1253.236572,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1983.242431), SetPVarFloat(npcid,"current_target_y", -1253.236572), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1983.242431,-1253.236572,23.984474))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2021.116577,-1253.747680,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2021.116577), SetPVarFloat(npcid,"current_target_y", -1253.747680), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,1978.587158,-1216.539794,25.337821,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1978.587158), SetPVarFloat(npcid,"current_target_y", -1216.539794), SetPVarFloat(npcid,"current_target_z", 25.337821);
				case 2: FCNPC_GoTo(npcid,1983.735961,-1268.729248,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1983.735961), SetPVarFloat(npcid,"current_target_y", -1268.729248), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 3: FCNPC_GoTo(npcid,1968.359741,-1253.376586,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1968.359741), SetPVarFloat(npcid,"current_target_y", -1253.376586), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1968.359741,-1253.376586,23.984474))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1983.433837,-1253.292724,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1983.433837), SetPVarFloat(npcid,"current_target_y", -1253.292724), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,1964.175048,-1218.899047,25.313072,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1964.175048), SetPVarFloat(npcid,"current_target_y", -1218.899047), SetPVarFloat(npcid,"current_target_z", 25.313072);
				case 2: FCNPC_GoTo(npcid,1968.065795,-1268.241577,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1968.065795), SetPVarFloat(npcid,"current_target_y", -1268.241577), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 3: FCNPC_GoTo(npcid,1965.741577,-1253.220214,23.934234,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1965.741577), SetPVarFloat(npcid,"current_target_y", -1253.220214), SetPVarFloat(npcid,"current_target_z", 23.934234);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1965.741699,-1253.220092,23.934249))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1968.517578,-1253.275512,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1968.517578), SetPVarFloat(npcid,"current_target_y", -1253.275512), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,1937.611083,-1253.158569,18.968101,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1937.611083), SetPVarFloat(npcid,"current_target_y", -1253.158569), SetPVarFloat(npcid,"current_target_z", 18.968101);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1937.611083,-1253.158569,18.968101))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1919.114013,-1253.130493,15.619818,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1919.114013), SetPVarFloat(npcid,"current_target_y", -1253.130493), SetPVarFloat(npcid,"current_target_z", 15.619818);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1919.114013,-1253.130493,15.619818))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1911.260009,-1253.263793,14.199967,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1911.260009), SetPVarFloat(npcid,"current_target_y", -1253.263793), SetPVarFloat(npcid,"current_target_z", 14.199967);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1911.260009,-1253.263793,14.199967))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1894.406005,-1253.008911,13.556363,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1894.406005), SetPVarFloat(npcid,"current_target_y", -1253.008911), SetPVarFloat(npcid,"current_target_z", 13.556363);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1894.406005,-1253.008911,13.556363))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1899.979003,-1236.936035,15.452120,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1899.979003), SetPVarFloat(npcid,"current_target_y", -1236.936035), SetPVarFloat(npcid,"current_target_z", 15.452120);
				case 1: FCNPC_GoTo(npcid,1888.196533,-1253.781616,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1888.196533), SetPVarFloat(npcid,"current_target_y", -1253.781616), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1888.196533,-1253.781616,13.546975))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1859.895141,-1252.947875,13.565026,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1859.895141), SetPVarFloat(npcid,"current_target_y", -1252.947875), SetPVarFloat(npcid,"current_target_z", 13.565026);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1859.895141,-1252.947875,13.565026))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1859.792846,-1268.442260,13.570460,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1859.792846), SetPVarFloat(npcid,"current_target_y", -1268.442260), SetPVarFloat(npcid,"current_target_z", 13.570460);
				case 1: FCNPC_GoTo(npcid,1859.727050,-1245.935302,14.163075,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1859.727050), SetPVarFloat(npcid,"current_target_y", -1245.935302), SetPVarFloat(npcid,"current_target_z", 14.163075);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1859.727050,-1245.935302,14.163075))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1859.818847,-1226.799926,17.624223,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1859.818847), SetPVarFloat(npcid,"current_target_y", -1226.799926), SetPVarFloat(npcid,"current_target_z", 17.624223);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1859.818847,-1226.799926,17.624223))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1859.689331,-1204.713500,21.608236,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1859.689331), SetPVarFloat(npcid,"current_target_y", -1204.713500), SetPVarFloat(npcid,"current_target_z", 21.608236);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1859.689331,-1204.713500,21.608236))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1859.570922,-1195.781372,23.219564,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1859.570922), SetPVarFloat(npcid,"current_target_y", -1195.781372), SetPVarFloat(npcid,"current_target_z", 23.219564);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1859.570922,-1195.781372,23.219564))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1859.477783,-1188.678710,23.828224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1859.477783), SetPVarFloat(npcid,"current_target_y", -1188.678710), SetPVarFloat(npcid,"current_target_z", 23.828224);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1859.477783,-1188.678710,23.828224))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1869.504150,-1183.312011,23.828224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1869.504150), SetPVarFloat(npcid,"current_target_y", -1183.312011), SetPVarFloat(npcid,"current_target_z", 23.828224);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1869.504150,-1183.312011,23.828224))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1872.450683,-1177.501098,23.828224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1872.450683), SetPVarFloat(npcid,"current_target_y", -1177.501098), SetPVarFloat(npcid,"current_target_z", 23.828224);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1872.489746,-1177.442993,23.828224))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1874.384643,-1167.932373,23.834045,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1874.384643), SetPVarFloat(npcid,"current_target_y", -1167.932373), SetPVarFloat(npcid,"current_target_z", 23.834045);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1874.384643,-1167.932373,23.834045))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1900.840454,-1171.750732,24.293647,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1900.840454), SetPVarFloat(npcid,"current_target_y", -1171.750732), SetPVarFloat(npcid,"current_target_z", 24.293647);
				case 1: FCNPC_GoTo(npcid,1874.440307,-1143.912841,23.898536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1874.440307), SetPVarFloat(npcid,"current_target_y", -1143.912841), SetPVarFloat(npcid,"current_target_z", 23.898536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1859.702026,-1268.633422,13.571274))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1859.999633,-1252.954467,13.565188,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1859.999633), SetPVarFloat(npcid,"current_target_y", -1252.954467), SetPVarFloat(npcid,"current_target_z", 13.565188);
				case 1: FCNPC_GoTo(npcid,1887.426879,-1268.489013,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1887.426879), SetPVarFloat(npcid,"current_target_y", -1268.489013), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1887.426879,-1268.489013,13.546975))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1904.462402,-1268.394165,13.558819,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1904.462402), SetPVarFloat(npcid,"current_target_y", -1268.394165), SetPVarFloat(npcid,"current_target_z", 13.558819);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1904.462402,-1268.394165,13.558819))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1918.545654,-1268.618896,15.517005,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1918.545654), SetPVarFloat(npcid,"current_target_y", -1268.618896), SetPVarFloat(npcid,"current_target_z", 15.517005);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1918.545654,-1268.618896,15.517005))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1930.279663,-1268.348754,17.643714,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1930.279663), SetPVarFloat(npcid,"current_target_y", -1268.348754), SetPVarFloat(npcid,"current_target_z", 17.643714);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1930.279663,-1268.348754,17.643714))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1944.934692,-1268.311645,20.291074,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1944.934692), SetPVarFloat(npcid,"current_target_y", -1268.311645), SetPVarFloat(npcid,"current_target_z", 20.291074);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1944.934692,-1268.311645,20.291074))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1964.957885,-1268.402343,23.825672,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1964.957885), SetPVarFloat(npcid,"current_target_y", -1268.402343), SetPVarFloat(npcid,"current_target_z", 23.825672);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1964.957885,-1268.402343,23.825672))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,1967.997314,-1268.381835,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1967.997314), SetPVarFloat(npcid,"current_target_y", -1268.381835), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1967.997314,-1268.381835,23.984474))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1968.330200,-1253.298461,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1968.330200), SetPVarFloat(npcid,"current_target_y", -1253.298461), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,1968.051879,-1301.683471,23.977708,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1968.051879), SetPVarFloat(npcid,"current_target_y", -1301.683471), SetPVarFloat(npcid,"current_target_z", 23.977708);
				case 2: FCNPC_GoTo(npcid,1983.562500,-1268.672241,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1983.562500), SetPVarFloat(npcid,"current_target_y", -1268.672241), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1983.638427,-1268.606689,23.984474))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1983.381591,-1253.339355,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1983.381591), SetPVarFloat(npcid,"current_target_y", -1253.339355), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2021.241943,-1268.495361,23.977954,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2021.241943), SetPVarFloat(npcid,"current_target_y", -1268.495361), SetPVarFloat(npcid,"current_target_z", 23.977954);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2021.241943,-1268.495361,23.977954))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2021.315551,-1301.611938,23.876882,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2021.315551), SetPVarFloat(npcid,"current_target_y", -1301.611938), SetPVarFloat(npcid,"current_target_z", 23.876882);
				case 1: FCNPC_GoTo(npcid,2020.963256,-1253.720825,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2020.963256), SetPVarFloat(npcid,"current_target_y", -1253.720825), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 2: FCNPC_GoTo(npcid,2058.923339,-1268.865356,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2058.923339), SetPVarFloat(npcid,"current_target_y", -1268.865356), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2058.923339,-1268.865356,23.984474))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2059.194335,-1252.880371,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2059.194335), SetPVarFloat(npcid,"current_target_y", -1252.880371), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2078.881103,-1269.077148,23.981115,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2078.881103), SetPVarFloat(npcid,"current_target_y", -1269.077148), SetPVarFloat(npcid,"current_target_z", 23.981115);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2078.881103,-1269.077148,23.981115))
	    {
	        switch(random(1))
	        {
				case 0: FCNPC_GoTo(npcid,2078.639160,-1252.746093,23.980409,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2078.639160), SetPVarFloat(npcid,"current_target_y", -1252.746093), SetPVarFloat(npcid,"current_target_z", 23.980409);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1968.123046,-1301.606811,23.975990))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1968.222534,-1268.283325,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1968.222534), SetPVarFloat(npcid,"current_target_y", -1268.283325), SetPVarFloat(npcid,"current_target_z", 23.984474);
				case 1: FCNPC_GoTo(npcid,2021.114990,-1301.556518,23.877048,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2021.114990), SetPVarFloat(npcid,"current_target_y", -1301.556518), SetPVarFloat(npcid,"current_target_z", 23.877048);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2021.114990,-1301.556518,23.877048))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2021.273437,-1268.669311,23.977954,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2021.273437), SetPVarFloat(npcid,"current_target_y", -1268.669311), SetPVarFloat(npcid,"current_target_z", 23.977954);
				case 1: FCNPC_GoTo(npcid,1967.575927,-1301.653564,23.984474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1967.575927), SetPVarFloat(npcid,"current_target_y", -1301.653564), SetPVarFloat(npcid,"current_target_z", 23.984474);
	        }
	    }
	}
	if(GetPVarInt(npcid,"vinewood")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,371.334686,-1166.627441,78.290672))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,355.638549,-1181.859375,77.106658,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 355.638549), SetPVarFloat(npcid,"current_target_y", -1181.859375), SetPVarFloat(npcid,"current_target_z", 77.106658);
				case 1: FCNPC_GoTo(npcid,358.295806,-1157.983276,78.193458,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 358.295806), SetPVarFloat(npcid,"current_target_y", -1157.983276), SetPVarFloat(npcid,"current_target_z", 78.193458);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,358.191192,-1157.898437,78.192680))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,345.782684,-1170.179321,77.140663,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 345.782684), SetPVarFloat(npcid,"current_target_y", -1170.179321), SetPVarFloat(npcid,"current_target_z", 77.140663);
				case 1: FCNPC_GoTo(npcid,371.168914,-1166.576782,78.286491,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 371.168914), SetPVarFloat(npcid,"current_target_y", -1166.576782), SetPVarFloat(npcid,"current_target_z", 78.286491);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,355.731964,-1181.696411,77.116760))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,371.145935,-1166.673339,78.281860,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 371.145935), SetPVarFloat(npcid,"current_target_y", -1166.673339), SetPVarFloat(npcid,"current_target_z", 78.281860);
				case 1: FCNPC_GoTo(npcid,345.792114,-1170.167968,77.141548,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 345.792114), SetPVarFloat(npcid,"current_target_y", -1170.167968), SetPVarFloat(npcid,"current_target_z", 77.141548);
				case 2: FCNPC_GoTo(npcid,328.125213,-1204.725341,76.272117,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 328.125213), SetPVarFloat(npcid,"current_target_y", -1204.725341), SetPVarFloat(npcid,"current_target_z", 76.272117);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,345.764526,-1170.060791,77.144653))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,358.226593,-1157.862060,78.195671,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 358.226593), SetPVarFloat(npcid,"current_target_y", -1157.862060), SetPVarFloat(npcid,"current_target_z", 78.195671);
				case 1: FCNPC_GoTo(npcid,355.681854,-1181.757202,77.112388,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 355.681854), SetPVarFloat(npcid,"current_target_y", -1181.757202), SetPVarFloat(npcid,"current_target_z", 77.112388);
				case 2: FCNPC_GoTo(npcid,317.660003,-1194.442138,76.242774,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 317.660003), SetPVarFloat(npcid,"current_target_y", -1194.442138), SetPVarFloat(npcid,"current_target_z", 76.242774);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,328.155395,-1204.608886,76.273605))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,355.541229,-1181.579833,77.113723,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 355.541229), SetPVarFloat(npcid,"current_target_y", -1181.579833), SetPVarFloat(npcid,"current_target_z", 77.113723);
				case 1: FCNPC_GoTo(npcid,317.668518,-1194.316162,76.244110,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 317.668518), SetPVarFloat(npcid,"current_target_y", -1194.316162), SetPVarFloat(npcid,"current_target_z", 76.244110);
				case 2: FCNPC_GoTo(npcid,294.634582,-1228.628173,75.507186,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 294.634582), SetPVarFloat(npcid,"current_target_y", -1228.628173), SetPVarFloat(npcid,"current_target_z", 75.507186);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,317.474975,-1194.465576,76.240196))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,345.722717,-1170.427856,77.113868,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 345.722717), SetPVarFloat(npcid,"current_target_y", -1170.427856), SetPVarFloat(npcid,"current_target_z", 77.113868);
				case 1: FCNPC_GoTo(npcid,328.116973,-1204.531982,76.273857,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 328.116973), SetPVarFloat(npcid,"current_target_y", -1204.531982), SetPVarFloat(npcid,"current_target_z", 76.273857);
				case 2: FCNPC_GoTo(npcid,286.089263,-1216.840576,75.505149,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 286.089263), SetPVarFloat(npcid,"current_target_y", -1216.840576), SetPVarFloat(npcid,"current_target_z", 75.505149);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,294.577087,-1228.685180,75.505165))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,327.997192,-1204.690917,76.270851,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 327.997192), SetPVarFloat(npcid,"current_target_y", -1204.690917), SetPVarFloat(npcid,"current_target_z", 76.270851);
				case 1: FCNPC_GoTo(npcid,286.204010,-1216.707275,75.509513,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 286.204010), SetPVarFloat(npcid,"current_target_y", -1216.707275), SetPVarFloat(npcid,"current_target_z", 75.509513);
				case 2: FCNPC_GoTo(npcid,284.988372,-1235.679931,74.900741,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 284.988372), SetPVarFloat(npcid,"current_target_y", -1235.679931), SetPVarFloat(npcid,"current_target_z", 74.900741);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,286.308532,-1216.744018,75.511169))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,317.625854,-1194.645996,76.240348,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 317.625854), SetPVarFloat(npcid,"current_target_y", -1194.645996), SetPVarFloat(npcid,"current_target_z", 76.240348);
				case 1: FCNPC_GoTo(npcid,294.711334,-1228.657836,75.508346,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 294.711334), SetPVarFloat(npcid,"current_target_y", -1228.657836), SetPVarFloat(npcid,"current_target_z", 75.508346);
				case 2: FCNPC_GoTo(npcid,276.269348,-1223.721191,74.938766,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 276.269348), SetPVarFloat(npcid,"current_target_y", -1223.721191), SetPVarFloat(npcid,"current_target_z", 74.938766);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,284.920501,-1235.692749,74.900047))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,294.790679,-1228.746337,75.508720,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 294.790679), SetPVarFloat(npcid,"current_target_y", -1228.746337), SetPVarFloat(npcid,"current_target_z", 75.508720);
				case 1: FCNPC_GoTo(npcid,276.161987,-1223.832885,74.930816,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 276.161987), SetPVarFloat(npcid,"current_target_y", -1223.832885), SetPVarFloat(npcid,"current_target_z", 74.930816);
				case 2: FCNPC_GoTo(npcid,271.970336,-1245.281616,73.846321,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 271.970336), SetPVarFloat(npcid,"current_target_y", -1245.281616), SetPVarFloat(npcid,"current_target_z", 73.846321);
				case 3: FCNPC_GoTo(npcid,289.262939,-1241.331420,74.674232,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 289.262939), SetPVarFloat(npcid,"current_target_y", -1241.331420), SetPVarFloat(npcid,"current_target_z", 74.674232);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,276.295440,-1223.725463,74.939758))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,284.865325,-1235.551147,74.908294,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 284.865325), SetPVarFloat(npcid,"current_target_y", -1235.551147), SetPVarFloat(npcid,"current_target_z", 74.908294);
				case 1: FCNPC_GoTo(npcid,271.818878,-1245.282592,73.836753,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 271.818878), SetPVarFloat(npcid,"current_target_y", -1245.282592), SetPVarFloat(npcid,"current_target_z", 73.836753);
				case 2: FCNPC_GoTo(npcid,248.448364,-1243.949096,71.495651,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 248.448364), SetPVarFloat(npcid,"current_target_y", -1243.949096), SetPVarFloat(npcid,"current_target_z", 71.495651);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,271.885192,-1245.190673,73.837402))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,256.336853,-1256.641479,71.303108,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 256.336853), SetPVarFloat(npcid,"current_target_y", -1256.641479), SetPVarFloat(npcid,"current_target_z", 71.303108);
				case 1: FCNPC_GoTo(npcid,280.633453,-1254.726074,73.909431,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 280.633453), SetPVarFloat(npcid,"current_target_y", -1254.726074), SetPVarFloat(npcid,"current_target_z", 73.909431);
				case 2: FCNPC_GoTo(npcid,284.925292,-1235.547851,74.908439,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 284.925292), SetPVarFloat(npcid,"current_target_y", -1235.547851), SetPVarFloat(npcid,"current_target_z", 74.908439);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,256.144683,-1256.784912,71.268089))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,271.900543,-1245.195190,73.838546,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 271.900543), SetPVarFloat(npcid,"current_target_y", -1245.195190), SetPVarFloat(npcid,"current_target_z", 73.838546);
				case 1: FCNPC_GoTo(npcid,248.400329,-1243.927856,71.491882,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 248.400329), SetPVarFloat(npcid,"current_target_y", -1243.927856), SetPVarFloat(npcid,"current_target_z", 71.491882);
				case 2: FCNPC_GoTo(npcid,239.601821,-1269.404052,67.617698,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 239.601821), SetPVarFloat(npcid,"current_target_y", -1269.404052), SetPVarFloat(npcid,"current_target_z", 67.617698);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,248.392532,-1244.010131,71.484146))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,230.592681,-1259.162719,67.755607,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 230.592681), SetPVarFloat(npcid,"current_target_y", -1259.162719), SetPVarFloat(npcid,"current_target_z", 67.755607);
				case 1: FCNPC_GoTo(npcid,256.147735,-1256.605346,71.284614,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 256.147735), SetPVarFloat(npcid,"current_target_y", -1256.605346), SetPVarFloat(npcid,"current_target_z", 71.284614);
				case 2: FCNPC_GoTo(npcid,276.373718,-1223.765991,74.941886,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 276.373718), SetPVarFloat(npcid,"current_target_y", -1223.765991), SetPVarFloat(npcid,"current_target_z", 74.941886);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,239.413177,-1269.410034,67.591361))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,256.170501,-1256.854614,71.264778,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 256.170501), SetPVarFloat(npcid,"current_target_y", -1256.854614), SetPVarFloat(npcid,"current_target_z", 71.264778);
				case 1: FCNPC_GoTo(npcid,230.177200,-1258.572021,67.779159,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 230.177200), SetPVarFloat(npcid,"current_target_y", -1258.572021), SetPVarFloat(npcid,"current_target_z", 67.779159);
				case 2: FCNPC_GoTo(npcid,231.845748,-1279.282226,64.125663,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 231.845748), SetPVarFloat(npcid,"current_target_y", -1279.282226), SetPVarFloat(npcid,"current_target_z", 64.125663);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,230.193389,-1258.777832,67.755928))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,248.467010,-1244.267211,71.471359,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 248.467010), SetPVarFloat(npcid,"current_target_y", -1244.267211), SetPVarFloat(npcid,"current_target_z", 71.471359);
				case 1: FCNPC_GoTo(npcid,239.598754,-1269.426879,67.614158,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 239.598754), SetPVarFloat(npcid,"current_target_y", -1269.426879), SetPVarFloat(npcid,"current_target_z", 67.614158);
				case 2: FCNPC_GoTo(npcid,219.205856,-1271.879272,64.424255,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 219.205856), SetPVarFloat(npcid,"current_target_y", -1271.879272), SetPVarFloat(npcid,"current_target_z", 64.424255);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,231.708038,-1279.146484,64.151023))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,239.718139,-1269.515747,67.618133,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 239.718139), SetPVarFloat(npcid,"current_target_y", -1269.515747), SetPVarFloat(npcid,"current_target_z", 67.618133);
				case 1: FCNPC_GoTo(npcid,230.358825,-1288.221435,60.694339,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 230.358825), SetPVarFloat(npcid,"current_target_y", -1288.221435), SetPVarFloat(npcid,"current_target_z", 60.694339);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,219.159637,-1271.926147,64.410026))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,215.115539,-1284.600585,61.649116,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 215.115539), SetPVarFloat(npcid,"current_target_y", -1284.600585), SetPVarFloat(npcid,"current_target_z", 61.649116);
				case 1: FCNPC_GoTo(npcid,230.140151,-1258.648071,67.765548,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 230.140151), SetPVarFloat(npcid,"current_target_y", -1258.648071), SetPVarFloat(npcid,"current_target_z", 67.765548);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,230.268615,-1288.106445,60.739349))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,236.965225,-1304.009155,56.343849,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 236.965225), SetPVarFloat(npcid,"current_target_y", -1304.009155), SetPVarFloat(npcid,"current_target_z", 56.343849);
				case 1: FCNPC_GoTo(npcid,232.426284,-1279.041870,64.356239,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 232.426284), SetPVarFloat(npcid,"current_target_y", -1279.041870), SetPVarFloat(npcid,"current_target_z", 64.356239);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,215.002868,-1284.337402,61.705425))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,217.231704,-1299.381103,58.715988,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 217.231704), SetPVarFloat(npcid,"current_target_y", -1299.381103), SetPVarFloat(npcid,"current_target_z", 58.715988);
				case 1: FCNPC_GoTo(npcid,219.430389,-1272.035766,64.417709,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 219.430389), SetPVarFloat(npcid,"current_target_y", -1272.035766), SetPVarFloat(npcid,"current_target_z", 64.417709);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,236.898101,-1303.913330,56.368804))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,230.428146,-1288.139648,60.712562,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 230.428146), SetPVarFloat(npcid,"current_target_y", -1288.139648), SetPVarFloat(npcid,"current_target_z", 60.712562);
				case 1: FCNPC_GoTo(npcid,249.624450,-1321.574340,53.110832,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 249.624450), SetPVarFloat(npcid,"current_target_y", -1321.574340), SetPVarFloat(npcid,"current_target_z", 53.110832);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,217.105300,-1299.335327,58.730667))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,215.139724,-1284.616210,61.646125,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 215.139724), SetPVarFloat(npcid,"current_target_y", -1284.616210), SetPVarFloat(npcid,"current_target_z", 61.646125);
				case 1: FCNPC_GoTo(npcid,225.362335,-1313.441772,55.947574,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 225.362335), SetPVarFloat(npcid,"current_target_y", -1313.441772), SetPVarFloat(npcid,"current_target_z", 55.947574);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,225.362335,-1313.441772,55.947574))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,217.536514,-1299.187622,58.731834,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 217.536514), SetPVarFloat(npcid,"current_target_y", -1299.187622), SetPVarFloat(npcid,"current_target_z", 58.731834);
				case 1: FCNPC_GoTo(npcid,237.383438,-1331.165039,52.455638,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 237.383438), SetPVarFloat(npcid,"current_target_y", -1331.165039), SetPVarFloat(npcid,"current_target_z", 52.455638);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,249.522018,-1321.666625,53.105339))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,237.362945,-1331.136962,52.455635,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 237.362945), SetPVarFloat(npcid,"current_target_y", -1331.136962), SetPVarFloat(npcid,"current_target_z", 52.455635);
				case 1: FCNPC_GoTo(npcid,237.063430,-1303.974365,56.339107,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 237.063430), SetPVarFloat(npcid,"current_target_y", -1303.974365), SetPVarFloat(npcid,"current_target_z", 56.339107);
				case 2: FCNPC_GoTo(npcid,258.328369,-1334.428466,53.075637,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 258.328369), SetPVarFloat(npcid,"current_target_y", -1334.428466), SetPVarFloat(npcid,"current_target_z", 53.075637);
				case 3: FCNPC_GoTo(npcid,293.413055,-1292.975463,54.196479,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 293.413055), SetPVarFloat(npcid,"current_target_y", -1292.975463), SetPVarFloat(npcid,"current_target_z", 54.196479);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,258.309997,-1334.425048,53.075111))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,249.547378,-1321.664672,53.106204,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 249.547378), SetPVarFloat(npcid,"current_target_y", -1321.664672), SetPVarFloat(npcid,"current_target_z", 53.106204);
				case 1: FCNPC_GoTo(npcid,247.194442,-1343.322143,52.445072,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 247.194442), SetPVarFloat(npcid,"current_target_y", -1343.322143), SetPVarFloat(npcid,"current_target_z", 52.445072);
				case 2: FCNPC_GoTo(npcid,274.867065,-1322.037841,53.653255,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 274.867065), SetPVarFloat(npcid,"current_target_y", -1322.037841), SetPVarFloat(npcid,"current_target_z", 53.653255);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,293.362976,-1292.975585,54.196014))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,249.599044,-1321.736572,53.106166,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 249.599044), SetPVarFloat(npcid,"current_target_y", -1321.736572), SetPVarFloat(npcid,"current_target_z", 53.106166);
				case 1: FCNPC_GoTo(npcid,301.013580,-1305.665161,54.198135,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 301.013580), SetPVarFloat(npcid,"current_target_y", -1305.665161), SetPVarFloat(npcid,"current_target_z", 54.198135);
				case 2: FCNPC_GoTo(npcid,333.740386,-1270.080688,54.166942,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 333.740386), SetPVarFloat(npcid,"current_target_y", -1270.080688), SetPVarFloat(npcid,"current_target_z", 54.166942);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,274.788238,-1321.959838,53.652935))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,258.254943,-1334.066284,53.082225,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 258.254943), SetPVarFloat(npcid,"current_target_y", -1334.066284), SetPVarFloat(npcid,"current_target_z", 53.082225);
				case 1: FCNPC_GoTo(npcid,300.942901,-1305.687744,54.197345,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 300.942901), SetPVarFloat(npcid,"current_target_y", -1305.687744), SetPVarFloat(npcid,"current_target_z", 54.197345);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,300.942901,-1305.687744,54.197345))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,293.386413,-1292.922851,54.196517,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 293.386413), SetPVarFloat(npcid,"current_target_y", -1292.922851), SetPVarFloat(npcid,"current_target_z", 54.196517);
				case 1: FCNPC_GoTo(npcid,274.710083,-1321.927001,53.651878,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 274.710083), SetPVarFloat(npcid,"current_target_y", -1321.927001), SetPVarFloat(npcid,"current_target_z", 53.651878);
				case 2: FCNPC_GoTo(npcid,336.802886,-1285.295410,54.226661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 336.802886), SetPVarFloat(npcid,"current_target_y", -1285.295410), SetPVarFloat(npcid,"current_target_z", 54.226661);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,333.684173,-1269.928100,54.166568))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,293.140594,-1292.808715,54.194847,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 293.140594), SetPVarFloat(npcid,"current_target_y", -1292.808715), SetPVarFloat(npcid,"current_target_z", 54.194847);
				case 1: FCNPC_GoTo(npcid,336.787384,-1285.225341,54.226661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 336.787384), SetPVarFloat(npcid,"current_target_y", -1285.225341), SetPVarFloat(npcid,"current_target_z", 54.226661);
				case 2: FCNPC_GoTo(npcid,381.219512,-1247.769287,52.882514,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 381.219512), SetPVarFloat(npcid,"current_target_y", -1247.769287), SetPVarFloat(npcid,"current_target_z", 52.882514);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,336.785552,-1285.174316,54.226661))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,300.794097,-1305.428710,54.197257,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 300.794097), SetPVarFloat(npcid,"current_target_y", -1305.428710), SetPVarFloat(npcid,"current_target_z", 54.197257);
				case 1: FCNPC_GoTo(npcid,387.044372,-1260.494140,52.868804,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 387.044372), SetPVarFloat(npcid,"current_target_y", -1260.494140), SetPVarFloat(npcid,"current_target_z", 52.868804);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,381.078308,-1247.715698,52.885875))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,333.458770,-1269.929077,54.170154,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 333.458770), SetPVarFloat(npcid,"current_target_y", -1269.929077), SetPVarFloat(npcid,"current_target_z", 54.170154);
				case 1: FCNPC_GoTo(npcid,386.935974,-1260.259033,52.869026,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 386.935974), SetPVarFloat(npcid,"current_target_y", -1260.259033), SetPVarFloat(npcid,"current_target_z", 52.869026);
				case 2: FCNPC_GoTo(npcid,393.789154,-1242.297363,52.015884,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 393.789154), SetPVarFloat(npcid,"current_target_y", -1242.297363), SetPVarFloat(npcid,"current_target_z", 52.015884);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,386.853576,-1260.429931,52.873550))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,336.543731,-1285.157470,54.226661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 336.543731), SetPVarFloat(npcid,"current_target_y", -1285.157470), SetPVarFloat(npcid,"current_target_z", 54.226661);
				case 1: FCNPC_GoTo(npcid,381.117401,-1247.670410,52.884227,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 381.117401), SetPVarFloat(npcid,"current_target_y", -1247.670410), SetPVarFloat(npcid,"current_target_z", 52.884227);
				case 2: FCNPC_GoTo(npcid,429.606292,-1244.090942,50.697227,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 429.606292), SetPVarFloat(npcid,"current_target_y", -1244.090942), SetPVarFloat(npcid,"current_target_z", 50.697227);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,393.801544,-1242.266235,52.009559))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,407.302185,-1236.772216,51.688739,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 407.302185), SetPVarFloat(npcid,"current_target_y", -1236.772216), SetPVarFloat(npcid,"current_target_z", 51.688739);
				case 1: FCNPC_GoTo(npcid,386.804565,-1228.642333,52.582248,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 386.804565), SetPVarFloat(npcid,"current_target_y", -1228.642333), SetPVarFloat(npcid,"current_target_z", 52.582248);
				case 2: FCNPC_GoTo(npcid,381.164306,-1247.779052,52.884197,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 381.164306), SetPVarFloat(npcid,"current_target_y", -1247.779052), SetPVarFloat(npcid,"current_target_z", 52.884197);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,429.464447,-1244.031982,50.704238))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,386.923553,-1260.374633,52.870826,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 386.923553), SetPVarFloat(npcid,"current_target_y", -1260.374633), SetPVarFloat(npcid,"current_target_z", 52.870826);
				case 1: FCNPC_GoTo(npcid,423.603271,-1230.940063,50.769912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 423.603271), SetPVarFloat(npcid,"current_target_y", -1230.940063), SetPVarFloat(npcid,"current_target_z", 50.769912);
				case 2: FCNPC_GoTo(npcid,517.107299,-1212.366943,44.224952,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 517.107299), SetPVarFloat(npcid,"current_target_y", -1212.366943), SetPVarFloat(npcid,"current_target_z", 44.224952);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,517.107299,-1212.366943,44.224952))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,511.318756,-1198.133178,44.285545,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 511.318756), SetPVarFloat(npcid,"current_target_y", -1198.133178), SetPVarFloat(npcid,"current_target_z", 44.285545);
				case 1: FCNPC_GoTo(npcid,429.499542,-1244.000976,50.702003,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 429.499542), SetPVarFloat(npcid,"current_target_y", -1244.000976), SetPVarFloat(npcid,"current_target_z", 50.702003);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,423.513977,-1230.907104,50.773605))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,456.187896,-1219.000854,48.690681,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 456.187896), SetPVarFloat(npcid,"current_target_y", -1219.000854), SetPVarFloat(npcid,"current_target_z", 48.690681);
				case 1: FCNPC_GoTo(npcid,429.443298,-1243.971313,50.704715,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 429.443298), SetPVarFloat(npcid,"current_target_y", -1243.971313), SetPVarFloat(npcid,"current_target_z", 50.704715);
				case 2: FCNPC_GoTo(npcid,407.225708,-1236.787475,51.691699,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 407.225708), SetPVarFloat(npcid,"current_target_y", -1236.787475), SetPVarFloat(npcid,"current_target_z", 51.691699);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,456.170623,-1219.054443,48.692909))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,423.366638,-1231.088012,50.784278,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 423.366638), SetPVarFloat(npcid,"current_target_y", -1231.088012), SetPVarFloat(npcid,"current_target_z", 50.784278);
				case 1: FCNPC_GoTo(npcid,511.862579,-1198.461425,44.227764,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 511.862579), SetPVarFloat(npcid,"current_target_y", -1198.461425), SetPVarFloat(npcid,"current_target_z", 44.227764);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,511.862579,-1198.461425,44.227764))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,516.935363,-1212.094116,44.214847,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 516.935363), SetPVarFloat(npcid,"current_target_y", -1212.094116), SetPVarFloat(npcid,"current_target_z", 44.214847);
				case 1: FCNPC_GoTo(npcid,456.076324,-1218.880004,48.694564,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 456.076324), SetPVarFloat(npcid,"current_target_y", -1218.880004), SetPVarFloat(npcid,"current_target_z", 48.694564);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,386.653869,-1228.442626,52.597492))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,401.852935,-1224.302001,51.774955,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 401.852935), SetPVarFloat(npcid,"current_target_y", -1224.302001), SetPVarFloat(npcid,"current_target_z", 51.774955);
				case 1: FCNPC_GoTo(npcid,393.767181,-1242.227539,51.999511,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 393.767181), SetPVarFloat(npcid,"current_target_y", -1242.227539), SetPVarFloat(npcid,"current_target_z", 51.999511);
				case 2: FCNPC_GoTo(npcid,373.961425,-1235.254272,53.333221,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 373.961425), SetPVarFloat(npcid,"current_target_y", -1235.254272), SetPVarFloat(npcid,"current_target_z", 53.333221);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,401.787841,-1224.222045,51.776374))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,407.347991,-1236.722900,51.686607,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 407.347991), SetPVarFloat(npcid,"current_target_y", -1236.722900), SetPVarFloat(npcid,"current_target_z", 51.686607);
				case 1: FCNPC_GoTo(npcid,386.763427,-1228.596679,52.583019,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 386.763427), SetPVarFloat(npcid,"current_target_y", -1228.596679), SetPVarFloat(npcid,"current_target_z", 52.583019);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,373.792327,-1235.262817,53.352359))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,368.122100,-1221.164794,53.200721,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 368.122100), SetPVarFloat(npcid,"current_target_y", -1221.164794), SetPVarFloat(npcid,"current_target_z", 53.200721);
				case 1: FCNPC_GoTo(npcid,386.853149,-1228.632690,52.584388,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 386.853149), SetPVarFloat(npcid,"current_target_y", -1228.632690), SetPVarFloat(npcid,"current_target_z", 52.584388);
				case 2: FCNPC_GoTo(npcid,351.685607,-1246.442260,57.279914,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 351.685607), SetPVarFloat(npcid,"current_target_y", -1246.442260), SetPVarFloat(npcid,"current_target_z", 57.279914);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,351.685607,-1246.442260,57.279914))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,373.921447,-1235.226928,53.336032,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 373.921447), SetPVarFloat(npcid,"current_target_y", -1235.226928), SetPVarFloat(npcid,"current_target_z", 53.336032);
				case 1: FCNPC_GoTo(npcid,343.231750,-1233.506469,57.720321,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 343.231750), SetPVarFloat(npcid,"current_target_y", -1233.506469), SetPVarFloat(npcid,"current_target_z", 57.720321);
	        }
	    }	    if(IsPlayerInRangeOfPoint(npcid,3.0,332.620544,-1254.563476,62.568901))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,313.935058,-1260.011474,68.434486,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 313.935058), SetPVarFloat(npcid,"current_target_y", -1260.011474), SetPVarFloat(npcid,"current_target_z", 68.434486);
				case 1: FCNPC_GoTo(npcid,325.922210,-1240.598266,63.041584,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 325.922210), SetPVarFloat(npcid,"current_target_y", -1240.598266), SetPVarFloat(npcid,"current_target_z", 63.041584);
				case 2: FCNPC_GoTo(npcid,351.559326,-1246.516845,57.309165,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 351.559326), SetPVarFloat(npcid,"current_target_y", -1246.516845), SetPVarFloat(npcid,"current_target_z", 57.309165);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,313.924285,-1260.089477,68.441787))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,332.487823,-1254.740478,62.623741,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 332.487823), SetPVarFloat(npcid,"current_target_y", -1254.740478), SetPVarFloat(npcid,"current_target_z", 62.623741);
				case 1: FCNPC_GoTo(npcid,301.689758,-1261.098999,71.887184,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 301.689758), SetPVarFloat(npcid,"current_target_y", -1261.098999), SetPVarFloat(npcid,"current_target_z", 71.887184);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,301.689758,-1261.098999,71.887184))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,313.819610,-1260.162963,68.477729,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 313.819610), SetPVarFloat(npcid,"current_target_y", -1260.162963), SetPVarFloat(npcid,"current_target_z", 68.477729);
				case 1: FCNPC_GoTo(npcid,290.427124,-1259.284912,73.476379,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 290.427124), SetPVarFloat(npcid,"current_target_y", -1259.284912), SetPVarFloat(npcid,"current_target_z", 73.476379);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,290.427124,-1259.284912,73.476379))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,301.641754,-1261.183959,71.893692,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 301.641754), SetPVarFloat(npcid,"current_target_y", -1261.183959), SetPVarFloat(npcid,"current_target_z", 71.893692);
				case 1: FCNPC_GoTo(npcid,280.686706,-1254.626220,73.908729,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 280.686706), SetPVarFloat(npcid,"current_target_y", -1254.626220), SetPVarFloat(npcid,"current_target_z", 73.908729);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,280.686706,-1254.626220,73.908729))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,290.401947,-1259.260742,73.477600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 290.401947), SetPVarFloat(npcid,"current_target_y", -1259.260742), SetPVarFloat(npcid,"current_target_z", 73.477600);
				case 1: FCNPC_GoTo(npcid,289.209167,-1241.128295,74.693115,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 289.209167), SetPVarFloat(npcid,"current_target_y", -1241.128295), SetPVarFloat(npcid,"current_target_z", 74.693115);
				case 2: FCNPC_GoTo(npcid,271.853240,-1245.263305,73.838188,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 271.853240), SetPVarFloat(npcid,"current_target_y", -1245.263305), SetPVarFloat(npcid,"current_target_z", 73.838188);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,289.193115,-1241.255004,74.680320))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,284.587829,-1235.651733,74.902671,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 284.587829), SetPVarFloat(npcid,"current_target_y", -1235.651733), SetPVarFloat(npcid,"current_target_z", 74.902671);
				case 1: FCNPC_GoTo(npcid,296.985229,-1245.391113,73.001564,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 296.985229), SetPVarFloat(npcid,"current_target_y", -1245.391113), SetPVarFloat(npcid,"current_target_z", 73.001564);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,296.985229,-1245.391113,73.001564))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,289.152343,-1241.390625,74.666130,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 289.152343), SetPVarFloat(npcid,"current_target_y", -1241.390625), SetPVarFloat(npcid,"current_target_z", 74.666130);
				case 1: FCNPC_GoTo(npcid,306.522827,-1245.776977,70.183013,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 306.522827), SetPVarFloat(npcid,"current_target_y", -1245.776977), SetPVarFloat(npcid,"current_target_z", 70.183013);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,306.522827,-1245.776977,70.183013))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,296.883453,-1245.447998,73.021949,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 296.883453), SetPVarFloat(npcid,"current_target_y", -1245.447998), SetPVarFloat(npcid,"current_target_z", 73.021949);
				case 1: FCNPC_GoTo(npcid,325.803771,-1240.747192,63.095146,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 325.803771), SetPVarFloat(npcid,"current_target_y", -1240.747192), SetPVarFloat(npcid,"current_target_z", 63.095146);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,325.803771,-1240.747192,63.095146))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,306.639038,-1245.807861,70.142929,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 306.639038), SetPVarFloat(npcid,"current_target_y", -1245.807861), SetPVarFloat(npcid,"current_target_z", 70.142929);
				case 1: FCNPC_GoTo(npcid,342.973632,-1233.574218,57.775161,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 342.973632), SetPVarFloat(npcid,"current_target_y", -1233.574218), SetPVarFloat(npcid,"current_target_z", 57.775161);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,343.075683,-1233.557373,57.754337))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,325.784606,-1240.445922,63.070198,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 325.784606), SetPVarFloat(npcid,"current_target_y", -1240.445922), SetPVarFloat(npcid,"current_target_z", 63.070198);
				case 1: FCNPC_GoTo(npcid,351.540496,-1246.328735,57.296710,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 351.540496), SetPVarFloat(npcid,"current_target_y", -1246.328735), SetPVarFloat(npcid,"current_target_z", 57.296710);
				case 2: FCNPC_GoTo(npcid,368.049957,-1221.140502,53.202411,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 368.049957), SetPVarFloat(npcid,"current_target_y", -1221.140502), SetPVarFloat(npcid,"current_target_z", 53.202411);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,368.049957,-1221.140502,53.202411))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,343.097564,-1233.691528,57.761764,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 343.097564), SetPVarFloat(npcid,"current_target_y", -1233.691528), SetPVarFloat(npcid,"current_target_z", 57.761764);
				case 1: FCNPC_GoTo(npcid,373.869110,-1235.159301,53.337860,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 373.869110), SetPVarFloat(npcid,"current_target_y", -1235.159301), SetPVarFloat(npcid,"current_target_z", 53.337860);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,237.308227,-1331.054687,52.455821))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,249.449523,-1321.735595,53.101367,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 249.449523), SetPVarFloat(npcid,"current_target_y", -1321.735595), SetPVarFloat(npcid,"current_target_z", 53.101367);
				case 1: FCNPC_GoTo(npcid,247.062820,-1343.076782,52.452873,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 247.062820), SetPVarFloat(npcid,"current_target_y", -1343.076782), SetPVarFloat(npcid,"current_target_z", 52.452873);
				case 2: FCNPC_GoTo(npcid,213.473266,-1351.216552,50.974105,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 213.473266), SetPVarFloat(npcid,"current_target_y", -1351.216552), SetPVarFloat(npcid,"current_target_z", 50.974105);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,246.970352,-1343.279907,52.442474))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,258.306915,-1334.170288,53.081359,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 258.306915), SetPVarFloat(npcid,"current_target_y", -1334.170288), SetPVarFloat(npcid,"current_target_z", 53.081359);
				case 1: FCNPC_GoTo(npcid,237.270401,-1331.112060,52.452964,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 237.270401), SetPVarFloat(npcid,"current_target_y", -1331.112060), SetPVarFloat(npcid,"current_target_z", 52.452964);
				case 2: FCNPC_GoTo(npcid,223.599685,-1361.705200,51.026535,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 223.599685), SetPVarFloat(npcid,"current_target_y", -1361.705200), SetPVarFloat(npcid,"current_target_z", 51.026535);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,223.599685,-1361.705200,51.026535))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,246.968200,-1343.288696,52.442062,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 246.968200), SetPVarFloat(npcid,"current_target_y", -1343.288696), SetPVarFloat(npcid,"current_target_z", 52.442062);
				case 1: FCNPC_GoTo(npcid,213.271316,-1351.135009,50.968582,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 213.271316), SetPVarFloat(npcid,"current_target_y", -1351.135009), SetPVarFloat(npcid,"current_target_z", 50.968582);
				case 2: FCNPC_GoTo(npcid,187.213912,-1375.506347,49.211967,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 187.213912), SetPVarFloat(npcid,"current_target_y", -1375.506347), SetPVarFloat(npcid,"current_target_z", 49.211967);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,223.599166,-1361.748291,51.024871))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,213.505325,-1351.056884,50.981063,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 213.505325), SetPVarFloat(npcid,"current_target_y", -1351.056884), SetPVarFloat(npcid,"current_target_z", 50.981063);
				case 1: FCNPC_GoTo(npcid,246.798431,-1343.181152,52.443290,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 246.798431), SetPVarFloat(npcid,"current_target_y", -1343.181152), SetPVarFloat(npcid,"current_target_z", 52.443290);
				case 2: FCNPC_GoTo(npcid,198.217376,-1385.204223,48.608734,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 198.217376), SetPVarFloat(npcid,"current_target_y", -1385.204223), SetPVarFloat(npcid,"current_target_z", 48.608734);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,198.217376,-1385.204223,48.608734))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,187.370742,-1375.568725,49.215030,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 187.370742), SetPVarFloat(npcid,"current_target_y", -1375.568725), SetPVarFloat(npcid,"current_target_z", 49.215030);
				case 1: FCNPC_GoTo(npcid,223.448181,-1361.787353,51.017105,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 223.448181), SetPVarFloat(npcid,"current_target_y", -1361.787353), SetPVarFloat(npcid,"current_target_z", 51.017105);
				case 2: FCNPC_GoTo(npcid,181.067932,-1402.812133,46.396598,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 181.067932), SetPVarFloat(npcid,"current_target_y", -1402.812133), SetPVarFloat(npcid,"current_target_z", 46.396598);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,187.155441,-1375.360229,49.214309))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,171.138656,-1391.395629,48.323448,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 171.138656), SetPVarFloat(npcid,"current_target_y", -1391.395629), SetPVarFloat(npcid,"current_target_z", 48.323448);
				case 1: FCNPC_GoTo(npcid,213.482711,-1351.138061,50.977264,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 213.482711), SetPVarFloat(npcid,"current_target_y", -1351.138061), SetPVarFloat(npcid,"current_target_z", 50.977264);
				case 2: FCNPC_GoTo(npcid,198.173812,-1385.188598,48.608051,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 198.173812), SetPVarFloat(npcid,"current_target_y", -1385.188598), SetPVarFloat(npcid,"current_target_z", 48.608051);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,180.970153,-1402.873413,46.391685))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,198.148071,-1385.139038,48.610794,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 198.148071), SetPVarFloat(npcid,"current_target_y", -1385.139038), SetPVarFloat(npcid,"current_target_z", 48.610794);
				case 1: FCNPC_GoTo(npcid,171.150650,-1391.331909,48.331012,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 171.150650), SetPVarFloat(npcid,"current_target_y", -1391.331909), SetPVarFloat(npcid,"current_target_z", 48.331012);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,171.150650,-1391.331909,48.331012))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,187.296966,-1375.468505,49.215599,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 187.296966), SetPVarFloat(npcid,"current_target_y", -1375.468505), SetPVarFloat(npcid,"current_target_z", 49.215599);
				case 1: FCNPC_GoTo(npcid,181.095870,-1402.826782,46.393753,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 181.095870), SetPVarFloat(npcid,"current_target_y", -1402.826782), SetPVarFloat(npcid,"current_target_z", 46.393753);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,407.260772,-1236.834350,51.690830))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,423.435516,-1231.102783,50.780807,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 423.435516), SetPVarFloat(npcid,"current_target_y", -1231.102783), SetPVarFloat(npcid,"current_target_z", 50.780807);
				case 1: FCNPC_GoTo(npcid,393.649749,-1242.088745,51.963737,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 393.649749), SetPVarFloat(npcid,"current_target_y", -1242.088745), SetPVarFloat(npcid,"current_target_z", 51.963737);
				case 2: FCNPC_GoTo(npcid,401.818115,-1224.298828,51.775154,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 401.818115), SetPVarFloat(npcid,"current_target_y", -1224.298828), SetPVarFloat(npcid,"current_target_z", 51.775154);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,213.313781,-1351.317749,50.963912))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,187.122146,-1375.567993,49.207397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 187.122146), SetPVarFloat(npcid,"current_target_y", -1375.567993), SetPVarFloat(npcid,"current_target_z", 49.207397);
				case 1: FCNPC_GoTo(npcid,223.615310,-1361.463256,51.036415,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 223.615310), SetPVarFloat(npcid,"current_target_y", -1361.463256), SetPVarFloat(npcid,"current_target_z", 51.036415);
				case 2: FCNPC_GoTo(npcid,237.509841,-1331.020385,52.463966,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 237.509841), SetPVarFloat(npcid,"current_target_y", -1331.020385), SetPVarFloat(npcid,"current_target_z", 52.463966);
	        }
	    }
	}
	if(GetPVarInt(npcid,"grove_cluck")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2405.475097,-1885.238403,13.553935))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2405.994140,-1902.035644,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2405.994140), SetPVarFloat(npcid,"current_target_y", -1902.035644), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2421.340332,-1885.716674,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.340332), SetPVarFloat(npcid,"current_target_y", -1885.716674), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2368.419433,-1885.463134,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2368.419433), SetPVarFloat(npcid,"current_target_y", -1885.463134), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2405.992431,-1901.987182,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2405.592773,-1885.414550,13.553935,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2405.592773), SetPVarFloat(npcid,"current_target_y", -1885.414550), SetPVarFloat(npcid,"current_target_z", 13.553935);
				case 1: FCNPC_GoTo(npcid,2421.571533,-1900.716918,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.571533), SetPVarFloat(npcid,"current_target_y", -1900.716918), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2405.936279,-1913.109130,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2405.936279), SetPVarFloat(npcid,"current_target_y", -1913.109130), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2406.086914,-1913.265380,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2405.943115,-1902.061279,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2405.943115), SetPVarFloat(npcid,"current_target_y", -1902.061279), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2421.146972,-1912.873779,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.146972), SetPVarFloat(npcid,"current_target_y", -1912.873779), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2406.487060,-1937.136352,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.487060), SetPVarFloat(npcid,"current_target_y", -1937.136352), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2406.487060,-1937.136352,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2406.062011,-1913.062255,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.062011), SetPVarFloat(npcid,"current_target_y", -1913.062255), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2421.748535,-1940.295776,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.748535), SetPVarFloat(npcid,"current_target_y", -1940.295776), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2405.771728,-1964.847045,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2405.771728), SetPVarFloat(npcid,"current_target_y", -1964.847045), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2405.886230,-1965.058349,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2406.308105,-1937.187988,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.308105), SetPVarFloat(npcid,"current_target_y", -1937.187988), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2421.211914,-1965.165161,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.211914), SetPVarFloat(npcid,"current_target_y", -1965.165161), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2405.857421,-1980.332397,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2405.857421), SetPVarFloat(npcid,"current_target_y", -1980.332397), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2354.225585,-1964.977050,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2354.225585), SetPVarFloat(npcid,"current_target_y", -1964.977050), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2405.864013,-1980.487182,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2406.008300,-1964.939086,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.008300), SetPVarFloat(npcid,"current_target_y", -1964.939086), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2420.798828,-1980.255615,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2420.798828), SetPVarFloat(npcid,"current_target_y", -1980.255615), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2354.864746,-1979.393432,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2354.864746), SetPVarFloat(npcid,"current_target_y", -1979.393432), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2421.294921,-1885.728515,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2405.691650,-1885.280395,13.553935,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2405.691650), SetPVarFloat(npcid,"current_target_y", -1885.280395), SetPVarFloat(npcid,"current_target_z", 13.553935);
				case 1: FCNPC_GoTo(npcid,2368.361083,-1885.506958,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2368.361083), SetPVarFloat(npcid,"current_target_y", -1885.506958), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2421.480468,-1900.644897,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.480468), SetPVarFloat(npcid,"current_target_y", -1900.644897), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2421.480468,-1900.644897,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2421.263427,-1885.823486,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.263427), SetPVarFloat(npcid,"current_target_y", -1885.823486), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2406.012207,-1901.974243,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.012207), SetPVarFloat(npcid,"current_target_y", -1901.974243), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2421.206542,-1912.880615,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.206542), SetPVarFloat(npcid,"current_target_y", -1912.880615), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2421.215820,-1912.754760,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2421.474853,-1900.860595,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.474853), SetPVarFloat(npcid,"current_target_y", -1900.860595), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2405.987304,-1913.193481,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2405.987304), SetPVarFloat(npcid,"current_target_y", -1913.193481), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2420.738769,-1923.827270,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2420.738769), SetPVarFloat(npcid,"current_target_y", -1923.827270), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2420.738769,-1923.827270,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2421.236816,-1912.922119,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.236816), SetPVarFloat(npcid,"current_target_y", -1912.922119), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2421.733154,-1940.375488,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.733154), SetPVarFloat(npcid,"current_target_y", -1940.375488), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2421.733154,-1940.375488,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2420.777343,-1923.793090,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2420.777343), SetPVarFloat(npcid,"current_target_y", -1923.793090), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2406.446533,-1937.223510,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.446533), SetPVarFloat(npcid,"current_target_y", -1937.223510), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2421.252929,-1965.148681,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.252929), SetPVarFloat(npcid,"current_target_y", -1965.148681), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2421.252929,-1965.148681,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2421.626708,-1940.452392,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.626708), SetPVarFloat(npcid,"current_target_y", -1940.452392), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2406.142333,-1964.968505,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.142333), SetPVarFloat(npcid,"current_target_y", -1964.968505), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2420.852294,-1980.203735,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2420.852294), SetPVarFloat(npcid,"current_target_y", -1980.203735), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2420.852294,-1980.203735,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2421.312011,-1965.197143,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2421.312011), SetPVarFloat(npcid,"current_target_y", -1965.197143), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2405.804931,-1980.429199,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2405.804931), SetPVarFloat(npcid,"current_target_y", -1980.429199), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2354.929443,-1979.764282,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2406.067871,-1980.382690,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.067871), SetPVarFloat(npcid,"current_target_y", -1980.382690), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2354.308105,-1965.051513,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2354.308105), SetPVarFloat(npcid,"current_target_y", -1965.051513), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2340.085205,-1980.957275,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2340.085205), SetPVarFloat(npcid,"current_target_y", -1980.957275), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2340.085205,-1980.957275,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2355.026855,-1979.831298,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2355.026855), SetPVarFloat(npcid,"current_target_y", -1979.831298), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2339.786865,-1965.620117,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2339.786865), SetPVarFloat(npcid,"current_target_y", -1965.620117), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2321.457519,-1979.475463,13.560964,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.457519), SetPVarFloat(npcid,"current_target_y", -1979.475463), SetPVarFloat(npcid,"current_target_z", 13.560964);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2321.457519,-1979.475463,13.560964))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2340.254882,-1980.294677,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2340.254882), SetPVarFloat(npcid,"current_target_y", -1980.294677), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2321.049316,-1964.611328,13.562600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.049316), SetPVarFloat(npcid,"current_target_y", -1964.611328), SetPVarFloat(npcid,"current_target_z", 13.562600);
				case 2: FCNPC_GoTo(npcid,2306.682128,-1979.830444,13.575397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.682128), SetPVarFloat(npcid,"current_target_y", -1979.830444), SetPVarFloat(npcid,"current_target_z", 13.575397);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2306.682128,-1979.830444,13.575397))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2321.569580,-1979.495849,13.560854,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.569580), SetPVarFloat(npcid,"current_target_y", -1979.495849), SetPVarFloat(npcid,"current_target_z", 13.560854);
				case 1: FCNPC_GoTo(npcid,2305.817626,-1964.770141,13.570977,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.817626), SetPVarFloat(npcid,"current_target_y", -1964.770141), SetPVarFloat(npcid,"current_target_z", 13.570977);
				case 2: FCNPC_GoTo(npcid,2284.506835,-1979.757202,13.568862,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2284.506835), SetPVarFloat(npcid,"current_target_y", -1979.757202), SetPVarFloat(npcid,"current_target_z", 13.568862);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2284.453613,-1979.719482,13.568837))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2306.803955,-1980.145385,13.575278,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.803955), SetPVarFloat(npcid,"current_target_y", -1980.145385), SetPVarFloat(npcid,"current_target_z", 13.575278);
				case 1: FCNPC_GoTo(npcid,2283.323486,-1965.214599,13.568284,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2283.323486), SetPVarFloat(npcid,"current_target_y", -1965.214599), SetPVarFloat(npcid,"current_target_z", 13.568284);
				case 2: FCNPC_GoTo(npcid,2252.435058,-1979.594482,13.553198,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2252.435058), SetPVarFloat(npcid,"current_target_y", -1979.594482), SetPVarFloat(npcid,"current_target_z", 13.553198);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2252.435058,-1979.594482,13.553198))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2284.371582,-1979.763793,13.568797,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2284.371582), SetPVarFloat(npcid,"current_target_y", -1979.763793), SetPVarFloat(npcid,"current_target_z", 13.568797);
				case 1: FCNPC_GoTo(npcid,2251.480468,-1964.884277,13.549839,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2251.480468), SetPVarFloat(npcid,"current_target_y", -1964.884277), SetPVarFloat(npcid,"current_target_z", 13.549839);
				case 2: FCNPC_GoTo(npcid,2221.280029,-1979.239990,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2221.280029), SetPVarFloat(npcid,"current_target_y", -1979.239990), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2221.280029,-1979.239990,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2252.652099,-1979.386108,13.553305,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2252.652099), SetPVarFloat(npcid,"current_target_y", -1979.386108), SetPVarFloat(npcid,"current_target_z", 13.553305);
				case 1: FCNPC_GoTo(npcid,2221.249755,-1963.937500,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2221.249755), SetPVarFloat(npcid,"current_target_y", -1963.937500), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2206.408203,-1980.166259,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2206.408203), SetPVarFloat(npcid,"current_target_y", -1980.166259), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2206.408203,-1980.166259,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2206.261718,-1964.606567,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2206.261718), SetPVarFloat(npcid,"current_target_y", -1964.606567), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2221.297851,-1979.327758,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2221.297851), SetPVarFloat(npcid,"current_target_y", -1979.327758), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2354.250976,-1965.041137,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2406.128662,-1965.042236,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2406.128662), SetPVarFloat(npcid,"current_target_y", -1965.042236), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2354.922119,-1979.674560,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2354.922119), SetPVarFloat(npcid,"current_target_y", -1979.674560), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2339.680419,-1965.453491,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2339.680419), SetPVarFloat(npcid,"current_target_y", -1965.453491), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2339.680419,-1965.453491,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2354.444580,-1964.937377,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2354.444580), SetPVarFloat(npcid,"current_target_y", -1964.937377), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2339.901855,-1980.893432,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2339.901855), SetPVarFloat(npcid,"current_target_y", -1980.893432), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2321.056396,-1964.431396,13.562600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.056396), SetPVarFloat(npcid,"current_target_y", -1964.431396), SetPVarFloat(npcid,"current_target_z", 13.562600);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2321.056396,-1964.431396,13.562600))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2339.776611,-1965.232177,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2339.776611), SetPVarFloat(npcid,"current_target_y", -1965.232177), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2321.556640,-1979.375000,13.560868,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.556640), SetPVarFloat(npcid,"current_target_y", -1979.375000), SetPVarFloat(npcid,"current_target_z", 13.560868);
				case 2: FCNPC_GoTo(npcid,2321.206787,-1947.938232,13.578246,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.206787), SetPVarFloat(npcid,"current_target_y", -1947.938232), SetPVarFloat(npcid,"current_target_z", 13.578246);
				case 3: FCNPC_GoTo(npcid,2305.664306,-1964.685668,13.571192,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.664306), SetPVarFloat(npcid,"current_target_y", -1964.685668), SetPVarFloat(npcid,"current_target_z", 13.571192);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2305.664306,-1964.685668,13.571192))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2321.140625,-1964.507568,13.562600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.140625), SetPVarFloat(npcid,"current_target_y", -1964.507568), SetPVarFloat(npcid,"current_target_z", 13.562600);
				case 1: FCNPC_GoTo(npcid,2306.616699,-1979.823486,13.575461,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.616699), SetPVarFloat(npcid,"current_target_y", -1979.823486), SetPVarFloat(npcid,"current_target_z", 13.575461);
				case 2: FCNPC_GoTo(npcid,2306.080810,-1948.073120,13.566992,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.080810), SetPVarFloat(npcid,"current_target_y", -1948.073120), SetPVarFloat(npcid,"current_target_z", 13.566992);
				case 3: FCNPC_GoTo(npcid,2283.550781,-1965.213012,13.568396,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2283.550781), SetPVarFloat(npcid,"current_target_y", -1965.213012), SetPVarFloat(npcid,"current_target_z", 13.568396);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2283.550781,-1965.213012,13.568396))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2305.638916,-1964.645385,13.571260,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.638916), SetPVarFloat(npcid,"current_target_y", -1964.645385), SetPVarFloat(npcid,"current_target_z", 13.571260);
				case 1: FCNPC_GoTo(npcid,2284.537109,-1979.797607,13.568878,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2284.537109), SetPVarFloat(npcid,"current_target_y", -1979.797607), SetPVarFloat(npcid,"current_target_z", 13.568878);
				case 2: FCNPC_GoTo(npcid,2251.551269,-1964.775878,13.549856,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2251.551269), SetPVarFloat(npcid,"current_target_y", -1964.775878), SetPVarFloat(npcid,"current_target_z", 13.549856);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2251.551269,-1964.775878,13.549856))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2283.155517,-1965.327148,13.568202,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2283.155517), SetPVarFloat(npcid,"current_target_y", -1965.327148), SetPVarFloat(npcid,"current_target_z", 13.568202);
				case 1: FCNPC_GoTo(npcid,2252.745361,-1979.401245,13.553350,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2252.745361), SetPVarFloat(npcid,"current_target_y", -1979.401245), SetPVarFloat(npcid,"current_target_z", 13.553350);
				case 2: FCNPC_GoTo(npcid,2221.156250,-1963.828491,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2221.156250), SetPVarFloat(npcid,"current_target_y", -1963.828491), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2221.156250,-1963.828491,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2251.467285,-1964.815063,13.549836,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2251.467285), SetPVarFloat(npcid,"current_target_y", -1964.815063), SetPVarFloat(npcid,"current_target_z", 13.549836);
				case 1: FCNPC_GoTo(npcid,2221.339355,-1979.249877,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2221.339355), SetPVarFloat(npcid,"current_target_y", -1979.249877), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2206.157958,-1964.613891,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2206.157958), SetPVarFloat(npcid,"current_target_y", -1964.613891), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2222.719970,-1937.432617,13.539807,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2222.719970), SetPVarFloat(npcid,"current_target_y", -1937.432617), SetPVarFloat(npcid,"current_target_z", 13.539807);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2206.365722,-1964.628295,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2206.373046,-1980.295654,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2206.373046), SetPVarFloat(npcid,"current_target_y", -1980.295654), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2221.300537,-1963.909545,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2221.300537), SetPVarFloat(npcid,"current_target_y", -1963.909545), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2207.698486,-1936.417236,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2207.698486), SetPVarFloat(npcid,"current_target_y", -1936.417236), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2207.698486,-1936.417236,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2205.811279,-1964.595703,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2205.811279), SetPVarFloat(npcid,"current_target_y", -1964.595703), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2222.463623,-1937.241333,13.539196,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2222.463623), SetPVarFloat(npcid,"current_target_y", -1937.241333), SetPVarFloat(npcid,"current_target_z", 13.539196);
				case 2: FCNPC_GoTo(npcid,2211.059082,-1902.373413,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2211.059082), SetPVarFloat(npcid,"current_target_y", -1902.373413), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2211.059082,-1902.373413,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2207.735351,-1936.079711,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2207.735351), SetPVarFloat(npcid,"current_target_y", -1936.079711), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2210.629882,-1886.341308,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2210.629882), SetPVarFloat(npcid,"current_target_y", -1886.341308), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2226.972167,-1901.853393,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2226.972167), SetPVarFloat(npcid,"current_target_y", -1901.853393), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2210.658203,-1886.422241,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2227.827880,-1886.072021,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2227.827880), SetPVarFloat(npcid,"current_target_y", -1886.072021), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2211.122802,-1902.116455,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2211.122802), SetPVarFloat(npcid,"current_target_y", -1902.116455), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2222.663085,-1937.369750,13.539686))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2221.340087,-1963.855102,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2221.340087), SetPVarFloat(npcid,"current_target_y", -1963.855102), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2207.811523,-1936.246826,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2207.811523), SetPVarFloat(npcid,"current_target_y", -1936.246826), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2249.652587,-1937.030883,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2249.652587), SetPVarFloat(npcid,"current_target_y", -1937.030883), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2226.960205,-1901.859375,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2226.960205), SetPVarFloat(npcid,"current_target_y", -1901.859375), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2226.960205,-1901.859375,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2222.759765,-1937.411743,13.539938,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2222.759765), SetPVarFloat(npcid,"current_target_y", -1937.411743), SetPVarFloat(npcid,"current_target_z", 13.539938);
				case 1: FCNPC_GoTo(npcid,2211.170166,-1902.271850,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2211.170166), SetPVarFloat(npcid,"current_target_y", -1902.271850), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2227.501708,-1886.163818,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2227.501708), SetPVarFloat(npcid,"current_target_y", -1886.163818), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2249.635009,-1902.166748,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2249.635009), SetPVarFloat(npcid,"current_target_y", -1902.166748), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2227.611328,-1886.280151,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2210.844970,-1886.244995,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2210.844970), SetPVarFloat(npcid,"current_target_y", -1886.244995), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2226.902832,-1901.786254,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2226.902832), SetPVarFloat(npcid,"current_target_y", -1901.786254), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2250.919433,-1887.040161,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2250.919433), SetPVarFloat(npcid,"current_target_y", -1887.040161), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2250.919433,-1887.040161,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2227.759033,-1886.228271,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2227.759033), SetPVarFloat(npcid,"current_target_y", -1886.228271), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2249.667480,-1901.942260,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2249.667480), SetPVarFloat(npcid,"current_target_y", -1901.942260), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2272.413574,-1886.974731,13.549368,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2272.413574), SetPVarFloat(npcid,"current_target_y", -1886.974731), SetPVarFloat(npcid,"current_target_z", 13.549368);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2272.413574,-1886.974731,13.549368))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2251.015136,-1886.997558,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2251.015136), SetPVarFloat(npcid,"current_target_y", -1886.997558), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2272.933349,-1901.813476,13.553779,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2272.933349), SetPVarFloat(npcid,"current_target_y", -1901.813476), SetPVarFloat(npcid,"current_target_z", 13.553779);
				case 2: FCNPC_GoTo(npcid,2296.556640,-1886.876586,13.596534,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.556640), SetPVarFloat(npcid,"current_target_y", -1886.876586), SetPVarFloat(npcid,"current_target_z", 13.596534);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2296.556640,-1886.876586,13.596533))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2272.017578,-1887.117675,13.548594,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2272.017578), SetPVarFloat(npcid,"current_target_y", -1887.117675), SetPVarFloat(npcid,"current_target_z", 13.548594);
				case 1: FCNPC_GoTo(npcid,2296.389892,-1901.992431,13.579478,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.389892), SetPVarFloat(npcid,"current_target_y", -1901.992431), SetPVarFloat(npcid,"current_target_z", 13.579478);
				case 2: FCNPC_GoTo(npcid,2305.992675,-1887.288574,13.613219,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.992675), SetPVarFloat(npcid,"current_target_y", -1887.288574), SetPVarFloat(npcid,"current_target_z", 13.613219);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2305.992675,-1887.288574,13.613219))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2296.306884,-1886.671020,13.596046,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.306884), SetPVarFloat(npcid,"current_target_y", -1886.671020), SetPVarFloat(npcid,"current_target_z", 13.596046);
				case 1: FCNPC_GoTo(npcid,2306.108642,-1902.526245,13.617287,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.108642), SetPVarFloat(npcid,"current_target_y", -1902.526245), SetPVarFloat(npcid,"current_target_z", 13.617287);
				case 2: FCNPC_GoTo(npcid,2321.023193,-1887.484741,13.614860,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.023193), SetPVarFloat(npcid,"current_target_y", -1887.484741), SetPVarFloat(npcid,"current_target_z", 13.614860);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2321.023193,-1887.484741,13.614860))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2320.928222,-1902.636840,13.610841,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2320.928222), SetPVarFloat(npcid,"current_target_y", -1902.636840), SetPVarFloat(npcid,"current_target_z", 13.610841);
				case 1: FCNPC_GoTo(npcid,2306.196533,-1887.117187,13.612920,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.196533), SetPVarFloat(npcid,"current_target_y", -1887.117187), SetPVarFloat(npcid,"current_target_z", 13.612920);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2249.439453,-1902.034423,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2227.149658,-1901.779907,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2227.149658), SetPVarFloat(npcid,"current_target_y", -1901.779907), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2250.906005,-1886.840209,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2250.906005), SetPVarFloat(npcid,"current_target_y", -1886.840209), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2249.756591,-1936.877197,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2249.756591), SetPVarFloat(npcid,"current_target_y", -1936.877197), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2272.900390,-1901.942016,13.553650,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2272.900390), SetPVarFloat(npcid,"current_target_y", -1901.942016), SetPVarFloat(npcid,"current_target_z", 13.553650);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2272.900390,-1901.942016,13.553650))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2249.576416,-1901.976684,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2249.576416), SetPVarFloat(npcid,"current_target_y", -1901.976684), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2272.266845,-1887.124511,13.549081,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2272.266845), SetPVarFloat(npcid,"current_target_y", -1887.124511), SetPVarFloat(npcid,"current_target_z", 13.549081);
				case 2: FCNPC_GoTo(npcid,2273.106445,-1937.446533,13.538951,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2273.106445), SetPVarFloat(npcid,"current_target_y", -1937.446533), SetPVarFloat(npcid,"current_target_z", 13.538951);
				case 3: FCNPC_GoTo(npcid,2296.282470,-1902.328491,13.581663,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.282470), SetPVarFloat(npcid,"current_target_y", -1902.328491), SetPVarFloat(npcid,"current_target_z", 13.581663);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2296.282470,-1902.328491,13.581663))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2273.129394,-1901.971679,13.561891,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2273.129394), SetPVarFloat(npcid,"current_target_y", -1901.971679), SetPVarFloat(npcid,"current_target_z", 13.561891);
				case 1: FCNPC_GoTo(npcid,2296.379882,-1886.714721,13.596189,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.379882), SetPVarFloat(npcid,"current_target_y", -1886.714721), SetPVarFloat(npcid,"current_target_z", 13.596189);
				case 2: FCNPC_GoTo(npcid,2296.265869,-1937.063476,13.559088,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.265869), SetPVarFloat(npcid,"current_target_y", -1937.063476), SetPVarFloat(npcid,"current_target_z", 13.559088);
				case 3: FCNPC_GoTo(npcid,2306.002929,-1902.420043,13.617287,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.002929), SetPVarFloat(npcid,"current_target_y", -1902.420043), SetPVarFloat(npcid,"current_target_z", 13.617287);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2306.002929,-1902.420043,13.617287))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2296.250976,-1902.036499,13.578560,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.250976), SetPVarFloat(npcid,"current_target_y", -1902.036499), SetPVarFloat(npcid,"current_target_z", 13.578560);
				case 1: FCNPC_GoTo(npcid,2306.122070,-1887.328735,13.613029,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.122070), SetPVarFloat(npcid,"current_target_y", -1887.328735), SetPVarFloat(npcid,"current_target_z", 13.613029);
				case 2: FCNPC_GoTo(npcid,2320.791748,-1902.607543,13.610798,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2320.791748), SetPVarFloat(npcid,"current_target_y", -1902.607543), SetPVarFloat(npcid,"current_target_z", 13.610798);
				case 3: FCNPC_GoTo(npcid,2306.572265,-1913.758544,13.586293,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.572265), SetPVarFloat(npcid,"current_target_y", -1913.758544), SetPVarFloat(npcid,"current_target_z", 13.586293);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2321.039306,-1902.567871,13.610740))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2321.049316,-1887.555175,13.614936,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.049316), SetPVarFloat(npcid,"current_target_y", -1887.555175), SetPVarFloat(npcid,"current_target_z", 13.614936);
				case 1: FCNPC_GoTo(npcid,2306.356933,-1902.305419,13.617287,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.356933), SetPVarFloat(npcid,"current_target_y", -1902.305419), SetPVarFloat(npcid,"current_target_z", 13.617287);
				case 2: FCNPC_GoTo(npcid,2321.290283,-1913.294433,13.597193,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.290283), SetPVarFloat(npcid,"current_target_y", -1913.294433), SetPVarFloat(npcid,"current_target_z", 13.597193);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2321.290283,-1913.294433,13.597193))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2320.851562,-1902.573730,13.610749,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2320.851562), SetPVarFloat(npcid,"current_target_y", -1902.573730), SetPVarFloat(npcid,"current_target_z", 13.610749);
				case 1: FCNPC_GoTo(npcid,2306.436767,-1913.925781,13.585844,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.436767), SetPVarFloat(npcid,"current_target_y", -1913.925781), SetPVarFloat(npcid,"current_target_z", 13.585844);
				case 2: FCNPC_GoTo(npcid,2344.465332,-1913.576538,13.557784,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2344.465332), SetPVarFloat(npcid,"current_target_y", -1913.576538), SetPVarFloat(npcid,"current_target_z", 13.557784);
				case 3: FCNPC_GoTo(npcid,2321.765869,-1937.000366,13.586037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.765869), SetPVarFloat(npcid,"current_target_y", -1937.000366), SetPVarFloat(npcid,"current_target_z", 13.586037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2321.765869,-1937.000366,13.586037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2321.366699,-1913.398681,13.596810,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.366699), SetPVarFloat(npcid,"current_target_y", -1913.398681), SetPVarFloat(npcid,"current_target_z", 13.596810);
				case 1: FCNPC_GoTo(npcid,2306.195556,-1937.794311,13.578225,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.195556), SetPVarFloat(npcid,"current_target_y", -1937.794311), SetPVarFloat(npcid,"current_target_z", 13.578225);
				case 2: FCNPC_GoTo(npcid,2321.165771,-1947.992065,13.578246,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.165771), SetPVarFloat(npcid,"current_target_y", -1947.992065), SetPVarFloat(npcid,"current_target_z", 13.578246);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2321.165771,-1947.992065,13.578246))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2321.505859,-1937.037719,13.586037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.505859), SetPVarFloat(npcid,"current_target_y", -1937.037719), SetPVarFloat(npcid,"current_target_z", 13.586037);
				case 1: FCNPC_GoTo(npcid,2344.333496,-1948.359252,13.564961,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2344.333496), SetPVarFloat(npcid,"current_target_y", -1948.359252), SetPVarFloat(npcid,"current_target_z", 13.564961);
				case 2: FCNPC_GoTo(npcid,2305.890625,-1947.989624,13.565688,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2305.890625), SetPVarFloat(npcid,"current_target_y", -1947.989624), SetPVarFloat(npcid,"current_target_z", 13.565688);
				case 3: FCNPC_GoTo(npcid,2320.932861,-1964.406494,13.562600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2320.932861), SetPVarFloat(npcid,"current_target_y", -1964.406494), SetPVarFloat(npcid,"current_target_z", 13.562600);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2306.617431,-1913.785156,13.586221))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2306.197753,-1902.422485,13.617287,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.197753), SetPVarFloat(npcid,"current_target_y", -1902.422485), SetPVarFloat(npcid,"current_target_z", 13.617287);
				case 1: FCNPC_GoTo(npcid,2321.325195,-1913.377197,13.596769,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.325195), SetPVarFloat(npcid,"current_target_y", -1913.377197), SetPVarFloat(npcid,"current_target_z", 13.596769);
				case 2: FCNPC_GoTo(npcid,2306.135986,-1937.935302,13.578225,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.135986), SetPVarFloat(npcid,"current_target_y", -1937.935302), SetPVarFloat(npcid,"current_target_z", 13.578225);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2306.135986,-1937.935302,13.578225))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2306.327880,-1913.815673,13.586139,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.327880), SetPVarFloat(npcid,"current_target_y", -1913.815673), SetPVarFloat(npcid,"current_target_z", 13.586139);
				case 1: FCNPC_GoTo(npcid,2321.805175,-1937.056518,13.586037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.805175), SetPVarFloat(npcid,"current_target_y", -1937.056518), SetPVarFloat(npcid,"current_target_z", 13.586037);
				case 2: FCNPC_GoTo(npcid,2296.354003,-1937.153198,13.559414,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.354003), SetPVarFloat(npcid,"current_target_y", -1937.153198), SetPVarFloat(npcid,"current_target_z", 13.559414);
				case 3: FCNPC_GoTo(npcid,2306.047119,-1947.946533,13.566570,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.047119), SetPVarFloat(npcid,"current_target_y", -1947.946533), SetPVarFloat(npcid,"current_target_z", 13.566570);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2306.047119,-1947.946533,13.566570))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2306.246093,-1937.957397,13.578225,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.246093), SetPVarFloat(npcid,"current_target_y", -1937.957397), SetPVarFloat(npcid,"current_target_z", 13.578225);
				case 1: FCNPC_GoTo(npcid,2321.468750,-1947.979614,13.578246,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.468750), SetPVarFloat(npcid,"current_target_y", -1947.979614), SetPVarFloat(npcid,"current_target_z", 13.578246);
				case 2: FCNPC_GoTo(npcid,2306.050292,-1964.750976,13.570830,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.050292), SetPVarFloat(npcid,"current_target_y", -1964.750976), SetPVarFloat(npcid,"current_target_z", 13.570830);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2296.154785,-1937.197509,13.559220))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2306.407714,-1937.944458,13.578225,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2306.407714), SetPVarFloat(npcid,"current_target_y", -1937.944458), SetPVarFloat(npcid,"current_target_z", 13.578225);
				case 1: FCNPC_GoTo(npcid,2296.656738,-1902.095947,13.586847,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.656738), SetPVarFloat(npcid,"current_target_y", -1902.095947), SetPVarFloat(npcid,"current_target_z", 13.586847);
				case 2: FCNPC_GoTo(npcid,2272.922363,-1937.547607,13.538606,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2272.922363), SetPVarFloat(npcid,"current_target_y", -1937.547607), SetPVarFloat(npcid,"current_target_z", 13.538606);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2272.922363,-1937.547607,13.538606))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2296.436523,-1937.135375,13.559496,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2296.436523), SetPVarFloat(npcid,"current_target_y", -1937.135375), SetPVarFloat(npcid,"current_target_z", 13.559496);
				case 1: FCNPC_GoTo(npcid,2272.945312,-1901.968139,13.553826,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2272.945312), SetPVarFloat(npcid,"current_target_y", -1901.968139), SetPVarFloat(npcid,"current_target_z", 13.553826);
				case 2: FCNPC_GoTo(npcid,2249.794921,-1937.015014,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2249.794921), SetPVarFloat(npcid,"current_target_y", -1937.015014), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2249.794921,-1937.015014,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2273.100585,-1937.498779,13.538773,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2273.100585), SetPVarFloat(npcid,"current_target_y", -1937.498779), SetPVarFloat(npcid,"current_target_z", 13.538773);
				case 1: FCNPC_GoTo(npcid,2249.715332,-1902.095336,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2249.715332), SetPVarFloat(npcid,"current_target_y", -1902.095336), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2222.487548,-1937.171386,13.539317,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2222.487548), SetPVarFloat(npcid,"current_target_y", -1937.171386), SetPVarFloat(npcid,"current_target_z", 13.539317);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2344.480468,-1948.174682,13.564646))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2321.141845,-1948.042968,13.578246,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.141845), SetPVarFloat(npcid,"current_target_y", -1948.042968), SetPVarFloat(npcid,"current_target_z", 13.578246);
				case 1: FCNPC_GoTo(npcid,2344.233886,-1933.541137,13.557431,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2344.233886), SetPVarFloat(npcid,"current_target_y", -1933.541137), SetPVarFloat(npcid,"current_target_z", 13.557431);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2344.233886,-1933.541137,13.557431))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2344.458007,-1948.212524,13.564702,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2344.458007), SetPVarFloat(npcid,"current_target_y", -1948.212524), SetPVarFloat(npcid,"current_target_z", 13.564702);
				case 1: FCNPC_GoTo(npcid,2367.990966,-1934.468994,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2367.990966), SetPVarFloat(npcid,"current_target_y", -1934.468994), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2344.545898,-1913.597900,13.557391,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2344.545898), SetPVarFloat(npcid,"current_target_y", -1913.597900), SetPVarFloat(npcid,"current_target_z", 13.557391);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2344.545898,-1913.597900,13.557391))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2344.556884,-1933.661010,13.556376,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2344.556884), SetPVarFloat(npcid,"current_target_y", -1933.661010), SetPVarFloat(npcid,"current_target_z", 13.556376);
				case 1: FCNPC_GoTo(npcid,2321.635498,-1913.317138,13.598634,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2321.635498), SetPVarFloat(npcid,"current_target_y", -1913.317138), SetPVarFloat(npcid,"current_target_z", 13.598634);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2368.029541,-1934.208129,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2344.620605,-1933.690917,13.556166,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2344.620605), SetPVarFloat(npcid,"current_target_y", -1933.690917), SetPVarFloat(npcid,"current_target_z", 13.556166);
				case 1: FCNPC_GoTo(npcid,2368.357666,-1885.620727,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2368.357666), SetPVarFloat(npcid,"current_target_y", -1885.620727), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2368.357666,-1885.620727,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2368.074462,-1934.225097,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2368.074462), SetPVarFloat(npcid,"current_target_y", -1934.225097), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2405.535888,-1885.579711,13.553935,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2405.535888), SetPVarFloat(npcid,"current_target_y", -1885.579711), SetPVarFloat(npcid,"current_target_z", 13.553935);
	        }
	    }
	}
	if(GetPVarInt(npcid,"marina")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,645.568237,-1413.827636,13.579198))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,706.593811,-1413.864501,13.534967,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.593811), SetPVarFloat(npcid,"current_target_y", -1413.864501), SetPVarFloat(npcid,"current_target_z", 13.534967);
				case 1: FCNPC_GoTo(npcid,645.180480,-1578.400512,15.703382,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 645.180480), SetPVarFloat(npcid,"current_target_y", -1578.400512), SetPVarFloat(npcid,"current_target_z", 15.703382);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,706.640563,-1413.859008,13.534907))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,645.441650,-1414.000244,13.579260,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 645.441650), SetPVarFloat(npcid,"current_target_y", -1414.000244), SetPVarFloat(npcid,"current_target_z", 13.579260);
				case 1: FCNPC_GoTo(npcid,708.128784,-1436.017944,13.539162,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 708.128784), SetPVarFloat(npcid,"current_target_y", -1436.017944), SetPVarFloat(npcid,"current_target_z", 13.539162);
				case 2: FCNPC_GoTo(npcid,769.058227,-1412.890625,13.529929,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 769.058227), SetPVarFloat(npcid,"current_target_y", -1412.890625), SetPVarFloat(npcid,"current_target_z", 13.529929);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,769.058227,-1412.890625,13.529929))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,706.588195,-1413.856689,13.534987,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.588195), SetPVarFloat(npcid,"current_target_y", -1413.856689), SetPVarFloat(npcid,"current_target_z", 13.534987);
				case 1: FCNPC_GoTo(npcid,768.608215,-1434.473999,13.534936,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 768.608215), SetPVarFloat(npcid,"current_target_y", -1434.473999), SetPVarFloat(npcid,"current_target_z", 13.534936);
				case 2: FCNPC_GoTo(npcid,789.389404,-1413.409667,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.389404), SetPVarFloat(npcid,"current_target_y", -1413.409667), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,708.083190,-1436.014892,13.539162))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,706.618225,-1413.940795,13.534819,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.618225), SetPVarFloat(npcid,"current_target_y", -1413.940795), SetPVarFloat(npcid,"current_target_z", 13.534819);
				case 1: FCNPC_GoTo(npcid,768.669921,-1434.518920,13.535065,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 768.669921), SetPVarFloat(npcid,"current_target_y", -1434.518920), SetPVarFloat(npcid,"current_target_z", 13.535065);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,768.669921,-1434.518920,13.535065))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,769.155517,-1412.883544,13.529973,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 769.155517), SetPVarFloat(npcid,"current_target_y", -1412.883544), SetPVarFloat(npcid,"current_target_z", 13.529973);
				case 1: FCNPC_GoTo(npcid,708.263000,-1435.967407,13.539162,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 708.263000), SetPVarFloat(npcid,"current_target_y", -1435.967407), SetPVarFloat(npcid,"current_target_z", 13.539162);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,789.355957,-1413.373046,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,769.257385,-1412.859375,13.530069,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 769.257385), SetPVarFloat(npcid,"current_target_y", -1412.859375), SetPVarFloat(npcid,"current_target_z", 13.530069);
				case 1: FCNPC_GoTo(npcid,789.452392,-1442.962890,13.547011,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.452392), SetPVarFloat(npcid,"current_target_y", -1442.962890), SetPVarFloat(npcid,"current_target_z", 13.547011);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,789.452392,-1442.962890,13.547011))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,789.396179,-1413.369140,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.396179), SetPVarFloat(npcid,"current_target_y", -1413.369140), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,785.353027,-1480.500610,13.552512,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 785.353027), SetPVarFloat(npcid,"current_target_y", -1480.500610), SetPVarFloat(npcid,"current_target_z", 13.552512);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,785.353027,-1480.500610,13.552512))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,789.428100,-1442.932861,13.547011,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.428100), SetPVarFloat(npcid,"current_target_y", -1442.932861), SetPVarFloat(npcid,"current_target_z", 13.547011);
				case 1: FCNPC_GoTo(npcid,769.343139,-1542.313842,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 769.343139), SetPVarFloat(npcid,"current_target_y", -1542.313842), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,769.343139,-1542.313842,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,785.377319,-1480.480834,13.552564,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 785.377319), SetPVarFloat(npcid,"current_target_y", -1480.480834), SetPVarFloat(npcid,"current_target_z", 13.552564);
				case 1: FCNPC_GoTo(npcid,763.579528,-1579.106689,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 763.579528), SetPVarFloat(npcid,"current_target_y", -1579.106689), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,763.579528,-1579.106689,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,769.187805,-1542.209228,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 769.187805), SetPVarFloat(npcid,"current_target_y", -1542.209228), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,762.489562,-1594.396606,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 762.489562), SetPVarFloat(npcid,"current_target_y", -1594.396606), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,746.899169,-1578.437622,14.122534,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 746.899169), SetPVarFloat(npcid,"current_target_y", -1578.437622), SetPVarFloat(npcid,"current_target_z", 14.122534);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,762.398437,-1594.269897,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,759.173522,-1594.512939,13.603461,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 759.173522), SetPVarFloat(npcid,"current_target_y", -1594.512939), SetPVarFloat(npcid,"current_target_z", 13.603461);
				case 1: FCNPC_GoTo(npcid,787.946472,-1594.201782,13.382912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 787.946472), SetPVarFloat(npcid,"current_target_y", -1594.201782), SetPVarFloat(npcid,"current_target_z", 13.382912);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,787.946472,-1594.201782,13.382912))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,762.389526,-1594.429565,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 762.389526), SetPVarFloat(npcid,"current_target_y", -1594.429565), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,810.209594,-1599.708740,13.548933,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 810.209594), SetPVarFloat(npcid,"current_target_y", -1599.708740), SetPVarFloat(npcid,"current_target_z", 13.548933);
				case 2: FCNPC_GoTo(npcid,789.083374,-1629.418334,13.382912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.083374), SetPVarFloat(npcid,"current_target_y", -1629.418334), SetPVarFloat(npcid,"current_target_z", 13.382912);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,789.083374,-1629.418334,13.382912))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,787.838867,-1594.277587,13.382912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 787.838867), SetPVarFloat(npcid,"current_target_y", -1594.277587), SetPVarFloat(npcid,"current_target_z", 13.382912);
				case 1: FCNPC_GoTo(npcid,811.028503,-1629.889770,13.382912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 811.028503), SetPVarFloat(npcid,"current_target_y", -1629.889770), SetPVarFloat(npcid,"current_target_z", 13.382912);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,810.107055,-1599.554565,13.548633))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,787.734741,-1594.195800,13.382912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 787.734741), SetPVarFloat(npcid,"current_target_y", -1594.195800), SetPVarFloat(npcid,"current_target_z", 13.382912);
				case 1: FCNPC_GoTo(npcid,826.143615,-1613.045410,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 826.143615), SetPVarFloat(npcid,"current_target_y", -1613.045410), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,826.143615,-1613.045410,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,809.994384,-1599.588012,13.548501,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 809.994384), SetPVarFloat(npcid,"current_target_y", -1599.588012), SetPVarFloat(npcid,"current_target_z", 13.548501);
				case 1: FCNPC_GoTo(npcid,811.199584,-1630.229003,13.382912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 811.199584), SetPVarFloat(npcid,"current_target_y", -1630.229003), SetPVarFloat(npcid,"current_target_z", 13.382912);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,811.199584,-1630.229003,13.382912))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,826.292175,-1612.910400,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 826.292175), SetPVarFloat(npcid,"current_target_y", -1612.910400), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,807.585754,-1635.391113,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 807.585754), SetPVarFloat(npcid,"current_target_y", -1635.391113), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,789.405029,-1629.373535,13.382912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.405029), SetPVarFloat(npcid,"current_target_y", -1629.373535), SetPVarFloat(npcid,"current_target_z", 13.382912);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,807.678100,-1635.485351,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,811.106689,-1630.083740,13.382912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 811.106689), SetPVarFloat(npcid,"current_target_y", -1630.083740), SetPVarFloat(npcid,"current_target_z", 13.382912);
				case 1: FCNPC_GoTo(npcid,801.711608,-1667.081909,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 801.711608), SetPVarFloat(npcid,"current_target_y", -1667.081909), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,801.711608,-1667.081909,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,807.955688,-1635.509155,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 807.955688), SetPVarFloat(npcid,"current_target_y", -1635.509155), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,775.309814,-1666.689819,13.395655,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 775.309814), SetPVarFloat(npcid,"current_target_y", -1666.689819), SetPVarFloat(npcid,"current_target_z", 13.395655);
				case 2: FCNPC_GoTo(npcid,801.946716,-1683.090820,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 801.946716), SetPVarFloat(npcid,"current_target_y", -1683.090820), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,801.946716,-1683.090820,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,802.384338,-1666.952392,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 802.384338), SetPVarFloat(npcid,"current_target_y", -1666.952392), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,775.262268,-1682.413940,13.386589,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 775.262268), SetPVarFloat(npcid,"current_target_y", -1682.413940), SetPVarFloat(npcid,"current_target_z", 13.386589);
				case 2: FCNPC_GoTo(npcid,802.410949,-1762.036743,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 802.410949), SetPVarFloat(npcid,"current_target_y", -1762.036743), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,802.410949,-1762.036743,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,802.571166,-1682.795654,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 802.571166), SetPVarFloat(npcid,"current_target_y", -1682.795654), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,761.143005,-1757.891723,13.007744,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 761.143005), SetPVarFloat(npcid,"current_target_y", -1757.891723), SetPVarFloat(npcid,"current_target_z", 13.007744);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,761.143005,-1757.891723,13.007744))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,802.602966,-1762.088623,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 802.602966), SetPVarFloat(npcid,"current_target_y", -1762.088623), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,762.816650,-1747.820434,12.632912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 762.816650), SetPVarFloat(npcid,"current_target_y", -1747.820434), SetPVarFloat(npcid,"current_target_z", 12.632912);
				case 2: FCNPC_GoTo(npcid,746.758605,-1755.259033,13.088770,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 746.758605), SetPVarFloat(npcid,"current_target_y", -1755.259033), SetPVarFloat(npcid,"current_target_z", 13.088770);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,746.758605,-1755.259033,13.088770))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,761.180480,-1758.040161,13.007744,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 761.180480), SetPVarFloat(npcid,"current_target_y", -1758.040161), SetPVarFloat(npcid,"current_target_z", 13.007744);
				case 1: FCNPC_GoTo(npcid,747.210449,-1747.393066,12.667124,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 747.210449), SetPVarFloat(npcid,"current_target_y", -1747.393066), SetPVarFloat(npcid,"current_target_z", 12.667124);
				case 2: FCNPC_GoTo(npcid,733.880310,-1752.070434,14.515111,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 733.880310), SetPVarFloat(npcid,"current_target_y", -1752.070434), SetPVarFloat(npcid,"current_target_z", 14.515111);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,733.880310,-1752.070434,14.515111))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,746.554870,-1755.433959,13.094449,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 746.554870), SetPVarFloat(npcid,"current_target_y", -1755.433959), SetPVarFloat(npcid,"current_target_z", 13.094449);
				case 1: FCNPC_GoTo(npcid,705.447998,-1742.521484,14.010529,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 705.447998), SetPVarFloat(npcid,"current_target_y", -1742.521484), SetPVarFloat(npcid,"current_target_z", 14.010529);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,705.447998,-1742.521484,14.010529))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,706.164367,-1737.453735,13.921043,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.164367), SetPVarFloat(npcid,"current_target_y", -1737.453735), SetPVarFloat(npcid,"current_target_z", 13.921043);
				case 1: FCNPC_GoTo(npcid,733.909729,-1752.259399,14.505848,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 733.909729), SetPVarFloat(npcid,"current_target_y", -1752.259399), SetPVarFloat(npcid,"current_target_z", 14.505848);
				case 2: FCNPC_GoTo(npcid,642.332763,-1723.553710,14.073401,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 642.332763), SetPVarFloat(npcid,"current_target_y", -1723.553710), SetPVarFloat(npcid,"current_target_z", 14.073401);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,642.332763,-1723.553710,14.073401))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,705.446228,-1742.749511,14.013216,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 705.446228), SetPVarFloat(npcid,"current_target_y", -1742.749511), SetPVarFloat(npcid,"current_target_z", 14.013216);
				case 1: FCNPC_GoTo(npcid,644.267456,-1714.549926,14.325918,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 644.267456), SetPVarFloat(npcid,"current_target_y", -1714.549926), SetPVarFloat(npcid,"current_target_z", 14.325918);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,643.979919,-1714.528442,14.324209))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,642.452819,-1723.912963,14.071619,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 642.452819), SetPVarFloat(npcid,"current_target_y", -1723.912963), SetPVarFloat(npcid,"current_target_z", 14.071619);
				case 1: FCNPC_GoTo(npcid,646.780273,-1680.042602,14.891076,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 646.780273), SetPVarFloat(npcid,"current_target_y", -1680.042602), SetPVarFloat(npcid,"current_target_z", 14.891076);
	        }
	    }	    if(IsPlayerInRangeOfPoint(npcid,3.0,646.778198,-1679.972412,14.891344))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,644.074829,-1714.591918,14.323175,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 644.074829), SetPVarFloat(npcid,"current_target_y", -1714.591918), SetPVarFloat(npcid,"current_target_z", 14.323175);
				case 1: FCNPC_GoTo(npcid,647.398620,-1663.757568,14.883465,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 647.398620), SetPVarFloat(npcid,"current_target_y", -1663.757568), SetPVarFloat(npcid,"current_target_z", 14.883465);
				case 2: FCNPC_GoTo(npcid,667.400146,-1680.558593,13.754981,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 667.400146), SetPVarFloat(npcid,"current_target_y", -1680.558593), SetPVarFloat(npcid,"current_target_z", 13.754981);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,647.373046,-1663.921142,14.884621))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,646.715270,-1680.113769,14.893362,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 646.715270), SetPVarFloat(npcid,"current_target_y", -1680.113769), SetPVarFloat(npcid,"current_target_z", 14.893362);
				case 1: FCNPC_GoTo(npcid,666.796386,-1665.056396,13.817013,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 666.796386), SetPVarFloat(npcid,"current_target_y", -1665.056396), SetPVarFloat(npcid,"current_target_z", 13.817013);
				case 2: FCNPC_GoTo(npcid,645.596252,-1593.954467,15.719346,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 645.596252), SetPVarFloat(npcid,"current_target_y", -1593.954467), SetPVarFloat(npcid,"current_target_z", 15.719346);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,645.596252,-1593.954467,15.719346))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,647.266418,-1663.921997,14.889939,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 647.266418), SetPVarFloat(npcid,"current_target_y", -1663.921997), SetPVarFloat(npcid,"current_target_z", 14.889939);
				case 1: FCNPC_GoTo(npcid,675.412353,-1594.203613,14.138691,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.412353), SetPVarFloat(npcid,"current_target_y", -1594.203613), SetPVarFloat(npcid,"current_target_z", 14.138691);
				case 2: FCNPC_GoTo(npcid,645.238220,-1578.325439,15.702527,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 645.238220), SetPVarFloat(npcid,"current_target_y", -1578.325439), SetPVarFloat(npcid,"current_target_z", 15.702527);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,645.238220,-1578.325439,15.702527))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,645.586181,-1593.753051,15.719599,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 645.586181), SetPVarFloat(npcid,"current_target_y", -1593.753051), SetPVarFloat(npcid,"current_target_z", 15.719599);
				case 1: FCNPC_GoTo(npcid,675.016113,-1578.741943,14.187392,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.016113), SetPVarFloat(npcid,"current_target_y", -1578.741943), SetPVarFloat(npcid,"current_target_z", 14.187392);
				case 2: FCNPC_GoTo(npcid,645.469604,-1413.708251,13.579928,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 645.469604), SetPVarFloat(npcid,"current_target_y", -1413.708251), SetPVarFloat(npcid,"current_target_z", 13.579928);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,759.172302,-1594.427490,13.601671))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,759.500976,-1606.553222,13.243951,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 759.500976), SetPVarFloat(npcid,"current_target_y", -1606.553222), SetPVarFloat(npcid,"current_target_z", 13.243951);
				case 1: FCNPC_GoTo(npcid,762.535095,-1594.458984,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 762.535095), SetPVarFloat(npcid,"current_target_y", -1594.458984), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,743.260925,-1594.169067,14.285653,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 743.260925), SetPVarFloat(npcid,"current_target_y", -1594.169067), SetPVarFloat(npcid,"current_target_z", 14.285653);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,743.423583,-1594.251342,14.279179))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,743.693176,-1602.398437,13.708740,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 743.693176), SetPVarFloat(npcid,"current_target_y", -1602.398437), SetPVarFloat(npcid,"current_target_z", 13.708740);
				case 1: FCNPC_GoTo(npcid,759.246765,-1594.418701,13.598569,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 759.246765), SetPVarFloat(npcid,"current_target_y", -1594.418701), SetPVarFloat(npcid,"current_target_z", 13.598569);
				case 2: FCNPC_GoTo(npcid,705.961608,-1594.095825,14.142366,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 705.961608), SetPVarFloat(npcid,"current_target_y", -1594.095825), SetPVarFloat(npcid,"current_target_z", 14.142366);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,705.961608,-1594.095825,14.142366))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,706.083740,-1597.662963,14.156019,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.083740), SetPVarFloat(npcid,"current_target_y", -1597.662963), SetPVarFloat(npcid,"current_target_z", 14.156019);
				case 1: FCNPC_GoTo(npcid,743.303222,-1594.265991,14.284412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 743.303222), SetPVarFloat(npcid,"current_target_y", -1594.265991), SetPVarFloat(npcid,"current_target_z", 14.284412);
				case 2: FCNPC_GoTo(npcid,705.204223,-1579.031372,14.198497,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 705.204223), SetPVarFloat(npcid,"current_target_y", -1579.031372), SetPVarFloat(npcid,"current_target_z", 14.198497);
				case 3: FCNPC_GoTo(npcid,675.360961,-1593.894165,14.139189,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.360961), SetPVarFloat(npcid,"current_target_y", -1593.894165), SetPVarFloat(npcid,"current_target_z", 14.139189);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,675.360961,-1593.894165,14.139189))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,706.104431,-1594.163940,14.143064,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.104431), SetPVarFloat(npcid,"current_target_y", -1594.163940), SetPVarFloat(npcid,"current_target_z", 14.143064);
				case 1: FCNPC_GoTo(npcid,675.013793,-1578.771728,14.186380,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.013793), SetPVarFloat(npcid,"current_target_y", -1578.771728), SetPVarFloat(npcid,"current_target_z", 14.186380);
				case 2: FCNPC_GoTo(npcid,645.472961,-1594.192993,15.719145,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 645.472961), SetPVarFloat(npcid,"current_target_y", -1594.192993), SetPVarFloat(npcid,"current_target_z", 15.719145);
				case 3: FCNPC_GoTo(npcid,675.559631,-1619.465576,8.703225,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.559631), SetPVarFloat(npcid,"current_target_y", -1619.465576), SetPVarFloat(npcid,"current_target_z", 8.703225);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,746.904968,-1578.360107,14.122347))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,763.727539,-1579.004882,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 763.727539), SetPVarFloat(npcid,"current_target_y", -1579.004882), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,759.161560,-1594.738159,13.608774,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 759.161560), SetPVarFloat(npcid,"current_target_y", -1594.738159), SetPVarFloat(npcid,"current_target_z", 13.608774);
				case 2: FCNPC_GoTo(npcid,705.043090,-1578.714965,14.203330,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 705.043090), SetPVarFloat(npcid,"current_target_y", -1578.714965), SetPVarFloat(npcid,"current_target_z", 14.203330);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,705.043090,-1578.714965,14.203330))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,746.806091,-1578.788940,14.125980,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 746.806091), SetPVarFloat(npcid,"current_target_y", -1578.788940), SetPVarFloat(npcid,"current_target_z", 14.125980);
				case 1: FCNPC_GoTo(npcid,706.131347,-1594.183105,14.143195,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.131347), SetPVarFloat(npcid,"current_target_y", -1594.183105), SetPVarFloat(npcid,"current_target_z", 14.143195);
				case 2: FCNPC_GoTo(npcid,675.079467,-1578.637207,14.189225,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.079467), SetPVarFloat(npcid,"current_target_y", -1578.637207), SetPVarFloat(npcid,"current_target_z", 14.189225);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,675.079467,-1578.637207,14.189225))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,705.465698,-1578.820800,14.206397,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 705.465698), SetPVarFloat(npcid,"current_target_y", -1578.820800), SetPVarFloat(npcid,"current_target_z", 14.206397);
				case 1: FCNPC_GoTo(npcid,675.373718,-1593.902099,14.138779,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.373718), SetPVarFloat(npcid,"current_target_y", -1593.902099), SetPVarFloat(npcid,"current_target_z", 14.138779);
				case 2: FCNPC_GoTo(npcid,645.101745,-1578.321899,15.703575,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 645.101745), SetPVarFloat(npcid,"current_target_y", -1578.321899), SetPVarFloat(npcid,"current_target_z", 15.703575);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,759.503479,-1606.428222,13.247707))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,759.297058,-1618.272827,11.371797,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 759.297058), SetPVarFloat(npcid,"current_target_y", -1618.272827), SetPVarFloat(npcid,"current_target_z", 11.371797);
				case 1: FCNPC_GoTo(npcid,759.246643,-1594.391357,13.597986,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 759.246643), SetPVarFloat(npcid,"current_target_y", -1594.391357), SetPVarFloat(npcid,"current_target_z", 13.597986);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,759.258422,-1618.426269,11.343334))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,759.517761,-1606.534423,13.244516,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 759.517761), SetPVarFloat(npcid,"current_target_y", -1606.534423), SetPVarFloat(npcid,"current_target_z", 13.244516);
				case 1: FCNPC_GoTo(npcid,759.574279,-1641.968627,5.930775,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 759.574279), SetPVarFloat(npcid,"current_target_y", -1641.968627), SetPVarFloat(npcid,"current_target_z", 5.930775);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,759.574279,-1641.968627,5.930775))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,759.218139,-1618.214965,11.382530,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 759.218139), SetPVarFloat(npcid,"current_target_y", -1618.214965), SetPVarFloat(npcid,"current_target_z", 11.382530);
				case 1: FCNPC_GoTo(npcid,760.120117,-1670.177001,4.146702,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 760.120117), SetPVarFloat(npcid,"current_target_y", -1670.177001), SetPVarFloat(npcid,"current_target_z", 4.146702);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,760.120117,-1670.177001,4.146702))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,759.508728,-1641.771240,5.951323,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 759.508728), SetPVarFloat(npcid,"current_target_y", -1641.771240), SetPVarFloat(npcid,"current_target_z", 5.951323);
				case 1: FCNPC_GoTo(npcid,745.590393,-1669.848022,4.155471,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 745.590393), SetPVarFloat(npcid,"current_target_y", -1669.848022), SetPVarFloat(npcid,"current_target_z", 4.155471);
				case 2: FCNPC_GoTo(npcid,761.635131,-1693.012329,4.617929,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 761.635131), SetPVarFloat(npcid,"current_target_y", -1693.012329), SetPVarFloat(npcid,"current_target_z", 4.617929);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,761.635131,-1693.012329,4.617929))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,760.138732,-1670.170410,4.146716,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 760.138732), SetPVarFloat(npcid,"current_target_y", -1670.170410), SetPVarFloat(npcid,"current_target_z", 4.146716);
				case 1: FCNPC_GoTo(npcid,762.327514,-1710.560913,6.518015,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 762.327514), SetPVarFloat(npcid,"current_target_y", -1710.560913), SetPVarFloat(npcid,"current_target_z", 6.518015);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,762.327514,-1710.560913,6.518015))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,761.832763,-1692.765014,4.604065,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 761.832763), SetPVarFloat(npcid,"current_target_y", -1692.765014), SetPVarFloat(npcid,"current_target_z", 4.604065);
				case 1: FCNPC_GoTo(npcid,762.821899,-1747.783325,12.631089,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 762.821899), SetPVarFloat(npcid,"current_target_y", -1747.783325), SetPVarFloat(npcid,"current_target_z", 12.631089);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,762.821899,-1747.783325,12.631089))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,762.340698,-1710.403930,6.496642,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 762.340698), SetPVarFloat(npcid,"current_target_y", -1710.403930), SetPVarFloat(npcid,"current_target_z", 6.496642);
				case 1: FCNPC_GoTo(npcid,747.145080,-1747.319091,12.662322,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 747.145080), SetPVarFloat(npcid,"current_target_y", -1747.319091), SetPVarFloat(npcid,"current_target_z", 12.662322);
				case 2: FCNPC_GoTo(npcid,761.681274,-1758.052490,13.007744,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 761.681274), SetPVarFloat(npcid,"current_target_y", -1758.052490), SetPVarFloat(npcid,"current_target_z", 13.007744);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,747.091369,-1747.431762,12.670348))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,746.813232,-1755.377807,13.090181,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 746.813232), SetPVarFloat(npcid,"current_target_y", -1755.377807), SetPVarFloat(npcid,"current_target_z", 13.090181);
				case 1: FCNPC_GoTo(npcid,762.830078,-1747.866210,12.635162,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 762.830078), SetPVarFloat(npcid,"current_target_y", -1747.866210), SetPVarFloat(npcid,"current_target_z", 12.635162);
				case 2: FCNPC_GoTo(npcid,747.369628,-1709.758666,6.371296,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 747.369628), SetPVarFloat(npcid,"current_target_y", -1709.758666), SetPVarFloat(npcid,"current_target_z", 6.371296);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,747.369628,-1709.758666,6.371296))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,746.943542,-1747.523193,12.677346,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 746.943542), SetPVarFloat(npcid,"current_target_y", -1747.523193), SetPVarFloat(npcid,"current_target_z", 12.677346);
				case 1: FCNPC_GoTo(npcid,762.305175,-1710.495117,6.509016,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 762.305175), SetPVarFloat(npcid,"current_target_y", -1710.495117), SetPVarFloat(npcid,"current_target_z", 6.509016);
				case 2: FCNPC_GoTo(npcid,746.631713,-1692.694580,4.566306,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 746.631713), SetPVarFloat(npcid,"current_target_y", -1692.694580), SetPVarFloat(npcid,"current_target_z", 4.566306);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,746.631713,-1692.694580,4.566306))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,747.124755,-1709.611083,6.350503,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 747.124755), SetPVarFloat(npcid,"current_target_y", -1709.611083), SetPVarFloat(npcid,"current_target_z", 6.350503);
				case 1: FCNPC_GoTo(npcid,761.750488,-1693.064819,4.621102,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 761.750488), SetPVarFloat(npcid,"current_target_y", -1693.064819), SetPVarFloat(npcid,"current_target_z", 4.621102);
				case 2: FCNPC_GoTo(npcid,745.778930,-1669.659423,4.156301,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 745.778930), SetPVarFloat(npcid,"current_target_y", -1669.659423), SetPVarFloat(npcid,"current_target_z", 4.156301);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,745.778930,-1669.659423,4.156301))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,746.989257,-1692.632812,4.563250,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 746.989257), SetPVarFloat(npcid,"current_target_y", -1692.632812), SetPVarFloat(npcid,"current_target_z", 4.563250);
				case 1: FCNPC_GoTo(npcid,760.120788,-1670.101562,4.147070,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 760.120788), SetPVarFloat(npcid,"current_target_y", -1670.101562), SetPVarFloat(npcid,"current_target_z", 4.147070);
				case 2: FCNPC_GoTo(npcid,744.036071,-1640.425048,6.100188,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 744.036071), SetPVarFloat(npcid,"current_target_y", -1640.425048), SetPVarFloat(npcid,"current_target_z", 6.100188);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,744.036071,-1640.425048,6.100188))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,745.523376,-1669.915649,4.155174,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 745.523376), SetPVarFloat(npcid,"current_target_y", -1669.915649), SetPVarFloat(npcid,"current_target_z", 4.155174);
				case 1: FCNPC_GoTo(npcid,743.835388,-1602.419433,13.700749,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 743.835388), SetPVarFloat(npcid,"current_target_y", -1602.419433), SetPVarFloat(npcid,"current_target_z", 13.700749);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,706.017761,-1597.698852,14.156186))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,706.201477,-1594.089965,14.143538,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.201477), SetPVarFloat(npcid,"current_target_y", -1594.089965), SetPVarFloat(npcid,"current_target_z", 14.143538);
				case 1: FCNPC_GoTo(npcid,706.296203,-1605.471435,9.126143,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.296203), SetPVarFloat(npcid,"current_target_y", -1605.471435), SetPVarFloat(npcid,"current_target_z", 9.126143);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,706.296203,-1605.471435,9.126143))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,706.118957,-1597.769165,14.156512,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.118957), SetPVarFloat(npcid,"current_target_y", -1597.769165), SetPVarFloat(npcid,"current_target_z", 14.156512);
				case 1: FCNPC_GoTo(npcid,706.206054,-1610.456298,9.126143,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.206054), SetPVarFloat(npcid,"current_target_y", -1610.456298), SetPVarFloat(npcid,"current_target_z", 9.126143);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,706.206054,-1610.456298,9.126143))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,706.229614,-1605.607177,9.126143,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.229614), SetPVarFloat(npcid,"current_target_y", -1605.607177), SetPVarFloat(npcid,"current_target_z", 9.126143);
				case 1: FCNPC_GoTo(npcid,706.445251,-1619.902832,3.437599,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.445251), SetPVarFloat(npcid,"current_target_y", -1619.902832), SetPVarFloat(npcid,"current_target_z", 3.437599);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,706.445251,-1619.902832,3.437599))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,706.255981,-1610.518066,9.126143,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.255981), SetPVarFloat(npcid,"current_target_y", -1610.518066), SetPVarFloat(npcid,"current_target_z", 9.126143);
				case 1: FCNPC_GoTo(npcid,706.206848,-1715.001098,3.437599,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.206848), SetPVarFloat(npcid,"current_target_y", -1715.001098), SetPVarFloat(npcid,"current_target_z", 3.437599);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,706.206848,-1715.001098,3.437599))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,706.382019,-1619.871337,3.437599,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.382019), SetPVarFloat(npcid,"current_target_y", -1619.871337), SetPVarFloat(npcid,"current_target_z", 3.437599);
				case 1: FCNPC_GoTo(npcid,706.287292,-1723.351440,8.687670,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.287292), SetPVarFloat(npcid,"current_target_y", -1723.351440), SetPVarFloat(npcid,"current_target_z", 8.687670);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,706.287292,-1723.351440,8.687670))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,706.263977,-1726.060180,8.684782,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.263977), SetPVarFloat(npcid,"current_target_y", -1726.060180), SetPVarFloat(npcid,"current_target_z", 8.684782);
				case 1: FCNPC_GoTo(npcid,706.207275,-1715.094116,3.437599,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.207275), SetPVarFloat(npcid,"current_target_y", -1715.094116), SetPVarFloat(npcid,"current_target_z", 3.437599);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,706.214965,-1726.234497,8.684640))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,706.225463,-1723.388793,8.688008,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.225463), SetPVarFloat(npcid,"current_target_y", -1723.388793), SetPVarFloat(npcid,"current_target_z", 8.688008);
				case 1: FCNPC_GoTo(npcid,685.569702,-1726.828491,8.703225,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 685.569702), SetPVarFloat(npcid,"current_target_y", -1726.828491), SetPVarFloat(npcid,"current_target_z", 8.703225);
				case 2: FCNPC_GoTo(npcid,706.239807,-1729.451171,8.687600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.239807), SetPVarFloat(npcid,"current_target_y", -1729.451171), SetPVarFloat(npcid,"current_target_z", 8.687600);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,706.239807,-1729.451171,8.687600))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,706.240417,-1726.290771,8.684535,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.240417), SetPVarFloat(npcid,"current_target_y", -1726.290771), SetPVarFloat(npcid,"current_target_z", 8.684535);
				case 1: FCNPC_GoTo(npcid,706.252868,-1737.088012,13.937939,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.252868), SetPVarFloat(npcid,"current_target_y", -1737.088012), SetPVarFloat(npcid,"current_target_z", 13.937939);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,706.252868,-1737.088012,13.937939))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,706.275512,-1729.365112,8.687600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.275512), SetPVarFloat(npcid,"current_target_y", -1729.365112), SetPVarFloat(npcid,"current_target_z", 8.687600);
				case 1: FCNPC_GoTo(npcid,705.499084,-1742.849121,14.017446,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 705.499084), SetPVarFloat(npcid,"current_target_y", -1742.849121), SetPVarFloat(npcid,"current_target_z", 14.017446);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,685.717468,-1726.836791,8.703225))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,706.209960,-1726.347656,8.684510,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 706.209960), SetPVarFloat(npcid,"current_target_y", -1726.347656), SetPVarFloat(npcid,"current_target_z", 8.684510);
				case 1: FCNPC_GoTo(npcid,676.809082,-1719.527832,8.699350,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 676.809082), SetPVarFloat(npcid,"current_target_y", -1719.527832), SetPVarFloat(npcid,"current_target_z", 8.699350);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,676.809082,-1719.527832,8.699350))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,685.520202,-1727.069580,8.703225,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 685.520202), SetPVarFloat(npcid,"current_target_y", -1727.069580), SetPVarFloat(npcid,"current_target_z", 8.703225);
				case 1: FCNPC_GoTo(npcid,675.466430,-1707.780273,8.705851,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.466430), SetPVarFloat(npcid,"current_target_y", -1707.780273), SetPVarFloat(npcid,"current_target_z", 8.705851);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,675.466430,-1707.780273,8.705851))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,676.641540,-1719.511718,8.699600,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 676.641540), SetPVarFloat(npcid,"current_target_y", -1719.511718), SetPVarFloat(npcid,"current_target_z", 8.699600);
				case 1: FCNPC_GoTo(npcid,675.722045,-1681.566406,8.705477,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.722045), SetPVarFloat(npcid,"current_target_y", -1681.566406), SetPVarFloat(npcid,"current_target_z", 8.705477);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,675.722045,-1681.566406,8.705477))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,675.557739,-1707.908081,8.705718,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.557739), SetPVarFloat(npcid,"current_target_y", -1707.908081), SetPVarFloat(npcid,"current_target_z", 8.705718);
				case 1: FCNPC_GoTo(npcid,675.606750,-1619.437133,8.703225,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.606750), SetPVarFloat(npcid,"current_target_y", -1619.437133), SetPVarFloat(npcid,"current_target_z", 8.703225);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,675.606750,-1619.437133,8.703225))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,675.727722,-1681.667480,8.705469,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.727722), SetPVarFloat(npcid,"current_target_y", -1681.667480), SetPVarFloat(npcid,"current_target_z", 8.705469);
				case 1: FCNPC_GoTo(npcid,675.299987,-1593.844116,14.141097,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 675.299987), SetPVarFloat(npcid,"current_target_y", -1593.844116), SetPVarFloat(npcid,"current_target_z", 14.141097);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,775.290222,-1666.717041,13.395525))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,802.578308,-1667.127075,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 802.578308), SetPVarFloat(npcid,"current_target_y", -1667.127075), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,775.178039,-1682.594848,13.386487,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 775.178039), SetPVarFloat(npcid,"current_target_y", -1682.594848), SetPVarFloat(npcid,"current_target_z", 13.386487);
				case 2: FCNPC_GoTo(npcid,759.915527,-1666.722167,12.317424,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 759.915527), SetPVarFloat(npcid,"current_target_y", -1666.722167), SetPVarFloat(npcid,"current_target_z", 12.317424);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,759.915527,-1666.722167,12.317424))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,775.173034,-1666.980712,13.394753,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 775.173034), SetPVarFloat(npcid,"current_target_y", -1666.980712), SetPVarFloat(npcid,"current_target_z", 13.394753);
				case 1: FCNPC_GoTo(npcid,761.983581,-1681.688720,12.517342,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 761.983581), SetPVarFloat(npcid,"current_target_y", -1681.688720), SetPVarFloat(npcid,"current_target_z", 12.517342);
				case 2: FCNPC_GoTo(npcid,739.486999,-1666.432983,10.662042,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 739.486999), SetPVarFloat(npcid,"current_target_y", -1666.432983), SetPVarFloat(npcid,"current_target_z", 10.662042);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,739.486999,-1666.432983,10.662042))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,760.093750,-1666.735351,12.334168,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 760.093750), SetPVarFloat(npcid,"current_target_y", -1666.735351), SetPVarFloat(npcid,"current_target_z", 12.334168);
				case 1: FCNPC_GoTo(npcid,739.571289,-1681.173339,10.716856,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 739.571289), SetPVarFloat(npcid,"current_target_y", -1681.173339), SetPVarFloat(npcid,"current_target_z", 10.716856);
				case 2: FCNPC_GoTo(npcid,714.649291,-1666.215576,10.722690,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 714.649291), SetPVarFloat(npcid,"current_target_y", -1666.215576), SetPVarFloat(npcid,"current_target_z", 10.722690);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,714.649291,-1666.215576,10.722689))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,739.602600,-1666.394287,10.661845,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 739.602600), SetPVarFloat(npcid,"current_target_y", -1666.394287), SetPVarFloat(npcid,"current_target_z", 10.661845);
				case 1: FCNPC_GoTo(npcid,715.944274,-1681.175659,10.712356,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 715.944274), SetPVarFloat(npcid,"current_target_y", -1681.175659), SetPVarFloat(npcid,"current_target_z", 10.712356);
				case 2: FCNPC_GoTo(npcid,682.370910,-1665.640014,12.244705,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 682.370910), SetPVarFloat(npcid,"current_target_y", -1665.640014), SetPVarFloat(npcid,"current_target_z", 12.244705);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,682.370910,-1665.640014,12.244705))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,714.950073,-1666.615478,10.709675,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 714.950073), SetPVarFloat(npcid,"current_target_y", -1666.615478), SetPVarFloat(npcid,"current_target_z", 10.709675);
				case 1: FCNPC_GoTo(npcid,666.687500,-1664.836547,13.824422,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 666.687500), SetPVarFloat(npcid,"current_target_y", -1664.836547), SetPVarFloat(npcid,"current_target_z", 13.824422);
				case 2: FCNPC_GoTo(npcid,682.590942,-1680.840698,12.187911,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 682.590942), SetPVarFloat(npcid,"current_target_y", -1680.840698), SetPVarFloat(npcid,"current_target_z", 12.187911);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,666.630615,-1664.942382,13.828022))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,682.444335,-1665.906005,12.236914,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 682.444335), SetPVarFloat(npcid,"current_target_y", -1665.906005), SetPVarFloat(npcid,"current_target_z", 12.236914);
				case 1: FCNPC_GoTo(npcid,667.113342,-1680.360473,13.771447,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 667.113342), SetPVarFloat(npcid,"current_target_y", -1680.360473), SetPVarFloat(npcid,"current_target_z", 13.771447);
				case 2: FCNPC_GoTo(npcid,647.258972,-1663.971069,14.890274,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 647.258972), SetPVarFloat(npcid,"current_target_y", -1663.971069), SetPVarFloat(npcid,"current_target_z", 14.890274);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,667.267272,-1680.503173,13.762574))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,646.770263,-1679.937866,14.891738,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 646.770263), SetPVarFloat(npcid,"current_target_y", -1679.937866), SetPVarFloat(npcid,"current_target_z", 14.891738);
				case 1: FCNPC_GoTo(npcid,682.947326,-1680.732543,12.159892,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 682.947326), SetPVarFloat(npcid,"current_target_y", -1680.732543), SetPVarFloat(npcid,"current_target_z", 12.159892);
				case 2: FCNPC_GoTo(npcid,666.706298,-1664.870361,13.823147,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 666.706298), SetPVarFloat(npcid,"current_target_y", -1664.870361), SetPVarFloat(npcid,"current_target_z", 13.823147);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,682.752624,-1680.919677,12.170613))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,667.321899,-1680.578491,13.759401,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 667.321899), SetPVarFloat(npcid,"current_target_y", -1680.578491), SetPVarFloat(npcid,"current_target_z", 13.759401);
				case 1: FCNPC_GoTo(npcid,682.412475,-1665.762084,12.240344,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 682.412475), SetPVarFloat(npcid,"current_target_y", -1665.762084), SetPVarFloat(npcid,"current_target_z", 12.240344);
				case 2: FCNPC_GoTo(npcid,715.947387,-1681.463867,10.712364,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 715.947387), SetPVarFloat(npcid,"current_target_y", -1681.463867), SetPVarFloat(npcid,"current_target_z", 10.712364);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,716.100463,-1681.233886,10.712738))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,682.761474,-1680.986083,12.169391,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 682.761474), SetPVarFloat(npcid,"current_target_y", -1680.986083), SetPVarFloat(npcid,"current_target_z", 12.169391);
				case 1: FCNPC_GoTo(npcid,714.815063,-1666.431152,10.715514,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 714.815063), SetPVarFloat(npcid,"current_target_y", -1666.431152), SetPVarFloat(npcid,"current_target_z", 10.715514);
				case 2: FCNPC_GoTo(npcid,739.675720,-1681.530395,10.726656,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 739.675720), SetPVarFloat(npcid,"current_target_y", -1681.530395), SetPVarFloat(npcid,"current_target_z", 10.726656);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,739.675720,-1681.530395,10.726656))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,716.037597,-1681.347167,10.712584,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 716.037597), SetPVarFloat(npcid,"current_target_y", -1681.347167), SetPVarFloat(npcid,"current_target_z", 10.712584);
				case 1: FCNPC_GoTo(npcid,739.376708,-1666.445922,10.662231,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 739.376708), SetPVarFloat(npcid,"current_target_y", -1666.445922), SetPVarFloat(npcid,"current_target_z", 10.662231);
				case 2: FCNPC_GoTo(npcid,762.025146,-1681.511230,12.522424,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 762.025146), SetPVarFloat(npcid,"current_target_y", -1681.511230), SetPVarFloat(npcid,"current_target_z", 12.522424);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,762.125366,-1681.489501,12.534677))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,739.446105,-1680.858276,10.708281,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 739.446105), SetPVarFloat(npcid,"current_target_y", -1680.858276), SetPVarFloat(npcid,"current_target_z", 10.708281);
				case 1: FCNPC_GoTo(npcid,760.050903,-1666.609619,12.329691,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 760.050903), SetPVarFloat(npcid,"current_target_y", -1666.609619), SetPVarFloat(npcid,"current_target_z", 12.329691);
				case 2: FCNPC_GoTo(npcid,775.224426,-1682.283813,13.386181,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 775.224426), SetPVarFloat(npcid,"current_target_y", -1682.283813), SetPVarFloat(npcid,"current_target_z", 13.386181);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,775.224426,-1682.283813,13.386181))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,761.997009,-1681.440063,12.518984,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 761.997009), SetPVarFloat(npcid,"current_target_y", -1681.440063), SetPVarFloat(npcid,"current_target_z", 12.518984);
				case 1: FCNPC_GoTo(npcid,775.289978,-1666.618530,13.395524,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 775.289978), SetPVarFloat(npcid,"current_target_y", -1666.618530), SetPVarFloat(npcid,"current_target_z", 13.395524);
				case 2: FCNPC_GoTo(npcid,801.900390,-1683.109619,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 801.900390), SetPVarFloat(npcid,"current_target_y", -1683.109619), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,743.599060,-1602.370239,13.715451))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,744.004699,-1640.541748,6.073468,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 744.004699), SetPVarFloat(npcid,"current_target_y", -1640.541748), SetPVarFloat(npcid,"current_target_z", 6.073468);
				case 1: FCNPC_GoTo(npcid,743.366333,-1594.348999,14.282200,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 743.366333), SetPVarFloat(npcid,"current_target_y", -1594.348999), SetPVarFloat(npcid,"current_target_z", 14.282200);
				case 2: FCNPC_GoTo(npcid,759.552673,-1606.544799,13.244204,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 759.552673), SetPVarFloat(npcid,"current_target_y", -1606.544799), SetPVarFloat(npcid,"current_target_z", 13.244204);
	        }
	    }
	}
	if(GetPVarInt(npcid,"circle_beach")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,362.568084,-1861.486206,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,386.388732,-1860.875854,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 386.388732), SetPVarFloat(npcid,"current_target_y", -1860.875854), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,363.089843,-1879.024658,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.089843), SetPVarFloat(npcid,"current_target_y", -1879.024658), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,363.089843,-1879.024658,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,362.838562,-1861.683715,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.838562), SetPVarFloat(npcid,"current_target_y", -1861.683715), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,375.150024,-1879.158691,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.150024), SetPVarFloat(npcid,"current_target_y", -1879.158691), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,386.537567,-1879.351806,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 386.537567), SetPVarFloat(npcid,"current_target_y", -1879.351806), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,386.409301,-1861.021606,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,362.666564,-1861.586669,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.666564), SetPVarFloat(npcid,"current_target_y", -1861.586669), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,386.598907,-1879.334960,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 386.598907), SetPVarFloat(npcid,"current_target_y", -1879.334960), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,386.598907,-1879.334960,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,386.374145,-1860.784667,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 386.374145), SetPVarFloat(npcid,"current_target_y", -1860.784667), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,375.338073,-1879.156005,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.338073), SetPVarFloat(npcid,"current_target_y", -1879.156005), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,384.644470,-1895.824462,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 384.644470), SetPVarFloat(npcid,"current_target_y", -1895.824462), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,375.196105,-1879.118408,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,363.157165,-1879.263305,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.157165), SetPVarFloat(npcid,"current_target_y", -1879.263305), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,386.563781,-1879.373657,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 386.563781), SetPVarFloat(npcid,"current_target_y", -1879.373657), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,375.028442,-1895.031982,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.028442), SetPVarFloat(npcid,"current_target_y", -1895.031982), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,384.602996,-1895.880493,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,386.626373,-1879.486694,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 386.626373), SetPVarFloat(npcid,"current_target_y", -1879.486694), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,375.205688,-1894.987792,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.205688), SetPVarFloat(npcid,"current_target_y", -1894.987792), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,375.205688,-1894.987792,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,384.528167,-1895.757812,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 384.528167), SetPVarFloat(npcid,"current_target_y", -1895.757812), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,375.223754,-1907.198730,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.223754), SetPVarFloat(npcid,"current_target_y", -1907.198730), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,375.223754,-1907.198730,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,375.288024,-1895.135986,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.288024), SetPVarFloat(npcid,"current_target_y", -1895.135986), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,388.068023,-1907.365356,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 388.068023), SetPVarFloat(npcid,"current_target_y", -1907.365356), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,375.055389,-1917.322998,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.055389), SetPVarFloat(npcid,"current_target_y", -1917.322998), SetPVarFloat(npcid,"current_target_z", 7.830190);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,388.064514,-1907.510986,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,375.407012,-1907.288818,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.407012), SetPVarFloat(npcid,"current_target_y", -1907.288818), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,388.063568,-1916.949218,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 388.063568), SetPVarFloat(npcid,"current_target_y", -1916.949218), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,388.085662,-1916.979858,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,388.280334,-1907.416625,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 388.280334), SetPVarFloat(npcid,"current_target_y", -1907.416625), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,375.262725,-1917.180419,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.262725), SetPVarFloat(npcid,"current_target_y", -1917.180419), SetPVarFloat(npcid,"current_target_z", 7.830190);
				case 2: FCNPC_GoTo(npcid,386.940856,-1927.707641,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 386.940856), SetPVarFloat(npcid,"current_target_y", -1927.707641), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,375.122222,-1917.215820,7.830190))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,388.091735,-1916.954101,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 388.091735), SetPVarFloat(npcid,"current_target_y", -1916.954101), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,375.411193,-1907.530273,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.411193), SetPVarFloat(npcid,"current_target_y", -1907.530273), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,363.301208,-1917.217285,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.301208), SetPVarFloat(npcid,"current_target_y", -1917.217285), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 3: FCNPC_GoTo(npcid,375.515594,-1927.958251,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.515594), SetPVarFloat(npcid,"current_target_y", -1927.958251), SetPVarFloat(npcid,"current_target_z", 7.830190);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,387.034393,-1927.583496,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,388.124847,-1917.111694,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 388.124847), SetPVarFloat(npcid,"current_target_y", -1917.111694), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,375.414245,-1928.005859,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.414245), SetPVarFloat(npcid,"current_target_y", -1928.005859), SetPVarFloat(npcid,"current_target_z", 7.830190);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,363.196563,-1917.412109,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,375.116577,-1917.160278,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.116577), SetPVarFloat(npcid,"current_target_y", -1917.160278), SetPVarFloat(npcid,"current_target_z", 7.830190);
				case 1: FCNPC_GoTo(npcid,363.101959,-1928.011840,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.101959), SetPVarFloat(npcid,"current_target_y", -1928.011840), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,375.366546,-1928.085693,7.830190))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,363.148406,-1927.956665,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.148406), SetPVarFloat(npcid,"current_target_y", -1927.956665), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,375.251342,-1917.226806,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.251342), SetPVarFloat(npcid,"current_target_y", -1917.226806), SetPVarFloat(npcid,"current_target_z", 7.830190);
				case 2: FCNPC_GoTo(npcid,387.045837,-1927.785888,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 387.045837), SetPVarFloat(npcid,"current_target_y", -1927.785888), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 3: FCNPC_GoTo(npcid,377.017059,-1946.624755,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 377.017059), SetPVarFloat(npcid,"current_target_y", -1946.624755), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,377.017059,-1946.624755,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,375.535522,-1928.041870,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.535522), SetPVarFloat(npcid,"current_target_y", -1928.041870), SetPVarFloat(npcid,"current_target_z", 7.830190);
				case 1: FCNPC_GoTo(npcid,376.733398,-1967.669311,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.733398), SetPVarFloat(npcid,"current_target_y", -1967.669311), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,362.598480,-1947.258056,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,363.139221,-1927.866088,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.139221), SetPVarFloat(npcid,"current_target_y", -1927.866088), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,377.314422,-1946.720825,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 377.314422), SetPVarFloat(npcid,"current_target_y", -1946.720825), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,362.175048,-1968.712402,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.175048), SetPVarFloat(npcid,"current_target_y", -1968.712402), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,362.175048,-1968.712402,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,377.040802,-1967.870117,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 377.040802), SetPVarFloat(npcid,"current_target_y", -1967.870117), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,362.934234,-1946.983276,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.934234), SetPVarFloat(npcid,"current_target_y", -1946.983276), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,362.355712,-1999.832153,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.355712), SetPVarFloat(npcid,"current_target_y", -1999.832153), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,376.847290,-1967.801635,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,376.992309,-1946.836669,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.992309), SetPVarFloat(npcid,"current_target_y", -1946.836669), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,362.150329,-1968.889038,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.150329), SetPVarFloat(npcid,"current_target_y", -1968.889038), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,376.220153,-1999.349365,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.220153), SetPVarFloat(npcid,"current_target_y", -1999.349365), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,376.220153,-1999.349365,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,376.522338,-1967.944335,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.522338), SetPVarFloat(npcid,"current_target_y", -1967.944335), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,362.230957,-1999.840942,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.230957), SetPVarFloat(npcid,"current_target_y", -1999.840942), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,376.550262,-2017.964599,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.550262), SetPVarFloat(npcid,"current_target_y", -2017.964599), SetPVarFloat(npcid,"current_target_z", 7.830190);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,362.168487,-1999.914672,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,362.217803,-1968.725341,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.217803), SetPVarFloat(npcid,"current_target_y", -1968.725341), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,376.331146,-1999.271606,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.331146), SetPVarFloat(npcid,"current_target_y", -1999.271606), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,363.178070,-2018.817138,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.178070), SetPVarFloat(npcid,"current_target_y", -2018.817138), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,363.178070,-2018.817138,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,376.546234,-2018.131713,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.546234), SetPVarFloat(npcid,"current_target_y", -2018.131713), SetPVarFloat(npcid,"current_target_z", 7.830190);
				case 1: FCNPC_GoTo(npcid,362.384246,-1999.776367,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.384246), SetPVarFloat(npcid,"current_target_y", -1999.776367), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,363.059997,-2026.688720,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.059997), SetPVarFloat(npcid,"current_target_y", -2026.688720), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,363.059997,-2026.688720,7.836037))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,363.227661,-2018.516967,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.227661), SetPVarFloat(npcid,"current_target_y", -2018.516967), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,376.473846,-2026.454467,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.473846), SetPVarFloat(npcid,"current_target_y", -2026.454467), SetPVarFloat(npcid,"current_target_z", 7.830190);
				case 2: FCNPC_GoTo(npcid,383.002197,-2026.666137,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 383.002197), SetPVarFloat(npcid,"current_target_y", -2026.666137), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 3: FCNPC_GoTo(npcid,362.548370,-2048.418212,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.548370), SetPVarFloat(npcid,"current_target_y", -2048.418212), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,362.564880,-2048.080322,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,383.731658,-2048.275878,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 383.731658), SetPVarFloat(npcid,"current_target_y", -2048.275878), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,363.021575,-2026.516845,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.021575), SetPVarFloat(npcid,"current_target_y", -2026.516845), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,351.836669,-2048.468017,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 351.836669), SetPVarFloat(npcid,"current_target_y", -2048.468017), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,351.836669,-2048.468017,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,362.461517,-2048.451416,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.461517), SetPVarFloat(npcid,"current_target_y", -2048.451416), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,350.762847,-2055.552978,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 350.762847), SetPVarFloat(npcid,"current_target_y", -2055.552978), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,350.762847,-2055.552978,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,351.623718,-2048.397705,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 351.623718), SetPVarFloat(npcid,"current_target_y", -2048.397705), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,351.177276,-2084.756347,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 351.177276), SetPVarFloat(npcid,"current_target_y", -2084.756347), SetPVarFloat(npcid,"current_target_z", 7.830190);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,351.177276,-2084.756347,7.830190))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,350.587249,-2055.896972,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 350.587249), SetPVarFloat(npcid,"current_target_y", -2055.896972), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,365.847473,-2085.057128,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 365.847473), SetPVarFloat(npcid,"current_target_y", -2085.057128), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,365.639221,-2085.074707,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,351.414825,-2084.907226,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 351.414825), SetPVarFloat(npcid,"current_target_y", -2084.907226), SetPVarFloat(npcid,"current_target_z", 7.830190);
				case 1: FCNPC_GoTo(npcid,366.262268,-2079.701171,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 366.262268), SetPVarFloat(npcid,"current_target_y", -2079.701171), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,373.090484,-2085.068847,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 373.090484), SetPVarFloat(npcid,"current_target_y", -2085.068847), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,366.421966,-2079.739257,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,365.797119,-2084.814697,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 365.797119), SetPVarFloat(npcid,"current_target_y", -2084.814697), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,372.926452,-2075.754394,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 372.926452), SetPVarFloat(npcid,"current_target_y", -2075.754394), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,372.989501,-2075.932617,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,366.394348,-2079.831542,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 366.394348), SetPVarFloat(npcid,"current_target_y", -2079.831542), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,383.112274,-2075.670654,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 383.112274), SetPVarFloat(npcid,"current_target_y", -2075.670654), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,373.351837,-2085.083984,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,365.763641,-2085.074218,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 365.763641), SetPVarFloat(npcid,"current_target_y", -2085.074218), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,394.699768,-2085.000000,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 394.699768), SetPVarFloat(npcid,"current_target_y", -2085.000000), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,383.082397,-2075.794921,7.836037))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,383.645660,-2057.874511,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 383.645660), SetPVarFloat(npcid,"current_target_y", -2057.874511), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,372.636474,-2075.807373,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 372.636474), SetPVarFloat(npcid,"current_target_y", -2075.807373), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,390.466735,-2076.069824,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 390.466735), SetPVarFloat(npcid,"current_target_y", -2076.069824), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 3: FCNPC_GoTo(npcid,394.551757,-2076.276611,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 394.551757), SetPVarFloat(npcid,"current_target_y", -2076.276611), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,390.800628,-2075.941650,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,382.947021,-2075.794433,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 382.947021), SetPVarFloat(npcid,"current_target_y", -2075.794433), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,392.088867,-2058.034912,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 392.088867), SetPVarFloat(npcid,"current_target_y", -2058.034912), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,394.700836,-2076.241455,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 394.700836), SetPVarFloat(npcid,"current_target_y", -2076.241455), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,394.700836,-2076.241455,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,390.800079,-2076.100830,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 390.800079), SetPVarFloat(npcid,"current_target_y", -2076.100830), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,394.730041,-2084.578613,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 394.730041), SetPVarFloat(npcid,"current_target_y", -2084.578613), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,394.730041,-2084.578613,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,394.599243,-2076.280517,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 394.599243), SetPVarFloat(npcid,"current_target_y", -2076.280517), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,406.980438,-2084.749755,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 406.980438), SetPVarFloat(npcid,"current_target_y", -2084.749755), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,406.980438,-2084.749755,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,394.836700,-2084.475585,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 394.836700), SetPVarFloat(npcid,"current_target_y", -2084.475585), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,407.419311,-2059.468261,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 407.419311), SetPVarFloat(npcid,"current_target_y", -2059.468261), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,407.419311,-2059.468261,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,406.931060,-2085.315917,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 406.931060), SetPVarFloat(npcid,"current_target_y", -2085.315917), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,391.281524,-2057.744140,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 391.281524), SetPVarFloat(npcid,"current_target_y", -2057.744140), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,407.103240,-2048.859375,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 407.103240), SetPVarFloat(npcid,"current_target_y", -2048.859375), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,407.103240,-2048.859375,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,407.183227,-2059.309082,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 407.183227), SetPVarFloat(npcid,"current_target_y", -2059.309082), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,396.858551,-2048.351318,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 396.858551), SetPVarFloat(npcid,"current_target_y", -2048.351318), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,396.858551,-2048.351318,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,407.216125,-2048.907226,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 407.216125), SetPVarFloat(npcid,"current_target_y", -2048.907226), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,397.164093,-2014.124389,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 397.164093), SetPVarFloat(npcid,"current_target_y", -2014.124389), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,383.862823,-2047.755493,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 383.862823), SetPVarFloat(npcid,"current_target_y", -2047.755493), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,391.600524,-2058.181640,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,407.057525,-2059.057128,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 407.057525), SetPVarFloat(npcid,"current_target_y", -2059.057128), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,391.143890,-2076.272949,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 391.143890), SetPVarFloat(npcid,"current_target_y", -2076.272949), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,383.754791,-2057.944580,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 383.754791), SetPVarFloat(npcid,"current_target_y", -2057.944580), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,383.726257,-2057.902587,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,391.305023,-2058.284912,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 391.305023), SetPVarFloat(npcid,"current_target_y", -2058.284912), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,383.157135,-2075.886474,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 383.157135), SetPVarFloat(npcid,"current_target_y", -2075.886474), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,383.660156,-2047.848632,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 383.660156), SetPVarFloat(npcid,"current_target_y", -2047.848632), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,383.660156,-2047.848632,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,396.840789,-2047.956420,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 396.840789), SetPVarFloat(npcid,"current_target_y", -2047.956420), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,362.675445,-2048.235107,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.675445), SetPVarFloat(npcid,"current_target_y", -2048.235107), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,382.759887,-2026.511108,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 382.759887), SetPVarFloat(npcid,"current_target_y", -2026.511108), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,382.759887,-2026.511108,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,383.486389,-2048.474609,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 383.486389), SetPVarFloat(npcid,"current_target_y", -2048.474609), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,376.528778,-2026.497802,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.528778), SetPVarFloat(npcid,"current_target_y", -2026.497802), SetPVarFloat(npcid,"current_target_z", 7.830190);
				case 2: FCNPC_GoTo(npcid,382.958862,-2017.895996,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 382.958862), SetPVarFloat(npcid,"current_target_y", -2017.895996), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,382.958862,-2017.895996,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,383.364105,-2026.813476,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 383.364105), SetPVarFloat(npcid,"current_target_y", -2026.813476), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,382.453369,-2013.986694,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 382.453369), SetPVarFloat(npcid,"current_target_y", -2013.986694), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,376.477783,-2018.141723,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.477783), SetPVarFloat(npcid,"current_target_y", -2018.141723), SetPVarFloat(npcid,"current_target_z", 7.830190);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,382.499267,-2014.306030,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,382.901947,-2017.970458,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 382.901947), SetPVarFloat(npcid,"current_target_y", -2017.970458), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,397.143127,-2013.841674,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 397.143127), SetPVarFloat(npcid,"current_target_y", -2013.841674), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,397.143127,-2013.841674,7.836037))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,396.699859,-2048.379150,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 396.699859), SetPVarFloat(npcid,"current_target_y", -2048.379150), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,382.590148,-2013.962524,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 382.590148), SetPVarFloat(npcid,"current_target_y", -2013.962524), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,376.536560,-2018.042480,7.830190))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,382.511718,-2018.188720,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 382.511718), SetPVarFloat(npcid,"current_target_y", -2018.188720), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,376.539794,-2026.597778,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.539794), SetPVarFloat(npcid,"current_target_y", -2026.597778), SetPVarFloat(npcid,"current_target_z", 7.830190);
				case 2: FCNPC_GoTo(npcid,376.563018,-1999.331787,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.563018), SetPVarFloat(npcid,"current_target_y", -1999.331787), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 3: FCNPC_GoTo(npcid,363.160034,-2018.724975,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.160034), SetPVarFloat(npcid,"current_target_y", -2018.724975), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,376.618530,-2026.522216,7.830190))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,383.291442,-2026.726074,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 383.291442), SetPVarFloat(npcid,"current_target_y", -2026.726074), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,362.999542,-2026.653930,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.999542), SetPVarFloat(npcid,"current_target_y", -2026.653930), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 2: FCNPC_GoTo(npcid,376.669311,-2018.035034,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 376.669311), SetPVarFloat(npcid,"current_target_y", -2018.035034), SetPVarFloat(npcid,"current_target_z", 7.830190);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,363.142852,-1928.017211,7.836037))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,363.440765,-1917.282226,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.440765), SetPVarFloat(npcid,"current_target_y", -1917.282226), SetPVarFloat(npcid,"current_target_z", 7.836037);
				case 1: FCNPC_GoTo(npcid,375.440612,-1928.039916,7.830190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 375.440612), SetPVarFloat(npcid,"current_target_y", -1928.039916), SetPVarFloat(npcid,"current_target_z", 7.830190);
				case 2: FCNPC_GoTo(npcid,362.725372,-1947.068847,7.836037,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.725372), SetPVarFloat(npcid,"current_target_y", -1947.068847), SetPVarFloat(npcid,"current_target_z", 7.836037);
	        }
	    }
	}
	if(GetPVarInt(npcid,"rodeo")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,430.787261,-1448.872680,30.578224))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,415.655670,-1459.380371,30.515724,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 415.655670), SetPVarFloat(npcid,"current_target_y", -1459.380371), SetPVarFloat(npcid,"current_target_z", 30.515724);
				case 1: FCNPC_GoTo(npcid,448.905670,-1469.937377,30.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 448.905670), SetPVarFloat(npcid,"current_target_y", -1469.937377), SetPVarFloat(npcid,"current_target_z", 30.578224);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,448.905670,-1469.937377,30.578224))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,430.763946,-1448.819091,30.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 430.763946), SetPVarFloat(npcid,"current_target_y", -1448.819091), SetPVarFloat(npcid,"current_target_z", 30.578224);
				case 1: FCNPC_GoTo(npcid,425.947357,-1481.869140,30.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 425.947357), SetPVarFloat(npcid,"current_target_y", -1481.869140), SetPVarFloat(npcid,"current_target_z", 30.578224);
				case 2: FCNPC_GoTo(npcid,454.151977,-1486.110595,31.043884,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 454.151977), SetPVarFloat(npcid,"current_target_y", -1486.110595), SetPVarFloat(npcid,"current_target_z", 31.043884);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,454.151977,-1486.110595,31.043884))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,449.018463,-1470.074829,30.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 449.018463), SetPVarFloat(npcid,"current_target_y", -1470.074829), SetPVarFloat(npcid,"current_target_z", 30.578224);
				case 1: FCNPC_GoTo(npcid,431.674438,-1493.507080,31.001621,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 431.674438), SetPVarFloat(npcid,"current_target_y", -1493.507080), SetPVarFloat(npcid,"current_target_z", 31.001621);
				case 2: FCNPC_GoTo(npcid,458.730407,-1510.177001,30.975742,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 458.730407), SetPVarFloat(npcid,"current_target_y", -1510.177001), SetPVarFloat(npcid,"current_target_z", 30.975742);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,458.725341,-1509.976196,30.977169))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,454.267303,-1486.107788,31.044902,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 454.267303), SetPVarFloat(npcid,"current_target_y", -1486.107788), SetPVarFloat(npcid,"current_target_z", 31.044902);
				case 1: FCNPC_GoTo(npcid,435.334777,-1513.820312,30.982690,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 435.334777), SetPVarFloat(npcid,"current_target_y", -1513.820312), SetPVarFloat(npcid,"current_target_z", 30.982690);
				case 2: FCNPC_GoTo(npcid,459.299133,-1532.255981,29.779230,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 459.299133), SetPVarFloat(npcid,"current_target_y", -1532.255981), SetPVarFloat(npcid,"current_target_z", 29.779230);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,459.299133,-1532.255981,29.779230))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,458.957214,-1510.115844,30.976009,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 458.957214), SetPVarFloat(npcid,"current_target_y", -1510.115844), SetPVarFloat(npcid,"current_target_z", 30.976009);
				case 1: FCNPC_GoTo(npcid,436.188323,-1532.017822,29.977939,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 436.188323), SetPVarFloat(npcid,"current_target_y", -1532.017822), SetPVarFloat(npcid,"current_target_z", 29.977939);
				case 2: FCNPC_GoTo(npcid,459.206970,-1571.486450,25.554227,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 459.206970), SetPVarFloat(npcid,"current_target_y", -1571.486450), SetPVarFloat(npcid,"current_target_z", 25.554227);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,459.206970,-1571.486450,25.554227))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,459.465362,-1532.017089,29.793157,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 459.465362), SetPVarFloat(npcid,"current_target_y", -1532.017089), SetPVarFloat(npcid,"current_target_z", 29.793157);
				case 1: FCNPC_GoTo(npcid,436.342193,-1570.740844,25.641550,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 436.342193), SetPVarFloat(npcid,"current_target_y", -1570.740844), SetPVarFloat(npcid,"current_target_z", 25.641550);
				case 2: FCNPC_GoTo(npcid,460.167388,-1600.921142,25.476661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 460.167388), SetPVarFloat(npcid,"current_target_y", -1600.921142), SetPVarFloat(npcid,"current_target_z", 25.476661);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,460.167388,-1600.921142,25.476661))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,459.184661,-1571.489501,25.554170,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 459.184661), SetPVarFloat(npcid,"current_target_y", -1571.489501), SetPVarFloat(npcid,"current_target_z", 25.554170);
				case 1: FCNPC_GoTo(npcid,435.959594,-1601.285034,25.476661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 435.959594), SetPVarFloat(npcid,"current_target_y", -1601.285034), SetPVarFloat(npcid,"current_target_z", 25.476661);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,435.959594,-1601.285034,25.476661))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,421.055786,-1600.806640,26.180662,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 421.055786), SetPVarFloat(npcid,"current_target_y", -1600.806640), SetPVarFloat(npcid,"current_target_z", 26.180662);
				case 1: FCNPC_GoTo(npcid,460.018951,-1600.812500,25.476661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 460.018951), SetPVarFloat(npcid,"current_target_y", -1600.812500), SetPVarFloat(npcid,"current_target_z", 25.476661);
				case 2: FCNPC_GoTo(npcid,436.318389,-1571.053222,25.601293,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 436.318389), SetPVarFloat(npcid,"current_target_y", -1571.053222), SetPVarFloat(npcid,"current_target_z", 25.601293);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,435.998229,-1574.727905,25.476661))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,436.046966,-1601.319702,25.476661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 436.046966), SetPVarFloat(npcid,"current_target_y", -1601.319702), SetPVarFloat(npcid,"current_target_z", 25.476661);
				case 1: FCNPC_GoTo(npcid,436.332336,-1570.794311,25.634670,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 436.332336), SetPVarFloat(npcid,"current_target_y", -1570.794311), SetPVarFloat(npcid,"current_target_z", 25.634670);
				case 2: FCNPC_GoTo(npcid,420.307189,-1574.832153,26.233079,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 420.307189), SetPVarFloat(npcid,"current_target_y", -1574.832153), SetPVarFloat(npcid,"current_target_z", 26.233079);
				case 3: FCNPC_GoTo(npcid,459.010131,-1571.588378,25.545450,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 459.010131), SetPVarFloat(npcid,"current_target_y", -1571.588378), SetPVarFloat(npcid,"current_target_z", 25.545450);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,436.376342,-1570.875488,25.624122))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,435.940368,-1574.570434,25.476661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 435.940368), SetPVarFloat(npcid,"current_target_y", -1574.570434), SetPVarFloat(npcid,"current_target_z", 25.476661);
				case 1: FCNPC_GoTo(npcid,459.134429,-1571.620971,25.540296,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 459.134429), SetPVarFloat(npcid,"current_target_y", -1571.620971), SetPVarFloat(npcid,"current_target_z", 25.540296);
				case 2: FCNPC_GoTo(npcid,435.990112,-1560.911865,26.941370,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 435.990112), SetPVarFloat(npcid,"current_target_y", -1560.911865), SetPVarFloat(npcid,"current_target_z", 26.941370);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,435.990112,-1560.911865,26.941370))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,432.425506,-1560.851074,26.971887,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 432.425506), SetPVarFloat(npcid,"current_target_y", -1560.851074), SetPVarFloat(npcid,"current_target_z", 26.971887);
				case 1: FCNPC_GoTo(npcid,436.331512,-1571.009643,25.606893,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 436.331512), SetPVarFloat(npcid,"current_target_y", -1571.009643), SetPVarFloat(npcid,"current_target_z", 25.606893);
				case 2: FCNPC_GoTo(npcid,436.083038,-1532.064941,29.975458,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 436.083038), SetPVarFloat(npcid,"current_target_y", -1532.064941), SetPVarFloat(npcid,"current_target_z", 29.975458);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,436.083038,-1532.064941,29.975458))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,435.970916,-1560.950195,26.936445,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 435.970916), SetPVarFloat(npcid,"current_target_y", -1560.950195), SetPVarFloat(npcid,"current_target_z", 26.936445);
				case 1: FCNPC_GoTo(npcid,459.055053,-1532.165649,29.785322,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 459.055053), SetPVarFloat(npcid,"current_target_y", -1532.165649), SetPVarFloat(npcid,"current_target_z", 29.785322);
				case 2: FCNPC_GoTo(npcid,435.397979,-1513.697265,30.983619,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 435.397979), SetPVarFloat(npcid,"current_target_y", -1513.697265), SetPVarFloat(npcid,"current_target_z", 30.983619);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,435.397979,-1513.697265,30.983619))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,436.109283,-1532.076171,29.974615,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 436.109283), SetPVarFloat(npcid,"current_target_y", -1532.076171), SetPVarFloat(npcid,"current_target_z", 29.974615);
				case 1: FCNPC_GoTo(npcid,458.816284,-1510.147583,30.975887,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 458.816284), SetPVarFloat(npcid,"current_target_y", -1510.147583), SetPVarFloat(npcid,"current_target_z", 30.975887);
				case 2: FCNPC_GoTo(npcid,431.524108,-1493.594726,31.002349,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 431.524108), SetPVarFloat(npcid,"current_target_y", -1493.594726), SetPVarFloat(npcid,"current_target_z", 31.002349);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,431.524108,-1493.594726,31.002349))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,435.277862,-1513.751831,30.983343,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 435.277862), SetPVarFloat(npcid,"current_target_y", -1513.751831), SetPVarFloat(npcid,"current_target_z", 30.983343);
				case 1: FCNPC_GoTo(npcid,454.008026,-1485.868408,31.035650,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 454.008026), SetPVarFloat(npcid,"current_target_y", -1485.868408), SetPVarFloat(npcid,"current_target_z", 31.035650);
				case 2: FCNPC_GoTo(npcid,425.781341,-1481.887329,30.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 425.781341), SetPVarFloat(npcid,"current_target_y", -1481.887329), SetPVarFloat(npcid,"current_target_z", 30.578224);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,425.781341,-1481.887329,30.578224))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,431.643310,-1493.802490,31.011390,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 431.643310), SetPVarFloat(npcid,"current_target_y", -1493.802490), SetPVarFloat(npcid,"current_target_z", 31.011390);
				case 1: FCNPC_GoTo(npcid,449.247589,-1469.962524,30.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 449.247589), SetPVarFloat(npcid,"current_target_y", -1469.962524), SetPVarFloat(npcid,"current_target_z", 30.578224);
				case 2: FCNPC_GoTo(npcid,404.884246,-1498.894165,31.604402,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 404.884246), SetPVarFloat(npcid,"current_target_y", -1498.894165), SetPVarFloat(npcid,"current_target_z", 31.604402);
				case 3: FCNPC_GoTo(npcid,415.800384,-1459.338745,30.515724,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 415.800384), SetPVarFloat(npcid,"current_target_y", -1459.338745), SetPVarFloat(npcid,"current_target_z", 30.515724);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,415.800384,-1459.338745,30.515724))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,430.643157,-1448.818359,30.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 430.643157), SetPVarFloat(npcid,"current_target_y", -1448.818359), SetPVarFloat(npcid,"current_target_z", 30.578224);
				case 1: FCNPC_GoTo(npcid,425.897674,-1482.077392,30.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 425.897674), SetPVarFloat(npcid,"current_target_y", -1482.077392), SetPVarFloat(npcid,"current_target_z", 30.578224);
				case 2: FCNPC_GoTo(npcid,391.025207,-1477.961791,31.531108,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 391.025207), SetPVarFloat(npcid,"current_target_y", -1477.961791), SetPVarFloat(npcid,"current_target_z", 31.531108);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,391.025207,-1477.961791,31.531108))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,415.778564,-1459.376586,30.515724,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 415.778564), SetPVarFloat(npcid,"current_target_y", -1459.376586), SetPVarFloat(npcid,"current_target_z", 30.515724);
				case 1: FCNPC_GoTo(npcid,404.869445,-1498.814575,31.602928,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 404.869445), SetPVarFloat(npcid,"current_target_y", -1498.814575), SetPVarFloat(npcid,"current_target_z", 31.602928);
				case 2: FCNPC_GoTo(npcid,363.351898,-1499.208007,32.702827,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.351898), SetPVarFloat(npcid,"current_target_y", -1499.208007), SetPVarFloat(npcid,"current_target_z", 32.702827);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,363.351898,-1499.208007,32.702827))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,391.227783,-1477.715332,31.519044,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 391.227783), SetPVarFloat(npcid,"current_target_y", -1477.715332), SetPVarFloat(npcid,"current_target_z", 31.519044);
				case 1: FCNPC_GoTo(npcid,379.036193,-1518.077514,32.731502,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 379.036193), SetPVarFloat(npcid,"current_target_y", -1518.077514), SetPVarFloat(npcid,"current_target_z", 32.731502);
				case 2: FCNPC_GoTo(npcid,350.542388,-1509.949707,33.012081,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 350.542388), SetPVarFloat(npcid,"current_target_y", -1509.949707), SetPVarFloat(npcid,"current_target_z", 33.012081);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,350.542388,-1509.949707,33.012081))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,363.391326,-1499.268798,32.703071,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.391326), SetPVarFloat(npcid,"current_target_y", -1499.268798), SetPVarFloat(npcid,"current_target_z", 32.703071);
				case 1: FCNPC_GoTo(npcid,369.621276,-1527.218750,33.097206,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 369.621276), SetPVarFloat(npcid,"current_target_y", -1527.218750), SetPVarFloat(npcid,"current_target_z", 33.097206);
				case 2: FCNPC_GoTo(npcid,341.543670,-1511.893554,34.377326,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 341.543670), SetPVarFloat(npcid,"current_target_y", -1511.893554), SetPVarFloat(npcid,"current_target_z", 34.377326);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,341.543670,-1511.893554,34.377326))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,350.719146,-1509.849975,33.013484,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 350.719146), SetPVarFloat(npcid,"current_target_y", -1509.849975), SetPVarFloat(npcid,"current_target_z", 33.013484);
				case 1: FCNPC_GoTo(npcid,338.038116,-1515.108520,35.829036,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 338.038116), SetPVarFloat(npcid,"current_target_y", -1515.108520), SetPVarFloat(npcid,"current_target_z", 35.829036);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,338.038116,-1515.108520,35.829036))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,341.539306,-1512.047241,34.408016,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 341.539306), SetPVarFloat(npcid,"current_target_y", -1512.047241), SetPVarFloat(npcid,"current_target_z", 34.408016);
				case 1: FCNPC_GoTo(npcid,330.316375,-1524.841796,35.782619,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 330.316375), SetPVarFloat(npcid,"current_target_y", -1524.841796), SetPVarFloat(npcid,"current_target_z", 35.782619);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,330.316375,-1524.841796,35.782619))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,337.951721,-1515.100585,35.829746,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 337.951721), SetPVarFloat(npcid,"current_target_y", -1515.100585), SetPVarFloat(npcid,"current_target_z", 35.829746);
				case 1: FCNPC_GoTo(npcid,327.604522,-1531.136840,33.703399,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 327.604522), SetPVarFloat(npcid,"current_target_y", -1531.136840), SetPVarFloat(npcid,"current_target_z", 33.703399);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,327.662872,-1531.242675,33.654853))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,330.566986,-1524.799072,35.806587,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 330.566986), SetPVarFloat(npcid,"current_target_y", -1524.799072), SetPVarFloat(npcid,"current_target_z", 35.806587);
				case 1: FCNPC_GoTo(npcid,329.361419,-1537.996093,33.199195,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 329.361419), SetPVarFloat(npcid,"current_target_y", -1537.996093), SetPVarFloat(npcid,"current_target_z", 33.199195);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,343.567291,-1518.786254,33.245178))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,350.679962,-1509.944458,33.011440,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 350.679962), SetPVarFloat(npcid,"current_target_y", -1509.944458), SetPVarFloat(npcid,"current_target_z", 33.011440);
				case 1: FCNPC_GoTo(npcid,362.821533,-1535.801025,33.403343,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.821533), SetPVarFloat(npcid,"current_target_y", -1535.801025), SetPVarFloat(npcid,"current_target_z", 33.403343);
				case 2: FCNPC_GoTo(npcid,329.353027,-1538.071289,33.199188,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 329.353027), SetPVarFloat(npcid,"current_target_y", -1538.071289), SetPVarFloat(npcid,"current_target_z", 33.199188);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,329.371795,-1538.129638,33.199344))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,327.591766,-1530.995971,33.762424,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 327.591766), SetPVarFloat(npcid,"current_target_y", -1530.995971), SetPVarFloat(npcid,"current_target_z", 33.762424);
				case 1: FCNPC_GoTo(npcid,343.474517,-1518.779174,33.245262,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 343.474517), SetPVarFloat(npcid,"current_target_y", -1518.779174), SetPVarFloat(npcid,"current_target_z", 33.245262);
				case 2: FCNPC_GoTo(npcid,347.727355,-1557.026245,33.046585,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 347.727355), SetPVarFloat(npcid,"current_target_y", -1557.026245), SetPVarFloat(npcid,"current_target_z", 33.046585);
				case 3: FCNPC_GoTo(npcid,324.638854,-1546.334472,33.244705,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 324.638854), SetPVarFloat(npcid,"current_target_y", -1546.334472), SetPVarFloat(npcid,"current_target_z", 33.244705);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,324.638854,-1546.334472,33.244705))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,329.530181,-1537.989868,33.200325,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 329.530181), SetPVarFloat(npcid,"current_target_y", -1537.989868), SetPVarFloat(npcid,"current_target_z", 33.200325);
				case 1: FCNPC_GoTo(npcid,347.672943,-1557.108154,33.048992,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 347.672943), SetPVarFloat(npcid,"current_target_y", -1557.108154), SetPVarFloat(npcid,"current_target_z", 33.048992);
				case 2: FCNPC_GoTo(npcid,318.423370,-1559.695434,33.263454,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 318.423370), SetPVarFloat(npcid,"current_target_y", -1559.695434), SetPVarFloat(npcid,"current_target_z", 33.263454);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,318.423370,-1559.695434,33.263454))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,324.515747,-1546.431396,33.249794,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 324.515747), SetPVarFloat(npcid,"current_target_y", -1546.431396), SetPVarFloat(npcid,"current_target_z", 33.249794);
				case 1: FCNPC_GoTo(npcid,343.182891,-1564.688110,33.238365,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 343.182891), SetPVarFloat(npcid,"current_target_y", -1564.688110), SetPVarFloat(npcid,"current_target_z", 33.238365);
				case 2: FCNPC_GoTo(npcid,314.834869,-1576.548828,33.203289,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 314.834869), SetPVarFloat(npcid,"current_target_y", -1576.548828), SetPVarFloat(npcid,"current_target_z", 33.203289);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,314.834869,-1576.548828,33.203289))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,318.608276,-1559.552368,33.264602,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 318.608276), SetPVarFloat(npcid,"current_target_y", -1559.552368), SetPVarFloat(npcid,"current_target_z", 33.264602);
				case 1: FCNPC_GoTo(npcid,342.610595,-1572.615844,33.203289,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 342.610595), SetPVarFloat(npcid,"current_target_y", -1572.615844), SetPVarFloat(npcid,"current_target_z", 33.203289);
				case 2: FCNPC_GoTo(npcid,314.635772,-1592.445434,33.211036,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 314.635772), SetPVarFloat(npcid,"current_target_y", -1592.445434), SetPVarFloat(npcid,"current_target_z", 33.211036);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,314.635772,-1592.445434,33.211036))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,314.666717,-1576.305297,33.203289,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 314.666717), SetPVarFloat(npcid,"current_target_y", -1576.305297), SetPVarFloat(npcid,"current_target_z", 33.203289);
				case 1: FCNPC_GoTo(npcid,340.964691,-1597.412597,33.219207,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 340.964691), SetPVarFloat(npcid,"current_target_y", -1597.412597), SetPVarFloat(npcid,"current_target_z", 33.219207);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,405.005737,-1498.684936,31.595296))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,425.917022,-1481.913452,30.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 425.917022), SetPVarFloat(npcid,"current_target_y", -1481.913452), SetPVarFloat(npcid,"current_target_z", 30.578224);
				case 1: FCNPC_GoTo(npcid,391.044433,-1477.806396,31.526958,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 391.044433), SetPVarFloat(npcid,"current_target_y", -1477.806396), SetPVarFloat(npcid,"current_target_z", 31.526958);
				case 2: FCNPC_GoTo(npcid,385.170867,-1513.478393,32.524322,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 385.170867), SetPVarFloat(npcid,"current_target_y", -1513.478393), SetPVarFloat(npcid,"current_target_z", 32.524322);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,385.170867,-1513.478393,32.524322))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,404.909637,-1498.736328,31.599689,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 404.909637), SetPVarFloat(npcid,"current_target_y", -1498.736328), SetPVarFloat(npcid,"current_target_z", 31.599689);
				case 1: FCNPC_GoTo(npcid,379.267974,-1518.037719,32.726135,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 379.267974), SetPVarFloat(npcid,"current_target_y", -1518.037719), SetPVarFloat(npcid,"current_target_z", 32.726135);
				case 2: FCNPC_GoTo(npcid,401.238128,-1530.180053,32.273536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 401.238128), SetPVarFloat(npcid,"current_target_y", -1530.180053), SetPVarFloat(npcid,"current_target_z", 32.273536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,379.177398,-1517.936157,32.725959))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,385.335235,-1513.528686,32.521701,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 385.335235), SetPVarFloat(npcid,"current_target_y", -1513.528686), SetPVarFloat(npcid,"current_target_z", 32.521701);
				case 1: FCNPC_GoTo(npcid,363.348907,-1499.249755,32.703559,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 363.348907), SetPVarFloat(npcid,"current_target_y", -1499.249755), SetPVarFloat(npcid,"current_target_z", 32.703559);
				case 2: FCNPC_GoTo(npcid,369.524688,-1527.218872,33.099102,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 369.524688), SetPVarFloat(npcid,"current_target_y", -1527.218872), SetPVarFloat(npcid,"current_target_z", 33.099102);
				case 3: FCNPC_GoTo(npcid,394.221710,-1535.444335,32.266395,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 394.221710), SetPVarFloat(npcid,"current_target_y", -1535.444335), SetPVarFloat(npcid,"current_target_z", 32.266395);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,369.602874,-1527.253540,33.098236))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,379.123138,-1518.078857,32.729804,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 379.123138), SetPVarFloat(npcid,"current_target_y", -1518.078857), SetPVarFloat(npcid,"current_target_z", 32.729804);
				case 1: FCNPC_GoTo(npcid,350.624664,-1509.894409,33.012950,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 350.624664), SetPVarFloat(npcid,"current_target_y", -1509.894409), SetPVarFloat(npcid,"current_target_z", 33.012950);
				case 2: FCNPC_GoTo(npcid,362.676635,-1535.697509,33.403854,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.676635), SetPVarFloat(npcid,"current_target_y", -1535.697509), SetPVarFloat(npcid,"current_target_z", 33.403854);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,362.676635,-1535.697509,33.403854))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,369.621002,-1527.255981,33.097927,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 369.621002), SetPVarFloat(npcid,"current_target_y", -1527.255981), SetPVarFloat(npcid,"current_target_z", 33.097927);
				case 1: FCNPC_GoTo(npcid,343.550933,-1518.758422,33.244667,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 343.550933), SetPVarFloat(npcid,"current_target_y", -1518.758422), SetPVarFloat(npcid,"current_target_z", 33.244667);
				case 2: FCNPC_GoTo(npcid,347.674926,-1556.951171,33.045284,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 347.674926), SetPVarFloat(npcid,"current_target_y", -1556.951171), SetPVarFloat(npcid,"current_target_z", 33.045284);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,347.674926,-1556.951171,33.045284))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,362.717590,-1535.921142,33.407756,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 362.717590), SetPVarFloat(npcid,"current_target_y", -1535.921142), SetPVarFloat(npcid,"current_target_z", 33.407756);
				case 1: FCNPC_GoTo(npcid,324.554931,-1546.294799,33.245246,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 324.554931), SetPVarFloat(npcid,"current_target_y", -1546.294799), SetPVarFloat(npcid,"current_target_z", 33.245246);
				case 2: FCNPC_GoTo(npcid,343.323638,-1564.479125,33.241626,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 343.323638), SetPVarFloat(npcid,"current_target_y", -1564.479125), SetPVarFloat(npcid,"current_target_z", 33.241626);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,343.302154,-1564.634887,33.237995))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,347.525085,-1556.994750,33.047630,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 347.525085), SetPVarFloat(npcid,"current_target_y", -1556.994750), SetPVarFloat(npcid,"current_target_z", 33.047630);
				case 1: FCNPC_GoTo(npcid,318.440734,-1559.757690,33.263435,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 318.440734), SetPVarFloat(npcid,"current_target_y", -1559.757690), SetPVarFloat(npcid,"current_target_z", 33.263435);
				case 2: FCNPC_GoTo(npcid,342.302947,-1572.624877,33.203289,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 342.302947), SetPVarFloat(npcid,"current_target_y", -1572.624877), SetPVarFloat(npcid,"current_target_z", 33.203289);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,342.302947,-1572.624877,33.203289))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,343.047729,-1564.489624,33.240875,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 343.047729), SetPVarFloat(npcid,"current_target_y", -1564.489624), SetPVarFloat(npcid,"current_target_z", 33.240875);
				case 1: FCNPC_GoTo(npcid,314.527526,-1576.414794,33.203289,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 314.527526), SetPVarFloat(npcid,"current_target_y", -1576.414794), SetPVarFloat(npcid,"current_target_z", 33.203289);
				case 2: FCNPC_GoTo(npcid,340.840942,-1597.248168,33.217590,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 340.840942), SetPVarFloat(npcid,"current_target_y", -1597.248168), SetPVarFloat(npcid,"current_target_z", 33.217590);
				case 3: FCNPC_GoTo(npcid,379.684417,-1574.589843,30.692649,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 379.684417), SetPVarFloat(npcid,"current_target_y", -1574.589843), SetPVarFloat(npcid,"current_target_z", 30.692649);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,340.880004,-1597.409912,33.218799))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,342.527191,-1572.244995,33.203289,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 342.527191), SetPVarFloat(npcid,"current_target_y", -1572.244995), SetPVarFloat(npcid,"current_target_z", 33.203289);
				case 1: FCNPC_GoTo(npcid,314.788696,-1592.315429,33.211036,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 314.788696), SetPVarFloat(npcid,"current_target_y", -1592.315429), SetPVarFloat(npcid,"current_target_z", 33.211036);
				case 2: FCNPC_GoTo(npcid,377.617889,-1599.171508,30.958215,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 377.617889), SetPVarFloat(npcid,"current_target_y", -1599.171508), SetPVarFloat(npcid,"current_target_z", 30.958215);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,420.966827,-1600.642211,26.185667))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,436.046722,-1601.534912,25.476661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 436.046722), SetPVarFloat(npcid,"current_target_y", -1601.534912), SetPVarFloat(npcid,"current_target_z", 25.476661);
				case 1: FCNPC_GoTo(npcid,420.130126,-1574.713867,26.243299,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 420.130126), SetPVarFloat(npcid,"current_target_y", -1574.713867), SetPVarFloat(npcid,"current_target_z", 26.243299);
				case 2: FCNPC_GoTo(npcid,394.738494,-1599.359985,28.758079,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 394.738494), SetPVarFloat(npcid,"current_target_y", -1599.359985), SetPVarFloat(npcid,"current_target_z", 28.758079);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,394.738494,-1599.359985,28.758079))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,420.906127,-1600.784790,26.189081,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 420.906127), SetPVarFloat(npcid,"current_target_y", -1600.784790), SetPVarFloat(npcid,"current_target_z", 26.189081);
				case 1: FCNPC_GoTo(npcid,397.014312,-1574.323852,28.496021,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 397.014312), SetPVarFloat(npcid,"current_target_y", -1574.323852), SetPVarFloat(npcid,"current_target_z", 28.496021);
				case 2: FCNPC_GoTo(npcid,377.362915,-1598.949707,30.990982,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 377.362915), SetPVarFloat(npcid,"current_target_y", -1598.949707), SetPVarFloat(npcid,"current_target_z", 30.990982);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,377.362915,-1598.949707,30.990982))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,394.628479,-1599.479492,28.772216,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 394.628479), SetPVarFloat(npcid,"current_target_y", -1599.479492), SetPVarFloat(npcid,"current_target_z", 28.772216);
				case 1: FCNPC_GoTo(npcid,379.452392,-1574.374755,30.722467,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 379.452392), SetPVarFloat(npcid,"current_target_y", -1574.374755), SetPVarFloat(npcid,"current_target_z", 30.722467);
				case 2: FCNPC_GoTo(npcid,340.940368,-1597.399780,33.219013,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 340.940368), SetPVarFloat(npcid,"current_target_y", -1597.399780), SetPVarFloat(npcid,"current_target_z", 33.219013);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,379.328277,-1574.494873,30.738416))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,341.930297,-1572.510498,33.203289,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 341.930297), SetPVarFloat(npcid,"current_target_y", -1572.510498), SetPVarFloat(npcid,"current_target_z", 33.203289);
				case 1: FCNPC_GoTo(npcid,377.610046,-1599.249389,30.959222,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 377.610046), SetPVarFloat(npcid,"current_target_y", -1599.249389), SetPVarFloat(npcid,"current_target_z", 30.959222);
				case 2: FCNPC_GoTo(npcid,397.000793,-1574.393676,28.497449,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 397.000793), SetPVarFloat(npcid,"current_target_y", -1574.393676), SetPVarFloat(npcid,"current_target_z", 28.497449);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,397.000793,-1574.393676,28.497449))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,379.367401,-1574.472167,30.733388,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 379.367401), SetPVarFloat(npcid,"current_target_y", -1574.472167), SetPVarFloat(npcid,"current_target_z", 30.733388);
				case 1: FCNPC_GoTo(npcid,394.786285,-1599.077026,28.751937,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 394.786285), SetPVarFloat(npcid,"current_target_y", -1599.077026), SetPVarFloat(npcid,"current_target_z", 28.751937);
				case 2: FCNPC_GoTo(npcid,419.943969,-1574.784790,26.254043,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 419.943969), SetPVarFloat(npcid,"current_target_y", -1574.784790), SetPVarFloat(npcid,"current_target_z", 26.254043);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,419.943969,-1574.784790,26.254043))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,396.915191,-1574.364868,28.506486,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 396.915191), SetPVarFloat(npcid,"current_target_y", -1574.364868), SetPVarFloat(npcid,"current_target_z", 28.506486);
				case 1: FCNPC_GoTo(npcid,420.964233,-1600.802734,26.185811,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 420.964233), SetPVarFloat(npcid,"current_target_y", -1600.802734), SetPVarFloat(npcid,"current_target_z", 26.185811);
				case 2: FCNPC_GoTo(npcid,436.038055,-1574.507690,25.476661,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 436.038055), SetPVarFloat(npcid,"current_target_y", -1574.507690), SetPVarFloat(npcid,"current_target_z", 25.476661);
				case 3: FCNPC_GoTo(npcid,421.506164,-1572.442626,26.163879,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 421.506164), SetPVarFloat(npcid,"current_target_y", -1572.442626), SetPVarFloat(npcid,"current_target_z", 26.163879);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,394.005798,-1535.263183,32.266395))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,378.999755,-1518.070800,32.732093,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 378.999755), SetPVarFloat(npcid,"current_target_y", -1518.070800), SetPVarFloat(npcid,"current_target_z", 32.732093);
				case 1: FCNPC_GoTo(npcid,401.323791,-1529.826660,32.273536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 401.323791), SetPVarFloat(npcid,"current_target_y", -1529.826660), SetPVarFloat(npcid,"current_target_z", 32.273536);
				case 2: FCNPC_GoTo(npcid,402.601013,-1543.570312,32.273536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 402.601013), SetPVarFloat(npcid,"current_target_y", -1543.570312), SetPVarFloat(npcid,"current_target_z", 32.273536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,401.261596,-1529.844360,32.273536))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,385.087554,-1513.376708,32.524379,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 385.087554), SetPVarFloat(npcid,"current_target_y", -1513.376708), SetPVarFloat(npcid,"current_target_z", 32.524379);
				case 1: FCNPC_GoTo(npcid,394.159576,-1535.395385,32.266395,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 394.159576), SetPVarFloat(npcid,"current_target_y", -1535.395385), SetPVarFloat(npcid,"current_target_z", 32.266395);
				case 2: FCNPC_GoTo(npcid,409.010528,-1539.562377,32.273536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 409.010528), SetPVarFloat(npcid,"current_target_y", -1539.562377), SetPVarFloat(npcid,"current_target_z", 32.273536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,409.010528,-1539.562377,32.273536))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,401.315551,-1530.141601,32.273536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 401.315551), SetPVarFloat(npcid,"current_target_y", -1530.141601), SetPVarFloat(npcid,"current_target_z", 32.273536);
				case 1: FCNPC_GoTo(npcid,411.992858,-1542.635742,32.273536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 411.992858), SetPVarFloat(npcid,"current_target_y", -1542.635742), SetPVarFloat(npcid,"current_target_z", 32.273536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,402.508972,-1543.374389,32.273536))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,394.178100,-1535.389038,32.266395,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 394.178100), SetPVarFloat(npcid,"current_target_y", -1535.389038), SetPVarFloat(npcid,"current_target_z", 32.266395);
				case 1: FCNPC_GoTo(npcid,408.117645,-1546.059814,32.273536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 408.117645), SetPVarFloat(npcid,"current_target_y", -1546.059814), SetPVarFloat(npcid,"current_target_z", 32.273536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,408.117645,-1546.059814,32.273536))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,402.590637,-1543.389892,32.273536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 402.590637), SetPVarFloat(npcid,"current_target_y", -1543.389892), SetPVarFloat(npcid,"current_target_z", 32.273536);
				case 1: FCNPC_GoTo(npcid,410.942413,-1548.779418,30.078224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 410.942413), SetPVarFloat(npcid,"current_target_y", -1548.779418), SetPVarFloat(npcid,"current_target_z", 30.078224);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,411.929321,-1542.712036,32.273536))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,414.710266,-1545.320678,30.078224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 414.710266), SetPVarFloat(npcid,"current_target_y", -1545.320678), SetPVarFloat(npcid,"current_target_z", 30.078224);
				case 1: FCNPC_GoTo(npcid,409.101196,-1539.583618,32.273536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 409.101196), SetPVarFloat(npcid,"current_target_y", -1539.583618), SetPVarFloat(npcid,"current_target_z", 32.273536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,414.714630,-1545.409057,30.078224))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,411.911865,-1542.551391,32.273536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 411.911865), SetPVarFloat(npcid,"current_target_y", -1542.551391), SetPVarFloat(npcid,"current_target_z", 32.273536);
				case 1: FCNPC_GoTo(npcid,416.721618,-1547.311889,30.078224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 416.721618), SetPVarFloat(npcid,"current_target_y", -1547.311889), SetPVarFloat(npcid,"current_target_z", 30.078224);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,411.142333,-1548.761474,30.078224))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,413.317626,-1550.830810,30.078224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 413.317626), SetPVarFloat(npcid,"current_target_y", -1550.830810), SetPVarFloat(npcid,"current_target_z", 30.078224);
				case 1: FCNPC_GoTo(npcid,408.102813,-1546.158935,32.273536,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 408.102813), SetPVarFloat(npcid,"current_target_y", -1546.158935), SetPVarFloat(npcid,"current_target_z", 32.273536);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,413.281005,-1550.855224,30.078224))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,411.019042,-1548.786987,30.078224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 411.019042), SetPVarFloat(npcid,"current_target_y", -1548.786987), SetPVarFloat(npcid,"current_target_z", 30.078224);
				case 1: FCNPC_GoTo(npcid,416.257324,-1553.983520,27.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 416.257324), SetPVarFloat(npcid,"current_target_y", -1553.983520), SetPVarFloat(npcid,"current_target_z", 27.578224);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,416.788574,-1547.282592,30.078224))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,414.626129,-1545.199707,30.078224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 414.626129), SetPVarFloat(npcid,"current_target_y", -1545.199707), SetPVarFloat(npcid,"current_target_z", 30.078224);
				case 1: FCNPC_GoTo(npcid,419.545745,-1550.336425,27.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 419.545745), SetPVarFloat(npcid,"current_target_y", -1550.336425), SetPVarFloat(npcid,"current_target_z", 27.578224);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,419.545745,-1550.336425,27.578224))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,416.728271,-1547.428955,30.078224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 416.728271), SetPVarFloat(npcid,"current_target_y", -1547.428955), SetPVarFloat(npcid,"current_target_z", 30.078224);
				case 1: FCNPC_GoTo(npcid,430.294433,-1560.918945,27.569715,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 430.294433), SetPVarFloat(npcid,"current_target_y", -1560.918945), SetPVarFloat(npcid,"current_target_z", 27.569715);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,430.294433,-1560.918945,27.569715))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,419.746459,-1550.549194,27.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 419.746459), SetPVarFloat(npcid,"current_target_y", -1550.549194), SetPVarFloat(npcid,"current_target_z", 27.578224);
				case 1: FCNPC_GoTo(npcid,432.459808,-1560.879882,26.968013,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 432.459808), SetPVarFloat(npcid,"current_target_y", -1560.879882), SetPVarFloat(npcid,"current_target_z", 26.968013);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,432.459808,-1560.879882,26.968013))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,430.474060,-1560.921630,27.569232,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 430.474060), SetPVarFloat(npcid,"current_target_y", -1560.921630), SetPVarFloat(npcid,"current_target_z", 27.569232);
				case 1: FCNPC_GoTo(npcid,436.018157,-1560.821044,26.953239,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 436.018157), SetPVarFloat(npcid,"current_target_y", -1560.821044), SetPVarFloat(npcid,"current_target_z", 26.953239);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,416.322723,-1553.854003,27.578224))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,412.984619,-1550.734497,30.078224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 412.984619), SetPVarFloat(npcid,"current_target_y", -1550.734497), SetPVarFloat(npcid,"current_target_z", 30.078224);
				case 1: FCNPC_GoTo(npcid,421.622894,-1568.955932,27.565298,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 421.622894), SetPVarFloat(npcid,"current_target_y", -1568.955932), SetPVarFloat(npcid,"current_target_z", 27.565298);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,421.622894,-1568.955932,27.565298))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,416.270355,-1553.822875,27.578224,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 416.270355), SetPVarFloat(npcid,"current_target_y", -1553.822875), SetPVarFloat(npcid,"current_target_z", 27.578224);
				case 1: FCNPC_GoTo(npcid,421.462646,-1572.420288,26.166391,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 421.462646), SetPVarFloat(npcid,"current_target_y", -1572.420288), SetPVarFloat(npcid,"current_target_z", 26.166391);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,421.462646,-1572.420288,26.166391))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,421.559967,-1568.778564,27.566076,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 421.559967), SetPVarFloat(npcid,"current_target_y", -1568.778564), SetPVarFloat(npcid,"current_target_z", 27.566076);
				case 1: FCNPC_GoTo(npcid,420.156860,-1574.769409,26.241756,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 420.156860), SetPVarFloat(npcid,"current_target_y", -1574.769409), SetPVarFloat(npcid,"current_target_z", 26.241756);
	        }
	    }
	}
	if(GetPVarInt(npcid,"hospital_ls")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1273.241455,-1288.107666,13.517853))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1268.097045,-1288.275634,13.509613,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1268.097045), SetPVarFloat(npcid,"current_target_y", -1288.275634), SetPVarFloat(npcid,"current_target_z", 13.509613);
				case 1: FCNPC_GoTo(npcid,1272.816284,-1327.043945,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1272.816284), SetPVarFloat(npcid,"current_target_y", -1327.043945), SetPVarFloat(npcid,"current_target_z", 13.500100);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1272.818847,-1327.183959,13.500100))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1273.264526,-1288.111694,13.517924,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1273.264526), SetPVarFloat(npcid,"current_target_y", -1288.111694), SetPVarFloat(npcid,"current_target_z", 13.517924);
				case 1: FCNPC_GoTo(npcid,1268.047607,-1327.507324,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1268.047607), SetPVarFloat(npcid,"current_target_y", -1327.507324), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 2: FCNPC_GoTo(npcid,1273.509765,-1348.905273,13.507912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1273.509765), SetPVarFloat(npcid,"current_target_y", -1348.905273), SetPVarFloat(npcid,"current_target_z", 13.507912);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1273.509765,-1348.905273,13.507912))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1272.820190,-1327.208007,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1272.820190), SetPVarFloat(npcid,"current_target_y", -1327.208007), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 1: FCNPC_GoTo(npcid,1267.576782,-1348.714965,13.507912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1267.576782), SetPVarFloat(npcid,"current_target_y", -1348.714965), SetPVarFloat(npcid,"current_target_z", 13.507912);
				case 2: FCNPC_GoTo(npcid,1273.379394,-1387.056884,13.379960,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1273.379394), SetPVarFloat(npcid,"current_target_y", -1387.056884), SetPVarFloat(npcid,"current_target_z", 13.379960);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1273.379394,-1387.056884,13.379960))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1273.502197,-1348.600830,13.507912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1273.502197), SetPVarFloat(npcid,"current_target_y", -1348.600830), SetPVarFloat(npcid,"current_target_z", 13.507912);
				case 1: FCNPC_GoTo(npcid,1267.928466,-1387.075561,13.347001,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1267.928466), SetPVarFloat(npcid,"current_target_y", -1387.075561), SetPVarFloat(npcid,"current_target_z", 13.347001);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1265.578979,-1273.167358,13.545761))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1268.104736,-1288.869384,13.496999,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1268.104736), SetPVarFloat(npcid,"current_target_y", -1288.869384), SetPVarFloat(npcid,"current_target_z", 13.496999);
				case 1: FCNPC_GoTo(npcid,1247.644409,-1272.750610,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1247.644409), SetPVarFloat(npcid,"current_target_y", -1272.750610), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1268.143310,-1288.706542,13.500180))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1273.169677,-1288.107543,13.517452,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1273.169677), SetPVarFloat(npcid,"current_target_y", -1288.107543), SetPVarFloat(npcid,"current_target_z", 13.517452);
				case 1: FCNPC_GoTo(npcid,1265.585083,-1273.074951,13.546003,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1265.585083), SetPVarFloat(npcid,"current_target_y", -1273.074951), SetPVarFloat(npcid,"current_target_z", 13.546003);
				case 2: FCNPC_GoTo(npcid,1248.043090,-1289.064819,13.581339,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1248.043090), SetPVarFloat(npcid,"current_target_y", -1289.064819), SetPVarFloat(npcid,"current_target_z", 13.581339);
				case 3: FCNPC_GoTo(npcid,1267.968872,-1327.555175,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1267.968872), SetPVarFloat(npcid,"current_target_y", -1327.555175), SetPVarFloat(npcid,"current_target_z", 13.500100);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1267.968872,-1327.555175,13.500100))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1268.179077,-1288.242675,13.510460,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1268.179077), SetPVarFloat(npcid,"current_target_y", -1288.242675), SetPVarFloat(npcid,"current_target_z", 13.510460);
				case 1: FCNPC_GoTo(npcid,1272.751831,-1327.217529,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1272.751831), SetPVarFloat(npcid,"current_target_y", -1327.217529), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 2: FCNPC_GoTo(npcid,1267.799072,-1349.397949,13.501271,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1267.799072), SetPVarFloat(npcid,"current_target_y", -1349.397949), SetPVarFloat(npcid,"current_target_z", 13.501271);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1267.799072,-1349.397949,13.501271))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1273.396728,-1348.273071,13.500130,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1273.396728), SetPVarFloat(npcid,"current_target_y", -1348.273071), SetPVarFloat(npcid,"current_target_z", 13.500130);
				case 1: FCNPC_GoTo(npcid,1268.015136,-1327.548706,13.500100,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1268.015136), SetPVarFloat(npcid,"current_target_y", -1327.548706), SetPVarFloat(npcid,"current_target_z", 13.500100);
				case 2: FCNPC_GoTo(npcid,1248.152221,-1349.396606,13.396325,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1248.152221), SetPVarFloat(npcid,"current_target_y", -1349.396606), SetPVarFloat(npcid,"current_target_z", 13.396325);
				case 3: FCNPC_GoTo(npcid,1267.964965,-1386.986328,13.345066,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1267.964965), SetPVarFloat(npcid,"current_target_y", -1386.986328), SetPVarFloat(npcid,"current_target_z", 13.345066);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1267.964965,-1386.986328,13.345066))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1267.835327,-1349.078857,13.507912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1267.835327), SetPVarFloat(npcid,"current_target_y", -1349.078857), SetPVarFloat(npcid,"current_target_z", 13.507912);
				case 1: FCNPC_GoTo(npcid,1273.428588,-1387.059692,13.380023,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1273.428588), SetPVarFloat(npcid,"current_target_y", -1387.059692), SetPVarFloat(npcid,"current_target_z", 13.380023);
				case 2: FCNPC_GoTo(npcid,1267.798828,-1412.562866,13.299524,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1267.798828), SetPVarFloat(npcid,"current_target_y", -1412.562866), SetPVarFloat(npcid,"current_target_z", 13.299524);
				case 3: FCNPC_GoTo(npcid,1247.715698,-1387.092407,13.363951,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1247.715698), SetPVarFloat(npcid,"current_target_y", -1387.092407), SetPVarFloat(npcid,"current_target_z", 13.363951);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1267.697265,-1412.407958,13.289060))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1268.110107,-1386.747436,13.340938,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1268.110107), SetPVarFloat(npcid,"current_target_y", -1386.747436), SetPVarFloat(npcid,"current_target_z", 13.340938);
				case 1: FCNPC_GoTo(npcid,1247.502197,-1413.546386,13.398040,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1247.502197), SetPVarFloat(npcid,"current_target_y", -1413.546386), SetPVarFloat(npcid,"current_target_z", 13.398040);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1247.502197,-1413.546386,13.398040))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1267.861816,-1412.562377,13.299490,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1267.861816), SetPVarFloat(npcid,"current_target_y", -1412.562377), SetPVarFloat(npcid,"current_target_z", 13.299490);
				case 1: FCNPC_GoTo(npcid,1215.060791,-1413.508911,13.358271,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1215.060791), SetPVarFloat(npcid,"current_target_y", -1413.508911), SetPVarFloat(npcid,"current_target_z", 13.358271);
				case 2: FCNPC_GoTo(npcid,1247.855957,-1387.092773,13.362652,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1247.855957), SetPVarFloat(npcid,"current_target_y", -1387.092773), SetPVarFloat(npcid,"current_target_z", 13.362652);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1247.855957,-1387.092773,13.362652))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1247.733032,-1413.590698,13.402459,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1247.733032), SetPVarFloat(npcid,"current_target_y", -1413.590698), SetPVarFloat(npcid,"current_target_z", 13.402459);
				case 1: FCNPC_GoTo(npcid,1268.093994,-1386.773437,13.341381,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1268.093994), SetPVarFloat(npcid,"current_target_y", -1386.773437), SetPVarFloat(npcid,"current_target_z", 13.341381);
				case 2: FCNPC_GoTo(npcid,1247.994995,-1349.503540,13.396377,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1247.994995), SetPVarFloat(npcid,"current_target_y", -1349.503540), SetPVarFloat(npcid,"current_target_z", 13.396377);
				case 3: FCNPC_GoTo(npcid,1214.365112,-1387.171997,13.414960,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1214.365112), SetPVarFloat(npcid,"current_target_y", -1387.171997), SetPVarFloat(npcid,"current_target_z", 13.414960);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1247.972778,-1349.262573,13.396260))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1247.872070,-1387.075073,13.362356,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1247.872070), SetPVarFloat(npcid,"current_target_y", -1387.075073), SetPVarFloat(npcid,"current_target_z", 13.362356);
				case 1: FCNPC_GoTo(npcid,1267.811035,-1348.922973,13.507912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1267.811035), SetPVarFloat(npcid,"current_target_y", -1348.922973), SetPVarFloat(npcid,"current_target_z", 13.507912);
				case 2: FCNPC_GoTo(npcid,1248.012084,-1328.093505,13.388330,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1248.012084), SetPVarFloat(npcid,"current_target_y", -1328.093505), SetPVarFloat(npcid,"current_target_z", 13.388330);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1248.012084,-1328.093505,13.388330))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1247.997680,-1349.376464,13.396315,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1247.997680), SetPVarFloat(npcid,"current_target_y", -1349.376464), SetPVarFloat(npcid,"current_target_z", 13.396315);
				case 1: FCNPC_GoTo(npcid,1248.174072,-1288.870727,13.598216,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1248.174072), SetPVarFloat(npcid,"current_target_y", -1288.870727), SetPVarFloat(npcid,"current_target_z", 13.598216);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1248.174072,-1288.870727,13.598216))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1248.055541,-1328.228637,13.388363,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1248.055541), SetPVarFloat(npcid,"current_target_y", -1328.228637), SetPVarFloat(npcid,"current_target_z", 13.388363);
				case 1: FCNPC_GoTo(npcid,1223.837890,-1288.490478,13.555656,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1223.837890), SetPVarFloat(npcid,"current_target_y", -1288.490478), SetPVarFloat(npcid,"current_target_z", 13.555656);
				case 2: FCNPC_GoTo(npcid,1267.955200,-1288.508178,13.501873,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1267.955200), SetPVarFloat(npcid,"current_target_y", -1288.508178), SetPVarFloat(npcid,"current_target_z", 13.501873);
				case 3: FCNPC_GoTo(npcid,1247.787475,-1273.160644,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1247.787475), SetPVarFloat(npcid,"current_target_y", -1273.160644), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1247.787475,-1273.160644,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1248.096313,-1289.099975,13.581051,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1248.096313), SetPVarFloat(npcid,"current_target_y", -1289.099975), SetPVarFloat(npcid,"current_target_z", 13.581051);
				case 1: FCNPC_GoTo(npcid,1265.852661,-1272.947509,13.546084,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1265.852661), SetPVarFloat(npcid,"current_target_y", -1272.947509), SetPVarFloat(npcid,"current_target_z", 13.546084);
				case 2: FCNPC_GoTo(npcid,1223.798217,-1273.152099,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1223.798217), SetPVarFloat(npcid,"current_target_y", -1273.152099), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1223.974243,-1273.165649,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1247.671630,-1273.316406,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1247.671630), SetPVarFloat(npcid,"current_target_y", -1273.316406), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1224.056884,-1288.284301,13.555416,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1224.056884), SetPVarFloat(npcid,"current_target_y", -1288.284301), SetPVarFloat(npcid,"current_target_z", 13.555416);
				case 2: FCNPC_GoTo(npcid,1208.502807,-1273.295532,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1208.502807), SetPVarFloat(npcid,"current_target_y", -1273.295532), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1224.063720,-1288.270263,13.555392))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1248.078002,-1289.043823,13.583911,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1248.078002), SetPVarFloat(npcid,"current_target_y", -1289.043823), SetPVarFloat(npcid,"current_target_z", 13.583911);
				case 1: FCNPC_GoTo(npcid,1224.114501,-1273.109130,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1224.114501), SetPVarFloat(npcid,"current_target_y", -1273.109130), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1214.135620,-1289.293212,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1214.135620), SetPVarFloat(npcid,"current_target_y", -1289.293212), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1187.566772,-1273.163085,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1208.617187,-1273.333129,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1208.617187), SetPVarFloat(npcid,"current_target_y", -1273.333129), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1187.843505,-1287.877197,13.554163,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.843505), SetPVarFloat(npcid,"current_target_y", -1287.877197), SetPVarFloat(npcid,"current_target_z", 13.554163);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1187.820434,-1287.757934,13.554163))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1187.565307,-1273.106811,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.565307), SetPVarFloat(npcid,"current_target_y", -1273.106811), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1213.986938,-1289.479980,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.986938), SetPVarFloat(npcid,"current_target_y", -1289.479980), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1187.819702,-1313.030029,13.564318,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.819702), SetPVarFloat(npcid,"current_target_y", -1313.030029), SetPVarFloat(npcid,"current_target_z", 13.564318);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1187.819702,-1313.030029,13.564318))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1187.865478,-1287.570678,13.554163,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.865478), SetPVarFloat(npcid,"current_target_y", -1287.570678), SetPVarFloat(npcid,"current_target_z", 13.554163);
				case 1: FCNPC_GoTo(npcid,1213.727539,-1312.119018,13.556322,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.727539), SetPVarFloat(npcid,"current_target_y", -1312.119018), SetPVarFloat(npcid,"current_target_z", 13.556322);
				case 2: FCNPC_GoTo(npcid,1187.907226,-1328.864868,13.560411,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.907226), SetPVarFloat(npcid,"current_target_y", -1328.864868), SetPVarFloat(npcid,"current_target_z", 13.560411);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1187.907226,-1328.864868,13.560411))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1187.847534,-1313.138671,13.564345,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.847534), SetPVarFloat(npcid,"current_target_y", -1313.138671), SetPVarFloat(npcid,"current_target_z", 13.564345);
				case 1: FCNPC_GoTo(npcid,1213.981811,-1328.623657,13.568125,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.981811), SetPVarFloat(npcid,"current_target_y", -1328.623657), SetPVarFloat(npcid,"current_target_z", 13.568125);
				case 2: FCNPC_GoTo(npcid,1187.868164,-1346.329833,13.566712,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.868164), SetPVarFloat(npcid,"current_target_y", -1346.329833), SetPVarFloat(npcid,"current_target_z", 13.566712);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1187.868164,-1346.329833,13.566712))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1188.070556,-1328.799194,13.560395,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1188.070556), SetPVarFloat(npcid,"current_target_y", -1328.799194), SetPVarFloat(npcid,"current_target_z", 13.560395);
				case 1: FCNPC_GoTo(npcid,1213.735839,-1345.404174,13.572264,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.735839), SetPVarFloat(npcid,"current_target_y", -1345.404174), SetPVarFloat(npcid,"current_target_z", 13.572264);
				case 2: FCNPC_GoTo(npcid,1187.765014,-1360.521728,13.557698,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.765014), SetPVarFloat(npcid,"current_target_y", -1360.521728), SetPVarFloat(npcid,"current_target_z", 13.557698);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1187.765014,-1360.521728,13.557698))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1187.852172,-1346.654296,13.566870,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.852172), SetPVarFloat(npcid,"current_target_y", -1346.654296), SetPVarFloat(npcid,"current_target_z", 13.566870);
				case 1: FCNPC_GoTo(npcid,1213.989868,-1360.177490,13.548059,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.989868), SetPVarFloat(npcid,"current_target_y", -1360.177490), SetPVarFloat(npcid,"current_target_z", 13.548059);
				case 2: FCNPC_GoTo(npcid,1187.556274,-1387.456298,13.551453,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.556274), SetPVarFloat(npcid,"current_target_y", -1387.456298), SetPVarFloat(npcid,"current_target_z", 13.551453);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1187.556274,-1387.456298,13.551453))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1187.889160,-1360.371948,13.557991,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.889160), SetPVarFloat(npcid,"current_target_y", -1360.371948), SetPVarFloat(npcid,"current_target_z", 13.557991);
				case 1: FCNPC_GoTo(npcid,1214.390991,-1387.249511,13.415440,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1214.390991), SetPVarFloat(npcid,"current_target_y", -1387.249511), SetPVarFloat(npcid,"current_target_z", 13.415440);
				case 2: FCNPC_GoTo(npcid,1205.886474,-1412.782592,13.380635,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1205.886474), SetPVarFloat(npcid,"current_target_y", -1412.782592), SetPVarFloat(npcid,"current_target_z", 13.380635);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1205.886474,-1412.782592,13.380635))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1187.547729,-1387.249145,13.550860,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.547729), SetPVarFloat(npcid,"current_target_y", -1387.249145), SetPVarFloat(npcid,"current_target_z", 13.550860);
				case 1: FCNPC_GoTo(npcid,1214.953613,-1413.468750,13.358415,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1214.953613), SetPVarFloat(npcid,"current_target_y", -1413.468750), SetPVarFloat(npcid,"current_target_z", 13.358415);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1214.834472,-1413.682495,13.361857))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1205.978881,-1412.929443,13.381492,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1205.978881), SetPVarFloat(npcid,"current_target_y", -1412.929443), SetPVarFloat(npcid,"current_target_z", 13.381492);
				case 1: FCNPC_GoTo(npcid,1247.621948,-1413.778198,13.407067,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1247.621948), SetPVarFloat(npcid,"current_target_y", -1413.778198), SetPVarFloat(npcid,"current_target_z", 13.407067);
				case 2: FCNPC_GoTo(npcid,1214.311401,-1387.155151,13.414879,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1214.311401), SetPVarFloat(npcid,"current_target_y", -1387.155151), SetPVarFloat(npcid,"current_target_z", 13.414879);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1214.311401,-1387.155151,13.414879))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1247.607299,-1387.120727,13.365192,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1247.607299), SetPVarFloat(npcid,"current_target_y", -1387.120727), SetPVarFloat(npcid,"current_target_z", 13.365192);
				case 1: FCNPC_GoTo(npcid,1215.163574,-1413.385986,13.356082,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1215.163574), SetPVarFloat(npcid,"current_target_y", -1413.385986), SetPVarFloat(npcid,"current_target_z", 13.356082);
				case 2: FCNPC_GoTo(npcid,1187.503173,-1387.331420,13.551739,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.503173), SetPVarFloat(npcid,"current_target_y", -1387.331420), SetPVarFloat(npcid,"current_target_z", 13.551739);
				case 3: FCNPC_GoTo(npcid,1213.838867,-1360.199340,13.547952,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.838867), SetPVarFloat(npcid,"current_target_y", -1360.199340), SetPVarFloat(npcid,"current_target_z", 13.547952);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1213.838867,-1360.199340,13.547952))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1214.238647,-1387.420288,13.416599,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1214.238647), SetPVarFloat(npcid,"current_target_y", -1387.420288), SetPVarFloat(npcid,"current_target_z", 13.416599);
				case 1: FCNPC_GoTo(npcid,1187.563842,-1360.300659,13.558130,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.563842), SetPVarFloat(npcid,"current_target_y", -1360.300659), SetPVarFloat(npcid,"current_target_z", 13.558130);
				case 2: FCNPC_GoTo(npcid,1213.598876,-1345.440429,13.572273,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.598876), SetPVarFloat(npcid,"current_target_y", -1345.440429), SetPVarFloat(npcid,"current_target_z", 13.572273);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1213.598876,-1345.440429,13.572273))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1213.695922,-1359.956665,13.549138,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.695922), SetPVarFloat(npcid,"current_target_y", -1359.956665), SetPVarFloat(npcid,"current_target_z", 13.549138);
				case 1: FCNPC_GoTo(npcid,1187.820556,-1346.385620,13.566739,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.820556), SetPVarFloat(npcid,"current_target_y", -1346.385620), SetPVarFloat(npcid,"current_target_z", 13.566739);
				case 2: FCNPC_GoTo(npcid,1213.849609,-1328.554565,13.568108,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.849609), SetPVarFloat(npcid,"current_target_y", -1328.554565), SetPVarFloat(npcid,"current_target_z", 13.568108);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1213.849609,-1328.554565,13.568108))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1213.632446,-1345.655273,13.572325,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.632446), SetPVarFloat(npcid,"current_target_y", -1345.655273), SetPVarFloat(npcid,"current_target_z", 13.572325);
				case 1: FCNPC_GoTo(npcid,1187.959594,-1328.814575,13.560399,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.959594), SetPVarFloat(npcid,"current_target_y", -1328.814575), SetPVarFloat(npcid,"current_target_z", 13.560399);
				case 2: FCNPC_GoTo(npcid,1213.757202,-1312.276367,13.556360,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.757202), SetPVarFloat(npcid,"current_target_y", -1312.276367), SetPVarFloat(npcid,"current_target_z", 13.556360);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1213.757202,-1312.276367,13.556360))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1213.869995,-1328.518554,13.568099,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.869995), SetPVarFloat(npcid,"current_target_y", -1328.518554), SetPVarFloat(npcid,"current_target_z", 13.568099);
				case 1: FCNPC_GoTo(npcid,1187.957641,-1313.105590,13.564336,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.957641), SetPVarFloat(npcid,"current_target_y", -1313.105590), SetPVarFloat(npcid,"current_target_z", 13.564336);
				case 2: FCNPC_GoTo(npcid,1213.800537,-1289.599975,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.800537), SetPVarFloat(npcid,"current_target_y", -1289.599975), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1213.800537,-1289.599975,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,1213.769409,-1312.167114,13.556333,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.769409), SetPVarFloat(npcid,"current_target_y", -1312.167114), SetPVarFloat(npcid,"current_target_z", 13.556333);
				case 1: FCNPC_GoTo(npcid,1187.869384,-1287.700439,13.554163,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.869384), SetPVarFloat(npcid,"current_target_y", -1287.700439), SetPVarFloat(npcid,"current_target_z", 13.554163);
				case 2: FCNPC_GoTo(npcid,1224.153564,-1288.319335,13.555587,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1224.153564), SetPVarFloat(npcid,"current_target_y", -1288.319335), SetPVarFloat(npcid,"current_target_z", 13.555587);
				case 3: FCNPC_GoTo(npcid,1208.638427,-1273.340087,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1208.638427), SetPVarFloat(npcid,"current_target_y", -1273.340087), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1208.600952,-1273.366333,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1223.896362,-1273.059082,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1223.896362), SetPVarFloat(npcid,"current_target_y", -1273.059082), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,1187.591796,-1273.112548,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1187.591796), SetPVarFloat(npcid,"current_target_y", -1273.112548), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,1213.902221,-1289.804809,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.902221), SetPVarFloat(npcid,"current_target_y", -1289.804809), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	}
	if(GetPVarInt(npcid,"tradeplace")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,789.060485,-1312.028320,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,789.341735,-1328.292236,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.341735), SetPVarFloat(npcid,"current_target_y", -1328.292236), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,805.114196,-1312.071777,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 805.114196), SetPVarFloat(npcid,"current_target_y", -1312.071777), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,789.425292,-1328.240844,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,789.109619,-1311.915039,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.109619), SetPVarFloat(npcid,"current_target_y", -1311.915039), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,805.343627,-1335.022583,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 805.343627), SetPVarFloat(npcid,"current_target_y", -1335.022583), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,789.246459,-1387.525268,13.728281,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.246459), SetPVarFloat(npcid,"current_target_y", -1387.525268), SetPVarFloat(npcid,"current_target_z", 13.728281);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,789.246459,-1387.525268,13.728281))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,789.600646,-1327.963012,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.600646), SetPVarFloat(npcid,"current_target_y", -1327.963012), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,805.909667,-1387.957031,13.558815,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 805.909667), SetPVarFloat(npcid,"current_target_y", -1387.957031), SetPVarFloat(npcid,"current_target_z", 13.558815);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,805.909667,-1387.957031,13.558815))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,852.996765,-1387.272827,13.745176,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 852.996765), SetPVarFloat(npcid,"current_target_y", -1387.272827), SetPVarFloat(npcid,"current_target_z", 13.745176);
				case 1: FCNPC_GoTo(npcid,789.209045,-1387.365844,13.728238,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.209045), SetPVarFloat(npcid,"current_target_y", -1387.365844), SetPVarFloat(npcid,"current_target_z", 13.728238);
				case 2: FCNPC_GoTo(npcid,805.131958,-1334.726928,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 805.131958), SetPVarFloat(npcid,"current_target_y", -1334.726928), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,805.131958,-1334.726928,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,805.396972,-1388.054687,13.555512,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 805.396972), SetPVarFloat(npcid,"current_target_y", -1388.054687), SetPVarFloat(npcid,"current_target_z", 13.555512);
				case 1: FCNPC_GoTo(npcid,789.540771,-1327.998291,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.540771), SetPVarFloat(npcid,"current_target_y", -1327.998291), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,805.255554,-1311.756835,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 805.255554), SetPVarFloat(npcid,"current_target_y", -1311.756835), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,842.135986,-1334.941284,13.573524,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 842.135986), SetPVarFloat(npcid,"current_target_y", -1334.941284), SetPVarFloat(npcid,"current_target_z", 13.573524);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,805.244812,-1311.583374,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,805.273376,-1335.125976,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 805.273376), SetPVarFloat(npcid,"current_target_y", -1335.125976), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,789.103332,-1312.220581,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 789.103332), SetPVarFloat(npcid,"current_target_y", -1312.220581), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,840.360290,-1312.310424,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 840.360290), SetPVarFloat(npcid,"current_target_y", -1312.310424), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,840.360290,-1312.310424,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,805.155517,-1311.913208,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 805.155517), SetPVarFloat(npcid,"current_target_y", -1311.913208), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,841.924133,-1334.880737,13.573776,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 841.924133), SetPVarFloat(npcid,"current_target_y", -1334.880737), SetPVarFloat(npcid,"current_target_z", 13.573776);
				case 2: FCNPC_GoTo(npcid,863.546386,-1311.608398,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 863.546386), SetPVarFloat(npcid,"current_target_y", -1311.608398), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,863.546386,-1311.608398,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,840.676696,-1312.094970,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 840.676696), SetPVarFloat(npcid,"current_target_y", -1312.094970), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,863.167236,-1334.474853,13.568890,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 863.167236), SetPVarFloat(npcid,"current_target_y", -1334.474853), SetPVarFloat(npcid,"current_target_z", 13.568890);
				case 2: FCNPC_GoTo(npcid,884.066772,-1312.137207,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 884.066772), SetPVarFloat(npcid,"current_target_y", -1312.137207), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,884.066772,-1312.137207,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,863.368896,-1311.754638,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 863.368896), SetPVarFloat(npcid,"current_target_y", -1311.754638), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,890.464660,-1334.648437,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 890.464660), SetPVarFloat(npcid,"current_target_y", -1334.648437), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,903.802551,-1311.842773,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 903.802551), SetPVarFloat(npcid,"current_target_y", -1311.842773), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,903.802551,-1311.842773,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,884.107116,-1311.740356,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 884.107116), SetPVarFloat(npcid,"current_target_y", -1311.740356), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,910.440734,-1334.784057,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 910.440734), SetPVarFloat(npcid,"current_target_y", -1334.784057), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,841.987365,-1334.889892,13.573950))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,805.052734,-1335.034667,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 805.052734), SetPVarFloat(npcid,"current_target_y", -1335.034667), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,840.531250,-1312.220092,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 840.531250), SetPVarFloat(npcid,"current_target_y", -1312.220092), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,863.354309,-1334.931030,13.567500,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 863.354309), SetPVarFloat(npcid,"current_target_y", -1334.931030), SetPVarFloat(npcid,"current_target_z", 13.567500);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,863.354309,-1334.931030,13.567500))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,841.928649,-1334.931640,13.572377,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 841.928649), SetPVarFloat(npcid,"current_target_y", -1334.931640), SetPVarFloat(npcid,"current_target_z", 13.572377);
				case 1: FCNPC_GoTo(npcid,863.551269,-1311.757446,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 863.551269), SetPVarFloat(npcid,"current_target_y", -1311.757446), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,890.585815,-1334.701171,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 890.585815), SetPVarFloat(npcid,"current_target_y", -1334.701171), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,890.585815,-1334.701171,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,863.300720,-1334.552734,13.567958,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 863.300720), SetPVarFloat(npcid,"current_target_y", -1334.552734), SetPVarFloat(npcid,"current_target_z", 13.567958);
				case 1: FCNPC_GoTo(npcid,884.163452,-1312.042968,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 884.163452), SetPVarFloat(npcid,"current_target_y", -1312.042968), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,910.591857,-1334.729614,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 910.591857), SetPVarFloat(npcid,"current_target_y", -1334.729614), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,910.591857,-1334.729614,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,890.352600,-1334.677490,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 890.352600), SetPVarFloat(npcid,"current_target_y", -1334.677490), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,903.656372,-1311.750244,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 903.656372), SetPVarFloat(npcid,"current_target_y", -1311.750244), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,909.652221,-1361.055419,13.382054,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 909.652221), SetPVarFloat(npcid,"current_target_y", -1361.055419), SetPVarFloat(npcid,"current_target_z", 13.382054);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,909.652221,-1361.055419,13.382054))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,910.824829,-1334.721069,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 910.824829), SetPVarFloat(npcid,"current_target_y", -1334.721069), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,909.220092,-1386.390258,13.550583,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 909.220092), SetPVarFloat(npcid,"current_target_y", -1386.390258), SetPVarFloat(npcid,"current_target_z", 13.550583);
				case 2: FCNPC_GoTo(npcid,899.842346,-1360.603393,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 899.842346), SetPVarFloat(npcid,"current_target_y", -1360.603393), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,909.209716,-1386.240844,13.549471))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,902.981689,-1387.201782,13.468850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 902.981689), SetPVarFloat(npcid,"current_target_y", -1387.201782), SetPVarFloat(npcid,"current_target_z", 13.468850);
				case 1: FCNPC_GoTo(npcid,909.908264,-1361.085815,13.382798,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 909.908264), SetPVarFloat(npcid,"current_target_y", -1361.085815), SetPVarFloat(npcid,"current_target_z", 13.382798);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,902.995544,-1386.960449,13.477839))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,909.366027,-1386.560546,13.548771,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 909.366027), SetPVarFloat(npcid,"current_target_y", -1386.560546), SetPVarFloat(npcid,"current_target_z", 13.548771);
				case 1: FCNPC_GoTo(npcid,853.013366,-1386.511474,13.780264,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 853.013366), SetPVarFloat(npcid,"current_target_y", -1386.511474), SetPVarFloat(npcid,"current_target_z", 13.780264);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,853.013366,-1386.511474,13.780264))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,903.019592,-1386.935302,13.478819,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 903.019592), SetPVarFloat(npcid,"current_target_y", -1386.935302), SetPVarFloat(npcid,"current_target_z", 13.478819);
				case 1: FCNPC_GoTo(npcid,853.362304,-1379.524536,13.568477,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 853.362304), SetPVarFloat(npcid,"current_target_y", -1379.524536), SetPVarFloat(npcid,"current_target_z", 13.568477);
				case 2: FCNPC_GoTo(npcid,805.716003,-1387.920898,13.557978,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 805.716003), SetPVarFloat(npcid,"current_target_y", -1387.920898), SetPVarFloat(npcid,"current_target_z", 13.557978);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,853.430358,-1379.390625,13.567184))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,852.751770,-1386.839477,13.766454,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 852.751770), SetPVarFloat(npcid,"current_target_y", -1386.839477), SetPVarFloat(npcid,"current_target_z", 13.766454);
				case 1: FCNPC_GoTo(npcid,854.265869,-1370.506347,13.657978,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 854.265869), SetPVarFloat(npcid,"current_target_y", -1370.506347), SetPVarFloat(npcid,"current_target_z", 13.657978);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,854.265869,-1370.506347,13.657978))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,853.344055,-1379.801513,13.574714,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 853.344055), SetPVarFloat(npcid,"current_target_y", -1379.801513), SetPVarFloat(npcid,"current_target_z", 13.574714);
				case 1: FCNPC_GoTo(npcid,859.433166,-1367.118408,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 859.433166), SetPVarFloat(npcid,"current_target_y", -1367.118408), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,859.433166,-1367.118408,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,854.305053,-1370.588256,13.656570,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 854.305053), SetPVarFloat(npcid,"current_target_y", -1370.588256), SetPVarFloat(npcid,"current_target_z", 13.656570);
				case 1: FCNPC_GoTo(npcid,866.230163,-1362.719116,13.612751,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 866.230163), SetPVarFloat(npcid,"current_target_y", -1362.719116), SetPVarFloat(npcid,"current_target_z", 13.612751);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,866.230163,-1362.719116,13.612751))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,859.323730,-1367.162719,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 859.323730), SetPVarFloat(npcid,"current_target_y", -1367.162719), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,872.446777,-1359.161010,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 872.446777), SetPVarFloat(npcid,"current_target_y", -1359.161010), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,872.446777,-1359.161010,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,866.476562,-1362.803344,13.601514,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 866.476562), SetPVarFloat(npcid,"current_target_y", -1362.803344), SetPVarFloat(npcid,"current_target_z", 13.601514);
				case 1: FCNPC_GoTo(npcid,880.765197,-1359.682006,13.699814,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 880.765197), SetPVarFloat(npcid,"current_target_y", -1359.682006), SetPVarFloat(npcid,"current_target_z", 13.699814);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,880.765197,-1359.682006,13.699814))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,872.210266,-1359.228637,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 872.210266), SetPVarFloat(npcid,"current_target_y", -1359.228637), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,886.925720,-1359.939331,13.809991,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 886.925720), SetPVarFloat(npcid,"current_target_y", -1359.939331), SetPVarFloat(npcid,"current_target_z", 13.809991);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,886.925720,-1359.939331,13.809991))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,880.859497,-1359.600585,13.707524,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 880.859497), SetPVarFloat(npcid,"current_target_y", -1359.600585), SetPVarFloat(npcid,"current_target_z", 13.707524);
				case 1: FCNPC_GoTo(npcid,895.364074,-1360.236816,13.872065,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 895.364074), SetPVarFloat(npcid,"current_target_y", -1360.236816), SetPVarFloat(npcid,"current_target_z", 13.872065);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,895.364074,-1360.236816,13.872065))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,887.014953,-1359.841552,13.802424,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 887.014953), SetPVarFloat(npcid,"current_target_y", -1359.841552), SetPVarFloat(npcid,"current_target_z", 13.802424);
				case 1: FCNPC_GoTo(npcid,900.085998,-1360.632446,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 900.085998), SetPVarFloat(npcid,"current_target_y", -1360.632446), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,900.085998,-1360.632446,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,895.376647,-1360.256469,13.873756,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 895.376647), SetPVarFloat(npcid,"current_target_y", -1360.256469), SetPVarFloat(npcid,"current_target_z", 13.873756);
				case 1: FCNPC_GoTo(npcid,909.512634,-1361.154541,13.382464,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 909.512634), SetPVarFloat(npcid,"current_target_y", -1361.154541), SetPVarFloat(npcid,"current_target_z", 13.382464);
			}
		}
	}
	if(GetPVarInt(npcid,"losflores")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2745.893066,-1250.524414,59.718849))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2746.060058,-1265.072021,59.748626,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2746.060058), SetPVarFloat(npcid,"current_target_y", -1265.072021), SetPVarFloat(npcid,"current_target_z", 59.748626);
				case 1: FCNPC_GoTo(npcid,2754.983886,-1250.514526,58.371307,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2754.983886), SetPVarFloat(npcid,"current_target_y", -1250.514526), SetPVarFloat(npcid,"current_target_z", 58.371307);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2754.983886,-1250.514526,58.371307))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2745.727050,-1250.522338,59.718849,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2745.727050), SetPVarFloat(npcid,"current_target_y", -1250.522338), SetPVarFloat(npcid,"current_target_z", 59.718849);
				case 1: FCNPC_GoTo(npcid,2755.634277,-1265.108154,58.144443,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2755.634277), SetPVarFloat(npcid,"current_target_y", -1265.108154), SetPVarFloat(npcid,"current_target_z", 58.144443);
				case 2: FCNPC_GoTo(npcid,2763.651855,-1250.237304,54.732872,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2763.651855), SetPVarFloat(npcid,"current_target_y", -1250.237304), SetPVarFloat(npcid,"current_target_z", 54.732872);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2763.651855,-1250.237304,54.732872))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2754.871826,-1250.589355,58.404945,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2754.871826), SetPVarFloat(npcid,"current_target_y", -1250.589355), SetPVarFloat(npcid,"current_target_z", 58.404945);
				case 1: FCNPC_GoTo(npcid,2763.410400,-1265.466796,54.840324,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2763.410400), SetPVarFloat(npcid,"current_target_y", -1265.466796), SetPVarFloat(npcid,"current_target_z", 54.840324);
				case 2: FCNPC_GoTo(npcid,2778.505371,-1250.329345,48.551025,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2778.505371), SetPVarFloat(npcid,"current_target_y", -1250.329345), SetPVarFloat(npcid,"current_target_z", 48.551025);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2778.505371,-1250.329345,48.551025))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2763.487304,-1250.250976,54.808647,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2763.487304), SetPVarFloat(npcid,"current_target_y", -1250.250976), SetPVarFloat(npcid,"current_target_z", 54.808647);
				case 1: FCNPC_GoTo(npcid,2778.799316,-1265.754516,48.487323,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2778.799316), SetPVarFloat(npcid,"current_target_y", -1265.754516), SetPVarFloat(npcid,"current_target_z", 48.487323);
				case 2: FCNPC_GoTo(npcid,2790.131347,-1250.895507,46.953334,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2790.131347), SetPVarFloat(npcid,"current_target_y", -1250.895507), SetPVarFloat(npcid,"current_target_z", 46.953334);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2790.131347,-1250.895507,46.953334))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2778.350585,-1250.208740,48.580909,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2778.350585), SetPVarFloat(npcid,"current_target_y", -1250.208740), SetPVarFloat(npcid,"current_target_z", 48.580909);
				case 1: FCNPC_GoTo(npcid,2788.390136,-1265.848388,46.944263,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2788.390136), SetPVarFloat(npcid,"current_target_y", -1265.848388), SetPVarFloat(npcid,"current_target_z", 46.944263);
				case 2: FCNPC_GoTo(npcid,2799.663574,-1256.194335,46.959560,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2799.663574), SetPVarFloat(npcid,"current_target_y", -1256.194335), SetPVarFloat(npcid,"current_target_z", 46.959560);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2799.663574,-1256.194335,46.959560))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2790.028076,-1250.712768,46.953258,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2790.028076), SetPVarFloat(npcid,"current_target_y", -1250.712768), SetPVarFloat(npcid,"current_target_z", 46.953258);
				case 1: FCNPC_GoTo(npcid,2804.518066,-1266.958129,46.833446,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.518066), SetPVarFloat(npcid,"current_target_y", -1266.958129), SetPVarFloat(npcid,"current_target_z", 46.833446);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2804.518066,-1266.958129,46.833446))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2799.588134,-1255.918701,46.959560,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2799.588134), SetPVarFloat(npcid,"current_target_y", -1255.918701), SetPVarFloat(npcid,"current_target_z", 46.959560);
				case 1: FCNPC_GoTo(npcid,2803.889160,-1271.847167,46.068073,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2803.889160), SetPVarFloat(npcid,"current_target_y", -1271.847167), SetPVarFloat(npcid,"current_target_z", 46.068073);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2803.889160,-1271.847167,46.068073))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2804.565673,-1266.851928,46.846321,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.565673), SetPVarFloat(npcid,"current_target_y", -1266.851928), SetPVarFloat(npcid,"current_target_z", 46.846321);
				case 1: FCNPC_GoTo(npcid,2788.998046,-1272.673828,45.874790,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2788.998046), SetPVarFloat(npcid,"current_target_y", -1272.673828), SetPVarFloat(npcid,"current_target_z", 45.874790);
				case 2: FCNPC_GoTo(npcid,2804.047363,-1287.367187,42.595088,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.047363), SetPVarFloat(npcid,"current_target_y", -1287.367187), SetPVarFloat(npcid,"current_target_z", 42.595088);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2804.047363,-1287.367187,42.595088))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2803.993652,-1271.697387,46.101646,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2803.993652), SetPVarFloat(npcid,"current_target_y", -1271.697387), SetPVarFloat(npcid,"current_target_z", 46.101646);
				case 1: FCNPC_GoTo(npcid,2789.191162,-1288.285034,42.362857,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.191162), SetPVarFloat(npcid,"current_target_y", -1288.285034), SetPVarFloat(npcid,"current_target_z", 42.362857);
				case 2: FCNPC_GoTo(npcid,2804.628906,-1309.882202,37.192420,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.628906), SetPVarFloat(npcid,"current_target_y", -1309.882202), SetPVarFloat(npcid,"current_target_z", 37.192420);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2804.628906,-1309.882202,37.192420))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2804.125000,-1287.202270,42.631973,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.125000), SetPVarFloat(npcid,"current_target_y", -1287.202270), SetPVarFloat(npcid,"current_target_z", 42.631973);
				case 1: FCNPC_GoTo(npcid,2789.134033,-1308.234619,37.593711,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.134033), SetPVarFloat(npcid,"current_target_y", -1308.234619), SetPVarFloat(npcid,"current_target_z", 37.593711);
				case 2: FCNPC_GoTo(npcid,2804.117187,-1332.598266,31.864030,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.117187), SetPVarFloat(npcid,"current_target_y", -1332.598266), SetPVarFloat(npcid,"current_target_z", 31.864030);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2804.117187,-1332.598266,31.864030))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2804.707519,-1309.528198,37.278629,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.707519), SetPVarFloat(npcid,"current_target_y", -1309.528198), SetPVarFloat(npcid,"current_target_z", 37.278629);
				case 1: FCNPC_GoTo(npcid,2789.410888,-1333.880981,31.557275,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.410888), SetPVarFloat(npcid,"current_target_y", -1333.880981), SetPVarFloat(npcid,"current_target_z", 31.557275);
				case 2: FCNPC_GoTo(npcid,2804.189208,-1353.537597,26.788356,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.189208), SetPVarFloat(npcid,"current_target_y", -1353.537597), SetPVarFloat(npcid,"current_target_z", 26.788356);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2804.189208,-1353.537597,26.788356))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2804.152587,-1332.627319,31.857265,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.152587), SetPVarFloat(npcid,"current_target_y", -1332.627319), SetPVarFloat(npcid,"current_target_z", 31.857265);
				case 1: FCNPC_GoTo(npcid,2789.223632,-1353.927978,26.708532,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.223632), SetPVarFloat(npcid,"current_target_y", -1353.927978), SetPVarFloat(npcid,"current_target_z", 26.708532);
				case 2: FCNPC_GoTo(npcid,2804.380859,-1366.157958,23.805526,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.380859), SetPVarFloat(npcid,"current_target_y", -1366.157958), SetPVarFloat(npcid,"current_target_z", 23.805526);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2804.380859,-1366.157958,23.805526))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2804.529785,-1353.320556,26.837356,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.529785), SetPVarFloat(npcid,"current_target_y", -1353.320556), SetPVarFloat(npcid,"current_target_z", 26.837356);
				case 1: FCNPC_GoTo(npcid,2789.259277,-1365.727661,23.908931,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.259277), SetPVarFloat(npcid,"current_target_y", -1365.727661), SetPVarFloat(npcid,"current_target_z", 23.908931);
				case 2: FCNPC_GoTo(npcid,2804.572998,-1377.854003,21.408687,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.572998), SetPVarFloat(npcid,"current_target_y", -1377.854003), SetPVarFloat(npcid,"current_target_z", 21.408687);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2804.572998,-1377.854003,21.408687))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2804.383300,-1366.110229,23.816867,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.383300), SetPVarFloat(npcid,"current_target_y", -1366.110229), SetPVarFloat(npcid,"current_target_z", 23.816867);
				case 1: FCNPC_GoTo(npcid,2789.503906,-1378.124267,21.414966,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.503906), SetPVarFloat(npcid,"current_target_y", -1378.124267), SetPVarFloat(npcid,"current_target_z", 21.414966);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2789.503906,-1378.124267,21.414966))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2804.479736,-1377.903808,21.409685,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.479736), SetPVarFloat(npcid,"current_target_y", -1377.903808), SetPVarFloat(npcid,"current_target_z", 21.409685);
				case 1: FCNPC_GoTo(npcid,2789.448974,-1365.703125,23.914726,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.448974), SetPVarFloat(npcid,"current_target_y", -1365.703125), SetPVarFloat(npcid,"current_target_z", 23.914726);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2789.448974,-1365.703125,23.914726))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2789.458496,-1377.991943,21.414709,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.458496), SetPVarFloat(npcid,"current_target_y", -1377.991943), SetPVarFloat(npcid,"current_target_z", 21.414709);
				case 1: FCNPC_GoTo(npcid,2804.683349,-1366.208251,23.793575,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.683349), SetPVarFloat(npcid,"current_target_y", -1366.208251), SetPVarFloat(npcid,"current_target_z", 23.793575);
				case 2: FCNPC_GoTo(npcid,2789.238525,-1353.862792,26.724096,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.238525), SetPVarFloat(npcid,"current_target_y", -1353.862792), SetPVarFloat(npcid,"current_target_z", 26.724096);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2789.238525,-1353.862792,26.724096))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2789.511474,-1365.839477,23.882534,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.511474), SetPVarFloat(npcid,"current_target_y", -1365.839477), SetPVarFloat(npcid,"current_target_z", 23.882534);
				case 1: FCNPC_GoTo(npcid,2804.333251,-1353.412109,26.817125,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.333251), SetPVarFloat(npcid,"current_target_y", -1353.412109), SetPVarFloat(npcid,"current_target_z", 26.817125);
				case 2: FCNPC_GoTo(npcid,2789.348144,-1333.648559,31.611404,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.348144), SetPVarFloat(npcid,"current_target_y", -1333.648559), SetPVarFloat(npcid,"current_target_z", 31.611404);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2789.348144,-1333.648559,31.611404))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2789.253662,-1353.926635,26.708852,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.253662), SetPVarFloat(npcid,"current_target_y", -1353.926635), SetPVarFloat(npcid,"current_target_z", 26.708852);
				case 1: FCNPC_GoTo(npcid,2804.208984,-1332.465698,31.894905,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.208984), SetPVarFloat(npcid,"current_target_y", -1332.465698), SetPVarFloat(npcid,"current_target_z", 31.894905);
				case 2: FCNPC_GoTo(npcid,2789.176513,-1308.163208,37.611026,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.176513), SetPVarFloat(npcid,"current_target_y", -1308.163208), SetPVarFloat(npcid,"current_target_z", 37.611026);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2789.176513,-1308.163208,37.611026))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2789.252685,-1334.066040,31.514177,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.252685), SetPVarFloat(npcid,"current_target_y", -1334.066040), SetPVarFloat(npcid,"current_target_z", 31.514177);
				case 1: FCNPC_GoTo(npcid,2804.796875,-1309.879760,37.193016,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.796875), SetPVarFloat(npcid,"current_target_y", -1309.879760), SetPVarFloat(npcid,"current_target_z", 37.193016);
				case 2: FCNPC_GoTo(npcid,2789.261718,-1288.285156,42.362831,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.261718), SetPVarFloat(npcid,"current_target_y", -1288.285156), SetPVarFloat(npcid,"current_target_z", 42.362831);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2789.261718,-1288.285156,42.362831))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2788.883056,-1308.145996,37.615200,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2788.883056), SetPVarFloat(npcid,"current_target_y", -1308.145996), SetPVarFloat(npcid,"current_target_z", 37.615200);
				case 1: FCNPC_GoTo(npcid,2804.002197,-1287.272827,42.616195,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.002197), SetPVarFloat(npcid,"current_target_y", -1287.272827), SetPVarFloat(npcid,"current_target_z", 42.616195);
				case 2: FCNPC_GoTo(npcid,2789.245605,-1272.620849,45.886837,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.245605), SetPVarFloat(npcid,"current_target_y", -1272.620849), SetPVarFloat(npcid,"current_target_z", 45.886837);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2789.245605,-1272.620849,45.886837))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2789.369628,-1288.308837,42.357509,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.369628), SetPVarFloat(npcid,"current_target_y", -1288.308837), SetPVarFloat(npcid,"current_target_z", 42.357509);
				case 1: FCNPC_GoTo(npcid,2803.951660,-1271.755126,46.088703,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2803.951660), SetPVarFloat(npcid,"current_target_y", -1271.755126), SetPVarFloat(npcid,"current_target_z", 46.088703);
				case 2: FCNPC_GoTo(npcid,2788.324951,-1265.518066,46.945396,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2788.324951), SetPVarFloat(npcid,"current_target_y", -1265.518066), SetPVarFloat(npcid,"current_target_z", 46.945396);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2788.324951,-1265.518066,46.945396))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2789.142822,-1272.562255,45.899971,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2789.142822), SetPVarFloat(npcid,"current_target_y", -1272.562255), SetPVarFloat(npcid,"current_target_z", 45.899971);
				case 1: FCNPC_GoTo(npcid,2790.140380,-1250.826904,46.953342,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2790.140380), SetPVarFloat(npcid,"current_target_y", -1250.826904), SetPVarFloat(npcid,"current_target_z", 46.953342);
				case 2: FCNPC_GoTo(npcid,2778.731689,-1265.537841,48.500286,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2778.731689), SetPVarFloat(npcid,"current_target_y", -1265.537841), SetPVarFloat(npcid,"current_target_z", 48.500286);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2778.731689,-1265.537841,48.500286))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2788.590332,-1265.734619,46.945198,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2788.590332), SetPVarFloat(npcid,"current_target_y", -1265.734619), SetPVarFloat(npcid,"current_target_z", 46.945198);
				case 1: FCNPC_GoTo(npcid,2778.516845,-1250.221191,48.549098,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2778.516845), SetPVarFloat(npcid,"current_target_y", -1250.221191), SetPVarFloat(npcid,"current_target_z", 48.549098);
				case 2: FCNPC_GoTo(npcid,2763.175537,-1265.594970,54.948413,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2763.175537), SetPVarFloat(npcid,"current_target_y", -1265.594970), SetPVarFloat(npcid,"current_target_z", 54.948413);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2763.175537,-1265.594970,54.948413))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2778.624267,-1265.535644,48.520881,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2778.624267), SetPVarFloat(npcid,"current_target_y", -1265.535644), SetPVarFloat(npcid,"current_target_z", 48.520881);
				case 1: FCNPC_GoTo(npcid,2763.630615,-1250.133300,54.742652,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2763.630615), SetPVarFloat(npcid,"current_target_y", -1250.133300), SetPVarFloat(npcid,"current_target_z", 54.742652);
				case 2: FCNPC_GoTo(npcid,2755.595458,-1264.943237,58.156372,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2755.595458), SetPVarFloat(npcid,"current_target_y", -1264.943237), SetPVarFloat(npcid,"current_target_z", 58.156372);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2755.595458,-1264.943237,58.156372))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2763.358154,-1265.511352,54.864372,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2763.358154), SetPVarFloat(npcid,"current_target_y", -1265.511352), SetPVarFloat(npcid,"current_target_z", 54.864372);
				case 1: FCNPC_GoTo(npcid,2754.920166,-1250.304443,58.393146,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2754.920166), SetPVarFloat(npcid,"current_target_y", -1250.304443), SetPVarFloat(npcid,"current_target_z", 58.393146);
				case 2: FCNPC_GoTo(npcid,2745.793701,-1265.204223,59.748130,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2745.793701), SetPVarFloat(npcid,"current_target_y", -1265.204223), SetPVarFloat(npcid,"current_target_z", 59.748130);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2745.793701,-1265.204223,59.748130))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2755.682617,-1265.161865,58.129589,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2755.682617), SetPVarFloat(npcid,"current_target_y", -1265.161865), SetPVarFloat(npcid,"current_target_z", 58.129589);
				case 1: FCNPC_GoTo(npcid,2745.917480,-1250.415649,59.718849,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2745.917480), SetPVarFloat(npcid,"current_target_y", -1250.415649), SetPVarFloat(npcid,"current_target_z", 59.718849);
	        }
	    }
	}
	if(GetPVarInt(npcid,"westcoast")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2864.354492,-1496.832275,10.898537))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2878.430175,-1498.017700,11.010260,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2878.430175), SetPVarFloat(npcid,"current_target_y", -1498.017700), SetPVarFloat(npcid,"current_target_z", 11.010260);
				case 1: FCNPC_GoTo(npcid,2861.500244,-1512.316406,11.062095,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2861.500244), SetPVarFloat(npcid,"current_target_y", -1512.316406), SetPVarFloat(npcid,"current_target_z", 11.062095);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2878.564453,-1498.026489,11.010279))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2893.656250,-1499.790283,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2893.656250), SetPVarFloat(npcid,"current_target_y", -1499.790283), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 1: FCNPC_GoTo(npcid,2864.164550,-1496.847900,10.898537,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2864.164550), SetPVarFloat(npcid,"current_target_y", -1496.847900), SetPVarFloat(npcid,"current_target_z", 10.898537);
				case 2: FCNPC_GoTo(npcid,2875.607421,-1514.514038,11.052030,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2875.607421), SetPVarFloat(npcid,"current_target_y", -1514.514038), SetPVarFloat(npcid,"current_target_z", 11.052030);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2893.453857,-1499.791870,11.046975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2878.302734,-1498.005737,11.010233,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2878.302734), SetPVarFloat(npcid,"current_target_y", -1498.005737), SetPVarFloat(npcid,"current_target_z", 11.010233);
				case 1: FCNPC_GoTo(npcid,2891.046386,-1515.425659,11.060073,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2891.046386), SetPVarFloat(npcid,"current_target_y", -1515.425659), SetPVarFloat(npcid,"current_target_z", 11.060073);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2861.581787,-1512.397583,11.062214))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2864.475830,-1496.687133,10.898537,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2864.475830), SetPVarFloat(npcid,"current_target_y", -1496.687133), SetPVarFloat(npcid,"current_target_z", 10.898537);
				case 1: FCNPC_GoTo(npcid,2875.689453,-1514.542602,11.052053,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2875.689453), SetPVarFloat(npcid,"current_target_y", -1514.542602), SetPVarFloat(npcid,"current_target_z", 11.052053);
				case 2: FCNPC_GoTo(npcid,2859.276123,-1522.559692,11.080148,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2859.276123), SetPVarFloat(npcid,"current_target_y", -1522.559692), SetPVarFloat(npcid,"current_target_z", 11.080148);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2875.563720,-1514.508666,11.052040))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2861.480468,-1512.353881,11.062164,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2861.480468), SetPVarFloat(npcid,"current_target_y", -1512.353881), SetPVarFloat(npcid,"current_target_z", 11.062164);
				case 1: FCNPC_GoTo(npcid,2878.536865,-1497.982788,11.010183,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2878.536865), SetPVarFloat(npcid,"current_target_y", -1497.982788), SetPVarFloat(npcid,"current_target_z", 11.010183);
				case 2: FCNPC_GoTo(npcid,2872.478515,-1530.294555,11.088240,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2872.478515), SetPVarFloat(npcid,"current_target_y", -1530.294555), SetPVarFloat(npcid,"current_target_z", 11.088240);
				case 3: FCNPC_GoTo(npcid,2891.037353,-1515.463500,11.060130,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2891.037353), SetPVarFloat(npcid,"current_target_y", -1515.463500), SetPVarFloat(npcid,"current_target_z", 11.060130);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2891.037353,-1515.463500,11.060130))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2875.461181,-1514.558959,11.052200,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2875.461181), SetPVarFloat(npcid,"current_target_y", -1514.558959), SetPVarFloat(npcid,"current_target_z", 11.052200);
				case 1: FCNPC_GoTo(npcid,2893.515380,-1499.872436,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2893.515380), SetPVarFloat(npcid,"current_target_y", -1499.872436), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 2: FCNPC_GoTo(npcid,2888.600585,-1530.918457,11.071419,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2888.600585), SetPVarFloat(npcid,"current_target_y", -1530.918457), SetPVarFloat(npcid,"current_target_z", 11.071419);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2859.412109,-1522.513305,11.080036))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2861.468750,-1512.394653,11.062236,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2861.468750), SetPVarFloat(npcid,"current_target_y", -1512.394653), SetPVarFloat(npcid,"current_target_z", 11.062236);
				case 1: FCNPC_GoTo(npcid,2852.671386,-1543.843505,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2852.671386), SetPVarFloat(npcid,"current_target_y", -1543.843505), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 2: FCNPC_GoTo(npcid,2872.489746,-1530.222900,11.088078,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2872.489746), SetPVarFloat(npcid,"current_target_y", -1530.222900), SetPVarFloat(npcid,"current_target_z", 11.088078);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2872.489746,-1530.222900,11.088078))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2859.433837,-1522.511108,11.080027,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2859.433837), SetPVarFloat(npcid,"current_target_y", -1522.511108), SetPVarFloat(npcid,"current_target_z", 11.080027);
				case 1: FCNPC_GoTo(npcid,2875.702148,-1514.366455,11.051659,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2875.702148), SetPVarFloat(npcid,"current_target_y", -1514.366455), SetPVarFloat(npcid,"current_target_z", 11.051659);
				case 2: FCNPC_GoTo(npcid,2867.456787,-1544.684448,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2867.456787), SetPVarFloat(npcid,"current_target_y", -1544.684448), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 3: FCNPC_GoTo(npcid,2888.679199,-1530.909667,11.070696,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2888.679199), SetPVarFloat(npcid,"current_target_y", -1530.909667), SetPVarFloat(npcid,"current_target_z", 11.070696);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2888.679199,-1530.909667,11.070696))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2872.329589,-1530.250366,11.088216,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2872.329589), SetPVarFloat(npcid,"current_target_y", -1530.250366), SetPVarFloat(npcid,"current_target_z", 11.088216);
				case 1: FCNPC_GoTo(npcid,2891.116455,-1515.262084,11.059543,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2891.116455), SetPVarFloat(npcid,"current_target_y", -1515.262084), SetPVarFloat(npcid,"current_target_z", 11.059543);
				case 2: FCNPC_GoTo(npcid,2884.039550,-1545.963989,11.068149,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2884.039550), SetPVarFloat(npcid,"current_target_y", -1545.963989), SetPVarFloat(npcid,"current_target_z", 11.068149);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2852.875976,-1543.781372,11.093850))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2859.059570,-1522.326293,11.079802,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2859.059570), SetPVarFloat(npcid,"current_target_y", -1522.326293), SetPVarFloat(npcid,"current_target_z", 11.079802);
				case 1: FCNPC_GoTo(npcid,2845.112548,-1564.732666,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2845.112548), SetPVarFloat(npcid,"current_target_y", -1564.732666), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 2: FCNPC_GoTo(npcid,2867.527832,-1544.707153,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2867.527832), SetPVarFloat(npcid,"current_target_y", -1544.707153), SetPVarFloat(npcid,"current_target_z", 11.093850);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2867.527832,-1544.707153,11.093850))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2852.811279,-1543.747924,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2852.811279), SetPVarFloat(npcid,"current_target_y", -1543.747924), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 1: FCNPC_GoTo(npcid,2872.532958,-1530.200561,11.088007,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2872.532958), SetPVarFloat(npcid,"current_target_y", -1530.200561), SetPVarFloat(npcid,"current_target_z", 11.088007);
				case 2: FCNPC_GoTo(npcid,2860.075927,-1568.378540,11.086083,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2860.075927), SetPVarFloat(npcid,"current_target_y", -1568.378540), SetPVarFloat(npcid,"current_target_z", 11.086083);
				case 3: FCNPC_GoTo(npcid,2884.107666,-1545.933105,11.067608,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2884.107666), SetPVarFloat(npcid,"current_target_y", -1545.933105), SetPVarFloat(npcid,"current_target_z", 11.067608);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2884.107666,-1545.933105,11.067608))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2888.562988,-1530.828002,11.071835,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2888.562988), SetPVarFloat(npcid,"current_target_y", -1530.828002), SetPVarFloat(npcid,"current_target_z", 11.071835);
				case 1: FCNPC_GoTo(npcid,2867.577636,-1544.569702,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2867.577636), SetPVarFloat(npcid,"current_target_y", -1544.569702), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 2: FCNPC_GoTo(npcid,2875.953369,-1572.372680,11.084535,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2875.953369), SetPVarFloat(npcid,"current_target_y", -1572.372680), SetPVarFloat(npcid,"current_target_z", 11.084535);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2845.204101,-1564.398681,11.093850))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2852.906005,-1543.713623,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2852.906005), SetPVarFloat(npcid,"current_target_y", -1543.713623), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 1: FCNPC_GoTo(npcid,2840.755615,-1574.324462,11.086083,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2840.755615), SetPVarFloat(npcid,"current_target_y", -1574.324462), SetPVarFloat(npcid,"current_target_z", 11.086083);
				case 2: FCNPC_GoTo(npcid,2860.233398,-1568.411865,11.086083,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2860.233398), SetPVarFloat(npcid,"current_target_y", -1568.411865), SetPVarFloat(npcid,"current_target_z", 11.086083);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2860.233398,-1568.411865,11.086083))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2845.140869,-1564.224853,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2845.140869), SetPVarFloat(npcid,"current_target_y", -1564.224853), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 1: FCNPC_GoTo(npcid,2867.572021,-1544.771362,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2867.572021), SetPVarFloat(npcid,"current_target_y", -1544.771362), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 2: FCNPC_GoTo(npcid,2855.456787,-1579.146972,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2855.456787), SetPVarFloat(npcid,"current_target_y", -1579.146972), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 3: FCNPC_GoTo(npcid,2875.819580,-1572.288574,11.085949,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2875.819580), SetPVarFloat(npcid,"current_target_y", -1572.288574), SetPVarFloat(npcid,"current_target_z", 11.085949);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2875.819580,-1572.288574,11.085949))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2884.061279,-1545.755126,11.068463,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2884.061279), SetPVarFloat(npcid,"current_target_y", -1545.755126), SetPVarFloat(npcid,"current_target_z", 11.068463);
				case 1: FCNPC_GoTo(npcid,2860.060058,-1568.470581,11.086083,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2860.060058), SetPVarFloat(npcid,"current_target_y", -1568.470581), SetPVarFloat(npcid,"current_target_z", 11.086083);
				case 2: FCNPC_GoTo(npcid,2872.357177,-1583.534057,11.078237,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2872.357177), SetPVarFloat(npcid,"current_target_y", -1583.534057), SetPVarFloat(npcid,"current_target_z", 11.078237);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2840.781738,-1574.374389,11.086083))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2845.204101,-1564.435668,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2845.204101), SetPVarFloat(npcid,"current_target_y", -1564.435668), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 1: FCNPC_GoTo(npcid,2834.406982,-1586.121948,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2834.406982), SetPVarFloat(npcid,"current_target_y", -1586.121948), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 2: FCNPC_GoTo(npcid,2855.581054,-1579.278442,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2855.581054), SetPVarFloat(npcid,"current_target_y", -1579.278442), SetPVarFloat(npcid,"current_target_z", 11.093850);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2855.581054,-1579.278442,11.093850))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2840.757568,-1574.354614,11.086083,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2840.757568), SetPVarFloat(npcid,"current_target_y", -1574.354614), SetPVarFloat(npcid,"current_target_z", 11.086083);
				case 1: FCNPC_GoTo(npcid,2846.664306,-1592.303710,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2846.664306), SetPVarFloat(npcid,"current_target_y", -1592.303710), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 2: FCNPC_GoTo(npcid,2872.329101,-1583.543212,11.078457,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2872.329101), SetPVarFloat(npcid,"current_target_y", -1583.543212), SetPVarFloat(npcid,"current_target_z", 11.078457);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2872.329101,-1583.543212,11.078457))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2875.875488,-1572.273803,11.085480,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2875.875488), SetPVarFloat(npcid,"current_target_y", -1572.273803), SetPVarFloat(npcid,"current_target_z", 11.085480);
				case 1: FCNPC_GoTo(npcid,2855.705078,-1579.280395,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2855.705078), SetPVarFloat(npcid,"current_target_y", -1579.280395), SetPVarFloat(npcid,"current_target_z", 11.093850);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2846.733642,-1592.367431,11.093850))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2855.733398,-1579.196411,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2855.733398), SetPVarFloat(npcid,"current_target_y", -1579.196411), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 1: FCNPC_GoTo(npcid,2834.438232,-1586.221923,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2834.438232), SetPVarFloat(npcid,"current_target_y", -1586.221923), SetPVarFloat(npcid,"current_target_z", 11.093850);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2834.438232,-1586.221923,11.093850))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2846.782226,-1592.407470,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2846.782226), SetPVarFloat(npcid,"current_target_y", -1592.407470), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 1: FCNPC_GoTo(npcid,2840.856201,-1574.400878,11.086083,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2840.856201), SetPVarFloat(npcid,"current_target_y", -1574.400878), SetPVarFloat(npcid,"current_target_z", 11.086083);
				case 2: FCNPC_GoTo(npcid,2832.246337,-1585.159545,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2832.246337), SetPVarFloat(npcid,"current_target_y", -1585.159545), SetPVarFloat(npcid,"current_target_z", 11.093850);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2832.246337,-1585.159545,11.093850))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2834.558837,-1586.232910,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2834.558837), SetPVarFloat(npcid,"current_target_y", -1586.232910), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 1: FCNPC_GoTo(npcid,2829.303222,-1584.409301,12.904990,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2826.159423), SetPVarFloat(npcid,"current_target_y", -1583.252319), SetPVarFloat(npcid,"current_target_z", 14.945412);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2829.303222,-1584.409301,12.904990))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2832.255859,-1585.368164,11.093850,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2832.255859), SetPVarFloat(npcid,"current_target_y", -1585.368164), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 1: FCNPC_GoTo(npcid,2825.841552,-1583.016235,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2825.841552), SetPVarFloat(npcid,"current_target_y", -1583.016235), SetPVarFloat(npcid,"current_target_z", 14.945412);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2826.159423,-1583.252319,14.945412))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2829.303222,-1584.409301,12.904990,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2832.116210), SetPVarFloat(npcid,"current_target_y", -1585.217651), SetPVarFloat(npcid,"current_target_z", 11.093850);
				case 1: FCNPC_GoTo(npcid,2823.923583,-1581.195800,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2823.923583), SetPVarFloat(npcid,"current_target_y", -1581.195800), SetPVarFloat(npcid,"current_target_z", 14.945412);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2823.923583,-1581.195800,14.945412))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2826.166015,-1583.183593,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2826.166015), SetPVarFloat(npcid,"current_target_y", -1583.183593), SetPVarFloat(npcid,"current_target_z", 14.945412);
				case 1: FCNPC_GoTo(npcid,2824.743652,-1577.875244,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2824.743652), SetPVarFloat(npcid,"current_target_y", -1577.875244), SetPVarFloat(npcid,"current_target_z", 14.945412);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2824.743652,-1577.875244,14.945412))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2823.852294,-1581.276977,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2823.852294), SetPVarFloat(npcid,"current_target_y", -1581.276977), SetPVarFloat(npcid,"current_target_z", 14.945412);
				case 1: FCNPC_GoTo(npcid,2827.817138,-1576.435058,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2827.817138), SetPVarFloat(npcid,"current_target_y", -1576.435058), SetPVarFloat(npcid,"current_target_z", 14.945412);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2827.817138,-1576.435058,14.945412))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2824.781738,-1577.702148,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2824.781738), SetPVarFloat(npcid,"current_target_y", -1577.702148), SetPVarFloat(npcid,"current_target_z", 14.945412);
				case 1: FCNPC_GoTo(npcid,2833.446533,-1578.095458,16.298414,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2833.446533), SetPVarFloat(npcid,"current_target_y", -1578.095458), SetPVarFloat(npcid,"current_target_z", 16.298414);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2833.446533,-1578.095458,16.298414))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2828.006835,-1576.556152,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2828.006835), SetPVarFloat(npcid,"current_target_y", -1576.556152), SetPVarFloat(npcid,"current_target_z", 14.945412);
				case 1: FCNPC_GoTo(npcid,2840.361328,-1580.122802,18.235195,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2840.361328), SetPVarFloat(npcid,"current_target_y", -1580.122802), SetPVarFloat(npcid,"current_target_z", 18.235195);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2840.361328,-1580.122802,18.235195))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2833.468994,-1577.992553,16.296190,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2833.468994), SetPVarFloat(npcid,"current_target_y", -1577.992553), SetPVarFloat(npcid,"current_target_z", 16.296190);
				case 1: FCNPC_GoTo(npcid,2846.766113,-1582.125488,19.880573,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2846.766113), SetPVarFloat(npcid,"current_target_y", -1582.125488), SetPVarFloat(npcid,"current_target_z", 19.880573);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2846.766113,-1582.125488,19.880573))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2840.400146,-1580.093627,18.243162,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2840.400146), SetPVarFloat(npcid,"current_target_y", -1580.093627), SetPVarFloat(npcid,"current_target_z", 18.243162);
				case 1: FCNPC_GoTo(npcid,2853.093750,-1583.953857,21.118484,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2853.093750), SetPVarFloat(npcid,"current_target_y", -1583.953857), SetPVarFloat(npcid,"current_target_z", 21.118484);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2853.093750,-1583.953857,21.118484))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2846.591552,-1581.959716,19.837223,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2846.591552), SetPVarFloat(npcid,"current_target_y", -1581.959716), SetPVarFloat(npcid,"current_target_z", 19.837223);
				case 1: FCNPC_GoTo(npcid,2861.536376,-1586.384643,22.130668,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2861.536376), SetPVarFloat(npcid,"current_target_y", -1586.384643), SetPVarFloat(npcid,"current_target_z", 22.130668);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2861.536376,-1586.384643,22.130668))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2852.913330,-1583.801757,21.090761,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2852.913330), SetPVarFloat(npcid,"current_target_y", -1583.801757), SetPVarFloat(npcid,"current_target_z", 21.090761);
				case 1: FCNPC_GoTo(npcid,2869.665283,-1588.697631,22.490684,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2869.665283), SetPVarFloat(npcid,"current_target_y", -1588.697631), SetPVarFloat(npcid,"current_target_z", 22.490684);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2869.665283,-1588.697631,22.490684))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2861.339599,-1586.216430,22.117933,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2861.339599), SetPVarFloat(npcid,"current_target_y", -1586.216430), SetPVarFloat(npcid,"current_target_z", 22.117933);
				case 1: FCNPC_GoTo(npcid,2876.653564,-1590.666381,22.359676,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2876.653564), SetPVarFloat(npcid,"current_target_y", -1590.666381), SetPVarFloat(npcid,"current_target_z", 22.359676);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2876.653564,-1590.666381,22.359676))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2869.476562,-1588.713867,22.493694,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2869.476562), SetPVarFloat(npcid,"current_target_y", -1588.713867), SetPVarFloat(npcid,"current_target_z", 22.493694);
				case 1: FCNPC_GoTo(npcid,2885.290283,-1593.403686,21.485174,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2885.290283), SetPVarFloat(npcid,"current_target_y", -1593.403686), SetPVarFloat(npcid,"current_target_z", 21.485174);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2885.290283,-1593.403686,21.485174))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2876.458007,-1590.941528,22.360773,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2876.458007), SetPVarFloat(npcid,"current_target_y", -1590.941528), SetPVarFloat(npcid,"current_target_z", 22.360773);
				case 1: FCNPC_GoTo(npcid,2893.045898,-1596.314941,20.095775,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2893.045898), SetPVarFloat(npcid,"current_target_y", -1596.314941), SetPVarFloat(npcid,"current_target_z", 20.095775);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2893.045898,-1596.314941,20.095775))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2884.906005,-1593.566528,21.537443,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2884.906005), SetPVarFloat(npcid,"current_target_y", -1593.566528), SetPVarFloat(npcid,"current_target_z", 21.537443);
				case 1: FCNPC_GoTo(npcid,2901.096923,-1598.728637,18.029384,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2901.096923), SetPVarFloat(npcid,"current_target_y", -1598.728637), SetPVarFloat(npcid,"current_target_z", 18.029384);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2901.096923,-1598.728637,18.029384))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2892.843750,-1595.956909,20.167633,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2892.843750), SetPVarFloat(npcid,"current_target_y", -1595.956909), SetPVarFloat(npcid,"current_target_z", 20.167633);
				case 1: FCNPC_GoTo(npcid,2911.939208,-1601.901000,14.994349,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2911.939208), SetPVarFloat(npcid,"current_target_y", -1601.901000), SetPVarFloat(npcid,"current_target_z", 14.994349);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2911.939208,-1601.901000,14.994349))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2901.127929,-1598.867675,18.006959,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2901.127929), SetPVarFloat(npcid,"current_target_y", -1598.867675), SetPVarFloat(npcid,"current_target_z", 18.006959);
				case 1: FCNPC_GoTo(npcid,2915.571289,-1601.741455,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2915.571289), SetPVarFloat(npcid,"current_target_y", -1601.741455), SetPVarFloat(npcid,"current_target_z", 14.945412);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2915.571289,-1601.741455,14.945412))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2912.140625,-1602.102416,14.951962,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2912.140625), SetPVarFloat(npcid,"current_target_y", -1602.102416), SetPVarFloat(npcid,"current_target_z", 14.951962);
				case 1: FCNPC_GoTo(npcid,2917.122802,-1598.162719,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2917.122802), SetPVarFloat(npcid,"current_target_y", -1598.162719), SetPVarFloat(npcid,"current_target_z", 14.945412);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2917.122802,-1598.162719,14.945412))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2915.650390,-1601.882202,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2915.650390), SetPVarFloat(npcid,"current_target_y", -1601.882202), SetPVarFloat(npcid,"current_target_z", 14.945412);
				case 1: FCNPC_GoTo(npcid,2914.457031,-1595.215332,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2914.457031), SetPVarFloat(npcid,"current_target_y", -1595.215332), SetPVarFloat(npcid,"current_target_z", 14.945412);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2914.457031,-1595.215332,14.945412))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2917.032470,-1597.992675,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2917.032470), SetPVarFloat(npcid,"current_target_y", -1597.992675), SetPVarFloat(npcid,"current_target_z", 14.945412);
				case 1: FCNPC_GoTo(npcid,2908.111816,-1593.239868,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2908.111816), SetPVarFloat(npcid,"current_target_y", -1593.239868), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2908.111816,-1593.239868,11.046975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2914.437255,-1595.184082,14.945412,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2914.437255), SetPVarFloat(npcid,"current_target_y", -1595.184082), SetPVarFloat(npcid,"current_target_z", 14.945412);
				case 1: FCNPC_GoTo(npcid,2906.359863,-1592.246337,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2906.359863), SetPVarFloat(npcid,"current_target_y", -1592.246337), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2906.359863,-1592.246337,11.046975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2908.174804,-1593.291381,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2908.174804), SetPVarFloat(npcid,"current_target_y", -1593.291381), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 1: FCNPC_GoTo(npcid,2908.794433,-1585.348388,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2908.794433), SetPVarFloat(npcid,"current_target_y", -1585.348388), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2908.794433,-1585.348388,11.046975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2906.439208,-1592.406616,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2906.439208), SetPVarFloat(npcid,"current_target_y", -1592.406616), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 1: FCNPC_GoTo(npcid,2919.966308,-1588.366943,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2919.966308), SetPVarFloat(npcid,"current_target_y", -1588.366943), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 2: FCNPC_GoTo(npcid,2913.414062,-1568.821655,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2913.414062), SetPVarFloat(npcid,"current_target_y", -1568.821655), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2913.414062,-1568.821655,11.046975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2908.878662,-1585.493164,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2908.878662), SetPVarFloat(npcid,"current_target_y", -1585.493164), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 1: FCNPC_GoTo(npcid,2924.664306,-1571.527587,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2924.664306), SetPVarFloat(npcid,"current_target_y", -1571.527587), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 2: FCNPC_GoTo(npcid,2920.450195,-1543.749267,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2920.450195), SetPVarFloat(npcid,"current_target_y", -1543.749267), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2920.450195,-1543.749267,11.046975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2913.382080,-1568.821411,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2913.382080), SetPVarFloat(npcid,"current_target_y", -1568.821411), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 1: FCNPC_GoTo(npcid,2930.914550,-1545.552368,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2930.914550), SetPVarFloat(npcid,"current_target_y", -1545.552368), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 2: FCNPC_GoTo(npcid,2923.966064,-1528.262817,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2923.966064), SetPVarFloat(npcid,"current_target_y", -1528.262817), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2923.966064,-1528.262817,11.046975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2920.678710,-1544.215942,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2920.678710), SetPVarFloat(npcid,"current_target_y", -1544.215942), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 1: FCNPC_GoTo(npcid,2934.319824,-1530.712524,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2934.319824), SetPVarFloat(npcid,"current_target_y", -1530.712524), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 2: FCNPC_GoTo(npcid,2927.883300,-1504.020996,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2927.883300), SetPVarFloat(npcid,"current_target_y", -1504.020996), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2927.883300,-1504.020996,11.046975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2923.863037,-1528.442871,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2923.863037), SetPVarFloat(npcid,"current_target_y", -1528.442871), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 1: FCNPC_GoTo(npcid,2938.423095,-1505.447875,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2938.423095), SetPVarFloat(npcid,"current_target_y", -1505.447875), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2938.423095,-1505.447875,11.046975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2928.039306,-1504.175781,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2928.039306), SetPVarFloat(npcid,"current_target_y", -1504.175781), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 1: FCNPC_GoTo(npcid,2934.176269,-1530.849609,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2934.176269), SetPVarFloat(npcid,"current_target_y", -1530.849609), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2934.176269,-1530.849609,11.046975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2938.520263,-1505.373779,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2938.520263), SetPVarFloat(npcid,"current_target_y", -1505.373779), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 1: FCNPC_GoTo(npcid,2923.947998,-1528.373046,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2923.947998), SetPVarFloat(npcid,"current_target_y", -1528.373046), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 2: FCNPC_GoTo(npcid,2930.729736,-1545.554931,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2930.729736), SetPVarFloat(npcid,"current_target_y", -1545.554931), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2930.729736,-1545.554931,11.046975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2934.406494,-1530.528442,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2934.406494), SetPVarFloat(npcid,"current_target_y", -1530.528442), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 1: FCNPC_GoTo(npcid,2920.260986,-1543.825927,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2920.260986), SetPVarFloat(npcid,"current_target_y", -1543.825927), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 2: FCNPC_GoTo(npcid,2924.750000,-1571.642456,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2924.750000), SetPVarFloat(npcid,"current_target_y", -1571.642456), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2924.750000,-1571.642456,11.046975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2930.760742,-1545.326171,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2930.760742), SetPVarFloat(npcid,"current_target_y", -1545.326171), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 1: FCNPC_GoTo(npcid,2913.380615,-1568.673095,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2913.380615), SetPVarFloat(npcid,"current_target_y", -1568.673095), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 2: FCNPC_GoTo(npcid,2920.060791,-1588.495483,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2920.060791), SetPVarFloat(npcid,"current_target_y", -1588.495483), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2920.060791,-1588.495483,11.046975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2924.767822,-1571.425415,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2924.767822), SetPVarFloat(npcid,"current_target_y", -1571.425415), SetPVarFloat(npcid,"current_target_z", 11.046975);
				case 1: FCNPC_GoTo(npcid,2908.744628,-1585.297607,11.046975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2908.744628), SetPVarFloat(npcid,"current_target_y", -1585.297607), SetPVarFloat(npcid,"current_target_z", 11.046975);
	        }
	    }
	}
	if(GetPVarInt(npcid,"willowfield")==1)
 	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2706.328125,-2041.372314,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2722.004394,-2041.276367,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2722.004394), SetPVarFloat(npcid,"current_target_y", -2041.276367), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2706.504638,-2011.954589,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.504638), SetPVarFloat(npcid,"current_target_y", -2011.954589), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2722.013427,-2041.226074,13.554787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2706.293457,-2041.353637,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.293457), SetPVarFloat(npcid,"current_target_y", -2041.353637), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2722.141845,-2016.652709,13.547299,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2722.141845), SetPVarFloat(npcid,"current_target_y", -2016.652709), SetPVarFloat(npcid,"current_target_z", 13.547299);
				case 2: FCNPC_GoTo(npcid,2814.795898,-2041.499877,11.101662,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2814.795898), SetPVarFloat(npcid,"current_target_y", -2041.499877), SetPVarFloat(npcid,"current_target_z", 11.101662);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2814.795898,-2041.499877,11.101662))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2721.936767,-2041.283935,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.936767), SetPVarFloat(npcid,"current_target_y", -2041.283935), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2815.169433,-1986.242553,11.094084,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.169433), SetPVarFloat(npcid,"current_target_y", -1986.242553), SetPVarFloat(npcid,"current_target_z", 11.094084);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2815.169433,-1986.242553,11.094084))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2814.639160,-2041.558105,11.101662,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2814.639160), SetPVarFloat(npcid,"current_target_y", -2041.558105), SetPVarFloat(npcid,"current_target_z", 11.101662);
				case 1: FCNPC_GoTo(npcid,2806.126464,-1986.463989,13.552612,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2806.126464), SetPVarFloat(npcid,"current_target_y", -1986.463989), SetPVarFloat(npcid,"current_target_z", 13.552612);
				case 2: FCNPC_GoTo(npcid,2815.708984,-1969.964477,11.094084,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.708984), SetPVarFloat(npcid,"current_target_y", -1969.964477), SetPVarFloat(npcid,"current_target_z", 11.094084);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2815.708984,-1969.964477,11.094084))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2815.109130,-1986.321777,11.094084,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.109130), SetPVarFloat(npcid,"current_target_y", -1986.321777), SetPVarFloat(npcid,"current_target_z", 11.094084);
				case 1: FCNPC_GoTo(npcid,2806.149414,-1969.820556,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2806.149414), SetPVarFloat(npcid,"current_target_y", -1969.820556), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2815.498535,-1952.757080,11.094084,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.498535), SetPVarFloat(npcid,"current_target_y", -1952.757080), SetPVarFloat(npcid,"current_target_z", 11.094084);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2815.498535,-1952.757080,11.094084))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2815.714843,-1969.809082,11.094084,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.714843), SetPVarFloat(npcid,"current_target_y", -1969.809082), SetPVarFloat(npcid,"current_target_z", 11.094084);
				case 1: FCNPC_GoTo(npcid,2806.394531,-1952.883178,13.537840,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2806.394531), SetPVarFloat(npcid,"current_target_y", -1952.883178), SetPVarFloat(npcid,"current_target_z", 13.537840);
				case 2: FCNPC_GoTo(npcid,2815.291992,-1937.185668,11.109475,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.291992), SetPVarFloat(npcid,"current_target_y", -1937.185668), SetPVarFloat(npcid,"current_target_z", 11.109475);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2815.291992,-1937.185668,11.109475))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2815.537597,-1952.985961,11.094084,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.537597), SetPVarFloat(npcid,"current_target_y", -1952.985961), SetPVarFloat(npcid,"current_target_z", 11.094084);
				case 1: FCNPC_GoTo(npcid,2804.637207,-1937.340454,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.637207), SetPVarFloat(npcid,"current_target_y", -1937.340454), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2815.219482,-1920.195068,11.109475,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.219482), SetPVarFloat(npcid,"current_target_y", -1920.195068), SetPVarFloat(npcid,"current_target_z", 11.109475);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2815.219482,-1920.195068,11.109475))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2815.214599,-1937.125976,11.109475,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.214599), SetPVarFloat(npcid,"current_target_y", -1937.125976), SetPVarFloat(npcid,"current_target_z", 11.109475);
				case 1: FCNPC_GoTo(npcid,2804.436523,-1920.680419,13.539463,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.436523), SetPVarFloat(npcid,"current_target_y", -1920.680419), SetPVarFloat(npcid,"current_target_z", 13.539463);
				case 2: FCNPC_GoTo(npcid,2815.381347,-1905.392333,11.109475,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.381347), SetPVarFloat(npcid,"current_target_y", -1905.392333), SetPVarFloat(npcid,"current_target_z", 11.109475);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2815.381347,-1905.392333,11.109475))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2815.130615,-1920.365722,11.109475,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.130615), SetPVarFloat(npcid,"current_target_y", -1920.365722), SetPVarFloat(npcid,"current_target_z", 11.109475);
				case 1: FCNPC_GoTo(npcid,2806.225585,-1905.420410,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2806.225585), SetPVarFloat(npcid,"current_target_y", -1905.420410), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2815.268066,-1898.605468,11.101662,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.268066), SetPVarFloat(npcid,"current_target_y", -1898.605468), SetPVarFloat(npcid,"current_target_z", 11.101662);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2815.268066,-1898.605468,11.101662))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2815.368652,-1905.233032,11.109475,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.368652), SetPVarFloat(npcid,"current_target_y", -1905.233032), SetPVarFloat(npcid,"current_target_z", 11.109475);
				case 1: FCNPC_GoTo(npcid,2777.088623,-1898.405761,11.054787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.088623), SetPVarFloat(npcid,"current_target_y", -1898.405761), SetPVarFloat(npcid,"current_target_z", 11.054787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2777.088623,-1898.405761,11.054787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2815.251464,-1898.620849,11.101662,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.251464), SetPVarFloat(npcid,"current_target_y", -1898.620849), SetPVarFloat(npcid,"current_target_z", 11.101662);
				case 1: FCNPC_GoTo(npcid,2761.489990,-1897.873901,11.054787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.489990), SetPVarFloat(npcid,"current_target_y", -1897.873901), SetPVarFloat(npcid,"current_target_z", 11.054787);
				case 2: FCNPC_GoTo(npcid,2777.111083,-1924.494506,13.539484,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.111083), SetPVarFloat(npcid,"current_target_y", -1924.494506), SetPVarFloat(npcid,"current_target_z", 13.539484);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2761.411132,-1897.875854,11.054787))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2777.494140,-1898.398437,11.054787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.494140), SetPVarFloat(npcid,"current_target_y", -1898.398437), SetPVarFloat(npcid,"current_target_z", 11.054787);
				case 1: FCNPC_GoTo(npcid,2761.859619,-1924.547607,13.539484,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.859619), SetPVarFloat(npcid,"current_target_y", -1924.547607), SetPVarFloat(npcid,"current_target_z", 13.539484);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2761.859619,-1924.547607,13.539484))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2761.428222,-1897.754272,11.054787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.428222), SetPVarFloat(npcid,"current_target_y", -1897.754272), SetPVarFloat(npcid,"current_target_z", 11.054787);
				case 1: FCNPC_GoTo(npcid,2777.222412,-1924.665893,13.539484,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.222412), SetPVarFloat(npcid,"current_target_y", -1924.665893), SetPVarFloat(npcid,"current_target_z", 13.539484);
				case 2: FCNPC_GoTo(npcid,2761.680908,-1943.861572,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.680908), SetPVarFloat(npcid,"current_target_y", -1943.861572), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2761.680908,-1943.861572,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2761.963867,-1924.394165,13.539484,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.963867), SetPVarFloat(npcid,"current_target_y", -1924.394165), SetPVarFloat(npcid,"current_target_z", 13.539484);
				case 1: FCNPC_GoTo(npcid,2777.461914,-1944.608032,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.461914), SetPVarFloat(npcid,"current_target_y", -1944.608032), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2756.356689,-1943.960083,13.548004,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2756.356689), SetPVarFloat(npcid,"current_target_y", -1943.960083), SetPVarFloat(npcid,"current_target_z", 13.548004);
				case 3: FCNPC_GoTo(npcid,2761.985107,-1970.761840,13.545654,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.985107), SetPVarFloat(npcid,"current_target_y", -1970.761840), SetPVarFloat(npcid,"current_target_z", 13.545654);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2761.985107,-1970.761840,13.545654))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2761.771240,-1943.755126,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.771240), SetPVarFloat(npcid,"current_target_y", -1943.755126), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2777.140869,-1970.489624,13.541659,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.140869), SetPVarFloat(npcid,"current_target_y", -1970.489624), SetPVarFloat(npcid,"current_target_z", 13.541659);
				case 2: FCNPC_GoTo(npcid,2761.956054,-1979.087646,13.547687,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.956054), SetPVarFloat(npcid,"current_target_y", -1979.087646), SetPVarFloat(npcid,"current_target_z", 13.547687);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2761.956054,-1979.087646,13.547687))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2762.055175,-1970.660644,13.545629,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2762.055175), SetPVarFloat(npcid,"current_target_y", -1970.660644), SetPVarFloat(npcid,"current_target_z", 13.545629);
				case 1: FCNPC_GoTo(npcid,2756.814941,-1979.321411,13.547799,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2756.814941), SetPVarFloat(npcid,"current_target_y", -1979.321411), SetPVarFloat(npcid,"current_target_z", 13.547799);
				case 2: FCNPC_GoTo(npcid,2761.628417,-1986.744262,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.628417), SetPVarFloat(npcid,"current_target_y", -1986.744262), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2777.221435,-1924.449340,13.539484))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2777.265625,-1898.209594,11.054787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.265625), SetPVarFloat(npcid,"current_target_y", -1898.209594), SetPVarFloat(npcid,"current_target_z", 11.054787);
				case 1: FCNPC_GoTo(npcid,2782.764160,-1924.434936,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2782.764160), SetPVarFloat(npcid,"current_target_y", -1924.434936), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2761.704833,-1924.641357,13.539484,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.704833), SetPVarFloat(npcid,"current_target_y", -1924.641357), SetPVarFloat(npcid,"current_target_z", 13.539484);
				case 3: FCNPC_GoTo(npcid,2777.294433,-1944.693359,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.294433), SetPVarFloat(npcid,"current_target_y", -1944.693359), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2777.294433,-1944.693359,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2777.162597,-1924.454345,13.539484,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.162597), SetPVarFloat(npcid,"current_target_y", -1924.454345), SetPVarFloat(npcid,"current_target_z", 13.539484);
				case 1: FCNPC_GoTo(npcid,2781.899414,-1944.408081,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2781.899414), SetPVarFloat(npcid,"current_target_y", -1944.408081), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2761.848144,-1943.738525,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.848144), SetPVarFloat(npcid,"current_target_y", -1943.738525), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2777.117187,-1970.638671,13.541712,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.117187), SetPVarFloat(npcid,"current_target_y", -1970.638671), SetPVarFloat(npcid,"current_target_z", 13.541712);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2777.117187,-1970.638671,13.541712))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2777.375976,-1944.689575,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.375976), SetPVarFloat(npcid,"current_target_y", -1944.689575), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2782.104736,-1970.381225,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2782.104736), SetPVarFloat(npcid,"current_target_y", -1970.381225), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2762.131591,-1970.968627,13.545704,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2762.131591), SetPVarFloat(npcid,"current_target_y", -1970.968627), SetPVarFloat(npcid,"current_target_z", 13.545704);
				case 3: FCNPC_GoTo(npcid,2777.025146,-1986.380249,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.025146), SetPVarFloat(npcid,"current_target_y", -1986.380249), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2777.025146,-1986.380249,13.554787))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2777.191894,-1970.521728,13.541629,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.191894), SetPVarFloat(npcid,"current_target_y", -1970.521728), SetPVarFloat(npcid,"current_target_z", 13.541629);
				case 1: FCNPC_GoTo(npcid,2761.706787,-1986.725463,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.706787), SetPVarFloat(npcid,"current_target_y", -1986.725463), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2785.152587,-1986.432617,13.553894,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2785.152587), SetPVarFloat(npcid,"current_target_y", -1986.432617), SetPVarFloat(npcid,"current_target_z", 13.553894);
				case 3: FCNPC_GoTo(npcid,2776.960937,-2001.858764,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2776.960937), SetPVarFloat(npcid,"current_target_y", -2001.858764), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2776.960937,-2001.858764,13.554787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2776.970947,-1986.135253,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2776.970947), SetPVarFloat(npcid,"current_target_y", -1986.135253), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2764.701660,-2000.970947,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2764.701660), SetPVarFloat(npcid,"current_target_y", -2000.970947), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2776.857910,-2008.097290,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2776.857910), SetPVarFloat(npcid,"current_target_y", -2008.097290), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2776.857910,-2008.097290,13.554787))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2776.996093,-2002.002685,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2776.996093), SetPVarFloat(npcid,"current_target_y", -2002.002685), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2785.296386,-2008.165771,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2785.296386), SetPVarFloat(npcid,"current_target_y", -2008.165771), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2785.296386,-2008.165771,13.554787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2785.270996,-1986.223388,13.553836,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2785.270996), SetPVarFloat(npcid,"current_target_y", -1986.223388), SetPVarFloat(npcid,"current_target_z", 13.553836);
				case 1: FCNPC_GoTo(npcid,2776.934814,-2008.100952,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2776.934814), SetPVarFloat(npcid,"current_target_y", -2008.100952), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2793.151855,-2008.151611,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2793.151855), SetPVarFloat(npcid,"current_target_y", -2008.151611), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2793.151855,-2008.151611,13.554787))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2785.301269,-2008.098266,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2785.301269), SetPVarFloat(npcid,"current_target_y", -2008.098266), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2799.443115,-2006.886718,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2799.443115), SetPVarFloat(npcid,"current_target_y", -2006.886718), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2799.443115,-2006.886718,13.554787))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2793.090820,-2008.096801,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2793.090820), SetPVarFloat(npcid,"current_target_y", -2008.096801), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2799.604248,-2032.633056,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2799.604248), SetPVarFloat(npcid,"current_target_y", -2032.633056), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2799.604248,-2032.633056,13.554787))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2799.508056,-2006.818237,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2799.508056), SetPVarFloat(npcid,"current_target_y", -2006.818237), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2764.932128,-2032.496215,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2764.932128), SetPVarFloat(npcid,"current_target_y", -2032.496215), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2764.932128,-2032.496215,13.554787))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2799.599609,-2032.507568,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2799.599609), SetPVarFloat(npcid,"current_target_y", -2032.507568), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2765.073730,-2017.162353,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2765.073730), SetPVarFloat(npcid,"current_target_y", -2017.162353), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2765.073730,-2017.162353,13.554787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2765.038330,-2032.655761,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2765.038330), SetPVarFloat(npcid,"current_target_y", -2032.655761), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2764.957519,-2000.934936,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2764.957519), SetPVarFloat(npcid,"current_target_y", -2000.934936), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2722.058593,-2016.783691,13.547299,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2722.058593), SetPVarFloat(npcid,"current_target_y", -2016.783691), SetPVarFloat(npcid,"current_target_z", 13.547299);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2764.702148,-2000.988769,13.554787))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2777.154296,-2001.885986,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.154296), SetPVarFloat(npcid,"current_target_y", -2001.885986), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2761.592773,-1986.588867,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.592773), SetPVarFloat(npcid,"current_target_y", -1986.588867), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2765.076904,-2017.034423,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2765.076904), SetPVarFloat(npcid,"current_target_y", -2017.034423), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 3: FCNPC_GoTo(npcid,2721.793212,-2002.106201,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.793212), SetPVarFloat(npcid,"current_target_y", -2002.106201), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2785.229248,-1986.416870,13.553856))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2776.808349,-1986.235595,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2776.808349), SetPVarFloat(npcid,"current_target_y", -1986.235595), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2785.308837,-2008.091308,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2785.308837), SetPVarFloat(npcid,"current_target_y", -2008.091308), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2806.395996,-1986.345825,13.508721,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2806.395996), SetPVarFloat(npcid,"current_target_y", -1986.345825), SetPVarFloat(npcid,"current_target_z", 13.508721);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2806.395996,-1986.345825,13.508721))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2785.358398,-1986.355346,13.553793,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2785.358398), SetPVarFloat(npcid,"current_target_y", -1986.355346), SetPVarFloat(npcid,"current_target_z", 13.553793);
				case 1: FCNPC_GoTo(npcid,2815.028076,-1986.362060,11.094084,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.028076), SetPVarFloat(npcid,"current_target_y", -1986.362060), SetPVarFloat(npcid,"current_target_z", 11.094084);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2806.235595,-1969.772216,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2815.732666,-1969.886840,11.094084,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.732666), SetPVarFloat(npcid,"current_target_y", -1969.886840), SetPVarFloat(npcid,"current_target_z", 11.094084);
				case 1: FCNPC_GoTo(npcid,2803.002441,-1970.161499,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2803.002441), SetPVarFloat(npcid,"current_target_y", -1970.161499), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2803.002441,-1970.161499,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2806.296875,-1969.826416,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2806.296875), SetPVarFloat(npcid,"current_target_y", -1969.826416), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2802.874511,-1953.113647,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2802.874511), SetPVarFloat(npcid,"current_target_y", -1953.113647), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2802.874511,-1953.113647,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2803.066650,-1970.117553,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2803.066650), SetPVarFloat(npcid,"current_target_y", -1970.117553), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2804.645507,-1950.594116,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.645507), SetPVarFloat(npcid,"current_target_y", -1950.594116), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2806.377441,-1952.847412,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2806.377441), SetPVarFloat(npcid,"current_target_y", -1952.847412), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2806.377441,-1952.847412,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2815.532470,-1952.853515,11.094084,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.532470), SetPVarFloat(npcid,"current_target_y", -1952.853515), SetPVarFloat(npcid,"current_target_z", 11.094084);
				case 1: FCNPC_GoTo(npcid,2802.876464,-1952.969116,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2802.876464), SetPVarFloat(npcid,"current_target_y", -1952.969116), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2804.638671,-1950.593017,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.638671), SetPVarFloat(npcid,"current_target_y", -1950.593017), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2804.638671,-1950.593017,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2802.802246,-1953.119628,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2802.802246), SetPVarFloat(npcid,"current_target_y", -1953.119628), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2806.386718,-1952.801879,13.540744,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2806.386718), SetPVarFloat(npcid,"current_target_y", -1952.801879), SetPVarFloat(npcid,"current_target_z", 13.540744);
				case 2: FCNPC_GoTo(npcid,2804.591552,-1945.233032,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.591552), SetPVarFloat(npcid,"current_target_y", -1945.233032), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2804.591552,-1945.233032,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2804.686767,-1950.622436,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.686767), SetPVarFloat(npcid,"current_target_y", -1950.622436), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2781.789550,-1944.375000,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2781.789550), SetPVarFloat(npcid,"current_target_y", -1944.375000), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2804.522705,-1937.396850,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.522705), SetPVarFloat(npcid,"current_target_y", -1937.396850), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2804.522705,-1937.396850,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2804.603515,-1945.117675,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.603515), SetPVarFloat(npcid,"current_target_y", -1945.117675), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2815.132568,-1937.268554,11.109475,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.132568), SetPVarFloat(npcid,"current_target_y", -1937.268554), SetPVarFloat(npcid,"current_target_z", 11.109475);
				case 2: FCNPC_GoTo(npcid,2804.245605,-1920.618774,13.539463,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.245605), SetPVarFloat(npcid,"current_target_y", -1920.618774), SetPVarFloat(npcid,"current_target_z", 13.539463);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2804.245605,-1920.618774,13.539463))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2804.458984,-1937.522705,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.458984), SetPVarFloat(npcid,"current_target_y", -1937.522705), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2815.254394,-1920.231201,11.109475,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.254394), SetPVarFloat(npcid,"current_target_y", -1920.231201), SetPVarFloat(npcid,"current_target_z", 11.109475);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2806.153808,-1905.292602,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2815.332031,-1905.241577,11.109475,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2815.332031), SetPVarFloat(npcid,"current_target_y", -1905.241577), SetPVarFloat(npcid,"current_target_z", 11.109475);
				case 1: FCNPC_GoTo(npcid,2781.206787,-1905.737182,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2781.206787), SetPVarFloat(npcid,"current_target_y", -1905.737182), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2781.135253,-1905.836669,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2806.166259,-1905.418090,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2806.166259), SetPVarFloat(npcid,"current_target_y", -1905.418090), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2782.438476,-1924.494750,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2782.438476), SetPVarFloat(npcid,"current_target_y", -1924.494750), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2782.438476,-1924.494750,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2781.142578,-1906.073120,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2781.142578), SetPVarFloat(npcid,"current_target_y", -1906.073120), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2777.164550,-1924.505859,13.539484,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.164550), SetPVarFloat(npcid,"current_target_y", -1924.505859), SetPVarFloat(npcid,"current_target_z", 13.539484);
				case 2: FCNPC_GoTo(npcid,2781.981689,-1944.226440,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2781.981689), SetPVarFloat(npcid,"current_target_y", -1944.226440), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2781.999755,-1944.392333,13.546975))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2804.716064,-1945.292358,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2804.716064), SetPVarFloat(npcid,"current_target_y", -1945.292358), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2782.483398,-1924.218750,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2782.483398), SetPVarFloat(npcid,"current_target_y", -1924.218750), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2781.931640,-1970.449584,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2781.931640), SetPVarFloat(npcid,"current_target_y", -1970.449584), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 3: FCNPC_GoTo(npcid,2777.366455,-1944.549682,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2777.366455), SetPVarFloat(npcid,"current_target_y", -1944.549682), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2781.965332,-1970.239257,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2782.060058,-1944.505615,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2782.060058), SetPVarFloat(npcid,"current_target_y", -1944.505615), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2776.934570,-1970.526733,13.541819,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2776.934570), SetPVarFloat(npcid,"current_target_y", -1970.526733), SetPVarFloat(npcid,"current_target_z", 13.541819);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2756.772216,-1979.276733,13.547756))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2762.051757,-1979.190429,13.547712,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2762.051757), SetPVarFloat(npcid,"current_target_y", -1979.190429), SetPVarFloat(npcid,"current_target_z", 13.547712);
				case 1: FCNPC_GoTo(npcid,2756.625244,-1943.805664,13.548331,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2756.625244), SetPVarFloat(npcid,"current_target_y", -1943.805664), SetPVarFloat(npcid,"current_target_z", 13.548331);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2756.625244,-1943.805664,13.548331))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2756.832275,-1979.489013,13.547925,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2756.832275), SetPVarFloat(npcid,"current_target_y", -1979.489013), SetPVarFloat(npcid,"current_target_z", 13.547925);
				case 1: FCNPC_GoTo(npcid,2761.998535,-1943.830322,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.998535), SetPVarFloat(npcid,"current_target_y", -1943.830322), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2721.560302,-1943.453491,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.560302), SetPVarFloat(npcid,"current_target_y", -1943.453491), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2721.499023,-1943.428833,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2756.621093,-1944.083740,13.548326,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2756.621093), SetPVarFloat(npcid,"current_target_y", -1944.083740), SetPVarFloat(npcid,"current_target_z", 13.548326);
				case 1: FCNPC_GoTo(npcid,2706.472412,-1944.236206,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.472412), SetPVarFloat(npcid,"current_target_y", -1944.236206), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2721.174560,-1986.256713,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.174560), SetPVarFloat(npcid,"current_target_y", -1986.256713), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2706.270263,-1944.237060,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2721.797851,-1943.457153,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.797851), SetPVarFloat(npcid,"current_target_y", -1943.457153), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2706.441650,-1970.149780,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.441650), SetPVarFloat(npcid,"current_target_y", -1970.149780), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2699.243408,-1970.006591,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2706.508544,-1970.276977,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.508544), SetPVarFloat(npcid,"current_target_y", -1970.276977), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2634.656738,-1970.817993,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2634.656738), SetPVarFloat(npcid,"current_target_y", -1970.817993), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2698.677734,-1943.763061,13.554144,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2698.677734), SetPVarFloat(npcid,"current_target_y", -1943.763061), SetPVarFloat(npcid,"current_target_z", 13.554144);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2698.677734,-1943.763061,13.554144))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2699.280273,-1970.170043,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2699.280273), SetPVarFloat(npcid,"current_target_y", -1970.170043), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2634.329589,-1943.745605,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2634.329589), SetPVarFloat(npcid,"current_target_y", -1943.745605), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2634.537597,-1944.006958,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2698.856689,-1943.602172,13.554144,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2698.856689), SetPVarFloat(npcid,"current_target_y", -1943.602172), SetPVarFloat(npcid,"current_target_z", 13.554144);
				case 1: FCNPC_GoTo(npcid,2634.671875,-1970.665283,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2634.671875), SetPVarFloat(npcid,"current_target_y", -1970.665283), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2634.671875,-1970.665283,13.546975))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2634.296386,-1943.868286,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2634.296386), SetPVarFloat(npcid,"current_target_y", -1943.868286), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2699.270751,-1970.095825,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2699.270751), SetPVarFloat(npcid,"current_target_y", -1970.095825), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2721.054443,-1986.244506,13.554787))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2721.491455,-1943.338867,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.491455), SetPVarFloat(npcid,"current_target_y", -1943.338867), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2706.313964,-1986.426879,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.313964), SetPVarFloat(npcid,"current_target_y", -1986.426879), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2706.313964,-1986.426879,13.554787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2721.093994,-1986.255859,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.093994), SetPVarFloat(npcid,"current_target_y", -1986.255859), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2706.541259,-1970.440795,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.541259), SetPVarFloat(npcid,"current_target_y", -1970.440795), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2706.368652,-1997.010253,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.368652), SetPVarFloat(npcid,"current_target_y", -1997.010253), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2721.732910,-2002.406005,13.554787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2721.089355,-1986.159423,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.089355), SetPVarFloat(npcid,"current_target_y", -1986.159423), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2721.145263,-2011.476684,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.145263), SetPVarFloat(npcid,"current_target_y", -2011.476684), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2706.250000,-1997.121948,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.250000), SetPVarFloat(npcid,"current_target_y", -1997.121948), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2706.250000,-1997.121948,13.554787))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2721.873291,-2002.345092,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.873291), SetPVarFloat(npcid,"current_target_y", -2002.345092), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2706.433105,-1986.264404,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.433105), SetPVarFloat(npcid,"current_target_y", -1986.264404), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2688.611816,-1996.482910,13.547299,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2688.611816), SetPVarFloat(npcid,"current_target_y", -1996.482910), SetPVarFloat(npcid,"current_target_z", 13.547299);
				case 3: FCNPC_GoTo(npcid,2706.461181,-2012.034545,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.461181), SetPVarFloat(npcid,"current_target_y", -2012.034545), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2688.446777,-1996.543090,13.547299))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2706.505126,-1997.195678,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.505126), SetPVarFloat(npcid,"current_target_y", -1997.195678), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2676.987792,-1996.486206,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2676.987792), SetPVarFloat(npcid,"current_target_y", -1996.486206), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2689.219970,-2012.374755,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2689.219970), SetPVarFloat(npcid,"current_target_y", -2012.374755), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2677.151611,-1996.464233,13.554787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2688.495849,-1996.484008,13.547299,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2688.495849), SetPVarFloat(npcid,"current_target_y", -1996.484008), SetPVarFloat(npcid,"current_target_z", 13.547299);
				case 1: FCNPC_GoTo(npcid,2677.283691,-2011.611938,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2677.283691), SetPVarFloat(npcid,"current_target_y", -2011.611938), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2655.680175,-1996.335449,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2655.680175), SetPVarFloat(npcid,"current_target_y", -1996.335449), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2655.680175,-1996.335449,13.554787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2677.239013,-1996.583618,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2677.239013), SetPVarFloat(npcid,"current_target_y", -1996.583618), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2656.088867,-2011.314697,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2656.088867), SetPVarFloat(npcid,"current_target_y", -2011.314697), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2640.571289,-1996.280883,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2640.571289), SetPVarFloat(npcid,"current_target_y", -1996.280883), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2640.571289,-1996.280883,13.554787))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2656.220214,-1996.381347,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2656.220214), SetPVarFloat(npcid,"current_target_y", -1996.381347), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2640.588134,-2010.865356,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2640.588134), SetPVarFloat(npcid,"current_target_y", -2010.865356), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2640.588134,-2010.865356,13.554787))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,2640.739746,-1996.215942,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2640.739746), SetPVarFloat(npcid,"current_target_y", -1996.215942), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2656.248046,-2011.426391,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2656.248046), SetPVarFloat(npcid,"current_target_y", -2011.426391), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2656.248046,-2011.426391,13.554787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2640.691650,-2010.979248,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2640.691650), SetPVarFloat(npcid,"current_target_y", -2010.979248), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2655.915527,-1996.472656,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2655.915527), SetPVarFloat(npcid,"current_target_y", -1996.472656), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2677.612548,-2011.583129,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2677.612548), SetPVarFloat(npcid,"current_target_y", -2011.583129), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2677.612548,-2011.583129,13.554787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2655.971191,-2011.376708,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2655.971191), SetPVarFloat(npcid,"current_target_y", -2011.376708), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2677.125732,-1996.359863,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2677.125732), SetPVarFloat(npcid,"current_target_y", -1996.359863), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2689.199462,-2012.215942,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2689.199462), SetPVarFloat(npcid,"current_target_y", -2012.215942), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2689.199462,-2012.215942,13.554787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2677.365478,-2011.508544,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2677.365478), SetPVarFloat(npcid,"current_target_y", -2011.508544), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2688.505859,-1996.497802,13.547299,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2688.505859), SetPVarFloat(npcid,"current_target_y", -1996.497802), SetPVarFloat(npcid,"current_target_z", 13.547299);
				case 2: FCNPC_GoTo(npcid,2706.410400,-2012.185913,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.410400), SetPVarFloat(npcid,"current_target_y", -2012.185913), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2706.410400,-2012.185913,13.554787))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2688.966308,-2012.078002,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2688.966308), SetPVarFloat(npcid,"current_target_y", -2012.078002), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2706.498779,-1996.951904,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.498779), SetPVarFloat(npcid,"current_target_y", -1996.951904), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2720.945800,-2011.548583,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2720.945800), SetPVarFloat(npcid,"current_target_y", -2011.548583), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 3: FCNPC_GoTo(npcid,2706.305419,-2041.471313,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.305419), SetPVarFloat(npcid,"current_target_y", -2041.471313), SetPVarFloat(npcid,"current_target_z", 13.546975);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2721.223144,-2011.463623,13.554787))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2721.694824,-2002.126586,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.694824), SetPVarFloat(npcid,"current_target_y", -2002.126586), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2722.149414,-2016.817504,13.547299,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2722.149414), SetPVarFloat(npcid,"current_target_y", -2016.817504), SetPVarFloat(npcid,"current_target_z", 13.547299);
				case 2: FCNPC_GoTo(npcid,2706.168212,-2012.088867,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.168212), SetPVarFloat(npcid,"current_target_y", -2012.088867), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2706.444580,-1970.213256,13.546975))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2699.170654,-1970.082153,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2699.170654), SetPVarFloat(npcid,"current_target_y", -1970.082153), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 1: FCNPC_GoTo(npcid,2706.480224,-1944.146728,13.546975,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.480224), SetPVarFloat(npcid,"current_target_y", -1944.146728), SetPVarFloat(npcid,"current_target_z", 13.546975);
				case 2: FCNPC_GoTo(npcid,2706.281494,-1986.189575,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2706.281494), SetPVarFloat(npcid,"current_target_y", -1986.189575), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2761.727294,-1986.631713,13.554787))
	    {
	        switch(random(4))
	        {
				case 0: FCNPC_GoTo(npcid,2761.988769,-1979.062133,13.547680,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2761.988769), SetPVarFloat(npcid,"current_target_y", -1979.062133), SetPVarFloat(npcid,"current_target_z", 13.547680);
				case 1: FCNPC_GoTo(npcid,2776.834228,-1986.124023,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2776.834228), SetPVarFloat(npcid,"current_target_y", -1986.124023), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2764.772460,-2000.900512,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2764.772460), SetPVarFloat(npcid,"current_target_y", -2000.900512), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 3: FCNPC_GoTo(npcid,2720.788085,-1986.312988,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2720.788085), SetPVarFloat(npcid,"current_target_y", -1986.312988), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,2722.159912,-2016.735717,13.547299))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,2765.227539,-2017.167846,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2765.227539), SetPVarFloat(npcid,"current_target_y", -2017.167846), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 1: FCNPC_GoTo(npcid,2721.314941,-2011.687866,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.314941), SetPVarFloat(npcid,"current_target_y", -2011.687866), SetPVarFloat(npcid,"current_target_z", 13.554787);
				case 2: FCNPC_GoTo(npcid,2721.855712,-2041.271118,13.554787,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 2721.855712), SetPVarFloat(npcid,"current_target_y", -2041.271118), SetPVarFloat(npcid,"current_target_z", 13.554787);
	        }
	    }
	}
	if(GetPVarInt(npcid,"centre")==1)
	{
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1029.788330,-947.908203,42.610874))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1032.579101,-973.273864,42.617652,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1032.579101), SetPVarFloat(npcid,"current_target_y", -973.273864), SetPVarFloat(npcid,"current_target_z", 42.617652);
				case 1: FCNPC_GoTo(npcid,1041.816284,-945.909057,42.809848,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1041.816284), SetPVarFloat(npcid,"current_target_y", -945.909057), SetPVarFloat(npcid,"current_target_z", 42.809848);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1041.693725,-945.843811,42.808986))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1029.950195,-947.798828,42.611049,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1029.950195), SetPVarFloat(npcid,"current_target_y", -947.798828), SetPVarFloat(npcid,"current_target_z", 42.611049);
				case 1: FCNPC_GoTo(npcid,1046.803955,-971.495666,42.796974,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1046.803955), SetPVarFloat(npcid,"current_target_y", -971.495666), SetPVarFloat(npcid,"current_target_z", 42.796974);
				case 2: FCNPC_GoTo(npcid,1061.933959,-943.217224,42.964775,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1061.933959), SetPVarFloat(npcid,"current_target_y", -943.217224), SetPVarFloat(npcid,"current_target_z", 42.964775);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1061.933959,-943.217224,42.964775))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1041.770385,-945.851440,42.809558,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1041.770385), SetPVarFloat(npcid,"current_target_y", -945.851440), SetPVarFloat(npcid,"current_target_z", 42.809558);
				case 1: FCNPC_GoTo(npcid,1065.280029,-967.906494,42.796974,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1065.280029), SetPVarFloat(npcid,"current_target_y", -967.906494), SetPVarFloat(npcid,"current_target_z", 42.796974);
				case 2: FCNPC_GoTo(npcid,1077.173950,-941.710205,42.865337,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1077.173950), SetPVarFloat(npcid,"current_target_y", -941.710205), SetPVarFloat(npcid,"current_target_z", 42.865337);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1077.173950,-941.710205,42.865337))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1062.054077,-943.019592,42.965877,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1062.054077), SetPVarFloat(npcid,"current_target_y", -943.019592), SetPVarFloat(npcid,"current_target_z", 42.965877);
				case 1: FCNPC_GoTo(npcid,1079.511718,-967.500427,42.451915,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1079.511718), SetPVarFloat(npcid,"current_target_y", -967.500427), SetPVarFloat(npcid,"current_target_z", 42.451915);
				case 2: FCNPC_GoTo(npcid,1092.429199,-940.469665,42.925861,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1092.429199), SetPVarFloat(npcid,"current_target_y", -940.469665), SetPVarFloat(npcid,"current_target_z", 42.925861);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1092.429199,-940.469665,42.925861))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1077.345825,-941.635620,42.863239,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1077.345825), SetPVarFloat(npcid,"current_target_y", -941.635620), SetPVarFloat(npcid,"current_target_z", 42.863239);
				case 1: FCNPC_GoTo(npcid,1094.098876,-964.973571,42.416103,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1094.098876), SetPVarFloat(npcid,"current_target_y", -964.973571), SetPVarFloat(npcid,"current_target_z", 42.416103);
				case 2: FCNPC_GoTo(npcid,1107.811523,-939.152832,43.049320,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1107.811523), SetPVarFloat(npcid,"current_target_y", -939.152832), SetPVarFloat(npcid,"current_target_z", 43.049320);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1107.811523,-939.152832,43.049320))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1092.447875,-940.285095,42.926532,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1092.447875), SetPVarFloat(npcid,"current_target_y", -940.285095), SetPVarFloat(npcid,"current_target_z", 42.926532);
				case 1: FCNPC_GoTo(npcid,1110.196289,-964.118347,42.724960,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1110.196289), SetPVarFloat(npcid,"current_target_y", -964.118347), SetPVarFloat(npcid,"current_target_z", 42.724960);
				case 2: FCNPC_GoTo(npcid,1151.996582,-936.309143,43.130474,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1151.996582), SetPVarFloat(npcid,"current_target_y", -936.309143), SetPVarFloat(npcid,"current_target_z", 43.130474);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1151.996582,-936.309143,43.130474))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1107.515502,-939.009277,43.060550,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1107.515502), SetPVarFloat(npcid,"current_target_y", -939.009277), SetPVarFloat(npcid,"current_target_z", 43.060550);
				case 1: FCNPC_GoTo(npcid,1154.267211,-961.440490,42.779396,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1154.267211), SetPVarFloat(npcid,"current_target_y", -961.440490), SetPVarFloat(npcid,"current_target_z", 42.779396);
				case 2: FCNPC_GoTo(npcid,1167.422607,-934.277709,43.255458,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1167.422607), SetPVarFloat(npcid,"current_target_y", -934.277709), SetPVarFloat(npcid,"current_target_z", 43.255458);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1167.422607,-934.277709,43.255458))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1151.707275,-936.169067,43.135643,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1151.707275), SetPVarFloat(npcid,"current_target_y", -936.169067), SetPVarFloat(npcid,"current_target_z", 43.135643);
				case 1: FCNPC_GoTo(npcid,1170.536987,-959.515563,42.810485,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1170.536987), SetPVarFloat(npcid,"current_target_y", -959.515563), SetPVarFloat(npcid,"current_target_z", 42.810485);
				case 2: FCNPC_GoTo(npcid,1190.486572,-930.770996,42.996696,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1190.486572), SetPVarFloat(npcid,"current_target_y", -930.770996), SetPVarFloat(npcid,"current_target_z", 42.996696);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1190.486572,-930.770996,42.996696))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1167.415893,-934.145324,43.262058,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1167.415893), SetPVarFloat(npcid,"current_target_y", -934.145324), SetPVarFloat(npcid,"current_target_z", 43.262058);
				case 1: FCNPC_GoTo(npcid,1194.872802,-956.149780,42.911705,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1194.872802), SetPVarFloat(npcid,"current_target_y", -956.149780), SetPVarFloat(npcid,"current_target_z", 42.911705);
				case 2: FCNPC_GoTo(npcid,1208.634277,-927.479370,42.924549,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1208.634277), SetPVarFloat(npcid,"current_target_y", -927.479370), SetPVarFloat(npcid,"current_target_z", 42.924549);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1208.634277,-927.479370,42.924549))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1190.760620,-930.695373,42.995216,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1190.760620), SetPVarFloat(npcid,"current_target_y", -930.695373), SetPVarFloat(npcid,"current_target_z", 42.995216);
				case 1: FCNPC_GoTo(npcid,1213.959472,-952.158569,42.872074,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.959472), SetPVarFloat(npcid,"current_target_y", -952.158569), SetPVarFloat(npcid,"current_target_z", 42.872074);
				case 2: FCNPC_GoTo(npcid,1229.678344,-923.989135,42.818824,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1229.678344), SetPVarFloat(npcid,"current_target_y", -923.989135), SetPVarFloat(npcid,"current_target_z", 42.818824);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1229.678344,-923.989135,42.818824))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1208.463500,-927.576538,42.924858,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1208.463500), SetPVarFloat(npcid,"current_target_y", -927.576538), SetPVarFloat(npcid,"current_target_z", 42.924858);
				case 1: FCNPC_GoTo(npcid,1233.440429,-948.826965,42.734157,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1233.440429), SetPVarFloat(npcid,"current_target_y", -948.826965), SetPVarFloat(npcid,"current_target_z", 42.734157);
				case 2: FCNPC_GoTo(npcid,1249.724975,-919.861694,42.812740,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1249.724975), SetPVarFloat(npcid,"current_target_y", -919.861694), SetPVarFloat(npcid,"current_target_z", 42.812740);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1249.724975,-919.861694,42.812740))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1229.619873,-923.845336,42.824508,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1229.619873), SetPVarFloat(npcid,"current_target_y", -923.845336), SetPVarFloat(npcid,"current_target_z", 42.824508);
				case 1: FCNPC_GoTo(npcid,1253.383789,-945.504272,42.465988,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1253.383789), SetPVarFloat(npcid,"current_target_y", -945.504272), SetPVarFloat(npcid,"current_target_z", 42.465988);
				case 2: FCNPC_GoTo(npcid,1274.442382,-916.377685,42.184879,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1274.442382), SetPVarFloat(npcid,"current_target_y", -916.377685), SetPVarFloat(npcid,"current_target_z", 42.184879);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1274.442382,-916.377685,42.184879))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1249.628662,-919.872009,42.812423,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1249.628662), SetPVarFloat(npcid,"current_target_y", -919.872009), SetPVarFloat(npcid,"current_target_z", 42.812423);
				case 1: FCNPC_GoTo(npcid,1276.616821,-941.401367,42.238105,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1276.616821), SetPVarFloat(npcid,"current_target_y", -941.401367), SetPVarFloat(npcid,"current_target_z", 42.238105);
				case 2: FCNPC_GoTo(npcid,1286.938354,-914.808776,41.206180,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1286.938354), SetPVarFloat(npcid,"current_target_y", -914.808776), SetPVarFloat(npcid,"current_target_z", 41.206180);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1286.938354,-914.808776,41.206180))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1274.373901,-916.292297,42.186901,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1274.373901), SetPVarFloat(npcid,"current_target_y", -916.292297), SetPVarFloat(npcid,"current_target_z", 42.186901);
				case 1: FCNPC_GoTo(npcid,1286.990722,-939.934936,41.570964,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1286.990722), SetPVarFloat(npcid,"current_target_y", -939.934936), SetPVarFloat(npcid,"current_target_z", 41.570964);
				case 2: FCNPC_GoTo(npcid,1304.026000,-913.831176,39.274501,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1304.026000), SetPVarFloat(npcid,"current_target_y", -913.831176), SetPVarFloat(npcid,"current_target_z", 39.274501);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1304.026000,-913.831176,39.274501))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1287.098632,-914.685058,41.186912,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1287.098632), SetPVarFloat(npcid,"current_target_y", -914.685058), SetPVarFloat(npcid,"current_target_z", 41.186912);
				case 1: FCNPC_GoTo(npcid,1301.860717,-939.797607,39.727695,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1301.860717), SetPVarFloat(npcid,"current_target_y", -939.797607), SetPVarFloat(npcid,"current_target_z", 39.727695);
				case 2: FCNPC_GoTo(npcid,1318.603637,-914.972106,37.733013,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1318.603637), SetPVarFloat(npcid,"current_target_y", -914.972106), SetPVarFloat(npcid,"current_target_z", 37.733013);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1318.603637,-914.972106,37.733013))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1303.514038,-913.774963,39.333023,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1303.514038), SetPVarFloat(npcid,"current_target_y", -913.774963), SetPVarFloat(npcid,"current_target_z", 39.333023);
				case 1: FCNPC_GoTo(npcid,1316.475097,-941.670227,38.016849,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1316.475097), SetPVarFloat(npcid,"current_target_y", -941.670227), SetPVarFloat(npcid,"current_target_z", 38.016849);
				case 2: FCNPC_GoTo(npcid,1331.027709,-918.343444,36.672218,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1331.027709), SetPVarFloat(npcid,"current_target_y", -918.343444), SetPVarFloat(npcid,"current_target_z", 36.672218);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1331.027709,-918.343444,36.672218))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1318.169067,-914.845642,37.770343,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1318.169067), SetPVarFloat(npcid,"current_target_y", -914.845642), SetPVarFloat(npcid,"current_target_z", 37.770343);
				case 1: FCNPC_GoTo(npcid,1337.909057,-920.282226,35.900779,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1337.909057), SetPVarFloat(npcid,"current_target_y", -920.282226), SetPVarFloat(npcid,"current_target_z", 35.900779);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1337.909057,-920.282226,35.900779))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1331.180175,-918.483886,36.651840,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1331.180175), SetPVarFloat(npcid,"current_target_y", -918.483886), SetPVarFloat(npcid,"current_target_z", 36.651840);
				case 1: FCNPC_GoTo(npcid,1337.740478,-945.458007,35.745502,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1337.740478), SetPVarFloat(npcid,"current_target_y", -945.458007), SetPVarFloat(npcid,"current_target_z", 35.745502);
				case 2: FCNPC_GoTo(npcid,1357.870727,-925.330932,34.381637,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1357.870727), SetPVarFloat(npcid,"current_target_y", -925.330932), SetPVarFloat(npcid,"current_target_z", 34.381637);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1357.870727,-925.330932,34.381637))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1337.874755,-920.245361,35.904335,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1337.874755), SetPVarFloat(npcid,"current_target_y", -920.245361), SetPVarFloat(npcid,"current_target_z", 35.904335);
				case 1: FCNPC_GoTo(npcid,1354.713256,-950.474731,34.495525,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1354.713256), SetPVarFloat(npcid,"current_target_y", -950.474731), SetPVarFloat(npcid,"current_target_z", 34.495525);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1354.713256,-950.474731,34.495525))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1357.879394,-925.341003,34.381420,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1357.879394), SetPVarFloat(npcid,"current_target_y", -925.341003), SetPVarFloat(npcid,"current_target_z", 34.381420);
				case 1: FCNPC_GoTo(npcid,1337.783813,-945.363830,35.743148,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1337.783813), SetPVarFloat(npcid,"current_target_y", -945.363830), SetPVarFloat(npcid,"current_target_z", 35.743148);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1337.783813,-945.363830,35.743148))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1354.663818,-950.776367,34.505577,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1354.663818), SetPVarFloat(npcid,"current_target_y", -950.776367), SetPVarFloat(npcid,"current_target_z", 34.505577);
				case 1: FCNPC_GoTo(npcid,1338.026245,-920.166076,35.891716,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1338.026245), SetPVarFloat(npcid,"current_target_y", -920.166076), SetPVarFloat(npcid,"current_target_z", 35.891716);
				case 2: FCNPC_GoTo(npcid,1316.494750,-941.730346,38.013805,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1316.494750), SetPVarFloat(npcid,"current_target_y", -941.730346), SetPVarFloat(npcid,"current_target_z", 38.013805);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1316.494750,-941.730346,38.013805))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1337.703247,-945.464599,35.748508,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1337.703247), SetPVarFloat(npcid,"current_target_y", -945.464599), SetPVarFloat(npcid,"current_target_z", 35.748508);
				case 1: FCNPC_GoTo(npcid,1318.202758,-914.880310,37.768524,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1318.202758), SetPVarFloat(npcid,"current_target_y", -914.880310), SetPVarFloat(npcid,"current_target_z", 37.768524);
				case 2: FCNPC_GoTo(npcid,1302.032226,-939.726013,39.706115,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1302.032226), SetPVarFloat(npcid,"current_target_y", -939.726013), SetPVarFloat(npcid,"current_target_z", 39.706115);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1302.032226,-939.726013,39.706115))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1316.423461,-941.736877,38.021976,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1316.423461), SetPVarFloat(npcid,"current_target_y", -941.736877), SetPVarFloat(npcid,"current_target_z", 38.021976);
				case 1: FCNPC_GoTo(npcid,1287.082641,-940.124633,41.564178,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1287.082641), SetPVarFloat(npcid,"current_target_y", -940.124633), SetPVarFloat(npcid,"current_target_z", 41.564178);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1287.082641,-940.124633,41.564178))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1301.888183,-939.707153,39.724277,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1301.888183), SetPVarFloat(npcid,"current_target_y", -939.707153), SetPVarFloat(npcid,"current_target_z", 39.724277);
				case 1: FCNPC_GoTo(npcid,1287.025634,-914.756652,41.195892,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1287.025634), SetPVarFloat(npcid,"current_target_y", -914.756652), SetPVarFloat(npcid,"current_target_z", 41.195892);
				case 2: FCNPC_GoTo(npcid,1276.489379,-941.101867,42.237106,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1276.489379), SetPVarFloat(npcid,"current_target_y", -941.101867), SetPVarFloat(npcid,"current_target_z", 42.237106);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1276.489379,-941.101867,42.237106))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1287.112548,-940.092407,41.559844,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1287.112548), SetPVarFloat(npcid,"current_target_y", -940.092407), SetPVarFloat(npcid,"current_target_z", 41.559844);
				case 1: FCNPC_GoTo(npcid,1274.461303,-916.111755,42.183116,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1274.461303), SetPVarFloat(npcid,"current_target_y", -916.111755), SetPVarFloat(npcid,"current_target_z", 42.183116);
				case 2: FCNPC_GoTo(npcid,1253.100585,-945.492309,42.466384,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1253.100585), SetPVarFloat(npcid,"current_target_y", -945.492309), SetPVarFloat(npcid,"current_target_z", 42.466384);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1253.100585,-945.492309,42.466384))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1276.875000,-941.214172,42.227329,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1276.875000), SetPVarFloat(npcid,"current_target_y", -941.214172), SetPVarFloat(npcid,"current_target_z", 42.227329);
				case 1: FCNPC_GoTo(npcid,1249.717529,-919.633483,42.816070,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1249.717529), SetPVarFloat(npcid,"current_target_y", -919.633483), SetPVarFloat(npcid,"current_target_z", 42.816070);
				case 2: FCNPC_GoTo(npcid,1233.468872,-948.730163,42.733840,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1233.468872), SetPVarFloat(npcid,"current_target_y", -948.730163), SetPVarFloat(npcid,"current_target_z", 42.733840);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1233.468872,-948.730163,42.733840))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1229.519531,-923.423461,42.840126,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1229.519531), SetPVarFloat(npcid,"current_target_y", -923.423461), SetPVarFloat(npcid,"current_target_z", 42.840126);
				case 1: FCNPC_GoTo(npcid,1253.505615,-945.494934,42.465965,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1253.505615), SetPVarFloat(npcid,"current_target_y", -945.494934), SetPVarFloat(npcid,"current_target_z", 42.465965);
				case 2: FCNPC_GoTo(npcid,1213.871215,-952.294128,42.872833,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.871215), SetPVarFloat(npcid,"current_target_y", -952.294128), SetPVarFloat(npcid,"current_target_z", 42.872833);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1213.871215,-952.294128,42.872833))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1233.383422,-948.867614,42.734611,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1233.383422), SetPVarFloat(npcid,"current_target_y", -948.867614), SetPVarFloat(npcid,"current_target_z", 42.734611);
				case 1: FCNPC_GoTo(npcid,1208.311523,-927.006958,42.925296,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1208.311523), SetPVarFloat(npcid,"current_target_y", -927.006958), SetPVarFloat(npcid,"current_target_z", 42.925296);
				case 2: FCNPC_GoTo(npcid,1194.839355,-955.917297,42.911712,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1194.839355), SetPVarFloat(npcid,"current_target_y", -955.917297), SetPVarFloat(npcid,"current_target_z", 42.911712);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1194.839355,-955.917297,42.911712))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1213.809570,-952.321166,42.873294,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1213.809570), SetPVarFloat(npcid,"current_target_y", -952.321166), SetPVarFloat(npcid,"current_target_z", 42.873294);
				case 1: FCNPC_GoTo(npcid,1190.557617,-930.626831,43.003261,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1190.557617), SetPVarFloat(npcid,"current_target_y", -930.626831), SetPVarFloat(npcid,"current_target_z", 43.003261);
				case 2: FCNPC_GoTo(npcid,1170.573486,-959.611877,42.811019,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1170.573486), SetPVarFloat(npcid,"current_target_y", -959.611877), SetPVarFloat(npcid,"current_target_z", 42.811019);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1170.573486,-959.611877,42.811019))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1194.897705,-956.027893,42.911773,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1194.897705), SetPVarFloat(npcid,"current_target_y", -956.027893), SetPVarFloat(npcid,"current_target_z", 42.911773);
				case 1: FCNPC_GoTo(npcid,1167.530151,-933.983642,43.272571,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1167.530151), SetPVarFloat(npcid,"current_target_y", -933.983642), SetPVarFloat(npcid,"current_target_z", 43.272571);
				case 2: FCNPC_GoTo(npcid,1154.303588,-961.337158,42.780174,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1154.303588), SetPVarFloat(npcid,"current_target_y", -961.337158), SetPVarFloat(npcid,"current_target_z", 42.780174);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1154.303588,-961.337158,42.780174))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1170.973022,-959.688964,42.823379,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1170.973022), SetPVarFloat(npcid,"current_target_y", -959.688964), SetPVarFloat(npcid,"current_target_z", 42.823379);
				case 1: FCNPC_GoTo(npcid,1151.866943,-936.125122,43.136283,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1151.866943), SetPVarFloat(npcid,"current_target_y", -936.125122), SetPVarFloat(npcid,"current_target_z", 43.136283);
				case 2: FCNPC_GoTo(npcid,1110.377441,-964.046936,42.728843,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1110.377441), SetPVarFloat(npcid,"current_target_y", -964.046936), SetPVarFloat(npcid,"current_target_z", 42.728843);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1110.377441,-964.046936,42.728843))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1154.469726,-961.692077,42.776863,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1154.469726), SetPVarFloat(npcid,"current_target_y", -961.692077), SetPVarFloat(npcid,"current_target_z", 42.776863);
				case 1: FCNPC_GoTo(npcid,1107.709472,-939.244689,43.042705,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1107.709472), SetPVarFloat(npcid,"current_target_y", -939.244689), SetPVarFloat(npcid,"current_target_z", 43.042705);
				case 2: FCNPC_GoTo(npcid,1094.197998,-964.875488,42.417285,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1094.197998), SetPVarFloat(npcid,"current_target_y", -964.875488), SetPVarFloat(npcid,"current_target_z", 42.417285);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1094.197998,-964.875488,42.417285))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1110.439208,-964.056518,42.730106,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1110.439208), SetPVarFloat(npcid,"current_target_y", -964.056518), SetPVarFloat(npcid,"current_target_z", 42.730106);
				case 1: FCNPC_GoTo(npcid,1092.302368,-940.411437,42.924194,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1092.302368), SetPVarFloat(npcid,"current_target_y", -940.411437), SetPVarFloat(npcid,"current_target_z", 42.924194);
				case 2: FCNPC_GoTo(npcid,1079.437255,-967.476135,42.450920,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1079.437255), SetPVarFloat(npcid,"current_target_y", -967.476135), SetPVarFloat(npcid,"current_target_z", 42.450920);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1079.437255,-967.476135,42.450920))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1094.318603,-965.051025,42.418006,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1094.318603), SetPVarFloat(npcid,"current_target_y", -965.051025), SetPVarFloat(npcid,"current_target_z", 42.418006);
				case 1: FCNPC_GoTo(npcid,1077.633422,-941.698120,42.860042,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1077.633422), SetPVarFloat(npcid,"current_target_y", -941.698120), SetPVarFloat(npcid,"current_target_z", 42.860042);
				case 2: FCNPC_GoTo(npcid,1065.362182,-968.154052,42.796974,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1065.362182), SetPVarFloat(npcid,"current_target_y", -968.154052), SetPVarFloat(npcid,"current_target_z", 42.796974);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1065.362182,-968.154052,42.796974))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1079.206909,-967.719848,42.450408,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1079.206909), SetPVarFloat(npcid,"current_target_y", -967.719848), SetPVarFloat(npcid,"current_target_z", 42.450408);
				case 1: FCNPC_GoTo(npcid,1062.058471,-942.754455,42.966167,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1062.058471), SetPVarFloat(npcid,"current_target_y", -942.754455), SetPVarFloat(npcid,"current_target_z", 42.966167);
				case 2: FCNPC_GoTo(npcid,1046.765991,-971.212585,42.796974,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1046.765991), SetPVarFloat(npcid,"current_target_y", -971.212585), SetPVarFloat(npcid,"current_target_z", 42.796974);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1046.765991,-971.212585,42.796974))
	    {
	        switch(random(3))
	        {
				case 0: FCNPC_GoTo(npcid,1065.498413,-968.013488,42.796974,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1065.498413), SetPVarFloat(npcid,"current_target_y", -968.013488), SetPVarFloat(npcid,"current_target_z", 42.796974);
				case 1: FCNPC_GoTo(npcid,1041.786865,-945.817077,42.809715,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1041.786865), SetPVarFloat(npcid,"current_target_y", -945.817077), SetPVarFloat(npcid,"current_target_z", 42.809715);
				case 2: FCNPC_GoTo(npcid,1032.582153,-973.212646,42.617835,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1032.582153), SetPVarFloat(npcid,"current_target_y", -973.212646), SetPVarFloat(npcid,"current_target_z", 42.617835);
	        }
	    }
	    if(IsPlayerInRangeOfPoint(npcid,3.0,1032.582153,-973.212646,42.617835))
	    {
	        switch(random(2))
	        {
				case 0: FCNPC_GoTo(npcid,1046.916870,-971.405456,42.796974,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1046.916870), SetPVarFloat(npcid,"current_target_y", -971.405456), SetPVarFloat(npcid,"current_target_z", 42.796974);
				case 1: FCNPC_GoTo(npcid,1029.714233,-947.704956,42.611106,MOVE_TYPE_WALK,0,0), SetPVarFloat(npcid,"current_target_x", 1029.714233), SetPVarFloat(npcid,"current_target_y", -947.704956), SetPVarFloat(npcid,"current_target_z", 42.611106);
	        }
	    }
	}
}

function spawnNPC()
{
	for (new npcid = 0; npcid < sizeof(npc); npcid++)
	{
  		npc[npcid][npc_ID] = FCNPC_Create(npc[npcid][npc_Name]);
  		FCNPC_Spawn(npc[npcid][npc_ID], npc[npcid][npc_Skin], npc[npcid][npc_X], npc[npcid][npc_Y], npc[npcid][npc_Z]);
  		FCNPC_SetWeapon(npc[npcid][npc_ID],npc[npcid][weaponnpcid]);
  		FCNPC_SetQuaternion(npc[npcid][npc_ID],0.0,0.0,0.0,0.0);
  		FCNPC_SetAngle(npc[npcid][npc_ID], npc[npcid][npc_A]);
  		SetPlayerColor(npc[npcid][npc_ID],00);
		SetPlayerVirtualWorld(npc[npcid][npc_ID],3);
		ApplyAnimation(npc[npcid][npc_ID], "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0 );
		FCNPC_Stop(npc[npcid][npc_ID]);
  		FCNPC_StopAttack(npc[npcid][npc_ID]);
	}
 	SetPVarInt(npc[0][npc_ID], "alhambra", 1),SetPVarInt(npc[1][npc_ID], "alhambra", 1), SetPVarInt(npc[8][npc_ID], "alhambra", 1), SetPVarInt(npc[9][npc_ID], "alhambra", 1);
 	for (new npcid = 2; npcid < 8; npcid++)
	{
 		SetPVarInt(npc[npcid][npc_ID], "major", 1);
	}
	for (new npcid = 9; npcid < 14; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "nearalnambra", 1);
	}
	for (new npcid = 14; npcid < 19; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "preglen", 1);
	}
	for (new npcid = 19; npcid < 23; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "prgl2", 1);
	}
	for (new npcid = 23; npcid < 29; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "grove", 1);
	}
	for (new npcid = 29; npcid < 35; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "glenpark", 1);
	}
	for (new npcid = 35; npcid < 41; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "vinewood", 1);
	}
	for (new npcid = 41; npcid < 47; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "grove_cluck", 1);
	}
	for (new npcid = 47; npcid < 57; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "marina", 1);
	}
	for (new npcid = 57; npcid < 61; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "circle_beach", 1);
	}
	for (new npcid = 61; npcid < 67; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "rodeo", 1);
	}
	for (new npcid = 67; npcid < 71; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "hospital_ls", 1);
	}
	for (new npcid = 71; npcid < 76; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "tradeplace", 1);
	}
	for (new npcid = 76; npcid < 80; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "losflores", 1);
	}
	for (new npcid = 80; npcid < 86; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "westcoast", 1);
	}
	for (new npcid = 86; npcid < 93; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "willowfield", 1);
	}
	for (new npcid = 93; npcid < 100; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "centre", 1);
	}
 	for (new npcid = 0; npcid < 100; npcid++)
	{
	    SetPVarInt(npc[npcid][npc_ID], "moneyinwallet", 1);
	    SetPVarInt(npc[npcid][npc_ID], "alive_npc", 1);
	    SetPVarInt(npc[npcid][npc_ID], "fighter", 1);
		switch(random(6))
		{
			case 0: SetPlayerFightingStyle(npc[npcid][npc_ID], 4);
			case 1: SetPlayerFightingStyle(npc[npcid][npc_ID], 5);
			case 2: SetPlayerFightingStyle(npc[npcid][npc_ID], 6);
			case 3: SetPlayerFightingStyle(npc[npcid][npc_ID], 7);
			case 4: SetPlayerFightingStyle(npc[npcid][npc_ID], 15);
			case 5: SetPlayerFightingStyle(npc[npcid][npc_ID], 16);
		}
	}
	SetTimer("start_move",1500,0);
	SetWalk();
 	npcmoneytimer = SetTimer("updatemoney",60000,1);
}

stock SetWalk()
{
	for(new i=0;i<MAX_PLAYERS;i++) 
	{
	    if(IsPlayerNPC(i))
		{
		    switch(random(4))
		    {
		        case 0: ApplyAnimation(i,"PED","WALK_player",4.1,1,1,1,1,1);
		        case 1: ApplyAnimation(i,"PED","WALK_civi",4.1,1,1,1,1,1);
		        case 2: ApplyAnimation(i,"PED","WALK_gang1",4.1,1,1,1,1,1);
		        case 3: ApplyAnimation(i,"PED","WALK_gang2",4.1,1,1,1,1,1);
		    }
		}
	}
}

function updatemoney()
{
	for (new npcid = 0; npcid < 100; npcid++)
	{
		if(GetPVarInt(npc[npcid][npc_ID], "moneyinwallet")!=1)
		{
		    SetPVarInt(npc[npcid][npc_ID], "moneyinwallet",1);
		}
	}
}



function start_move()
{
	for (new npcid = 0; npcid < 100; npcid++)
	{
	    SetPlayerVirtualWorld(npc[npcid][npc_ID],0);
	    FCNPC_Stop(npc[npcid][npc_ID]);
  		FCNPC_StopAttack(npc[npcid][npc_ID]);
	    SetPVarInt(npc[npcid][npc_ID], "check_coll", 1);
	    CallLocalFunction("FCNPC_OnReachDestination", "i", npc[npcid][npc_ID]);
	}
	npc_coll_timer = SetTimer("check_collision",100,1);
}

stock Money_Grab(playerid)
{
	new randommoney;
	randommoney = random(50);
	new message[64];
	format(message,sizeof(message),"You robbed a citizen in the amount of $%i",randommoney);
	SendClientMessage(playerid,-1,message);
	GivePlayerMoney(playerid,randommoney);
}

public OnPlayerStreamIn(playerid, forplayerid)
{

	return 1;
}

stock Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
	return VectorSize(x1-x2, y1-y2, z1-z2);
}

forward check_collision();
public check_collision()
{
	new
		Float:player_pos[3],
		Float:npc_pos[4],
		Float:vect1X, Float:vect1Y, Float:vect2X, Float:vect2Y,
		Float:scal, Float:dist;

	foreach (new i : Player)
	{
		new targetplayer = GetPlayerTargetPlayer(i);
		if (GetPVarInt(targetplayer,"moneyinwallet")==1 && IsPlayerNPC(targetplayer) && GetPlayerWeapon(i)>21 && GetPlayerWeapon(i) <=34)
		{
			GetPlayerPos(i, player_pos[0], player_pos[1], player_pos[2]);
			FCNPC_GetPosition(targetplayer, npc_pos[0], npc_pos[1], npc_pos[2]);
			npc_pos[3] = FCNPC_GetAngle(targetplayer);

			vect1X = npc_pos[0] - player_pos[0];
			vect1Y = npc_pos[1] - player_pos[1];

			vect2X = npc_pos[0] - npc_pos[0] - (floatsin(npc_pos[3], degrees) * 3);
			vect2Y = npc_pos[1] - npc_pos[1] + (floatcos(npc_pos[3], degrees) * 3);

			scal = vect2X * vect1X + vect2Y * vect1Y;

			dist = GetDistanceBetweenPoints(npc_pos[0], npc_pos[1], npc_pos[2], player_pos[0], player_pos[1], player_pos[2]);
			if (dist < 5.0 && scal <= 0)
			{
				if (GetPVarInt(targetplayer,"fighter")!=1)
				{
					SetPVarInt(targetplayer,"fighter",1);
					FCNPC_SetWeapon(targetplayer,0);
				}

				SetPVarInt(targetplayer, "check_coll", 2);
				SetPVarInt(targetplayer,"moneyinwallet",2);

				FCNPC_Stop(targetplayer);
				FCNPC_SetSpecialAction(targetplayer,10);

				SetTimerEx("backquaternion",5000,0,"i",targetplayer);
				SetTimerEx("back_coll",5000,0,"i",targetplayer);

				Money_Grab(i);

				switch(random(4))
				{
					case 0: SetPlayerChatBubble(targetplayer, "Get my money, but don't kill me!", -1, 10.0, 4900);
					case 1: SetPlayerChatBubble(targetplayer, "I don't have anymore!", -1, 10.0, 4900);
					case 2: SetPlayerChatBubble(targetplayer, "Don't shoot me, please!", -1, 10.0, 4900);
					case 3: SetPlayerChatBubble(targetplayer, "I have really no more!", -1, 10.0, 4900);
				}
			}
		}
	}

	new Float:x2,Float:y2,Float:z2;
	new Float:tmpdis;
	new pid;

	foreach (new i : Bot)
	{
		dist = 65000.0;
		pid = FCNPC_GetClosestPlayer(i, dist);
		if (pid == -1) {
			continue;
		}

		if (dist < 1.5 && GetPlayerState(pid)==PLAYER_STATE_DRIVER)
		{
			new Float:xPos[3];
			GetVehicleVelocity(GetPlayerVehicleID(pid), xPos[0], xPos[1], xPos[2]);
			new Float:pspeed = floatround(floatsqroot(xPos[0] * xPos[0] + xPos[1] * xPos[1] + xPos[2] * xPos[2]) * 180.00);
			if(pspeed>=7.0)
			{
				FCNPC_Stop(i);
				FCNPC_SetHealth(i,0);
			}
		}
		if(GetPVarInt(i,"fighter")==1 && GetPVarInt(i,"alive_npc")==1 && GetPVarInt(i,"check_coll")==1)
		{
			FCNPC_GetPosition(i, npc_pos[0], npc_pos[1], npc_pos[2]);
			npc_pos[3] = FCNPC_GetAngle(i);

			foreach (new j : Bot)
			{
				if (j == i) {
					continue;
				}

				FCNPC_GetPosition(j, x2, y2, z2);

				tmpdis = GetDistanceBetweenPoints(npc_pos[0], npc_pos[1], npc_pos[2], x2, y2, z2);
				if (tmpdis < 2.0 && tmpdis > 1.25 && GetPVarInt(j,"alive_npc")==1)
				{
					npc_pos[0] += (1.5 * floatsin(-npc_pos[3] - 55, degrees));
					npc_pos[1] += (1.5 * floatcos(-npc_pos[3] - 55, degrees));
					FCNPC_GoTo(i, npc_pos[0], npc_pos[1], npc_pos[2], MOVE_TYPE_WALK, 0, 0);

					SetPVarInt(i,"check_coll",2);

					SetTimerEx("backquaternion",550,0,"i",i);
					SetTimerEx("back_coll",1700,0,"i",i);
				}
			}
		}
		if(GetPVarInt(i,"fighter")==2 && GetPVarInt(i, "victim")== pid)
		{
			FCNPC_Stop(i);
			if(dist < 10.0)
			{
				SetPVarInt(i, "check_coll", 2);
				SetPVarInt(i, "fighter",3);
			}
			else
			{
				SetPVarInt(i, "fighter",1);
				SetPVarInt(i, "check_coll", 1);
			 	FCNPC_GoTo(i,GetPVarFloat(i, "current_target_x"),GetPVarFloat(i, "current_target_y"),GetPVarFloat(i, "current_target_z"),MOVE_TYPE_WALK,0,0);
			}
		}
 		if(GetPVarInt(i,"fighter")==3)
		{
			if(dist < 1.0 && GetPVarInt(i, "victim") == pid)
			{
				FCNPC_Player_Angle(i,pid);
				switch(random(3))
				{
					case 0: FCNPC_SetKeys(i,KEY_HANDBRAKE+KEY_FIRE);
					case 1: FCNPC_SetKeys(i,KEY_HANDBRAKE+KEY_SECONDARY_ATTACK);
					case 2: FCNPC_SetKeys(i,KEY_HANDBRAKE+KEY_JUMP);
				}
			}
			else if(dist < 10.0 && GetPVarInt(i, "victim") == pid)
			{
				 FCNPC_Player_Angle(i,pid);
			}
			new Float:nx, Float:ny, Float:nz;
			FCNPC_GetPosition(i, nx,ny,nz);
			if(GetPlayerDistanceFromPoint(GetPVarInt(i, "victim"), nx,ny,nz) > 10.0)
			{
				DeletePVar(i,"victim");
				SetPVarInt(i, "fighter",1);
				FCNPC_Stop(i);
				FCNPC_SetWeapon(i,0);
				SetPVarInt(i, "check_coll", 1);
				FCNPC_GoTo(i,GetPVarFloat(i, "current_target_x"),GetPVarFloat(i, "current_target_y"),GetPVarFloat(i, "current_target_z"),MOVE_TYPE_WALK,0,0);
			}
		}
	}
}

stock FCNPC_Player_Angle(npcid, playerid)
{
	new Float:player_pos[3];
	GetPlayerPos(playerid, player_pos[0], player_pos[1], player_pos[2]);

	new Float:npc_pos[3];
	FCNPC_GetPosition(npcid, npc_pos[0], npc_pos[1], npc_pos[2]);

	FCNPC_SetAngle(npcid, 180.0 - atan2(npc_pos[0] - player_pos[0], npc_pos[1] - player_pos[1]));
	return 1;
}

stock FCNPC_GetClosestPlayer(npcid, &Float:cdist = 65000.0)
{
	new cid = -1;
	new Float:dist;
	new Float:mx, Float:my, Float:mz;

	FCNPC_GetPosition(npcid, mx, my, mz);

	foreach (new i : Player)
	{
		dist = GetPlayerDistanceFromPoint(i, mx, my, mz);
		if (dist < cdist)
		{
			cdist = dist;
			cid = i;
		}
	}

	return cid;
}



public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/givemegun", true))
    {
        GivePlayerWeapon(playerid,1,1);
        GivePlayerWeapon(playerid,16,500);
        GivePlayerWeapon(playerid,24,500);
        GivePlayerWeapon(playerid,25,500);
        GivePlayerWeapon(playerid,30,500);
        GivePlayerWeapon(playerid,29,500);
        GivePlayerWeapon(playerid,33,500);
        GivePlayerWeapon(playerid,34,500);
        return 1;
    }
    return 0;
}

function respawn(npcid)
{
	FCNPC_Respawn(npcid);
	SetPlayerVirtualWorld(npcid,0);
	SetPVarInt(npcid,"moneyinwallet",1);
	SetPVarInt(npcid,"alive_npc",1);
	SetPVarInt(npcid, "fighter",1);
	SetPVarInt(npcid,"check_coll",1);
	FCNPC_SetWeapon(npcid,0);
	FCNPC_GoTo(npcid,GetPVarFloat(npcid, "current_target_x"),GetPVarFloat(npcid, "current_target_y"),GetPVarFloat(npcid, "current_target_z"),MOVE_TYPE_WALK,0,0);
}

function disappear(npcid)
{
	SetPlayerVirtualWorld(npcid,1);
}
public FCNPC_OnDeath(npcid)
{
        SetPVarInt(npcid,"alive_npc",2);
        SetPVarInt(npcid,"check_coll",2);

        if (GetPVarInt(npcid, "moneyinwallet") != 2)
        {
                new Float:x, Float:y, Float:z;
                FCNPC_GetPosition(npcid, x, y, z);
                money_pickup[npcid] = CreatePickup(1212, 1, x + (random(5) - random(5)) / 2, y + (random(5) - random(5)) / 2, z, -1);

                SetTimerEx("DestroyMoneyPickup", 8000, 0, "i", npcid);
        }

        SetPVarInt(npcid,"moneyinwallet",2);
        SetTimerEx("respawn",15000,0,"i",npcid);
        SetTimerEx("disappear",7500,0,"i",npcid);
}

forward DestroyMoneyPickup(npcid);
public DestroyMoneyPickup(npcid)
{
        if (money_pickup[npcid] != -1) {
                DestroyPickup(money_pickup[npcid]);
                money_pickup[npcid] = -1;
        }
        return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
        foreach (new npcid : Bot)
        {
                if (pickupid == money_pickup[npcid])
                {
                        DestroyMoneyPickup(npcid);

                        new randommoney = random(50);
                        new message[64];
                        format(message,sizeof(message),"You've got $%i",randommoney);
                        SendClientMessage(playerid,-1,message);
                        GivePlayerMoney(playerid, randommoney);
                        break;
                }
        }
        return 1;
}

function backquaternion(npcid)
{
	ApplyAnimation(npcid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0 );
	if(FCNPC_GetSpecialAction(npcid)==10)
	{
	    FCNPC_SetSpecialAction(npcid,0);
	}
	if(GetPVarInt(npcid,"fighter")!=3)
	{
    	FCNPC_GoTo(npcid,GetPVarFloat(npcid, "current_target_x"),GetPVarFloat(npcid, "current_target_y"),GetPVarFloat(npcid, "current_target_z"),MOVE_TYPE_WALK,0,0);
	}
}

function back_coll(npcid)
{
    SetPVarInt(npcid, "check_coll", 1);
}

public FCNPC_OnTakeDamage(npcid, damagerid, weaponid, bodypart, Float:health_loss)
{
	return 1;
}
public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
	return 1;

}
