
open Prims

type local_binding =
(FStar_Ident.ident * FStar_Syntax_Syntax.bv * Prims.bool)


type rec_binding =
(FStar_Ident.ident * FStar_Ident.lid * FStar_Syntax_Syntax.delta_depth)


type module_abbrev =
(FStar_Ident.ident * FStar_Ident.lident)

type open_kind =
| Open_module
| Open_namespace


let uu___is_Open_module : open_kind  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Open_module -> begin
true
end
| uu____12 -> begin
false
end))


let uu___is_Open_namespace : open_kind  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Open_namespace -> begin
true
end
| uu____16 -> begin
false
end))


type open_module_or_namespace =
(FStar_Ident.lident * open_kind)

type record_or_dc =
{typename : FStar_Ident.lident; constrname : FStar_Ident.ident; parms : FStar_Syntax_Syntax.binders; fields : (FStar_Ident.ident * FStar_Syntax_Syntax.typ) Prims.list; is_private_or_abstract : Prims.bool; is_record : Prims.bool}

type scope_mod =
| Local_binding of local_binding
| Rec_binding of rec_binding
| Module_abbrev of module_abbrev
| Open_module_or_namespace of open_module_or_namespace
| Top_level_def of FStar_Ident.ident
| Record_or_dc of record_or_dc


let uu___is_Local_binding : scope_mod  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Local_binding (_0) -> begin
true
end
| uu____92 -> begin
false
end))


let __proj__Local_binding__item___0 : scope_mod  ->  local_binding = (fun projectee -> (match (projectee) with
| Local_binding (_0) -> begin
_0
end))


let uu___is_Rec_binding : scope_mod  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Rec_binding (_0) -> begin
true
end
| uu____104 -> begin
false
end))


let __proj__Rec_binding__item___0 : scope_mod  ->  rec_binding = (fun projectee -> (match (projectee) with
| Rec_binding (_0) -> begin
_0
end))


let uu___is_Module_abbrev : scope_mod  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Module_abbrev (_0) -> begin
true
end
| uu____116 -> begin
false
end))


let __proj__Module_abbrev__item___0 : scope_mod  ->  module_abbrev = (fun projectee -> (match (projectee) with
| Module_abbrev (_0) -> begin
_0
end))


let uu___is_Open_module_or_namespace : scope_mod  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Open_module_or_namespace (_0) -> begin
true
end
| uu____128 -> begin
false
end))


let __proj__Open_module_or_namespace__item___0 : scope_mod  ->  open_module_or_namespace = (fun projectee -> (match (projectee) with
| Open_module_or_namespace (_0) -> begin
_0
end))


let uu___is_Top_level_def : scope_mod  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Top_level_def (_0) -> begin
true
end
| uu____140 -> begin
false
end))


let __proj__Top_level_def__item___0 : scope_mod  ->  FStar_Ident.ident = (fun projectee -> (match (projectee) with
| Top_level_def (_0) -> begin
_0
end))


let uu___is_Record_or_dc : scope_mod  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Record_or_dc (_0) -> begin
true
end
| uu____152 -> begin
false
end))


let __proj__Record_or_dc__item___0 : scope_mod  ->  record_or_dc = (fun projectee -> (match (projectee) with
| Record_or_dc (_0) -> begin
_0
end))


type string_set =
Prims.string FStar_Util.set

type exported_id_kind =
| Exported_id_term_type
| Exported_id_field


let uu___is_Exported_id_term_type : exported_id_kind  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Exported_id_term_type -> begin
true
end
| uu____164 -> begin
false
end))


let uu___is_Exported_id_field : exported_id_kind  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Exported_id_field -> begin
true
end
| uu____168 -> begin
false
end))


type exported_id_set =
exported_id_kind  ->  string_set FStar_ST.ref

type env =
{curmodule : FStar_Ident.lident Prims.option; curmonad : FStar_Ident.ident Prims.option; modules : (FStar_Ident.lident * FStar_Syntax_Syntax.modul) Prims.list; scope_mods : scope_mod Prims.list; exported_ids : exported_id_set FStar_Util.smap; trans_exported_ids : exported_id_set FStar_Util.smap; includes : FStar_Ident.lident Prims.list FStar_ST.ref FStar_Util.smap; sigaccum : FStar_Syntax_Syntax.sigelts; sigmap : (FStar_Syntax_Syntax.sigelt * Prims.bool) FStar_Util.smap; iface : Prims.bool; admitted_iface : Prims.bool; expect_typ : Prims.bool; docs : FStar_Parser_AST.fsdoc FStar_Util.smap; remaining_iface_decls : (FStar_Ident.lident * FStar_Parser_AST.decl Prims.list) Prims.list; syntax_only : Prims.bool}

type foundname =
| Term_name of (FStar_Syntax_Syntax.typ * Prims.bool)
| Eff_name of (FStar_Syntax_Syntax.sigelt * FStar_Ident.lident)


let uu___is_Term_name : foundname  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Term_name (_0) -> begin
true
end
| uu____350 -> begin
false
end))


let __proj__Term_name__item___0 : foundname  ->  (FStar_Syntax_Syntax.typ * Prims.bool) = (fun projectee -> (match (projectee) with
| Term_name (_0) -> begin
_0
end))


let uu___is_Eff_name : foundname  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Eff_name (_0) -> begin
true
end
| uu____370 -> begin
false
end))


let __proj__Eff_name__item___0 : foundname  ->  (FStar_Syntax_Syntax.sigelt * FStar_Ident.lident) = (fun projectee -> (match (projectee) with
| Eff_name (_0) -> begin
_0
end))


let set_iface : env  ->  Prims.bool  ->  env = (fun env b -> (

let uu___175_390 = env
in {curmodule = uu___175_390.curmodule; curmonad = uu___175_390.curmonad; modules = uu___175_390.modules; scope_mods = uu___175_390.scope_mods; exported_ids = uu___175_390.exported_ids; trans_exported_ids = uu___175_390.trans_exported_ids; includes = uu___175_390.includes; sigaccum = uu___175_390.sigaccum; sigmap = uu___175_390.sigmap; iface = b; admitted_iface = uu___175_390.admitted_iface; expect_typ = uu___175_390.expect_typ; docs = uu___175_390.docs; remaining_iface_decls = uu___175_390.remaining_iface_decls; syntax_only = uu___175_390.syntax_only}))


let iface : env  ->  Prims.bool = (fun e -> e.iface)


let set_admitted_iface : env  ->  Prims.bool  ->  env = (fun e b -> (

let uu___176_400 = e
in {curmodule = uu___176_400.curmodule; curmonad = uu___176_400.curmonad; modules = uu___176_400.modules; scope_mods = uu___176_400.scope_mods; exported_ids = uu___176_400.exported_ids; trans_exported_ids = uu___176_400.trans_exported_ids; includes = uu___176_400.includes; sigaccum = uu___176_400.sigaccum; sigmap = uu___176_400.sigmap; iface = uu___176_400.iface; admitted_iface = b; expect_typ = uu___176_400.expect_typ; docs = uu___176_400.docs; remaining_iface_decls = uu___176_400.remaining_iface_decls; syntax_only = uu___176_400.syntax_only}))


let admitted_iface : env  ->  Prims.bool = (fun e -> e.admitted_iface)


let set_expect_typ : env  ->  Prims.bool  ->  env = (fun e b -> (

let uu___177_410 = e
in {curmodule = uu___177_410.curmodule; curmonad = uu___177_410.curmonad; modules = uu___177_410.modules; scope_mods = uu___177_410.scope_mods; exported_ids = uu___177_410.exported_ids; trans_exported_ids = uu___177_410.trans_exported_ids; includes = uu___177_410.includes; sigaccum = uu___177_410.sigaccum; sigmap = uu___177_410.sigmap; iface = uu___177_410.iface; admitted_iface = uu___177_410.admitted_iface; expect_typ = b; docs = uu___177_410.docs; remaining_iface_decls = uu___177_410.remaining_iface_decls; syntax_only = uu___177_410.syntax_only}))


let expect_typ : env  ->  Prims.bool = (fun e -> e.expect_typ)


let all_exported_id_kinds : exported_id_kind Prims.list = (Exported_id_field)::(Exported_id_term_type)::[]


let transitive_exported_ids : env  ->  FStar_Ident.lident  ->  Prims.string Prims.list = (fun env lid -> (

let module_name = (FStar_Ident.string_of_lid lid)
in (

let uu____423 = (FStar_Util.smap_try_find env.trans_exported_ids module_name)
in (match (uu____423) with
| None -> begin
[]
end
| Some (exported_id_set) -> begin
(

let uu____427 = (

let uu____428 = (exported_id_set Exported_id_term_type)
in (FStar_ST.read uu____428))
in (FStar_All.pipe_right uu____427 FStar_Util.set_elements))
end))))


let open_modules : env  ->  (FStar_Ident.lident * FStar_Syntax_Syntax.modul) Prims.list = (fun e -> e.modules)


let set_current_module : env  ->  FStar_Ident.lident  ->  env = (fun e l -> (

let uu___178_446 = e
in {curmodule = Some (l); curmonad = uu___178_446.curmonad; modules = uu___178_446.modules; scope_mods = uu___178_446.scope_mods; exported_ids = uu___178_446.exported_ids; trans_exported_ids = uu___178_446.trans_exported_ids; includes = uu___178_446.includes; sigaccum = uu___178_446.sigaccum; sigmap = uu___178_446.sigmap; iface = uu___178_446.iface; admitted_iface = uu___178_446.admitted_iface; expect_typ = uu___178_446.expect_typ; docs = uu___178_446.docs; remaining_iface_decls = uu___178_446.remaining_iface_decls; syntax_only = uu___178_446.syntax_only}))


let current_module : env  ->  FStar_Ident.lident = (fun env -> (match (env.curmodule) with
| None -> begin
(failwith "Unset current module")
end
| Some (m) -> begin
m
end))


let iface_decls : env  ->  FStar_Ident.lident  ->  FStar_Parser_AST.decl Prims.list Prims.option = (fun env l -> (

let uu____459 = (FStar_All.pipe_right env.remaining_iface_decls (FStar_List.tryFind (fun uu____475 -> (match (uu____475) with
| (m, uu____480) -> begin
(FStar_Ident.lid_equals l m)
end))))
in (match (uu____459) with
| None -> begin
None
end
| Some (uu____489, decls) -> begin
Some (decls)
end)))


let set_iface_decls : env  ->  FStar_Ident.lident  ->  FStar_Parser_AST.decl Prims.list  ->  env = (fun env l ds -> (

let uu____508 = (FStar_List.partition (fun uu____522 -> (match (uu____522) with
| (m, uu____527) -> begin
(FStar_Ident.lid_equals l m)
end)) env.remaining_iface_decls)
in (match (uu____508) with
| (uu____530, rest) -> begin
(

let uu___179_548 = env
in {curmodule = uu___179_548.curmodule; curmonad = uu___179_548.curmonad; modules = uu___179_548.modules; scope_mods = uu___179_548.scope_mods; exported_ids = uu___179_548.exported_ids; trans_exported_ids = uu___179_548.trans_exported_ids; includes = uu___179_548.includes; sigaccum = uu___179_548.sigaccum; sigmap = uu___179_548.sigmap; iface = uu___179_548.iface; admitted_iface = uu___179_548.admitted_iface; expect_typ = uu___179_548.expect_typ; docs = uu___179_548.docs; remaining_iface_decls = (((l), (ds)))::rest; syntax_only = uu___179_548.syntax_only})
end)))


let qual : FStar_Ident.lident  ->  FStar_Ident.ident  ->  FStar_Ident.lident = FStar_Syntax_Util.qual_id


let qualify : env  ->  FStar_Ident.ident  ->  FStar_Ident.lident = (fun env id -> (match (env.curmonad) with
| None -> begin
(

let uu____563 = (current_module env)
in (qual uu____563 id))
end
| Some (monad) -> begin
(

let uu____565 = (

let uu____566 = (current_module env)
in (qual uu____566 monad))
in (FStar_Syntax_Util.mk_field_projector_name_from_ident uu____565 id))
end))


let syntax_only : env  ->  Prims.bool = (fun env -> env.syntax_only)


let set_syntax_only : env  ->  Prims.bool  ->  env = (fun env b -> (

let uu___180_576 = env
in {curmodule = uu___180_576.curmodule; curmonad = uu___180_576.curmonad; modules = uu___180_576.modules; scope_mods = uu___180_576.scope_mods; exported_ids = uu___180_576.exported_ids; trans_exported_ids = uu___180_576.trans_exported_ids; includes = uu___180_576.includes; sigaccum = uu___180_576.sigaccum; sigmap = uu___180_576.sigmap; iface = uu___180_576.iface; admitted_iface = uu___180_576.admitted_iface; expect_typ = uu___180_576.expect_typ; docs = uu___180_576.docs; remaining_iface_decls = uu___180_576.remaining_iface_decls; syntax_only = b}))


let new_sigmap = (fun uu____584 -> (FStar_Util.smap_create (Prims.parse_int "100")))


let empty_env : Prims.unit  ->  env = (fun uu____587 -> (

let uu____588 = (new_sigmap ())
in (

let uu____590 = (new_sigmap ())
in (

let uu____592 = (new_sigmap ())
in (

let uu____598 = (new_sigmap ())
in (

let uu____604 = (new_sigmap ())
in {curmodule = None; curmonad = None; modules = []; scope_mods = []; exported_ids = uu____588; trans_exported_ids = uu____590; includes = uu____592; sigaccum = []; sigmap = uu____598; iface = false; admitted_iface = false; expect_typ = false; docs = uu____604; remaining_iface_decls = []; syntax_only = false}))))))


let sigmap : env  ->  (FStar_Syntax_Syntax.sigelt * Prims.bool) FStar_Util.smap = (fun env -> env.sigmap)


let has_all_in_scope : env  ->  Prims.bool = (fun env -> (FStar_List.existsb (fun uu____622 -> (match (uu____622) with
| (m, uu____626) -> begin
(FStar_Ident.lid_equals m FStar_Syntax_Const.all_lid)
end)) env.modules))


let set_bv_range : FStar_Syntax_Syntax.bv  ->  FStar_Range.range  ->  FStar_Syntax_Syntax.bv = (fun bv r -> (

let id = (

let uu___181_634 = bv.FStar_Syntax_Syntax.ppname
in {FStar_Ident.idText = uu___181_634.FStar_Ident.idText; FStar_Ident.idRange = r})
in (

let uu___182_635 = bv
in {FStar_Syntax_Syntax.ppname = id; FStar_Syntax_Syntax.index = uu___182_635.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = uu___182_635.FStar_Syntax_Syntax.sort})))


let bv_to_name : FStar_Syntax_Syntax.bv  ->  FStar_Range.range  ->  FStar_Syntax_Syntax.term = (fun bv r -> (FStar_Syntax_Syntax.bv_to_name (set_bv_range bv r)))


let unmangleMap : (Prims.string * Prims.string * FStar_Syntax_Syntax.delta_depth * FStar_Syntax_Syntax.fv_qual Prims.option) Prims.list = ((("op_ColonColon"), ("Cons"), (FStar_Syntax_Syntax.Delta_constant), (Some (FStar_Syntax_Syntax.Data_ctor))))::((("not"), ("op_Negation"), (FStar_Syntax_Syntax.Delta_equational), (None)))::[]


let unmangleOpName : FStar_Ident.ident  ->  (FStar_Syntax_Syntax.term * Prims.bool) Prims.option = (fun id -> (

let t = (FStar_Util.find_map unmangleMap (fun uu____681 -> (match (uu____681) with
| (x, y, dd, dq) -> begin
(match ((id.FStar_Ident.idText = x)) with
| true -> begin
(

let uu____695 = (

let uu____696 = (FStar_Ident.lid_of_path (("Prims")::(y)::[]) id.FStar_Ident.idRange)
in (FStar_Syntax_Syntax.fvar uu____696 dd dq))
in Some (uu____695))
end
| uu____697 -> begin
None
end)
end)))
in (match (t) with
| Some (v1) -> begin
Some (((v1), (false)))
end
| None -> begin
None
end)))

type 'a cont_t =
| Cont_ok of 'a
| Cont_fail
| Cont_ignore


let uu___is_Cont_ok = (fun projectee -> (match (projectee) with
| Cont_ok (_0) -> begin
true
end
| uu____726 -> begin
false
end))


let __proj__Cont_ok__item___0 = (fun projectee -> (match (projectee) with
| Cont_ok (_0) -> begin
_0
end))


let uu___is_Cont_fail = (fun projectee -> (match (projectee) with
| Cont_fail -> begin
true
end
| uu____750 -> begin
false
end))


let uu___is_Cont_ignore = (fun projectee -> (match (projectee) with
| Cont_ignore -> begin
true
end
| uu____761 -> begin
false
end))


let option_of_cont = (fun k_ignore uu___148_780 -> (match (uu___148_780) with
| Cont_ok (a) -> begin
Some (a)
end
| Cont_fail -> begin
None
end
| Cont_ignore -> begin
(k_ignore ())
end))


let find_in_record = (fun ns id record cont -> (

let typename' = (FStar_Ident.lid_of_ids (FStar_List.append ns ((record.typename.FStar_Ident.ident)::[])))
in (match ((FStar_Ident.lid_equals typename' record.typename)) with
| true -> begin
(

let fname = (FStar_Ident.lid_of_ids (FStar_List.append record.typename.FStar_Ident.ns ((id)::[])))
in (

let find1 = (FStar_Util.find_map record.fields (fun uu____825 -> (match (uu____825) with
| (f, uu____830) -> begin
(match ((id.FStar_Ident.idText = f.FStar_Ident.idText)) with
| true -> begin
Some (record)
end
| uu____832 -> begin
None
end)
end)))
in (match (find1) with
| Some (r) -> begin
(cont r)
end
| None -> begin
Cont_ignore
end)))
end
| uu____835 -> begin
Cont_ignore
end)))


let get_exported_id_set : env  ->  Prims.string  ->  (exported_id_kind  ->  string_set FStar_ST.ref) Prims.option = (fun e mname -> (FStar_Util.smap_try_find e.exported_ids mname))


let get_trans_exported_id_set : env  ->  Prims.string  ->  (exported_id_kind  ->  string_set FStar_ST.ref) Prims.option = (fun e mname -> (FStar_Util.smap_try_find e.trans_exported_ids mname))


let string_of_exported_id_kind : exported_id_kind  ->  Prims.string = (fun uu___149_866 -> (match (uu___149_866) with
| Exported_id_field -> begin
"field"
end
| Exported_id_term_type -> begin
"term/type"
end))


let find_in_module_with_includes = (fun eikind find_in_module find_in_module_default env ns id -> (

let idstr = id.FStar_Ident.idText
in (

let rec aux = (fun uu___150_915 -> (match (uu___150_915) with
| [] -> begin
find_in_module_default
end
| (modul)::q -> begin
(

let mname = modul.FStar_Ident.str
in (

let not_shadowed = (

let uu____923 = (get_exported_id_set env mname)
in (match (uu____923) with
| None -> begin
true
end
| Some (mex) -> begin
(

let mexports = (

let uu____939 = (mex eikind)
in (FStar_ST.read uu____939))
in (FStar_Util.set_mem idstr mexports))
end))
in (

let mincludes = (

let uu____946 = (FStar_Util.smap_try_find env.includes mname)
in (match (uu____946) with
| None -> begin
[]
end
| Some (minc) -> begin
(FStar_ST.read minc)
end))
in (

let look_into = (match (not_shadowed) with
| true -> begin
(

let uu____966 = (qual modul id)
in (find_in_module uu____966))
end
| uu____967 -> begin
Cont_ignore
end)
in (match (look_into) with
| Cont_ignore -> begin
(aux (FStar_List.append mincludes q))
end
| uu____969 -> begin
look_into
end)))))
end))
in (aux ((ns)::[])))))


let is_exported_id_field : exported_id_kind  ->  Prims.bool = (fun uu___151_973 -> (match (uu___151_973) with
| Exported_id_field -> begin
true
end
| uu____974 -> begin
false
end))


let try_lookup_id'' = (fun env id eikind k_local_binding k_rec_binding k_record find_in_module lookup_default_id -> (

let check_local_binding_id = (fun uu___152_1063 -> (match (uu___152_1063) with
| (id', uu____1065, uu____1066) -> begin
(id'.FStar_Ident.idText = id.FStar_Ident.idText)
end))
in (

let check_rec_binding_id = (fun uu___153_1070 -> (match (uu___153_1070) with
| (id', uu____1072, uu____1073) -> begin
(id'.FStar_Ident.idText = id.FStar_Ident.idText)
end))
in (

let curmod_ns = (

let uu____1076 = (current_module env)
in (FStar_Ident.ids_of_lid uu____1076))
in (

let proc = (fun uu___154_1081 -> (match (uu___154_1081) with
| Local_binding (l) when (check_local_binding_id l) -> begin
(k_local_binding l)
end
| Rec_binding (r) when (check_rec_binding_id r) -> begin
(k_rec_binding r)
end
| Open_module_or_namespace (ns, uu____1086) -> begin
(find_in_module_with_includes eikind find_in_module Cont_ignore env ns id)
end
| Top_level_def (id') when (id'.FStar_Ident.idText = id.FStar_Ident.idText) -> begin
(lookup_default_id Cont_ignore id)
end
| Record_or_dc (r) when (is_exported_id_field eikind) -> begin
(

let uu____1089 = (FStar_Ident.lid_of_ids curmod_ns)
in (find_in_module_with_includes Exported_id_field (fun lid -> (

let id1 = lid.FStar_Ident.ident
in (find_in_record lid.FStar_Ident.ns id1 r k_record))) Cont_ignore env uu____1089 id))
end
| uu____1092 -> begin
Cont_ignore
end))
in (

let rec aux = (fun uu___155_1098 -> (match (uu___155_1098) with
| (a)::q -> begin
(

let uu____1104 = (proc a)
in (option_of_cont (fun uu____1106 -> (aux q)) uu____1104))
end
| [] -> begin
(

let uu____1107 = (lookup_default_id Cont_fail id)
in (option_of_cont (fun uu____1109 -> None) uu____1107))
end))
in (aux env.scope_mods)))))))


let found_local_binding = (fun r uu____1128 -> (match (uu____1128) with
| (id', x, mut) -> begin
(

let uu____1135 = (bv_to_name x r)
in ((uu____1135), (mut)))
end))


let find_in_module = (fun env lid k_global_def k_not_found -> (

let uu____1172 = (FStar_Util.smap_try_find (sigmap env) lid.FStar_Ident.str)
in (match (uu____1172) with
| Some (sb) -> begin
(k_global_def lid sb)
end
| None -> begin
k_not_found
end)))


let try_lookup_id : env  ->  FStar_Ident.ident  ->  (FStar_Syntax_Syntax.term * Prims.bool) Prims.option = (fun env id -> (

let uu____1194 = (unmangleOpName id)
in (match (uu____1194) with
| Some (f) -> begin
Some (f)
end
| uu____1208 -> begin
(try_lookup_id'' env id Exported_id_term_type (fun r -> (

let uu____1215 = (found_local_binding id.FStar_Ident.idRange r)
in Cont_ok (uu____1215))) (fun uu____1220 -> Cont_fail) (fun uu____1223 -> Cont_ignore) (fun i -> (find_in_module env i (fun uu____1230 uu____1231 -> Cont_fail) Cont_ignore)) (fun uu____1238 uu____1239 -> Cont_fail))
end)))


let lookup_default_id = (fun env id k_global_def k_not_found -> (

let find_in_monad = (match (env.curmonad) with
| Some (uu____1291) -> begin
(

let lid = (qualify env id)
in (

let uu____1293 = (FStar_Util.smap_try_find (sigmap env) lid.FStar_Ident.str)
in (match (uu____1293) with
| Some (r) -> begin
(

let uu____1306 = (k_global_def lid r)
in Some (uu____1306))
end
| None -> begin
None
end)))
end
| None -> begin
None
end)
in (match (find_in_monad) with
| Some (v1) -> begin
v1
end
| None -> begin
(

let lid = (

let uu____1319 = (current_module env)
in (qual uu____1319 id))
in (find_in_module env lid k_global_def k_not_found))
end)))


let module_is_defined : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> ((match (env.curmodule) with
| None -> begin
false
end
| Some (m) -> begin
(

let uu____1328 = (current_module env)
in (FStar_Ident.lid_equals lid uu____1328))
end) || (FStar_List.existsb (fun x -> (FStar_Ident.lid_equals lid (Prims.fst x))) env.modules)))


let resolve_module_name : env  ->  FStar_Ident.lident  ->  Prims.bool  ->  FStar_Ident.lident Prims.option = (fun env lid honor_ns -> (

let nslen = (FStar_List.length lid.FStar_Ident.ns)
in (

let rec aux = (fun uu___156_1352 -> (match (uu___156_1352) with
| [] -> begin
(

let uu____1355 = (module_is_defined env lid)
in (match (uu____1355) with
| true -> begin
Some (lid)
end
| uu____1357 -> begin
None
end))
end
| (Open_module_or_namespace (ns, Open_namespace))::q when honor_ns -> begin
(

let new_lid = (

let uu____1362 = (

let uu____1364 = (FStar_Ident.path_of_lid ns)
in (

let uu____1366 = (FStar_Ident.path_of_lid lid)
in (FStar_List.append uu____1364 uu____1366)))
in (FStar_Ident.lid_of_path uu____1362 (FStar_Ident.range_of_lid lid)))
in (

let uu____1368 = (module_is_defined env new_lid)
in (match (uu____1368) with
| true -> begin
Some (new_lid)
end
| uu____1370 -> begin
(aux q)
end)))
end
| (Module_abbrev (name, modul))::uu____1373 when ((nslen = (Prims.parse_int "0")) && (name.FStar_Ident.idText = lid.FStar_Ident.ident.FStar_Ident.idText)) -> begin
Some (modul)
end
| (uu____1377)::q -> begin
(aux q)
end))
in (aux env.scope_mods))))


let fail_if_curmodule : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident  ->  Prims.unit = (fun env ns_original ns_resolved -> (

let uu____1389 = (

let uu____1390 = (current_module env)
in (FStar_Ident.lid_equals ns_resolved uu____1390))
in (match (uu____1389) with
| true -> begin
(match ((FStar_Ident.lid_equals ns_resolved FStar_Syntax_Const.prims_lid)) with
| true -> begin
()
end
| uu____1391 -> begin
(

let uu____1392 = (

let uu____1393 = (

let uu____1396 = (FStar_Util.format1 "Reference %s to current module is forbidden (see GitHub issue #451)" ns_original.FStar_Ident.str)
in ((uu____1396), ((FStar_Ident.range_of_lid ns_original))))
in FStar_Errors.Error (uu____1393))
in (Prims.raise uu____1392))
end)
end
| uu____1397 -> begin
()
end)))


let fail_if_qualified_by_curmodule : env  ->  FStar_Ident.lident  ->  Prims.unit = (fun env lid -> (match (lid.FStar_Ident.ns) with
| [] -> begin
()
end
| uu____1404 -> begin
(

let modul_orig = (FStar_Ident.lid_of_ids lid.FStar_Ident.ns)
in (

let uu____1407 = (resolve_module_name env modul_orig true)
in (match (uu____1407) with
| Some (modul_res) -> begin
(fail_if_curmodule env modul_orig modul_res)
end
| uu____1410 -> begin
()
end)))
end))


let namespace_is_open : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (FStar_List.existsb (fun uu___157_1418 -> (match (uu___157_1418) with
| Open_module_or_namespace (ns, Open_namespace) -> begin
(FStar_Ident.lid_equals lid ns)
end
| uu____1420 -> begin
false
end)) env.scope_mods))


let shorten_module_path : env  ->  FStar_Ident.ident Prims.list  ->  Prims.bool  ->  (FStar_Ident.ident Prims.list * FStar_Ident.ident Prims.list) = (fun env ids is_full_path -> (

let rec aux = (fun revns id -> (

let lid = (FStar_Ident.lid_of_ns_and_id (FStar_List.rev revns) id)
in (match ((namespace_is_open env lid)) with
| true -> begin
Some ((((FStar_List.rev ((id)::revns))), ([])))
end
| uu____1462 -> begin
(match (revns) with
| [] -> begin
None
end
| (ns_last_id)::rev_ns_prefix -> begin
(

let uu____1475 = (aux rev_ns_prefix ns_last_id)
in (FStar_All.pipe_right uu____1475 (FStar_Util.map_option (fun uu____1499 -> (match (uu____1499) with
| (stripped_ids, rev_kept_ids) -> begin
((stripped_ids), ((id)::rev_kept_ids))
end)))))
end)
end)))
in (

let uu____1516 = (is_full_path && (

let uu____1517 = (FStar_Ident.lid_of_ids ids)
in (module_is_defined env uu____1517)))
in (match (uu____1516) with
| true -> begin
((ids), ([]))
end
| uu____1524 -> begin
(match ((FStar_List.rev ids)) with
| [] -> begin
(([]), ([]))
end
| (ns_last_id)::ns_rev_prefix -> begin
(

let uu____1534 = (aux ns_rev_prefix ns_last_id)
in (match (uu____1534) with
| None -> begin
(([]), (ids))
end
| Some (stripped_ids, rev_kept_ids) -> begin
((stripped_ids), ((FStar_List.rev rev_kept_ids)))
end))
end)
end))))


let shorten_lid : env  ->  FStar_Ident.lid  ->  FStar_Ident.lid = (fun env lid -> (

let uu____1568 = (shorten_module_path env lid.FStar_Ident.ns true)
in (match (uu____1568) with
| (uu____1573, short) -> begin
(FStar_Ident.lid_of_ns_and_id short lid.FStar_Ident.ident)
end)))


let resolve_in_open_namespaces'' = (fun env lid eikind k_local_binding k_rec_binding k_record f_module l_default -> (match (lid.FStar_Ident.ns) with
| (uu____1664)::uu____1665 -> begin
(

let uu____1667 = (

let uu____1669 = (

let uu____1670 = (FStar_Ident.lid_of_ids lid.FStar_Ident.ns)
in (FStar_Ident.set_lid_range uu____1670 (FStar_Ident.range_of_lid lid)))
in (resolve_module_name env uu____1669 true))
in (match (uu____1667) with
| None -> begin
None
end
| Some (modul) -> begin
(

let uu____1673 = (find_in_module_with_includes eikind f_module Cont_fail env modul lid.FStar_Ident.ident)
in (option_of_cont (fun uu____1675 -> None) uu____1673))
end))
end
| [] -> begin
(try_lookup_id'' env lid.FStar_Ident.ident eikind k_local_binding k_rec_binding k_record f_module l_default)
end))


let cont_of_option = (fun k_none uu___158_1690 -> (match (uu___158_1690) with
| Some (v1) -> begin
Cont_ok (v1)
end
| None -> begin
k_none
end))


let resolve_in_open_namespaces' = (fun env lid k_local_binding k_rec_binding k_global_def -> (

let k_global_def' = (fun k lid1 def -> (

let uu____1769 = (k_global_def lid1 def)
in (cont_of_option k uu____1769)))
in (

let f_module = (fun lid' -> (

let k = Cont_ignore
in (find_in_module env lid' (k_global_def' k) k)))
in (

let l_default = (fun k i -> (lookup_default_id env i (k_global_def' k) k))
in (resolve_in_open_namespaces'' env lid Exported_id_term_type (fun l -> (

let uu____1790 = (k_local_binding l)
in (cont_of_option Cont_fail uu____1790))) (fun r -> (

let uu____1793 = (k_rec_binding r)
in (cont_of_option Cont_fail uu____1793))) (fun uu____1795 -> Cont_ignore) f_module l_default)))))


let fv_qual_of_se : FStar_Syntax_Syntax.sigelt  ->  FStar_Syntax_Syntax.fv_qual Prims.option = (fun se -> (match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_datacon (uu____1801, uu____1802, uu____1803, l, uu____1805, quals, uu____1807) -> begin
(

let qopt = (FStar_Util.find_map quals (fun uu___159_1814 -> (match (uu___159_1814) with
| FStar_Syntax_Syntax.RecordConstructor (uu____1816, fs) -> begin
Some (FStar_Syntax_Syntax.Record_ctor (((l), (fs))))
end
| uu____1823 -> begin
None
end)))
in (match (qopt) with
| None -> begin
Some (FStar_Syntax_Syntax.Data_ctor)
end
| x -> begin
x
end))
end
| FStar_Syntax_Syntax.Sig_declare_typ (uu____1827, uu____1828, uu____1829, quals) -> begin
None
end
| uu____1833 -> begin
None
end))


let lb_fv : FStar_Syntax_Syntax.letbinding Prims.list  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.fv = (fun lbs lid -> (

let uu____1842 = (FStar_Util.find_map lbs (fun lb -> (

let fv = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in (

let uu____1846 = (FStar_Syntax_Syntax.fv_eq_lid fv lid)
in (match (uu____1846) with
| true -> begin
Some (fv)
end
| uu____1848 -> begin
None
end)))))
in (FStar_All.pipe_right uu____1842 FStar_Util.must)))


let ns_of_lid_equals : FStar_Ident.lident  ->  FStar_Ident.lident  ->  Prims.bool = (fun lid ns -> (((FStar_List.length lid.FStar_Ident.ns) = (FStar_List.length (FStar_Ident.ids_of_lid ns))) && (

let uu____1860 = (FStar_Ident.lid_of_ids lid.FStar_Ident.ns)
in (FStar_Ident.lid_equals uu____1860 ns))))


let try_lookup_name : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  foundname Prims.option = (fun any_val exclude_interf env lid -> (

let occurrence_range = (FStar_Ident.range_of_lid lid)
in (

let k_global_def = (fun source_lid uu___163_1885 -> (match (uu___163_1885) with
| (uu____1889, true) when exclude_interf -> begin
None
end
| (se, uu____1891) -> begin
(match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_inductive_typ (uu____1893) -> begin
(

let uu____1904 = (

let uu____1905 = (

let uu____1908 = (FStar_Syntax_Syntax.fvar source_lid FStar_Syntax_Syntax.Delta_constant None)
in ((uu____1908), (false)))
in Term_name (uu____1905))
in Some (uu____1904))
end
| FStar_Syntax_Syntax.Sig_datacon (uu____1909) -> begin
(

let uu____1919 = (

let uu____1920 = (

let uu____1923 = (

let uu____1924 = (fv_qual_of_se se)
in (FStar_Syntax_Syntax.fvar source_lid FStar_Syntax_Syntax.Delta_constant uu____1924))
in ((uu____1923), (false)))
in Term_name (uu____1920))
in Some (uu____1919))
end
| FStar_Syntax_Syntax.Sig_let ((uu____1926, lbs), uu____1928, uu____1929, uu____1930) -> begin
(

let fv = (lb_fv lbs source_lid)
in (

let uu____1943 = (

let uu____1944 = (

let uu____1947 = (FStar_Syntax_Syntax.fvar source_lid fv.FStar_Syntax_Syntax.fv_delta fv.FStar_Syntax_Syntax.fv_qual)
in ((uu____1947), (false)))
in Term_name (uu____1944))
in Some (uu____1943)))
end
| FStar_Syntax_Syntax.Sig_declare_typ (lid1, uu____1949, uu____1950, quals) -> begin
(

let uu____1954 = (any_val || (FStar_All.pipe_right quals (FStar_Util.for_some (fun uu___160_1956 -> (match (uu___160_1956) with
| FStar_Syntax_Syntax.Assumption -> begin
true
end
| uu____1957 -> begin
false
end)))))
in (match (uu____1954) with
| true -> begin
(

let lid2 = (FStar_Ident.set_lid_range lid1 (FStar_Ident.range_of_lid source_lid))
in (

let dd = (

let uu____1961 = ((FStar_Syntax_Util.is_primop_lid lid2) || ((ns_of_lid_equals lid2 FStar_Syntax_Const.prims_lid) && (FStar_All.pipe_right quals (FStar_Util.for_some (fun uu___161_1963 -> (match (uu___161_1963) with
| (FStar_Syntax_Syntax.Projector (_)) | (FStar_Syntax_Syntax.Discriminator (_)) -> begin
true
end
| uu____1966 -> begin
false
end))))))
in (match (uu____1961) with
| true -> begin
FStar_Syntax_Syntax.Delta_equational
end
| uu____1967 -> begin
FStar_Syntax_Syntax.Delta_constant
end))
in (

let uu____1968 = (FStar_Util.find_map quals (fun uu___162_1970 -> (match (uu___162_1970) with
| FStar_Syntax_Syntax.Reflectable (refl_monad) -> begin
Some (refl_monad)
end
| uu____1973 -> begin
None
end)))
in (match (uu____1968) with
| Some (refl_monad) -> begin
(

let refl_const = ((FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_reflect (refl_monad)))) None occurrence_range)
in Some (Term_name (((refl_const), (false)))))
end
| uu____1989 -> begin
(

let uu____1991 = (

let uu____1992 = (

let uu____1995 = (

let uu____1996 = (fv_qual_of_se se)
in (FStar_Syntax_Syntax.fvar lid2 dd uu____1996))
in ((uu____1995), (false)))
in Term_name (uu____1992))
in Some (uu____1991))
end))))
end
| uu____1998 -> begin
None
end))
end
| (FStar_Syntax_Syntax.Sig_new_effect_for_free (ne)) | (FStar_Syntax_Syntax.Sig_new_effect (ne)) -> begin
Some (Eff_name (((se), ((FStar_Ident.set_lid_range ne.FStar_Syntax_Syntax.mname (FStar_Ident.range_of_lid source_lid))))))
end
| FStar_Syntax_Syntax.Sig_effect_abbrev (uu____2000) -> begin
Some (Eff_name (((se), (source_lid))))
end
| uu____2009 -> begin
None
end)
end))
in (

let k_local_binding = (fun r -> (

let uu____2021 = (

let uu____2022 = (found_local_binding (FStar_Ident.range_of_lid lid) r)
in Term_name (uu____2022))
in Some (uu____2021)))
in (

let k_rec_binding = (fun uu____2032 -> (match (uu____2032) with
| (id, l, dd) -> begin
(

let uu____2040 = (

let uu____2041 = (

let uu____2044 = (FStar_Syntax_Syntax.fvar (FStar_Ident.set_lid_range l (FStar_Ident.range_of_lid lid)) dd None)
in ((uu____2044), (false)))
in Term_name (uu____2041))
in Some (uu____2040))
end))
in (

let found_unmangled = (match (lid.FStar_Ident.ns) with
| [] -> begin
(

let uu____2048 = (unmangleOpName lid.FStar_Ident.ident)
in (match (uu____2048) with
| Some (f) -> begin
Some (Term_name (f))
end
| uu____2058 -> begin
None
end))
end
| uu____2062 -> begin
None
end)
in (match (found_unmangled) with
| None -> begin
(resolve_in_open_namespaces' env lid k_local_binding k_rec_binding k_global_def)
end
| x -> begin
x
end)))))))


let try_lookup_effect_name' : Prims.bool  ->  env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.sigelt * FStar_Ident.lident) Prims.option = (fun exclude_interf env lid -> (

let uu____2082 = (try_lookup_name true exclude_interf env lid)
in (match (uu____2082) with
| Some (Eff_name (o, l)) -> begin
Some (((o), (l)))
end
| uu____2091 -> begin
None
end)))


let try_lookup_effect_name : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.option = (fun env l -> (

let uu____2102 = (try_lookup_effect_name' (not (env.iface)) env l)
in (match (uu____2102) with
| Some (o, l1) -> begin
Some (l1)
end
| uu____2111 -> begin
None
end)))


let try_lookup_effect_name_and_attributes : env  ->  FStar_Ident.lident  ->  (FStar_Ident.lident * FStar_Syntax_Syntax.cflags Prims.list) Prims.option = (fun env l -> (

let uu____2125 = (try_lookup_effect_name' (not (env.iface)) env l)
in (match (uu____2125) with
| Some ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_new_effect (ne); FStar_Syntax_Syntax.sigrng = uu____2134}, l1) -> begin
Some (((l1), (ne.FStar_Syntax_Syntax.cattributes)))
end
| Some ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_new_effect_for_free (ne); FStar_Syntax_Syntax.sigrng = uu____2143}, l1) -> begin
Some (((l1), (ne.FStar_Syntax_Syntax.cattributes)))
end
| Some ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_effect_abbrev (uu____2151, uu____2152, uu____2153, uu____2154, uu____2155, cattributes); FStar_Syntax_Syntax.sigrng = uu____2157}, l1) -> begin
Some (((l1), (cattributes)))
end
| uu____2169 -> begin
None
end)))


let try_lookup_effect_defn : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.eff_decl Prims.option = (fun env l -> (

let uu____2183 = (try_lookup_effect_name' (not (env.iface)) env l)
in (match (uu____2183) with
| Some ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_new_effect (ne); FStar_Syntax_Syntax.sigrng = uu____2189}, uu____2190) -> begin
Some (ne)
end
| Some ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_new_effect_for_free (ne); FStar_Syntax_Syntax.sigrng = uu____2194}, uu____2195) -> begin
Some (ne)
end
| uu____2198 -> begin
None
end)))


let is_effect_name : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (

let uu____2208 = (try_lookup_effect_name env lid)
in (match (uu____2208) with
| None -> begin
false
end
| Some (uu____2210) -> begin
true
end)))


let try_lookup_root_effect_name : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.option = (fun env l -> (

let uu____2218 = (try_lookup_effect_name' (not (env.iface)) env l)
in (match (uu____2218) with
| Some ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_effect_abbrev (l', uu____2224, uu____2225, uu____2226, uu____2227, uu____2228); FStar_Syntax_Syntax.sigrng = uu____2229}, uu____2230) -> begin
(

let rec aux = (fun new_name -> (

let uu____2242 = (FStar_Util.smap_try_find (sigmap env) new_name.FStar_Ident.str)
in (match (uu____2242) with
| None -> begin
None
end
| Some (s, uu____2252) -> begin
(match (s.FStar_Syntax_Syntax.sigel) with
| (FStar_Syntax_Syntax.Sig_new_effect_for_free (ne)) | (FStar_Syntax_Syntax.Sig_new_effect (ne)) -> begin
Some ((FStar_Ident.set_lid_range ne.FStar_Syntax_Syntax.mname (FStar_Ident.range_of_lid l)))
end
| FStar_Syntax_Syntax.Sig_effect_abbrev (uu____2257, uu____2258, uu____2259, cmp, uu____2261, uu____2262) -> begin
(

let l'' = (FStar_Syntax_Util.comp_effect_name cmp)
in (aux l''))
end
| uu____2268 -> begin
None
end)
end)))
in (aux l'))
end
| Some (uu____2269, l') -> begin
Some (l')
end
| uu____2273 -> begin
None
end)))


let lookup_letbinding_quals : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.qualifier Prims.list = (fun env lid -> (

let k_global_def = (fun lid1 uu___164_2294 -> (match (uu___164_2294) with
| ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_declare_typ (lid2, uu____2300, uu____2301, quals); FStar_Syntax_Syntax.sigrng = uu____2303}, uu____2304) -> begin
Some (quals)
end
| uu____2308 -> begin
None
end))
in (

let uu____2312 = (resolve_in_open_namespaces' env lid (fun uu____2316 -> None) (fun uu____2318 -> None) k_global_def)
in (match (uu____2312) with
| Some (quals) -> begin
quals
end
| uu____2324 -> begin
[]
end))))


let try_lookup_module : env  ->  Prims.string Prims.list  ->  FStar_Syntax_Syntax.modul Prims.option = (fun env path -> (

let uu____2336 = (FStar_List.tryFind (fun uu____2342 -> (match (uu____2342) with
| (mlid, modul) -> begin
(

let uu____2347 = (FStar_Ident.path_of_lid mlid)
in (uu____2347 = path))
end)) env.modules)
in (match (uu____2336) with
| Some (uu____2351, modul) -> begin
Some (modul)
end
| None -> begin
None
end)))


let try_lookup_let : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term Prims.option = (fun env lid -> (

let k_global_def = (fun lid1 uu___165_2373 -> (match (uu___165_2373) with
| ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_let ((uu____2377, lbs), uu____2379, uu____2380, uu____2381); FStar_Syntax_Syntax.sigrng = uu____2382}, uu____2383) -> begin
(

let fv = (lb_fv lbs lid1)
in (

let uu____2396 = (FStar_Syntax_Syntax.fvar lid1 fv.FStar_Syntax_Syntax.fv_delta fv.FStar_Syntax_Syntax.fv_qual)
in Some (uu____2396)))
end
| uu____2397 -> begin
None
end))
in (resolve_in_open_namespaces' env lid (fun uu____2400 -> None) (fun uu____2401 -> None) k_global_def)))


let try_lookup_definition : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term Prims.option = (fun env lid -> (

let k_global_def = (fun lid1 uu___166_2420 -> (match (uu___166_2420) with
| ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_let (lbs, uu____2427, uu____2428, uu____2429); FStar_Syntax_Syntax.sigrng = uu____2430}, uu____2431) -> begin
(FStar_Util.find_map (Prims.snd lbs) (fun lb -> (match (lb.FStar_Syntax_Syntax.lbname) with
| FStar_Util.Inr (fv) when (FStar_Syntax_Syntax.fv_eq_lid fv lid1) -> begin
Some (lb.FStar_Syntax_Syntax.lbdef)
end
| uu____2448 -> begin
None
end)))
end
| uu____2453 -> begin
None
end))
in (resolve_in_open_namespaces' env lid (fun uu____2460 -> None) (fun uu____2463 -> None) k_global_def)))


let empty_include_smap : FStar_Ident.lident Prims.list FStar_ST.ref FStar_Util.smap = (new_sigmap ())


let empty_exported_id_smap : exported_id_set FStar_Util.smap = (new_sigmap ())


let try_lookup_lid' : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.term * Prims.bool) Prims.option = (fun any_val exclude_interf env lid -> (

let uu____2490 = (try_lookup_name any_val exclude_interf env lid)
in (match (uu____2490) with
| Some (Term_name (e, mut)) -> begin
Some (((e), (mut)))
end
| uu____2499 -> begin
None
end)))


let try_lookup_lid : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.term * Prims.bool) Prims.option = (fun env l -> (try_lookup_lid' env.iface false env l))


let resolve_to_fully_qualified_name : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.option = (fun env l -> (

let uu____2519 = (try_lookup_lid env l)
in (match (uu____2519) with
| None -> begin
None
end
| Some (e, uu____2527) -> begin
(

let uu____2530 = (

let uu____2531 = (FStar_Syntax_Subst.compress e)
in uu____2531.FStar_Syntax_Syntax.n)
in (match (uu____2530) with
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
Some (fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
end
| uu____2540 -> begin
None
end))
end)))


let try_lookup_lid_no_resolve : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.term * Prims.bool) Prims.option = (fun env l -> (

let env' = (

let uu___183_2551 = env
in {curmodule = uu___183_2551.curmodule; curmonad = uu___183_2551.curmonad; modules = uu___183_2551.modules; scope_mods = []; exported_ids = empty_exported_id_smap; trans_exported_ids = uu___183_2551.trans_exported_ids; includes = empty_include_smap; sigaccum = uu___183_2551.sigaccum; sigmap = uu___183_2551.sigmap; iface = uu___183_2551.iface; admitted_iface = uu___183_2551.admitted_iface; expect_typ = uu___183_2551.expect_typ; docs = uu___183_2551.docs; remaining_iface_decls = uu___183_2551.remaining_iface_decls; syntax_only = uu___183_2551.syntax_only})
in (try_lookup_lid env' l)))


let try_lookup_doc : env  ->  FStar_Ident.lid  ->  FStar_Parser_AST.fsdoc Prims.option = (fun env l -> (FStar_Util.smap_try_find env.docs l.FStar_Ident.str))


let try_lookup_datacon : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.fv Prims.option = (fun env lid -> (

let k_global_def = (fun lid1 uu___168_2575 -> (match (uu___168_2575) with
| ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_declare_typ (uu____2579, uu____2580, uu____2581, quals); FStar_Syntax_Syntax.sigrng = uu____2583}, uu____2584) -> begin
(

let uu____2587 = (FStar_All.pipe_right quals (FStar_Util.for_some (fun uu___167_2589 -> (match (uu___167_2589) with
| FStar_Syntax_Syntax.Assumption -> begin
true
end
| uu____2590 -> begin
false
end))))
in (match (uu____2587) with
| true -> begin
(

let uu____2592 = (FStar_Syntax_Syntax.lid_as_fv lid1 FStar_Syntax_Syntax.Delta_constant None)
in Some (uu____2592))
end
| uu____2593 -> begin
None
end))
end
| ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_datacon (uu____2594); FStar_Syntax_Syntax.sigrng = uu____2595}, uu____2596) -> begin
(

let uu____2606 = (FStar_Syntax_Syntax.lid_as_fv lid1 FStar_Syntax_Syntax.Delta_constant (Some (FStar_Syntax_Syntax.Data_ctor)))
in Some (uu____2606))
end
| uu____2607 -> begin
None
end))
in (resolve_in_open_namespaces' env lid (fun uu____2610 -> None) (fun uu____2611 -> None) k_global_def)))


let find_all_datacons : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.list Prims.option = (fun env lid -> (

let k_global_def = (fun lid1 uu___169_2630 -> (match (uu___169_2630) with
| ({FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_inductive_typ (uu____2635, uu____2636, uu____2637, uu____2638, uu____2639, datas, uu____2641); FStar_Syntax_Syntax.sigrng = uu____2642}, uu____2643) -> begin
Some (datas)
end
| uu____2651 -> begin
None
end))
in (resolve_in_open_namespaces' env lid (fun uu____2656 -> None) (fun uu____2658 -> None) k_global_def)))


let record_cache_aux_with_filter : (((Prims.unit  ->  Prims.unit) * (Prims.unit  ->  Prims.unit) * (Prims.unit  ->  record_or_dc Prims.list) * (record_or_dc  ->  Prims.unit) * (Prims.unit  ->  Prims.unit)) * (Prims.unit  ->  Prims.unit)) = (

let record_cache = (FStar_Util.mk_ref (([])::[]))
in (

let push1 = (fun uu____2692 -> (

let uu____2693 = (

let uu____2696 = (

let uu____2698 = (FStar_ST.read record_cache)
in (FStar_List.hd uu____2698))
in (

let uu____2706 = (FStar_ST.read record_cache)
in (uu____2696)::uu____2706))
in (FStar_ST.write record_cache uu____2693)))
in (

let pop1 = (fun uu____2721 -> (

let uu____2722 = (

let uu____2725 = (FStar_ST.read record_cache)
in (FStar_List.tl uu____2725))
in (FStar_ST.write record_cache uu____2722)))
in (

let peek = (fun uu____2741 -> (

let uu____2742 = (FStar_ST.read record_cache)
in (FStar_List.hd uu____2742)))
in (

let insert = (fun r -> (

let uu____2754 = (

let uu____2757 = (

let uu____2759 = (peek ())
in (r)::uu____2759)
in (

let uu____2761 = (

let uu____2764 = (FStar_ST.read record_cache)
in (FStar_List.tl uu____2764))
in (uu____2757)::uu____2761))
in (FStar_ST.write record_cache uu____2754)))
in (

let commit1 = (fun uu____2780 -> (

let uu____2781 = (FStar_ST.read record_cache)
in (match (uu____2781) with
| (hd1)::(uu____2789)::tl1 -> begin
(FStar_ST.write record_cache ((hd1)::tl1))
end
| uu____2802 -> begin
(failwith "Impossible")
end)))
in (

let filter1 = (fun uu____2808 -> (

let rc = (peek ())
in ((pop1 ());
(match (()) with
| () -> begin
(

let filtered = (FStar_List.filter (fun r -> (not (r.is_private_or_abstract))) rc)
in (

let uu____2815 = (

let uu____2818 = (FStar_ST.read record_cache)
in (filtered)::uu____2818)
in (FStar_ST.write record_cache uu____2815)))
end);
)))
in (

let aux = ((push1), (pop1), (peek), (insert), (commit1))
in ((aux), (filter1))))))))))


let record_cache_aux : ((Prims.unit  ->  Prims.unit) * (Prims.unit  ->  Prims.unit) * (Prims.unit  ->  record_or_dc Prims.list) * (record_or_dc  ->  Prims.unit) * (Prims.unit  ->  Prims.unit)) = (

let uu____2892 = record_cache_aux_with_filter
in (match (uu____2892) with
| (aux, uu____2930) -> begin
aux
end))


let filter_record_cache : Prims.unit  ->  Prims.unit = (

let uu____2969 = record_cache_aux_with_filter
in (match (uu____2969) with
| (uu____2992, filter1) -> begin
filter1
end))


let push_record_cache : Prims.unit  ->  Prims.unit = (

let uu____3032 = record_cache_aux
in (match (uu____3032) with
| (push1, uu____3052, uu____3053, uu____3054, uu____3055) -> begin
push1
end))


let pop_record_cache : Prims.unit  ->  Prims.unit = (

let uu____3080 = record_cache_aux
in (match (uu____3080) with
| (uu____3099, pop1, uu____3101, uu____3102, uu____3103) -> begin
pop1
end))


let peek_record_cache : Prims.unit  ->  record_or_dc Prims.list = (

let uu____3129 = record_cache_aux
in (match (uu____3129) with
| (uu____3149, uu____3150, peek, uu____3152, uu____3153) -> begin
peek
end))


let insert_record_cache : record_or_dc  ->  Prims.unit = (

let uu____3178 = record_cache_aux
in (match (uu____3178) with
| (uu____3197, uu____3198, uu____3199, insert, uu____3201) -> begin
insert
end))


let commit_record_cache : Prims.unit  ->  Prims.unit = (

let uu____3226 = record_cache_aux
in (match (uu____3226) with
| (uu____3245, uu____3246, uu____3247, uu____3248, commit1) -> begin
commit1
end))


let extract_record : env  ->  scope_mod Prims.list FStar_ST.ref  ->  FStar_Syntax_Syntax.sigelt  ->  Prims.unit = (fun e new_globs se -> (match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_bundle (sigs, uu____3288, uu____3289) -> begin
(

let is_rec = (FStar_Util.for_some (fun uu___170_3300 -> (match (uu___170_3300) with
| (FStar_Syntax_Syntax.RecordType (_)) | (FStar_Syntax_Syntax.RecordConstructor (_)) -> begin
true
end
| uu____3303 -> begin
false
end)))
in (

let find_dc = (fun dc -> (FStar_All.pipe_right sigs (FStar_Util.find_opt (fun uu___171_3311 -> (match (uu___171_3311) with
| {FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_datacon (lid, uu____3313, uu____3314, uu____3315, uu____3316, uu____3317, uu____3318); FStar_Syntax_Syntax.sigrng = uu____3319} -> begin
(FStar_Ident.lid_equals dc lid)
end
| uu____3324 -> begin
false
end)))))
in (FStar_All.pipe_right sigs (FStar_List.iter (fun uu___172_3326 -> (match (uu___172_3326) with
| {FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_inductive_typ (typename, univs, parms, uu____3330, uu____3331, (dc)::[], tags); FStar_Syntax_Syntax.sigrng = uu____3334} -> begin
(

let uu____3340 = (

let uu____3341 = (find_dc dc)
in (FStar_All.pipe_left FStar_Util.must uu____3341))
in (match (uu____3340) with
| {FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_datacon (constrname, uu____3345, t, uu____3347, uu____3348, uu____3349, uu____3350); FStar_Syntax_Syntax.sigrng = uu____3351} -> begin
(

let uu____3356 = (FStar_Syntax_Util.arrow_formals t)
in (match (uu____3356) with
| (formals, uu____3365) -> begin
(

let is_rec1 = (is_rec tags)
in (

let formals' = (FStar_All.pipe_right formals (FStar_List.collect (fun uu____3391 -> (match (uu____3391) with
| (x, q) -> begin
(

let uu____3399 = ((FStar_Syntax_Syntax.is_null_bv x) || (is_rec1 && (FStar_Syntax_Syntax.is_implicit q)))
in (match (uu____3399) with
| true -> begin
[]
end
| uu____3405 -> begin
(((x), (q)))::[]
end))
end))))
in (

let fields' = (FStar_All.pipe_right formals' (FStar_List.map (fun uu____3430 -> (match (uu____3430) with
| (x, q) -> begin
(

let uu____3439 = (match (is_rec1) with
| true -> begin
(FStar_Syntax_Util.unmangle_field_name x.FStar_Syntax_Syntax.ppname)
end
| uu____3440 -> begin
x.FStar_Syntax_Syntax.ppname
end)
in ((uu____3439), (x.FStar_Syntax_Syntax.sort)))
end))))
in (

let fields = fields'
in (

let record = {typename = typename; constrname = constrname.FStar_Ident.ident; parms = parms; fields = fields; is_private_or_abstract = ((FStar_List.contains FStar_Syntax_Syntax.Private tags) || (FStar_List.contains FStar_Syntax_Syntax.Abstract tags)); is_record = is_rec1}
in ((

let uu____3451 = (

let uu____3453 = (FStar_ST.read new_globs)
in (Record_or_dc (record))::uu____3453)
in (FStar_ST.write new_globs uu____3451));
(match (()) with
| () -> begin
((

let add_field = (fun uu____3469 -> (match (uu____3469) with
| (id, uu____3475) -> begin
(

let modul = (

let uu____3481 = (FStar_Ident.lid_of_ids constrname.FStar_Ident.ns)
in uu____3481.FStar_Ident.str)
in (

let uu____3482 = (get_exported_id_set e modul)
in (match (uu____3482) with
| Some (my_ex) -> begin
(

let my_exported_ids = (my_ex Exported_id_field)
in ((

let uu____3498 = (

let uu____3499 = (FStar_ST.read my_exported_ids)
in (FStar_Util.set_add id.FStar_Ident.idText uu____3499))
in (FStar_ST.write my_exported_ids uu____3498));
(match (()) with
| () -> begin
(

let projname = (

let uu____3506 = (

let uu____3507 = (FStar_Syntax_Util.mk_field_projector_name_from_ident constrname id)
in uu____3507.FStar_Ident.ident)
in uu____3506.FStar_Ident.idText)
in (

let uu____3509 = (

let uu____3510 = (FStar_ST.read my_exported_ids)
in (FStar_Util.set_add projname uu____3510))
in (FStar_ST.write my_exported_ids uu____3509)))
end);
))
end
| None -> begin
()
end)))
end))
in (FStar_List.iter add_field fields'));
(match (()) with
| () -> begin
(insert_record_cache record)
end);
)
end);
))))))
end))
end
| uu____3523 -> begin
()
end))
end
| uu____3524 -> begin
()
end))))))
end
| uu____3525 -> begin
()
end))


let try_lookup_record_or_dc_by_field_name : env  ->  FStar_Ident.lident  ->  record_or_dc Prims.option = (fun env fieldname -> (

let find_in_cache = (fun fieldname1 -> (

let uu____3538 = ((fieldname1.FStar_Ident.ns), (fieldname1.FStar_Ident.ident))
in (match (uu____3538) with
| (ns, id) -> begin
(

let uu____3548 = (peek_record_cache ())
in (FStar_Util.find_map uu____3548 (fun record -> (

let uu____3551 = (find_in_record ns id record (fun r -> Cont_ok (r)))
in (option_of_cont (fun uu____3554 -> None) uu____3551)))))
end)))
in (resolve_in_open_namespaces'' env fieldname Exported_id_field (fun uu____3555 -> Cont_ignore) (fun uu____3556 -> Cont_ignore) (fun r -> Cont_ok (r)) (fun fn -> (

let uu____3559 = (find_in_cache fn)
in (cont_of_option Cont_ignore uu____3559))) (fun k uu____3562 -> k))))


let try_lookup_record_by_field_name : env  ->  FStar_Ident.lident  ->  record_or_dc Prims.option = (fun env fieldname -> (

let uu____3571 = (try_lookup_record_or_dc_by_field_name env fieldname)
in (match (uu____3571) with
| Some (r) when r.is_record -> begin
Some (r)
end
| uu____3575 -> begin
None
end)))


let belongs_to_record : env  ->  FStar_Ident.lident  ->  record_or_dc  ->  Prims.bool = (fun env lid record -> (

let uu____3586 = (try_lookup_record_by_field_name env lid)
in (match (uu____3586) with
| Some (record') when (

let uu____3589 = (

let uu____3590 = (FStar_Ident.path_of_ns record.typename.FStar_Ident.ns)
in (FStar_Ident.text_of_path uu____3590))
in (

let uu____3592 = (

let uu____3593 = (FStar_Ident.path_of_ns record'.typename.FStar_Ident.ns)
in (FStar_Ident.text_of_path uu____3593))
in (uu____3589 = uu____3592))) -> begin
(

let uu____3595 = (find_in_record record.typename.FStar_Ident.ns lid.FStar_Ident.ident record (fun uu____3597 -> Cont_ok (())))
in (match (uu____3595) with
| Cont_ok (uu____3598) -> begin
true
end
| uu____3599 -> begin
false
end))
end
| uu____3601 -> begin
false
end)))


let try_lookup_dc_by_field_name : env  ->  FStar_Ident.lident  ->  (FStar_Ident.lident * Prims.bool) Prims.option = (fun env fieldname -> (

let uu____3612 = (try_lookup_record_or_dc_by_field_name env fieldname)
in (match (uu____3612) with
| Some (r) -> begin
(

let uu____3618 = (

let uu____3621 = (

let uu____3622 = (FStar_Ident.lid_of_ids (FStar_List.append r.typename.FStar_Ident.ns ((r.constrname)::[])))
in (FStar_Ident.set_lid_range uu____3622 (FStar_Ident.range_of_lid fieldname)))
in ((uu____3621), (r.is_record)))
in Some (uu____3618))
end
| uu____3625 -> begin
None
end)))


let string_set_ref_new : Prims.unit  ->  Prims.string FStar_Util.set FStar_ST.ref = (fun uu____3634 -> (

let uu____3635 = (FStar_Util.new_set FStar_Util.compare FStar_Util.hashcode)
in (FStar_Util.mk_ref uu____3635)))


let exported_id_set_new : Prims.unit  ->  exported_id_kind  ->  Prims.string FStar_Util.set FStar_ST.ref = (fun uu____3646 -> (

let term_type_set = (string_set_ref_new ())
in (

let field_set = (string_set_ref_new ())
in (fun uu___173_3655 -> (match (uu___173_3655) with
| Exported_id_term_type -> begin
term_type_set
end
| Exported_id_field -> begin
field_set
end)))))


let unique : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  Prims.bool = (fun any_val exclude_if env lid -> (

let filter_scope_mods = (fun uu___174_3675 -> (match (uu___174_3675) with
| Rec_binding (uu____3676) -> begin
true
end
| uu____3677 -> begin
false
end))
in (

let this_env = (

let uu___184_3679 = env
in (

let uu____3680 = (FStar_List.filter filter_scope_mods env.scope_mods)
in {curmodule = uu___184_3679.curmodule; curmonad = uu___184_3679.curmonad; modules = uu___184_3679.modules; scope_mods = uu____3680; exported_ids = empty_exported_id_smap; trans_exported_ids = uu___184_3679.trans_exported_ids; includes = empty_include_smap; sigaccum = uu___184_3679.sigaccum; sigmap = uu___184_3679.sigmap; iface = uu___184_3679.iface; admitted_iface = uu___184_3679.admitted_iface; expect_typ = uu___184_3679.expect_typ; docs = uu___184_3679.docs; remaining_iface_decls = uu___184_3679.remaining_iface_decls; syntax_only = uu___184_3679.syntax_only}))
in (

let uu____3682 = (try_lookup_lid' any_val exclude_if this_env lid)
in (match (uu____3682) with
| None -> begin
true
end
| Some (uu____3688) -> begin
false
end)))))


let push_scope_mod : env  ->  scope_mod  ->  env = (fun env scope_mod -> (

let uu___185_3699 = env
in {curmodule = uu___185_3699.curmodule; curmonad = uu___185_3699.curmonad; modules = uu___185_3699.modules; scope_mods = (scope_mod)::env.scope_mods; exported_ids = uu___185_3699.exported_ids; trans_exported_ids = uu___185_3699.trans_exported_ids; includes = uu___185_3699.includes; sigaccum = uu___185_3699.sigaccum; sigmap = uu___185_3699.sigmap; iface = uu___185_3699.iface; admitted_iface = uu___185_3699.admitted_iface; expect_typ = uu___185_3699.expect_typ; docs = uu___185_3699.docs; remaining_iface_decls = uu___185_3699.remaining_iface_decls; syntax_only = uu___185_3699.syntax_only}))


let push_bv' : env  ->  FStar_Ident.ident  ->  Prims.bool  ->  (env * FStar_Syntax_Syntax.bv) = (fun env x is_mutable -> (

let bv = (FStar_Syntax_Syntax.gen_bv x.FStar_Ident.idText (Some (x.FStar_Ident.idRange)) FStar_Syntax_Syntax.tun)
in (((push_scope_mod env (Local_binding (((x), (bv), (is_mutable)))))), (bv))))


let push_bv_mutable : env  ->  FStar_Ident.ident  ->  (env * FStar_Syntax_Syntax.bv) = (fun env x -> (push_bv' env x true))


let push_bv : env  ->  FStar_Ident.ident  ->  (env * FStar_Syntax_Syntax.bv) = (fun env x -> (push_bv' env x false))


let push_top_level_rec_binding : env  ->  FStar_Ident.ident  ->  FStar_Syntax_Syntax.delta_depth  ->  env = (fun env x dd -> (

let l = (qualify env x)
in (

let uu____3738 = ((unique false true env l) || (FStar_Options.interactive ()))
in (match (uu____3738) with
| true -> begin
(push_scope_mod env (Rec_binding (((x), (l), (dd)))))
end
| uu____3739 -> begin
(Prims.raise (FStar_Errors.Error ((((Prims.strcat "Duplicate top-level names " l.FStar_Ident.str)), ((FStar_Ident.range_of_lid l))))))
end))))


let push_sigelt : env  ->  FStar_Syntax_Syntax.sigelt  ->  env = (fun env s -> (

let err1 = (fun l -> (

let sopt = (FStar_Util.smap_try_find (sigmap env) l.FStar_Ident.str)
in (

let r = (match (sopt) with
| Some (se, uu____3758) -> begin
(

let uu____3761 = (FStar_Util.find_opt (FStar_Ident.lid_equals l) (FStar_Syntax_Util.lids_of_sigelt se))
in (match (uu____3761) with
| Some (l1) -> begin
(FStar_All.pipe_left FStar_Range.string_of_range (FStar_Ident.range_of_lid l1))
end
| None -> begin
"<unknown>"
end))
end
| None -> begin
"<unknown>"
end)
in (

let uu____3766 = (

let uu____3767 = (

let uu____3770 = (FStar_Util.format2 "Duplicate top-level names [%s]; previously declared at %s" (FStar_Ident.text_of_lid l) r)
in ((uu____3770), ((FStar_Ident.range_of_lid l))))
in FStar_Errors.Error (uu____3767))
in (Prims.raise uu____3766)))))
in (

let globals = (FStar_Util.mk_ref env.scope_mods)
in (

let env1 = (

let uu____3777 = (match (s.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_let (uu____3782) -> begin
((false), (true))
end
| FStar_Syntax_Syntax.Sig_bundle (uu____3790) -> begin
((true), (true))
end
| uu____3797 -> begin
((false), (false))
end)
in (match (uu____3777) with
| (any_val, exclude_if) -> begin
(

let lids = (FStar_Syntax_Util.lids_of_sigelt s)
in (

let uu____3802 = (FStar_Util.find_map lids (fun l -> (

let uu____3805 = (

let uu____3806 = (unique any_val exclude_if env l)
in (not (uu____3806)))
in (match (uu____3805) with
| true -> begin
Some (l)
end
| uu____3808 -> begin
None
end))))
in (match (uu____3802) with
| Some (l) when (

let uu____3810 = (FStar_Options.interactive ())
in (not (uu____3810))) -> begin
(err1 l)
end
| uu____3811 -> begin
((extract_record env globals s);
(

let uu___186_3816 = env
in {curmodule = uu___186_3816.curmodule; curmonad = uu___186_3816.curmonad; modules = uu___186_3816.modules; scope_mods = uu___186_3816.scope_mods; exported_ids = uu___186_3816.exported_ids; trans_exported_ids = uu___186_3816.trans_exported_ids; includes = uu___186_3816.includes; sigaccum = (s)::env.sigaccum; sigmap = uu___186_3816.sigmap; iface = uu___186_3816.iface; admitted_iface = uu___186_3816.admitted_iface; expect_typ = uu___186_3816.expect_typ; docs = uu___186_3816.docs; remaining_iface_decls = uu___186_3816.remaining_iface_decls; syntax_only = uu___186_3816.syntax_only});
)
end)))
end))
in (

let env2 = (

let uu___187_3818 = env1
in (

let uu____3819 = (FStar_ST.read globals)
in {curmodule = uu___187_3818.curmodule; curmonad = uu___187_3818.curmonad; modules = uu___187_3818.modules; scope_mods = uu____3819; exported_ids = uu___187_3818.exported_ids; trans_exported_ids = uu___187_3818.trans_exported_ids; includes = uu___187_3818.includes; sigaccum = uu___187_3818.sigaccum; sigmap = uu___187_3818.sigmap; iface = uu___187_3818.iface; admitted_iface = uu___187_3818.admitted_iface; expect_typ = uu___187_3818.expect_typ; docs = uu___187_3818.docs; remaining_iface_decls = uu___187_3818.remaining_iface_decls; syntax_only = uu___187_3818.syntax_only}))
in (

let uu____3824 = (match (s.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_bundle (ses, uu____3838, uu____3839) -> begin
(

let uu____3846 = (FStar_List.map (fun se -> (((FStar_Syntax_Util.lids_of_sigelt se)), (se))) ses)
in ((env2), (uu____3846)))
end
| uu____3860 -> begin
((env2), (((((FStar_Syntax_Util.lids_of_sigelt s)), (s)))::[]))
end)
in (match (uu____3824) with
| (env3, lss) -> begin
((FStar_All.pipe_right lss (FStar_List.iter (fun uu____3890 -> (match (uu____3890) with
| (lids, se) -> begin
(FStar_All.pipe_right lids (FStar_List.iter (fun lid -> ((

let uu____3901 = (

let uu____3903 = (FStar_ST.read globals)
in (Top_level_def (lid.FStar_Ident.ident))::uu____3903)
in (FStar_ST.write globals uu____3901));
(match (()) with
| () -> begin
(

let modul = (

let uu____3912 = (FStar_Ident.lid_of_ids lid.FStar_Ident.ns)
in uu____3912.FStar_Ident.str)
in ((

let uu____3914 = (get_exported_id_set env3 modul)
in (match (uu____3914) with
| Some (f) -> begin
(

let my_exported_ids = (f Exported_id_term_type)
in (

let uu____3929 = (

let uu____3930 = (FStar_ST.read my_exported_ids)
in (FStar_Util.set_add lid.FStar_Ident.ident.FStar_Ident.idText uu____3930))
in (FStar_ST.write my_exported_ids uu____3929)))
end
| None -> begin
()
end));
(match (()) with
| () -> begin
(FStar_Util.smap_add (sigmap env3) lid.FStar_Ident.str ((se), ((env3.iface && (not (env3.admitted_iface))))))
end);
))
end);
))))
end))));
(

let env4 = (

let uu___188_3942 = env3
in (

let uu____3943 = (FStar_ST.read globals)
in {curmodule = uu___188_3942.curmodule; curmonad = uu___188_3942.curmonad; modules = uu___188_3942.modules; scope_mods = uu____3943; exported_ids = uu___188_3942.exported_ids; trans_exported_ids = uu___188_3942.trans_exported_ids; includes = uu___188_3942.includes; sigaccum = uu___188_3942.sigaccum; sigmap = uu___188_3942.sigmap; iface = uu___188_3942.iface; admitted_iface = uu___188_3942.admitted_iface; expect_typ = uu___188_3942.expect_typ; docs = uu___188_3942.docs; remaining_iface_decls = uu___188_3942.remaining_iface_decls; syntax_only = uu___188_3942.syntax_only}))
in env4);
)
end)))))))


let push_namespace : env  ->  FStar_Ident.lident  ->  env = (fun env ns -> (

let uu____3954 = (

let uu____3957 = (resolve_module_name env ns false)
in (match (uu____3957) with
| None -> begin
(

let modules = env.modules
in (

let uu____3965 = (FStar_All.pipe_right modules (FStar_Util.for_some (fun uu____3971 -> (match (uu____3971) with
| (m, uu____3975) -> begin
(FStar_Util.starts_with (Prims.strcat (FStar_Ident.text_of_lid m) ".") (Prims.strcat (FStar_Ident.text_of_lid ns) "."))
end))))
in (match (uu____3965) with
| true -> begin
((ns), (Open_namespace))
end
| uu____3978 -> begin
(

let uu____3979 = (

let uu____3980 = (

let uu____3983 = (FStar_Util.format1 "Namespace %s cannot be found" (FStar_Ident.text_of_lid ns))
in ((uu____3983), ((FStar_Ident.range_of_lid ns))))
in FStar_Errors.Error (uu____3980))
in (Prims.raise uu____3979))
end)))
end
| Some (ns') -> begin
((fail_if_curmodule env ns ns');
((ns'), (Open_module));
)
end))
in (match (uu____3954) with
| (ns', kd) -> begin
(push_scope_mod env (Open_module_or_namespace (((ns'), (kd)))))
end)))


let push_include : env  ->  FStar_Ident.lident  ->  env = (fun env ns -> (

let ns0 = ns
in (

let uu____3997 = (resolve_module_name env ns false)
in (match (uu____3997) with
| Some (ns1) -> begin
((fail_if_curmodule env ns0 ns1);
(

let env1 = (push_scope_mod env (Open_module_or_namespace (((ns1), (Open_module)))))
in (

let curmod = (

let uu____4003 = (current_module env1)
in uu____4003.FStar_Ident.str)
in ((

let uu____4005 = (FStar_Util.smap_try_find env1.includes curmod)
in (match (uu____4005) with
| None -> begin
()
end
| Some (incl) -> begin
(

let uu____4018 = (

let uu____4020 = (FStar_ST.read incl)
in (ns1)::uu____4020)
in (FStar_ST.write incl uu____4018))
end));
(match (()) with
| () -> begin
(

let uu____4028 = (get_trans_exported_id_set env1 ns1.FStar_Ident.str)
in (match (uu____4028) with
| Some (ns_trans_exports) -> begin
((

let uu____4041 = (

let uu____4052 = (get_exported_id_set env1 curmod)
in (

let uu____4057 = (get_trans_exported_id_set env1 curmod)
in ((uu____4052), (uu____4057))))
in (match (uu____4041) with
| (Some (cur_exports), Some (cur_trans_exports)) -> begin
(

let update_exports = (fun k -> (

let ns_ex = (

let uu____4097 = (ns_trans_exports k)
in (FStar_ST.read uu____4097))
in (

let ex = (cur_exports k)
in ((

let uu____4106 = (

let uu____4107 = (FStar_ST.read ex)
in (FStar_Util.set_difference uu____4107 ns_ex))
in (FStar_ST.write ex uu____4106));
(match (()) with
| () -> begin
(

let trans_ex = (cur_trans_exports k)
in (

let uu____4117 = (

let uu____4118 = (FStar_ST.read trans_ex)
in (FStar_Util.set_union uu____4118 ns_ex))
in (FStar_ST.write trans_ex uu____4117)))
end);
))))
in (FStar_List.iter update_exports all_exported_id_kinds))
end
| uu____4124 -> begin
()
end));
(match (()) with
| () -> begin
env1
end);
)
end
| None -> begin
(

let uu____4138 = (

let uu____4139 = (

let uu____4142 = (FStar_Util.format1 "include: Module %s was not prepared" ns1.FStar_Ident.str)
in ((uu____4142), ((FStar_Ident.range_of_lid ns1))))
in FStar_Errors.Error (uu____4139))
in (Prims.raise uu____4138))
end))
end);
)));
)
end
| uu____4143 -> begin
(

let uu____4145 = (

let uu____4146 = (

let uu____4149 = (FStar_Util.format1 "include: Module %s cannot be found" ns.FStar_Ident.str)
in ((uu____4149), ((FStar_Ident.range_of_lid ns))))
in FStar_Errors.Error (uu____4146))
in (Prims.raise uu____4145))
end))))


let push_module_abbrev : env  ->  FStar_Ident.ident  ->  FStar_Ident.lident  ->  env = (fun env x l -> (

let uu____4159 = (module_is_defined env l)
in (match (uu____4159) with
| true -> begin
((fail_if_curmodule env l l);
(push_scope_mod env (Module_abbrev (((x), (l)))));
)
end
| uu____4161 -> begin
(

let uu____4162 = (

let uu____4163 = (

let uu____4166 = (FStar_Util.format1 "Module %s cannot be found" (FStar_Ident.text_of_lid l))
in ((uu____4166), ((FStar_Ident.range_of_lid l))))
in FStar_Errors.Error (uu____4163))
in (Prims.raise uu____4162))
end)))


let push_doc : env  ->  FStar_Ident.lident  ->  FStar_Parser_AST.fsdoc Prims.option  ->  env = (fun env l doc_opt -> (match (doc_opt) with
| None -> begin
env
end
| Some (doc1) -> begin
((

let uu____4180 = (FStar_Util.smap_try_find env.docs l.FStar_Ident.str)
in (match (uu____4180) with
| None -> begin
()
end
| Some (old_doc) -> begin
(

let uu____4183 = (

let uu____4184 = (FStar_Ident.string_of_lid l)
in (

let uu____4185 = (FStar_Parser_AST.string_of_fsdoc old_doc)
in (

let uu____4186 = (FStar_Parser_AST.string_of_fsdoc doc1)
in (FStar_Util.format3 "Overwriting doc of %s; old doc was [%s]; new doc are [%s]" uu____4184 uu____4185 uu____4186))))
in (FStar_Errors.warn (FStar_Ident.range_of_lid l) uu____4183))
end));
(FStar_Util.smap_add env.docs l.FStar_Ident.str doc1);
env;
)
end))


let check_admits : env  ->  Prims.unit = (fun env -> (FStar_All.pipe_right env.sigaccum (FStar_List.iter (fun se -> (match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_declare_typ (l, u, t, quals) -> begin
(

let uu____4198 = (try_lookup_lid env l)
in (match (uu____4198) with
| None -> begin
((

let uu____4205 = (

let uu____4206 = (FStar_Options.interactive ())
in (not (uu____4206)))
in (match (uu____4205) with
| true -> begin
(

let uu____4207 = (

let uu____4208 = (FStar_Range.string_of_range (FStar_Ident.range_of_lid l))
in (

let uu____4209 = (FStar_Syntax_Print.lid_to_string l)
in (FStar_Util.format2 "%s: Warning: Admitting %s without a definition\n" uu____4208 uu____4209)))
in (FStar_Util.print_string uu____4207))
end
| uu____4210 -> begin
()
end));
(FStar_Util.smap_add (sigmap env) l.FStar_Ident.str (((

let uu___189_4213 = se
in {FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_declare_typ (((l), (u), (t), ((FStar_Syntax_Syntax.Assumption)::quals))); FStar_Syntax_Syntax.sigrng = uu___189_4213.FStar_Syntax_Syntax.sigrng})), (false)));
)
end
| Some (uu____4215) -> begin
()
end))
end
| uu____4220 -> begin
()
end)))))


let finish : env  ->  FStar_Syntax_Syntax.modul  ->  env = (fun env modul -> ((FStar_All.pipe_right modul.FStar_Syntax_Syntax.declarations (FStar_List.iter (fun se -> (match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_bundle (ses, quals, uu____4231) -> begin
(match (((FStar_List.contains FStar_Syntax_Syntax.Private quals) || (FStar_List.contains FStar_Syntax_Syntax.Abstract quals))) with
| true -> begin
(FStar_All.pipe_right ses (FStar_List.iter (fun se1 -> (match (se1.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_datacon (lid, uu____4241, uu____4242, uu____4243, uu____4244, uu____4245, uu____4246) -> begin
(FStar_Util.smap_remove (sigmap env) lid.FStar_Ident.str)
end
| uu____4253 -> begin
()
end))))
end
| uu____4254 -> begin
()
end)
end
| FStar_Syntax_Syntax.Sig_declare_typ (lid, uu____4256, uu____4257, quals) -> begin
(match ((FStar_List.contains FStar_Syntax_Syntax.Private quals)) with
| true -> begin
(FStar_Util.smap_remove (sigmap env) lid.FStar_Ident.str)
end
| uu____4263 -> begin
()
end)
end
| FStar_Syntax_Syntax.Sig_let ((uu____4264, lbs), uu____4266, quals, uu____4268) -> begin
((match (((FStar_List.contains FStar_Syntax_Syntax.Private quals) || (FStar_List.contains FStar_Syntax_Syntax.Abstract quals))) with
| true -> begin
(FStar_All.pipe_right lbs (FStar_List.iter (fun lb -> (

let uu____4283 = (

let uu____4284 = (

let uu____4285 = (

let uu____4290 = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in uu____4290.FStar_Syntax_Syntax.fv_name)
in uu____4285.FStar_Syntax_Syntax.v)
in uu____4284.FStar_Ident.str)
in (FStar_Util.smap_remove (sigmap env) uu____4283)))))
end
| uu____4296 -> begin
()
end);
(match (((FStar_List.contains FStar_Syntax_Syntax.Abstract quals) && (not ((FStar_List.contains FStar_Syntax_Syntax.Private quals))))) with
| true -> begin
(FStar_All.pipe_right lbs (FStar_List.iter (fun lb -> (

let lid = (

let uu____4300 = (

let uu____4305 = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in uu____4305.FStar_Syntax_Syntax.fv_name)
in uu____4300.FStar_Syntax_Syntax.v)
in (

let decl = (

let uu___190_4310 = se
in {FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_declare_typ (((lid), (lb.FStar_Syntax_Syntax.lbunivs), (lb.FStar_Syntax_Syntax.lbtyp), ((FStar_Syntax_Syntax.Assumption)::quals))); FStar_Syntax_Syntax.sigrng = uu___190_4310.FStar_Syntax_Syntax.sigrng})
in (FStar_Util.smap_add (sigmap env) lid.FStar_Ident.str ((decl), (false))))))))
end
| uu____4317 -> begin
()
end);
)
end
| uu____4318 -> begin
()
end))));
(

let curmod = (

let uu____4320 = (current_module env)
in uu____4320.FStar_Ident.str)
in ((

let uu____4322 = (

let uu____4333 = (get_exported_id_set env curmod)
in (

let uu____4338 = (get_trans_exported_id_set env curmod)
in ((uu____4333), (uu____4338))))
in (match (uu____4322) with
| (Some (cur_ex), Some (cur_trans_ex)) -> begin
(

let update_exports = (fun eikind -> (

let cur_ex_set = (

let uu____4378 = (cur_ex eikind)
in (FStar_ST.read uu____4378))
in (

let cur_trans_ex_set_ref = (cur_trans_ex eikind)
in (

let uu____4386 = (

let uu____4387 = (FStar_ST.read cur_trans_ex_set_ref)
in (FStar_Util.set_union cur_ex_set uu____4387))
in (FStar_ST.write cur_trans_ex_set_ref uu____4386)))))
in (FStar_List.iter update_exports all_exported_id_kinds))
end
| uu____4393 -> begin
()
end));
(match (()) with
| () -> begin
((filter_record_cache ());
(match (()) with
| () -> begin
(

let uu___191_4405 = env
in {curmodule = None; curmonad = uu___191_4405.curmonad; modules = (((modul.FStar_Syntax_Syntax.name), (modul)))::env.modules; scope_mods = []; exported_ids = uu___191_4405.exported_ids; trans_exported_ids = uu___191_4405.trans_exported_ids; includes = uu___191_4405.includes; sigaccum = []; sigmap = uu___191_4405.sigmap; iface = uu___191_4405.iface; admitted_iface = uu___191_4405.admitted_iface; expect_typ = uu___191_4405.expect_typ; docs = uu___191_4405.docs; remaining_iface_decls = uu___191_4405.remaining_iface_decls; syntax_only = uu___191_4405.syntax_only})
end);
)
end);
));
))


let stack : env Prims.list FStar_ST.ref = (FStar_Util.mk_ref [])


let push : env  ->  env = (fun env -> ((push_record_cache ());
(

let uu____4418 = (

let uu____4420 = (FStar_ST.read stack)
in (env)::uu____4420)
in (FStar_ST.write stack uu____4418));
(

let uu___192_4428 = env
in (

let uu____4429 = (FStar_Util.smap_copy (sigmap env))
in (

let uu____4435 = (FStar_Util.smap_copy env.docs)
in {curmodule = uu___192_4428.curmodule; curmonad = uu___192_4428.curmonad; modules = uu___192_4428.modules; scope_mods = uu___192_4428.scope_mods; exported_ids = uu___192_4428.exported_ids; trans_exported_ids = uu___192_4428.trans_exported_ids; includes = uu___192_4428.includes; sigaccum = uu___192_4428.sigaccum; sigmap = uu____4429; iface = uu___192_4428.iface; admitted_iface = uu___192_4428.admitted_iface; expect_typ = uu___192_4428.expect_typ; docs = uu____4435; remaining_iface_decls = uu___192_4428.remaining_iface_decls; syntax_only = uu___192_4428.syntax_only})));
))


let pop : Prims.unit  ->  env = (fun uu____4439 -> (

let uu____4440 = (FStar_ST.read stack)
in (match (uu____4440) with
| (env)::tl1 -> begin
((pop_record_cache ());
(FStar_ST.write stack tl1);
env;
)
end
| uu____4453 -> begin
(failwith "Impossible: Too many pops")
end)))


let commit_mark : env  ->  env = (fun env -> ((commit_record_cache ());
(

let uu____4459 = (FStar_ST.read stack)
in (match (uu____4459) with
| (uu____4464)::tl1 -> begin
((FStar_ST.write stack tl1);
env;
)
end
| uu____4471 -> begin
(failwith "Impossible: Too many pops")
end));
))


let mark : env  ->  env = (fun x -> (push x))


let reset_mark : Prims.unit  ->  env = (fun uu____4478 -> (pop ()))


let export_interface : FStar_Ident.lident  ->  env  ->  env = (fun m env -> (

let sigelt_in_m = (fun se -> (match ((FStar_Syntax_Util.lids_of_sigelt se)) with
| (l)::uu____4490 -> begin
(l.FStar_Ident.nsstr = m.FStar_Ident.str)
end
| uu____4492 -> begin
false
end))
in (

let sm = (sigmap env)
in (

let env1 = (pop ())
in (

let keys = (FStar_Util.smap_keys sm)
in (

let sm' = (sigmap env1)
in ((FStar_All.pipe_right keys (FStar_List.iter (fun k -> (

let uu____4510 = (FStar_Util.smap_try_find sm' k)
in (match (uu____4510) with
| Some (se, true) when (sigelt_in_m se) -> begin
((FStar_Util.smap_remove sm' k);
(

let se1 = (match (se.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_declare_typ (l, u, t, q) -> begin
(

let uu___193_4529 = se
in {FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_declare_typ (((l), (u), (t), ((FStar_Syntax_Syntax.Assumption)::q))); FStar_Syntax_Syntax.sigrng = uu___193_4529.FStar_Syntax_Syntax.sigrng})
end
| uu____4531 -> begin
se
end)
in (FStar_Util.smap_add sm' k ((se1), (false))));
)
end
| uu____4534 -> begin
()
end)))));
env1;
)))))))


let finish_module_or_interface : env  ->  FStar_Syntax_Syntax.modul  ->  env = (fun env modul -> ((match ((not (modul.FStar_Syntax_Syntax.is_interface))) with
| true -> begin
(check_admits env)
end
| uu____4545 -> begin
()
end);
(finish env modul);
))


let prepare_module_or_interface : Prims.bool  ->  Prims.bool  ->  env  ->  FStar_Ident.lident  ->  (env * Prims.bool) = (fun intf admitted env mname -> (

let prep = (fun env1 -> (

let open_ns = (match ((FStar_Ident.lid_equals mname FStar_Syntax_Const.prims_lid)) with
| true -> begin
[]
end
| uu____4567 -> begin
(match ((FStar_Util.starts_with "FStar." (FStar_Ident.text_of_lid mname))) with
| true -> begin
(FStar_Syntax_Const.prims_lid)::(FStar_Syntax_Const.fstar_ns_lid)::[]
end
| uu____4569 -> begin
(FStar_Syntax_Const.prims_lid)::(FStar_Syntax_Const.st_lid)::(FStar_Syntax_Const.all_lid)::(FStar_Syntax_Const.fstar_ns_lid)::[]
end)
end)
in (

let open_ns1 = (match (((FStar_List.length mname.FStar_Ident.ns) <> (Prims.parse_int "0"))) with
| true -> begin
(

let ns = (FStar_Ident.lid_of_ids mname.FStar_Ident.ns)
in (ns)::open_ns)
end
| uu____4576 -> begin
open_ns
end)
in ((

let uu____4578 = (exported_id_set_new ())
in (FStar_Util.smap_add env1.exported_ids mname.FStar_Ident.str uu____4578));
(match (()) with
| () -> begin
((

let uu____4583 = (exported_id_set_new ())
in (FStar_Util.smap_add env1.trans_exported_ids mname.FStar_Ident.str uu____4583));
(match (()) with
| () -> begin
((

let uu____4588 = (FStar_Util.mk_ref [])
in (FStar_Util.smap_add env1.includes mname.FStar_Ident.str uu____4588));
(match (()) with
| () -> begin
(

let uu___194_4597 = env1
in (

let uu____4598 = (FStar_List.map (fun lid -> Open_module_or_namespace (((lid), (Open_namespace)))) open_ns1)
in {curmodule = Some (mname); curmonad = uu___194_4597.curmonad; modules = uu___194_4597.modules; scope_mods = uu____4598; exported_ids = uu___194_4597.exported_ids; trans_exported_ids = uu___194_4597.trans_exported_ids; includes = uu___194_4597.includes; sigaccum = uu___194_4597.sigaccum; sigmap = env1.sigmap; iface = intf; admitted_iface = admitted; expect_typ = uu___194_4597.expect_typ; docs = uu___194_4597.docs; remaining_iface_decls = uu___194_4597.remaining_iface_decls; syntax_only = uu___194_4597.syntax_only}))
end);
)
end);
)
end);
))))
in (

let uu____4601 = (FStar_All.pipe_right env.modules (FStar_Util.find_opt (fun uu____4613 -> (match (uu____4613) with
| (l, uu____4617) -> begin
(FStar_Ident.lid_equals l mname)
end))))
in (match (uu____4601) with
| None -> begin
(

let uu____4622 = (prep env)
in ((uu____4622), (false)))
end
| Some (uu____4623, m) -> begin
((

let uu____4628 = ((

let uu____4629 = (FStar_Options.interactive ())
in (not (uu____4629))) && ((not (m.FStar_Syntax_Syntax.is_interface)) || intf))
in (match (uu____4628) with
| true -> begin
(

let uu____4630 = (

let uu____4631 = (

let uu____4634 = (FStar_Util.format1 "Duplicate module or interface name: %s" mname.FStar_Ident.str)
in ((uu____4634), ((FStar_Ident.range_of_lid mname))))
in FStar_Errors.Error (uu____4631))
in (Prims.raise uu____4630))
end
| uu____4635 -> begin
()
end));
(

let uu____4636 = (

let uu____4637 = (push env)
in (prep uu____4637))
in ((uu____4636), (true)));
)
end))))


let enter_monad_scope : env  ->  FStar_Ident.ident  ->  env = (fun env mname -> (match (env.curmonad) with
| Some (mname') -> begin
(Prims.raise (FStar_Errors.Error ((((Prims.strcat "Trying to define monad " (Prims.strcat mname.FStar_Ident.idText (Prims.strcat ", but already in monad scope " mname'.FStar_Ident.idText)))), (mname.FStar_Ident.idRange)))))
end
| None -> begin
(

let uu___195_4645 = env
in {curmodule = uu___195_4645.curmodule; curmonad = Some (mname); modules = uu___195_4645.modules; scope_mods = uu___195_4645.scope_mods; exported_ids = uu___195_4645.exported_ids; trans_exported_ids = uu___195_4645.trans_exported_ids; includes = uu___195_4645.includes; sigaccum = uu___195_4645.sigaccum; sigmap = uu___195_4645.sigmap; iface = uu___195_4645.iface; admitted_iface = uu___195_4645.admitted_iface; expect_typ = uu___195_4645.expect_typ; docs = uu___195_4645.docs; remaining_iface_decls = uu___195_4645.remaining_iface_decls; syntax_only = uu___195_4645.syntax_only})
end))


let fail_or = (fun env lookup lid -> (

let uu____4670 = (lookup lid)
in (match (uu____4670) with
| None -> begin
(

let opened_modules = (FStar_List.map (fun uu____4676 -> (match (uu____4676) with
| (lid1, uu____4680) -> begin
(FStar_Ident.text_of_lid lid1)
end)) env.modules)
in (

let msg = (FStar_Util.format1 "Identifier not found: [%s]" (FStar_Ident.text_of_lid lid))
in (

let msg1 = (match (((FStar_List.length lid.FStar_Ident.ns) = (Prims.parse_int "0"))) with
| true -> begin
msg
end
| uu____4685 -> begin
(

let modul = (

let uu____4687 = (FStar_Ident.lid_of_ids lid.FStar_Ident.ns)
in (FStar_Ident.set_lid_range uu____4687 (FStar_Ident.range_of_lid lid)))
in (

let uu____4688 = (resolve_module_name env modul true)
in (match (uu____4688) with
| None -> begin
(

let opened_modules1 = (FStar_String.concat ", " opened_modules)
in (FStar_Util.format3 "%s\nModule %s does not belong to the list of modules in scope, namely %s" msg modul.FStar_Ident.str opened_modules1))
end
| Some (modul') when (not ((FStar_List.existsb (fun m -> (m = modul'.FStar_Ident.str)) opened_modules))) -> begin
(

let opened_modules1 = (FStar_String.concat ", " opened_modules)
in (FStar_Util.format4 "%s\nModule %s resolved into %s, which does not belong to the list of modules in scope, namely %s" msg modul.FStar_Ident.str modul'.FStar_Ident.str opened_modules1))
end
| Some (modul') -> begin
(FStar_Util.format4 "%s\nModule %s resolved into %s, definition %s not found" msg modul.FStar_Ident.str modul'.FStar_Ident.str lid.FStar_Ident.ident.FStar_Ident.idText)
end)))
end)
in (Prims.raise (FStar_Errors.Error (((msg1), ((FStar_Ident.range_of_lid lid)))))))))
end
| Some (r) -> begin
r
end)))


let fail_or2 = (fun lookup id -> (

let uu____4715 = (lookup id)
in (match (uu____4715) with
| None -> begin
(Prims.raise (FStar_Errors.Error ((((Prims.strcat "Identifier not found [" (Prims.strcat id.FStar_Ident.idText "]"))), (id.FStar_Ident.idRange)))))
end
| Some (r) -> begin
r
end)))




