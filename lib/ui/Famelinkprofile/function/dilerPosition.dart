class DilerPosition {
  static List pos = [
    {"top": 225, "bottom": 227, "left": 230, "right": 220},
    {"top": 230, "bottom": 220, "left": 226, "right": 226},
    {"top": 225, "bottom": 227, "left": 235, "right": 225},
    {"top": 225, "bottom": 227, "left": 230, "right": 220}
  ];
}

// top: selectPhase == 3 ? 270.r : 0.r,
// left: selectPhase == 2 ? 235.r : 0.r,
// right: selectPhase == 1 ? 235.r : 0.r,
// bottom: selectPhase == 0 ? 190.r : 0.r,

// top: selectPhase == 0 ? 180.r : 0.r,
// left: selectPhase == 1 ? 235.r : 0.r,
// right: selectPhase == 2 ? 235.r : 0.r,
// bottom: selectPhase == 3 ? 290.r : 0.r,
//
// top: selectPhase == 1 ? 225.r : 0.r  ,
// left: selectPhase == 3 ? 290.r : 0.r,
// right: selectPhase == 0 ? 180.r : 0.r,
// bottom: selectPhase == 2 ? 235.r : 0.r,
//
// top: selectPhase == 2 ? 225.r : 0.r,
// left: selectPhase == 0 ? 190.r : 0.r,
// right: selectPhase == 3 ? 280.r : 0.r,
// bottom: selectPhase == 1 ? 235.r : 0.r,

// top:  DilerPosition.pos[selectPhase]['top'].toDouble().r,
// left:  DilerPosition.pos[selectPhase]['left'].toDouble().r,
// right: DilerPosition.pos[selectPhase]['right'].toDouble().r,
// bottom:  DilerPosition.pos[selectPhase]['bottom'].toDouble().r,
