//==- HexagonInstrFormatsV60.td - Hexagon Instruction Formats -*- tablegen -==//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file describes the Hexagon V60 instruction classes in TableGen format.
//
//===----------------------------------------------------------------------===//

//----------------------------------------------------------------------------//
//                         Hexagon Intruction Flags +
//
//                        *** Must match BaseInfo.h ***
//----------------------------------------------------------------------------//

def TypeCVI_VA         : IType<13>;
def TypeCVI_VA_DV      : IType<14>;
def TypeCVI_VX         : IType<15>;
def TypeCVI_VX_DV      : IType<16>;
def TypeCVI_VP         : IType<17>;
def TypeCVI_VP_VS      : IType<18>;
def TypeCVI_VS         : IType<19>;
def TypeCVI_VINLANESAT : IType<20>;
def TypeCVI_VM_LD      : IType<21>;
def TypeCVI_VM_TMP_LD  : IType<22>;
def TypeCVI_VM_CUR_LD  : IType<23>;
def TypeCVI_VM_VP_LDU  : IType<24>;
def TypeCVI_VM_ST      : IType<25>;
def TypeCVI_VM_NEW_ST  : IType<26>;
def TypeCVI_VM_STU     : IType<27>;
def TypeCVI_HIST       : IType<28>;
//----------------------------------------------------------------------------//
//                         Intruction Classes Definitions +
//----------------------------------------------------------------------------//

let validSubTargets = HasV60SubT in
{
class CVI_VA_Resource<dag outs, dag ins, string asmstr,
                       list<dag> pattern = [], string cstr = "",
                       InstrItinClass itin = CVI_VA>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VA>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VA_DV_Resource<dag outs, dag ins, string asmstr,
                         list<dag> pattern = [], string cstr = "",
                         InstrItinClass itin = CVI_VA_DV>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VA_DV>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VX_Resource_long<dag outs, dag ins, string asmstr,
                       list<dag> pattern = [], string cstr = "",
                       InstrItinClass itin = CVI_VX_LONG>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VX>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VX_Resource_late<dag outs, dag ins, string asmstr,
                       list<dag> pattern = [], string cstr = "",
                       InstrItinClass itin = CVI_VX_LATE>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VX>,
     Requires<[HasV60T, UseHVX]>;

class CVI_VX_Resource<dag outs, dag ins, string asmstr,
                       list<dag> pattern = [], string cstr = "",
                       InstrItinClass itin = CVI_VX>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VX>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VX_DV_Resource<dag outs, dag ins, string asmstr,
                       list<dag> pattern = [], string cstr = "",
                       InstrItinClass itin = CVI_VX_DV>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VX_DV>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VX_DV_Slot2_Resource<dag outs, dag ins, string asmstr,
                       list<dag> pattern = [], string cstr = "",
                       InstrItinClass itin = CVI_VX_DV_SLOT2>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VX_DV>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VX_DV_Resource_long<dag outs, dag ins, string asmstr,
                         list<dag> pattern = [], string cstr = "",
                         InstrItinClass itin = CVI_VX_DV_LONG>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VX_DV>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VP_Resource_long<dag outs, dag ins, string asmstr,
                         list<dag> pattern = [], string cstr = "",
                         InstrItinClass itin = CVI_VP_LONG>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VP>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VP_VS_Resource_early<dag outs, dag ins, string asmstr,
                         list<dag> pattern = [], string cstr = "",
                         InstrItinClass itin = CVI_VP_VS_EARLY>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VP_VS>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VP_VS_Resource_long<dag outs, dag ins, string asmstr,
                         list<dag> pattern = [], string cstr = "",
                         InstrItinClass itin = CVI_VP_VS_LONG>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VP_VS>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VP_VS_Resource_long_early<dag outs, dag ins, string asmstr,
                         list<dag> pattern = [], string cstr = "",
                         InstrItinClass itin = CVI_VP_VS_LONG_EARLY>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VP_VS>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VS_Resource<dag outs, dag ins, string asmstr,
                         list<dag> pattern = [], string cstr = "",
                         InstrItinClass itin = CVI_VS>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VS>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VINLANESAT_Resource<dag outs, dag ins, string asmstr,
                         list<dag> pattern = [], string cstr = "",
                         InstrItinClass itin = CVI_VINLANESAT>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VINLANESAT>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VS_Resource_long<dag outs, dag ins, string asmstr,
                           list<dag> pattern = [], string cstr = "",
                           InstrItinClass itin = CVI_VS>
  : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VS>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_LD_Resource<dag outs, dag ins, string asmstr,
                         list<dag> pattern = [], string cstr = "",
                         InstrItinClass itin = CVI_VM_LD>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_LD>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_LD_Resource_long<dag outs, dag ins, string asmstr,
                              list<dag> pattern = [], string cstr = "",
                         InstrItinClass itin = CVI_VM_LD>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_LD>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_TMP_LD_Resource<dag outs, dag ins, string asmstr,
                             list<dag> pattern = [], string cstr = "",
                             InstrItinClass itin = CVI_VM_TMP_LD>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_TMP_LD>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_TMP_LD_Resource_long<dag outs, dag ins, string asmstr,
                                  list<dag> pattern = [], string cstr = "",
                                  InstrItinClass itin = CVI_VM_TMP_LD>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_TMP_LD>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_CUR_LD_Resource<dag outs, dag ins, string asmstr,
                             list<dag> pattern = [], string cstr = "",
                             InstrItinClass itin = CVI_VM_CUR_LD>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_CUR_LD>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_VP_LDU_Resource<dag outs, dag ins, string asmstr,
                             list<dag> pattern = [], string cstr = "",
                             InstrItinClass itin = CVI_VM_VP_LDU>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_VP_LDU>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_VP_LDU_Resource_long<dag outs, dag ins, string asmstr,
                                  list<dag> pattern = [], string cstr = "",
                                  InstrItinClass itin = CVI_VM_VP_LDU>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_VP_LDU>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_ST_Resource<dag outs, dag ins, string asmstr,
                         list<dag> pattern = [], string cstr = "",
                         InstrItinClass itin = CVI_VM_ST>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_ST>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_ST_Resource_long<dag outs, dag ins, string asmstr,
                              list<dag> pattern = [], string cstr = "",
                              InstrItinClass itin = CVI_VM_ST>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_ST>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_NEW_ST_Resource<dag outs, dag ins, string asmstr,
                             list<dag> pattern = [], string cstr = "",
                             InstrItinClass itin = CVI_VM_NEW_ST>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_NEW_ST>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_NEW_ST_Resource_long<dag outs, dag ins, string asmstr,
                                  list<dag> pattern = [], string cstr = "",
                                  InstrItinClass itin = CVI_VM_NEW_ST>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_NEW_ST>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_STU_Resource<dag outs, dag ins, string asmstr,
                          list<dag> pattern = [], string cstr = "",
                          InstrItinClass itin = CVI_VM_STU>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_STU>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_VM_STU_Resource_long<dag outs, dag ins, string asmstr,
                               list<dag> pattern = [], string cstr = "",
                               InstrItinClass itin = CVI_VM_STU>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VM_STU>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;

class CVI_HIST_Resource<dag outs, dag ins, string asmstr,
                        list<dag> pattern = [], string cstr = "",
                        InstrItinClass itin = CVI_HIST>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_HIST>,
     OpcodeHexagon, Requires<[HasV60T, UseHVX]>;
}

let validSubTargets = HasV60SubT in
{
class CVI_VA_Resource1<dag outs, dag ins, string asmstr,
                       list<dag> pattern = [], string cstr = "",
                       InstrItinClass itin = CVI_VA>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VA>,
     Requires<[HasV60T, UseHVX]>;

class CVI_VX_DV_Resource1<dag outs, dag ins, string asmstr,
                         list<dag> pattern = [], string cstr = "",
                         InstrItinClass itin = CVI_VX_DV>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_VX_DV>,
     Requires<[HasV60T, UseHVX]>;

class CVI_HIST_Resource1<dag outs, dag ins, string asmstr,
                        list<dag> pattern = [], string cstr = "",
                        InstrItinClass itin = CVI_HIST>
   : InstHexagon<outs, ins, asmstr, pattern, cstr, itin, TypeCVI_HIST>,
     Requires<[HasV60T, UseHVX]>;
}


