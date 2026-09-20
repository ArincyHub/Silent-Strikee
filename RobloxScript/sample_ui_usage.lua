--
local v0 = {
	[1770 - (1749 + 20) ] = 1 + 0
};
local v1 = game:GetService("Players");
local v2 = game:GetService("TweenService");
local v3 = game:GetService("RunService");
local v4 = game:GetService("HttpService");
local v5 = v1.LocalPlayer;
local v6 = v5:WaitForChild("PlayerGui");
local v7 = game:GetService("VirtualUser");
pcall(function()
	if getconnections then
		for v603, v604 in pairs(getconnections(v5.Idled)) do
			if v604['Disable'] then
				v604:Disable();
			end
		end
	end
end);
v5.Idled:Connect(function()
	local v206 = 1322 - (1249 + 73) ;
	while true do
		if (v206 == (0 + 0)) then
			pcall(function()
				v7:CaptureController();
				v7:ClickButton2(Vector2.new());
			end);
			print("🛡️ Anti-AFK Worked: ป้องกันการโดนเตะ 20 นาทีเรียบร้อย!");
			break;
		end
	end
end);
local v8 = v6;
for v207, v208 in pairs(v8:GetChildren()) do
	if (v208.Name == "FARTEZ_LUCKY_HUB") then
		v208:Destroy();
	end
end
local v9 = {
	Background = Color3.fromRGB(1150 - (466 + 679), 11 - 6, 22 - 14),
	Surface = Color3.fromRGB(1915 - (106 + 1794), 15, 7 + 13),
	SurfaceLight = Color3.fromRGB(25, 25, 9 + 26),
	Accent = Color3.fromRGB(11 - 7, 549 - 346, 155 - (4 + 110)),
	Text = Color3.fromRGB(255, 839 - (57 + 527), 255),
	TextDim = Color3.fromRGB(1577 - (41 + 1386), 150, 150),
	Success = Color3.fromRGB(4, 203, 41)
};
local v10 = Instance.new("ScreenGui");
v10.Name = "FARTEZ_LUCKY_HUB";
v10.ResetOnSpawn = false;
v10.Parent = v8;
local v14 = Instance.new("ImageButton", v10);
v14.Size = UDim2.new(103 - (17 + 86), 34 + 16, 0, 50);
v14.Position = UDim2.new(0 - 0, 15, 0 - 0, 316 - (122 + 44));
v14.BackgroundColor3 = v9.Surface;
v14.Image = "rbxthumb://type=Asset&id=117149073945265&w=150&h=150";
v14.Draggable = true;
Instance.new("UICorner", v14).CornerRadius = UDim.new(0.5 - 0, 0 - 0);
local v22 = Instance.new("UIStroke", v14);
v22.Thickness = 2 + 0 ;
v22.Color = v9.Accent;
local v26 = Instance.new("Frame", v10);
v26.Size = UDim2.new(0 + 0, 628 - 318, 0, 320);
v26.Position = UDim2.new(0.5, - (220 - (30 + 35)), 0.5 + 0, - (1467 - (1043 + 214)));
v26.BackgroundColor3 = v9.Background;
v26.BorderSizePixel = 0 - 0 ;
v26.Active = true;
v26.Draggable = true;
Instance.new("UICorner", v26).CornerRadius = UDim.new(1212 - (323 + 889), 31 - 19);
local v35 = Instance.new("Frame", v26);
v35.Size = UDim2.new(581 - (361 + 219), 320 - (53 + 267), 0, 12 + 38);
v35.BackgroundColor3 = v9.Surface;
v35.BorderSizePixel = 0;
local v39 = Instance.new("ImageLabel", v35);
v39.Size = UDim2.new(413 - (15 + 398), 36, 0, 1018 - (18 + 964));
v39.Position = UDim2.new(0 - 0, 10, 0.5 + 0, - (12 + 6));
v39.BackgroundTransparency = 1;
v39.Image = "rbxthumb://type=Asset&id=117149073945265&w=150&h=150";
Instance.new("UICorner", v39).CornerRadius = UDim.new(850.2 - (20 + 830), 0);
local v45 = Instance.new("TextLabel", v35);
v45.Size = UDim2.new(0 + 0, 160, 126 - (116 + 10), 2 + 20);
v45.Position = UDim2.new(0, 790 - (542 + 196), 0 - 0, 2 + 3);
v45.BackgroundTransparency = 1 + 0 ;
v45.Text = "                                          PC     2.0   Bata";
v45.TextColor3 = v9.Text;
v45.TextSize = 10;
v45.Font = Enum.Font.GothamBold;
v45.TextXAlignment = Enum.TextXAlignment.Left;
local v57 = Instance.new("TextLabel", v35);
v57.Size = UDim2.new(0, 160, 0 + 0, 57 - 35);
v57.Position = UDim2.new(0, 52, 0 - 0, 1556 - (1126 + 425));
v57.BackgroundTransparency = 406 - (118 + 287) ;
v57.Text = "FARTEZ HUB";
v57.TextColor3 = v9.Text;
v57.TextSize = 66 - 49 ;
v57.Font = Enum.Font.GothamBold;
v57.TextXAlignment = Enum.TextXAlignment.Left;
local v66 = Instance.new("TextLabel", v35);
v66.Size = UDim2.new(0, 160, 0, 1137 - (118 + 1003));
v66.Position = UDim2.new(0, 52, 0 - 0, 26);
v66.BackgroundTransparency = 378 - (142 + 235) ;
v66.Text = "Kick a Lucky Block";
v66.TextColor3 = v9.Accent;
v66.TextSize = 45 - 35 ;
v66.Font = Enum.Font.GothamSemibold;
v66.TextXAlignment = Enum.TextXAlignment.Left;
local v76 = Instance.new("Frame", v26);
v76.Size = UDim2.new(1 + 0, - (993 - (553 + 424)), 0 - 0, 32 + 4);
v76.Position = UDim2.new(0, 8 + 0, 0 + 0, 24 + 32);
v76.BackgroundColor3 = v9.Surface;
Instance.new("UICorner", v76).CornerRadius = UDim.new(0, 5 + 3);
local v81 = Instance.new("UIListLayout", v76);
v81.FillDirection = Enum.FillDirection.Horizontal;
v81.HorizontalAlignment = Enum.HorizontalAlignment.Center;
v81.VerticalAlignment = Enum.VerticalAlignment.Center;
v81.Padding = UDim.new(0 - 0, 2);
local v89 = Instance.new("Frame", v26);
v89.Size = UDim2.new(1, - 16, 2 - 1, - 110);
v89.Position = UDim2.new(0, 17 - 9, 0 + 0, 98);
v89.BackgroundColor3 = v9.Surface;
v89.ClipsDescendants = true;
Instance.new("UICorner", v89).CornerRadius = UDim.new(0, 48 - 38);
local v95 = {};
local function v96(v209)
	local v210 = 753 - (239 + 514) ;
	local v211;
	local v212;
	local v213;
	local v214;
	while true do
		if (v210 == (3 + 5)) then
			Instance.new("UIPadding", v213).PaddingBottom = UDim.new(1329 - (797 + 532), 9 + 3);
			table.insert(v95, {
				Btn = v211,
				Page = v213
			});
			v211.MouseButton1Click:Connect(function()
				for v780, v781 in pairs(v95) do
					v781.Page.Visible = false;
					v2:Create(v781.Btn, TweenInfo.new(0.2), {
						BackgroundColor3 = v9.SurfaceLight,
						TextColor3 = v9.TextDim
					}):Play();
				end
				v213.Visible = true;
				v2:Create(v211, TweenInfo.new(0.2 + 0), {
					BackgroundColor3 = v9.Accent,
					TextColor3 = Color3.new(0 - 0, 0, 1202 - (373 + 829))
				}):Play();
			end);
			v210 = 740 - (476 + 255) ;
		end
		if (v210 == 6) then
			v213.AutomaticCanvasSize = Enum.AutomaticSize.Y;
			v213.Visible = false;
			v214 = Instance.new("UIListLayout", v213);
			v210 = 7;
		end
		if (v210 == 1) then
			v211.BackgroundColor3 = v9.SurfaceLight;
			v211.Text = v209;
			v211.TextColor3 = v9.TextDim;
			v210 = 2;
		end
		if (v210 == (1130 - (369 + 761))) then
			v211 = Instance.new("TextButton", v76);
			v211.Size = UDim2.new(0 + 0, 0 - 0, 0, 52 - 24);
			v211.AutomaticSize = Enum.AutomaticSize.X;
			v210 = 1;
		end
		if (v210 == (247 - (64 + 174))) then
			return v213;
		end
		if (v210 == (1 + 6)) then
			v214.Padding = UDim.new(0 - 0, 346 - (144 + 192));
			v214.HorizontalAlignment = Enum.HorizontalAlignment.Center;
			Instance.new("UIPadding", v213).PaddingTop = UDim.new(0, 228 - (42 + 174));
			v210 = 8;
		end
		if (v210 == 5) then
			v213.BackgroundTransparency = 1;
			v213.ScrollBarThickness = 2 + 0 ;
			v213.ScrollBarImageColor3 = v9.Accent;
			v210 = 5 + 1 ;
		end
		if (v210 == (2 + 1)) then
			v212 = Instance.new("UIPadding", v211);
			v212.PaddingLeft = UDim.new(1504 - (363 + 1141), 6);
			v212.PaddingRight = UDim.new(0, 1586 - (1183 + 397));
			v210 = 4;
		end
		if (v210 == (5 - 3)) then
			v211.TextSize = 9;
			v211.Font = Enum.Font.GothamBold;
			Instance.new("UICorner", v211).CornerRadius = UDim.new(0, 5 + 1);
			v210 = 3 + 0 ;
		end
		if (v210 == (1979 - (1913 + 62))) then
			v213 = Instance.new("ScrollingFrame", v89);
			v213.Name = v209 .. "Page" ;
			v213.Size = UDim2.new(1 + 0, 0, 2 - 1, 1933 - (565 + 1368));
			v210 = 5;
		end
	end
end
local v97 = v96("Main");
local v98 = v96("Collect");
local v99 = v96("UpG");
local v100 = v96("Configs");
local v101 = v96("KickZone");
local v102 = v96("Sell");
local v103 = v96("Info");
local v104 = {};
local v105 = {};
local v106 = {};
local function v107(v215, v216, v217)
	local v218 = Instance.new("TextButton", v215);
	v218.Size = UDim2.new(0, 977 - 717, 1661 - (1477 + 184), 43 - 11);
	v218.BackgroundColor3 = v9.SurfaceLight;
	v218.Text = v216;
	v218.TextColor3 = v9.Text;
	v218.Font = Enum.Font.GothamBold;
	v218.TextSize = 12;
	Instance.new("UICorner", v218).CornerRadius = UDim.new(0 + 0, 862 - (564 + 292));
	v218.MouseButton1Click:Connect(v217);
end
local function v108(v229, v230, v231, v232)
	local v233 = 0 - 0 ;
	local v234;
	local v235;
	local v236;
	local v237;
	while true do
		if (v233 == (2 - 1)) then
			v235 = Instance.new("TextLabel", v234);
			v235.Size = UDim2.new(305 - (244 + 60), - (39 + 11), 1, 476 - (41 + 435));
			v235.Position = UDim2.new(1001 - (938 + 63), 8 + 2, 1125 - (936 + 189), 0 + 0);
			v235.BackgroundTransparency = 1;
			v233 = 2;
		end
		if (v233 == (1616 - (1565 + 48))) then
			v235.TextSize = 11;
			v236 = Instance.new("TextButton", v234);
			v236.Size = UDim2.new(0 + 0, 1158 - (782 + 356), 267 - (176 + 91), 52 - 32);
			v236.Position = UDim2.new(1 - 0, - (1122 - (975 + 117)), 1875.5 - (157 + 1718), - 10);
			v233 = 4;
		end
		if (2 == v233) then
			v235.Text = v230;
			v235.TextColor3 = v9.Text;
			v235.Font = Enum.Font.GothamBold;
			v235.TextXAlignment = Enum.TextXAlignment.Left;
			v233 = 3 + 0 ;
		end
		if (v233 == 0) then
			v234 = Instance.new("Frame", v229);
			v234.Size = UDim2.new(0, 260, 0 - 0, 109 - 77);
			v234.BackgroundColor3 = v9.SurfaceLight;
			Instance.new("UICorner", v234).CornerRadius = UDim.new(0, 1024 - (697 + 321));
			v233 = 2 - 1 ;
		end
		if (v233 == 5) then
			v237 = false;
			v105[v231] = function(v734)
				v237 = v734;
				v236.BackgroundColor3 = (v237 and v9.Accent) or v9.Surface ;
				v104[v231] = v237;
				v232(v237);
			end;
			v236.MouseButton1Click:Connect(function()
				v105[v231]( not v237);
			end);
			v104[v231] = false;
			break;
		end
		if (v233 == (8 - 4)) then
			v236.BackgroundColor3 = v9.Surface;
			v236.Text = "";
			Instance.new("UICorner", v236).CornerRadius = UDim.new(0, 8 - 4);
			Instance.new("UIStroke", v236).Color = v9.Accent;
			v233 = 5;
		end
	end
end
local function v109(v238, v239, v240, v241, v242)
	local v243 = Instance.new("Frame", v238);
	v243.Size = UDim2.new(0, 260, 0 + 0, 59 - 27);
	v243.BackgroundColor3 = v9.SurfaceLight;
	v243.ClipsDescendants = true;
	Instance.new("UICorner", v243).CornerRadius = UDim.new(0 - 0, 1233 - (322 + 905));
	local v249 = v240[612 - (602 + 9) ];
	local v250 = Instance.new("TextButton", v243);
	v250.Size = UDim2.new(1190 - (449 + 740), 0, 872 - (826 + 46), 979 - (245 + 702));
	v250.BackgroundTransparency = 3 - 2 ;
	v250.Text = "  " .. v239 .. ": " .. v249 .. "  ▼" ;
	v250.TextColor3 = v9.Accent;
	v250.Font = Enum.Font.GothamBold;
	v250.TextSize = 11;
	v250.TextXAlignment = Enum.TextXAlignment.Left;
	local v261 = Instance.new("ScrollingFrame", v243);
	v261.Size = UDim2.new(1 + 0, 1898 - (260 + 1638), 441 - (382 + 58), - 32);
	v261.Position = UDim2.new(0 - 0, 0 + 0, 0 - 0, 94 - 62);
	v261.BackgroundTransparency = 1206 - (902 + 303) ;
	v261.ScrollBarThickness = 3 - 1 ;
	v261.AutomaticCanvasSize = Enum.AutomaticSize.Y;
	local v268 = Instance.new("UIListLayout", v261);
	v268.SortOrder = Enum.SortOrder.LayoutOrder;
	local v271 = false;
	local v272 = math.min( # v240 * 30, 361 - 211);
	v105[v241] = function(v514)
		if (v514 and table.find(v240, v514)) then
			local v658 = 0 + 0 ;
			while true do
				if (v658 == (1691 - (1121 + 569))) then
					v104[v241] = v249;
					v242(v249);
					break;
				end
				if ((214 - (22 + 192)) == v658) then
					v249 = v514;
					v250.Text = "  " .. v239 .. ": " .. v249 .. "  ▼" ;
					v658 = 684 - (483 + 200) ;
				end
			end
		end
	end;
	v250.MouseButton1Click:Connect(function()
		local v515 = 1463 - (1404 + 59) ;
		while true do
			if (v515 == (0 - 0)) then
				v271 = not v271;
				if v271 then
					v2:Create(v243, TweenInfo.new(0.2 - 0), {
						Size = UDim2.new(765 - (468 + 297), 822 - (334 + 228), 0 - 0, (73 - 41) + v272)
					}):Play();
				else
					v2:Create(v243, TweenInfo.new(0.2 - 0), {
						Size = UDim2.new(0 + 0, 496 - (141 + 95), 0, 32 + 0)
					}):Play();
				end
				break;
			end
		end
	end);
	for v516, v517 in ipairs(v240) do
		local v518 = 0;
		local v519;
		while true do
			if (v518 == (9 - 5)) then
				v519.MouseButton1Click:Connect(function()
					local v783 = 0 - 0 ;
					while true do
						if (v783 == (1 + 0)) then
							v105[v241](v517);
							break;
						end
						if (v783 == (0 - 0)) then
							v271 = false;
							v2:Create(v243, TweenInfo.new(0.2), {
								Size = UDim2.new(0 + 0, 136 + 124, 0, 44 - 12)
							}):Play();
							v783 = 1;
						end
					end
				end);
				break;
			end
			if (v518 == 2) then
				v519.TextColor3 = v9.TextDim;
				v519.Font = Enum.Font.GothamBold;
				v518 = 3;
			end
			if (v518 == (2 + 1)) then
				v519.TextSize = 11;
				v519.TextXAlignment = Enum.TextXAlignment.Left;
				v518 = 4;
			end
			if (v518 == 0) then
				v519 = Instance.new("TextButton", v261);
				v519.Size = UDim2.new(1, - (173 - (92 + 71)), 0 + 0, 50 - 20);
				v518 = 766 - (574 + 191) ;
			end
			if (v518 == 1) then
				v519.BackgroundColor3 = v9.Surface;
				v519.Text = "    " .. v517 ;
				v518 = 2 + 0 ;
			end
		end
	end
	v104[v241] = v240[2 - 1 ];
end
local function v110(v276, v277, v278, v279, v280)
	local v281 = Instance.new("Frame", v276);
	v281.Size = UDim2.new(0, 133 + 127, 0, 32);
	v281.BackgroundColor3 = v9.SurfaceLight;
	v281.ClipsDescendants = true;
	Instance.new("UICorner", v281).CornerRadius = UDim.new(0, 855 - (254 + 595));
	local v287 = {};
	for v520, v521 in ipairs(v278) do
		v287[v521] = false;
	end
	local v288 = Instance.new("TextButton", v281);
	v288.Size = UDim2.new(1, 126 - (55 + 71), 0 - 0, 1822 - (573 + 1217));
	v288.BackgroundTransparency = 2 - 1 ;
	v288.Text = "  " .. v277 .. ": Any  ▼" ;
	v288.TextColor3 = v9.Accent;
	v288.Font = Enum.Font.GothamBold;
	v288.TextSize = 11;
	v288.TextXAlignment = Enum.TextXAlignment.Left;
	local v299 = Instance.new("ScrollingFrame", v281);
	v299.Size = UDim2.new(1 + 0, 0 - 0, 940 - (714 + 225), - (93 - 61));
	v299.Position = UDim2.new(0 - 0, 0 + 0, 0 - 0, 838 - (118 + 688));
	v299.BackgroundTransparency = 49 - (25 + 23) ;
	v299.ScrollBarThickness = 1 + 1 ;
	v299.AutomaticCanvasSize = Enum.AutomaticSize.Y;
	local v306 = Instance.new("UIListLayout", v299);
	v306.SortOrder = Enum.SortOrder.LayoutOrder;
	local v309 = false;
	local v310 = math.min( # v278 * (1916 - (927 + 959)), 505 - 355);
	local v311 = {};
	local function v312()
		local v523 = 732 - (16 + 716) ;
		for v591, v592 in pairs(v287) do
			if v592 then
				v523 = v523 + 1 ;
			end
		end
		if (v523 == (0 - 0)) then
			v288.Text = "  " .. v277 .. ": Any  " .. ((v309 and "▲") or "▼") ;
		else
			v288.Text = "  " .. v277 .. ": " .. v523 .. " Selected  " .. ((v309 and "▲") or "▼") ;
		end
		v104[v279] = v287;
		v280(v287);
	end
	v105[v279] = function(v525)
		if (type(v525) == "table") then
			local v661 = 97 - (11 + 86) ;
			while true do
				if (v661 == (2 - 1)) then
					v312();
					break;
				end
				if (v661 == 0) then
					for v832, v833 in pairs(v525) do
						if (v287[v832] ~= nil) then
							v287[v832] = v833;
						end
					end
					for v834, v835 in pairs(v311) do
						v835.TextColor3 = (v287[v834] and v9.Success) or v9.TextDim ;
					end
					v661 = 286 - (175 + 110) ;
				end
			end
		end
	end;
	v288.MouseButton1Click:Connect(function()
		v309 = not v309;
		if v309 then
			v2:Create(v281, TweenInfo.new(0.2 - 0), {
				Size = UDim2.new(0 - 0, 260, 1796 - (503 + 1293), 32 + v310)
			}):Play();
		else
			v2:Create(v281, TweenInfo.new(0.2), {
				Size = UDim2.new(0 - 0, 189 + 71, 0, 1093 - (810 + 251))
			}):Play();
		end
		v312();
	end);
	for v526, v527 in ipairs(v278) do
		local v528 = 0;
		local v529;
		while true do
			if (v528 == (0 + 0)) then
				v529 = Instance.new("TextButton", v299);
				v529.Size = UDim2.new(1 + 0, - (10 + 0), 0, 563 - (43 + 490));
				v528 = 734 - (711 + 22) ;
			end
			if (v528 == (3 - 2)) then
				v529.BackgroundColor3 = v9.Surface;
				v529.Text = "    " .. v527 ;
				v528 = 2;
			end
			if (4 == v528) then
				v311[v527] = v529;
				v529.MouseButton1Click:Connect(function()
					local v784 = 0;
					while true do
						if (v784 == (859 - (240 + 619))) then
							v287[v527] = not v287[v527];
							v529.TextColor3 = (v287[v527] and v9.Success) or v9.TextDim ;
							v784 = 1 + 0 ;
						end
						if (v784 == 1) then
							v312();
							break;
						end
					end
				end);
				break;
			end
			if (3 == v528) then
				v529.TextSize = 11;
				v529.TextXAlignment = Enum.TextXAlignment.Left;
				v528 = 5 - 1 ;
			end
			if (v528 == 2) then
				v529.TextColor3 = v9.TextDim;
				v529.Font = Enum.Font.GothamBold;
				v528 = 3;
			end
		end
	end
	v104[v279] = v287;
end
local function v111(v315, v316, v317, v318, v319, v320, v321)
	local v322 = Instance.new("Frame", v315);
	v322.Size = UDim2.new(0, 18 + 242, 1744 - (1344 + 400), 32);
	v322.BackgroundColor3 = v9.SurfaceLight;
	v322.ClipsDescendants = true;
	Instance.new("UICorner", v322).CornerRadius = UDim.new(405 - (255 + 150), 5 + 1);
	local v328 = {};
	for v530, v531 in ipairs(v317) do
		v328[v531] = false;
	end
	local v329 = Instance.new("TextButton", v322);
	v329.Size = UDim2.new(1, 0 + 0, 0 - 0, 103 - 71);
	v329.BackgroundTransparency = 1740 - (404 + 1335) ;
	v329.Text = "  " .. v316 .. ": Any  ▼" ;
	v329.TextColor3 = v9.Accent;
	v329.Font = Enum.Font.GothamBold;
	v329.TextSize = 417 - (183 + 223) ;
	v329.TextXAlignment = Enum.TextXAlignment.Left;
	local v340 = Instance.new("ScrollingFrame", v322);
	v340.Size = UDim2.new(1 - 0, 0, 1 + 0, - (12 + 20));
	v340.Position = UDim2.new(337 - (10 + 327), 0, 0 + 0, 370 - (118 + 220));
	v340.BackgroundTransparency = 1 + 0 ;
	v340.ScrollBarThickness = 451 - (108 + 341) ;
	v340.AutomaticCanvasSize = Enum.AutomaticSize.Y;
	local v347 = Instance.new("UIListLayout", v340);
	v347.SortOrder = Enum.SortOrder.LayoutOrder;
	local v350 = false;
	local v351 = math.min( # v317 * (14 + 16), 150);
	local v352 = {};
	if not v106[v319] then
		v106[v319] = {};
	end
	local function v353()
		local v533 = 0 - 0 ;
		for v594, v595 in pairs(v320) do
			if v595 then
				v533 = v533 + 1 ;
			end
		end
		if (v533 == (1493 - (711 + 782))) then
			v329.Text = "  " .. v316 .. ": Any  " .. ((v350 and "▲") or "▼") ;
		else
			v329.Text = "  " .. v316 .. ": " .. v533 .. " Selected  " .. ((v350 and "▲") or "▼") ;
		end
	end
	v106[v319][v318] = v353;
	local function v355()
		for v596, v597 in pairs(v106[v319]) do
			v597();
		end
		v104[v318] = v328;
		v321(v328);
	end
	v105[v318] = function(v535)
		if (type(v535) == "table") then
			local v664 = 0;
			while true do
				if (v664 == (1 - 0)) then
					v355();
					break;
				end
				if (v664 == (469 - (270 + 199))) then
					for v837, v838 in pairs(v535) do
						if (v328[v837] ~= nil) then
							local v902 = 0 + 0 ;
							while true do
								if (v902 == (1819 - (580 + 1239))) then
									v328[v837] = v838;
									v320[v837] = v838;
									break;
								end
							end
						end
					end
					for v839, v840 in pairs(v352) do
						v840.TextColor3 = (v328[v839] and v9.Success) or v9.TextDim ;
					end
					v664 = 2 - 1 ;
				end
			end
		end
	end;
	v329.MouseButton1Click:Connect(function()
		local v536 = 0 + 0 ;
		while true do
			if (v536 == (0 + 0)) then
				v350 = not v350;
				if v350 then
					v2:Create(v322, TweenInfo.new(0.2 + 0), {
						Size = UDim2.new(0 - 0, 260, 0, 20 + 12 + v351)
					}):Play();
				else
					v2:Create(v322, TweenInfo.new(0.2), {
						Size = UDim2.new(1167 - (645 + 522), 2050 - (1010 + 780), 0 + 0, 32)
					}):Play();
				end
				v536 = 1;
			end
			if (v536 == (4 - 3)) then
				v353();
				break;
			end
		end
	end);
	for v537, v538 in ipairs(v317) do
		local v539 = Instance.new("TextButton", v340);
		v539.Size = UDim2.new(2 - 1, - (1846 - (1045 + 791)), 0 - 0, 45 - 15);
		v539.BackgroundColor3 = v9.Surface;
		v539.Text = "    " .. v538 ;
		v539.TextColor3 = v9.TextDim;
		v539.Font = Enum.Font.GothamBold;
		v539.TextSize = 516 - (351 + 154) ;
		v539.TextXAlignment = Enum.TextXAlignment.Left;
		v352[v538] = v539;
		v539.MouseButton1Click:Connect(function()
			v328[v538] = not v328[v538];
			v320[v538] = v328[v538];
			v539.TextColor3 = (v328[v538] and v9.Success) or v9.TextDim ;
			v355();
		end);
	end
	v104[v318] = v328;
end
local function v112(v358, v359, v360, v361, v362, v363, v364)
	local v365 = Instance.new("Frame", v358);
	v365.Size = UDim2.new(0, 260, 1574 - (1281 + 293), 32);
	v365.BackgroundColor3 = v9.SurfaceLight;
	Instance.new("UICorner", v365).CornerRadius = UDim.new(0, 6);
	local v370 = Instance.new("TextLabel", v365);
	v370.Size = UDim2.new(266 - (28 + 238), 245 - 135, 1560 - (1381 + 178), 0 + 0);
	v370.Position = UDim2.new(0 + 0, 10, 0 + 0, 0 - 0);
	v370.BackgroundTransparency = 1 + 0 ;
	v370.Text = v359;
	v370.TextColor3 = v9.Text;
	v370.Font = Enum.Font.GothamBold;
	v370.TextXAlignment = Enum.TextXAlignment.Left;
	v370.TextSize = 481 - (381 + 89) ;
	local v382 = Instance.new("Frame", v365);
	v382.Size = UDim2.new(0, 116 + 14, 1, 0 + 0);
	v382.Position = UDim2.new(1, - (239 - 99), 1156 - (1074 + 82), 0 - 0);
	v382.BackgroundTransparency = 1785 - (214 + 1570) ;
	local v386 = Instance.new("TextButton", v382);
	v386.Size = UDim2.new(1455 - (990 + 465), 28, 0 + 0, 11 + 13);
	v386.Position = UDim2.new(0, 0, 0.5, - 12);
	v386.BackgroundColor3 = v9.Surface;
	v386.Text = "-";
	v386.TextColor3 = v9.Text;
	v386.Font = Enum.Font.GothamBold;
	Instance.new("UICorner", v386).CornerRadius = UDim.new(0, 4);
	local v395 = Instance.new("TextBox", v382);
	v395.Size = UDim2.new(0 + 0, 236 - 176, 1726 - (1668 + 58), 650 - (512 + 114));
	v395.Position = UDim2.new(0 - 0, 34, 0.5 - 0, - (41 - 29));
	v395.BackgroundColor3 = v9.Surface;
	v395.Text = tostring(v362);
	v395.TextColor3 = v9.Accent;
	v395.Font = Enum.Font.GothamBold;
	v395.TextSize = 11;
	Instance.new("UICorner", v395).CornerRadius = UDim.new(0, 2 + 2);
	local v405 = Instance.new("TextButton", v382);
	v405.Size = UDim2.new(0 + 0, 28, 0 + 0, 24);
	v405.Position = UDim2.new(0, 337 - 237, 0.5, - (2006 - (109 + 1885)));
	v405.BackgroundColor3 = v9.Surface;
	v405.Text = "+";
	v405.TextColor3 = v9.Text;
	v405.Font = Enum.Font.GothamBold;
	Instance.new("UICorner", v405).CornerRadius = UDim.new(0, 1473 - (1269 + 200));
	local v413 = v362;
	v105[v363] = function(v552)
		v552 = tonumber(v552) or v362 ;
		v552 = math.clamp(v552, v360, v361);
		v413 = v552;
		v395.Text = tostring(v413);
		v104[v363] = v413;
		v364(v413);
	end;
	v386.MouseButton1Click:Connect(function()
		v105[v363](v413 - (1 - 0));
	end);
	v405.MouseButton1Click:Connect(function()
		v105[v363](v413 + (816 - (98 + 717)));
	end);
	v395.FocusLost:Connect(function()
		v105[v363](v395.Text);
	end);
	v104[v363] = v362;
end
local function v113(v416, v417, v418, v419, v420)
	local v421 = 826 - (802 + 24) ;
	local v422;
	local v423;
	local v424;
	while true do
		if (v421 == (0 - 0)) then
			v422 = Instance.new("Frame", v416);
			v422.Size = UDim2.new(0 - 0, 39 + 221, 0 + 0, 9 + 41);
			v422.BackgroundColor3 = v9.SurfaceLight;
			v421 = 1 + 0 ;
		end
		if (v421 == 4) then
			v423.TextSize = 30 - 19 ;
			v424 = Instance.new("TextBox", v422);
			v424.Size = UDim2.new(3 - 2, - (8 + 12), 0 + 0, 19 + 3);
			v421 = 4 + 1 ;
		end
		if (v421 == (1 + 1)) then
			v423.Position = UDim2.new(1433 - (797 + 636), 48 - 38, 0, 1621 - (1427 + 192));
			v423.BackgroundTransparency = 1;
			v423.Text = v417;
			v421 = 2 + 1 ;
		end
		if (v421 == (13 - 7)) then
			v424.Text = "";
			v424.PlaceholderText = v418;
			v424.Font = Enum.Font.GothamBold;
			v421 = 7 + 0 ;
		end
		if (v421 == (1 + 0)) then
			Instance.new("UICorner", v422).CornerRadius = UDim.new(326 - (192 + 134), 1282 - (316 + 960));
			v423 = Instance.new("TextLabel", v422);
			v423.Size = UDim2.new(1, - (12 + 8), 0 + 0, 19 + 1);
			v421 = 7 - 5 ;
		end
		if (v421 == (560 - (83 + 468))) then
			v424.FocusLost:Connect(function()
				v105[v419](v424.Text);
			end);
			v104[v419] = "";
			break;
		end
		if (v421 == (1814 - (1202 + 604))) then
			v424.ClipsDescendants = true;
			Instance.new("UICorner", v424).CornerRadius = UDim.new(0, 18 - 14);
			v105[v419] = function(v760)
				local v761 = 0 - 0 ;
				while true do
					if (v761 == (2 - 1)) then
						v420(v760);
						break;
					end
					if (v761 == (325 - (45 + 280))) then
						v424.Text = v760;
						v104[v419] = v760;
						v761 = 1 + 0 ;
					end
				end
			end;
			v421 = 9;
		end
		if (v421 == (3 + 0)) then
			v423.TextColor3 = v9.Text;
			v423.Font = Enum.Font.GothamBold;
			v423.TextXAlignment = Enum.TextXAlignment.Left;
			v421 = 2 + 2 ;
		end
		if (v421 == (3 + 2)) then
			v424.Position = UDim2.new(0 + 0, 18 - 8, 1911 - (340 + 1571), 9 + 13);
			v424.BackgroundColor3 = v9.Surface;
			v424.TextColor3 = v9.Accent;
			v421 = 6;
		end
		if (v421 == (1779 - (1733 + 39))) then
			v424.TextSize = 27 - 17 ;
			v424.TextXAlignment = Enum.TextXAlignment.Left;
			v424.ClearTextOnFocus = false;
			v421 = 1042 - (125 + 909) ;
		end
	end
end
local v114 = "";
local v115 = false;
local v116 = {};
local function v117(v425, v426, v427, v428)
	if (v114 == "") then
		return;
	end
	if ( not v115 and not v428) then
		return;
	end
	local v429 = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request ;
	if v429 then
		local v601 = 0;
		local v602;
		while true do
			if (v601 == (1948 - (1096 + 852))) then
				v602 = {
					embeds = {
						{
							title = v425,
							description = v426,
							type = "rich",
							color = v427,
							footer = {
								text = "FARTEZ HUB | " .. os.date("%X")
							}
						}
					}
				};
				task.spawn(function()
					pcall(function()
						v429({
							Url = v114,
							Method = "POST",
							Headers = {
								["Content-Type"] = "application/json"
							},
							Body = v4:JSONEncode(v602)
						});
					end);
				end);
				break;
			end
		end
	end
end
local v118 = {
	Common = {
		"Noobini Pizzanini",
		"Tim Cheese",
		"LiriIi LariIa",
		"Talpa Di Fero",
		"Fruli Frula",
		"Svinina Bombardino",
		"Pipi Kiwi"
	},
	Rare = {
		"Gangster Footera",
		"Bobrito Bandito",
		"Boneca Ambalabu",
		"Ta Ta Ta Ta Sahur",
		"Ballerina Cappuccina",
		"Brr Brr Patapim",
		"Cappuccino Assassino",
		"Cacto Hipopotamo"
	},
	Epic = {
		"Madung",
		"Waterdino",
		"Pesto Mortioni",
		"Pannaburro",
		"Mangolini Parrocini",
		"Orcalero",
		"John Pork",
		"Gattatino Nyanino"
	},
	Legendary = {
		"Chimpanzini Bananini",
		"Plan Red",
		"Plan Blue",
		"Capi Taco",
		"Trulimero Trulicana",
		"Bambini Crostini",
		"Elefantucci Bananucci",
		"Bananita Dolphinita",
		"Salamino Pinguino"
	},
	Mythic = {
		"Penguino Cocosino",
		"67",
		"Burbaloni Luliloli",
		"Chef Crabracadabra",
		"Capybara Eggplant",
		"Bangello",
		"Elefanto Frigo",
		"Rinooccio Veidini",
		"Glorbo Fruttodrillo"
	},
	Godly = {
		"Udin Din Din Dun",
		"Pandaccini Bananini",
		"Octopusini Bluberini",
		"Strawberelli Flamingelli",
		"Sigma Boy",
		"Frigo Camelo",
		"Orangutini Ananasini",
		"Rhino Toasterino",
		"Bombardiro Crocodilo"
	},
	Secret = {
		"Bombini Gusini",
		"Tuff Toucan",
		"Fryuro",
		"Burguro",
		"Guest666",
		"Zibra Zubra Zibralini",
		"Cavallo Virtuso",
		"Gorillo Watermelondrillo",
		"Cocofanto Elefanto"
	},
	Divine = {
		"Girafa Celeste",
		"Tralalero Tralala",
		"Tralalerita Tralala",
		"Peant jarro",
		"Dipperi Chiperini",
		"Rexosaurus",
		"1X1X1X1",
		"Matteo"
	},
	Hacked = {
		"Alessio",
		"Tripi Tropi Tropa Tripa",
		"Torrtuginni Dragonfruitini",
		"Tictac Sahur",
		"Cactus Pingu",
		"Los Primos Blue",
		"La Vacca Saturno Saturnita",
		"Agarrini La Palini"
	},
	OG = {
		"Karkerkar Kurkur",
		"Compactororni Diskaloni",
		"Blackhole Goat",
		"Cappuccino Clownino",
		"Nuclearo Dinossauro",
		"Los Nooo My Hotspotsitos",
		"Chillin Chilli",
		"Crazylone Pizaione",
		"Corn Sahur",
		"Meowl",
		"Strawberry Elephant"
	},
	Celestial = {
		"Dragonfrutina Dolphinita",
		"Guerriro Digitale",
		"Chicleteira Bicicleteira",
		"Pot Hotspot",
		"Krupuk Pagi Pagi",
		"Beluga Beluga",
		"Tralaledon",
		"Anpalı Babel",
		"Ketupat Kepat",
		"Mastodontico Telepiedone"
	},
	Eternal = {
		"Professora 67",
		"Astro Tim",
		"Baba Yaga",
		"Kicky"
	}
};
local v119 = {
	"Common",
	"Rare",
	"Epic",
	"Legendary",
	"Mythic",
	"Godly",
	"Secret",
	"Divine",
	"Hacked",
	"OG",
	"Celestial",
	"Eternal"
};
local v120 = {
	"Normal",
	"Golden",
	"Diamond",
	"Plasma",
	"Molten",
	"Radioactive",
	"Shadow",
	"Electrified",
	"Rainbow",
	"Virus",
	"Volcanic",
	"Alien",
	"Void",
	"Bacon",
	"Enchanted",
	"Phantom",
	"Astral",
	"Wet"
};
local v121 = 50;
local v122 = false;
local function v123(v430)
	local v431 = 0 + 0 ;
	local v432;
	local v433;
	while true do
		if (1 == v431) then
			if v433 then
				v433.Velocity = Vector3.new(433 - (153 + 280), 0 - 0, 0);
				v433.CFrame = v430;
			end
			break;
		end
		if (v431 == (0 + 0)) then
			v432 = v5.Character;
			v433 = v432 and v432:FindFirstChild("HumanoidRootPart") ;
			v431 = 1 + 0 ;
		end
	end
end
local v124 = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network");
local v125 = {
	Perfect = 1 + 0,
	Excellent = 0.867 + 0,
	Great = 0.635 + 0,
	Mid = 0.264 - 0,
	Bad = 0.067 + 0
};
local v126 = "Perfect";
local v127 = 670 - (89 + 578) ;
local function v128(v434, v435, v436)
	local v437 = 0 + 0 ;
	local v438;
	local v439;
	local v440;
	local v441;
	local v442;
	local v443;
	while true do
		if (v437 == 0) then
			if not (v434 and v435 and (v435.Health > 0)) then
				return;
			end
			v438 = CFrame.new(v436.X, v127, v436.Z);
			v439 = (v434.Position - v438.Position).Magnitude;
			v437 = 1 - 0 ;
		end
		if (v437 == (1050 - (572 + 477))) then
			v440 = (v122 and v121) or math.max(v435.WalkSpeed, 7 + 43) ;
			v441 = v439 / v440 ;
			v434.Anchored = true;
			v437 = 2 + 0 ;
		end
		if (v437 == (1 + 2)) then
			v443.Completed:Wait();
			if (v434 and v434.Parent) then
				v434.Anchored = false;
			end
			break;
		end
		if (v437 == (88 - (84 + 2))) then
			v442 = TweenInfo.new(v441, Enum.EasingStyle.Linear);
			v443 = v2:Create(v434, v442, {
				CFrame = v438
			});
			v443:Play();
			v437 = 3;
		end
	end
end
local v129 = {
	"Golden",
	"Diamond",
	"Plasma",
	"Molten",
	"Radioactive",
	"Shadow",
	"Electrified",
	"Rainbow",
	"Virus",
	"Alien",
	"Void",
	"Bacon",
	"Enchanted",
	"Phantom",
	"Volcanic",
	"Astral",
	"Wet"
};
local v130 = game:GetService("ReplicatedStorage");
local v131 = v130:WaitForChild("Shared"):WaitForChild("Data"):WaitForChild("MutationData");
local v132 = v130:WaitForChild("Shared"):WaitForChild("Data"):WaitForChild("MutationSwitch");
local v133 = v130:WaitForChild("Objects"):WaitForChild("VFX"):WaitForChild("MutationVFX");
local v134 = {};
pcall(function()
	for v555, v556 in pairs(v132:GetChildren()) do
		v134[string.lower(v556.Name)] = v556.Name;
	end
	for v559, v560 in pairs(v131:GetChildren()) do
		v134[string.lower(v560.Name)] = v560.Name;
	end
	for v563, v564 in pairs(v133:GetChildren()) do
		v134[string.lower(v564.Name)] = v564.Name;
	end
end);
for v444, v445 in ipairs(v129) do
	v134[string.lower(v445)] = v445;
end
local v135 = {
	eye = "Alien",
	handle = "Bacon",
	water = "Wet",
	splash = "Wet",
	droplet = "Wet",
	aura = "Void",
	blackhole = "Void",
	void = "Void",
	glitch = "Virus",
	virus = "Virus",
	spark = "Electrified",
	electric = "Electrified",
	fire = "Molten",
	lava = "Molten",
	phantom = "Phantom",
	shadow = "Shadow",
	rainbow = "Rainbow",
	gold = "Golden",
	diamond = "Diamond"
};
for v447, v448 in pairs(v135) do
	v134[string.lower(v447)] = v448;
end
local function v136(v450)
	local v451 = {};
	if not v450 then
		return v451;
	end
	local v452 = string.lower(v450.Name);
	for v567, v568 in ipairs(v129) do
		if string.find(v452, string.lower(v568)) then
			v451[v568] = true;
		end
	end
	for v569, v570 in pairs(v450:GetAttributes()) do
		local v571 = string.lower(v569);
		if ((type(v570) == "boolean") and (v570 == true)) then
			if v134[v571] then
				v451[v134[v571]] = true;
			end
		end
		if (type(v570) == "string") then
			local v702 = string.lower(v570);
			if v134[v702] then
				v451[v134[v702]] = true;
			end
		end
	end
	for v572, v573 in pairs(v450:GetDescendants()) do
		local v574 = 0 - 0 ;
		local v575;
		while true do
			if (v574 == (1 + 0)) then
				if v573:IsA("StringValue") then
					local v820 = string.lower(tostring(v573.Value));
					if v134[v820] then
						v451[v134[v820]] = true;
					end
				end
				for v790, v791 in pairs(v573:GetAttributes()) do
					local v792 = string.lower(v790);
					if ((type(v791) == "boolean") and (v791 == true)) then
						if v134[v792] then
							v451[v134[v792]] = true;
						end
					end
					if (type(v791) == "string") then
						local v844 = string.lower(v791);
						if v134[v844] then
							v451[v134[v844]] = true;
						end
					end
				end
				v574 = 2;
			end
			if (v574 == (491 - (457 + 32))) then
				if v573:IsA("TextLabel") then
					local v821 = 0 + 0 ;
					local v822;
					while true do
						if (v821 == (1402 - (832 + 570))) then
							v822 = string.lower(v573.Text);
							for v924, v925 in ipairs(v129) do
								if string.find(v822, string.lower(v925)) then
									v451[v925] = true;
								end
							end
							break;
						end
					end
				end
				if (v573:IsA("ParticleEmitter") or v573:IsA("Trail") or v573:IsA("Beam")) then
					local v823 = 0 + 0 ;
					local v824;
					while true do
						if (v823 == (0 + 0)) then
							v824 = string.lower(v573.Name);
							if v134[v824] then
								v451[v134[v824]] = true;
							end
							break;
						end
					end
				end
				break;
			end
			if ((0 - 0) == v574) then
				v575 = string.lower(v573.Name);
				if v134[v575] then
					v451[v134[v575]] = true;
				end
				v574 = 1 + 0 ;
			end
		end
	end
	return v451;
end
local v137 = {};
local v138 = {};
local v139 = {};
v109(v97, "Filter Rarity", v119, "Main_FilterRarity", function(v453)
	for v576, v577 in pairs(v138) do
		v577.Visible = v576 == v453 ;
	end
end);
for v454, v455 in ipairs(v119) do
	local v456 = 796 - (588 + 208) ;
	local v457;
	while true do
		if (v456 == 0) then
			v457 = Instance.new("Frame", v97);
			v457.Size = UDim2.new(0, 700 - 440, 1800 - (884 + 916), 32);
			v456 = 1 - 0 ;
		end
		if (v456 == (1 + 0)) then
			v457.BackgroundTransparency = 1;
			v457.AutomaticSize = Enum.AutomaticSize.Y;
			v456 = 2;
		end
		if (v456 == (655 - (232 + 421))) then
			v457.Visible = v455 == "Common" ;
			v138[v455] = v457;
			v456 = 1892 - (1569 + 320) ;
		end
		if ((1 + 2) == v456) then
			v111(v457, "Target Pets", v118[v455], "Main_TargetPets_" .. v455, "MainKickPetsSync", v137, function(v762)
			end);
			break;
		end
	end
end
v110(v97, "Target Mutation", v120, "Main_TargetMutations", function(v458)
	v139 = v458;
end);
local v140 = false;
local v141 = 0 + 0 ;
v108(v97, "Auto Kick (Warp & Run Back) ✨", "AutoKick", function(v459)
	v140 = v459;
	v141 += 1
	local v460 = v141;
	if v140 then
		task.spawn(function()
			while v140 and (v460 == v141) do
				pcall(function()
					local v793 = 0 - 0 ;
					local v794;
					local v795;
					local v796;
					local v797;
					local v798;
					local v799;
					local v800;
					local v801;
					local v802;
					local v803;
					while true do
						if (v793 == 6) then
							if (v802 and v803) then
								task.wait(0.5);
								local v926 = false;
								local v927 = false;
								local v928 = v136(v803);
								for v959, v960 in pairs(v139) do
									if v960 then
										v927 = true;
										if (v959 == "Normal") then
											local v1032 = false;
											for v1042, v1042 in pairs(v928) do
												v1032 = true;
												break;
											end
											if not v1032 then
												v926 = true;
												break;
											end
										elseif v928[v959] then
											v926 = true;
											break;
										end
									end
								end
								local v929 = false;
								local v930 = false;
								for v961, v962 in pairs(v137) do
									if v962 then
										v930 = true;
										if string.find(string.lower(v803.Name), string.lower(v961)) then
											v929 = true;
											break;
										end
									end
								end
								local v931 = false;
								if (v927 and not v926) then
									v931 = true;
								end
								if (v930 and not v929) then
									v931 = true;
								end
								if v931 then
									local v975 = workspace:FindFirstChild("Waves");
									local v976 = nil;
									if v975 then
										if v975:IsA("BasePart") then
											v976 = v975.Position;
										elseif v975:IsA("Model") then
											v976 = v975:GetPivot().Position;
										else
											local v1062 = 0;
											local v1063;
											while true do
												if (v1062 == 0) then
													v1063 = v975:FindFirstChildWhichIsA("BasePart", true);
													if v1063 then
														v976 = v1063.Position;
													end
													break;
												end
											end
										end
									end
									if v976 then
										v128(v795, v796, v976);
									elseif v797 then
										v128(v795, v796, v798.Position);
									end
								elseif (v803 and not v803:GetAttribute("WebhookSent")) then
									local v1010 = 0;
									local v1011;
									local v1012;
									local v1013;
									local v1014;
									local v1015;
									while true do
										if (v1010 == (607 - (316 + 289))) then
											if v118 then
												for v1080, v1081 in pairs(v118) do
													for v1097, v1098 in ipairs(v1081) do
														if string.find(string.lower(v1011), string.lower(v1098)) then
															v1014 = v1080;
															break;
														end
													end
													if (v1014 ~= "Unknown") then
														break;
													end
												end
											end
											v1015 = (v116[v1011] or (0 - 0)) + 1 + 0 ;
											print("🎯 Target Found: " .. v1011 .. " [" .. v1013 .. "] (Rarity: " .. v1014 .. ") -> Returning to safezone");
											v1010 = 3;
										end
										if (v1010 == (1454 - (666 + 787))) then
											for v1064, v1065 in pairs(v928) do
												table.insert(v1012, v1064);
											end
											v1013 = (( # v1012 > (425 - (360 + 65))) and table.concat(v1012, ", ")) or "Normal" ;
											v1014 = "Unknown";
											v1010 = 2 + 0 ;
										end
										if (v1010 == 3) then
											v117("👀 Target Found!", "**Pet:** " .. v1011 .. "\n**Rarity:** " .. v1014 .. "\n**Mutation:** " .. v1013 .. "\n**Count:** " .. v1015 .. "\n**Player:** " .. v5.Name, 3447003, false);
											if v797 then
												local v1074 = 0;
												while true do
													if (v1074 == (254 - (79 + 175))) then
														v128(v795, v796, v798.Position);
														task.wait(1.5);
														v1074 = 1;
													end
													if (v1074 == 1) then
														if (v794 and v796 and (v796.Health > 0) and ((v795.Position - v798.Position).Magnitude < (31 - 11))) then
															v116[v1011] = (v116[v1011] or (0 + 0)) + (2 - 1) ;
															local v1109 = v116[v1011];
															print("✅ Successfully collected: " .. v1011 .. " [" .. v1013 .. "] (Rarity: " .. v1014 .. ") | Total: " .. v1109);
															v117("🎉 Target Collected!", "**Pet:** " .. v1011 .. "\n**Rarity:** " .. v1014 .. "\n**Mutation:** " .. v1013 .. "\n**Count:** " .. v1109 .. "\n**Player:** " .. v5.Name, 605014 - 290861, false);
														end
														break;
													end
												end
											end
											break;
										end
										if (v1010 == (899 - (503 + 396))) then
											v803:SetAttribute("WebhookSent", true);
											v1011 = v803.Name;
											v1012 = {};
											v1010 = 182 - (92 + 89) ;
										end
									end
								elseif v797 then
									v128(v795, v796, v798.Position);
								end
							end
							break;
						end
						if (v793 == (1 - 0)) then
							if not (v795 and v796 and (v796.Health > (0 + 0))) then
								return;
							end
							v797 = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady") ;
							if not v797 then
								return;
							end
							v793 = 2 + 0 ;
						end
						if (v793 == (11 - 8)) then
							v799 = v795.Position;
							v800 = false;
							v801 = v6:FindFirstChild("HUD");
							v793 = 1 + 3 ;
						end
						if (v793 == (8 - 4)) then
							for v905 = 1 + 0 , 72 + 78 do
								task.wait(0.1);
								if ( not v794 or not v794.Parent or (v796.Health <= (0 - 0))) then
									return;
								end
								if ((v795.Position - v799).Magnitude > (5 + 35)) then
									v800 = true;
									break;
								end
								local v906 = v801 and v801:FindFirstChild("KickButton") ;
								if (v906 and v906.Visible) then
									local v963 = 0 - 0 ;
									while true do
										if (v963 == 0) then
											v124.rev_KickEvent:FireServer(v125[v126] or (1245 - (485 + 759)));
											task.wait(0.5 - 0);
											break;
										end
									end
								end
							end
							if not v800 then
								return;
							end
							task.wait(0.5);
							v793 = 1194 - (442 + 747) ;
						end
						if ((1140 - (832 + 303)) == v793) then
							v802 = false;
							v803 = nil;
							for v907 = 947 - (88 + 858) , 13 + 27 do
								task.wait(0.2 + 0);
								local v908 = 3 + 57 ;
								for v932, v933 in pairs(workspace.Debris:GetChildren()) do
									if (v933:IsA("Model") and v933.PrimaryPart) then
										local v977 = (v933.PrimaryPart.Position - v795.Position).Magnitude;
										if (v977 < v908) then
											local v1016 = 789 - (766 + 23) ;
											while true do
												if (v1016 == (4 - 3)) then
													v803 = v933;
													break;
												end
												if (v1016 == (0 - 0)) then
													v908 = v977;
													v802 = true;
													v1016 = 2 - 1 ;
												end
											end
										end
									end
								end
								if v802 then
									break;
								end
							end
							v793 = 20 - 14 ;
						end
						if (v793 == (1075 - (1036 + 37))) then
							v798 = (v797:IsA("BasePart") and v797.CFrame) or v797:GetPivot() ;
							if ((v795.Position - v798.Position).Magnitude > 5) then
								v123(v798 + Vector3.new(0 + 0, 5 - 2, 0 + 0));
							end
							task.wait(0.5);
							v793 = 3;
						end
						if (v793 == 0) then
							v794 = v5.Character;
							v795 = v794 and v794:FindFirstChild("HumanoidRootPart") ;
							v796 = v794 and v794:FindFirstChild("Humanoid") ;
							v793 = 1;
						end
					end
				end);
				task.wait(1480.4 - (641 + 839));
			end
		end);
	end
end);
local v142 = false;
local v143 = 913 - (910 + 3) ;
local v144 = {
	["Wooden Stick"] = true,
	["Copper Plate"] = true,
	["Stone Block"] = true,
	["Bone Barbell"] = true,
	["Donut Barbell"] = true,
	["Ice Barbell"] = true,
	["Iron Plate"] = true,
	["Heaven Plate"] = true,
	["Golden Barbell"] = true,
	["Giant Gold Star Barbell"] = true,
	["Neon Pulse"] = true,
	["Mega Golden Barbell"] = true,
	["Bone Barbel"] = true,
	["Emerald Barbell"] = true
};
local function v145(v461)
	local v462 = 0;
	while true do
		if (v462 == 2) then
			pcall(function()
				if (v461:IsA("GuiObject") and (v461.AbsoluteSize.X > 0) and v461.Visible) then
					if ((v461.AbsolutePosition.X >= 0) and (v461.AbsolutePosition.X <= workspace.CurrentCamera.ViewportSize.X)) then
						local v856 = game:GetService("VirtualInputManager");
						local v857 = game:GetService("GuiService"):GetGuiInset();
						local v858 = v461.AbsolutePosition.X + (v461.AbsoluteSize.X / 2) + v857.X ;
						local v859 = v461.AbsolutePosition.Y + (v461.AbsoluteSize.Y / (4 - 2)) + v857.Y ;
						v856:SendMouseButtonEvent(v858, v859, 0, true, game, 1685 - (1466 + 218));
						task.wait(0.01);
						v856:SendMouseButtonEvent(v858, v859, 0 + 0, false, game, 1);
					end
				end
			end);
			break;
		end
		if ((1148 - (556 + 592)) == v462) then
			if ( not v461 or not v461.Parent) then
				return;
			end
			if getconnections then
				local v804 = 0;
				while true do
					if (v804 == (1 + 0)) then
						pcall(function()
							for v934, v935 in pairs(getconnections(v461.Activated)) do
								v935:Fire();
							end
						end);
						break;
					end
					if (v804 == 0) then
						pcall(function()
							for v936, v937 in pairs(getconnections(v461.MouseButton1Down)) do
								v937:Fire();
							end
						end);
						pcall(function()
							for v938, v939 in pairs(getconnections(v461.MouseButton1Click)) do
								v939:Fire();
							end
						end);
						v804 = 809 - (329 + 479) ;
					end
				end
			end
			v462 = 855 - (174 + 680) ;
		end
		if ((3 - 2) == v462) then
			if firesignal then
				pcall(function()
					firesignal(v461.MouseButton1Down);
				end);
				pcall(function()
					firesignal(v461.MouseButton1Click);
				end);
				pcall(function()
					firesignal(v461.Activated);
				end);
			end
			pcall(function()
				if v461:IsA("GuiButton") then
					v461:Activate();
				end
			end);
			v462 = 3 - 1 ;
		end
	end
end
v108(v97, "Auto Train & x2 ||—||", "AutoTrain", function(v463)
	v142 = v463;
	v143 = v143 + 1 ;
	local v464 = v143;
	if v142 then
		task.spawn(function()
			while v142 and (v464 == v143) do
				pcall(function()
					local v805 = v5.Character;
					local v806 = v805 and v805:FindFirstChild("Humanoid") ;
					local v807 = v5:FindFirstChild("Backpack");
					local v808 = v805 and v805:FindFirstChildOfClass("Tool") ;
					if not v808 then
						local v845 = v6:FindFirstChild("Backpack") and v6.Backpack:FindFirstChild("Bar") and v6.Backpack.Bar:FindFirstChild("Slot1") ;
						if (v845 and getconnections) then
							local v909 = 0 + 0 ;
							local v910;
							while true do
								if (v909 == (739 - (396 + 343))) then
									v910 = {
										v845,
										v845:FindFirstChild("ToolImage")
									};
									for v990, v991 in pairs(v910) do
										if v991 then
											local v1033 = 0;
											while true do
												if ((1390 - (135 + 1254)) == v1033) then
													pcall(function()
														for v1082, v1083 in pairs(getconnections(v991.Activated)) do
															v1083:Fire();
														end
													end);
													break;
												end
												if (v1033 == (0 - 0)) then
													pcall(function()
														for v1084, v1085 in pairs(getconnections(v991.MouseButton1Down)) do
															v1085:Fire();
														end
													end);
													pcall(function()
														for v1086, v1087 in pairs(getconnections(v991.MouseButton1Click)) do
															v1087:Fire();
														end
													end);
													v1033 = 4 - 3 ;
												end
											end
										end
									end
									break;
								end
							end
						end
						task.wait(0.1);
						if ( not v805:FindFirstChildOfClass("Tool") and v807 and v806) then
							for v940, v941 in pairs(v807:GetChildren()) do
								if (v941:IsA("Tool") and v144[v941.Name]) then
									v806:EquipTool(v941);
									break;
								end
							end
						end
					else
						v808:Activate();
					end
				end);
				pcall(function()
					local v809 = v6:FindFirstChild("KickUpgrades");
					if v809 then
						for v860, v861 in pairs(v809:GetChildren()) do
							if (((v861.Name == "Bonus") or (v861.Name == "PopBonus")) and v861.Visible) then
								local v942 = 0 + 0 ;
								local v943;
								while true do
									if (v942 == (1527 - (389 + 1138))) then
										v943 = {
											v861
										};
										for v1017, v1018 in ipairs(v861:GetDescendants()) do
											if (v1018:IsA("GuiButton") or v1018:IsA("ImageLabel")) then
												table.insert(v943, v1018);
											end
										end
										v942 = 1 + 0 ;
									end
									if ((1 + 0) == v942) then
										for v1019, v1020 in ipairs(v943) do
											v145(v1020);
										end
										break;
									end
								end
							end
						end
					end
				end);
				task.wait(0.1 + 0);
			end
		end);
	end
end);
v108(v97, "Enable Custom Speed 🏃", "EnableSpeed", function(v465)
	v122 = v465;
	if v122 then
		task.spawn(function()
			while v122 do
				pcall(function()
					local v810 = v5.Character;
					local v811 = v810 and v810:FindFirstChild("Humanoid") ;
					if v811 then
						v811.WalkSpeed = v121;
					end
				end);
				task.wait(1545.1 - (320 + 1225));
			end
		end);
	end
end);
v112(v97, "Set Speed", 1 - 0, 612 + 388, 1514 - (157 + 1307), "SpeedVal", function(v466)
	v121 = v466;
end);
v107(v97, "TP KickReady ⚡", function()
	pcall(function()
		v123(workspace.Areas.KickReady.CFrame + Vector3.new(1859 - (821 + 1038), 12 - 7, 0 + 0));
	end);
end);
local v146 = false;
local v147 = nil;
v108(v98, "Auto Collect Money 🤑", "AutoCollect", function(v467)
	local v468 = 0 - 0 ;
	local v469;
	local v470;
	while true do
		if (v468 == 0) then
			v146 = v467;
			v469 = v5.Character;
			v468 = 1 + 0 ;
		end
		if (v468 == (2 - 1)) then
			v470 = v469 and v469:FindFirstChild("HumanoidRootPart") ;
			if v146 then
				local v812 = 1026 - (834 + 192) ;
				while true do
					if (v812 == 0) then
						if ( not v147 and v470) then
							local v944 = math.huge;
							for v964, v965 in pairs(workspace:WaitForChild("Plots"):GetChildren()) do
								if (v965:IsA("Model") or v965:IsA("Folder")) then
									local v992 = 0;
									local v993;
									while true do
										if ((0 + 0) == v992) then
											v993 = (v470.Position - v965:GetPivot().Position).Magnitude;
											if (v993 < v944) then
												local v1066 = 0;
												while true do
													if (v1066 == 0) then
														v944 = v993;
														v147 = v965;
														break;
													end
												end
											end
											break;
										end
									end
								end
							end
						end
						task.spawn(function()
							while v146 do
								local v945 = 0 + 0 ;
								while true do
									if (v945 == 0) then
										if v147 then
											local v1034 = v147:FindFirstChild("Buttons");
											if v1034 then
												for v1067 = 1 + 0 , 46 - 16 do
													if not v146 then
														break;
													end
													local v1068 = v1034:FindFirstChild("Slot" .. v1067);
													if v1068 then
														local v1088 = 0;
														local v1089;
														while true do
															if (v1088 == 0) then
																v1089 = nil;
																if v1068:IsA("BasePart") then
																	v1089 = v1068.CFrame;
																elseif (v1068:IsA("Model") and v1068.PrimaryPart) then
																	v1089 = v1068.PrimaryPart.CFrame;
																elseif v1068:FindFirstChildWhichIsA("BasePart") then
																	v1089 = v1068:FindFirstChildWhichIsA("BasePart").CFrame;
																end
																v1088 = 305 - (300 + 4) ;
															end
															if (v1088 == 1) then
																if v1089 then
																	pcall(function()
																		v123(v1089 + Vector3.new(0, 1.5 + 0, 0 - 0));
																		task.wait(362.1 - (112 + 250));
																		v124.rev_B_Collect:FireServer(v1067);
																	end);
																end
																break;
															end
														end
													end
												end
											end
										end
										task.wait(1.5);
										break;
									end
								end
							end
						end);
						break;
					end
				end
			end
			break;
		end
	end
end);
local v148 = false;
v108(v98, "Instant Grab (No Delay) ⚡", "InstantGrab", function(v471)
	v148 = v471;
	if v148 then
		task.spawn(function()
			while v148 do
				pcall(function()
					for v826, v827 in pairs(workspace:GetDescendants()) do
						if v827:IsA("ProximityPrompt") then
							v827.HoldDuration = 0 + 0 ;
						end
					end
				end);
				task.wait(2 - 1);
			end
		end);
	end
end);
local v149 = false;
local v150 = 0 + 0 ;
v108(v98, "Auto Volcano Event (PC FIX1) 🌋💻", "AutoCollectVolcano", function(v472)
	v149 = v472;
	v150 += (1 + 0)
	local v473 = v150;
	if v149 then
		task.spawn(function()
			while v149 and (v473 == v150) do
				local v763 = 0 + 0 ;
				while true do
					if (v763 == 0) then
						pcall(function()
							local v863 = v5.Character;
							local v864 = v863 and v863:FindFirstChild("HumanoidRootPart") ;
							local v865 = v863 and v863:FindFirstChild("Humanoid") ;
							if not (v864 and v865 and (v865.Health > (0 + 0))) then
								return;
							end
							local v866 = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady") ;
							if not v866 then
								return;
							end
							local v867 = (v866:IsA("BasePart") and v866.CFrame) or v866:GetPivot() ;
							local v868 = v867.Position;
							if ((v864.Position - v868).Magnitude > (8 + 2)) then
								v123(v867 + Vector3.new(1414 - (1001 + 413), 6 - 3, 0));
							end
							task.wait(0.5);
							local v869 = v864.Position;
							local v870 = false;
							local v871 = v6:FindFirstChild("HUD");
							for v911 = 883 - (244 + 638) , 843 - (627 + 66) do
								task.wait(0.08);
								if ( not v863 or not v863.Parent or (v865.Health <= (0 - 0)) or not v149) then
									return;
								end
								local v912 = v871 and v871:FindFirstChild("KickButton") ;
								if (v912 and v912.Visible) then
									v124.rev_KickEvent:FireServer(603 - (512 + 90));
								end
								if ((v864.Position - v869).Magnitude > (1946 - (1665 + 241))) then
									v870 = true;
									break;
								end
							end
							if not v870 then
								return;
							end
							local v872 = 717 - (373 + 344) ;
							local v873 = v864.Position;
							while v149 and (v865.Health > (0 + 0)) do
								pcall(function()
									if (v865.Sit or v865.PlatformStand or (v865:GetState() == Enum.HumanoidStateType.Ragdoll) or (v865:GetState() == Enum.HumanoidStateType.FallingDown)) then
										v865.Sit = false;
										v865.PlatformStand = false;
										v865:ChangeState(Enum.HumanoidStateType.Running);
										v865.Jump = true;
									end
								end);
								local v913 = v864.Position;
								local v914 = (Vector3.new(v868.X, 0 + 0, v868.Z) - Vector3.new(v913.X, 0 - 0, v913.Z)).Unit;
								for v946, v947 in pairs(workspace.Debris:GetChildren()) do
									local v948 = v947:FindFirstChild("Hitbox");
									local v949 = v947:FindFirstChild("ShardParts");
									if (v948 and v948:IsA("BasePart") and v949) then
										local v981 = 0 - 0 ;
										local v982;
										local v983;
										while true do
											if ((1100 - (35 + 1064)) == v981) then
												if (v983 <= (48 + 17)) then
													local v1053 = (Vector3.new(v982.X, 0 - 0, v982.Z) - Vector3.new(v913.X, 0, v913.Z)).Unit;
													local v1054 = v914:Dot(v1053);
													if (v1054 >= - (0.2 + 0)) then
														pcall(function()
															v864.CFrame = CFrame.new(v948.Position + Vector3.new(1236 - (298 + 938), 1261 - (233 + 1026), 1666 - (636 + 1030)));
															v864.Velocity = Vector3.zero;
															v864.AssemblyLinearVelocity = Vector3.zero;
															for v1099 = 1, 2 + 1 do
																v124.rev_CollectShard:FireServer(v947.Name);
																task.wait(0.02 + 0);
															end
														end);
													end
												end
												break;
											end
											if (v981 == (0 + 0)) then
												v982 = v948.Position;
												v983 = (v913 - v982).Magnitude;
												v981 = 1;
											end
										end
									end
								end
								pcall(function()
									local v950 = 0 + 0 ;
									while true do
										if (v950 == 1) then
											v864.AssemblyLinearVelocity = Vector3.zero;
											break;
										end
										if (v950 == (221 - (55 + 166))) then
											v864.CFrame = v864.CFrame:Lerp(CFrame.new(v868 + Vector3.new(0 + 0, 1 + 2, 0 - 0)), 297.15 - (36 + 261));
											v864.Velocity = Vector3.zero;
											v950 = 1 - 0 ;
										end
									end
								end);
								local v915 = (v864.Position - v868).Magnitude;
								if (v915 <= 8) then
									break;
								end
								if ((v864.Position - v873).Magnitude < (1368.5 - (34 + 1334))) then
									v872 += (0.1 + 0)
								else
									v872 = 0 + 0 ;
									v873 = v864.Position;
								end
								if (v872 > (1286 - (1035 + 248))) then
									v123(v867 + Vector3.new(21 - (20 + 1), 3, 0 + 0));
									break;
								end
								v3.Heartbeat:Wait();
							end
						end);
						task.wait(319.5 - (134 + 185));
						break;
					end
				end
			end
		end);
	end
end);
local v151 = false;
local v152 = 0;
local v153 = CFrame.new(1802.768310546875 - (549 + 584), - (692.0019745826721 - (314 + 371)), 837.5688934326172 - 593);
v108(v98, "Auto Collect Volcano 🌋 (PC fix2)", "AutoCollectVolcanoKamikaze", function(v474)
	v151 = v474;
	v152 += (969 - (478 + 490))
	local v475 = v152;
	if v151 then
		task.spawn(function()
			while v151 and (v475 == v152) do
				local v764 = 0 + 0 ;
				while true do
					if (v764 == (1172 - (786 + 386))) then
						pcall(function()
							local v874 = v5.Character;
							local v875 = v874 and v874:FindFirstChild("HumanoidRootPart") ;
							local v876 = v874 and v874:FindFirstChild("Humanoid") ;
							if not (v874 and v875 and v876 and (v876.Health > (0 - 0))) then
								task.wait(1380 - (1055 + 324));
								return;
							end
							local v877 = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady") ;
							if not v877 then
								return;
							end
							local v878 = (v877:IsA("BasePart") and v877.CFrame) or v877:GetPivot() ;
							if ((v875.Position - v878.Position).Magnitude > (1350 - (1093 + 247))) then
								v123(v878 + Vector3.new(0 + 0, 3, 0 + 0));
							end
							task.wait(0.4);
							local v879 = v875.Position;
							local v880 = false;
							local v881 = v6:FindFirstChild("HUD");
							for v916 = 3 - 2 , 509 - 359 do
								task.wait(0.08 - 0);
								if not v151 then
									return;
								end
								local v917 = v881 and v881:FindFirstChild("KickButton") ;
								if (v917 and v917.Visible) then
									v124.rev_KickEvent:FireServer(2 - 1);
								end
								if ((v875.Position - v879).Magnitude > (15 + 25)) then
									v880 = true;
									break;
								end
							end
							if not v880 then
								return;
							end
							local v882 = 0 - 0 ;
							while v882 < (17 - 12) do
								task.wait(0.5);
								v882 += (0.5 + 0)
								local v918 = 0 - 0 ;
								for v951, v952 in pairs(workspace.Debris:GetChildren()) do
									if v952:FindFirstChild("Hitbox") then
										v918 += (689 - (364 + 324))
									end
								end
								if (v918 > (13 - 8)) then
									break;
								end
							end
							v875.CFrame = v153 + Vector3.new(0, 6 - 3, 0 + 0) ;
							task.wait(0.2 - 0);
							local v884 = {};
							while v151 and (v876.Health > (0 - 0)) do
								local v919 = nil;
								local v920 = math.huge;
								for v953, v954 in pairs(workspace.Debris:GetChildren()) do
									local v955 = v954:FindFirstChild("Hitbox");
									if (v955 and v955:IsA("BasePart") and not v884[v954]) then
										local v984 = string.match(v954.Name, "^[^_]+");
										if (v984 ~= "Common") then
											local v1021 = 0 - 0 ;
											local v1022;
											while true do
												if ((1268 - (1249 + 19)) == v1021) then
													v1022 = (v875.Position - v955.Position).Magnitude;
													if (v1022 < v920) then
														local v1075 = 0 + 0 ;
														while true do
															if (v1075 == (0 - 0)) then
																v920 = v1022;
																v919 = v954;
																break;
															end
														end
													end
													break;
												end
											end
										end
									end
								end
								if not v919 then
									task.wait(0.5);
									break;
								end
								local v921 = v919:FindFirstChild("Hitbox");
								if v921 then
									local v967 = 1086 - (686 + 400) ;
									while v151 and v919.Parent and (v876.Health > (0 + 0)) and not v884[v919] do
										task.wait(229.05 - (73 + 156));
										v967 += 0.05
										pcall(function()
											local v999 = 0 + 0 ;
											local v1000;
											local v1001;
											while true do
												if (v999 == (813 - (721 + 90))) then
													v875.AssemblyLinearVelocity = Vector3.zero;
													break;
												end
												if (v999 == (0 + 0)) then
													v1000 = v921.Position + Vector3.new(0 - 0, 472 - (224 + 246), 0) ;
													v1001 = 0.12 - 0 ;
													v999 = 1;
												end
												if (v999 == 1) then
													v875.CFrame = v875.CFrame:Lerp(CFrame.new(v1000), v1001);
													v875.Velocity = Vector3.zero;
													v999 = 3 - 1 ;
												end
											end
										end);
										local v985 = (v875.Position - v921.Position).Magnitude;
										if (v985 <= 10) then
											v884[v919] = true;
											pcall(function()
												local v1037 = 0;
												while true do
													if (v1037 == (0 + 0)) then
														v875.CFrame = v921.CFrame + Vector3.new(0 + 0, 1 + 0, 0) ;
														for v1076 = 1 - 0 , 3 do
															local v1077 = 0;
															while true do
																if ((0 - 0) == v1077) then
																	v124.rev_CollectShard:FireServer(v919.Name);
																	task.wait(513.03 - (203 + 310));
																	break;
																end
															end
														end
														break;
													end
												end
											end);
											break;
										end
										if (v967 >= (1996 - (1238 + 755))) then
											v884[v919] = true;
											break;
										end
									end
								end
								task.wait();
							end
						end);
						task.wait(0.5 + 0);
						break;
					end
				end
			end
		end);
	end
end);
v107(v98, "Buy Speed x1 👟", function()
	v124.rev_SPEED_UPGRADE:FireServer(1535 - (709 + 825));
end);
v107(v98, "Rebirth ♻️", function()
	v124.rev_RebirthRequest:FireServer();
end);
local v154 = {};
for v476 = 1 - 0 , 43 - 13 do
	table.insert(v154, tostring(v476));
end
local v155 = "1";
v109(v99, "Select UpG", v154, "UpGVal", function(v477)
	v155 = v477;
end);
local v156 = false;
v108(v99, "Auto Upgrade Selected ⚡", "AutoUpG", function(v478)
	local v479 = 864 - (196 + 668) ;
	while true do
		if (v479 == (0 - 0)) then
			v156 = v478;
			if v156 then
				task.spawn(function()
					while v156 do
						pcall(function()
							v124.rev_B_Upgrade:FireServer(tonumber(v155));
						end);
						task.wait(0.2);
					end
				end);
			end
			break;
		end
	end
end);
local v157 = "FARTEZ_HUB_CONFIGS";
pcall(function()
	if (isfolder and not isfolder(v157)) then
		makefolder(v157);
	elseif (makefolder and not isfolder) then
		makefolder(v157);
	end
end);
local v158 = "";
local v159 = "---";
local function v160()
	local v480 = 0 - 0 ;
	local v481;
	while true do
		if (v480 == (834 - (171 + 662))) then
			if ( # v481 == 0) then
				table.insert(v481, "---");
			end
			return v481;
		end
		if (v480 == 0) then
			v481 = {};
			if listfiles then
				pcall(function()
					for v847, v848 in pairs(listfiles(v157)) do
						local v849 = 93 - (4 + 89) ;
						local v850;
						while true do
							if ((0 - 0) == v849) then
								v850 = v848:match("([^/\\]+)%.json$");
								if v850 then
									table.insert(v481, v850);
								end
								break;
							end
						end
					end
				end);
			end
			v480 = 1;
		end
	end
end
v113(v100, "Config name", "Enter config name...", "UI_InputName", function(v482)
	v158 = v482;
end);
v107(v100, "Create config", function()
	local v483 = 0 + 0 ;
	local v484;
	while true do
		if (v483 == (0 - 0)) then
			if (v158 == "") then
				local v813 = 0 + 0 ;
				while true do
					if (v813 == (1486 - (35 + 1451))) then
						print("⚠️ กรุณาใส่ชื่อ Config!");
						return;
					end
				end
			end
			v484 = v4:JSONEncode(v104);
			v483 = 1454 - (28 + 1425) ;
		end
		if (v483 == (1994 - (941 + 1052))) then
			pcall(function()
				if writefile then
					local v828 = 0;
					while true do
						if ((0 + 0) == v828) then
							writefile(v157 .. "/" .. v158 .. ".json", v484);
							print("✅ สร้าง Config: " .. v158 .. " สำเร็จ!");
							break;
						end
					end
				end
			end);
			break;
		end
	end
end);
local v161 = Instance.new("Frame", v100);
v161.Size = UDim2.new(1514 - (822 + 692), 260, 0, 32);
v161.BackgroundColor3 = v9.SurfaceLight;
v161.ClipsDescendants = true;
Instance.new("UICorner", v161).CornerRadius = UDim.new(0 - 0, 3 + 3);
local v167 = Instance.new("TextButton", v161);
v167.Size = UDim2.new(1, 297 - (45 + 252), 0 + 0, 12 + 20);
v167.BackgroundTransparency = 2 - 1 ;
v167.Text = "  Config list: ---  ▼";
v167.TextColor3 = v9.Accent;
v167.Font = Enum.Font.GothamBold;
v167.TextSize = 444 - (114 + 319) ;
v167.TextXAlignment = Enum.TextXAlignment.Left;
local v175 = Instance.new("ScrollingFrame", v161);
v175.Size = UDim2.new(1 - 0, 0, 1 - 0, - 32);
v175.Position = UDim2.new(0, 0 + 0, 0, 46 - 14);
v175.BackgroundTransparency = 1 - 0 ;
v175.ScrollBarThickness = 1965 - (556 + 1407) ;
v175.AutomaticCanvasSize = Enum.AutomaticSize.Y;
local v182 = Instance.new("UIListLayout", v175);
local v183 = false;
local function v184()
	for v579, v580 in pairs(v175:GetChildren()) do
		if v580:IsA("TextButton") then
			v580:Destroy();
		end
	end
	local v485 = v160();
	v159 = v485[1207 - (741 + 465) ] or "---" ;
	v167.Text = "  Config list: " .. v159 .. "  ▼" ;
	for v581, v582 in ipairs(v485) do
		local v583 = 465 - (170 + 295) ;
		local v584;
		while true do
			if (0 == v583) then
				v584 = Instance.new("TextButton", v175);
				v584.Size = UDim2.new(1 + 0, - (10 + 0), 0 - 0, 25 + 5);
				v583 = 1 + 0 ;
			end
			if (v583 == 2) then
				v584.TextColor3 = v9.TextDim;
				v584.Font = Enum.Font.GothamBold;
				v583 = 3;
			end
			if (1 == v583) then
				v584.BackgroundColor3 = v9.Surface;
				v584.Text = "    " .. v582 ;
				v583 = 2;
			end
			if ((3 + 1) == v583) then
				v584.MouseButton1Click:Connect(function()
					v159 = v582;
					v183 = false;
					v2:Create(v161, TweenInfo.new(1230.2 - (957 + 273)), {
						Size = UDim2.new(0, 70 + 190, 0, 32)
					}):Play();
					v167.Text = "  Config list: " .. v159 .. "  ▼" ;
				end);
				break;
			end
			if (v583 == 3) then
				v584.TextSize = 5 + 6 ;
				v584.TextXAlignment = Enum.TextXAlignment.Left;
				v583 = 15 - 11 ;
			end
		end
	end
end
v167.MouseButton1Click:Connect(function()
	v183 = not v183;
	local v487 = # v160();
	local v488 = math.min(v487 * 30, 150);
	if v183 then
		v184();
		v2:Create(v161, TweenInfo.new(0.2 - 0), {
			Size = UDim2.new(0 - 0, 1287 - 1027, 0, (1812 - (389 + 1391)) + v488)
		}):Play();
	else
		v2:Create(v161, TweenInfo.new(0.2 + 0), {
			Size = UDim2.new(0 + 0, 591 - 331, 951 - (783 + 168), 107 - 75)
		}):Play();
	end
end);
v184();
v107(v100, "Load config", function()
	local v489 = 0 + 0 ;
	while true do
		if (v489 == 0) then
			if (v159 == "---") then
				return;
			end
			pcall(function()
				if isfile(v157 .. "/" .. v159 .. ".json") then
					local v829 = 311 - (309 + 2) ;
					local v830;
					local v831;
					while true do
						if (v829 == (2 - 1)) then
							for v956, v957 in pairs(v831) do
								if v105[v956] then
									v105[v956](v957);
								end
							end
							print("✅ โหลด Config: " .. v159 .. " สำเร็จ และอัปเดตหน้าจอแล้ว!");
							break;
						end
						if (v829 == 0) then
							v830 = readfile(v157 .. "/" .. v159 .. ".json");
							v831 = v4:JSONDecode(v830);
							v829 = 1;
						end
					end
				end
			end);
			break;
		end
	end
end);
v107(v100, "Overwrite config", function()
	if (v159 == "---") then
		return;
	end
	local v490 = v4:JSONEncode(v104);
	pcall(function()
		if writefile then
			local v710 = 1212 - (1090 + 122) ;
			while true do
				if (v710 == (0 + 0)) then
					writefile(v157 .. "/" .. v159 .. ".json", v490);
					print("💾 เซฟทับ Config: " .. v159 .. " สำเร็จ!");
					break;
				end
			end
		end
	end);
end);
v107(v100, "Delete config", function()
	if (v159 == "---") then
		return;
	end
	pcall(function()
		if (delfile and isfile(v157 .. "/" .. v159 .. ".json")) then
			local v711 = 0 - 0 ;
			while true do
				if (v711 == 1) then
					v184();
					break;
				end
				if (v711 == (0 + 0)) then
					delfile(v157 .. "/" .. v159 .. ".json");
					print("🗑️ ลบ Config: " .. v159 .. " ทิ้งแล้ว!");
					v711 = 1119 - (628 + 490) ;
				end
			end
		end
	end);
end);
v107(v100, "Refresh list", function()
	v184();
	print("🔄 รีเฟรชรายชื่อ Config แล้ว");
end);
v107(v100, "Set as autoload", function()
	if (v159 == "---") then
		return;
	end
	pcall(function()
		if writefile then
			local v712 = 0 + 0 ;
			while true do
				if (v712 == 0) then
					writefile(v157 .. "/Autoload.txt", v159);
					print("🚀 ตั้งค่า " .. v159 .. " เป็น Autoload แล้ว!");
					break;
				end
			end
		end
	end);
end);
v107(v100, "Reset autoload", function()
	pcall(function()
		if (delfile and isfile(v157 .. "/Autoload.txt")) then
			delfile(v157 .. "/Autoload.txt");
			print("♻️ ยกเลิกการตั้งค่า Autoload เรียบร้อยแล้ว!");
		elseif writefile then
			writefile(v157 .. "/Autoload.txt", "");
			print("♻️ ยกเลิกการตั้งค่า Autoload เรียบร้อยแล้ว (เขียนทับค่าว่าง)!");
		end
	end);
end);
task.spawn(function()
	pcall(function()
		if (isfile and isfile(v157 .. "/Autoload.txt")) then
			local v713 = readfile(v157 .. "/Autoload.txt");
			if ((v713 ~= "") and isfile(v157 .. "/" .. v713 .. ".json")) then
				local v815 = 0 - 0 ;
				local v816;
				local v817;
				while true do
					if (v815 == (4 - 3)) then
						for v922, v923 in pairs(v817) do
							if v105[v922] then
								v105[v922](v923);
							end
						end
						print("✨ ใช้งานระบบ Autoload: โหลด " .. v713 .. " สำเร็จ!");
						break;
					end
					if (v815 == (774 - (431 + 343))) then
						v816 = readfile(v157 .. "/" .. v713 .. ".json");
						v817 = v4:JSONDecode(v816);
						v815 = 1;
					end
				end
			end
		end
	end);
end);
local v185 = {
	Common = {
		2 - 1,
		3.6448693e-9 + 0
	},
	Rare = {
		1 + 0,
		1.0934608e-7
	},
	Epic = {
		1 + 0,
		0.0000036448694 + 0
	},
	Legendary = {
		0 + 0,
		0.01 - 0
	},
	Mythic = {
		1317.2499446161091 - (486 + 831),
		0.01 - 0
	},
	Godly = {
		3 - 2,
		0.0006143887127431052 + 0
	},
	Secret = {
		1,
		290.00191724973945 - (23 + 267)
	},
	Divine = {
		387.7800284549594 - (371 + 16),
		0.01 - 0
	},
	Hacked = {
		0.7925464622676373,
		118.02 - (88 + 30)
	},
	OG = {
		1,
		1776.06 - (421 + 1355)
	},
	Celestial = {
		1,
		0.11024213100273421 - 0
	},
	Eternal = {
		1084 - (286 + 797),
		0.5212494498439454 - 0
	}
};
local v186 = "Common";
local v187 = {};
local v188 = {};
local v189 = {};
v109(v101, "Select Zone & Rarity 🎯", v119, "Event_FilterRarity", function(v491)
	v186 = v491;
	for v585, v586 in pairs(v188) do
		v586.Visible = v585 == v491 ;
	end
end);
local v190 = 440 - (397 + 42) ;
v112(v101, "Adjust Dist (Multiplier)", 0.0001, 32 + 68, 801 - (24 + 776), "EventDist", function(v492)
	v190 = v492;
end);
for v493, v494 in ipairs(v119) do
	local v495 = 0 - 0 ;
	local v496;
	while true do
		if (v495 == (786 - (222 + 563))) then
			v496.BackgroundTransparency = 1 - 0 ;
			v496.AutomaticSize = Enum.AutomaticSize.Y;
			v495 = 2 + 0 ;
		end
		if (v495 == 0) then
			v496 = Instance.new("Frame", v101);
			v496.Size = UDim2.new(0, 450 - (23 + 167), 0, 32);
			v495 = 1799 - (690 + 1108) ;
		end
		if (v495 == (2 + 1)) then
			v111(v496, "Target KickZone Brainrots", v118[v494], "Event_TargetPets_" .. v494, "EventKickPetsSync", v187, function(v776)
			end);
			break;
		end
		if (v495 == 2) then
			v496.Visible = v494 == "Common" ;
			v188[v494] = v496;
			v495 = 3 + 0 ;
		end
	end
end
v110(v101, "Target KickZone Mutation", v120, "Event_TargetMutations", function(v497)
	v189 = v497;
end);
local v191 = false;
local v192 = 848 - (40 + 808) ;
v108(v101, "Auto Kick (KickZone & Waves) ✨", "AutoEvent", function(v498)
	v191 = v498;
	v192 = v192 + 1 + 0 ;
	local v499 = v192;
	if v191 then
		task.spawn(function()
			while v191 and (v499 == v192) do
				local v777 = 0 - 0 ;
				while true do
					if (0 == v777) then
						pcall(function()
							local v885 = 0 + 0 ;
							local v886;
							local v887;
							local v888;
							local v889;
							local v890;
							local v891;
							local v892;
							local v893;
							local v894;
							local v895;
							while true do
								if (v885 == (1 + 0)) then
									if not (v887 and v888 and (v888.Health > 0)) then
										return;
									end
									v889 = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady") ;
									if not v889 then
										return;
									end
									v885 = 2 + 0 ;
								end
								if (v885 == (573 - (47 + 524))) then
									v890 = (v889:IsA("BasePart") and v889.CFrame) or v889:GetPivot() ;
									if ((v887.Position - v890.Position).Magnitude > (4 + 1)) then
										v123(v890 + Vector3.new(0 - 0, 3, 0 - 0));
									end
									task.wait(0.5 - 0);
									v885 = 1729 - (1165 + 561) ;
								end
								if (v885 == (1 + 3)) then
									for v986 = 3 - 2 , 153 + 247 do
										task.wait(479.1 - (341 + 138));
										if ( not v886 or not v886.Parent or (v888.Health <= (0 + 0))) then
											return;
										end
										if ((v887.Position - v891).Magnitude > (82 - 42)) then
											v892 = true;
											break;
										end
										local v987 = v893 and v893:FindFirstChild("KickButton") ;
										if (v987 and v987.Visible) then
											local v1025 = v185[v186];
											if v1025 then
												v124.rev_KickEvent:FireServer(v1025[1], v1025[328 - (89 + 237) ] * v190);
											else
												v124.rev_KickEvent:FireServer(3 - 2);
											end
											task.wait(0.5);
										end
									end
									if not v892 then
										return;
									end
									task.wait(0.5);
									v885 = 10 - 5 ;
								end
								if (v885 == (887 - (581 + 300))) then
									if (v894 and v895) then
										task.wait(0.5);
										local v1002 = false;
										local v1003 = false;
										local v1004 = v136(v895);
										for v1026, v1027 in pairs(v189) do
											if v1027 then
												v1003 = true;
												if (v1026 == "Normal") then
													local v1070 = false;
													for v1078, v1078 in pairs(v1004) do
														v1070 = true;
														break;
													end
													if not v1070 then
														v1002 = true;
														break;
													end
												elseif v1004[v1026] then
													v1002 = true;
													break;
												end
											end
										end
										local v1005 = false;
										local v1006 = false;
										for v1028, v1029 in pairs(v187) do
											if v1029 then
												v1006 = true;
												if string.find(string.lower(v895.Name), string.lower(v1028)) then
													v1005 = true;
													break;
												end
											end
										end
										local v1007 = false;
										if (v1003 and not v1002) then
											v1007 = true;
										end
										if (v1006 and not v1005) then
											v1007 = true;
										end
										if v1007 then
											local v1038 = workspace:FindFirstChild("Waves");
											local v1039 = nil;
											if v1038 then
												if v1038:IsA("BasePart") then
													v1039 = v1038.Position;
												elseif v1038:IsA("Model") then
													v1039 = v1038:GetPivot().Position;
												else
													local v1101 = v1038:FindFirstChildWhichIsA("BasePart", true);
													if v1101 then
														v1039 = v1101.Position;
													end
												end
											end
											if v1039 then
												v128(v887, v888, v1039);
											elseif v889 then
												v128(v887, v888, v890.Position);
											end
										elseif (v895 and not v895:GetAttribute("WebhookSent")) then
											v895:SetAttribute("WebhookSent", true);
											local v1056 = v895.Name;
											local v1057 = {};
											for v1071, v1072 in pairs(v1004) do
												table.insert(v1057, v1071);
											end
											local v1058 = (( # v1057 > (1220 - (855 + 365))) and table.concat(v1057, ", ")) or "Normal" ;
											local v1059 = "Unknown";
											if v118 then
												for v1094, v1095 in pairs(v118) do
													for v1102, v1103 in ipairs(v1095) do
														if string.find(string.lower(v1056), string.lower(v1103)) then
															v1059 = v1094;
															break;
														end
													end
													if (v1059 ~= "Unknown") then
														break;
													end
												end
											end
											local v1060 = (v116[v1056] or 0) + (2 - 1) ;
											print("🎯 KickZone Target Found: " .. v1056 .. " [" .. v1058 .. "] (Rarity: " .. v1059 .. ") -> Returning to safezone");
											v117("👀 KickZone Target Found!", "**Pet:** " .. v1056 .. "\n**Rarity:** " .. v1059 .. "\n**Mutation:** " .. v1058 .. "\n**Count:** " .. v1060 .. "\n**Player:** " .. v5.Name, 3447003, false);
											if v889 then
												v128(v887, v888, v890.Position);
												task.wait(1.5 + 0);
												if (v886 and v888 and (v888.Health > (1235 - (1030 + 205))) and ((v887.Position - v890.Position).Magnitude < 20)) then
													v116[v1056] = (v116[v1056] or 0) + 1 + 0 ;
													local v1105 = v116[v1056];
													print("✅ Successfully collected: " .. v1056 .. " [" .. v1058 .. "] (Rarity: " .. v1059 .. ") | Total: " .. v1105);
													v117("🎉 KickZone Target Collected!", "**Pet:** " .. v1056 .. "\n**Rarity:** " .. v1059 .. "\n**Mutation:** " .. v1058 .. "\n**Count:** " .. v1105 .. "\n**Player:** " .. v5.Name, 292246 + 21907, false);
												end
											end
										elseif v889 then
											v128(v887, v888, v890.Position);
										end
									end
									break;
								end
								if (v885 == (289 - (156 + 130))) then
									v891 = v887.Position;
									v892 = false;
									v893 = v6:FindFirstChild("HUD");
									v885 = 8 - 4 ;
								end
								if (v885 == (8 - 3)) then
									v894 = false;
									v895 = nil;
									for v988 = 1 - 0 , 11 + 29 do
										task.wait(0.2 + 0);
										local v989 = 2000;
										for v1008, v1009 in pairs(workspace.Debris:GetChildren()) do
											if (v1009:IsA("Model") and v1009.PrimaryPart) then
												local v1040 = 0;
												local v1041;
												while true do
													if (v1040 == 0) then
														v1041 = (v1009.PrimaryPart.Position - v887.Position).Magnitude;
														if (v1041 < v989) then
															local v1096 = 69 - (10 + 59) ;
															while true do
																if (v1096 == (1 + 0)) then
																	v895 = v1009;
																	break;
																end
																if (v1096 == 0) then
																	v989 = v1041;
																	v894 = true;
																	v1096 = 1;
																end
															end
														end
														break;
													end
												end
											end
										end
										if v894 then
											break;
										end
									end
									v885 = 29 - 23 ;
								end
								if (v885 == 0) then
									v886 = v5.Character;
									v887 = v886 and v886:FindFirstChild("HumanoidRootPart") ;
									v888 = v886 and v886:FindFirstChild("Humanoid") ;
									v885 = 1164 - (671 + 492) ;
								end
							end
						end);
						task.wait(0.4);
						break;
					end
				end
			end
		end);
	end
end);
local v193 = {};
local v194 = {};
local v195 = {};
local v196 = {
	"Normal",
	"Golden",
	"Diamond",
	"Plasma",
	"Molten",
	"Radioactive",
	"Shadow",
	"Electrified",
	"Rainbow",
	"Virus",
	"Alien",
	"Void",
	"Bacon",
	"Enchanted",
	"Phantom",
	"Astral",
	"Wet"
};
v109(v102, "Select Rarity", v119, "Sell_FilterRarity", function(v500)
	for v588, v589 in pairs(v194) do
		v589.Visible = v588 == v500 ;
	end
end);
for v501, v502 in ipairs(v119) do
	local v503 = 0;
	local v504;
	while true do
		if (v503 == 1) then
			v504.BackgroundTransparency = 2 - 1 ;
			v504.AutomaticSize = Enum.AutomaticSize.Y;
			v503 = 2 - 0 ;
		end
		if ((178 - (50 + 126)) == v503) then
			v504.Visible = v502 == "Common" ;
			v194[v502] = v504;
			v503 = 3;
		end
		if (v503 == (8 - 5)) then
			v111(v504, "Select Brainrots", v118[v502], "Sell_TargetPets_" .. v502, "SellPetsSync", v193, function(v778)
			end);
			break;
		end
		if (v503 == 0) then
			v504 = Instance.new("Frame", v102);
			v504.Size = UDim2.new(0 + 0, 1673 - (1233 + 180), 969 - (522 + 447), 32);
			v503 = 1422 - (107 + 1314) ;
		end
	end
end
v110(v102, "Select Mutation", v196, "Sell_TargetMutations", function(v505)
	v195 = v505;
end);
local v197 = false;
v108(v102, "Auto Sell Selected Pets 💸", "AutoSell", function(v506)
	v197 = v506;
	if v197 then
		task.spawn(function()
			while v197 do
				local v779 = 0 + 0 ;
				while true do
					if (v779 == 0) then
						pcall(function()
							local v896 = 0 - 0 ;
							local v897;
							local v898;
							local v899;
							local v900;
							while true do
								if (v896 == (0 + 0)) then
									v897 = game:GetService("Players").LocalPlayer;
									v898 = v897:FindFirstChild("Backpack");
									v896 = 1 - 0 ;
								end
								if (v896 == (7 - 5)) then
									if (v898 and v900) then
										for v1030, v1031 in pairs(v898:GetChildren()) do
											if not v197 then
												break;
											end
											if (v1031:IsA("Tool") and v193[v1031.Name]) then
												local v1050 = v1031:GetAttribute("Mutation") or "None" ;
												if (v1050 == "None") then
													v1050 = "Normal";
												end
												local v1051 = false;
												if v195[v1050] then
													v1051 = true;
												end
												if v1051 then
													v900:EquipTool(v1031);
													task.wait(0.15);
													game:GetService("ReplicatedStorage").Shared.Packages.Network.ref_B_Sell:InvokeServer();
													task.wait(1910.2 - (716 + 1194));
												end
											end
										end
									end
									break;
								end
								if (v896 == (1 + 0)) then
									v899 = v897.Character;
									v900 = v899 and v899:FindFirstChild("Humanoid") ;
									v896 = 1 + 1 ;
								end
							end
						end);
						task.wait(504 - (74 + 429));
						break;
					end
				end
			end
		end);
	end
end);
local function v198(v507, v508)
	local v509 = 0;
	local v510;
	while true do
		if (v509 == (1 - 0)) then
			v510.BackgroundTransparency = 1 + 0 ;
			v510.Text = v507;
			v509 = 4 - 2 ;
		end
		if (v509 == 3) then
			v510.TextSize = 12;
			break;
		end
		if (v509 == 0) then
			v510 = Instance.new("TextLabel", v103);
			v510.Size = UDim2.new(1, 0 + 0, 0, 76 - 51);
			v509 = 2 - 1 ;
		end
		if (v509 == 2) then
			v510.TextColor3 = v508;
			v510.Font = Enum.Font.GothamBold;
			v509 = 436 - (279 + 154) ;
		end
	end
end
v198("🍀 Kick a Lucky Block", v9.Success);
v198("🌿 by FARTEZ", v9.Success);
v198("▶️ YouTube FARTEZ HUB", v9.Success);
v198("🟢 It works", v9.Success);
local v199 = Instance.new("Frame", v103);
v199.Size = UDim2.new(1, 0, 0, 2);
v199.BackgroundColor3 = v9.SurfaceLight;
v199.BorderSizePixel = 778 - (454 + 324) ;
v198("--- Discord Webhook ---", v9.Accent);
v108(v103, "Enable Webhook 🔔", "EnableWebhook", function(v511)
	v115 = v511;
end);
v113(v103, "Webhook URL:", "Paste URL https://discord.com...", "WebhookURL", function(v512)
	v114 = v512;
	print("🔗 Webhook URL Saved: " .. v114);
end);
v107(v103, "Test Webhook 🧪", function()
	v117("🧪 Test Notification", "Webhook system for **FARTEZ HUB** is working perfectly!", 247164 + 66989, true);
end);
v95[18 - (12 + 5) ].Page.Visible = true;
v95[1 + 0 ].Btn.BackgroundColor3 = v9.Accent;
v95[1].Btn.TextColor3 = Color3.new(0 - 0, 0 + 0, 0);
v14.MouseButton1Click:Connect(function()
	v26.Visible = not v26.Visible;
end);