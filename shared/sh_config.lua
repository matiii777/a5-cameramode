Shared = {}

--- Camera Mode
Shared.DiscordWebHook = "YOUR-WEBHOOK-HERE" -- Put your webhook here to save screenshots to discord https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks
Shared.Cameramodeheader = 'A5 Camera Mode' -- camera mode header text
Shared.MovingX = {Min = -14, Max = 14} -- the maximum and minimum movement horizontaly
Shared.MovingY = {Min = -14, Max = 14} -- the maximum and minimum movement verticaly
Shared.MovingZ = {Min = 0, Max = 8} -- the maximum and minimum movement longitudely ?
Shared.MovingFov = {Min = -12, Max = 40} -- the maximum and minimum FOV
Shared.MaxFilterStrength = 2.6

------ DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE DOING -------
Shared.EndFOV = 20.0
Shared.CameraOffsetStart = vector3(2.20, 2.0, 2.20)
Shared.CameraOffsetEnd = vector3(0.0, 5.0, -0.6)
Shared.CameraTransitionTime = 400
------ DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE DOING -------

--these are all the filters that are used in the camera mode
Shared.Filters = {
    [1] = {
        Name = 'No Filter',
        Source = false,
        Color = 'rgb(254,254,254)',
    },
    [2] = {
        Name = 'Black and white',
        Source = 'spectator4',
        Color = 'rgb(0,0,0)',
    },
    [3] = {
        Name = 'Security Camera',
        Source = 'CAMERA_secuirity_FUZZ',
        Color = 'rgb(160,80,40)',
    },
    [4] = {
        Name = 'Brightness',
        Source = 'BeastLaunch02',
        Color = 'rgb(240,240,180)',
    },
    [5] = {
        Name = 'Focus on center',
        Source = 'AirRaceBoost01',
        Color = 'rgb(20,224,20)',
    },
    [6] = {
        Name = 'Green effect',
        Source = 'AirRaceBoost02',
        Color = 'rgb(160,224,40)',
    },
    [7] = {
        Name = 'Sharpness',
        Source = 'AmbientPUSH',
        Color = 'rgb(12,12,12)',
    },
    [8] = {
        Name = 'Old effect purple',
        Source = 'ArenaEMP',
        Color = 'rgb(140,124,220)',
    },
    [9] = {
        Name = 'Old effect lightblue',
        Source = 'ArenaEMP_Blend',
        Color = 'rgb(42,224,144)',
    },
    [10] = {
        Name = 'Old effect brown',
        Source = 'BeastIntro01',
        Color = 'rgb(144,64,24)',
    },
    [11] = {
        Name = 'Old effect red',
        Source = 'BeastIntro02',
        Color = 'rgb(254,22,22)',
    },
    [12] = {
        Name = 'Beach regular',
        Source = 'ArenaWheelPurple01',
        Color = 'rgb(240,124,220)',
    },
    [13] = {
        Name = 'Beach highlight',
        Source = 'ArenaWheelPurple02',
        Color = 'rgb(240,24,220)',
    },
    [14] = {
        Name = 'Depth',
        Source = 'Bank_HLWD',
        Color = 'rgb(224,22,22)',
    },
    [15] = {
        Name = '420',
        Source = 'Barry1_Stoned',
        Color = 'rgb(44,224,44)',
    },
    [16] = {
        Name = 'Too much drugs',
        Source = 'BikerFilter',
        Color = 'rgb(122,224,144)',
    },
    [17] = {
        Name = 'Fade blur',
        Source = 'BarryFadeOut',
        Color = 'rgb(242,224,144)',
    },
    [18] = {
        Name = 'Border Shadow',
        Source = 'BikerForm01',
        Color = 'rgb(4,4,4)',
    },
    [19] = {
        Name = 'Mexican movie light',
        Source = 'Bikers',
        Color = 'rgb(144,82,144)',
    },
    [20] = {
        Name = 'Mexican movie dark',
        Source = 'BikersSPLASH',
        Color = 'rgb(144,42,144)',
    },
    [21] = {
        Name = 'Green with lines',
        Source = 'blackNwhite',
        Color = 'rgb(64,224,64)',
    },
    [22] = {
        Name = 'Dirty Blur',
        Source = 'BlackOut',
        Color = 'rgb(166,166,166)',
    },
    [23] = {
        Name = 'Pink heat',
        Source = 'BleepYellow02',
        Color = 'rgb(164,44,84)',
    },
    [24] = {
        Name = 'Bloom heavy',
        Source = 'Bloom',
        Color = 'rgb(222,222,222)',
    },
    [25] = {
        Name = 'Bloom Midium',
        Source = 'BloomLight',
        Color = 'rgb(188,188,188)',
    },
    [26] = {
        Name = 'Bloom Light',
        Source = 'BloomMid',
        Color = 'rgb(144,144,144)',
    },
    [27] = {
        Name = 'Old TV',
        Source = 'Broken_camera_fuzz',
        Color = 'rgb(184,128,42)',
    },
    [28] = {
        Name = 'Hot blue',
        Source = 'BulletTimeDark',
        Color = 'rgb(20,80,244)',
    },
    [29] = {
        Name = 'Hot Red',
        Source = 'casino_managersoffice',
        Color = 'rgb(244,22,22)',
    },
    [30] = {
        Name = 'Day and night',
        Source = 'casino_mainfloor',
        Color = 'rgb(20,28,84)',
    },
    [31] = {
        Name = 'Old Camera',
        Source = 'CHOP',
        Color = 'rgb(84,64,42)',
    },
    [32] = {
        Name = 'Cinema light',
        Source = 'cinema',
        Color = 'rgb(122,122,144)',
    },
    [33] = {
        Name = 'Cinema heavy',
        Source = 'cinema_001',
        Color = 'rgb(162,162,184)',
    },
    [34] = {
        Name = 'Black and white bloom',
        Source = 'cops',
        Color = 'rgb(4,4,4)',
    },
    [35] = {
        Name = 'Light purple touch',
        Source = 'CopsSPLASH',
        Color = 'rgb(162,162,284)',
    },
    [36] = {
        Name = 'Light orange touch',
        Source = 'CrossLine01',
        Color = 'rgb(242,122,24)',
    },
    [37] = {
        Name = 'Clean background',
        Source = 'CS1_railwayB_tunnel',
        Color = 'rgb(162,162,284)',
    },
    [38] = {
        Name = 'Remove all light',
        Source = 'downtown_FIB_cascades_opt',
        Color = 'rgb(244,244,82)',
    },
    [39] = {
        Name = 'Red shadow',
        Source = 'damage',
        Color = 'rgb(244,24,24)',
    },
    [40] = {
        Name = 'Bright sky',
        Source = 'dlc_casino_carpark',
        Color = 'rgb(164,244,244)',
    },
    [41] = {
        Name = 'Yellow highlight',
        Source = 'DrivingFocusLight',
        Color = 'rgb(244,244,22)',
    },
    [42] = {
        Name = 'Green highlight',
        Source = 'DrivingFocusDark',
        Color = 'rgb(44,244,82)',
    },
    [43] = {
        Name = 'Blue drip',
        Source = 'DRUG_2_drive',
        Color = 'rgb(24,64,242)',
    },
    [44] = {
        Name = 'Purple drip',
        Source = 'drug_drive_blend02',
        Color = 'rgb(124,24,222)',
    },
    [45] = {
        Name = 'Under water',
        Source = 'Drug_deadman',
        Color = 'rgb(22,184,242)',
    },
    [46] = {
        Name = 'Pure green',
        Source = 'drug_flying_02',
        Color = 'rgb(44,244,44)',
    },
    [47] = {
        Name = 'Pure pink',
        Source = 'drug_flying_base',
        Color = 'rgb(224,24,222)',
    },
    [48] = {
        Name = 'More lights',
        Source = 'eatra_bouncelight_beach',
        Color = 'rgb(244,224,224)',
    },
    [49] = {
        Name = 'Contrast',
        Source = 'epsilion',
        Color = 'rgb(188,188,188)',
    },
    [50] = {
        Name = 'Contrast 2',
        Source = 'exile1_plane',
        Color = 'rgb(224,224,224)',
    },
    [51] = {
        Name = 'Bright lights',
        Source = 'Facebook_NEW',
        Color = 'rgb(222,222,22)',
    },
    [52] = {
        Name = 'Bright lights 2',
        Source = 'facebook_serveroom',
        Color = 'rgb(222,222,82)',
    },
    [53] = {
        Name = 'Bright lights 3',
        Source = 'FIB_5',
        Color = 'rgb(222,222,22)',
    },
    [54] = {
        Name = 'Bright lights 4',
        Source = 'FIB_6',
        Color = 'rgb(222,222,82)',
    },
    [55] = {
        Name = 'Bright lights 5',
        Source = 'FIB_A',
        Color = 'rgb(222,222,22)',
    },
    [56] = {
        Name = 'Bright lights 6',
        Source = 'FIB_B',
        Color = 'rgb(222,222,82)',
    },
    [57] = {
        Name = 'Shadow with blur',
        Source = 'fp_vig_blue',
        Color = 'rgb(4,4,4)',
    },
    [58] = {
        Name = 'Green shadow with blur',
        Source = 'fp_vig_green',
        Color = 'rgb(44,224,44)',
    },
    [59] = {
        Name = 'Stripped to green',
        Source = 'FranklinColorCode',
        Color = 'rgb(24,124,84)',
    },
    [60] = {
        Name = 'Stripped to green 2',
        Source = 'FranklinColorCodeBasic',
        Color = 'rgb(24,124,84)',
    },
    [61] = {
        Name = 'Stripped to green 3',
        Source = 'FranklinColorCodeBright',
        Color = 'rgb(24,124,84)',
    },
    [62] = {
        Name = 'Cold colors',
        Source = 'Glasses_BlackOut',
        Color = 'rgb(64,144,182)',
    },
    [63] = {
        Name = 'Cold colors 2',
        Source = 'glasses_brown',
        Color = 'rgb(64,144,182)',
    },
    [64] = {
        Name = 'Blue Shade',
        Source = 'glasses_Darkblue',
        Color = 'rgb(2,24,222)',
    },
    [65] = {
        Name = 'Green Shade',
        Source = 'glasses_green',
        Color = 'rgb(22,242,22)',
    },
    [66] = {
        Name = 'Orange shade',
        Source = 'glasses_orange',
        Color = 'rgb(244,124,22)',
    },
    [67] = {
        Name = 'Pink shade',
        Source = 'glasses_pink',
        Color = 'rgb(224,44,182)',
    },
    [68] = {
        Name = 'Purple shade',
        Source = 'glasses_purple',
        Color = 'rgb(124,24,222)',
    },
    [69] = {
        Name = 'Red shade',
        Source = 'glasses_red',
        Color = 'rgb(255,44,44)',
    },
    [70] = {
        Name = 'Orange and green',
        Source = 'glasses_yellow',
        Color = 'rgb(244,164,12)',
    },
    [71] = {
        Name = 'Fog',
        Source = 'graveyard_shootout',
        Color = 'rgb(224,224,224)',
    },
    [72] = {
        Name = 'Unclear shadow',
        Source = 'helicamfirst',
        Color = 'rgb(4,4,4)',
    },
    [73] = {
        Name = 'Red and blue',
        Source = 'Hint_cam',
        Color = 'rgb(244,24,24)',
    },
    [74] = {
        Name = 'Light blue',
        Source = 'hud_def_colorgrade',
        Color = 'rgb(24,124,182)',
    },
    [75] = {
        Name = 'Black and white 2',
        Source = 'hud_def_desat_cold_kill',
        Color = 'rgb(4,4,4)',
    },
    [76] = {
        Name = 'Black and white 3',
        Source = 'hud_def_desatcrunch',
        Color = 'rgb(4,4,4)',
    },
    [77] = {
        Name = 'Beach soft',
        Source = 'InchPurple01',
        Color = 'rgb(164,44,222)',
    },
    [78] = {
        Name = 'White and light blue',
        Source = 'int_Hospital2_DM',
        Color = 'rgb(124,224,222)',
    },
    [79] = {
        Name = 'Low black and blue',
        Source = 'introblue',
        Color = 'rgb(22,22,222)',
    },
    [80] = {
        Name = 'Purple blur',
        Source = 'Kifflom',
        Color = 'rgb(124,24,222)',
    },
    [81] = {
        Name = 'Fade background',
        Source = 'michealspliff',
        Color = 'rgb(4,4,4)',
    },
    [82] = {
        Name = 'Smug',
        Source = 'MP_Arena_theme_atlantis',
        Color = 'rgb(244,244,244)',
    },
    [83] = {
        Name = 'Yellow sky',
        Source = 'MP_Arena_theme_evening',
        Color = 'rgb(224,166,22)',
    },
    [84] = {
        Name = 'Spotlight blue',
        Source = 'mp_lad_day',
        Color = 'rgb(22,44,222)',
    },
    [85] = {
        Name = 'Spotlight red',
        Source = 'mp_lad_judgment',
        Color = 'rgb(244,22,22)',
    },
    [86] = {
        Name = 'Smog 2',
        Source = 'nervousRON_fog',
        Color = 'rgb(244,244,244)',
    },
    [87] = {
        Name = 'Black and white 4',
        Source = 'NG_blackout',
        Color = 'rgb(4,4,4)',
    },
    [88] = {
        Name = 'Black and white 5',
        Source = 'NG_deathfail_BW_base',
        Color = 'rgb(4,4,4)',
    },
    [89] = {
        Name = 'Hot colors',
        Source = 'NG_filmic10',
        Color = 'rgb(222,124,22)',
    },
    [90] = {
        Name = 'Black and white 6',
        Source = 'phone_cam7',
        Color = 'rgb(4,4,4)',
    },
    [91] = {
        Name = 'Dark fog',
        Source = 'SALTONSEA',
        Color = 'rgb(244,244,244)',
    },
    [92] = {
        Name = 'Dark fog 2',
        Source = 'WATER_cove',
        Color = 'rgb(244,244,244)',
    },
    [93] = {
        Name = 'Under water',
        Source = 'underwater_deep',
        Color = 'rgb(42,164,222)',
    },
    [94] = {
        Name = 'Soft pink',
        Source = 'TinyPink01',
        Color = 'rgb(224,124,222)',
    },
}
