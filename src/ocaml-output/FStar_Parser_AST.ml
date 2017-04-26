
open Prims

let old_mk_tuple_lid : Prims.int  ->  FStar_Range.range  ->  FStar_Ident.lident = (fun n1 r -> (

let t = (

let uu____8 = (FStar_Util.string_of_int n1)
in (FStar_Util.format1 "Tuple%s" uu____8))
in (

let uu____9 = (FStar_Syntax_Const.pconst t)
in (FStar_Ident.set_lid_range uu____9 r))))


let old_mk_tuple_data_lid : Prims.int  ->  FStar_Range.range  ->  FStar_Ident.lident = (fun n1 r -> (

let t = (

let uu____17 = (FStar_Util.string_of_int n1)
in (FStar_Util.format1 "MkTuple%s" uu____17))
in (

let uu____18 = (FStar_Syntax_Const.pconst t)
in (FStar_Ident.set_lid_range uu____18 r))))


let old_mk_dtuple_lid : Prims.int  ->  FStar_Range.range  ->  FStar_Ident.lident = (fun n1 r -> (

let t = (

let uu____26 = (FStar_Util.string_of_int n1)
in (FStar_Util.format1 "DTuple%s" uu____26))
in (

let uu____27 = (FStar_Syntax_Const.pconst t)
in (FStar_Ident.set_lid_range uu____27 r))))


let old_mk_dtuple_data_lid : Prims.int  ->  FStar_Range.range  ->  FStar_Ident.lident = (fun n1 r -> (

let t = (

let uu____35 = (FStar_Util.string_of_int n1)
in (FStar_Util.format1 "MkDTuple%s" uu____35))
in (

let uu____36 = (FStar_Syntax_Const.pconst t)
in (FStar_Ident.set_lid_range uu____36 r))))

type level =
| Un
| Expr
| Type_level
| Kind
| Formula


let uu___is_Un : level  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Un -> begin
true
end
| uu____40 -> begin
false
end))


let uu___is_Expr : level  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Expr -> begin
true
end
| uu____44 -> begin
false
end))


let uu___is_Type_level : level  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Type_level -> begin
true
end
| uu____48 -> begin
false
end))


let uu___is_Kind : level  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Kind -> begin
true
end
| uu____52 -> begin
false
end))


let uu___is_Formula : level  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Formula -> begin
true
end
| uu____56 -> begin
false
end))

type imp =
| FsTypApp
| Hash
| UnivApp
| Nothing


let uu___is_FsTypApp : imp  ->  Prims.bool = (fun projectee -> (match (projectee) with
| FsTypApp -> begin
true
end
| uu____60 -> begin
false
end))


let uu___is_Hash : imp  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Hash -> begin
true
end
| uu____64 -> begin
false
end))


let uu___is_UnivApp : imp  ->  Prims.bool = (fun projectee -> (match (projectee) with
| UnivApp -> begin
true
end
| uu____68 -> begin
false
end))


let uu___is_Nothing : imp  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Nothing -> begin
true
end
| uu____72 -> begin
false
end))

type arg_qualifier =
| Implicit
| Equality


let uu___is_Implicit : arg_qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Implicit -> begin
true
end
| uu____76 -> begin
false
end))


let uu___is_Equality : arg_qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Equality -> begin
true
end
| uu____80 -> begin
false
end))


type aqual =
arg_qualifier Prims.option

type let_qualifier =
| NoLetQualifier
| Rec
| Mutable


let uu___is_NoLetQualifier : let_qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| NoLetQualifier -> begin
true
end
| uu____85 -> begin
false
end))


let uu___is_Rec : let_qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Rec -> begin
true
end
| uu____89 -> begin
false
end))


let uu___is_Mutable : let_qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Mutable -> begin
true
end
| uu____93 -> begin
false
end))

type term' =
| Wild
| Const of FStar_Const.sconst
| Op of (FStar_Ident.ident * term Prims.list)
| Tvar of FStar_Ident.ident
| Uvar of FStar_Ident.ident
| Var of FStar_Ident.lid
| Name of FStar_Ident.lid
| Projector of (FStar_Ident.lid * FStar_Ident.ident)
| Construct of (FStar_Ident.lid * (term * imp) Prims.list)
| Abs of (pattern Prims.list * term)
| App of (term * term * imp)
| Let of (let_qualifier * (pattern * term) Prims.list * term)
| LetOpen of (FStar_Ident.lid * term)
| Seq of (term * term)
| Bind of (FStar_Ident.ident * term * term)
| If of (term * term * term)
| Match of (term * (pattern * term Prims.option * term) Prims.list)
| TryWith of (term * (pattern * term Prims.option * term) Prims.list)
| Ascribed of (term * term * term Prims.option)
| Record of (term Prims.option * (FStar_Ident.lid * term) Prims.list)
| Project of (term * FStar_Ident.lid)
| Product of (binder Prims.list * term)
| Sum of (binder Prims.list * term)
| QForall of (binder Prims.list * term Prims.list Prims.list * term)
| QExists of (binder Prims.list * term Prims.list Prims.list * term)
| Refine of (binder * term)
| NamedTyp of (FStar_Ident.ident * term)
| Paren of term
| Requires of (term * Prims.string Prims.option)
| Ensures of (term * Prims.string Prims.option)
| Labeled of (term * Prims.string * Prims.bool)
| Assign of (FStar_Ident.ident * term)
| Discrim of FStar_Ident.lid
| Attributes of term Prims.list 
 and term =
{tm : term'; range : FStar_Range.range; level : level} 
 and binder' =
| Variable of FStar_Ident.ident
| TVariable of FStar_Ident.ident
| Annotated of (FStar_Ident.ident * term)
| TAnnotated of (FStar_Ident.ident * term)
| NoName of term 
 and binder =
{b : binder'; brange : FStar_Range.range; blevel : level; aqual : aqual} 
 and pattern' =
| PatWild
| PatConst of FStar_Const.sconst
| PatApp of (pattern * pattern Prims.list)
| PatVar of (FStar_Ident.ident * arg_qualifier Prims.option)
| PatName of FStar_Ident.lid
| PatTvar of (FStar_Ident.ident * arg_qualifier Prims.option)
| PatList of pattern Prims.list
| PatTuple of (pattern Prims.list * Prims.bool)
| PatRecord of (FStar_Ident.lid * pattern) Prims.list
| PatAscribed of (pattern * term)
| PatOr of pattern Prims.list
| PatOp of FStar_Ident.ident 
 and pattern =
{pat : pattern'; prange : FStar_Range.range}


let uu___is_Wild : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Wild -> begin
true
end
| uu____386 -> begin
false
end))


let uu___is_Const : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Const (_0) -> begin
true
end
| uu____391 -> begin
false
end))


let __proj__Const__item___0 : term'  ->  FStar_Const.sconst = (fun projectee -> (match (projectee) with
| Const (_0) -> begin
_0
end))


let uu___is_Op : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Op (_0) -> begin
true
end
| uu____406 -> begin
false
end))


let __proj__Op__item___0 : term'  ->  (FStar_Ident.ident * term Prims.list) = (fun projectee -> (match (projectee) with
| Op (_0) -> begin
_0
end))


let uu___is_Tvar : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Tvar (_0) -> begin
true
end
| uu____427 -> begin
false
end))


let __proj__Tvar__item___0 : term'  ->  FStar_Ident.ident = (fun projectee -> (match (projectee) with
| Tvar (_0) -> begin
_0
end))


let uu___is_Uvar : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Uvar (_0) -> begin
true
end
| uu____439 -> begin
false
end))


let __proj__Uvar__item___0 : term'  ->  FStar_Ident.ident = (fun projectee -> (match (projectee) with
| Uvar (_0) -> begin
_0
end))


let uu___is_Var : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Var (_0) -> begin
true
end
| uu____451 -> begin
false
end))


let __proj__Var__item___0 : term'  ->  FStar_Ident.lid = (fun projectee -> (match (projectee) with
| Var (_0) -> begin
_0
end))


let uu___is_Name : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Name (_0) -> begin
true
end
| uu____463 -> begin
false
end))


let __proj__Name__item___0 : term'  ->  FStar_Ident.lid = (fun projectee -> (match (projectee) with
| Name (_0) -> begin
_0
end))


let uu___is_Projector : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Projector (_0) -> begin
true
end
| uu____477 -> begin
false
end))


let __proj__Projector__item___0 : term'  ->  (FStar_Ident.lid * FStar_Ident.ident) = (fun projectee -> (match (projectee) with
| Projector (_0) -> begin
_0
end))


let uu___is_Construct : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Construct (_0) -> begin
true
end
| uu____500 -> begin
false
end))


let __proj__Construct__item___0 : term'  ->  (FStar_Ident.lid * (term * imp) Prims.list) = (fun projectee -> (match (projectee) with
| Construct (_0) -> begin
_0
end))


let uu___is_Abs : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Abs (_0) -> begin
true
end
| uu____530 -> begin
false
end))


let __proj__Abs__item___0 : term'  ->  (pattern Prims.list * term) = (fun projectee -> (match (projectee) with
| Abs (_0) -> begin
_0
end))


let uu___is_App : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| App (_0) -> begin
true
end
| uu____554 -> begin
false
end))


let __proj__App__item___0 : term'  ->  (term * term * imp) = (fun projectee -> (match (projectee) with
| App (_0) -> begin
_0
end))


let uu___is_Let : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Let (_0) -> begin
true
end
| uu____581 -> begin
false
end))


let __proj__Let__item___0 : term'  ->  (let_qualifier * (pattern * term) Prims.list * term) = (fun projectee -> (match (projectee) with
| Let (_0) -> begin
_0
end))


let uu___is_LetOpen : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| LetOpen (_0) -> begin
true
end
| uu____613 -> begin
false
end))


let __proj__LetOpen__item___0 : term'  ->  (FStar_Ident.lid * term) = (fun projectee -> (match (projectee) with
| LetOpen (_0) -> begin
_0
end))


let uu___is_Seq : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Seq (_0) -> begin
true
end
| uu____633 -> begin
false
end))


let __proj__Seq__item___0 : term'  ->  (term * term) = (fun projectee -> (match (projectee) with
| Seq (_0) -> begin
_0
end))


let uu___is_Bind : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Bind (_0) -> begin
true
end
| uu____654 -> begin
false
end))


let __proj__Bind__item___0 : term'  ->  (FStar_Ident.ident * term * term) = (fun projectee -> (match (projectee) with
| Bind (_0) -> begin
_0
end))


let uu___is_If : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| If (_0) -> begin
true
end
| uu____678 -> begin
false
end))


let __proj__If__item___0 : term'  ->  (term * term * term) = (fun projectee -> (match (projectee) with
| If (_0) -> begin
_0
end))


let uu___is_Match : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Match (_0) -> begin
true
end
| uu____706 -> begin
false
end))


let __proj__Match__item___0 : term'  ->  (term * (pattern * term Prims.option * term) Prims.list) = (fun projectee -> (match (projectee) with
| Match (_0) -> begin
_0
end))


let uu___is_TryWith : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| TryWith (_0) -> begin
true
end
| uu____746 -> begin
false
end))


let __proj__TryWith__item___0 : term'  ->  (term * (pattern * term Prims.option * term) Prims.list) = (fun projectee -> (match (projectee) with
| TryWith (_0) -> begin
_0
end))


let uu___is_Ascribed : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Ascribed (_0) -> begin
true
end
| uu____783 -> begin
false
end))


let __proj__Ascribed__item___0 : term'  ->  (term * term * term Prims.option) = (fun projectee -> (match (projectee) with
| Ascribed (_0) -> begin
_0
end))


let uu___is_Record : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Record (_0) -> begin
true
end
| uu____813 -> begin
false
end))


let __proj__Record__item___0 : term'  ->  (term Prims.option * (FStar_Ident.lid * term) Prims.list) = (fun projectee -> (match (projectee) with
| Record (_0) -> begin
_0
end))


let uu___is_Project : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Project (_0) -> begin
true
end
| uu____845 -> begin
false
end))


let __proj__Project__item___0 : term'  ->  (term * FStar_Ident.lid) = (fun projectee -> (match (projectee) with
| Project (_0) -> begin
_0
end))


let uu___is_Product : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Product (_0) -> begin
true
end
| uu____866 -> begin
false
end))


let __proj__Product__item___0 : term'  ->  (binder Prims.list * term) = (fun projectee -> (match (projectee) with
| Product (_0) -> begin
_0
end))


let uu___is_Sum : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Sum (_0) -> begin
true
end
| uu____890 -> begin
false
end))


let __proj__Sum__item___0 : term'  ->  (binder Prims.list * term) = (fun projectee -> (match (projectee) with
| Sum (_0) -> begin
_0
end))


let uu___is_QForall : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| QForall (_0) -> begin
true
end
| uu____917 -> begin
false
end))


let __proj__QForall__item___0 : term'  ->  (binder Prims.list * term Prims.list Prims.list * term) = (fun projectee -> (match (projectee) with
| QForall (_0) -> begin
_0
end))


let uu___is_QExists : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| QExists (_0) -> begin
true
end
| uu____953 -> begin
false
end))


let __proj__QExists__item___0 : term'  ->  (binder Prims.list * term Prims.list Prims.list * term) = (fun projectee -> (match (projectee) with
| QExists (_0) -> begin
_0
end))


let uu___is_Refine : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Refine (_0) -> begin
true
end
| uu____985 -> begin
false
end))


let __proj__Refine__item___0 : term'  ->  (binder * term) = (fun projectee -> (match (projectee) with
| Refine (_0) -> begin
_0
end))


let uu___is_NamedTyp : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| NamedTyp (_0) -> begin
true
end
| uu____1005 -> begin
false
end))


let __proj__NamedTyp__item___0 : term'  ->  (FStar_Ident.ident * term) = (fun projectee -> (match (projectee) with
| NamedTyp (_0) -> begin
_0
end))


let uu___is_Paren : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Paren (_0) -> begin
true
end
| uu____1023 -> begin
false
end))


let __proj__Paren__item___0 : term'  ->  term = (fun projectee -> (match (projectee) with
| Paren (_0) -> begin
_0
end))


let uu___is_Requires : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Requires (_0) -> begin
true
end
| uu____1038 -> begin
false
end))


let __proj__Requires__item___0 : term'  ->  (term * Prims.string Prims.option) = (fun projectee -> (match (projectee) with
| Requires (_0) -> begin
_0
end))


let uu___is_Ensures : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Ensures (_0) -> begin
true
end
| uu____1062 -> begin
false
end))


let __proj__Ensures__item___0 : term'  ->  (term * Prims.string Prims.option) = (fun projectee -> (match (projectee) with
| Ensures (_0) -> begin
_0
end))


let uu___is_Labeled : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Labeled (_0) -> begin
true
end
| uu____1086 -> begin
false
end))


let __proj__Labeled__item___0 : term'  ->  (term * Prims.string * Prims.bool) = (fun projectee -> (match (projectee) with
| Labeled (_0) -> begin
_0
end))


let uu___is_Assign : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Assign (_0) -> begin
true
end
| uu____1109 -> begin
false
end))


let __proj__Assign__item___0 : term'  ->  (FStar_Ident.ident * term) = (fun projectee -> (match (projectee) with
| Assign (_0) -> begin
_0
end))


let uu___is_Discrim : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Discrim (_0) -> begin
true
end
| uu____1127 -> begin
false
end))


let __proj__Discrim__item___0 : term'  ->  FStar_Ident.lid = (fun projectee -> (match (projectee) with
| Discrim (_0) -> begin
_0
end))


let uu___is_Attributes : term'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Attributes (_0) -> begin
true
end
| uu____1140 -> begin
false
end))


let __proj__Attributes__item___0 : term'  ->  term Prims.list = (fun projectee -> (match (projectee) with
| Attributes (_0) -> begin
_0
end))


let uu___is_Variable : binder'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Variable (_0) -> begin
true
end
| uu____1167 -> begin
false
end))


let __proj__Variable__item___0 : binder'  ->  FStar_Ident.ident = (fun projectee -> (match (projectee) with
| Variable (_0) -> begin
_0
end))


let uu___is_TVariable : binder'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| TVariable (_0) -> begin
true
end
| uu____1179 -> begin
false
end))


let __proj__TVariable__item___0 : binder'  ->  FStar_Ident.ident = (fun projectee -> (match (projectee) with
| TVariable (_0) -> begin
_0
end))


let uu___is_Annotated : binder'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Annotated (_0) -> begin
true
end
| uu____1193 -> begin
false
end))


let __proj__Annotated__item___0 : binder'  ->  (FStar_Ident.ident * term) = (fun projectee -> (match (projectee) with
| Annotated (_0) -> begin
_0
end))


let uu___is_TAnnotated : binder'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| TAnnotated (_0) -> begin
true
end
| uu____1213 -> begin
false
end))


let __proj__TAnnotated__item___0 : binder'  ->  (FStar_Ident.ident * term) = (fun projectee -> (match (projectee) with
| TAnnotated (_0) -> begin
_0
end))


let uu___is_NoName : binder'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| NoName (_0) -> begin
true
end
| uu____1231 -> begin
false
end))


let __proj__NoName__item___0 : binder'  ->  term = (fun projectee -> (match (projectee) with
| NoName (_0) -> begin
_0
end))


let uu___is_PatWild : pattern'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| PatWild -> begin
true
end
| uu____1258 -> begin
false
end))


let uu___is_PatConst : pattern'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| PatConst (_0) -> begin
true
end
| uu____1263 -> begin
false
end))


let __proj__PatConst__item___0 : pattern'  ->  FStar_Const.sconst = (fun projectee -> (match (projectee) with
| PatConst (_0) -> begin
_0
end))


let uu___is_PatApp : pattern'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| PatApp (_0) -> begin
true
end
| uu____1278 -> begin
false
end))


let __proj__PatApp__item___0 : pattern'  ->  (pattern * pattern Prims.list) = (fun projectee -> (match (projectee) with
| PatApp (_0) -> begin
_0
end))


let uu___is_PatVar : pattern'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| PatVar (_0) -> begin
true
end
| uu____1302 -> begin
false
end))


let __proj__PatVar__item___0 : pattern'  ->  (FStar_Ident.ident * arg_qualifier Prims.option) = (fun projectee -> (match (projectee) with
| PatVar (_0) -> begin
_0
end))


let uu___is_PatName : pattern'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| PatName (_0) -> begin
true
end
| uu____1323 -> begin
false
end))


let __proj__PatName__item___0 : pattern'  ->  FStar_Ident.lid = (fun projectee -> (match (projectee) with
| PatName (_0) -> begin
_0
end))


let uu___is_PatTvar : pattern'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| PatTvar (_0) -> begin
true
end
| uu____1338 -> begin
false
end))


let __proj__PatTvar__item___0 : pattern'  ->  (FStar_Ident.ident * arg_qualifier Prims.option) = (fun projectee -> (match (projectee) with
| PatTvar (_0) -> begin
_0
end))


let uu___is_PatList : pattern'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| PatList (_0) -> begin
true
end
| uu____1360 -> begin
false
end))


let __proj__PatList__item___0 : pattern'  ->  pattern Prims.list = (fun projectee -> (match (projectee) with
| PatList (_0) -> begin
_0
end))


let uu___is_PatTuple : pattern'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| PatTuple (_0) -> begin
true
end
| uu____1378 -> begin
false
end))


let __proj__PatTuple__item___0 : pattern'  ->  (pattern Prims.list * Prims.bool) = (fun projectee -> (match (projectee) with
| PatTuple (_0) -> begin
_0
end))


let uu___is_PatRecord : pattern'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| PatRecord (_0) -> begin
true
end
| uu____1402 -> begin
false
end))


let __proj__PatRecord__item___0 : pattern'  ->  (FStar_Ident.lid * pattern) Prims.list = (fun projectee -> (match (projectee) with
| PatRecord (_0) -> begin
_0
end))


let uu___is_PatAscribed : pattern'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| PatAscribed (_0) -> begin
true
end
| uu____1425 -> begin
false
end))


let __proj__PatAscribed__item___0 : pattern'  ->  (pattern * term) = (fun projectee -> (match (projectee) with
| PatAscribed (_0) -> begin
_0
end))


let uu___is_PatOr : pattern'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| PatOr (_0) -> begin
true
end
| uu____1444 -> begin
false
end))


let __proj__PatOr__item___0 : pattern'  ->  pattern Prims.list = (fun projectee -> (match (projectee) with
| PatOr (_0) -> begin
_0
end))


let uu___is_PatOp : pattern'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| PatOp (_0) -> begin
true
end
| uu____1459 -> begin
false
end))


let __proj__PatOp__item___0 : pattern'  ->  FStar_Ident.ident = (fun projectee -> (match (projectee) with
| PatOp (_0) -> begin
_0
end))


type branch =
(pattern * term Prims.option * term)


type knd =
term


type typ =
term


type expr =
term


type fsdoc =
(Prims.string * (Prims.string * Prims.string) Prims.list)

type tycon =
| TyconAbstract of (FStar_Ident.ident * binder Prims.list * knd Prims.option)
| TyconAbbrev of (FStar_Ident.ident * binder Prims.list * knd Prims.option * term)
| TyconRecord of (FStar_Ident.ident * binder Prims.list * knd Prims.option * (FStar_Ident.ident * term * fsdoc Prims.option) Prims.list)
| TyconVariant of (FStar_Ident.ident * binder Prims.list * knd Prims.option * (FStar_Ident.ident * term Prims.option * fsdoc Prims.option * Prims.bool) Prims.list)


let uu___is_TyconAbstract : tycon  ->  Prims.bool = (fun projectee -> (match (projectee) with
| TyconAbstract (_0) -> begin
true
end
| uu____1540 -> begin
false
end))


let __proj__TyconAbstract__item___0 : tycon  ->  (FStar_Ident.ident * binder Prims.list * knd Prims.option) = (fun projectee -> (match (projectee) with
| TyconAbstract (_0) -> begin
_0
end))


let uu___is_TyconAbbrev : tycon  ->  Prims.bool = (fun projectee -> (match (projectee) with
| TyconAbbrev (_0) -> begin
true
end
| uu____1573 -> begin
false
end))


let __proj__TyconAbbrev__item___0 : tycon  ->  (FStar_Ident.ident * binder Prims.list * knd Prims.option * term) = (fun projectee -> (match (projectee) with
| TyconAbbrev (_0) -> begin
_0
end))


let uu___is_TyconRecord : tycon  ->  Prims.bool = (fun projectee -> (match (projectee) with
| TyconRecord (_0) -> begin
true
end
| uu____1614 -> begin
false
end))


let __proj__TyconRecord__item___0 : tycon  ->  (FStar_Ident.ident * binder Prims.list * knd Prims.option * (FStar_Ident.ident * term * fsdoc Prims.option) Prims.list) = (fun projectee -> (match (projectee) with
| TyconRecord (_0) -> begin
_0
end))


let uu___is_TyconVariant : tycon  ->  Prims.bool = (fun projectee -> (match (projectee) with
| TyconVariant (_0) -> begin
true
end
| uu____1672 -> begin
false
end))


let __proj__TyconVariant__item___0 : tycon  ->  (FStar_Ident.ident * binder Prims.list * knd Prims.option * (FStar_Ident.ident * term Prims.option * fsdoc Prims.option * Prims.bool) Prims.list) = (fun projectee -> (match (projectee) with
| TyconVariant (_0) -> begin
_0
end))

type qualifier =
| Private
| Abstract
| Noeq
| Unopteq
| Assumption
| DefaultEffect
| TotalEffect
| Effect_qual
| New
| Inline
| Visible
| Unfold_for_unification_and_vcgen
| Inline_for_extraction
| Irreducible
| NoExtract
| Reifiable
| Reflectable
| Opaque
| Logic


let uu___is_Private : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Private -> begin
true
end
| uu____1722 -> begin
false
end))


let uu___is_Abstract : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Abstract -> begin
true
end
| uu____1726 -> begin
false
end))


let uu___is_Noeq : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Noeq -> begin
true
end
| uu____1730 -> begin
false
end))


let uu___is_Unopteq : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Unopteq -> begin
true
end
| uu____1734 -> begin
false
end))


let uu___is_Assumption : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Assumption -> begin
true
end
| uu____1738 -> begin
false
end))


let uu___is_DefaultEffect : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| DefaultEffect -> begin
true
end
| uu____1742 -> begin
false
end))


let uu___is_TotalEffect : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| TotalEffect -> begin
true
end
| uu____1746 -> begin
false
end))


let uu___is_Effect_qual : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Effect_qual -> begin
true
end
| uu____1750 -> begin
false
end))


let uu___is_New : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| New -> begin
true
end
| uu____1754 -> begin
false
end))


let uu___is_Inline : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Inline -> begin
true
end
| uu____1758 -> begin
false
end))


let uu___is_Visible : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Visible -> begin
true
end
| uu____1762 -> begin
false
end))


let uu___is_Unfold_for_unification_and_vcgen : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Unfold_for_unification_and_vcgen -> begin
true
end
| uu____1766 -> begin
false
end))


let uu___is_Inline_for_extraction : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Inline_for_extraction -> begin
true
end
| uu____1770 -> begin
false
end))


let uu___is_Irreducible : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Irreducible -> begin
true
end
| uu____1774 -> begin
false
end))


let uu___is_NoExtract : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| NoExtract -> begin
true
end
| uu____1778 -> begin
false
end))


let uu___is_Reifiable : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Reifiable -> begin
true
end
| uu____1782 -> begin
false
end))


let uu___is_Reflectable : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Reflectable -> begin
true
end
| uu____1786 -> begin
false
end))


let uu___is_Opaque : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Opaque -> begin
true
end
| uu____1790 -> begin
false
end))


let uu___is_Logic : qualifier  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Logic -> begin
true
end
| uu____1794 -> begin
false
end))


type qualifiers =
qualifier Prims.list


type attributes_ =
term Prims.list

type decoration =
| Qualifier of qualifier
| DeclAttributes of term Prims.list
| Doc of fsdoc


let uu___is_Qualifier : decoration  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Qualifier (_0) -> begin
true
end
| uu____1811 -> begin
false
end))


let __proj__Qualifier__item___0 : decoration  ->  qualifier = (fun projectee -> (match (projectee) with
| Qualifier (_0) -> begin
_0
end))


let uu___is_DeclAttributes : decoration  ->  Prims.bool = (fun projectee -> (match (projectee) with
| DeclAttributes (_0) -> begin
true
end
| uu____1824 -> begin
false
end))


let __proj__DeclAttributes__item___0 : decoration  ->  term Prims.list = (fun projectee -> (match (projectee) with
| DeclAttributes (_0) -> begin
_0
end))


let uu___is_Doc : decoration  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Doc (_0) -> begin
true
end
| uu____1839 -> begin
false
end))


let __proj__Doc__item___0 : decoration  ->  fsdoc = (fun projectee -> (match (projectee) with
| Doc (_0) -> begin
_0
end))

type lift_op =
| NonReifiableLift of term
| ReifiableLift of (term * term)
| LiftForFree of term


let uu___is_NonReifiableLift : lift_op  ->  Prims.bool = (fun projectee -> (match (projectee) with
| NonReifiableLift (_0) -> begin
true
end
| uu____1862 -> begin
false
end))


let __proj__NonReifiableLift__item___0 : lift_op  ->  term = (fun projectee -> (match (projectee) with
| NonReifiableLift (_0) -> begin
_0
end))


let uu___is_ReifiableLift : lift_op  ->  Prims.bool = (fun projectee -> (match (projectee) with
| ReifiableLift (_0) -> begin
true
end
| uu____1876 -> begin
false
end))


let __proj__ReifiableLift__item___0 : lift_op  ->  (term * term) = (fun projectee -> (match (projectee) with
| ReifiableLift (_0) -> begin
_0
end))


let uu___is_LiftForFree : lift_op  ->  Prims.bool = (fun projectee -> (match (projectee) with
| LiftForFree (_0) -> begin
true
end
| uu____1894 -> begin
false
end))


let __proj__LiftForFree__item___0 : lift_op  ->  term = (fun projectee -> (match (projectee) with
| LiftForFree (_0) -> begin
_0
end))

type lift =
{msource : FStar_Ident.lid; mdest : FStar_Ident.lid; lift_op : lift_op}

type pragma =
| SetOptions of Prims.string
| ResetOptions of Prims.string Prims.option
| LightOff


let uu___is_SetOptions : pragma  ->  Prims.bool = (fun projectee -> (match (projectee) with
| SetOptions (_0) -> begin
true
end
| uu____1934 -> begin
false
end))


let __proj__SetOptions__item___0 : pragma  ->  Prims.string = (fun projectee -> (match (projectee) with
| SetOptions (_0) -> begin
_0
end))


let uu___is_ResetOptions : pragma  ->  Prims.bool = (fun projectee -> (match (projectee) with
| ResetOptions (_0) -> begin
true
end
| uu____1947 -> begin
false
end))


let __proj__ResetOptions__item___0 : pragma  ->  Prims.string Prims.option = (fun projectee -> (match (projectee) with
| ResetOptions (_0) -> begin
_0
end))


let uu___is_LightOff : pragma  ->  Prims.bool = (fun projectee -> (match (projectee) with
| LightOff -> begin
true
end
| uu____1961 -> begin
false
end))

type decl' =
| TopLevelModule of FStar_Ident.lid
| Open of FStar_Ident.lid
| Include of FStar_Ident.lid
| ModuleAbbrev of (FStar_Ident.ident * FStar_Ident.lid)
| TopLevelLet of (let_qualifier * (pattern * term) Prims.list)
| Main of term
| Tycon of (Prims.bool * (tycon * fsdoc Prims.option) Prims.list)
| Val of (FStar_Ident.ident * term)
| Exception of (FStar_Ident.ident * term Prims.option)
| NewEffect of effect_decl
| SubEffect of lift
| Pragma of pragma
| Fsdoc of fsdoc
| Assume of (FStar_Ident.ident * term) 
 and decl =
{d : decl'; drange : FStar_Range.range; doc : fsdoc Prims.option; quals : qualifiers; attrs : attributes_} 
 and effect_decl =
| DefineEffect of (FStar_Ident.ident * binder Prims.list * term * decl Prims.list)
| RedefineEffect of (FStar_Ident.ident * binder Prims.list * term)


let uu___is_TopLevelModule : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| TopLevelModule (_0) -> begin
true
end
| uu____2060 -> begin
false
end))


let __proj__TopLevelModule__item___0 : decl'  ->  FStar_Ident.lid = (fun projectee -> (match (projectee) with
| TopLevelModule (_0) -> begin
_0
end))


let uu___is_Open : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Open (_0) -> begin
true
end
| uu____2072 -> begin
false
end))


let __proj__Open__item___0 : decl'  ->  FStar_Ident.lid = (fun projectee -> (match (projectee) with
| Open (_0) -> begin
_0
end))


let uu___is_Include : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Include (_0) -> begin
true
end
| uu____2084 -> begin
false
end))


let __proj__Include__item___0 : decl'  ->  FStar_Ident.lid = (fun projectee -> (match (projectee) with
| Include (_0) -> begin
_0
end))


let uu___is_ModuleAbbrev : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| ModuleAbbrev (_0) -> begin
true
end
| uu____2098 -> begin
false
end))


let __proj__ModuleAbbrev__item___0 : decl'  ->  (FStar_Ident.ident * FStar_Ident.lid) = (fun projectee -> (match (projectee) with
| ModuleAbbrev (_0) -> begin
_0
end))


let uu___is_TopLevelLet : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| TopLevelLet (_0) -> begin
true
end
| uu____2121 -> begin
false
end))


let __proj__TopLevelLet__item___0 : decl'  ->  (let_qualifier * (pattern * term) Prims.list) = (fun projectee -> (match (projectee) with
| TopLevelLet (_0) -> begin
_0
end))


let uu___is_Main : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Main (_0) -> begin
true
end
| uu____2148 -> begin
false
end))


let __proj__Main__item___0 : decl'  ->  term = (fun projectee -> (match (projectee) with
| Main (_0) -> begin
_0
end))


let uu___is_Tycon : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Tycon (_0) -> begin
true
end
| uu____2166 -> begin
false
end))


let __proj__Tycon__item___0 : decl'  ->  (Prims.bool * (tycon * fsdoc Prims.option) Prims.list) = (fun projectee -> (match (projectee) with
| Tycon (_0) -> begin
_0
end))


let uu___is_Val : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Val (_0) -> begin
true
end
| uu____2198 -> begin
false
end))


let __proj__Val__item___0 : decl'  ->  (FStar_Ident.ident * term) = (fun projectee -> (match (projectee) with
| Val (_0) -> begin
_0
end))


let uu___is_Exception : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Exception (_0) -> begin
true
end
| uu____2219 -> begin
false
end))


let __proj__Exception__item___0 : decl'  ->  (FStar_Ident.ident * term Prims.option) = (fun projectee -> (match (projectee) with
| Exception (_0) -> begin
_0
end))


let uu___is_NewEffect : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| NewEffect (_0) -> begin
true
end
| uu____2240 -> begin
false
end))


let __proj__NewEffect__item___0 : decl'  ->  effect_decl = (fun projectee -> (match (projectee) with
| NewEffect (_0) -> begin
_0
end))


let uu___is_SubEffect : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| SubEffect (_0) -> begin
true
end
| uu____2252 -> begin
false
end))


let __proj__SubEffect__item___0 : decl'  ->  lift = (fun projectee -> (match (projectee) with
| SubEffect (_0) -> begin
_0
end))


let uu___is_Pragma : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Pragma (_0) -> begin
true
end
| uu____2264 -> begin
false
end))


let __proj__Pragma__item___0 : decl'  ->  pragma = (fun projectee -> (match (projectee) with
| Pragma (_0) -> begin
_0
end))


let uu___is_Fsdoc : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Fsdoc (_0) -> begin
true
end
| uu____2276 -> begin
false
end))


let __proj__Fsdoc__item___0 : decl'  ->  fsdoc = (fun projectee -> (match (projectee) with
| Fsdoc (_0) -> begin
_0
end))


let uu___is_Assume : decl'  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Assume (_0) -> begin
true
end
| uu____2290 -> begin
false
end))


let __proj__Assume__item___0 : decl'  ->  (FStar_Ident.ident * term) = (fun projectee -> (match (projectee) with
| Assume (_0) -> begin
_0
end))


let uu___is_DefineEffect : effect_decl  ->  Prims.bool = (fun projectee -> (match (projectee) with
| DefineEffect (_0) -> begin
true
end
| uu____2336 -> begin
false
end))


let __proj__DefineEffect__item___0 : effect_decl  ->  (FStar_Ident.ident * binder Prims.list * term * decl Prims.list) = (fun projectee -> (match (projectee) with
| DefineEffect (_0) -> begin
_0
end))


let uu___is_RedefineEffect : effect_decl  ->  Prims.bool = (fun projectee -> (match (projectee) with
| RedefineEffect (_0) -> begin
true
end
| uu____2370 -> begin
false
end))


let __proj__RedefineEffect__item___0 : effect_decl  ->  (FStar_Ident.ident * binder Prims.list * term) = (fun projectee -> (match (projectee) with
| RedefineEffect (_0) -> begin
_0
end))

type modul =
| Module of (FStar_Ident.lid * decl Prims.list)
| Interface of (FStar_Ident.lid * decl Prims.list * Prims.bool)


let uu___is_Module : modul  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Module (_0) -> begin
true
end
| uu____2410 -> begin
false
end))


let __proj__Module__item___0 : modul  ->  (FStar_Ident.lid * decl Prims.list) = (fun projectee -> (match (projectee) with
| Module (_0) -> begin
_0
end))


let uu___is_Interface : modul  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Interface (_0) -> begin
true
end
| uu____2435 -> begin
false
end))


let __proj__Interface__item___0 : modul  ->  (FStar_Ident.lid * decl Prims.list * Prims.bool) = (fun projectee -> (match (projectee) with
| Interface (_0) -> begin
_0
end))


type file =
modul Prims.list


type inputFragment =
(file, decl Prims.list) FStar_Util.either


let check_id : FStar_Ident.ident  ->  Prims.unit = (fun id -> (

let first_char = (FStar_String.substring id.FStar_Ident.idText (Prims.parse_int "0") (Prims.parse_int "1"))
in (match (((FStar_String.lowercase first_char) = first_char)) with
| true -> begin
()
end
| uu____2463 -> begin
(

let uu____2464 = (

let uu____2465 = (

let uu____2468 = (FStar_Util.format1 "Invalid identifer \'%s\'; expected a symbol that begins with a lower-case character" id.FStar_Ident.idText)
in ((uu____2468), (id.FStar_Ident.idRange)))
in FStar_Errors.Error (uu____2465))
in (Prims.raise uu____2464))
end)))


let at_most_one = (fun s r l -> (match (l) with
| (x)::[] -> begin
Some (x)
end
| [] -> begin
None
end
| uu____2490 -> begin
(

let uu____2492 = (

let uu____2493 = (

let uu____2496 = (FStar_Util.format1 "At most one %s is allowed on declarations" s)
in ((uu____2496), (r)))
in FStar_Errors.Error (uu____2493))
in (Prims.raise uu____2492))
end))


let mk_decl : decl'  ->  FStar_Range.range  ->  decoration Prims.list  ->  decl = (fun d r decorations -> (

let doc1 = (

let uu____2511 = (FStar_List.choose (fun uu___108_2513 -> (match (uu___108_2513) with
| Doc (d1) -> begin
Some (d1)
end
| uu____2516 -> begin
None
end)) decorations)
in (at_most_one "fsdoc" r uu____2511))
in (

let attributes_ = (

let uu____2520 = (FStar_List.choose (fun uu___109_2524 -> (match (uu___109_2524) with
| DeclAttributes (a) -> begin
Some (a)
end
| uu____2530 -> begin
None
end)) decorations)
in (at_most_one "attribute set" r uu____2520))
in (

let attributes_1 = (FStar_Util.dflt [] attributes_)
in (

let qualifiers = (FStar_List.choose (fun uu___110_2538 -> (match (uu___110_2538) with
| Qualifier (q) -> begin
Some (q)
end
| uu____2541 -> begin
None
end)) decorations)
in {d = d; drange = r; doc = doc1; quals = qualifiers; attrs = attributes_1})))))


let mk_binder : binder'  ->  FStar_Range.range  ->  level  ->  aqual  ->  binder = (fun b r l i -> {b = b; brange = r; blevel = l; aqual = i})


let mk_term : term'  ->  FStar_Range.range  ->  level  ->  term = (fun t r l -> {tm = t; range = r; level = l})


let mk_uminus : term  ->  FStar_Range.range  ->  FStar_Range.range  ->  level  ->  term = (fun t rminus r l -> (

let t1 = (match (t.tm) with
| Const (FStar_Const.Const_int (s, Some (FStar_Const.Signed, width))) -> begin
Const (FStar_Const.Const_int ((((Prims.strcat "-" s)), (Some (((FStar_Const.Signed), (width)))))))
end
| uu____2588 -> begin
Op ((((FStar_Ident.mk_ident (("-"), (rminus)))), ((t)::[])))
end)
in (mk_term t1 r l)))


let mk_pattern : pattern'  ->  FStar_Range.range  ->  pattern = (fun p r -> {pat = p; prange = r})


let un_curry_abs : pattern Prims.list  ->  term  ->  term' = (fun ps body -> (match (body.tm) with
| Abs (p', body') -> begin
Abs ((((FStar_List.append ps p')), (body')))
end
| uu____2609 -> begin
Abs (((ps), (body)))
end))


let mk_function : (pattern * term Prims.option * term) Prims.list  ->  FStar_Range.range  ->  FStar_Range.range  ->  term = (fun branches r1 r2 -> (

let x = (

let i = (FStar_Syntax_Syntax.next_id ())
in (FStar_Ident.gen r1))
in (

let uu____2632 = (

let uu____2633 = (

let uu____2637 = (

let uu____2638 = (

let uu____2639 = (

let uu____2647 = (

let uu____2648 = (

let uu____2649 = (FStar_Ident.lid_of_ids ((x)::[]))
in Var (uu____2649))
in (mk_term uu____2648 r1 Expr))
in ((uu____2647), (branches)))
in Match (uu____2639))
in (mk_term uu____2638 r2 Expr))
in ((((mk_pattern (PatVar (((x), (None)))) r1))::[]), (uu____2637)))
in Abs (uu____2633))
in (mk_term uu____2632 r2 Expr))))


let un_function : pattern  ->  term  ->  (pattern * term) Prims.option = (fun p tm -> (match (((p.pat), (tm.tm))) with
| (PatVar (uu____2669), Abs (pats, body)) -> begin
Some ((((mk_pattern (PatApp (((p), (pats)))) p.prange)), (body)))
end
| uu____2680 -> begin
None
end))


let lid_with_range : FStar_Ident.lident  ->  FStar_Range.range  ->  FStar_Ident.lident = (fun lid r -> (

let uu____2691 = (FStar_Ident.path_of_lid lid)
in (FStar_Ident.lid_of_path uu____2691 r)))


let consPat : FStar_Range.range  ->  pattern  ->  pattern  ->  pattern' = (fun r hd1 tl1 -> PatApp ((((mk_pattern (PatName (FStar_Syntax_Const.cons_lid)) r)), ((hd1)::(tl1)::[]))))


let consTerm : FStar_Range.range  ->  term  ->  term  ->  term = (fun r hd1 tl1 -> (mk_term (Construct (((FStar_Syntax_Const.cons_lid), ((((hd1), (Nothing)))::(((tl1), (Nothing)))::[])))) r Expr))


let lexConsTerm : FStar_Range.range  ->  term  ->  term  ->  term = (fun r hd1 tl1 -> (mk_term (Construct (((FStar_Syntax_Const.lexcons_lid), ((((hd1), (Nothing)))::(((tl1), (Nothing)))::[])))) r Expr))


let mkConsList : FStar_Range.range  ->  term Prims.list  ->  term = (fun r elts -> (

let nil = (mk_term (Construct (((FStar_Syntax_Const.nil_lid), ([])))) r Expr)
in (FStar_List.fold_right (fun e tl1 -> (consTerm r e tl1)) elts nil)))


let mkLexList : FStar_Range.range  ->  term Prims.list  ->  term = (fun r elts -> (

let nil = (mk_term (Construct (((FStar_Syntax_Const.lextop_lid), ([])))) r Expr)
in (FStar_List.fold_right (fun e tl1 -> (lexConsTerm r e tl1)) elts nil)))


let ml_comp : term  ->  term = (fun t -> (

let ml = (mk_term (Name (FStar_Syntax_Const.effect_ML_lid)) t.range Expr)
in (

let t1 = (mk_term (App (((ml), (t), (Nothing)))) t.range Expr)
in t1)))


let tot_comp : term  ->  term = (fun t -> (

let ml = (mk_term (Name (FStar_Syntax_Const.effect_Tot_lid)) t.range Expr)
in (

let t1 = (mk_term (App (((ml), (t), (Nothing)))) t.range Expr)
in t1)))


let mkApp : term  ->  (term * imp) Prims.list  ->  FStar_Range.range  ->  term = (fun t args r -> (match (args) with
| [] -> begin
t
end
| uu____2798 -> begin
(match (t.tm) with
| Name (s) -> begin
(mk_term (Construct (((s), (args)))) r Un)
end
| uu____2806 -> begin
(FStar_List.fold_left (fun t1 uu____2810 -> (match (uu____2810) with
| (a, imp) -> begin
(mk_term (App (((t1), (a), (imp)))) r Un)
end)) t args)
end)
end))


let mkRefSet : FStar_Range.range  ->  term Prims.list  ->  term = (fun r elts -> (

let uu____2823 = ((FStar_Syntax_Const.tset_empty), (FStar_Syntax_Const.tset_singleton), (FStar_Syntax_Const.tset_union))
in (match (uu____2823) with
| (empty_lid, singleton_lid, union_lid) -> begin
(

let empty1 = (mk_term (Var ((FStar_Ident.set_lid_range empty_lid r))) r Expr)
in (

let ref_constr = (mk_term (Var ((FStar_Ident.set_lid_range FStar_Syntax_Const.heap_ref r))) r Expr)
in (

let singleton1 = (mk_term (Var ((FStar_Ident.set_lid_range singleton_lid r))) r Expr)
in (

let union1 = (mk_term (Var ((FStar_Ident.set_lid_range union_lid r))) r Expr)
in (FStar_List.fold_right (fun e tl1 -> (

let e1 = (mkApp ref_constr ((((e), (Nothing)))::[]) r)
in (

let single_e = (mkApp singleton1 ((((e1), (Nothing)))::[]) r)
in (mkApp union1 ((((single_e), (Nothing)))::(((tl1), (Nothing)))::[]) r)))) elts empty1)))))
end)))


let mkExplicitApp : term  ->  term Prims.list  ->  FStar_Range.range  ->  term = (fun t args r -> (match (args) with
| [] -> begin
t
end
| uu____2863 -> begin
(match (t.tm) with
| Name (s) -> begin
(

let uu____2866 = (

let uu____2867 = (

let uu____2873 = (FStar_List.map (fun a -> ((a), (Nothing))) args)
in ((s), (uu____2873)))
in Construct (uu____2867))
in (mk_term uu____2866 r Un))
end
| uu____2883 -> begin
(FStar_List.fold_left (fun t1 a -> (mk_term (App (((t1), (a), (Nothing)))) r Un)) t args)
end)
end))


let mkAdmitMagic : FStar_Range.range  ->  term = (fun r -> (

let unit_const = (mk_term (Const (FStar_Const.Const_unit)) r Expr)
in (

let admit1 = (

let admit_name = (mk_term (Var ((FStar_Ident.set_lid_range FStar_Syntax_Const.admit_lid r))) r Expr)
in (mkExplicitApp admit_name ((unit_const)::[]) r))
in (

let magic1 = (

let magic_name = (mk_term (Var ((FStar_Ident.set_lid_range FStar_Syntax_Const.magic_lid r))) r Expr)
in (mkExplicitApp magic_name ((unit_const)::[]) r))
in (

let admit_magic = (mk_term (Seq (((admit1), (magic1)))) r Expr)
in admit_magic)))))


let mkWildAdmitMagic = (fun r -> (

let uu____2906 = (mkAdmitMagic r)
in (((mk_pattern PatWild r)), (None), (uu____2906))))


let focusBranches = (fun branches r -> (

let should_filter = (FStar_Util.for_some Prims.fst branches)
in (match (should_filter) with
| true -> begin
((FStar_Errors.warn r "Focusing on only some cases");
(

let focussed = (

let uu____2962 = (FStar_List.filter Prims.fst branches)
in (FStar_All.pipe_right uu____2962 (FStar_List.map Prims.snd)))
in (

let uu____3006 = (

let uu____3012 = (mkWildAdmitMagic r)
in (uu____3012)::[])
in (FStar_List.append focussed uu____3006)));
)
end
| uu____3029 -> begin
(FStar_All.pipe_right branches (FStar_List.map Prims.snd))
end)))


let focusLetBindings = (fun lbs r -> (

let should_filter = (FStar_Util.for_some Prims.fst lbs)
in (match (should_filter) with
| true -> begin
((FStar_Errors.warn r "Focusing on only some cases in this (mutually) recursive definition");
(FStar_List.map (fun uu____3098 -> (match (uu____3098) with
| (f, lb) -> begin
(match (f) with
| true -> begin
lb
end
| uu____3113 -> begin
(

let uu____3114 = (mkAdmitMagic r)
in (((Prims.fst lb)), (uu____3114)))
end)
end)) lbs);
)
end
| uu____3115 -> begin
(FStar_All.pipe_right lbs (FStar_List.map Prims.snd))
end)))


let mkFsTypApp : term  ->  term Prims.list  ->  FStar_Range.range  ->  term = (fun t args r -> (

let uu____3143 = (FStar_List.map (fun a -> ((a), (FsTypApp))) args)
in (mkApp t uu____3143 r)))


let mkTuple : term Prims.list  ->  FStar_Range.range  ->  term = (fun args r -> (

let cons1 = (FStar_Syntax_Util.mk_tuple_data_lid (FStar_List.length args) r)
in (

let uu____3162 = (FStar_List.map (fun x -> ((x), (Nothing))) args)
in (mkApp (mk_term (Name (cons1)) r Expr) uu____3162 r))))


let mkDTuple : term Prims.list  ->  FStar_Range.range  ->  term = (fun args r -> (

let cons1 = (FStar_Syntax_Util.mk_dtuple_data_lid (FStar_List.length args) r)
in (

let uu____3181 = (FStar_List.map (fun x -> ((x), (Nothing))) args)
in (mkApp (mk_term (Name (cons1)) r Expr) uu____3181 r))))


let mkRefinedBinder : FStar_Ident.ident  ->  term  ->  Prims.bool  ->  term Prims.option  ->  FStar_Range.range  ->  aqual  ->  binder = (fun id t should_bind_var refopt m implicit -> (

let b = (mk_binder (Annotated (((id), (t)))) m Type_level implicit)
in (match (refopt) with
| None -> begin
b
end
| Some (phi) -> begin
(match (should_bind_var) with
| true -> begin
(mk_binder (Annotated (((id), ((mk_term (Refine (((b), (phi)))) m Type_level))))) m Type_level implicit)
end
| uu____3210 -> begin
(

let x = (FStar_Ident.gen t.range)
in (

let b1 = (mk_binder (Annotated (((x), (t)))) m Type_level implicit)
in (mk_binder (Annotated (((id), ((mk_term (Refine (((b1), (phi)))) m Type_level))))) m Type_level implicit)))
end)
end)))


let mkRefinedPattern : pattern  ->  term  ->  Prims.bool  ->  term Prims.option  ->  FStar_Range.range  ->  FStar_Range.range  ->  pattern = (fun pat t should_bind_pat phi_opt t_range range -> (

let t1 = (match (phi_opt) with
| None -> begin
t
end
| Some (phi) -> begin
(match (should_bind_pat) with
| true -> begin
(match (pat.pat) with
| PatVar (x, uu____3236) -> begin
(mk_term (Refine ((((mk_binder (Annotated (((x), (t)))) t_range Type_level None)), (phi)))) range Type_level)
end
| uu____3239 -> begin
(

let x = (FStar_Ident.gen t_range)
in (

let phi1 = (

let x_var = (

let uu____3243 = (

let uu____3244 = (FStar_Ident.lid_of_ids ((x)::[]))
in Var (uu____3244))
in (mk_term uu____3243 phi.range Formula))
in (

let pat_branch = ((pat), (None), (phi))
in (

let otherwise_branch = (

let uu____3256 = (

let uu____3257 = (

let uu____3258 = (FStar_Ident.lid_of_path (("False")::[]) phi.range)
in Name (uu____3258))
in (mk_term uu____3257 phi.range Formula))
in (((mk_pattern PatWild phi.range)), (None), (uu____3256)))
in (mk_term (Match (((x_var), ((pat_branch)::(otherwise_branch)::[])))) phi.range Formula))))
in (mk_term (Refine ((((mk_binder (Annotated (((x), (t)))) t_range Type_level None)), (phi1)))) range Type_level)))
end)
end
| uu____3277 -> begin
(

let x = (FStar_Ident.gen t.range)
in (mk_term (Refine ((((mk_binder (Annotated (((x), (t)))) t_range Type_level None)), (phi)))) range Type_level))
end)
end)
in (mk_pattern (PatAscribed (((pat), (t1)))) range)))


let rec extract_named_refinement : term  ->  (FStar_Ident.ident * term * term Prims.option) Prims.option = (fun t1 -> (match (t1.tm) with
| NamedTyp (x, t) -> begin
Some (((x), (t), (None)))
end
| Refine ({b = Annotated (x, t); brange = uu____3301; blevel = uu____3302; aqual = uu____3303}, t') -> begin
Some (((x), (t), (Some (t'))))
end
| Paren (t) -> begin
(extract_named_refinement t)
end
| uu____3311 -> begin
None
end))


let rec as_mlist : modul Prims.list  ->  ((FStar_Ident.lid * decl) * decl Prims.list)  ->  decl Prims.list  ->  modul Prims.list = (fun out cur ds -> (

let uu____3341 = cur
in (match (uu____3341) with
| ((m_name, m_decl), cur1) -> begin
(match (ds) with
| [] -> begin
(FStar_List.rev ((Module (((m_name), ((m_decl)::(FStar_List.rev cur1)))))::out))
end
| (d)::ds1 -> begin
(match (d.d) with
| TopLevelModule (m') -> begin
(as_mlist ((Module (((m_name), ((m_decl)::(FStar_List.rev cur1)))))::out) ((((m'), (d))), ([])) ds1)
end
| uu____3366 -> begin
(as_mlist out ((((m_name), (m_decl))), ((d)::cur1)) ds1)
end)
end)
end)))


let as_frag : Prims.bool  ->  FStar_Range.range  ->  decl Prims.list  ->  (modul Prims.list, decl Prims.list) FStar_Util.either = (fun is_light light_range ds -> (

let uu____3389 = (match (ds) with
| (d)::ds1 -> begin
((d), (ds1))
end
| [] -> begin
(Prims.raise FStar_Errors.Empty_frag)
end)
in (match (uu____3389) with
| (d, ds1) -> begin
(match (d.d) with
| TopLevelModule (m) -> begin
(

let ds2 = (match (is_light) with
| true -> begin
(

let uu____3419 = (mk_decl (Pragma (LightOff)) light_range [])
in (uu____3419)::ds1)
end
| uu____3420 -> begin
ds1
end)
in (

let ms = (as_mlist [] ((((m), (d))), ([])) ds2)
in ((

let uu____3427 = (FStar_List.tl ms)
in (match (uu____3427) with
| (Module (m', uu____3430))::uu____3431 -> begin
(

let msg = "Support for more than one module in a file is deprecated"
in (

let uu____3436 = (FStar_Range.string_of_range (FStar_Ident.range_of_lid m'))
in (FStar_Util.print2_warning "%s (Warning): %s\n" uu____3436 msg)))
end
| uu____3437 -> begin
()
end));
FStar_Util.Inl (ms);
)))
end
| uu____3441 -> begin
(

let ds2 = (d)::ds1
in ((FStar_List.iter (fun uu___111_3445 -> (match (uu___111_3445) with
| {d = TopLevelModule (uu____3446); drange = r; doc = uu____3448; quals = uu____3449; attrs = uu____3450} -> begin
(Prims.raise (FStar_Errors.Error ((("Unexpected module declaration"), (r)))))
end
| uu____3452 -> begin
()
end)) ds2);
FStar_Util.Inr (ds2);
))
end)
end)))


let compile_op : Prims.int  ->  Prims.string  ->  Prims.string = (fun arity s -> (

let name_of_char = (fun uu___112_3464 -> (match (uu___112_3464) with
| '&' -> begin
"Amp"
end
| '@' -> begin
"At"
end
| '+' -> begin
"Plus"
end
| '-' when (arity = (Prims.parse_int "1")) -> begin
"Minus"
end
| '-' -> begin
"Subtraction"
end
| '/' -> begin
"Slash"
end
| '<' -> begin
"Less"
end
| '=' -> begin
"Equals"
end
| '>' -> begin
"Greater"
end
| '_' -> begin
"Underscore"
end
| '|' -> begin
"Bar"
end
| '!' -> begin
"Bang"
end
| '^' -> begin
"Hat"
end
| '%' -> begin
"Percent"
end
| '*' -> begin
"Star"
end
| '?' -> begin
"Question"
end
| ':' -> begin
"Colon"
end
| uu____3465 -> begin
"UNKNOWN"
end))
in (match (s) with
| ".[]<-" -> begin
"op_String_Assignment"
end
| ".()<-" -> begin
"op_Array_Assignment"
end
| ".[]" -> begin
"op_String_Access"
end
| ".()" -> begin
"op_Array_Access"
end
| uu____3466 -> begin
(

let uu____3467 = (

let uu____3468 = (

let uu____3470 = (FStar_String.list_of_string s)
in (FStar_List.map name_of_char uu____3470))
in (FStar_String.concat "_" uu____3468))
in (Prims.strcat "op_" uu____3467))
end)))


let compile_op' : Prims.string  ->  Prims.string = (fun s -> (compile_op (~- ((Prims.parse_int "1"))) s))


let string_of_fsdoc : (Prims.string * (Prims.string * Prims.string) Prims.list)  ->  Prims.string = (fun uu____3482 -> (match (uu____3482) with
| (comment, keywords) -> begin
(

let uu____3496 = (

let uu____3497 = (FStar_List.map (fun uu____3501 -> (match (uu____3501) with
| (k, v1) -> begin
(Prims.strcat k (Prims.strcat "->" v1))
end)) keywords)
in (FStar_String.concat "," uu____3497))
in (Prims.strcat comment uu____3496))
end))


let string_of_let_qualifier : let_qualifier  ->  Prims.string = (fun uu___113_3508 -> (match (uu___113_3508) with
| NoLetQualifier -> begin
""
end
| Rec -> begin
"rec"
end
| Mutable -> begin
"mutable"
end))


let to_string_l = (fun sep f l -> (

let uu____3533 = (FStar_List.map f l)
in (FStar_String.concat sep uu____3533)))


let imp_to_string : imp  ->  Prims.string = (fun uu___114_3537 -> (match (uu___114_3537) with
| Hash -> begin
"#"
end
| uu____3538 -> begin
""
end))


let rec term_to_string : term  ->  Prims.string = (fun x -> (match (x.tm) with
| Wild -> begin
"_"
end
| Requires (t, uu____3549) -> begin
(

let uu____3552 = (term_to_string t)
in (FStar_Util.format1 "(requires %s)" uu____3552))
end
| Ensures (t, uu____3554) -> begin
(

let uu____3557 = (term_to_string t)
in (FStar_Util.format1 "(ensures %s)" uu____3557))
end
| Labeled (t, l, uu____3560) -> begin
(

let uu____3561 = (term_to_string t)
in (FStar_Util.format2 "(labeled %s %s)" l uu____3561))
end
| Const (c) -> begin
(FStar_Syntax_Print.const_to_string c)
end
| Op (s, xs) -> begin
(

let uu____3567 = (

let uu____3568 = (FStar_List.map (fun x1 -> (FStar_All.pipe_right x1 term_to_string)) xs)
in (FStar_String.concat ", " uu____3568))
in (FStar_Util.format2 "%s(%s)" (FStar_Ident.text_of_id s) uu____3567))
end
| (Tvar (id)) | (Uvar (id)) -> begin
id.FStar_Ident.idText
end
| (Var (l)) | (Name (l)) -> begin
l.FStar_Ident.str
end
| Construct (l, args) -> begin
(

let uu____3581 = (to_string_l " " (fun uu____3584 -> (match (uu____3584) with
| (a, imp) -> begin
(

let uu____3589 = (term_to_string a)
in (FStar_Util.format2 "%s%s" (imp_to_string imp) uu____3589))
end)) args)
in (FStar_Util.format2 "(%s %s)" l.FStar_Ident.str uu____3581))
end
| Abs (pats, t) -> begin
(

let uu____3594 = (to_string_l " " pat_to_string pats)
in (

let uu____3595 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "(fun %s -> %s)" uu____3594 uu____3595)))
end
| App (t1, t2, imp) -> begin
(

let uu____3599 = (FStar_All.pipe_right t1 term_to_string)
in (

let uu____3600 = (FStar_All.pipe_right t2 term_to_string)
in (FStar_Util.format3 "%s %s%s" uu____3599 (imp_to_string imp) uu____3600)))
end
| Let (Rec, lbs, body) -> begin
(

let uu____3609 = (to_string_l " and " (fun uu____3612 -> (match (uu____3612) with
| (p, b) -> begin
(

let uu____3617 = (FStar_All.pipe_right p pat_to_string)
in (

let uu____3618 = (FStar_All.pipe_right b term_to_string)
in (FStar_Util.format2 "%s=%s" uu____3617 uu____3618)))
end)) lbs)
in (

let uu____3619 = (FStar_All.pipe_right body term_to_string)
in (FStar_Util.format2 "let rec %s in %s" uu____3609 uu____3619)))
end
| Let (q, ((pat, tm))::[], body) -> begin
(

let uu____3631 = (FStar_All.pipe_right pat pat_to_string)
in (

let uu____3632 = (FStar_All.pipe_right tm term_to_string)
in (

let uu____3633 = (FStar_All.pipe_right body term_to_string)
in (FStar_Util.format4 "let %s %s = %s in %s" (string_of_let_qualifier q) uu____3631 uu____3632 uu____3633))))
end
| Seq (t1, t2) -> begin
(

let uu____3636 = (FStar_All.pipe_right t1 term_to_string)
in (

let uu____3637 = (FStar_All.pipe_right t2 term_to_string)
in (FStar_Util.format2 "%s; %s" uu____3636 uu____3637)))
end
| If (t1, t2, t3) -> begin
(

let uu____3641 = (FStar_All.pipe_right t1 term_to_string)
in (

let uu____3642 = (FStar_All.pipe_right t2 term_to_string)
in (

let uu____3643 = (FStar_All.pipe_right t3 term_to_string)
in (FStar_Util.format3 "if %s then %s else %s" uu____3641 uu____3642 uu____3643))))
end
| Match (t, branches) -> begin
(

let uu____3656 = (FStar_All.pipe_right t term_to_string)
in (

let uu____3657 = (to_string_l " | " (fun uu____3662 -> (match (uu____3662) with
| (p, w, e) -> begin
(

let uu____3672 = (FStar_All.pipe_right p pat_to_string)
in (

let uu____3673 = (match (w) with
| None -> begin
""
end
| Some (e1) -> begin
(

let uu____3675 = (term_to_string e1)
in (FStar_Util.format1 "when %s" uu____3675))
end)
in (

let uu____3676 = (FStar_All.pipe_right e term_to_string)
in (FStar_Util.format3 "%s %s -> %s" uu____3672 uu____3673 uu____3676))))
end)) branches)
in (FStar_Util.format2 "match %s with %s" uu____3656 uu____3657)))
end
| Ascribed (t1, t2, None) -> begin
(

let uu____3680 = (FStar_All.pipe_right t1 term_to_string)
in (

let uu____3681 = (FStar_All.pipe_right t2 term_to_string)
in (FStar_Util.format2 "(%s : %s)" uu____3680 uu____3681)))
end
| Ascribed (t1, t2, Some (tac)) -> begin
(

let uu____3686 = (FStar_All.pipe_right t1 term_to_string)
in (

let uu____3687 = (FStar_All.pipe_right t2 term_to_string)
in (

let uu____3688 = (FStar_All.pipe_right tac term_to_string)
in (FStar_Util.format3 "(%s : %s by %s)" uu____3686 uu____3687 uu____3688))))
end
| Record (Some (e), fields) -> begin
(

let uu____3698 = (FStar_All.pipe_right e term_to_string)
in (

let uu____3699 = (to_string_l " " (fun uu____3702 -> (match (uu____3702) with
| (l, e1) -> begin
(

let uu____3707 = (FStar_All.pipe_right e1 term_to_string)
in (FStar_Util.format2 "%s=%s" l.FStar_Ident.str uu____3707))
end)) fields)
in (FStar_Util.format2 "{%s with %s}" uu____3698 uu____3699)))
end
| Record (None, fields) -> begin
(

let uu____3716 = (to_string_l " " (fun uu____3719 -> (match (uu____3719) with
| (l, e) -> begin
(

let uu____3724 = (FStar_All.pipe_right e term_to_string)
in (FStar_Util.format2 "%s=%s" l.FStar_Ident.str uu____3724))
end)) fields)
in (FStar_Util.format1 "{%s}" uu____3716))
end
| Project (e, l) -> begin
(

let uu____3727 = (FStar_All.pipe_right e term_to_string)
in (FStar_Util.format2 "%s.%s" uu____3727 l.FStar_Ident.str))
end
| Product ([], t) -> begin
(term_to_string t)
end
| Product ((b)::(hd1)::tl1, t) -> begin
(term_to_string (mk_term (Product ((((b)::[]), ((mk_term (Product ((((hd1)::tl1), (t)))) x.range x.level))))) x.range x.level))
end
| Product ((b)::[], t) when (x.level = Type_level) -> begin
(

let uu____3741 = (FStar_All.pipe_right b binder_to_string)
in (

let uu____3742 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s -> %s" uu____3741 uu____3742)))
end
| Product ((b)::[], t) when (x.level = Kind) -> begin
(

let uu____3746 = (FStar_All.pipe_right b binder_to_string)
in (

let uu____3747 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s => %s" uu____3746 uu____3747)))
end
| Sum (binders, t) -> begin
(

let uu____3752 = (

let uu____3753 = (FStar_All.pipe_right binders (FStar_List.map binder_to_string))
in (FStar_All.pipe_right uu____3753 (FStar_String.concat " * ")))
in (

let uu____3758 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s * %s" uu____3752 uu____3758)))
end
| QForall (bs, pats, t) -> begin
(

let uu____3768 = (to_string_l " " binder_to_string bs)
in (

let uu____3769 = (to_string_l " \\/ " (to_string_l "; " term_to_string) pats)
in (

let uu____3771 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format3 "forall %s.{:pattern %s} %s" uu____3768 uu____3769 uu____3771))))
end
| QExists (bs, pats, t) -> begin
(

let uu____3781 = (to_string_l " " binder_to_string bs)
in (

let uu____3782 = (to_string_l " \\/ " (to_string_l "; " term_to_string) pats)
in (

let uu____3784 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format3 "exists %s.{:pattern %s} %s" uu____3781 uu____3782 uu____3784))))
end
| Refine (b, t) -> begin
(

let uu____3787 = (FStar_All.pipe_right b binder_to_string)
in (

let uu____3788 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s:{%s}" uu____3787 uu____3788)))
end
| NamedTyp (x1, t) -> begin
(

let uu____3791 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s:%s" x1.FStar_Ident.idText uu____3791))
end
| Paren (t) -> begin
(

let uu____3793 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format1 "(%s)" uu____3793))
end
| Product (bs, t) -> begin
(

let uu____3798 = (

let uu____3799 = (FStar_All.pipe_right bs (FStar_List.map binder_to_string))
in (FStar_All.pipe_right uu____3799 (FStar_String.concat ",")))
in (

let uu____3804 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "Unidentified product: [%s] %s" uu____3798 uu____3804)))
end
| t -> begin
"_"
end))
and binder_to_string : binder  ->  Prims.string = (fun x -> (

let s = (match (x.b) with
| Variable (i) -> begin
i.FStar_Ident.idText
end
| TVariable (i) -> begin
(FStar_Util.format1 "%s:_" i.FStar_Ident.idText)
end
| (TAnnotated (i, t)) | (Annotated (i, t)) -> begin
(

let uu____3812 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s:%s" i.FStar_Ident.idText uu____3812))
end
| NoName (t) -> begin
(FStar_All.pipe_right t term_to_string)
end)
in (

let uu____3814 = (aqual_to_string x.aqual)
in (FStar_Util.format2 "%s%s" uu____3814 s))))
and aqual_to_string : aqual  ->  Prims.string = (fun uu___115_3815 -> (match (uu___115_3815) with
| Some (Equality) -> begin
"$"
end
| Some (Implicit) -> begin
"#"
end
| uu____3816 -> begin
""
end))
and pat_to_string : pattern  ->  Prims.string = (fun x -> (match (x.pat) with
| PatWild -> begin
"_"
end
| PatConst (c) -> begin
(FStar_Syntax_Print.const_to_string c)
end
| PatApp (p, ps) -> begin
(

let uu____3823 = (FStar_All.pipe_right p pat_to_string)
in (

let uu____3824 = (to_string_l " " pat_to_string ps)
in (FStar_Util.format2 "(%s %s)" uu____3823 uu____3824)))
end
| (PatTvar (i, aq)) | (PatVar (i, aq)) -> begin
(

let uu____3831 = (aqual_to_string aq)
in (FStar_Util.format2 "%s%s" uu____3831 i.FStar_Ident.idText))
end
| PatName (l) -> begin
l.FStar_Ident.str
end
| PatList (l) -> begin
(

let uu____3835 = (to_string_l "; " pat_to_string l)
in (FStar_Util.format1 "[%s]" uu____3835))
end
| PatTuple (l, false) -> begin
(

let uu____3839 = (to_string_l ", " pat_to_string l)
in (FStar_Util.format1 "(%s)" uu____3839))
end
| PatTuple (l, true) -> begin
(

let uu____3843 = (to_string_l ", " pat_to_string l)
in (FStar_Util.format1 "(|%s|)" uu____3843))
end
| PatRecord (l) -> begin
(

let uu____3848 = (to_string_l "; " (fun uu____3851 -> (match (uu____3851) with
| (f, e) -> begin
(

let uu____3856 = (FStar_All.pipe_right e pat_to_string)
in (FStar_Util.format2 "%s=%s" f.FStar_Ident.str uu____3856))
end)) l)
in (FStar_Util.format1 "{%s}" uu____3848))
end
| PatOr (l) -> begin
(to_string_l "|\n " pat_to_string l)
end
| PatOp (op) -> begin
(FStar_Util.format1 "(%s)" (FStar_Ident.text_of_id op))
end
| PatAscribed (p, t) -> begin
(

let uu____3862 = (FStar_All.pipe_right p pat_to_string)
in (

let uu____3863 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "(%s:%s)" uu____3862 uu____3863)))
end))


let rec head_id_of_pat : pattern  ->  FStar_Ident.lid Prims.list = (fun p -> (match (p.pat) with
| PatName (l) -> begin
(l)::[]
end
| PatVar (i, uu____3871) -> begin
(

let uu____3874 = (FStar_Ident.lid_of_ids ((i)::[]))
in (uu____3874)::[])
end
| PatApp (p1, uu____3876) -> begin
(head_id_of_pat p1)
end
| PatAscribed (p1, uu____3880) -> begin
(head_id_of_pat p1)
end
| uu____3881 -> begin
[]
end))


let lids_of_let = (fun defs -> (FStar_All.pipe_right defs (FStar_List.collect (fun uu____3902 -> (match (uu____3902) with
| (p, uu____3907) -> begin
(head_id_of_pat p)
end)))))


let id_of_tycon : tycon  ->  Prims.string = (fun uu___116_3910 -> (match (uu___116_3910) with
| (TyconAbstract (i, _, _)) | (TyconAbbrev (i, _, _, _)) | (TyconRecord (i, _, _, _)) | (TyconVariant (i, _, _, _)) -> begin
i.FStar_Ident.idText
end))


let decl_to_string : decl  ->  Prims.string = (fun d -> (match (d.d) with
| TopLevelModule (l) -> begin
(Prims.strcat "module " l.FStar_Ident.str)
end
| Open (l) -> begin
(Prims.strcat "open " l.FStar_Ident.str)
end
| Include (l) -> begin
(Prims.strcat "include " l.FStar_Ident.str)
end
| ModuleAbbrev (i, l) -> begin
(FStar_Util.format2 "module %s = %s" i.FStar_Ident.idText l.FStar_Ident.str)
end
| TopLevelLet (uu____3951, pats) -> begin
(

let uu____3959 = (

let uu____3960 = (

let uu____3962 = (lids_of_let pats)
in (FStar_All.pipe_right uu____3962 (FStar_List.map (fun l -> l.FStar_Ident.str))))
in (FStar_All.pipe_right uu____3960 (FStar_String.concat ", ")))
in (Prims.strcat "let " uu____3959))
end
| Main (uu____3968) -> begin
"main ..."
end
| Assume (i, uu____3970) -> begin
(Prims.strcat "assume " i.FStar_Ident.idText)
end
| Tycon (uu____3971, tys) -> begin
(

let uu____3981 = (

let uu____3982 = (FStar_All.pipe_right tys (FStar_List.map (fun uu____3992 -> (match (uu____3992) with
| (x, uu____3997) -> begin
(id_of_tycon x)
end))))
in (FStar_All.pipe_right uu____3982 (FStar_String.concat ", ")))
in (Prims.strcat "type " uu____3981))
end
| Val (i, uu____4002) -> begin
(Prims.strcat "val " i.FStar_Ident.idText)
end
| Exception (i, uu____4004) -> begin
(Prims.strcat "exception " i.FStar_Ident.idText)
end
| (NewEffect (DefineEffect (i, _, _, _))) | (NewEffect (RedefineEffect (i, _, _))) -> begin
(Prims.strcat "new_effect " i.FStar_Ident.idText)
end
| SubEffect (uu____4016) -> begin
"sub_effect"
end
| Pragma (uu____4017) -> begin
"pragma"
end
| Fsdoc (uu____4018) -> begin
"fsdoc"
end))


let modul_to_string : modul  ->  Prims.string = (fun m -> (match (m) with
| (Module (_, decls)) | (Interface (_, decls, _)) -> begin
(

let uu____4030 = (FStar_All.pipe_right decls (FStar_List.map decl_to_string))
in (FStar_All.pipe_right uu____4030 (FStar_String.concat "\n")))
end))


let error = (fun msg tm r -> (

let tm1 = (FStar_All.pipe_right tm term_to_string)
in (

let tm2 = (match (((FStar_String.length tm1) >= (Prims.parse_int "80"))) with
| true -> begin
(

let uu____4057 = (FStar_Util.substring tm1 (Prims.parse_int "0") (Prims.parse_int "77"))
in (Prims.strcat uu____4057 "..."))
end
| uu____4058 -> begin
tm1
end)
in (Prims.raise (FStar_Errors.Error ((((Prims.strcat msg (Prims.strcat "\n" tm2))), (r))))))))




