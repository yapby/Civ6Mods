-- ============================= --
--  Copyright 2018 FiatAccompli  --
-- ============================= --

include("mod_settings.lua");
include("mod_settings_key_binding_helper.lua");
include("inputsupport");

ModSettings.PageHeader(
  "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", 
  "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY",
  "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_DESCRIPTION", 
  "fiataccompli_logo.dds");

---------------- Minimap size controls -----------------------
ModSettings.Header:new("LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_MINIMAP_CONTROLS");

local minimapSizeKeyDownMatchOptions = { Event=KeyEvents.KeyDown, InterfaceModes=KeyBindingHelper.ALL_INTERFACE_MODES };

local minimapSizeIncreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_HOME, {Shift=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_MINIMAP_INCREASE_SIZE");
local minimapSizeDecreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_END, {Shift=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_MINIMAP_DECREASE_SIZE");
local minimapChangeAmountSetting = ModSettings.Range:new(5, 1, 100, "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", 
    "LOC_PTK_GLOBAL_HOTKEYS_MINIMAP_SIZE_CHANGE_AMOUNT", "LOC_PTK_GLOBAL_HOTKEYS_MINIMAP_SIZE_CHANGE_AMOUNT_TOOLTIP",
    { Steps = 99, ValueFormatter = ModSettings.Range.PERCENT_FORMATTER });

-- Rather annoyingly, there is no way to get the current minimap size.  So we just have to keep track of it in parallel 
-- to the real game value.  A side effect of this is that when you adjust the size with the actual in-game options it 
-- will get out of sync and the next increase/decrease by these keys will "jump" it back to whatever size it remembers. 
-- Oh well, best we can do.
local minimapSize = Options.GetGraphicsOption("General", "MinimapSize") or 0.0;

-------------- Sound controls -----------------------------
ModSettings.Header:new("LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_SOUND_CONTROLS");
-- Key down is used to pick up auto-repeats from the operating system.
local volumeChangeKeyDownMatchOptions = { 
    Event=KeyEvents.KeyDown, 
    InterfaceModes=KeyBindingHelper.ALL_INTERFACE_MODES, 
    AllowInPopups=true,
    InputContexts={
      [InputContext.World] = true,
      [InputContext.Diplomacy] = true,
      [InputContext.Loading] = true,
      [InputContext.Ready] = true,
      [InputContext.EndGame] = true,
    },
};

local volumeChangeUsePageUpPageDownKeys = ModSettings.Action:new(
  "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_VOLUME_USE_PAGE_UP_PAGE_DOWN", "LOC_PTK_GLOBAL_HOTKEYS_VOLUME_USE_PAGE_UP_PAGE_DOWN_TOOLTIP");

local volumeChangeUseDedicatedKeys = ModSettings.Action:new(
  "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_VOLUME_USE_NATIVE_VOLUME_KEYS", "LOC_PTK_GLOBAL_HOTKEYS_VOLUME_USE_NATIVE_VOLUME_KEYS_TOOLTIP");

local volumeChangeAmountSetting = ModSettings.Range:new(5, 1, 100, "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", 
    "LOC_PTK_GLOBAL_HOTKEYS_VOLUME_CHANGE_AMOUNT", "LOC_PTK_GLOBAL_HOTKEYS_VOLUME_CHANGE_AMOUNT_TOOLTIP",
    { Steps = 99, ValueFormatter = ModSettings.Range.PERCENT_FORMATTER });

local volumeIncreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_PRIOR),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_INCREASE_VOLUME");
local volumeDecreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_NEXT),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_DECREASE_VOLUME");
local volumeMuteKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_NEXT, {Ctrl=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_MUTE_VOLUME");
local musicVolumeIncreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_PRIOR, {Shift=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_INCREASE_MUSIC_VOLUME");
local musicVolumeDecreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_NEXT, {Shift=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_DECREASE_MUSIC_VOLUME");
local soundEffectsVolumeIncreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_PRIOR, {Alt=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_INCREASE_SOUND_EFFECTS_VOLUME");
local soundEffectsVolumeDecreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_NEXT, {Alt=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_DECREASE_SOUND_EFFECTS_VOLUME");
local ambientVolumeIncreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_PRIOR, {Shift=true, Alt=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_INCREASE_AMBIENT_VOLUME");
local ambientVolumeDecreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_NEXT, {Shift=true, Alt=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_DECREASE_AMBIENT_VOLUME");
local speechVolumeIncreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_PRIOR, {Shift=true, Ctrl=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_INCREASE_SPEECH_VOLUME");
local speechVolumeDecreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_NEXT, {Shift=true, Ctrl=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_DECREASE_SPEECH_VOLUME");

-- Volume at the time the it was muted and to which it will be restored when the mute key is pressed again.
local volumeToDeMute = -1;

volumeChangeUseDedicatedKeys:AddChangedHandler(
    function()
      volumeIncreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_VOLUME_UP));
      volumeDecreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_VOLUME_DOWN));
      volumeMuteKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_VOLUME_MUTE));
      musicVolumeIncreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_VOLUME_UP, {Shift=true}));
      musicVolumeDecreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_VOLUME_DOWN, {Shift=true}));
      soundEffectsVolumeIncreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_VOLUME_UP, {Alt=true}));
      soundEffectsVolumeDecreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_VOLUME_DOWN, {Alt=true}));
      ambientVolumeIncreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_VOLUME_UP, {Shift=true, Alt=true}));
      ambientVolumeDecreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_VOLUME_DOWN, {Shift=true, Alt=true}));
      speechVolumeIncreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_VOLUME_UP, {Shift=true, Ctrl=true}));
      speechVolumeDecreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_VOLUME_DOWN, {Shift=true, Ctrl=true}));
    end);
volumeChangeUsePageUpPageDownKeys:AddChangedHandler(
    function()
      volumeIncreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_PRIOR));
      volumeDecreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_NEXT));
      volumeMuteKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_NEXT, {Ctrl=true}));
      musicVolumeIncreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_PRIOR, {Shift=true}));
      musicVolumeDecreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_NEXT, {Shift=true}));
      soundEffectsVolumeIncreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_PRIOR, {Alt=true}));
      soundEffectsVolumeDecreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_NEXT, {Alt=true}));
      ambientVolumeIncreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_PRIOR, {Shift=true, Alt=true}));
      ambientVolumeDecreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_NEXT, {Shift=true, Alt=true}));
      speechVolumeIncreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_PRIOR, {Shift=true, Ctrl=true}));
      speechVolumeDecreaseKeyBinding:Change(ModSettings.KeyBinding.MakeValue(Keys.VK_NEXT, {Shift=true, Ctrl=true}));
    end);

------------------- Gameplay controls --------------------
ModSettings.Header:new("LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_GAMEPLAY_CONTROLS");

local gameplayControlsMatchOptions = { InterfaceModes=KeyBindingHelper.ALL_INTERFACE_MODES, AllowInPopups=true };

local toggleQuickCombatKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.Q, {Alt=true, Ctrl=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_TOGGLE_QUICK_COMBAT");
local toggleQuickMovementKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.Q, {Alt=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_TOGGLE_QUICK_MOVEMENT");

------------------ Toggleable UI elements --------------------------
ModSettings.Header:new("LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_GRAPHICS_CONTROLS");

local graphicTogglesMatchOptions = { InterfaceModes=KeyBindingHelper.ALL_INTERFACE_MODES, AllowInPopups=true };

local toggleCityBannersKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.W, {Alt=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_TOGGLE_CITY_BANNERS");
local toggleMapTacksKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.E, {Alt=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_TOGGLE_MAP_TACKS");
local toggleUnitIconsKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.R, {Alt=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_TOGGLE_UNIT_ICONS");
local toggleHUDKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.T, {Alt=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_TOGGLE_HUD", "LOC_PTK_GLOBAL_HOTKEYS_TOGGLE_HUD_TOOLTIP");

------------------ Time of day --------------------------
ModSettings.Header:new("LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_IN_GAME_TIME_OF_DAY_CONTROLS");

local timeOfDayMatchOptions = { InterfaceModes=KeyBindingHelper.ALL_INTERFACE_MODES, AllowInPopups=true };
local timeOfDayKeyDownMatchOptions = { Event=KeyEvents.KeyDown, InterfaceModes=KeyBindingHelper.ALL_INTERFACE_MODES };

local toggleAnimatedTimeOfDayKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.A, {Alt=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_TOGGLE_ANIMATED_TIME_OF_DAY");

local timeOfDayChangeAmountSetting = ModSettings.Range:new(10, 1, 60, "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", 
    "LOC_PTK_GLOBAL_HOTKEYS_TIME_OF_DAY_CHANGE_AMOUNT", nil, { Steps = 59 });
local timeOfDayIncreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_HOME, {Ctrl=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_INCREASE_TIME_OF_DAY");
local timeOfDayDecreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_END, {Ctrl=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_DECREASE_TIME_OF_DAY");

local timeOfDayLengthChangePercentSetting = ModSettings.Range:new(10, 1, 50, "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", 
    "LOC_PTK_GLOBAL_HOTKEYS_TIME_OF_DAY_SPEED_CHANGE_AMOUNT", "LOC_PTK_GLOBAL_HOTKEYS_TIME_OF_DAY_SPEED_CHANGE_AMOUNT_TOOLTIP", 
    { Steps = 49, ValueFormatter = ModSettings.Range.PERCENT_FORMATTER });
local timeOfDaySpeedIncreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_HOME, {Alt=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_TIME_OF_DAY_SPEED_CHANGE_INCREASE");
local timeOfDaySpeedDecreaseKeyBinding = ModSettings.KeyBinding:new(ModSettings.KeyBinding.MakeValue(Keys.VK_END, {Alt=true}),
    "LOC_PTK_GLOBAL_HOTKEYS_MOD_SETTINGS_CATEGORY", "LOC_PTK_GLOBAL_HOTKEYS_TIME_OF_DAY_SPEED_CHANGE_DECREASE");

local animatedTimeOfDay:boolean = nil;

---------------------------------------------------------
-- Logic
---------------------------------------------------------
function FadeUpdatedVisualContainer(container:table)
  container:SetToBeginning();
  container:Play();

  UpdateTimeLabel(UI.GetAmbientTimeOfDay());
  UpdateLengthOfDayLabel(UI.GetAmbientTimeOfDaySpeed());
  Controls.StatusWindowAlpha:SetHide(false);
  Controls.StatusWindowAlpha:SetToBeginning();
  Controls.FadeDelay:SetToBeginning();
  Controls.FadeDelay:Play();
end

--------------------------------------------------------------------
-- Taken wholesale from Options.lua
local TIME_SCALE = 23.0 + (59.0 / 60.0); -- 11:59 PM
function UpdateTimeLabel(value)
  local iHours = math.floor(value);
  local iMins  = math.floor((value - iHours) * 60);
  local meridiem = "";

  if (UserConfiguration.GetClockFormat() == 0) then
    meridiem = " am";
    if ( iHours >= 12 ) then
      meridiem = " pm";
      if( iHours > 12 ) then iHours = iHours - 12; end
    end
    if( iHours < 1 ) then iHours = 12; end
  end

  local strTime = string.format("%.d:%.2d%s", iHours, iMins, meridiem);
  Controls.TimeOfDayLabel:SetText(strTime);
end
--------------------------------------------------------------------

function UpdateLengthOfDayLabel(speed:number)
  local length = 24 / speed;
  if length >= 1 then
    -- Add .05 to implement rounding since it's displayed to the tenth and the formatting code does not round.
    Controls.DayLengthLabel:LocalizeAndSetText("LOC_PTK_GLOBAL_HOTKEYS_LENGTH_OF_DAY_FORMATTER_MINUTES", length + .05);
  else
    Controls.DayLengthLabel:LocalizeAndSetText("LOC_PTK_GLOBAL_HOTKEYS_LENGTH_OF_DAY_FORMATTER_SECONDS", length * 60 + .05);
  end
end

function SetTimeOfDayLabelVisibility(showDayLength:boolean)
  Controls.DayLengthContainer:SetHide(not showDayLength);
  Controls.InGameTimeOfDayContainer:SetHide(showDayLength);
end

function UpdateBinaryStatus(enabled:boolean, label:table, slash:table)
  if label then
    label:LocalizeAndSetText(enabled and "LOC_OPTIONS_ENABLED" or "LOC_OPTIONS_DISABLED");
  end
  if slash then
    slash:SetHide(enabled);
  end
end

function SetAmbientTimeOfDaySpeed(multiplier:number)
  -- The value associated with UI.AmbientTimeOfDaySpeed appears to be the number of in-game ambient hours 
  -- that pass per minute of real time.  The default is 1.2 which equates to a 20 minute in-game day.
  -- Cap at 1000 in-game hours/real minute.  The game will actually go about 100 times faster than this before it 
  -- gives up on changing the in-game time of day, but above 1000 we're getting into the epilepsy zone.
  local newValue = math.max(1/60, math.min(multiplier * UI.GetAmbientTimeOfDaySpeed(), 1000));
  UI.SetAmbientTimeOfDaySpeed(newValue);
end

function IsAnimatedTimeOfDay()
  if animatedTimeOfDay == nil then 
    animatedTimeOfDay = Options.GetGraphicsOption("General", "AmbientTimeOfDay") == 1;
  end
  return animatedTimeOfDay;
end

function UpdateVolume(identifier:string, changeMultiplier:number, volumeBar:table, visualOnly:boolean)
  local changeAmount = volumeChangeAmountSetting.Value;
  local currentValue = Options.GetAudioOption("Sound", identifier);
  local newValue = math.max(0, math.min(100, currentValue + changeAmount * changeMultiplier));
  UpdateVolumeTo(identifier, newValue, volumeBar, visualOnly);
  return newValue;
end

function UpdateVolumeTo(identifier:string, volume:number, volumeBar:table, visualOnly:boolean)
  if not visualOnly then
    Options.SetAudioOption("Sound", identifier, volume, 1);
  end
  volumeBar:SetPercent(volume / 100);
end

function UpdateUI()
  local volume = UpdateVolume("Master Volume", 0, Controls.MasterVolumeBar, true);
  UpdateBinaryStatus(volume > 0, nil, Controls.VolumeSlash);
  UpdateVolume("Music Volume", 0, Controls.MusicVolumeBar, true);
  UpdateVolume("SFX Volume", 0, Controls.SoundEffectsVolumeBar, true);
  UpdateVolume("Ambience Volume", 0, Controls.AmbientVolumeBar, true);
  UpdateVolume("Speech Volume", 0, Controls.SpeechVolumeBar, true);

  UpdateBinaryStatus(UserConfiguration.GetValue("QuickCombat") == 1, Controls.QuickCombatStatus, Controls.QuickCombatSlash);
  UpdateBinaryStatus(UserConfiguration.GetValue("QuickMovement") == 1, Controls.QuickMovementStatus, Controls.QuickMovementSlash);
  UpdateBinaryStatus(IsAnimatedTimeOfDay(), nil, Controls.AnimatedTimeOfDaySlash);
  SetTimeOfDayLabelVisibility(IsAnimatedTimeOfDay());
end

function ToggleControlVisibility(control:table, additionalControls:table)
  local hidden = not control:IsHidden();
  control:SetHide(hidden);

  if additionalControls then
    for _, name in ipairs(additionalControls) do
      ContextPtr:LookUpControl(name):SetHide(hidden);
    end
  end
end

function OnInputHandler(input:table)
  if KeyBindingHelper.InputMatches(volumeIncreaseKeyBinding(), input, volumeChangeKeyDownMatchOptions) then
    volumeToDeMute = -1;
    local volume = UpdateVolume("Master Volume", 1, Controls.MasterVolumeBar);
    UpdateBinaryStatus(volume > 0, nil, Controls.VolumeSlash);
    FadeUpdatedVisualContainer(Controls.VolumeContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(volumeDecreaseKeyBinding(), input, volumeChangeKeyDownMatchOptions) then
    volumeToDeMute = -1;
    local volume = UpdateVolume("Master Volume", -1, Controls.MasterVolumeBar);
    UpdateBinaryStatus(volume > 0, nil, Controls.VolumeSlash);
    FadeUpdatedVisualContainer(Controls.VolumeContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(volumeMuteKeyBinding(), input, volumeChangeKeyDownMatchOptions) then
    local currentValue = Options.GetAudioOption("Sound", "Master Volume");
    if currentValue == 0 then
      if volumeToDeMute > 0 then
        UpdateVolumeTo("Master Volume", volumeToDeMute, Controls.MasterVolumeBar);
        UpdateBinaryStatus(true, nil, Controls.VolumeSlash);
        FadeUpdatedVisualContainer(Controls.VolumeContainer);
      end
    else
      volumeToDeMute = currentValue;
      UpdateVolumeTo("Master Volume", 0, Controls.MasterVolumeBar);
      UpdateBinaryStatus(false, nil, Controls.VolumeSlash);
      FadeUpdatedVisualContainer(Controls.VolumeContainer);
    end
    return true;
  elseif KeyBindingHelper.InputMatches(musicVolumeDecreaseKeyBinding(), input, volumeChangeKeyDownMatchOptions) then
    UpdateVolume("Music Volume", -1, Controls.MusicVolumeBar);
    FadeUpdatedVisualContainer(Controls.MusicVolumeContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(musicVolumeIncreaseKeyBinding(), input, volumeChangeKeyDownMatchOptions) then
    UpdateVolume("Music Volume", 1, Controls.MusicVolumeBar);
    FadeUpdatedVisualContainer(Controls.MusicVolumeContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(soundEffectsVolumeDecreaseKeyBinding(), input, volumeChangeKeyDownMatchOptions) then
    UpdateVolume("SFX Volume", -1, Controls.SoundEffectsVolumeBar);
    FadeUpdatedVisualContainer(Controls.SoundEffectsVolumeContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(soundEffectsVolumeIncreaseKeyBinding(), input, volumeChangeKeyDownMatchOptions) then
    UpdateVolume("SFX Volume", 1, Controls.SoundEffectsVolumeBar);
    FadeUpdatedVisualContainer(Controls.SoundEffectsVolumeContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(ambientVolumeDecreaseKeyBinding(), input, volumeChangeKeyDownMatchOptions) then
    UpdateVolume("Ambience Volume", -1, Controls.AmbientVolumeBar);
    FadeUpdatedVisualContainer(Controls.AmbientVolumeContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(ambientVolumeIncreaseKeyBinding(), input, volumeChangeKeyDownMatchOptions) then
    UpdateVolume("Ambience Volume", 1, Controls.AmbientVolumeBar);
    FadeUpdatedVisualContainer(Controls.AmbientVolumeContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(speechVolumeDecreaseKeyBinding(), input, volumeChangeKeyDownMatchOptions) then
    UpdateVolume("Speech Volume", -1, Controls.SpeechVolumeBar);
    FadeUpdatedVisualContainer(Controls.SpeechVolumeContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(speechVolumeIncreaseKeyBinding(), input, volumeChangeKeyDownMatchOptions) then
    UpdateVolume("Speech Volume", 1, Controls.SpeechVolumeBar);
    FadeUpdatedVisualContainer(Controls.SpeechVolumeContainer);
    return true;
  end

  if KeyBindingHelper.InputMatches(toggleQuickCombatKeyBinding(), input, gameplayControlsMatchOptions) then
    local value = UserConfiguration.GetValue("QuickCombat");
    value = value == 0 and 1 or 0;
    UserConfiguration.SetValue("QuickCombat", value);
    UpdateBinaryStatus(value == 1, Controls.QuickCombatStatus, Controls.QuickCombatSlash);
    FadeUpdatedVisualContainer(Controls.QuickCombatContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(toggleQuickMovementKeyBinding(), input, gameplayControlsMatchOptions) then
    local value = UserConfiguration.GetValue("QuickMovement");
    value = value == 0 and 1 or 0;
    UserConfiguration.SetValue("QuickMovement", value);
    UpdateBinaryStatus(value == 1, Controls.QuickMovementStatus, Controls.QuickMovementSlash);
    FadeUpdatedVisualContainer(Controls.QuickMovementContainer);
    return true;
  end

  if KeyBindingHelper.InputMatches(toggleAnimatedTimeOfDayKeyBinding(), input, timeOfDayMatchOptions) then
    animatedTimeOfDay = not IsAnimatedTimeOfDay();
    UI.SetAmbientTimeOfDayAnimating(animatedTimeOfDay);
    UpdateBinaryStatus(animatedTimeOfDay, nil, Controls.AnimatedTimeOfDaySlash);
    SetTimeOfDayLabelVisibility(animatedTimeOfDay);
    FadeUpdatedVisualContainer(Controls.TimeOfDayContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(timeOfDayIncreaseKeyBinding(), input, timeOfDayKeyDownMatchOptions) then
    UI.SetAmbientTimeOfDay(math.fmod(UI.GetAmbientTimeOfDay() + timeOfDayChangeAmountSetting() / 60, 24))
    SetTimeOfDayLabelVisibility(false);
    FadeUpdatedVisualContainer(Controls.TimeOfDayContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(timeOfDayDecreaseKeyBinding(), input, timeOfDayKeyDownMatchOptions) then
    UI.SetAmbientTimeOfDay(math.fmod(UI.GetAmbientTimeOfDay() - timeOfDayChangeAmountSetting() / 60 + 24, 24))
    SetTimeOfDayLabelVisibility(false);
    FadeUpdatedVisualContainer(Controls.TimeOfDayContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(timeOfDaySpeedIncreaseKeyBinding(), input, timeOfDayKeyDownMatchOptions) then
    SetAmbientTimeOfDaySpeed(1 + timeOfDayLengthChangePercentSetting() / 100);
    SetTimeOfDayLabelVisibility(true);
    FadeUpdatedVisualContainer(Controls.TimeOfDayContainer);
    return true;
  elseif KeyBindingHelper.InputMatches(timeOfDaySpeedDecreaseKeyBinding(), input, timeOfDayKeyDownMatchOptions) then
    SetAmbientTimeOfDaySpeed(1 / (1 + timeOfDayLengthChangePercentSetting() / 100));
    SetTimeOfDayLabelVisibility(true);
    FadeUpdatedVisualContainer(Controls.TimeOfDayContainer);
    return true;
  end

  if KeyBindingHelper.InputMatches(toggleCityBannersKeyBinding(), input, graphicTogglesMatchOptions) then
    ToggleControlVisibility(ContextPtr:LookUpControl("/InGame/CityBannerManager"));
  elseif KeyBindingHelper.InputMatches(toggleMapTacksKeyBinding(), input, graphicTogglesMatchOptions) then
    ToggleControlVisibility(ContextPtr:LookUpControl("/InGame/MapPinManager"));
  elseif KeyBindingHelper.InputMatches(toggleUnitIconsKeyBinding(), input, graphicTogglesMatchOptions) then
    ToggleControlVisibility(ContextPtr:LookUpControl("/InGame/UnitFlagManager"));
  elseif KeyBindingHelper.InputMatches(toggleHUDKeyBinding(), input, graphicTogglesMatchOptions) then
    ToggleControlVisibility(ContextPtr:LookUpControl("/InGame/HUD"),
        { 
          "/InGame/WorldViewIconsManager",
          "/InGame/DistrictPlotIconManager",
          "/InGame/PlotInfo",
          "/InGame/UnitFlagManager",
          "/InGame/CityBannerManager",
          "/InGame/TourismBannerManager",
          "/InGame/MapPinManager",
          "/InGame/SelectedUnit",
          "/InGame/SelectedMapPinContainer",
          "/InGame/SelectedUnitContainer",
          "/InGame/WorldViewPlotMessages",
          "/InGame/PartialScreens",
          "/InGame/Screens",
          "/InGame/TopLevelHUD",
          "/InGame/WorldPopups",
        });
  end

  if KeyBindingHelper.InputMatches(minimapSizeIncreaseKeyBinding(), input, minimapSizeKeyDownMatchOptions) then
    minimapSize = math.max(0, math.min(1, minimapSize + minimapChangeAmountSetting() / 100));
    UI.SetMinimapSize(minimapSize);
    return true;
  elseif KeyBindingHelper.InputMatches(minimapSizeDecreaseKeyBinding(), input, minimapSizeKeyDownMatchOptions) then
    minimapSize = math.max(0, math.min(1, minimapSize - minimapChangeAmountSetting() / 100));
    UI.SetMinimapSize(minimapSize);
    return true;
  end
end

function Initialize()
  -- When fade delay elapses start the fade and when that finishes hide the status window.
  Controls.FadeDelay:RegisterEndCallback(
      function()
        Controls.StatusWindowAlpha:Play();
      end);
  Controls.StatusWindowAlpha:RegisterEndCallback(
      function()
        Controls.StatusWindowAlpha:SetHide(true);
      end);
  -- You might think that whenever an option is changed this would be called, but actually it's only 
  -- invoked for some subset of options.  Which includes quick combat/movement, but not animating 
  -- day length.  Firaxis must have been involved at some point.
  Events.UserOptionChanged.Add(UpdateUI);
  ContextPtr:SetInputHandler(OnInputHandler, true);

  -- Addin UIs are hidden by default with the Gathering Storm update.  Need to be "visible" to 
  -- recieve input events.
  ContextPtr:SetHide(false);
  UpdateUI();
end

Initialize();
