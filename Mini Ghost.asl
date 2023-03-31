//Mini Ghost Autosplitter
//Created by NickRPGreen 

state("minighost"){
    int IGT: "minighost.exe", 0x208274;             // In-Game-Timer
    int Room: "minighost.exe", 0x347818;            // Semi-unique identifier in most rooms, though some rooms share the same value
    byte GameState: "minighost.exe", 0x2081AC;      // Value of 0 when game isn't running, 1 when game is running
    int MaxCubes: "minighost.exe", 0x31FEF0;        // Maximum number of cubes that can be held
    int CurrentHealth: "minighost.exe", 0x31FF1C;   // Current health of Ghost
    int MaxHealth: "minighost.exe", 0x31FF20;       // Maximum health Ghost can currently attain
    int FinalBoss: "minighost.exe", 0x3200FC;       // Health of the final boss, dies when this value hits 1

    // Item Pickups (Not all are used)
    byte MineDetector: "minighost.exe", 0x31FEFC;
    byte PiggyBank: "minighost.exe", 0x31FEFD;
    byte Sniper: "minighost.exe", 0x31FEFE;
    byte NightVision: "minighost.exe", 0x31FEFF;
    byte Leaf: "minighost.exe", 0x31FF00;
    byte Uranium: "minighost.exe", 0x31FF01;
    byte UpgradeCircuit: "minighost.exe", 0x31FF02;
    byte Knife: "minighost.exe", 0x31FF03;
    byte CallbackButton: "minighost.exe", 0x31FF04;
    byte ServoFeet: "minighost.exe", 0x31FF05;
    byte Multitasking: "minighost.exe", 0x31FF06;
    byte AccessCard1: "minighost.exe", 0x31FF07;
    byte AccessCard2: "minighost.exe", 0x31FF08;
    byte AccessCard3: "minighost.exe", 0x31FF09;
    byte AccessCard4: "minighost.exe", 0x31FF0A;
    byte Protection: "minighost.exe", 0x31FF0B;
    byte Battery: "minighost.exe", 0x31FF0C;
    byte Map: "minighost.exe", 0x31FF0D;
    byte ForceField: "minighost.exe", 0x31FF0E;
    byte TransportCapsule: "minighost.exe", 0x31FF0F;
    byte AtomicPower: "minighost.exe", 0x31FF10;
    byte Magnet: "minighost.exe", 0x31FF11;
    byte TwinShot: "minighost.exe", 0x31FF12;
    byte FourLeafClover: "minighost.exe", 0x31FF13;
}

startup{
    // Major Splits
    settings.Add("Major_Splits", true, "Major Splits");
    settings.SetToolTip("Major_Splits", "Bosses 1-3 splits on pickup of the Access Card after defeating the Boss");
    settings.Add("Boss1", true, "Boss Zone 1", "Major_Splits");
    settings.Add("Boss2", true, "Boss Zone 2", "Major_Splits");
    settings.Add("Boss3", true, "Boss Zone 3", "Major_Splits");
    settings.Add("Boss4", true, "Computer Boss", "Major_Splits");

    // Item Splits
    settings.Add("Item_Splits", true, "Item Splits");
    settings.Add("ServoFeet", true, "Servo Feet", "Item_Splits");
    settings.Add("CallbackButton", true, "Callback Button", "Item_Splits");
    settings.Add("PiggyBank", true, "Piggy Bank", "Item_Splits");
    settings.Add("BatteryUpgrade1", true, "Battery Upgrade 1", "Item_Splits");
    settings.Add("AccessCard1", true, "Access Card 1", "Item_Splits");
    settings.Add("ProtectionUpgrade1", true, "Protection Upgrade 1", "Item_Splits");
    settings.Add("MineDetector", true, "Mine Detector", "Item_Splits");
    settings.Add("Multitasking", true, "Multitasking", "Item_Splits");
    settings.Add("BatteryUpgrade2", true, "Battery Upgrade 2", "Item_Splits");
    settings.Add("Uranium", true, "Uranium", "Item_Splits");
    settings.Add("AtomicPower", true, "Atomic Power", "Item_Splits");
    settings.Add("Leaf", true, "Leaf", "Item_Splits");
    settings.Add("Sniper", true, "Sniper", "Item_Splits");
}

split{
    if(settings["ServoFeet"] && old.ServoFeet == 0 && current.ServoFeet == 1) return true;
    if(settings["CallbackButton"] && old.CallbackButton == 0 && current.CallbackButton == 1) return true;
    if(settings["PiggyBank"] && old.PiggyBank == 0 && current.PiggyBank == 1) return true;
    if(settings["BatteryUpgrade1"] && old.MaxCubes == 40 && current.MaxCubes == 80) return true;
    if(settings["AccessCard1"] && old.AccessCard1 == 0 && current.AccessCard1 == 1) return true;
    if(settings["ProtectionUpgrade1"] && old.MaxHealth == 8 && current.MaxHealth == 12) return true;
    if(settings["MineDetector"] && old.MineDetector == 0 && current.MineDetector == 1) return true;
    if(settings["Boss1"] && old.AccessCard2 == 0 && current.AccessCard2 == 1) return true;
    if(settings["Multitasking"] && old.Multitasking == 0 && current.Multitasking == 1) return true;
    if(settings["BatteryUpgrade2"] && old.MaxCubes == 80 && current.MaxCubes == 120) return true;
    if(settings["Uranium"] && old.Uranium == 0 && current.Uranium == 1) return true;
    if(settings["Boss2"] && old.AccessCard3 == 0 && current.AccessCard3 == 1) return true;
    if(settings["Boss3"] && old.AccessCard4 == 0 && current.AccessCard4 == 1) return true;
    if(settings["AtomicPower"] && old.AtomicPower == 0 && current.AtomicPower == 1) return true;
    if(settings["Leaf"] && old.Leaf == 0 && current.Leaf == 1) return true;
    if(settings["Sniper"] && old.Sniper == 0 && current.Sniper == 1) return true;
    if(settings["Boss4"] && current.FinalBoss == 1 && current.Room == 229 && current.AccessCard4 == 1) return true;     // Room 229 is shared with another room, so only splits if Access Card 4 has been obtained
}

start{
    return old.IGT == 0 && current.IGT > 0;
}

gameTime{
    return TimeSpan.FromMilliseconds(current.IGT*10);
}

isLoading{
    return true;
}

reset{
    if(old.GameState == 1 && current.GameState == 0 && current.Room != 229) return true;                                // Prevents a reset when defeating the final boss
}