; RUN: llc < %s -mtriple=i386-apple-darwin -relocation-model=pic -disable-fp-elim | grep add | grep 12 | not grep non_lazy_ptr
; Don't fold re-materialized load into a two address instruction

	%"struct.Smarts::Runnable" = type { i32 (...)**, i32 }
	%struct.__sbuf = type { i8*, i32 }
	%"struct.std::ios_base" = type { i32 (...)**, i32, i32, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %struct.__sbuf, [8 x %struct.__sbuf], i32, %struct.__sbuf*, %"struct.std::locale" }
	%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"struct.std::ios_base"*, i32)*, i32, i32 }
	%"struct.std::locale" = type { %"struct.std::locale::_Impl"* }
	%"struct.std::locale::_Impl" = type { i32, %"struct.Smarts::Runnable"**, i32, %"struct.Smarts::Runnable"**, i8** }
@_ZTVSt9basic_iosIcSt11char_traitsIcEE = external constant [4 x i32 (...)*]		; <[4 x i32 (...)*]*> [#uses=1]
@_ZTTSt19basic_ostringstreamIcSt11char_traitsIcESaIcEE = external constant [4 x i8*]		; <[4 x i8*]*> [#uses=1]
@_ZTVSt19basic_ostringstreamIcSt11char_traitsIcESaIcEE = external constant [10 x i32 (...)*]		; <[10 x i32 (...)*]*> [#uses=2]
@_ZTVSt15basic_streambufIcSt11char_traitsIcEE = external constant [16 x i32 (...)*]		; <[16 x i32 (...)*]*> [#uses=1]
@_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE = external constant [16 x i32 (...)*]		; <[16 x i32 (...)*]*> [#uses=1]

define void @_GLOBAL__I__ZN5Pooma5pinfoE() nounwind  {
entry:
	store i32 (...)** getelementptr ([10 x i32 (...)*], [10 x i32 (...)*]* @_ZTVSt19basic_ostringstreamIcSt11char_traitsIcESaIcEE, i32 0, i32 8), i32 (...)*** null, align 4
	%tmp96.i.i142.i = call i8* @_Znwm( i32 180 ) nounwind 		; <i8*> [#uses=2]
	call void @_ZNSt8ios_baseC2Ev( %"struct.std::ios_base"* null ) nounwind 
	store i32 (...)** getelementptr ([4 x i32 (...)*], [4 x i32 (...)*]* @_ZTVSt9basic_iosIcSt11char_traitsIcEE, i32 0, i32 2), i32 (...)*** null, align 4
	store i32 (...)** null, i32 (...)*** null, align 4
	%ctg2242.i.i163.i = getelementptr i8, i8* %tmp96.i.i142.i, i32 0		; <i8*> [#uses=1]
	%tmp150.i.i164.i = load i8*, i8** getelementptr ([4 x i8*], [4 x i8*]* @_ZTTSt19basic_ostringstreamIcSt11char_traitsIcESaIcEE, i32 0, i64 2), align 4		; <i8*> [#uses=1]
	%tmp150151.i.i165.i = bitcast i8* %tmp150.i.i164.i to i32 (...)**		; <i32 (...)**> [#uses=1]
	%tmp153.i.i166.i = bitcast i8* %ctg2242.i.i163.i to i32 (...)***		; <i32 (...)***> [#uses=1]
	store i32 (...)** %tmp150151.i.i165.i, i32 (...)*** %tmp153.i.i166.i, align 4
	%tmp159.i.i167.i = bitcast i8* %tmp96.i.i142.i to i32 (...)***		; <i32 (...)***> [#uses=1]
	store i32 (...)** getelementptr ([10 x i32 (...)*], [10 x i32 (...)*]* @_ZTVSt19basic_ostringstreamIcSt11char_traitsIcESaIcEE, i32 0, i32 3), i32 (...)*** %tmp159.i.i167.i, align 4
	store i32 (...)** getelementptr ([16 x i32 (...)*], [16 x i32 (...)*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i32 0, i32 2), i32 (...)*** null, align 4
	call void @_ZNSt6localeC1Ev( %"struct.std::locale"* null ) nounwind 
	store i32 (...)** getelementptr ([16 x i32 (...)*], [16 x i32 (...)*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i32 0, i32 2), i32 (...)*** null, align 4
	unreachable
}

declare i8* @_Znwm(i32)

declare void @_ZNSt8ios_baseC2Ev(%"struct.std::ios_base"*)

declare void @_ZNSt6localeC1Ev(%"struct.std::locale"*) nounwind 
