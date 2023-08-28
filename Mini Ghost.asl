//Mini Ghost Autosplitter v1.1
//Created by NickRPGreen
//Supports Any% and 100% with splits for item pickup, upgrade purchase, and the final boss.

state("minighost"){
    int IGT: "minighost.exe", 0x208274;             // In-Game-Timer
    int Room: "minighost.exe", 0x347818;            // Semi-unique identifier in most rooms, though some rooms share the same value
    byte GameState: "minighost.exe", 0x2081AC;      // Value of 0 when game isn't running, 1 when game is running
    int MaxCubes: "minighost.exe", 0x31FEF0;        // Maximum number of cubes that can be held
    int MaxHealth: "minighost.exe", 0x31FF20;       // Maximum health Ghost can currently attain

    // Item Pickups
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

init{
    refreshRate = 30;
}

startup{
    // Major Splits
    settings.Add("Major_Splits", true, "Major Splits");
    settings.SetToolTip("Major_Splits", "Bosses 1-3 splits on pickup of the Access Card after defeating the Boss");
    settings.Add("Boss1", true, "Boss Zone 1", "Major_Splits");
    settings.Add("Boss2", true, "Boss Zone 2", "Major_Splits");
    settings.Add("Boss3", true, "Boss Zone 3", "Major_Splits");
    settings.Add("Boss4", true, "Final Boss", "Major_Splits");

    // Any% Item Splits
    settings.Add("AnyItemSplits", true, "Any% Items");
    settings.Add("ServoFeet", true, "Servo Feet", "AnyItemSplits");
    settings.Add("CallbackButton", true, "Callback Button", "AnyItemSplits");
    settings.Add("BatteryUpgrade1", true, "Battery Upgrade 1", "AnyItemSplits");
    settings.Add("AccessCard1", true, "Access Card 1", "AnyItemSplits");
    settings.Add("PiggyBank", true, "Piggy Bank", "AnyItemSplits");
    settings.Add("ProtectionUpgrade1", true, "Protection Upgrade 1", "AnyItemSplits");
    settings.Add("MineDetector", true, "Mine Detector", "AnyItemSplits");
    settings.Add("BatteryUpgrade2", true, "Battery Upgrade 2", "AnyItemSplits");
    settings.Add("Uranium", true, "Uranium", "AnyItemSplits");
    settings.Add("AtomicPower", true, "Atomic Power", "AnyItemSplits");
    settings.Add("Leaf", true, "Leaf", "AnyItemSplits");
    settings.Add("Sniper", true, "Sniper", "AnyItemSplits");

    // 100% Item Splits
    settings.Add("AllItemSplits", false, "100% Items");
    settings.Add("UpgradeCircuit", false, "Upgrade Circuit", "AllItemSplits");
    settings.Add("Multitasking", false, "Multitasking", "AllItemSplits");
    settings.Add("BatteryUpgrade3", false, "Battery Upgrade 3", "AllItemSplits");
    settings.Add("ProtectionUpgrade2", false, "Protection Upgrade 2", "AllItemSplits");
    settings.Add("NightVision", false, "Night Vision", "AllItemSplits");
    settings.Add("BatteryUpgrade4", false, "Battery Upgrade 4", "AllItemSplits");
    settings.Add("Map", false, "Map", "AllItemSplits");
    settings.Add("ForceField", false, "Force Field", "AllItemSplits");
    settings.Add("Magnet", false, "Magnet", "AllItemSplits");
    settings.Add("TwinShot", false, "Twin Shot", "AllItemSplits");
    settings.Add("Knife", false, "Knife", "AllItemSplits");
    settings.Add("TransportCapsule", false, "Transport Capsule", "AllItemSplits");
    settings.Add("ProtectionUpgrade3", false, "Protection Upgrade 3", "AllItemSplits");
    settings.Add("FourLeafClover", false, "Four Leaf Clover", "AllItemSplits");
    settings.Add("ProtectionUpgrade4", false, "Protection Upgrade 4", "AllItemSplits");
}

split{
    // Major Splits
    if(settings["Boss1"] && old.AccessCard2 == 0 && current.AccessCard2 == 1) return true;
    if(settings["Boss2"] && old.AccessCard3 == 0 && current.AccessCard3 == 1) return true;
    if(settings["Boss3"] && old.AccessCard4 == 0 && current.AccessCard4 == 1) return true;
    if(settings["Boss4"] && old.IGT == current.IGT && current.Room == 229) return true;

    // Any%
    if(settings["ServoFeet"] && old.ServoFeet == 0 && current.ServoFeet == 1) return true;
    if(settings["CallbackButton"] && old.CallbackButton == 0 && current.CallbackButton == 1) return true;
    if(settings["BatteryUpgrade1"] && old.MaxCubes == 40 && current.MaxCubes == 80) return true;
    if(settings["AccessCard1"] && old.AccessCard1 == 0 && current.AccessCard1 == 1) return true;
    if(settings["PiggyBank"] && old.PiggyBank == 0 && current.PiggyBank == 1) return true;
    if(settings["ProtectionUpgrade1"] && old.MaxHealth == 8 && current.MaxHealth == 12) return true;
    if(settings["MineDetector"] && old.MineDetector == 0 && current.MineDetector == 1) return true;
    if(settings["BatteryUpgrade2"] && old.MaxCubes == 80 && current.MaxCubes == 120) return true;
    if(settings["Uranium"] && old.Uranium == 0 && current.Uranium == 1) return true;
    if(settings["AtomicPower"] && old.AtomicPower == 0 && current.AtomicPower == 1) return true;
    if(settings["Leaf"] && old.Leaf == 0 && current.Leaf == 1) return true;
    if(settings["Sniper"] && old.Sniper == 0 && current.Sniper == 1) return true;

    // All Items
    if(settings["UpgradeCircuit"] && old.UpgradeCircuit == 0 && current.UpgradeCircuit == 1) return true;
    if(settings["Multitasking"] && old.Multitasking == 0 && current.Multitasking == 1) return true;
    if(settings["BatteryUpgrade3"] && old.MaxCubes == 120 && current.MaxCubes == 160) return true;
    if(settings["ProtectionUpgrade2"] && old.MaxHealth == 12 && current.MaxHealth == 16) return true;
    if(settings["NightVision"] && old.NightVision == 0 && current.NightVision == 1) return true;
    if(settings["BatteryUpgrade4"] && old.MaxCubes == 160 && current.MaxCubes == 200) return true;
    if(settings["Map"] && old.Map == 0 && current.Map == 1) return true;
    if(settings["ForceField"] && old.ForceField == 0 && current.ForceField == 1) return true;
    if(settings["Magnet"] && old.Magnet == 0 && current.Magnet == 1) return true;
    if(settings["TwinShot"] && old.TwinShot == 0 && current.TwinShot == 1) return true;
    if(settings["Knife"] && old.Knife == 0 && current.Knife == 1) return true;
    if(settings["TransportCapsule"] && old.TransportCapsule == 0 && current.TransportCapsule == 1) return true;
    if(settings["ProtectionUpgrade3"] && old.MaxHealth == 16 && current.MaxHealth == 20) return true;
    if(settings["FourLeafClover"] && old.FourLeafClover == 0 && current.FourLeafClover == 1) return true;
    if(settings["ProtectionUpgrade4"] && old.MaxHealth == 20 && current.MaxHealth == 24) return true;
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
    if(old.GameState == 1 && current.GameState == 0 && current.Room != 229) return true; // Room number is required to prevent a reset when defeating the final boss
}
