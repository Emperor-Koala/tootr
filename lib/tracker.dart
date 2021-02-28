import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tootr/save_file.dart';

const Duration animDuration = Duration(milliseconds: 300);

class Tracker extends StatefulWidget {

  final SaveFile saveFile;

  Tracker(this.saveFile);

  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      saveTimer?.cancel();
      forceSave();
    }
    if (state == AppLifecycleState.resumed) {
      if (saveTimer == null || !saveTimer.isActive)
        saveTimer = Timer.periodic(Duration(seconds: 10), (timer) {
          if (valuesChanged) {
            forceSave();
            valuesChanged = false;
          }
        });
    }
  }

  bool valuesChanged = false;

  Timer saveTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    saveTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (valuesChanged) {
        forceSave();
        valuesChanged = false;
      }
    });
  }

  void forceSave() async {
    await File('${(await getApplicationDocumentsDirectory()).path}/${widget.saveFile.fileName}').writeAsString(jsonEncode(widget.saveFile.toJson()));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    saveTimer?.cancel();
    forceSave();
    super.dispose();
  }

  List<Widget> get _swords => [
    ToggleItemButton(
      image: 'Kokiri Sword.png',
      right: true,
      initialState: widget.saveFile.kokiriSword,
      onChanged: (v) {
        widget.saveFile.kokiriSword = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Master Sword.png',
      left: true,
      right: true,
      initialState: widget.saveFile.masterSword,
      onChanged: (v) {
        widget.saveFile.masterSword = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Biggoron Sword.png',
      left: true,
      initialState: widget.saveFile.biggoronSword,
      onChanged: (v) {
        widget.saveFile.biggoronSword = v;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  List<Widget> get _shields => [
    ToggleItemButton(
      image: 'Deku Shield.png',
      right: true,
      initialState: widget.saveFile.dekuShield,
      onChanged: (v) {
        widget.saveFile.dekuShield = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Hylian Shield.png',
      left: true,
      right: true,
      initialState: widget.saveFile.hylianShield,
      onChanged: (v) {
        widget.saveFile.hylianShield = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Mirror Shield.png',
      left: true,
      initialState: widget.saveFile.mirrorShield,
      onChanged: (v) {
        widget.saveFile.mirrorShield = v;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  List<Widget> get _bombs => [
    IncrementingItemButton(
      image: 'Bombs.png',
      right: true,
      initialValue: widget.saveFile.bombsForty ? 40 : widget.saveFile.bombsThirty ? 30 : widget.saveFile.bombsTwenty ? 20 : 0,
      increment: widget.saveFile.bombsTwenty ? 10 : 20,
      decrement: widget.saveFile.bombsThirty ? 10 : 20,
      maxValue: 40,
      onChanged: (val) {
        widget.saveFile.bombsTwenty = val >= 20;
        widget.saveFile.bombsThirty = val >= 30;
        widget.saveFile.bombsForty = val >= 40;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Bombchus.png',
      left: true,
      initialState: widget.saveFile.bombchus,
      onChanged: (v) {
        widget.saveFile.bombchus = v;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  List<Widget> get _goddessesGifts => [
    ToggleItemButton(
      image: 'Din\'s Fire.png',
      right: true,
      initialState: widget.saveFile.dinsFire,
      onChanged: (v) {
        widget.saveFile.dinsFire = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Farore\'s Wind.png',
      left: true,
      right: true,
      initialState: widget.saveFile.faroresWind,
      onChanged: (v) {
        widget.saveFile.faroresWind = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Nayru\'s Love.png',
      left: true,
      initialState: widget.saveFile.nayrusLove,
      onChanged: (v) {
        widget.saveFile.nayrusLove = v;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  List<Widget> get _hearts => [
    IncrementingItemButton(
      image: 'Heart Piece.png',
      right: true,
      maxValue: 36,
      initialValue: widget.saveFile.heartPieces,
      onChanged: (v) {
        widget.saveFile.heartPieces = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    IncrementingItemButton(
      image: 'Heart Container.png',
      left: true,
      right: true,
      maxValue: 8,
      initialValue: widget.saveFile.heartContainers,
      onChanged: (v) {
        widget.saveFile.heartContainers = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Double Defense.png',
      left: true,
      initialState: widget.saveFile.doubleDefense,
      onChanged: (v) {
        widget.saveFile.doubleDefense = v;
        valuesChanged = true;
        setState((){});
      },
    )
  ];

  List<Widget> get _tunics => [
    Container(
      padding: EdgeInsets.only(
        top: 3,
        left: 3,
      ),
      child: Container(
        padding: EdgeInsets.only(
          right: 3,
          bottom: 3,
        ),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          'assets/Kokiri Tunic.png',
        ),
      ),
    ),
    ToggleItemButton(
      image: 'Goron Tunic.png',
      left: true,
      right: true,
      bottom: true,
      initialState: widget.saveFile.goronTunic,
      onChanged: (v) {
        widget.saveFile.goronTunic = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Zora Tunic.png',
      left: true,
      bottom: true,
      initialState: widget.saveFile.zoraTunic,
      onChanged: (v) {
        widget.saveFile.zoraTunic = v;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  List<Widget> get _boots => [
    Container(
      padding: EdgeInsets.only(
        bottom: 3,
        left: 3,
      ),
      child: Container(
        padding: EdgeInsets.only(
          right: 3,
          top: 3,
        ),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          'assets/Kokiri Boots.png',
        ),
      ),
    ),
    ToggleItemButton(
      image: 'Iron Boots.png',
      left: true,
      right: true,
      top: true,
      initialState: widget.saveFile.ironBoots,
      onChanged: (v) {
        widget.saveFile.ironBoots = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Hover Boots.png',
      left: true,
      top: true,
      initialState: widget.saveFile.hoverBoots,
      onChanged: (v) {
        widget.saveFile.hoverBoots = v;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  List<Widget> get _storyProgress => [
    MaskQuestButton(
      right: true,
      initialValue: widget.saveFile.maskQuestProgress.index,
      onChanged: (v) {
        widget.saveFile.maskQuestProgress = MaskQuest.values[v];
        valuesChanged = true;
        setState((){});
      },
    ),
    BiggoronQuestButton(
      left: true,
      right: true,
      initialValue: widget.saveFile.biggoronQuestProgress.index,
      onChanged: (v) {
        widget.saveFile.biggoronQuestProgress = BiggoronQuest.values[v];
        valuesChanged = true;
        setState((){});
      },
    ),
    IncrementingItemButton(
      image: 'Big Poe.png',
      left: true,
      maxValue: 10,
      initialValue: widget.saveFile.bigPoes,
      onChanged: (v) {
        widget.saveFile.bigPoes = v;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  List<Widget> get _inconsequentials => [
    IncrementingItemButton(
      image: 'Ice Trap.png',
      right: true,
      initialValue: widget.saveFile.iceTraps,
      onChanged: (v) {
        widget.saveFile.iceTraps = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    IncrementingItemButton(
      image: 'Blue Rupee.png',
      left: true,
      right: true,
      initialValue: widget.saveFile.blupees,
      onChanged: (v) {
        widget.saveFile.blupees = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Green Rupee.png',
      left: true,
      initialState: widget.saveFile.gupee,
      onChanged: (v) {
        widget.saveFile.gupee = v;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  List<Widget> get _deku => [
    // Deku Sticks
    IncrementingItemButton(
      right: true,
      image: 'Deku Stick.png',
      increment: 10,
      maxValue: 30,
      initialValue: widget.saveFile.dekuSticksThirty ? 30 : widget.saveFile.dekuSticksTwenty ? 20 : widget.saveFile.dekuSticksTen ? 10 : 0,
      onChanged: (v) {
        widget.saveFile.dekuSticksTen = v >= 10;
        widget.saveFile.dekuSticksTwenty = v >= 20;
        widget.saveFile.dekuSticksThirty = v >= 30;
        valuesChanged = true;
        setState((){});
      },
    ),

    // Deku Nuts
    IncrementingItemButton(
      left: true,
      image: 'Deku Nut.png',
      increment: widget.saveFile.dekuNutsTwenty ? 10 : 20,
      decrement: widget.saveFile.dekuNutsThirty ? 10 : 20,
      maxValue: 40,
      initialValue: widget.saveFile.dekuNutsForty ? 40 : widget.saveFile.dekuNutsThirty ? 30 : widget.saveFile.dekuNutsTwenty ? 20 : 0,
      onChanged: (val) {
        widget.saveFile.dekuNutsTwenty = val >= 20;
        widget.saveFile.dekuNutsThirty = val >= 30;
        widget.saveFile.dekuNutsForty = val >= 40;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  List<Widget> get _childWeapons => [
    // Slingshot
    IncrementingItemButton(
      right: true,
      image: 'Slingshot.png',
      increment: widget.saveFile.slingshotThirty ? 10 : 30,
      decrement: widget.saveFile.slingshotForty ? 10 : 30,
      maxValue: 50,
      initialValue: widget.saveFile.slingshotFifty ? 50 : widget.saveFile.slingshotForty ? 40 : widget.saveFile.slingshotThirty ? 30 : 0,
      onChanged: (val) {
        widget.saveFile.slingshotThirty = val >= 30;
        widget.saveFile.slingshotForty = val >= 40;
        widget.saveFile.slingshotFifty = val >= 50;
        valuesChanged = true;
        setState((){});
      },
    ),

    // Boomerang
    ToggleItemButton(
      image: 'Boomerang.png',
      left: true,
      initialState: widget.saveFile.boomerang,
      onChanged: (v) {
        widget.saveFile.boomerang = v;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  List<Widget> get _songs => [
    ToggleItemButton(
      image: 'Zelda\'s Lullaby.png',
      right: true,
      initialState: widget.saveFile.zeldasLullaby,
      onChanged: (v) {
        widget.saveFile.zeldasLullaby = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Epona\'s Song.png',
      left: true,
      right: true,
      initialState: widget.saveFile.eponasSong,
      onChanged: (v) {
        widget.saveFile.eponasSong = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Saria\'s Song.png',
      left: true,
      right: true,
      initialState: widget.saveFile.sariasSong,
      onChanged: (v) {
        widget.saveFile.sariasSong = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Sun\'s Song.png',
      left: true,
      right: true,
      initialState: widget.saveFile.sunsSong,
      onChanged: (v) {
        widget.saveFile.sunsSong = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Song of Time.png',
      left: true,
      right: true,
      initialState: widget.saveFile.songOfTime,
      onChanged: (v) {
        widget.saveFile.songOfTime = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Song of Storms.png',
      left: true,
      initialState: widget.saveFile.songOfStorms,
      onChanged: (v) {
        widget.saveFile.songOfStorms = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Prelude of Light.png',
      right: true,
      initialState: widget.saveFile.preludeOfLight,
      onChanged: (v) {
        widget.saveFile.preludeOfLight = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Minuet of Forest.png',
      right: true,
      left: true,
      initialState: widget.saveFile.minuetOfForest,
      onChanged: (v) {
        widget.saveFile.minuetOfForest = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Bolero of Fire.png',
      right: true,
      left: true,
      initialState: widget.saveFile.boleroOfFire,
      onChanged: (v) {
        widget.saveFile.boleroOfFire = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Serenade of Water.png',
      right: true,
      left: true,
      initialState: widget.saveFile.serenadeOfWater,
      onChanged: (v) {
        widget.saveFile.serenadeOfWater = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Nocturne of Shadow.png',
      right: true,
      left: true,
      initialState: widget.saveFile.nocturneOfShadow,
      onChanged: (v) {
        widget.saveFile.nocturneOfShadow = v;
        valuesChanged = true;
        setState((){});
      },
    ),
    ToggleItemButton(
      image: 'Requiem of Spirit.png',
      left : true,
      initialState: widget.saveFile.requiemOfSpirit,
      onChanged: (v) {
        widget.saveFile.requiemOfSpirit = v;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  List<Widget> get _strengthSwim => [
    UpgradeableItemButton(
      images: ['Goron\'s Bracelet.png', 'Silver Gauntlets.png', 'Gold Gauntlets.png'],
      right: true,
      initialState: widget.saveFile.goldenGauntlets ? 3 : widget.saveFile.silverGauntlets ? 2 : widget.saveFile.goronBracelet ? 1 : 0,
      onChanged: (v) {
        widget.saveFile.goronBracelet = v >= 1;
        widget.saveFile.silverGauntlets = v >= 2;
        widget.saveFile.goldenGauntlets = v >= 3;
        valuesChanged = true;
        setState((){});
      },
    ),

    // Scales
    UpgradeableItemButton(
      images: ['Silver Scale.png', 'Golden Scale.png'],
      left: true,
      initialState: widget.saveFile.goldenScale ? 2 : widget.saveFile.zoraScale ? 1 : 0,
      onChanged: (v) {
        widget.saveFile.zoraScale = v >= 1;
        widget.saveFile.goldenScale = v >= 2;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  List<Widget> get _adultWeapons => [
    // Megaton Hammer
    ToggleItemButton(
      image: 'Megaton Hammer.png',
      right: true,
      initialState: widget.saveFile.megatonHammer,
      onChanged: (v) {
        widget.saveFile.megatonHammer = v;
        valuesChanged = true;
        setState((){});
      },
    ),

    // Hookshot/Longshot
    UpgradeableItemButton(
      images: ['Hookshot.png', 'Longshot.png'],
      left: true,
      initialState: widget.saveFile.longshot ? 2 : widget.saveFile.hookshot ? 1 : 0,
      onChanged: (v) {
        widget.saveFile.hookshot = v >= 1;
        widget.saveFile.longshot = v >= 2;
        valuesChanged = true;
        setState(() {});
      },
    ),
  ];

  List<Widget> get _bottles => [
    // Bottles
    IncrementingItemButton(
      image: 'Bottle.png',
      maxValue: 4,
      right: true,
      initialValue: widget.saveFile.bottles,
      onChanged: (v) {
        widget.saveFile.bottles = v;
        valuesChanged = true;
        setState((){});
      },
    ),

    // Ruto's Letter
    ToggleItemButton(
      image: 'Ruto\'s Letter.png',
      left: true,
      initialState: widget.saveFile.rutosLetter,
      onChanged: (v) {
        widget.saveFile.rutosLetter = v;
        valuesChanged = true;
        setState((){});
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.saveFile.name ?? widget.saveFile.fileName ?? 'No Name'),
      ),
      body: ListView(
        children: [
          GridView.count(
            crossAxisCount: 6,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 7),
            shrinkWrap: true,
            children: [
              ..._swords,

              ..._deku,

              IncrementingItemButton(
                image: 'Fairy Bow.png',
                bottom: true,
                increment: widget.saveFile.bowThirty ? 10 : 30,
                decrement: widget.saveFile.bowForty ? 10 : 30,
                maxValue: 50,
                initialValue: widget.saveFile.bowFifty ? 50 : widget.saveFile.bowForty ? 40 : widget.saveFile.bowThirty ? 30 : 0,
                onChanged: (val) {
                  widget.saveFile.bowThirty = val >= 30;
                  widget.saveFile.bowForty = val >= 40;
                  widget.saveFile.bowFifty = val >= 50;
                  valuesChanged = true;
                  setState((){});
                },
              ),

              ..._shields,

              ..._childWeapons,

              ToggleItemButton(
                image: 'Fire Arrows.png',
                top: true,
                bottom: true,
                initialState: widget.saveFile.fireArrows,
                onChanged: (v) {
                  widget.saveFile.fireArrows = v;
                  valuesChanged = true;
                  setState((){});
                },
              ),

              ..._tunics,

              // Bombs
              ..._bombs,

              ToggleItemButton(
                image: 'Ice Arrows.png',
                top: true,
                bottom: true,
                initialState: widget.saveFile.iceArrows,
                onChanged: (v) {
                  widget.saveFile.iceArrows = v;
                  valuesChanged = true;
                  setState((){});
                },
              ),

              ..._boots,

              // Beans
              IncrementingItemButton(
                image: 'Magic Beans.png',
                maxValue: 10,
                initialValue: widget.saveFile.seeds,
                onChanged: (v) {
                  widget.saveFile.seeds = v;
                  valuesChanged = true;
                  setState((){});
                },
              ),

              // Gold Skulltula Tokens
              IncrementingItemButton(
                image: 'Gold Skulltula Token.png',
                maxValue: 100,
                initialValue: widget.saveFile.skultulaTokens,
                onChanged: (v) {
                  widget.saveFile.skultulaTokens = v;
                  valuesChanged = true;
                  setState((){});
                },
              ),

              ToggleItemButton(
                image: 'Light Arrows.png',
                top: true,
                initialState: widget.saveFile.lightArrows,
                onChanged: (v) {
                  widget.saveFile.lightArrows = v;
                  valuesChanged = true;
                  setState((){});
                },),

              // Wallets
              UpgradeableItemButton(
                images: ['Bomb Bag.png', 'Adult Wallet.png', 'Giant\'s Wallet.png'],
                min: 1,
                initialState: widget.saveFile.giantsWallet ? 3 : widget.saveFile.adultsWallet ? 2 : 1,
                onChanged: (v) {
                  widget.saveFile.adultsWallet = v >= 2;
                  widget.saveFile.giantsWallet = v >= 3;
                  valuesChanged = true;
                  setState(() {});
                },
              ),

              // Ocarinas
              UpgradeableItemButton(
                images: ['Fairy Ocarina.png', 'Ocarina of Time.png'],
                initialState: widget.saveFile.timeOcarina ? 2 : widget.saveFile.fairyOcarina ? 1 : 0,
                onChanged: (v) {
                  widget.saveFile.fairyOcarina = v >= 1;
                  widget.saveFile.timeOcarina = v >= 2;
                  valuesChanged = true;
                  setState(() {});
                },
              ),

              ..._strengthSwim,

              ..._bottles,

              ..._goddessesGifts,

              ..._hearts,

              // Lens Of Truth
              ToggleItemButton(
                image: 'Lens of Truth.png',
                initialState: widget.saveFile.lensOfTruth,
                onChanged: (v) {
                  widget.saveFile.lensOfTruth = v;
                  valuesChanged = true;
                  setState(() {});
                },
              ),

              // Gerudo Membership Card
              ToggleItemButton(
                image: 'Gerudo Token.png',
                initialState: widget.saveFile.gerudoMembership,
                onChanged: (v) {
                  widget.saveFile.gerudoMembership = v;
                  valuesChanged = true;
                  setState(() {});
                },
              ),

              // Magic
              UpgradeableItemButton(
                images: ['Magic Jar.png', 'Large Magic Jar.png'],
                initialState: widget.saveFile.magicUpgrade ? 2 : widget.saveFile.magic ? 1 : 0,
                onChanged: (v) {
                  widget.saveFile.magic = v >= 1;
                  widget.saveFile.magicUpgrade = v >= 2;
                  valuesChanged = true;
                  setState(() {});
                },
              ),

              // Stone of Agony
              ToggleItemButton(
                image: 'Stone of Agony.png',
                scale: 24/42,
                initialState: widget.saveFile.stoneOfAgony,
                onChanged: (v) {
                  widget.saveFile.stoneOfAgony = v;
                  valuesChanged = true;
                  setState(() {});
                },
              ),

              ..._adultWeapons,

              ..._storyProgress,

              ..._inconsequentials,

            ],
          ),

          GridView.count(
            crossAxisCount: 6,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
            shrinkWrap: true,
            children: _songs,
          ),

          // Staggered Grid View for keys
          Padding(
            padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    child: StaggeredGridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(left: 13, right: 6),
                      shrinkWrap: true,
                      crossAxisCount: 7,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: AlignmentDirectional.centerStart,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                          ),
                          child: Text('BOTW'),
                        ),
                        Container(
                          color: Colors.black26,
                          child: IncrementingItemButton(
                            image: 'Small Key.png',
                            scale: 1.66,
                            bottomTextSpacing: 0,
                            rightTextSpacing: 3,
                            maxValue: 3,
                            initialValue: widget.saveFile.botwKeys,
                            onChanged: (v) {
                              widget.saveFile.botwKeys = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: AlignmentDirectional.centerStart,
                          color: Colors.black26,
                          child: Text('GERUDO FORTRESS'),
                        ),
                        Container(
                          color: Colors.black26,
                          child: IncrementingItemButton(
                            image: 'Small Key.png',
                            scale: 1.66,
                            bottomTextSpacing: 0,
                            rightTextSpacing: 3,
                            maxValue: 4,
                            initialValue: widget.saveFile.gerudoFortressKeys,
                            onChanged: (v) {
                              widget.saveFile.gerudoFortressKeys = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                        ),
                        Container(color: Colors.black26),

                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: AlignmentDirectional.centerStart,
                          color: Colors.black26,
                          child: Text('TRAINING GROUNDS'),
                        ),
                        Container(
                          color: Colors.black26,
                          child: IncrementingItemButton(
                            image: 'Small Key.png',
                            scale: 1.66,
                            bottomTextSpacing: 0,
                            rightTextSpacing: 3,
                            maxValue: 9,
                            initialValue: widget.saveFile.gtgKeys,
                            onChanged: (v) {
                              widget.saveFile.gtgKeys = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                        ),
                        Container(color: Colors.black26),

                        Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: AlignmentDirectional.centerStart,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
                          ),
                          child: Text('GANON\'S CASTLE'),
                        ),
                        Container(
                          color: Colors.black26,
                          child: IncrementingItemButton(
                            image: 'Small Key.png',
                            scale: 1.66,
                            bottomTextSpacing: 0,
                            rightTextSpacing: 3,
                            maxValue: 3,
                            initialValue: widget.saveFile.ganonsCastleKeys,
                            onChanged: (v) {
                              widget.saveFile.ganonsCastleKeys = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
                          ),
                          child: ToggleItemButton(
                            image: 'Boss Key.png',
                            scale: 1.66,
                            initialState: widget.saveFile.ganonBossKey,
                            onChanged: (v) {
                              widget.saveFile.ganonBossKey = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                        ),

                      ],
                      staggeredTiles: [
                        StaggeredTile.extent(5, 40),
                        StaggeredTile.extent(1, 40),
                        StaggeredTile.extent(1, 40),
                        StaggeredTile.extent(5, 40),
                        StaggeredTile.extent(1, 40),
                        StaggeredTile.extent(1, 40),
                        StaggeredTile.extent(5, 40),
                        StaggeredTile.extent(1, 40),
                        StaggeredTile.extent(1, 40),
                        StaggeredTile.extent(5, 40),
                        StaggeredTile.extent(1, 40),
                        StaggeredTile.extent(1, 40),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 160,
                    margin: EdgeInsets.only(right: 13, left: 6),
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MedallionButton(
                          initialState: widget.saveFile.freeMedallionObtained,
                          initialMedallion: widget.saveFile.freeMedallion,
                          onStateChanged: (v) {
                            widget.saveFile.freeMedallionObtained = v;
                            valuesChanged = true;
                            setState(() {});
                          },
                          onMedallionChanged: (v) {
                            widget.saveFile.freeMedallion = v;
                            valuesChanged = true;
                            setState(() {});
                          },
                        ),
                        Container(alignment: Alignment.topCenter, padding: EdgeInsets.only(top: 12), child: Text('FREE')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(13, 7, 13, 7),
            padding: EdgeInsets.fromLTRB(4, 10, 4, 3),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MedallionButton(
                            initialState: widget.saveFile.dekuTreeMedallionObtained,
                            initialMedallion: widget.saveFile.dekuTreeMedallion,
                            onStateChanged: (v) {
                              widget.saveFile.dekuTreeMedallionObtained = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                            onMedallionChanged: (v) {
                              widget.saveFile.dekuTreeMedallion = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 5),
                          Text('DEKU\nTREE', textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MedallionButton(
                            initialState: widget.saveFile.dodongosCavernMedallionObtained,
                            initialMedallion: widget.saveFile.dodongosCavernMedallion,
                            onStateChanged: (v) {
                              widget.saveFile.dodongosCavernMedallionObtained = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                            onMedallionChanged: (v) {
                              widget.saveFile.dodongosCavernMedallion = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 5),
                          Text('D. C.', textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MedallionButton(
                            initialState: widget.saveFile.jabuJabuMedallionObtained,
                            initialMedallion: widget.saveFile.jabuJabuMedallion,
                            onStateChanged: (v) {
                              widget.saveFile.jabuJabuMedallionObtained = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                            onMedallionChanged: (v) {
                              widget.saveFile.jabuJabuMedallion = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 5),
                          Text('JABU\nJABU', textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),

                SizedBox(height: 15),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MedallionButton(
                            initialState: widget.saveFile.forestTempleMedallionObtained,
                            initialMedallion: widget.saveFile.forestTempleMedallion,
                            onStateChanged: (v) {
                              widget.saveFile.forestTempleMedallionObtained = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                            onMedallionChanged: (v) {
                              widget.saveFile.forestTempleMedallion = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 5),
                          Text('FOREST\nTEMPLE', textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
                          SizedBox(height: 3),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            children: [
                              IncrementingItemButton(
                                image: 'Small Key.png',
                                scale: 1.66,
                                bottomTextSpacing: 0,
                                rightTextSpacing: 3,
                                maxValue: 6,
                                initialValue: widget.saveFile.forestTempleKeys,
                                onChanged: (v) {
                                  widget.saveFile.forestTempleKeys = v;
                                  valuesChanged = true;
                                  setState(() {});
                                },
                              ),
                              ToggleItemButton(
                                image: 'Boss Key.png',
                                scale: 1.66,
                                initialState: widget.saveFile.forestTempleBossKey,
                                onChanged: (v) {
                                  widget.saveFile.forestTempleBossKey = v;
                                  valuesChanged = true;
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MedallionButton(
                            initialState: widget.saveFile.fireTempleMedallionObtained,
                            initialMedallion: widget.saveFile.fireTempleMedallion,
                            onStateChanged: (v) {
                              widget.saveFile.fireTempleMedallionObtained = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                            onMedallionChanged: (v) {
                              widget.saveFile.fireTempleMedallion = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 5),
                          Text('FIRE\nTEMPLE', textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            children: [
                              IncrementingItemButton(
                                image: 'Small Key.png',
                                scale: 1.66,
                                bottomTextSpacing: 0,
                                rightTextSpacing: 3,
                                maxValue: 8,
                                initialValue: widget.saveFile.fireTempleKeys,
                                onChanged: (v) {
                                  widget.saveFile.fireTempleKeys = v;
                                  valuesChanged = true;
                                  setState(() {});
                                },
                              ),
                              ToggleItemButton(
                                image: 'Boss Key.png',
                                scale: 1.66,
                                initialState: widget.saveFile.fireTempleBossKey,
                                onChanged: (v) {
                                  widget.saveFile.fireTempleBossKey = v;
                                  valuesChanged = true;
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MedallionButton(
                            initialState: widget.saveFile.waterTempleMedallionObtained,
                            initialMedallion: widget.saveFile.waterTempleMedallion,
                            onStateChanged: (v) {
                              widget.saveFile.waterTempleMedallionObtained = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                            onMedallionChanged: (v) {
                              widget.saveFile.waterTempleMedallion = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 5),
                          Text('WATER\nTEMPLE', textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            children: [
                              IncrementingItemButton(
                                image: 'Small Key.png',
                                scale: 1.66,
                                bottomTextSpacing: 0,
                                rightTextSpacing: 3,
                                maxValue: 6,
                                initialValue: widget.saveFile.waterTempleKeys,
                                onChanged: (v) {
                                  widget.saveFile.waterTempleKeys = v;
                                  valuesChanged = true;
                                  setState(() {});
                                },
                              ),
                              ToggleItemButton(
                                image: 'Boss Key.png',
                                scale: 1.66,
                                initialState: widget.saveFile.waterTempleBossKey,
                                onChanged: (v) {
                                  widget.saveFile.waterTempleBossKey = v;
                                  valuesChanged = true;
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MedallionButton(
                            initialState: widget.saveFile.shadowTempleMedallionObtained,
                            initialMedallion: widget.saveFile.shadowTempleMedallion,
                            onStateChanged: (v) {
                              widget.saveFile.shadowTempleMedallionObtained = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                            onMedallionChanged: (v) {
                              widget.saveFile.shadowTempleMedallion = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 5),
                          Text('SHADOW\nTEMPLE', textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            children: [
                              IncrementingItemButton(
                                image: 'Small Key.png',
                                scale: 1.66,
                                bottomTextSpacing: 0,
                                rightTextSpacing: 3,
                                maxValue: 6,
                                initialValue: widget.saveFile.shadowTempleKeys,
                                onChanged: (v) {
                                  widget.saveFile.shadowTempleKeys = v;
                                  valuesChanged = true;
                                  setState(() {});
                                },
                              ),
                              ToggleItemButton(
                                image: 'Boss Key.png',
                                scale: 1.66,
                                initialState: widget.saveFile.shadowTempleBossKey,
                                onChanged: (v) {
                                  widget.saveFile.shadowTempleBossKey = v;
                                  valuesChanged = true;
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MedallionButton(
                            initialState: widget.saveFile.spiritTempleMedallionObtained,
                            initialMedallion: widget.saveFile.spiritTempleMedallion,
                            onStateChanged: (v) {
                              widget.saveFile.spiritTempleMedallionObtained = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                            onMedallionChanged: (v) {
                              widget.saveFile.spiritTempleMedallion = v;
                              valuesChanged = true;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 5),
                          Text('SPIRIT\nTEMPLE', textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            children: [
                              IncrementingItemButton(
                                image: 'Small Key.png',
                                scale: 1.66,
                                bottomTextSpacing: 0,
                                rightTextSpacing: 3,
                                maxValue: 7,
                                initialValue: widget.saveFile.spiritTempleKeys,
                                onChanged: (v) {
                                  widget.saveFile.spiritTempleKeys = v;
                                  valuesChanged = true;
                                  setState(() {});
                                },
                              ),
                              ToggleItemButton(
                                image: 'Boss Key.png',
                                scale: 1.66,
                                initialState: widget.saveFile.spiritTempleBossKey,
                                onChanged: (v) {
                                  widget.saveFile.spiritTempleBossKey = v;
                                  valuesChanged = true;
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}

class ToggleItemButton extends StatefulWidget {

  final String image;
  final bool initialState;
  final void Function(bool val) onChanged;
  final double scale;

  final bool top;
  final bool left;
  final bool right;
  final bool bottom;

  ToggleItemButton({
    this.image,
    this.initialState = false,
    this.onChanged,
    this.top = false,
    this.left = false,
    this.right = false,
    this.bottom = false,
    this.scale,
  });

  @override
  _ToggleItemButtonState createState() => _ToggleItemButtonState();
}

class _ToggleItemButtonState extends State<ToggleItemButton> {

  bool on;

  @override
  void initState() {
    super.initState();
    on = widget.initialState ?? false;
  }

  void toggle(bool val) {
    setState(() => on = val);
    widget.onChanged?.call(val);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.top ? 0 : 3,
        left: widget.left ? 0 : 3,
        right: widget.right ? 0 : 3,
        bottom: widget.bottom ? 0 : 3,
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: widget.top ? 3 : 0,
          left: widget.left ? 3 : 0,
          right: widget.right ? 3 : 0,
          bottom: widget.bottom ? 3 : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(
            topLeft: widget.top || widget.left ? Radius.zero : Radius.circular(12),
            topRight: widget.top || widget.right ? Radius.zero : Radius.circular(12),
            bottomLeft: widget.bottom || widget.left ? Radius.zero : Radius.circular(12),
            bottomRight: widget.bottom || widget.right ? Radius.zero : Radius.circular(12),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => toggle(true),
          onDoubleTap: () => toggle(false),
          child: AnimatedOpacity(
            opacity: on ? 1.0 : 0.25,
            duration: animDuration,
            child: widget.image != null && widget.image.isNotEmpty
                ? Image.asset('assets/${widget.image}', scale: widget.scale ?? 1)
                : Icon(Icons.help),
          ),
        ),
      ),
    );
  }
}

class IncrementingItemButton extends StatefulWidget {
  final String image;
  final int initialValue;
  final void Function(int val) onChanged;

  final bool top;
  final bool left;
  final bool right;
  final bool bottom;

  final int maxValue;
  final int increment;
  final int decrement;
  final double scale;

  final double bottomTextSpacing;
  final double rightTextSpacing;

  IncrementingItemButton({
    this.image,
    this.initialValue = 0,
    this.maxValue,
    this.increment = 1,
    int decrement,
    this.onChanged,
    this.top = false,
    this.left = false,
    this.right = false,
    this.bottom = false,
    this.scale,
    this.bottomTextSpacing,
    this.rightTextSpacing,
  }) : this.decrement = decrement ?? increment;

  @override
  _IncrementingItemButtonState createState() => _IncrementingItemButtonState();
}

class _IncrementingItemButtonState extends State<IncrementingItemButton> {

  int currentVal;

  @override
  void initState() {
    super.initState();
    currentVal = widget.initialValue ?? 0;
  }

  void increment() {
    if (widget.maxValue != null && currentVal == widget.maxValue) return;
    setState(() => currentVal += (widget.increment ?? 1));
    widget.onChanged?.call(currentVal);
  }

  void decrement() {
    if (currentVal == 0) return;
    setState(() => currentVal -= (widget.decrement ?? 1));
    widget.onChanged?.call(currentVal);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.top ? 0 : 3,
        left: widget.left ? 0 : 3,
        right: widget.right ? 0 : 3,
        bottom: widget.bottom ? 0 : 3,
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: widget.top ? 3 : 0,
          left: widget.left ? 3 : 0,
          right: widget.right ? 3 : 0,
          bottom: widget.bottom ? 3 : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(
            topLeft: widget.top || widget.left ? Radius.zero : Radius.circular(12),
            topRight: widget.top || widget.right ? Radius.zero : Radius.circular(12),
            bottomLeft: widget.bottom || widget.left ? Radius.zero : Radius.circular(12),
            bottomRight: widget.bottom || widget.right ? Radius.zero : Radius.circular(12),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => increment(),
          onDoubleTap: () => decrement(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: currentVal > 0 ? 1.0 : 0.25,
                duration: animDuration,
                child: widget.image != null && widget.image.isNotEmpty ? Image.asset('assets/${widget.image}', scale: widget.scale ?? 1) : Icon(Icons.help),
              ),
              Visibility(
                visible: currentVal > 0,
                child: Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  padding: EdgeInsets.only(bottom: widget.bottomTextSpacing ?? 7, right: widget.rightTextSpacing ?? 10),
                  child: SizedBox(
                    child: Container(color: Colors.black.withOpacity(0.75), child: Text('$currentVal', style: TextStyle(color: widget.maxValue != null && currentVal == widget.maxValue ? Color(0xFF00FF00) : Colors.white)))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaskQuestButton extends StatefulWidget {

  final int initialValue;
  final void Function(int value) onChanged;

  final bool top;
  final bool left;
  final bool right;
  final bool bottom;

  MaskQuestButton({
    this.initialValue,
    this.onChanged,
    this.top = false,
    this.left = false,
    this.right = false,
    this.bottom = false,
  });

  @override
  _MaskQuestButtonState createState() => _MaskQuestButtonState();
}

class _MaskQuestButtonState extends State<MaskQuestButton> {

  int currentVal;

  @override
  void initState() {
    super.initState();
    currentVal = widget.initialValue ?? 0;
  }

  void increment() {
    if (currentVal == MaskQuest.values.length-1) return;
    setState(() => currentVal += 1);
    widget.onChanged?.call(currentVal);
  }

  void decrement() {
    if (currentVal == 0) return;
    setState(() => currentVal -= 1);
    widget.onChanged?.call(currentVal);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.top ? 0 : 3,
        left: widget.left ? 0 : 3,
        right: widget.right ? 0 : 3,
        bottom: widget.bottom ? 0 : 3,
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: widget.top ? 3 : 0,
          left: widget.left ? 3 : 0,
          right: widget.right ? 3 : 0,
          bottom: widget.bottom ? 3 : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(
            topLeft: widget.top || widget.left ? Radius.zero : Radius.circular(12),
            topRight: widget.top || widget.right ? Radius.zero : Radius.circular(12),
            bottomLeft: widget.bottom || widget.left ? Radius.zero : Radius.circular(12),
            bottomRight: widget.bottom || widget.right ? Radius.zero : Radius.circular(12),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => increment(),
          onDoubleTap: () => decrement(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: currentVal > 0 ? 1.0 : 0.25,
                duration: animDuration,
                child: Image.asset('assets/${MaskQuest.values[currentVal].image}'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class BiggoronQuestButton extends StatefulWidget {

  final int initialValue;
  final void Function(int value) onChanged;

  final bool top;
  final bool left;
  final bool right;
  final bool bottom;

  BiggoronQuestButton({
    this.initialValue,
    this.onChanged,
    this.top = false,
    this.left = false,
    this.right = false,
    this.bottom = false,
  });

  @override
  _BiggoronQuestButtonState createState() => _BiggoronQuestButtonState();
}

class _BiggoronQuestButtonState extends State<BiggoronQuestButton> {

  int currentVal;

  @override
  void initState() {
    super.initState();
    currentVal = widget.initialValue ?? 0;
  }

  void increment() {
    if (currentVal == BiggoronQuest.values.length-1) return;
    setState(() => currentVal += 1);
    widget.onChanged?.call(currentVal);
  }

  void decrement() {
    if (currentVal == 0) return;
    setState(() => currentVal -= 1);
    widget.onChanged?.call(currentVal);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.top ? 0 : 3,
        left: widget.left ? 0 : 3,
        right: widget.right ? 0 : 3,
        bottom: widget.bottom ? 0 : 3,
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: widget.top ? 3 : 0,
          left: widget.left ? 3 : 0,
          right: widget.right ? 3 : 0,
          bottom: widget.bottom ? 3 : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(
            topLeft: widget.top || widget.left ? Radius.zero : Radius.circular(12),
            topRight: widget.top || widget.right ? Radius.zero : Radius.circular(12),
            bottomLeft: widget.bottom || widget.left ? Radius.zero : Radius.circular(12),
            bottomRight: widget.bottom || widget.right ? Radius.zero : Radius.circular(12),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => increment(),
          onDoubleTap: () => decrement(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: currentVal > 0 ? 1.0 : 0.25,
                duration: animDuration,
                child: Image.asset('assets/${BiggoronQuest.values[currentVal].image}'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class UpgradeableItemButton extends StatefulWidget {

  final List<String> images;
  final int initialState;
  final int min;
  final void Function(int value) onChanged;

  final bool top;
  final bool left;
  final bool right;
  final bool bottom;

  UpgradeableItemButton({
    this.images,
    this.initialState,
    this.min,
    this.onChanged,
    this.top = false,
    this.left = false,
    this.right = false,
    this.bottom = false,
  });

  @override
  _UpgradeableItemButtonState createState() => _UpgradeableItemButtonState();
}

class _UpgradeableItemButtonState extends State<UpgradeableItemButton> {

  int currentVal;

  @override
  void initState() {
    super.initState();
    currentVal = widget.initialState ?? widget.min ?? 0;
  }

  void increment() {
    if (currentVal == widget.images.length) return;
    setState(() => currentVal += 1);
    widget.onChanged?.call(currentVal);
  }

  void decrement() {
    if (currentVal == (widget.min ?? 0)) return;
    setState(() => currentVal -= 1);
    widget.onChanged?.call(currentVal);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.top ? 0 : 3,
        left: widget.left ? 0 : 3,
        right: widget.right ? 0 : 3,
        bottom: widget.bottom ? 0 : 3,
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: widget.top ? 3 : 0,
          left: widget.left ? 3 : 0,
          right: widget.right ? 3 : 0,
          bottom: widget.bottom ? 3 : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(
            topLeft: widget.top || widget.left ? Radius.zero : Radius.circular(12),
            topRight: widget.top || widget.right ? Radius.zero : Radius.circular(12),
            bottomLeft: widget.bottom || widget.left ? Radius.zero : Radius.circular(12),
            bottomRight: widget.bottom || widget.right ? Radius.zero : Radius.circular(12),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => increment(),
          onDoubleTap: () => decrement(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: currentVal > 0 ? 1.0 : 0.25,
                duration: animDuration,
                child: Image.asset('assets/${widget.images[max(0, currentVal-1)]}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MedallionButton extends StatefulWidget {

  final bool initialState;
  final Medallion initialMedallion;

  final void Function(Medallion value) onMedallionChanged;
  final void Function(bool value) onStateChanged;

  MedallionButton({this.initialState, this.initialMedallion, this.onMedallionChanged, this.onStateChanged});

  @override
  _MedallionButtonState createState() => _MedallionButtonState();
}

class _MedallionButtonState extends State<MedallionButton> {

  bool on;
  Medallion medallion;

  @override
  void initState() {
    super.initState();
    on = widget.initialState ?? false;
    medallion = widget.initialMedallion ?? Medallion.None;
  }

  void toggle(bool val) {
    setState(() => on = val);
    widget.onStateChanged?.call(val);
  }

  void selectMedallion() {
    showDialog<Medallion>(
      context: context,
      builder: (_) => Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(7),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(_, Medallion.KokiriEmerald),
                      child: Image.asset('assets/Kokiri\'s Emerald.png', scale: 0.9),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(_, Medallion.GoronRuby),
                      child: Image.asset('assets/Goron\'s Ruby.png', scale: 0.9),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(_, Medallion.ZoraSapphire),
                      child: Image.asset('assets/Zora\'s Sapphire.png', scale: 0.9),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(_, Medallion.Light),
                      child: Image.asset('assets/Light Medallion.png', scale: 0.9),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(_, Medallion.Forest),
                      child: Image.asset('assets/Forest Medallion.png', scale: 0.9),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(_, Medallion.Fire),
                      child: Image.asset('assets/Fire Medallion.png', scale: 0.9),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(_, Medallion.Water),
                      child: Image.asset('assets/Water Medallion.png', scale: 0.9),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(_, Medallion.Shadow),
                      child: Image.asset('assets/Shadow Medallion.png', scale: 0.9),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(_, Medallion.Spirit),
                      child: Image.asset('assets/Spirit Medallion.png', scale: 0.9),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(_, Medallion.None),
                      child: Image.asset('assets/Unknown Medallion.png', scale: 0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).then((value) {
      if (value == null) return;
      setState(() => medallion = value);
      widget.onMedallionChanged?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => toggle(true),
      onDoubleTap: () => toggle(false),
      onLongPress: selectMedallion,
      child: AnimatedOpacity(
        opacity: on ? 1.0 : 0.25,
        duration: animDuration,
        child: Image.asset('assets/${medallion.image}', scale: 0.75),
      ),
    );
  }
}
