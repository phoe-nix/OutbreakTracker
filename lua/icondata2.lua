local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            --1 .45 magazine
            x=0,
            y=0,
            width=48,
            height=48,

        },
        {
            --2 hg magazine
            x=48,
            y=0,
            width=48,
            height=48,

        },
        {
            --3 lucky coin
            x=96,
            y=0,
            width=48,
            height=48,

        },
        {
            --4 shooter
            x=144,
            y=0,
            width=48,
            height=48,

        },
        {
            --5 lighter
            x=192,
            y=0,
            width=48,
            height=48,

        },
        {
            --6 stun gun
            x=240,
            y=0,
            width=48,
            height=48,

        },
        {
            --7 charm
            x=288,
            y=0,
            width=48,
            height=48,

        },
        {
            --8 bandage
            x=336,
            y=0,
            width=48,
            height=48,

        },
        {
            --9 green herb
            x=384,
            y=0,
            width=48,
            height=48,

        },
        {
            --10 blue herb
            x=432,
            y=0,
            width=48,
            height=48,

        },
        {
            --11 red herb
            x=480,
            y=0,
            width=48,
            height=48,

        },
        {
            --12 mixed herb (G+G)
            x=528,
            y=0,
            width=48,
            height=48,

        },
        {
            --13 Mixed Herb (G+G+G)
            x=576,
            y=0,
            width=48,
            height=48,

        },
        {
            --14 Mixed Herb (G+R)
            x=624,
            y=0,
            width=48,
            height=48,

        },
        {
            --15 Mixed Herb (G+B)
            x=672,
            y=0,
            width=48,
            height=48,

        },
        {
            --16 Mixed Herb (G+R+B)
            x=720,
            y=0,
            width=48,
            height=48,

        },
        {
            --17 First Aid Spray
            x=768,
            y=0,
            width=48,
            height=48,

        },
        {
            --18 Recovery Pill (1)
            x=816,
            y=0,
            width=48,
            height=48,

        },
        {
            --19 Recovery Pill (3)
            x=864,
            y=0,
            width=48,
            height=48,

        },
        {
            --20 Hemostat (1)
            x=912,
            y=0,
            width=48,
            height=48,

        },
        {
            --21 Antidote (1)
            x=960,
            y=0,
            width=48,
            height=48,

        },
        {
            --22 Anti-virus (1)
            x=1008,
            y=0,
            width=48,
            height=48,

        },
        {
            --23 Anti-virus (3)
            x=1056,
            y=0,
            width=48,
            height=48,

        },
        {
            --24 Iron Pipe
            x=1104,
            y=0,
            width=48,
            height=48,

        },
        {
            --25 Handgun Rounds (10)
            x=1152,
            y=0,
            width=48,
            height=48,

        },
        {
            --26 Handgun Rounds (15)
            x=1200,
            y=0,
            width=48,
            height=48,

        },
        {
            --27 Handgun Rounds (20)
            x=1248,
            y=0,
            width=48,
            height=48,

        },
        {
            --28 Handgun Rounds (30)
            x=1296,
            y=0,
            width=48,
            height=48,

        },
        {
            --29 empty
            x=1344,
            y=0,
            width=48,
            height=48,

        },
    },

    sheetContentWidth = 1392,
    sheetContentHeight = 48
}

--9 Green Herb
--10 Blue Herb
--11 Red Herb
--12 Mixed Herb (G+G)
--13 Mixed Herb (G+G+G)
--14 Mixed Herb (G+R)
--15 Mixed Herb (G+B)
--16 Mixed Herb (G+R+B)
--17 First Aid Spray
--18 Recovery Pill (1)
--19 Recovery Pill (3)
--20 Hemostat (1)
--21 Antidote (1)
--22 Anti-virus (1)
--23 Anti-virus (3)
--24 Iron Pipe
--25 Handgun Rounds (10)
--26 Handgun Rounds (15)
--27 Handgun Rounds (20)
--28 Handgun Rounds (30)
--29 empty

SheetInfo.frameIndex =
{
	--
    ["Kevin"] = 1,
    ["Mark"] = 2,
    ["Jim"] = 3,
    ["George"] = 4,
    ["David"] = 5,
    ["Alyssa"] = 6,
    ["Yoko"] = 7,
    ["Cindy"] = 8,
    ["Unknown"] = 29,
    ["MACDOWELL"] = 20,	--20 Hemostat (1)
    ["RODRIGUEZ"] = 9,		--9 Green Herb
    ["CONRAD"] = 21,		--21 Antidote (1)
    ["HUNK:B"] = 28,		--28 Handgun Rounds (30)
    ["HUNK"] = 17,			--17 First Aid Spray
    ["MIGUEL"] = 27,		--27 Handgun Rounds (20)
    ["LUKE"] = 17,			--17 First Aid Spray
    ["ARNOLD"] = 24,		--24 Iron Pipe
    ["MATT"] = 24,			--24 Iron Pipe
    ["BILLY"] = 18,		--18 Recovery Pill (1)
    ["HARSH"] = 20,		--20 Hemostat (1)
    ["PETER"] = 22,		--22 Anti-virus (1)
    ["MARVIN"] = 20,		--20 Hemostat (1)
    ["FRED"] = 15,			--15 Mixed Herb (G+B)
    ["ANDY"] = 24,			--24 Iron Pipe
    ["JEAN"] = 10,			--10 Blue Herb
    ["TONY"] = 24,			--24 Iron Pipe
    ["PATRICK"] = 14,		--14 Mixed Herb (G+R)
    ["LLOYD"] = 15,		--15 Mixed Herb (G+B)
    ["AUSTIN"] = 24,		--24 Iron Pipe
    ["CLINT"] = 17,		--17 First Aid Spray
    ["BONE"] = 16,			--16 Mixed Herb (G+R+B)
    ["BOB"] = 25,			--25 Handgun Rounds (10)
    ["NATHAN"] = 13,		--13 Mixed Herb (G+G+G)
    ["SAMUEL"] = 24,		--24 Iron Pipe
    ["WILL"] = 18,			--18 Recovery Pill (1)
    ["ROGER"] = 12,		--12 Mixed Herb (G+G)
    ["CARTER"] = 22,		--22 Anti-virus (1)
    ["GREG"] = 23,			--23 Anti-virus (3)
    ["FROST"] = 10,		--10 Blue Herb
    ["FROST:B"] = 14,		--14 Mixed Herb (G+R)
    ["JAKE"] = 16,			--16 Mixed Herb (G+R+B)
    ["GARY"] = 17,			--17 First Aid Spray
    ["RICHARD"] = 14,		--14 Mixed Herb (G+R)
    ["MICKEY"] = 20,		--20 Hemostat (1)
    ["AL"] = 18,			--18 Recovery Pill (1)
    ["AXEMAN"] = 24,		--24 Iron Pipe
    ["AL:B"] = 13,			--13 Mixed Herb (G+G+G)
    ["BEN"] = 9,			--9 Green Herb
    ["REGAN"] = 21,		--21 Antidote (1)
    ["REGAN:B"] = 20,		--20 Hemostat (1)
    ["MONICA"] = 16,		--16 Mixed Herb (G+R+B)
    ["LINDA"] = 19,		--19 Recovery Pill (3)
    ["RITA"] = 26,			--26 Handgun Rounds (15)
    ["MARY"] = 18,			--18 Recovery Pill (1)
    ["KATE"] = 12,			--12 Mixed Herb (G+G)
    ["DANNY"] = 24,		--24 Iron Pipe
    ["DANNY:B"] = 17,		--17 First Aid Spray
    ["GILL"] = 15,			--15 Mixed Herb (G+B)
    ["GILL:B"] = 14,		--14 Mixed Herb (G+R)
    ["KEITH"] = 19,		--19 Recovery Pill (3)
    ["KURT"] = 24,			--24 Iron Pipe
    ["KURT:B"] = 20,		--20 Hemostat (1)
    ["GARY:B"] = 24,		--24 Iron Pipe
    ["AL:C"] = 13,			--13 Mixed Herb (G+G+G)
    ["DOROTHY"] = 10,		--10 Blue Herb
    ["YOKO:Z"] = 23,		--23 Anti-virus (3)
    ["RAYMOND"] = 28,		--28 Handgun Rounds (30)
    ["ARTHUR"] = 9,		--9 Green Herb
    ["AARON"] = 26,		--26 Handgun Rounds (15)
    ["DORIAN"] = 11,		--11 Red Herb
    ["ELLIOTT"] = 24,		--24 Iron Pipe
    ["ERIC"] = 27,			--27 Handgun Rounds (20)
    ["HARRY"] = 15,		--15 Mixed Herb (G+B)
    ["Mr.RED"] = 29,		--29 None
    ["Mr.BLUE"] = 29,		--29 None
    ["Mr.GREEN"] = 29,		--29 None
    ["Mr.GOLD"] = 29,		--29 None
    ["Mr.BLACK"] = 29,		--29 None
    ["KARL"] = 17,			--17 First Aid Spray
    ["DUSTIN"] = 26,		--26 Handgun Rounds (15)
    ["DEREK"] = 24,		--24 Iron Pipe
    ["Ms.WHITE"] = 29,		--29 None
    ["Ms.PEACH"] = 29,		--29 None
    ["Ms.WATER"] = 29,		--29 None
    ["LEN"] = 19,			--19 Recovery Pill (3)
    ["NICOLAS"] = 14,		--14 Mixed Herb (G+R)
    ["SEAN"] = 24,			--24 Iron Pipe
    ["PHILIP"] = 18,		--18 Recovery Pill (1)
    ["DON"] = 25,			--25 Handgun Rounds (10)
    ["MATTHEW"] = 24,		--24 Iron Pipe
    ["ROBERT"] = 15,		--15 Mixed Herb (G+B)
    ["CHUCK"] = 14,		--14 Mixed Herb (G+R)
    ["GINGER"] = 12,		--12 Mixed Herb (G+G)
    ["LAURA"] = 17,		--17 First Aid Spray
    ["AMELIA"] = 11,		--11 Red Herb
    ["ETHAN"] = 17,		--17 First Aid Spray
    ["HOWARD"] = 21,		--21 Antidote (1)
    ["ISAAC"] = 20,		--20 Hemostat (1)
    ["KATHY"] = 16,		--16 Mixed Herb (G+R+B)
    ["ELENA"] = 18,		--18 Recovery Pill (1)
    ["FRANK"] = 23,		--23 Anti-virus (3)
    ["RODNEY"] = 11,		--11 Red Herb
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
