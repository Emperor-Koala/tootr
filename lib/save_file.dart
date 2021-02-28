import 'dart:math';

enum Medallion {
  None,
  KokiriEmerald,
  GoronRuby,
  ZoraSapphire,
  Light,
  Forest,
  Fire,
  Water,
  Shadow,
  Spirit,
}

extension MD on Medallion {
  String get image {
    switch (this) {
      case Medallion.None:
        return 'Unknown Medallion.png';
      case Medallion.KokiriEmerald:
        return 'Kokiri\'s Emerald.png';
      case Medallion.GoronRuby:
        return 'Goron\'s Ruby.png';
      case Medallion.ZoraSapphire:
        return 'Zora\'s Sapphire.png';
      case Medallion.Light:
        return 'Light Medallion.png';
      case Medallion.Forest:
        return 'Forest Medallion.png';
      case Medallion.Fire:
        return 'Fire Medallion.png';
      case Medallion.Water:
        return 'Water Medallion.png';
      case Medallion.Shadow:
        return 'Shadow Medallion.png';
      case Medallion.Spirit:
        return 'Spirit Medallion.png';
    }
    return 'Unknown Medallion.png';
  }
}

enum MaskQuest {
  None,
  WeirdEgg,
  Cucco,
  ZeldasLetter,
  KeatonMask,
  SkullMask,
  ReDeadMask,
  BunnyHood,
  MaskOfTruth,
}

extension MQ on MaskQuest {
  String get image {
    switch (this) {
      case MaskQuest.None:
        return 'Weird Egg.png';
      case MaskQuest.WeirdEgg:
        return 'Weird Egg.png';
      case MaskQuest.Cucco:
        return 'Cucco.png';
      case MaskQuest.ZeldasLetter:
        return 'Zelda\'s Letter.png';
      case MaskQuest.KeatonMask:
        return 'Keaton Mask.png';
      case MaskQuest.SkullMask:
        return 'Skull Mask.png';
      case MaskQuest.ReDeadMask:
        return 'Spooky Mask.png';
      case MaskQuest.BunnyHood:
        return 'Bunny Hood.png';
      case MaskQuest.MaskOfTruth:
        return 'Mask of Truth.png';
    }
    return 'Weird Egg.png';
  }
}

enum BiggoronQuest {
  None,
  GiantsKnife,
  PocketEgg,
  PocketCucco,
  Cojiro,
  OddMushroom,
  OddPoultice,
  PoachersSaw,
  BrokenGoronsSword,
  Prescription,
  EyeballFrog,
  EyeDrops,
  ClaimCheck
}

extension BQ on BiggoronQuest {
  String get image {
    switch (this) {
      case BiggoronQuest.None:
        return 'Giant\'s Knife.png';
      case BiggoronQuest.GiantsKnife:
        return 'Giant\'s Knife.png';
      case BiggoronQuest.PocketEgg:
        return 'Pocket Egg.png';
      case BiggoronQuest.PocketCucco:
        return 'Pocket Cucco.png';
      case BiggoronQuest.Cojiro:
        return 'Cojiro.png';
      case BiggoronQuest.OddMushroom:
        return 'Odd Mushroom.png';
      case BiggoronQuest.OddPoultice:
        return 'Odd Potion.png';
      case BiggoronQuest.PoachersSaw:
        return 'Poacher\'s Saw.png';
      case BiggoronQuest.BrokenGoronsSword:
        return 'Broken Goron Sword.png';
      case BiggoronQuest.Prescription:
        return 'Prescription.png';
      case BiggoronQuest.EyeballFrog:
        return 'Eyeball Frog.png';
      case BiggoronQuest.EyeDrops:
        return 'World\'s Finest Eyedrops.png';
      case BiggoronQuest.ClaimCheck:
        return 'Claim Check.png';
    }
    return 'Giant\'s Knife.png';
  }
}

class SaveFile {
  String fileName;
  String name;

  bool kokiriSword;
  bool masterSword;
  bool biggoronSword;

  bool dekuSticksTen;
  bool dekuSticksTwenty;
  bool dekuSticksThirty;

  bool dekuNutsTwenty;
  bool dekuNutsThirty;
  bool dekuNutsForty;

  bool bombsTwenty;
  bool bombsThirty;
  bool bombsForty;

  bool bowThirty;
  bool bowForty;
  bool bowFifty;

  MaskQuest maskQuestProgress;

  bool dekuShield;
  bool hylianShield;
  bool mirrorShield;

  bool slingshotThirty;
  bool slingshotForty;
  bool slingshotFifty;

  bool boomerang;

  bool bombchus;

  bool fireArrows;
  bool iceArrows;
  bool lightArrows;

  BiggoronQuest biggoronQuestProgress;

  bool goronTunic;
  bool zoraTunic;

  bool lensOfTruth;

  bool megatonHammer;

  bool hookshot;
  bool longshot;

  int bigPoes; // (0-10)

  bool ironBoots;
  bool hoverBoots;

  bool dinsFire;
  bool faroresWind;
  bool nayrusLove;

  int iceTraps;

  int heartPieces;
  int heartContainers;
  bool doubleDefense;

  int bottles; // (0-4)

  bool rutosLetter;

  int seeds; // (0-10)

  int skultulaTokens; // (0-100)

  bool gupee; // green rupee

  bool gerudoMembership;

  bool goronBracelet;
  bool silverGauntlets;
  bool goldenGauntlets;

  bool zoraScale;
  bool goldenScale;

  bool adultsWallet;
  bool giantsWallet;

  bool magic;
  bool magicUpgrade;

  bool stoneOfAgony;

  bool fairyOcarina;
  bool timeOcarina;

  int blupees;

  bool zeldasLullaby;
  bool eponasSong;
  bool sariasSong;
  bool sunsSong;
  bool songOfTime;
  bool songOfStorms;
  bool preludeOfLight;
  bool minuetOfForest;
  bool boleroOfFire;
  bool serenadeOfWater;
  bool nocturneOfShadow;
  bool requiemOfSpirit;

  int botwKeys; // (0-3)
  int gerudoFortressKeys; // (0-4)
  int gtgKeys; // (0-9)

  bool ganonBossKey;
  int ganonsCastleKeys; // (0-3)

  Medallion freeMedallion;
  bool freeMedallionObtained;

  Medallion dekuTreeMedallion;
  bool dekuTreeMedallionObtained;

  Medallion dodongosCavernMedallion;
  bool dodongosCavernMedallionObtained;

  Medallion jabuJabuMedallion;
  bool jabuJabuMedallionObtained;

  Medallion forestTempleMedallion;
  bool forestTempleMedallionObtained;
  bool forestTempleBossKey;
  int forestTempleKeys; // (0-6)

  Medallion fireTempleMedallion;
  bool fireTempleMedallionObtained;
  bool fireTempleBossKey;
  int fireTempleKeys; // (0-8)

  Medallion waterTempleMedallion;
  bool waterTempleMedallionObtained;
  bool waterTempleBossKey;
  int waterTempleKeys; // (0-6)

  Medallion shadowTempleMedallion;
  bool shadowTempleMedallionObtained;
  bool shadowTempleBossKey;
  int shadowTempleKeys; // (0-6)

  Medallion spiritTempleMedallion;
  bool spiritTempleMedallionObtained;
  bool spiritTempleBossKey;
  int spiritTempleKeys; // (0-7)

  SaveFile(this.fileName, this.name) {
    kokiriSword = false;
    masterSword = false;
    biggoronSword = false;
    dekuSticksTen = false;
    dekuSticksTwenty = false;
    dekuSticksThirty = false;
    dekuNutsTwenty = false;
    dekuNutsThirty = false;
    dekuNutsForty = false;
    bombsTwenty = false;
    bombsThirty = false;
    bombsForty = false;
    bowThirty = false;
    bowForty = false;
    bowFifty = false;
    maskQuestProgress = MaskQuest.None;
    dekuShield = false;
    hylianShield = false;
    mirrorShield = false;
    slingshotThirty = false;
    slingshotForty = false;
    slingshotFifty = false;
    boomerang = false;
    bombchus = false;
    fireArrows = false;
    iceArrows = false;
    lightArrows = false;
    biggoronQuestProgress = BiggoronQuest.None;
    goronTunic = false;
    zoraTunic = false;
    lensOfTruth = false;
    megatonHammer = false;
    hookshot = false;
    longshot = false;
    bigPoes = 0;
    ironBoots = false;
    hoverBoots = false;
    dinsFire = false;
    faroresWind = false;
    nayrusLove = false;
    iceTraps = 0;
    heartPieces = 0;
    heartContainers = 0;
    doubleDefense = false;
    bottles = 0;
    rutosLetter = false;
    seeds = 0;
    skultulaTokens = 0;
    gupee = false;
    gerudoMembership = false;
    goronBracelet = false;
    silverGauntlets = false;
    goldenGauntlets = false;
    zoraScale = false;
    goldenScale = false;
    adultsWallet = false;
    giantsWallet = false;
    magic = false;
    magicUpgrade = false;
    stoneOfAgony = false;
    fairyOcarina = false;
    timeOcarina = false;
    blupees = 0;
    zeldasLullaby = false;
    eponasSong = false;
    sariasSong = false;
    sunsSong = false;
    songOfTime = false;
    songOfStorms = false;
    preludeOfLight = false;
    minuetOfForest = false;
    boleroOfFire = false;
    serenadeOfWater = false;
    nocturneOfShadow = false;
    requiemOfSpirit = false;
    botwKeys = 0;
    gerudoFortressKeys = 0;
    gtgKeys = 0;
    ganonBossKey = false;
    ganonsCastleKeys = 0;
    freeMedallion = Medallion.None;
    freeMedallionObtained = false;
    dekuTreeMedallion = Medallion.None;
    dekuTreeMedallionObtained = false;
    dodongosCavernMedallion = Medallion.None;
    dodongosCavernMedallionObtained = false;
    jabuJabuMedallion = Medallion.None;
    jabuJabuMedallionObtained = false;
    forestTempleMedallion = Medallion.None;
    forestTempleMedallionObtained = false;
    forestTempleBossKey = false;
    forestTempleKeys = 0;
    fireTempleMedallion = Medallion.None;
    fireTempleMedallionObtained = false;
    fireTempleBossKey = false;
    fireTempleKeys = 0;
    waterTempleMedallion = Medallion.None;
    waterTempleMedallionObtained = false;
    waterTempleBossKey = false;
    waterTempleKeys = 0;
    shadowTempleMedallion = Medallion.None;
    shadowTempleMedallionObtained = false;
    shadowTempleBossKey = false;
    shadowTempleKeys = 0;
    spiritTempleMedallion = Medallion.None;
    spiritTempleMedallionObtained = false;
    spiritTempleBossKey = false;
    spiritTempleKeys = 0;
  }

  SaveFile.fromJson(this.fileName, Map<String, dynamic> json) {
    name = json['name'];

    kokiriSword = json['kokiri_sword'];
    masterSword = json['master_sword'];
    biggoronSword = json['biggoron_sword'];

    dekuSticksTen = json['deku_sticks_ten'];
    dekuSticksTwenty = json['deku_sticks_twenty'];
    dekuSticksThirty = json['deku_sticks_thirty'];

    dekuNutsTwenty = json['deku_nuts_twenty'];
    dekuNutsThirty = json['deku_nuts_thirty'];
    dekuNutsForty = json['deku_nuts_forty'];

    bombsTwenty = json['bombs_twenty'];
    bombsThirty = json['bombs_thirty'];
    bombsForty = json['bombs_forty'];

    bowThirty = json['bow_thirty'];
    bowForty = json['bow_forty'];
    bowFifty = json['bow_fifty'];

    maskQuestProgress = MaskQuest.values[
      clamp(0, MaskQuest.values.length, json['mask_quest_progress'])];

    dekuShield = json['deku_shield'];
    hylianShield = json['hylian_shield'];
    mirrorShield = json['mirror_shield'];

    slingshotThirty = json['slingshot_thirty'];
    slingshotForty = json['slingshot_forty'];
    slingshotFifty = json['slingshot_fifty'];

    boomerang = json['boomerang'];

    bombchus = json['bombchus'];

    fireArrows = json['fire_arrows'];
    iceArrows = json['ice_arrows'];
    lightArrows = json['light_arrows'];

    biggoronQuestProgress = BiggoronQuest.values[
      clamp(0, BiggoronQuest.values.length, json['biggoron_quest_progress'])];

    goronTunic = json['goron_tunic'];
    zoraTunic = json['zora_tunic'];

    lensOfTruth = json['lensOfTruth'];

    megatonHammer = json['megaton_hammer'];

    hookshot = json['hookshot'];
    longshot = json['longshot'];

    bigPoes = clamp(0, 10, json['big_poes']);

    ironBoots = json['iron_boots'];
    hoverBoots = json['hover_boots'];

    dinsFire = json['dins_fire'];
    faroresWind = json['farores_wind'];
    nayrusLove = json['nayrus_love'];

    iceTraps = max(0, json['ice_traps']);

    heartPieces = clamp(0, 36, json['heart_pieces']);
    heartContainers = clamp(0, 8, json['heart_containers']);
    doubleDefense = json['double_defense'];

    bottles = clamp(0, 4, json['bottles']);

    rutosLetter = json['rutos_letter'];

    seeds = clamp(0, 10, json['seeds']);

    skultulaTokens = clamp(0, 100, json['skultula_tokens']);

    gupee = json['gupee'];

    gerudoMembership = json['gerudo_membership'];

    goronBracelet = json['goron_bracelet'];
    silverGauntlets = json['silver_gauntlets'];
    goldenGauntlets = json['golden_gauntlets'];

    zoraScale = json['zora_scale'];
    goldenScale = json['golden_scale'];

    adultsWallet = json['adults_wallet'];
    giantsWallet = json['giants_wallet'];

    magic = json['magic'];
    magicUpgrade = json['magic_upgrade'];

    stoneOfAgony = json['stone_of_agony'];

    fairyOcarina = json['fairy_ocarina'];
    timeOcarina = json['time_ocarina'];

    blupees = max(0, json['blupees']);

    zeldasLullaby = json['zeldas_lullaby'];
    eponasSong = json['eponas_song'];
    sariasSong = json['sarias_song'];
    sunsSong = json['suns_song'];
    songOfTime = json['song_of_time'];
    songOfStorms = json['song_of_storms'];
    preludeOfLight = json['prelude_of_light'];
    minuetOfForest = json['minuet_of_forest'];
    boleroOfFire = json['bolero_of_fire'];
    serenadeOfWater = json['serenade_of_water'];
    nocturneOfShadow = json['nocturne_of_shadow'];
    requiemOfSpirit = json['requiem_of_spirit'];

    botwKeys = clamp(0, 3, json['botw_keys']);
    gerudoFortressKeys = clamp(0, 4, json['gerudo_fortress_keys']);
    gtgKeys = clamp(0, 9, json['gtg_keys']);

    ganonBossKey = json['ganon_boss_key'];
    ganonsCastleKeys = clamp(0, 3, json['ganons_castle_keys']);

    freeMedallion = Medallion.values[
      clamp(0, Medallion.values.length-1, json['free_medallion'])];
    freeMedallionObtained = json['free_medallion_obtained'] ?? false;

    dekuTreeMedallion = Medallion.values[
      clamp(0, Medallion.values.length-1, json['deku_tree_medallion'])];
    dekuTreeMedallionObtained = json['deku_tree_medallion_obtained'];

    dodongosCavernMedallion = Medallion.values[
      clamp(0, Medallion.values.length-1, json['dodongos_cavern_medallion'])];
    dodongosCavernMedallionObtained = json['dodongos_cavern_medallion_obtained'];

    jabuJabuMedallion = Medallion.values[
      clamp(0, Medallion.values.length-1, json['jabu_jabu_medallion'])];
    jabuJabuMedallionObtained = json['jabu_jabu_medallion_obtained'];

    forestTempleMedallion = Medallion.values[
      clamp(0, Medallion.values.length-1, json['forest_temple_medallion'])];
    forestTempleMedallionObtained = json['forest_temple_medallion_obtained'];
    forestTempleBossKey = json['forest_temple_boss_key'];
    forestTempleKeys = clamp(0, 6, json['forest_temple_keys']); // (0-6)

    fireTempleMedallion = Medallion.values[
      clamp(0, Medallion.values.length-1, json['fire_temple_medallion'])];
    fireTempleMedallionObtained = json['fire_temple_medallion_obtained'];
    fireTempleBossKey = json['fire_temple_boss_key'];
    fireTempleKeys = clamp(0, 8, json['fire_temple_keys']); // (0-8)

    waterTempleMedallion = Medallion.values[
      clamp(0, Medallion.values.length-1, json['water_temple_medallion'])];
    waterTempleMedallionObtained = json['water_temple_medallion_obtained'];
    waterTempleBossKey = json['water_temple_boss_key'];
    waterTempleKeys = clamp(0, 6, json['water_temple_keys']); // (0-6)

    shadowTempleMedallion = Medallion.values[
      clamp(0, Medallion.values.length-1, json['shadow_temple_medallion'])];
    shadowTempleMedallionObtained = json['shadow_temple_medallion_obtained'];
    shadowTempleBossKey = json['shadow_temple_boss_key'];
    shadowTempleKeys = clamp(0, 6, json['shadow_temple_keys']); // (0-6)

    spiritTempleMedallion = Medallion.values[
      clamp(0, Medallion.values.length-1, json['spirit_temple_medallion'])];
    spiritTempleMedallionObtained = json['spirit_temple_medallion_obtained'];
    spiritTempleBossKey = json['spirit_temple_boss_key'];
    spiritTempleKeys = clamp(0, 7, json['spirit_temple_keys']); // (0-7)

  }

  Map<String, dynamic> toJson() => {
    'name': name ?? fileName,
    'kokiri_sword': kokiriSword ?? false,
    'master_sword': masterSword ?? false,
    'biggoron_sword': biggoronSword ?? false,
    'deku_sticks_ten': dekuSticksTen ?? false,
    'deku_sticks_twenty': dekuSticksTwenty ?? false,
    'deku_sticks_thirty': dekuSticksThirty ?? false,
    'deku_nuts_twenty': dekuNutsTwenty ?? false,
    'deku_nuts_thirty': dekuNutsThirty ?? false,
    'deku_nuts_forty': dekuNutsForty ?? false,
    'bombs_twenty': bombsTwenty ?? false,
    'bombs_thirty': bombsThirty ?? false,
    'bombs_forty': bombsForty ?? false,
    'bow_thirty': bowThirty ?? false,
    'bow_forty': bowForty ?? false,
    'bow_fifty': bowFifty ?? false,
    'mask_quest_progress': maskQuestProgress?.index ?? 0,
    'deku_shield': dekuShield ?? false,
    'hylian_shield': hylianShield ?? false,
    'mirror_shield': mirrorShield ?? false,
    'slingshot_thirty': slingshotThirty ?? false,
    'slingshot_forty': slingshotForty ?? false,
    'slingshot_fifty': slingshotFifty ?? false,
    'boomerang': boomerang ?? false,
    'bombchus': bombchus ?? false,
    'fire_arrows': fireArrows ?? false,
    'ice_arrows': iceArrows ?? false,
    'light_arrows': lightArrows ?? false,
    'biggoron_quest_progress': biggoronQuestProgress?.index ?? 0,
    'goron_tunic': goronTunic ?? false,
    'zora_tunic': zoraTunic ?? false,
    'lens_of_truth': lensOfTruth ?? false,
    'megaton_hammer': megatonHammer ?? false,
    'hookshot': hookshot ?? false,
    'longshot': longshot ?? false,
    'big_poes': bigPoes ?? 0,
    'iron_boots': ironBoots ?? false,
    'hover_boots': hoverBoots ?? false,
    'dins_fire': dinsFire ?? false,
    'farores_wind': faroresWind ?? false,
    'nayrus_love': nayrusLove ?? false,
    'ice_traps': iceTraps ?? 0,
    'heart_pieces': heartPieces ?? 0,
    'heart_containers': heartContainers ?? 0,
    'double_defense': doubleDefense ?? false,
    'bottles': bottles ?? 0,
    'rutos_letter': rutosLetter ?? false,
    'seeds': seeds ?? 0,
    'skultula_tokens': skultulaTokens ?? 0,
    'gupee': gupee ?? false,
    'gerudo_membership': gerudoMembership ?? false,
    'goron_bracelet': goronBracelet ?? false,
    'silver_gauntlets': silverGauntlets ?? false,
    'golden_gauntlets': goldenGauntlets ?? false,
    'zora_scale': zoraScale ?? false,
    'golden_scale': goldenScale ?? false,
    'adults_wallet': adultsWallet ?? false,
    'giants_wallet': giantsWallet ?? false,
    'magic': magic ?? false,
    'magic_upgrade': magicUpgrade ?? false,
    'stone_of_agony': stoneOfAgony ?? false,
    'fairy_ocarina': fairyOcarina ?? false,
    'time_ocarina': timeOcarina ?? false,
    'blupees': blupees ?? 0,
    'zeldas_lullaby': zeldasLullaby ?? false,
    'eponas_song': eponasSong ?? false,
    'sarias_song': sariasSong ?? false,
    'suns_song': sunsSong ?? false,
    'song_of_time': songOfTime ?? false,
    'song_of_storms': songOfStorms ?? false,
    'prelude_of_light': preludeOfLight ?? false,
    'minuet_of_forest': minuetOfForest ?? false,
    'bolero_of_fire': boleroOfFire ?? false,
    'serenade_of_water': serenadeOfWater ?? false,
    'nocturne_of_shadow': nocturneOfShadow ?? false,
    'requiem_of_spirit': requiemOfSpirit ?? false,
    'botw_keys': botwKeys ?? 0,
    'gerudo_fortress_keys': gerudoFortressKeys ?? 0,
    'gtg_keys': gtgKeys ?? 0,
    'ganon_boss_key': ganonBossKey ?? false,
    'ganons_castle_keys': ganonsCastleKeys ?? 0,
    'free_medallion': freeMedallion?.index ?? 0,
    'free_medallion_obtained': freeMedallionObtained ?? false,
    'deku_tree_medallion': dekuTreeMedallion?.index ?? 0,
    'deku_tree_medallion_obtained': dekuTreeMedallionObtained ?? false,
    'dodongos_cavern_medallion': dodongosCavernMedallion?.index ?? 0,
    'dodongos_cavern_medallion_obtained': dodongosCavernMedallionObtained ?? false,
    'jabu_jabu_medallion': jabuJabuMedallion?.index ?? 0,
    'jabu_jabu_medallion_obtained': jabuJabuMedallionObtained ?? false,
    'forest_temple_medallion': forestTempleMedallion?.index ?? 0,
    'forest_temple_medallion_obtained': forestTempleMedallionObtained ?? false,
    'forest_temple_boss_key': forestTempleBossKey ?? false,
    'forest_temple_keys': forestTempleKeys ?? 0,
    'fire_temple_medallion': fireTempleMedallion?.index ?? 0,
    'fire_temple_medallion_obtained': fireTempleMedallionObtained ?? false,
    'fire_temple_boss_key': fireTempleBossKey ?? false,
    'fire_temple_keys': fireTempleKeys ?? 0,
    'water_temple_medallion': waterTempleMedallion?.index ?? 0,
    'water_temple_medallion_obtained': waterTempleMedallionObtained ?? false,
    'water_temple_boss_key': waterTempleBossKey ?? false,
    'water_temple_keys': waterTempleKeys ?? 0,
    'shadow_temple_medallion': shadowTempleMedallion?.index ?? 0,
    'shadow_temple_medallion_obtained': shadowTempleMedallionObtained ?? false,
    'shadow_temple_boss_key': shadowTempleBossKey ?? false,
    'shadow_temple_keys': shadowTempleKeys ?? 0,
    'spirit_temple_medallion': spiritTempleMedallion?.index ?? 0,
    'spirit_temple_medallion_obtained': spiritTempleMedallionObtained ?? false,
    'spirit_temple_boss_key': spiritTempleBossKey ?? false,
    'spirit_temple_keys': spiritTempleKeys ?? 0,
  };

}

num clamp(num minVal, num maxVal, num value) => max(minVal, min(maxVal, value));
