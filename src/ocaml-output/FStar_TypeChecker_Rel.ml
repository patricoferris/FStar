
open Prims
# 65 "FStar.TypeChecker.Rel.fst"
let new_uvar : FStar_Range.range  ->  FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.typ  ->  (FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.typ) = (fun r binders k -> (
# 66 "FStar.TypeChecker.Rel.fst"
let binders = (FStar_All.pipe_right binders (FStar_List.filter (fun x -> (let _151_8 = (FStar_Syntax_Syntax.is_null_binder x)
in (FStar_All.pipe_right _151_8 Prims.op_Negation)))))
in (
# 67 "FStar.TypeChecker.Rel.fst"
let uv = (FStar_Unionfind.fresh FStar_Syntax_Syntax.Uvar)
in (match (binders) with
| [] -> begin
(
# 70 "FStar.TypeChecker.Rel.fst"
let uv = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_uvar ((uv, k))) (Some (k.FStar_Syntax_Syntax.n)) r)
in (uv, uv))
end
| _69_38 -> begin
(
# 73 "FStar.TypeChecker.Rel.fst"
let args = (FStar_Syntax_Util.args_of_non_null_binders binders)
in (
# 74 "FStar.TypeChecker.Rel.fst"
let k' = (let _151_9 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_Syntax_Util.arrow binders _151_9))
in (
# 75 "FStar.TypeChecker.Rel.fst"
let uv = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_uvar ((uv, k'))) None r)
in (let _151_10 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((uv, args))) (Some (k.FStar_Syntax_Syntax.n)) r)
in (_151_10, uv)))))
end))))

# 82 "FStar.TypeChecker.Rel.fst"
type uvi =
| TERM of ((FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.typ) * FStar_Syntax_Syntax.term)
| UNIV of (FStar_Syntax_Syntax.universe_uvar * FStar_Syntax_Syntax.universe)

# 83 "FStar.TypeChecker.Rel.fst"
let is_TERM = (fun _discr_ -> (match (_discr_) with
| TERM (_) -> begin
true
end
| _ -> begin
false
end))

# 84 "FStar.TypeChecker.Rel.fst"
let is_UNIV = (fun _discr_ -> (match (_discr_) with
| UNIV (_) -> begin
true
end
| _ -> begin
false
end))

# 83 "FStar.TypeChecker.Rel.fst"
let ___TERM____0 : uvi  ->  ((FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.typ) * FStar_Syntax_Syntax.term) = (fun projectee -> (match (projectee) with
| TERM (_69_44) -> begin
_69_44
end))

# 84 "FStar.TypeChecker.Rel.fst"
let ___UNIV____0 : uvi  ->  (FStar_Syntax_Syntax.universe_uvar * FStar_Syntax_Syntax.universe) = (fun projectee -> (match (projectee) with
| UNIV (_69_47) -> begin
_69_47
end))

# 87 "FStar.TypeChecker.Rel.fst"
type worklist =
{attempting : FStar_TypeChecker_Common.probs; wl_deferred : (Prims.int * Prims.string * FStar_TypeChecker_Common.prob) Prims.list; ctr : Prims.int; defer_ok : Prims.bool; smt_ok : Prims.bool; tcenv : FStar_TypeChecker_Env.env}

# 87 "FStar.TypeChecker.Rel.fst"
let is_Mkworklist : worklist  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkworklist"))))

# 97 "FStar.TypeChecker.Rel.fst"
type solution =
| Success of FStar_TypeChecker_Common.deferred
| Failed of (FStar_TypeChecker_Common.prob * Prims.string)

# 98 "FStar.TypeChecker.Rel.fst"
let is_Success = (fun _discr_ -> (match (_discr_) with
| Success (_) -> begin
true
end
| _ -> begin
false
end))

# 99 "FStar.TypeChecker.Rel.fst"
let is_Failed = (fun _discr_ -> (match (_discr_) with
| Failed (_) -> begin
true
end
| _ -> begin
false
end))

# 98 "FStar.TypeChecker.Rel.fst"
let ___Success____0 : solution  ->  FStar_TypeChecker_Common.deferred = (fun projectee -> (match (projectee) with
| Success (_69_57) -> begin
_69_57
end))

# 99 "FStar.TypeChecker.Rel.fst"
let ___Failed____0 : solution  ->  (FStar_TypeChecker_Common.prob * Prims.string) = (fun projectee -> (match (projectee) with
| Failed (_69_60) -> begin
_69_60
end))

# 101 "FStar.TypeChecker.Rel.fst"
type variance =
| COVARIANT
| CONTRAVARIANT
| INVARIANT

# 102 "FStar.TypeChecker.Rel.fst"
let is_COVARIANT = (fun _discr_ -> (match (_discr_) with
| COVARIANT (_) -> begin
true
end
| _ -> begin
false
end))

# 103 "FStar.TypeChecker.Rel.fst"
let is_CONTRAVARIANT = (fun _discr_ -> (match (_discr_) with
| CONTRAVARIANT (_) -> begin
true
end
| _ -> begin
false
end))

# 104 "FStar.TypeChecker.Rel.fst"
let is_INVARIANT = (fun _discr_ -> (match (_discr_) with
| INVARIANT (_) -> begin
true
end
| _ -> begin
false
end))

# 106 "FStar.TypeChecker.Rel.fst"
type tprob =
(FStar_Syntax_Syntax.typ, FStar_Syntax_Syntax.term) FStar_TypeChecker_Common.problem

# 107 "FStar.TypeChecker.Rel.fst"
type cprob =
(FStar_Syntax_Syntax.comp, Prims.unit) FStar_TypeChecker_Common.problem

# 108 "FStar.TypeChecker.Rel.fst"
type ('a, 'b) problem_t =
('a, 'b) FStar_TypeChecker_Common.problem

# 117 "FStar.TypeChecker.Rel.fst"
let rel_to_string : FStar_TypeChecker_Common.rel  ->  Prims.string = (fun _69_1 -> (match (_69_1) with
| FStar_TypeChecker_Common.EQ -> begin
"="
end
| FStar_TypeChecker_Common.SUB -> begin
"<:"
end
| FStar_TypeChecker_Common.SUBINV -> begin
":>"
end))

# 122 "FStar.TypeChecker.Rel.fst"
let term_to_string = (fun env t -> (FStar_Syntax_Print.term_to_string t))

# 124 "FStar.TypeChecker.Rel.fst"
let prob_to_string : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  Prims.string = (fun env _69_2 -> (match (_69_2) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(let _151_109 = (let _151_108 = (term_to_string env p.FStar_TypeChecker_Common.lhs)
in (let _151_107 = (let _151_106 = (FStar_Syntax_Print.tag_of_term p.FStar_TypeChecker_Common.lhs)
in (let _151_105 = (let _151_104 = (let _151_103 = (term_to_string env p.FStar_TypeChecker_Common.rhs)
in (let _151_102 = (let _151_101 = (FStar_Syntax_Print.tag_of_term p.FStar_TypeChecker_Common.rhs)
in (let _151_100 = (let _151_99 = (FStar_TypeChecker_Normalize.term_to_string env (Prims.fst p.FStar_TypeChecker_Common.logical_guard))
in (let _151_98 = (let _151_97 = (FStar_All.pipe_right p.FStar_TypeChecker_Common.reason (FStar_String.concat "\n\t\t\t"))
in (_151_97)::[])
in (_151_99)::_151_98))
in (_151_101)::_151_100))
in (_151_103)::_151_102))
in ((rel_to_string p.FStar_TypeChecker_Common.relation))::_151_104)
in (_151_106)::_151_105))
in (_151_108)::_151_107))
in (FStar_Util.format "\t%s (%s)\n\t\t%s\n\t%s (%s) (guard %s)\n\t\t<Reason>\n\t\t\t%s\n\t\t</Reason>" _151_109))
end
| FStar_TypeChecker_Common.CProb (p) -> begin
(let _151_111 = (FStar_TypeChecker_Normalize.comp_to_string env p.FStar_TypeChecker_Common.lhs)
in (let _151_110 = (FStar_TypeChecker_Normalize.comp_to_string env p.FStar_TypeChecker_Common.rhs)
in (FStar_Util.format3 "\t%s \n\t\t%s\n\t%s" _151_111 (rel_to_string p.FStar_TypeChecker_Common.relation) _151_110)))
end))

# 140 "FStar.TypeChecker.Rel.fst"
let uvi_to_string : FStar_TypeChecker_Env.env  ->  uvi  ->  Prims.string = (fun env _69_3 -> (match (_69_3) with
| UNIV (u, t) -> begin
(
# 142 "FStar.TypeChecker.Rel.fst"
let x = if (FStar_ST.read FStar_Options.hide_uvar_nums) then begin
"?"
end else begin
(let _151_116 = (FStar_Unionfind.uvar_id u)
in (FStar_All.pipe_right _151_116 FStar_Util.string_of_int))
end
in (let _151_117 = (FStar_Syntax_Print.univ_to_string t)
in (FStar_Util.format2 "UNIV %s %s" x _151_117)))
end
| TERM ((u, _69_84), t) -> begin
(
# 146 "FStar.TypeChecker.Rel.fst"
let x = if (FStar_ST.read FStar_Options.hide_uvar_nums) then begin
"?"
end else begin
(let _151_118 = (FStar_Unionfind.uvar_id u)
in (FStar_All.pipe_right _151_118 FStar_Util.string_of_int))
end
in (let _151_119 = (FStar_TypeChecker_Normalize.term_to_string env t)
in (FStar_Util.format2 "TERM %s %s" x _151_119)))
end))

# 148 "FStar.TypeChecker.Rel.fst"
let uvis_to_string : FStar_TypeChecker_Env.env  ->  uvi Prims.list  ->  Prims.string = (fun env uvis -> (let _151_124 = (FStar_List.map (uvi_to_string env) uvis)
in (FStar_All.pipe_right _151_124 (FStar_String.concat ", "))))

# 149 "FStar.TypeChecker.Rel.fst"
let names_to_string : (FStar_Syntax_Syntax.bv Prims.list * (FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.bv  ->  Prims.bool))  ->  Prims.string = (fun nms -> (let _151_134 = (let _151_133 = (FStar_Util.set_elements nms)
in (FStar_All.pipe_right _151_133 (FStar_List.map FStar_Syntax_Print.bv_to_string)))
in (FStar_All.pipe_right _151_134 (FStar_String.concat ", "))))

# 150 "FStar.TypeChecker.Rel.fst"
let args_to_string = (fun args -> (let _151_137 = (FStar_All.pipe_right args (FStar_List.map (fun _69_97 -> (match (_69_97) with
| (x, _69_96) -> begin
(FStar_Syntax_Print.term_to_string x)
end))))
in (FStar_All.pipe_right _151_137 (FStar_String.concat " "))))

# 159 "FStar.TypeChecker.Rel.fst"
let empty_worklist : FStar_TypeChecker_Env.env  ->  worklist = (fun env -> {attempting = []; wl_deferred = []; ctr = 0; defer_ok = true; smt_ok = true; tcenv = env})

# 167 "FStar.TypeChecker.Rel.fst"
let singleton : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  worklist = (fun env prob -> (
# 167 "FStar.TypeChecker.Rel.fst"
let _69_101 = (empty_worklist env)
in {attempting = (prob)::[]; wl_deferred = _69_101.wl_deferred; ctr = _69_101.ctr; defer_ok = _69_101.defer_ok; smt_ok = _69_101.smt_ok; tcenv = _69_101.tcenv}))

# 168 "FStar.TypeChecker.Rel.fst"
let wl_of_guard = (fun env g -> (
# 168 "FStar.TypeChecker.Rel.fst"
let _69_105 = (empty_worklist env)
in (let _151_146 = (FStar_List.map Prims.snd g)
in {attempting = _151_146; wl_deferred = _69_105.wl_deferred; ctr = _69_105.ctr; defer_ok = false; smt_ok = _69_105.smt_ok; tcenv = _69_105.tcenv})))

# 169 "FStar.TypeChecker.Rel.fst"
let defer : Prims.string  ->  FStar_TypeChecker_Common.prob  ->  worklist  ->  worklist = (fun reason prob wl -> (
# 169 "FStar.TypeChecker.Rel.fst"
let _69_110 = wl
in {attempting = _69_110.attempting; wl_deferred = ((wl.ctr, reason, prob))::wl.wl_deferred; ctr = _69_110.ctr; defer_ok = _69_110.defer_ok; smt_ok = _69_110.smt_ok; tcenv = _69_110.tcenv}))

# 170 "FStar.TypeChecker.Rel.fst"
let attempt : FStar_TypeChecker_Common.prob Prims.list  ->  worklist  ->  worklist = (fun probs wl -> (
# 170 "FStar.TypeChecker.Rel.fst"
let _69_114 = wl
in {attempting = (FStar_List.append probs wl.attempting); wl_deferred = _69_114.wl_deferred; ctr = _69_114.ctr; defer_ok = _69_114.defer_ok; smt_ok = _69_114.smt_ok; tcenv = _69_114.tcenv}))

# 172 "FStar.TypeChecker.Rel.fst"
let giveup : FStar_TypeChecker_Env.env  ->  Prims.string  ->  FStar_TypeChecker_Common.prob  ->  solution = (fun env reason prob -> (
# 173 "FStar.TypeChecker.Rel.fst"
let _69_119 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_163 = (prob_to_string env prob)
in (FStar_Util.print2 "Failed %s:\n%s\n" reason _151_163))
end else begin
()
end
in Failed ((prob, reason))))

# 183 "FStar.TypeChecker.Rel.fst"
let invert_rel : FStar_TypeChecker_Common.rel  ->  FStar_TypeChecker_Common.rel = (fun _69_4 -> (match (_69_4) with
| FStar_TypeChecker_Common.EQ -> begin
FStar_TypeChecker_Common.EQ
end
| FStar_TypeChecker_Common.SUB -> begin
FStar_TypeChecker_Common.SUBINV
end
| FStar_TypeChecker_Common.SUBINV -> begin
FStar_TypeChecker_Common.SUB
end))

# 187 "FStar.TypeChecker.Rel.fst"
let invert = (fun p -> (
# 187 "FStar.TypeChecker.Rel.fst"
let _69_126 = p
in {FStar_TypeChecker_Common.pid = _69_126.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = p.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.relation = (invert_rel p.FStar_TypeChecker_Common.relation); FStar_TypeChecker_Common.rhs = p.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.element = _69_126.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_126.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_126.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_126.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_126.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_126.FStar_TypeChecker_Common.rank}))

# 188 "FStar.TypeChecker.Rel.fst"
let maybe_invert = (fun p -> if (p.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.SUBINV) then begin
(invert p)
end else begin
p
end)

# 189 "FStar.TypeChecker.Rel.fst"
let maybe_invert_p : FStar_TypeChecker_Common.prob  ->  FStar_TypeChecker_Common.prob = (fun _69_5 -> (match (_69_5) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(FStar_All.pipe_right (maybe_invert p) (fun _151_170 -> FStar_TypeChecker_Common.TProb (_151_170)))
end
| FStar_TypeChecker_Common.CProb (p) -> begin
(FStar_All.pipe_right (maybe_invert p) (fun _151_171 -> FStar_TypeChecker_Common.CProb (_151_171)))
end))

# 192 "FStar.TypeChecker.Rel.fst"
let vary_rel : FStar_TypeChecker_Common.rel  ->  variance  ->  FStar_TypeChecker_Common.rel = (fun rel _69_6 -> (match (_69_6) with
| INVARIANT -> begin
FStar_TypeChecker_Common.EQ
end
| CONTRAVARIANT -> begin
(invert_rel rel)
end
| COVARIANT -> begin
rel
end))

# 196 "FStar.TypeChecker.Rel.fst"
let p_pid : FStar_TypeChecker_Common.prob  ->  Prims.int = (fun _69_7 -> (match (_69_7) with
| FStar_TypeChecker_Common.TProb (p) -> begin
p.FStar_TypeChecker_Common.pid
end
| FStar_TypeChecker_Common.CProb (p) -> begin
p.FStar_TypeChecker_Common.pid
end))

# 199 "FStar.TypeChecker.Rel.fst"
let p_rel : FStar_TypeChecker_Common.prob  ->  FStar_TypeChecker_Common.rel = (fun _69_8 -> (match (_69_8) with
| FStar_TypeChecker_Common.TProb (p) -> begin
p.FStar_TypeChecker_Common.relation
end
| FStar_TypeChecker_Common.CProb (p) -> begin
p.FStar_TypeChecker_Common.relation
end))

# 202 "FStar.TypeChecker.Rel.fst"
let p_reason : FStar_TypeChecker_Common.prob  ->  Prims.string Prims.list = (fun _69_9 -> (match (_69_9) with
| FStar_TypeChecker_Common.TProb (p) -> begin
p.FStar_TypeChecker_Common.reason
end
| FStar_TypeChecker_Common.CProb (p) -> begin
p.FStar_TypeChecker_Common.reason
end))

# 205 "FStar.TypeChecker.Rel.fst"
let p_loc : FStar_TypeChecker_Common.prob  ->  FStar_Range.range = (fun _69_10 -> (match (_69_10) with
| FStar_TypeChecker_Common.TProb (p) -> begin
p.FStar_TypeChecker_Common.loc
end
| FStar_TypeChecker_Common.CProb (p) -> begin
p.FStar_TypeChecker_Common.loc
end))

# 208 "FStar.TypeChecker.Rel.fst"
let p_guard : FStar_TypeChecker_Common.prob  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.term) = (fun _69_11 -> (match (_69_11) with
| FStar_TypeChecker_Common.TProb (p) -> begin
p.FStar_TypeChecker_Common.logical_guard
end
| FStar_TypeChecker_Common.CProb (p) -> begin
p.FStar_TypeChecker_Common.logical_guard
end))

# 211 "FStar.TypeChecker.Rel.fst"
let p_scope : FStar_TypeChecker_Common.prob  ->  FStar_Syntax_Syntax.binders = (fun _69_12 -> (match (_69_12) with
| FStar_TypeChecker_Common.TProb (p) -> begin
p.FStar_TypeChecker_Common.scope
end
| FStar_TypeChecker_Common.CProb (p) -> begin
p.FStar_TypeChecker_Common.scope
end))

# 214 "FStar.TypeChecker.Rel.fst"
let p_invert : FStar_TypeChecker_Common.prob  ->  FStar_TypeChecker_Common.prob = (fun _69_13 -> (match (_69_13) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(FStar_All.pipe_left (fun _151_190 -> FStar_TypeChecker_Common.TProb (_151_190)) (invert p))
end
| FStar_TypeChecker_Common.CProb (p) -> begin
(FStar_All.pipe_left (fun _151_191 -> FStar_TypeChecker_Common.CProb (_151_191)) (invert p))
end))

# 217 "FStar.TypeChecker.Rel.fst"
let is_top_level_prob : FStar_TypeChecker_Common.prob  ->  Prims.bool = (fun p -> ((FStar_All.pipe_right (p_reason p) FStar_List.length) = 1))

# 218 "FStar.TypeChecker.Rel.fst"
let next_pid : Prims.unit  ->  Prims.int = (
# 219 "FStar.TypeChecker.Rel.fst"
let ctr = (FStar_ST.alloc 0)
in (fun _69_176 -> (match (()) with
| () -> begin
(
# 220 "FStar.TypeChecker.Rel.fst"
let _69_177 = (FStar_Util.incr ctr)
in (FStar_ST.read ctr))
end)))

# 222 "FStar.TypeChecker.Rel.fst"
let mk_problem = (fun scope orig lhs rel rhs elt reason -> (let _151_204 = (next_pid ())
in (let _151_203 = (new_uvar (p_loc orig) scope FStar_Syntax_Util.ktype0)
in {FStar_TypeChecker_Common.pid = _151_204; FStar_TypeChecker_Common.lhs = lhs; FStar_TypeChecker_Common.relation = rel; FStar_TypeChecker_Common.rhs = rhs; FStar_TypeChecker_Common.element = elt; FStar_TypeChecker_Common.logical_guard = _151_203; FStar_TypeChecker_Common.scope = scope; FStar_TypeChecker_Common.reason = (reason)::(p_reason orig); FStar_TypeChecker_Common.loc = (p_loc orig); FStar_TypeChecker_Common.rank = None})))

# 234 "FStar.TypeChecker.Rel.fst"
let new_problem = (fun env lhs rel rhs elt loc reason -> (
# 235 "FStar.TypeChecker.Rel.fst"
let scope = (FStar_TypeChecker_Env.all_binders env)
in (let _151_214 = (next_pid ())
in (let _151_213 = (let _151_212 = (FStar_TypeChecker_Env.get_range env)
in (new_uvar _151_212 scope FStar_Syntax_Util.ktype0))
in {FStar_TypeChecker_Common.pid = _151_214; FStar_TypeChecker_Common.lhs = lhs; FStar_TypeChecker_Common.relation = rel; FStar_TypeChecker_Common.rhs = rhs; FStar_TypeChecker_Common.element = elt; FStar_TypeChecker_Common.logical_guard = _151_213; FStar_TypeChecker_Common.scope = scope; FStar_TypeChecker_Common.reason = (reason)::[]; FStar_TypeChecker_Common.loc = loc; FStar_TypeChecker_Common.rank = None}))))

# 248 "FStar.TypeChecker.Rel.fst"
let problem_using_guard = (fun orig lhs rel rhs elt reason -> (let _151_221 = (next_pid ())
in {FStar_TypeChecker_Common.pid = _151_221; FStar_TypeChecker_Common.lhs = lhs; FStar_TypeChecker_Common.relation = rel; FStar_TypeChecker_Common.rhs = rhs; FStar_TypeChecker_Common.element = elt; FStar_TypeChecker_Common.logical_guard = (p_guard orig); FStar_TypeChecker_Common.scope = (p_scope orig); FStar_TypeChecker_Common.reason = (reason)::(p_reason orig); FStar_TypeChecker_Common.loc = (p_loc orig); FStar_TypeChecker_Common.rank = None}))

# 260 "FStar.TypeChecker.Rel.fst"
let guard_on_element = (fun problem x phi -> (match (problem.FStar_TypeChecker_Common.element) with
| None -> begin
(FStar_Syntax_Util.mk_forall x phi)
end
| Some (e) -> begin
(FStar_Syntax_Subst.subst ((FStar_Syntax_Syntax.NT ((x, e)))::[]) phi)
end))

# 264 "FStar.TypeChecker.Rel.fst"
let explain : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  Prims.string  ->  Prims.string = (fun env d s -> (let _151_233 = (FStar_All.pipe_left FStar_Range.string_of_range (p_loc d))
in (let _151_232 = (prob_to_string env d)
in (let _151_231 = (FStar_All.pipe_right (p_reason d) (FStar_String.concat "\n\t>"))
in (FStar_Util.format4 "(%s) Failed to solve the sub-problem\n%s\nWhich arose because:\n\t%s\nFailed because:%s\n" _151_233 _151_232 _151_231 s)))))

# 278 "FStar.TypeChecker.Rel.fst"
let commit : uvi Prims.list  ->  Prims.unit = (fun uvis -> (FStar_All.pipe_right uvis (FStar_List.iter (fun _69_14 -> (match (_69_14) with
| UNIV (u, t) -> begin
(match (t) with
| FStar_Syntax_Syntax.U_unif (u') -> begin
(FStar_Unionfind.union u u')
end
| _69_218 -> begin
(FStar_Unionfind.change u (Some (t)))
end)
end
| TERM ((u, _69_221), t) -> begin
(FStar_Syntax_Util.set_uvar u t)
end)))))

# 286 "FStar.TypeChecker.Rel.fst"
let find_term_uvar : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax FStar_Syntax_Syntax.uvar_basis FStar_Unionfind.uvar  ->  uvi Prims.list  ->  FStar_Syntax_Syntax.term Prims.option = (fun uv s -> (FStar_Util.find_map s (fun _69_15 -> (match (_69_15) with
| UNIV (_69_230) -> begin
None
end
| TERM ((u, _69_234), t) -> begin
if (FStar_Unionfind.equivalent uv u) then begin
Some (t)
end else begin
None
end
end))))

# 290 "FStar.TypeChecker.Rel.fst"
let find_univ_uvar : FStar_Syntax_Syntax.universe Prims.option FStar_Unionfind.uvar  ->  uvi Prims.list  ->  FStar_Syntax_Syntax.universe Prims.option = (fun u s -> (FStar_Util.find_map s (fun _69_16 -> (match (_69_16) with
| UNIV (u', t) -> begin
if (FStar_Unionfind.equivalent u u') then begin
Some (t)
end else begin
None
end
end
| _69_247 -> begin
None
end))))

# 302 "FStar.TypeChecker.Rel.fst"
let whnf : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env t -> (let _151_252 = (let _151_251 = (FStar_Syntax_Util.unmeta t)
in (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.WHNF)::[]) env _151_251))
in (FStar_Syntax_Subst.compress _151_252)))

# 303 "FStar.TypeChecker.Rel.fst"
let sn : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun env t -> (let _151_257 = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env t)
in (FStar_Syntax_Subst.compress _151_257)))

# 304 "FStar.TypeChecker.Rel.fst"
let norm_arg = (fun env t -> (let _151_260 = (sn env (Prims.fst t))
in (_151_260, (Prims.snd t))))

# 305 "FStar.TypeChecker.Rel.fst"
let sn_binders : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.binders  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list = (fun env binders -> (FStar_All.pipe_right binders (FStar_List.map (fun _69_258 -> (match (_69_258) with
| (x, imp) -> begin
(let _151_267 = (
# 306 "FStar.TypeChecker.Rel.fst"
let _69_259 = x
in (let _151_266 = (sn env x.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _69_259.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _69_259.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _151_266}))
in (_151_267, imp))
end)))))

# 312 "FStar.TypeChecker.Rel.fst"
let norm_univ : worklist  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe = (fun wl u -> (
# 313 "FStar.TypeChecker.Rel.fst"
let rec aux = (fun u -> (
# 314 "FStar.TypeChecker.Rel.fst"
let u = (FStar_Syntax_Subst.compress_univ u)
in (match (u) with
| FStar_Syntax_Syntax.U_succ (u) -> begin
(let _151_274 = (aux u)
in FStar_Syntax_Syntax.U_succ (_151_274))
end
| FStar_Syntax_Syntax.U_max (us) -> begin
(let _151_275 = (FStar_List.map aux us)
in FStar_Syntax_Syntax.U_max (_151_275))
end
| _69_271 -> begin
u
end)))
in (let _151_276 = (aux u)
in (FStar_TypeChecker_Normalize.normalize_universe wl.tcenv _151_276))))

# 325 "FStar.TypeChecker.Rel.fst"
let normalize_refinement = (fun steps env wl t0 -> (FStar_TypeChecker_Normalize.normalize_refinement steps env t0))

# 327 "FStar.TypeChecker.Rel.fst"
let base_and_refinement = (fun env wl t1 -> (
# 328 "FStar.TypeChecker.Rel.fst"
let rec aux = (fun norm t1 -> (match (t1.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_refine (x, phi) -> begin
if norm then begin
(x.FStar_Syntax_Syntax.sort, Some ((x, phi)))
end else begin
(match ((normalize_refinement ((FStar_TypeChecker_Normalize.WHNF)::[]) env wl t1)) with
| {FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_refine (x, phi); FStar_Syntax_Syntax.tk = _69_291; FStar_Syntax_Syntax.pos = _69_289; FStar_Syntax_Syntax.vars = _69_287} -> begin
(x.FStar_Syntax_Syntax.sort, Some ((x, phi)))
end
| tt -> begin
(let _151_290 = (let _151_289 = (FStar_Syntax_Print.term_to_string tt)
in (let _151_288 = (FStar_Syntax_Print.tag_of_term tt)
in (FStar_Util.format2 "impossible: Got %s ... %s\n" _151_289 _151_288)))
in (FStar_All.failwith _151_290))
end)
end
end
| (FStar_Syntax_Syntax.Tm_uinst (_)) | (FStar_Syntax_Syntax.Tm_fvar (_)) | (FStar_Syntax_Syntax.Tm_app (_)) -> begin
if norm then begin
(t1, None)
end else begin
(
# 343 "FStar.TypeChecker.Rel.fst"
let _69_309 = (let _151_291 = (normalize_refinement ((FStar_TypeChecker_Normalize.WHNF)::[]) env wl t1)
in (aux true _151_291))
in (match (_69_309) with
| (t2', refinement) -> begin
(match (refinement) with
| None -> begin
(t1, None)
end
| _69_312 -> begin
(t2', refinement)
end)
end))
end
end
| (FStar_Syntax_Syntax.Tm_type (_)) | (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_name (_)) | (FStar_Syntax_Syntax.Tm_bvar (_)) | (FStar_Syntax_Syntax.Tm_arrow (_)) | (FStar_Syntax_Syntax.Tm_abs (_)) | (FStar_Syntax_Syntax.Tm_uvar (_)) -> begin
(t1, None)
end
| (FStar_Syntax_Syntax.Tm_let (_)) | (FStar_Syntax_Syntax.Tm_match (_)) -> begin
(FStar_All.failwith "Unhandled cases!")
end
| (FStar_Syntax_Syntax.Tm_meta (_)) | (FStar_Syntax_Syntax.Tm_ascribed (_)) | (FStar_Syntax_Syntax.Tm_delayed (_)) | (FStar_Syntax_Syntax.Tm_unknown) -> begin
(let _151_294 = (let _151_293 = (FStar_Syntax_Print.term_to_string t1)
in (let _151_292 = (FStar_Syntax_Print.tag_of_term t1)
in (FStar_Util.format2 "impossible (outer): Got %s ... %s\n" _151_293 _151_292)))
in (FStar_All.failwith _151_294))
end))
in (let _151_295 = (whnf env t1)
in (aux false _151_295))))

# 367 "FStar.TypeChecker.Rel.fst"
let unrefine : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ = (fun env t -> (let _151_300 = (base_and_refinement env (empty_worklist env) t)
in (FStar_All.pipe_right _151_300 Prims.fst)))

# 369 "FStar.TypeChecker.Rel.fst"
let trivial_refinement : FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term) = (fun t -> (let _151_303 = (FStar_Syntax_Syntax.null_bv t)
in (_151_303, FStar_Syntax_Util.t_true)))

# 371 "FStar.TypeChecker.Rel.fst"
let as_refinement = (fun env wl t -> (
# 372 "FStar.TypeChecker.Rel.fst"
let _69_358 = (base_and_refinement env wl t)
in (match (_69_358) with
| (t_base, refinement) -> begin
(match (refinement) with
| None -> begin
(trivial_refinement t_base)
end
| Some (x, phi) -> begin
(x, phi)
end)
end)))

# 377 "FStar.TypeChecker.Rel.fst"
let force_refinement = (fun _69_366 -> (match (_69_366) with
| (t_base, refopt) -> begin
(
# 378 "FStar.TypeChecker.Rel.fst"
let _69_374 = (match (refopt) with
| Some (y, phi) -> begin
(y, phi)
end
| None -> begin
(trivial_refinement t_base)
end)
in (match (_69_374) with
| (y, phi) -> begin
(FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_refine ((y, phi))) None t_base.FStar_Syntax_Syntax.pos)
end))
end))

# 391 "FStar.TypeChecker.Rel.fst"
let wl_prob_to_string : worklist  ->  FStar_TypeChecker_Common.prob  ->  Prims.string = (fun wl _69_17 -> (match (_69_17) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(let _151_316 = (FStar_Util.string_of_int p.FStar_TypeChecker_Common.pid)
in (let _151_315 = (let _151_312 = (whnf wl.tcenv p.FStar_TypeChecker_Common.lhs)
in (FStar_Syntax_Print.term_to_string _151_312))
in (let _151_314 = (let _151_313 = (whnf wl.tcenv p.FStar_TypeChecker_Common.rhs)
in (FStar_Syntax_Print.term_to_string _151_313))
in (FStar_Util.format4 "%s: %s  (%s)  %s" _151_316 _151_315 (rel_to_string p.FStar_TypeChecker_Common.relation) _151_314))))
end
| FStar_TypeChecker_Common.CProb (p) -> begin
(let _151_319 = (FStar_Util.string_of_int p.FStar_TypeChecker_Common.pid)
in (let _151_318 = (FStar_TypeChecker_Normalize.comp_to_string wl.tcenv p.FStar_TypeChecker_Common.lhs)
in (let _151_317 = (FStar_TypeChecker_Normalize.comp_to_string wl.tcenv p.FStar_TypeChecker_Common.rhs)
in (FStar_Util.format4 "%s: %s  (%s)  %s" _151_319 _151_318 (rel_to_string p.FStar_TypeChecker_Common.relation) _151_317))))
end))

# 406 "FStar.TypeChecker.Rel.fst"
let wl_to_string : worklist  ->  Prims.string = (fun wl -> (let _151_325 = (let _151_324 = (let _151_323 = (FStar_All.pipe_right wl.wl_deferred (FStar_List.map (fun _69_387 -> (match (_69_387) with
| (_69_383, _69_385, x) -> begin
x
end))))
in (FStar_List.append wl.attempting _151_323))
in (FStar_List.map (wl_prob_to_string wl) _151_324))
in (FStar_All.pipe_right _151_325 (FStar_String.concat "\n\t"))))

# 416 "FStar.TypeChecker.Rel.fst"
let u_abs : (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term = (fun x y -> (FStar_Syntax_Util.abs x y None))

# 418 "FStar.TypeChecker.Rel.fst"
let solve_prob' : Prims.bool  ->  FStar_TypeChecker_Common.prob  ->  FStar_Syntax_Syntax.term Prims.option  ->  uvi Prims.list  ->  worklist  ->  worklist = (fun resolve_ok prob logical_guard uvis wl -> (
# 419 "FStar.TypeChecker.Rel.fst"
let phi = (match (logical_guard) with
| None -> begin
FStar_Syntax_Util.t_true
end
| Some (phi) -> begin
phi
end)
in (
# 422 "FStar.TypeChecker.Rel.fst"
let _69_402 = (p_guard prob)
in (match (_69_402) with
| (_69_400, uv) -> begin
(
# 423 "FStar.TypeChecker.Rel.fst"
let _69_415 = (match ((let _151_340 = (FStar_Syntax_Subst.compress uv)
in _151_340.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_uvar (uvar, k) -> begin
(
# 425 "FStar.TypeChecker.Rel.fst"
let bs = (p_scope prob)
in (
# 426 "FStar.TypeChecker.Rel.fst"
let bs = (FStar_All.pipe_right bs (FStar_List.filter (fun x -> (let _151_342 = (FStar_Syntax_Syntax.is_null_binder x)
in (FStar_All.pipe_right _151_342 Prims.op_Negation)))))
in (
# 427 "FStar.TypeChecker.Rel.fst"
let phi = (u_abs bs phi)
in (
# 428 "FStar.TypeChecker.Rel.fst"
let _69_411 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug wl.tcenv) (FStar_Options.Other ("Rel"))) then begin
(let _151_345 = (FStar_Util.string_of_int (p_pid prob))
in (let _151_344 = (FStar_Syntax_Print.term_to_string uv)
in (let _151_343 = (FStar_Syntax_Print.term_to_string phi)
in (FStar_Util.print3 "Solving %s (%s) with formula %s\n" _151_345 _151_344 _151_343))))
end else begin
()
end
in (FStar_Syntax_Util.set_uvar uvar phi)))))
end
| _69_414 -> begin
if (not (resolve_ok)) then begin
(FStar_All.failwith "Impossible: this instance has already been assigned a solution")
end else begin
()
end
end)
in (
# 435 "FStar.TypeChecker.Rel.fst"
let _69_417 = (commit uvis)
in (
# 436 "FStar.TypeChecker.Rel.fst"
let _69_419 = wl
in {attempting = _69_419.attempting; wl_deferred = _69_419.wl_deferred; ctr = (wl.ctr + 1); defer_ok = _69_419.defer_ok; smt_ok = _69_419.smt_ok; tcenv = _69_419.tcenv})))
end))))

# 438 "FStar.TypeChecker.Rel.fst"
let extend_solution : Prims.int  ->  uvi Prims.list  ->  worklist  ->  worklist = (fun pid sol wl -> (
# 439 "FStar.TypeChecker.Rel.fst"
let _69_424 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug wl.tcenv) (FStar_Options.Other ("RelCheck"))) then begin
(let _151_354 = (FStar_Util.string_of_int pid)
in (let _151_353 = (let _151_352 = (FStar_List.map (uvi_to_string wl.tcenv) sol)
in (FStar_All.pipe_right _151_352 (FStar_String.concat ", ")))
in (FStar_Util.print2 "Solving %s: with %s\n" _151_354 _151_353)))
end else begin
()
end
in (
# 441 "FStar.TypeChecker.Rel.fst"
let _69_426 = (commit sol)
in (
# 442 "FStar.TypeChecker.Rel.fst"
let _69_428 = wl
in {attempting = _69_428.attempting; wl_deferred = _69_428.wl_deferred; ctr = (wl.ctr + 1); defer_ok = _69_428.defer_ok; smt_ok = _69_428.smt_ok; tcenv = _69_428.tcenv}))))

# 444 "FStar.TypeChecker.Rel.fst"
let solve_prob : FStar_TypeChecker_Common.prob  ->  FStar_Syntax_Syntax.term Prims.option  ->  uvi Prims.list  ->  worklist  ->  worklist = (fun prob logical_guard uvis wl -> (
# 445 "FStar.TypeChecker.Rel.fst"
let conj_guard = (fun t g -> (match ((t, g)) with
| (_69_438, FStar_TypeChecker_Common.Trivial) -> begin
t
end
| (None, FStar_TypeChecker_Common.NonTrivial (f)) -> begin
Some (f)
end
| (Some (t), FStar_TypeChecker_Common.NonTrivial (f)) -> begin
(let _151_367 = (FStar_Syntax_Util.mk_conj t f)
in Some (_151_367))
end))
in (
# 449 "FStar.TypeChecker.Rel.fst"
let _69_450 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug wl.tcenv) (FStar_Options.Other ("RelCheck"))) then begin
(let _151_370 = (FStar_All.pipe_left FStar_Util.string_of_int (p_pid prob))
in (let _151_369 = (let _151_368 = (FStar_List.map (uvi_to_string wl.tcenv) uvis)
in (FStar_All.pipe_right _151_368 (FStar_String.concat ", ")))
in (FStar_Util.print2 "Solving %s: with %s\n" _151_370 _151_369)))
end else begin
()
end
in (solve_prob' false prob logical_guard uvis wl))))

# 461 "FStar.TypeChecker.Rel.fst"
let rec occurs = (fun wl uk t -> (let _151_380 = (let _151_378 = (FStar_Syntax_Free.uvars t)
in (FStar_All.pipe_right _151_378 FStar_Util.set_elements))
in (FStar_All.pipe_right _151_380 (FStar_Util.for_some (fun _69_459 -> (match (_69_459) with
| (uv, _69_458) -> begin
(FStar_Unionfind.equivalent uv (Prims.fst uk))
end))))))

# 467 "FStar.TypeChecker.Rel.fst"
let occurs_check = (fun env wl uk t -> (
# 468 "FStar.TypeChecker.Rel.fst"
let occurs_ok = (not ((occurs wl uk t)))
in (
# 469 "FStar.TypeChecker.Rel.fst"
let msg = if occurs_ok then begin
None
end else begin
(let _151_387 = (let _151_386 = (FStar_Syntax_Print.uvar_to_string (Prims.fst uk))
in (let _151_385 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format2 "occurs-check failed (%s occurs in %s)" _151_386 _151_385)))
in Some (_151_387))
end
in (occurs_ok, msg))))

# 476 "FStar.TypeChecker.Rel.fst"
let occurs_and_freevars_check = (fun env wl uk fvs t -> (
# 477 "FStar.TypeChecker.Rel.fst"
let fvs_t = (FStar_Syntax_Free.names t)
in (
# 478 "FStar.TypeChecker.Rel.fst"
let _69_474 = (occurs_check env wl uk t)
in (match (_69_474) with
| (occurs_ok, msg) -> begin
(let _151_419 = (FStar_Util.set_is_subset_of fvs_t fvs)
in (occurs_ok, _151_419, (msg, fvs, fvs_t)))
end))))

# 481 "FStar.TypeChecker.Rel.fst"
let intersect_vars = (fun v1 v2 -> (
# 482 "FStar.TypeChecker.Rel.fst"
let as_set = (fun v -> (FStar_All.pipe_right v (FStar_List.fold_left (fun out x -> (FStar_Util.set_add (Prims.fst x) out)) FStar_Syntax_Syntax.no_names)))
in (
# 484 "FStar.TypeChecker.Rel.fst"
let v1_set = (as_set v1)
in (
# 485 "FStar.TypeChecker.Rel.fst"
let _69_492 = (FStar_All.pipe_right v2 (FStar_List.fold_left (fun _69_484 _69_487 -> (match ((_69_484, _69_487)) with
| ((isect, isect_set), (x, imp)) -> begin
if (let _151_428 = (FStar_Util.set_mem x v1_set)
in (FStar_All.pipe_left Prims.op_Negation _151_428)) then begin
(isect, isect_set)
end else begin
(
# 491 "FStar.TypeChecker.Rel.fst"
let fvs = (FStar_Syntax_Free.names x.FStar_Syntax_Syntax.sort)
in if (FStar_Util.set_is_subset_of fvs isect_set) then begin
(let _151_429 = (FStar_Util.set_add x isect_set)
in (((x, imp))::isect, _151_429))
end else begin
(isect, isect_set)
end)
end
end)) ([], FStar_Syntax_Syntax.no_names)))
in (match (_69_492) with
| (isect, _69_491) -> begin
(FStar_List.rev isect)
end)))))

# 498 "FStar.TypeChecker.Rel.fst"
let binders_eq = (fun v1 v2 -> (((FStar_List.length v1) = (FStar_List.length v2)) && (FStar_List.forall2 (fun _69_498 _69_502 -> (match ((_69_498, _69_502)) with
| ((a, _69_497), (b, _69_501)) -> begin
(FStar_Syntax_Syntax.bv_eq a b)
end)) v1 v2)))

# 502 "FStar.TypeChecker.Rel.fst"
let pat_var_opt = (fun env seen arg -> (
# 503 "FStar.TypeChecker.Rel.fst"
let hd = (norm_arg env arg)
in (match ((Prims.fst hd).FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_name (a) -> begin
if (FStar_All.pipe_right seen (FStar_Util.for_some (fun _69_512 -> (match (_69_512) with
| (b, _69_511) -> begin
(FStar_Syntax_Syntax.bv_eq a b)
end)))) then begin
None
end else begin
Some ((a, (Prims.snd hd)))
end
end
| _69_514 -> begin
None
end)))

# 512 "FStar.TypeChecker.Rel.fst"
let rec pat_vars : FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.arg_qualifier Prims.option) Prims.list  ->  FStar_Syntax_Syntax.binders Prims.option = (fun env seen args -> (match (args) with
| [] -> begin
Some ((FStar_List.rev seen))
end
| hd::rest -> begin
(match ((pat_var_opt env seen hd)) with
| None -> begin
(
# 516 "FStar.TypeChecker.Rel.fst"
let _69_523 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_444 = (FStar_All.pipe_left FStar_Syntax_Print.term_to_string (Prims.fst hd))
in (FStar_Util.print1 "Not a pattern: %s\n" _151_444))
end else begin
()
end
in None)
end
| Some (x) -> begin
(pat_vars env ((x)::seen) rest)
end)
end))

# 520 "FStar.TypeChecker.Rel.fst"
let destruct_flex_t = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_uvar (uv, k) -> begin
(t, uv, k, [])
end
| FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (uv, k); FStar_Syntax_Syntax.tk = _69_537; FStar_Syntax_Syntax.pos = _69_535; FStar_Syntax_Syntax.vars = _69_533}, args) -> begin
(t, uv, k, args)
end
| _69_547 -> begin
(FStar_All.failwith "Not a flex-uvar")
end))

# 525 "FStar.TypeChecker.Rel.fst"
let destruct_flex_pattern = (fun env t -> (
# 526 "FStar.TypeChecker.Rel.fst"
let _69_554 = (destruct_flex_t t)
in (match (_69_554) with
| (t, uv, k, args) -> begin
(match ((pat_vars env [] args)) with
| Some (vars) -> begin
((t, uv, k, args), Some (vars))
end
| _69_558 -> begin
((t, uv, k, args), None)
end)
end)))

# 600 "FStar.TypeChecker.Rel.fst"
type match_result =
| MisMatch
| HeadMatch
| FullMatch

# 601 "FStar.TypeChecker.Rel.fst"
let is_MisMatch = (fun _discr_ -> (match (_discr_) with
| MisMatch (_) -> begin
true
end
| _ -> begin
false
end))

# 602 "FStar.TypeChecker.Rel.fst"
let is_HeadMatch = (fun _discr_ -> (match (_discr_) with
| HeadMatch (_) -> begin
true
end
| _ -> begin
false
end))

# 603 "FStar.TypeChecker.Rel.fst"
let is_FullMatch = (fun _discr_ -> (match (_discr_) with
| FullMatch (_) -> begin
true
end
| _ -> begin
false
end))

# 605 "FStar.TypeChecker.Rel.fst"
let head_match : match_result  ->  match_result = (fun _69_18 -> (match (_69_18) with
| MisMatch -> begin
MisMatch
end
| _69_562 -> begin
HeadMatch
end))

# 609 "FStar.TypeChecker.Rel.fst"
let rec head_matches : FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term  ->  match_result = (fun t1 t2 -> (match ((let _151_460 = (let _151_457 = (FStar_Syntax_Util.unmeta t1)
in _151_457.FStar_Syntax_Syntax.n)
in (let _151_459 = (let _151_458 = (FStar_Syntax_Util.unmeta t2)
in _151_458.FStar_Syntax_Syntax.n)
in (_151_460, _151_459)))) with
| (FStar_Syntax_Syntax.Tm_name (x), FStar_Syntax_Syntax.Tm_name (y)) -> begin
if (FStar_Syntax_Syntax.bv_eq x y) then begin
FullMatch
end else begin
MisMatch
end
end
| (FStar_Syntax_Syntax.Tm_fvar (f), FStar_Syntax_Syntax.Tm_fvar (g)) -> begin
if (FStar_Syntax_Syntax.fv_eq f g) then begin
FullMatch
end else begin
MisMatch
end
end
| (FStar_Syntax_Syntax.Tm_uinst (f, _69_577), FStar_Syntax_Syntax.Tm_uinst (g, _69_582)) -> begin
(let _151_461 = (head_matches f g)
in (FStar_All.pipe_right _151_461 head_match))
end
| (FStar_Syntax_Syntax.Tm_constant (c), FStar_Syntax_Syntax.Tm_constant (d)) -> begin
if (c = d) then begin
FullMatch
end else begin
MisMatch
end
end
| (FStar_Syntax_Syntax.Tm_uvar (uv, _69_593), FStar_Syntax_Syntax.Tm_uvar (uv', _69_598)) -> begin
if (FStar_Unionfind.equivalent uv uv') then begin
FullMatch
end else begin
MisMatch
end
end
| (FStar_Syntax_Syntax.Tm_refine (x, _69_604), FStar_Syntax_Syntax.Tm_refine (y, _69_609)) -> begin
(let _151_462 = (head_matches x.FStar_Syntax_Syntax.sort y.FStar_Syntax_Syntax.sort)
in (FStar_All.pipe_right _151_462 head_match))
end
| (FStar_Syntax_Syntax.Tm_refine (x, _69_615), _69_619) -> begin
(let _151_463 = (head_matches x.FStar_Syntax_Syntax.sort t2)
in (FStar_All.pipe_right _151_463 head_match))
end
| (_69_622, FStar_Syntax_Syntax.Tm_refine (x, _69_625)) -> begin
(let _151_464 = (head_matches t1 x.FStar_Syntax_Syntax.sort)
in (FStar_All.pipe_right _151_464 head_match))
end
| ((FStar_Syntax_Syntax.Tm_type (_), FStar_Syntax_Syntax.Tm_type (_))) | ((FStar_Syntax_Syntax.Tm_arrow (_), FStar_Syntax_Syntax.Tm_arrow (_))) -> begin
HeadMatch
end
| (FStar_Syntax_Syntax.Tm_app (head, _69_645), FStar_Syntax_Syntax.Tm_app (head', _69_650)) -> begin
(head_matches head head')
end
| (FStar_Syntax_Syntax.Tm_app (head, _69_656), _69_660) -> begin
(head_matches head t2)
end
| (_69_663, FStar_Syntax_Syntax.Tm_app (head, _69_666)) -> begin
(head_matches t1 head)
end
| _69_671 -> begin
MisMatch
end))

# 632 "FStar.TypeChecker.Rel.fst"
let head_matches_delta = (fun env wl t1 t2 -> (
# 633 "FStar.TypeChecker.Rel.fst"
let success = (fun d r t1 t2 -> (r, if (d > 0) then begin
Some ((t1, t2))
end else begin
None
end))
in (
# 634 "FStar.TypeChecker.Rel.fst"
let fail = (fun _69_682 -> (match (()) with
| () -> begin
(MisMatch, None)
end))
in (
# 635 "FStar.TypeChecker.Rel.fst"
let rec aux = (fun d t1 t2 -> (match ((head_matches t1 t2)) with
| MisMatch -> begin
if (d = 3) then begin
(fail ())
end else begin
(
# 639 "FStar.TypeChecker.Rel.fst"
let steps = if (d = 0) then begin
(FStar_TypeChecker_Normalize.Inline)::(FStar_TypeChecker_Normalize.WHNF)::[]
end else begin
if (d = 1) then begin
(FStar_TypeChecker_Normalize.Unfold)::(FStar_TypeChecker_Normalize.WHNF)::[]
end else begin
(FStar_TypeChecker_Normalize.Unfold)::[]
end
end
in (
# 645 "FStar.TypeChecker.Rel.fst"
let t1' = (normalize_refinement steps env wl t1)
in (
# 646 "FStar.TypeChecker.Rel.fst"
let t2' = (normalize_refinement steps env wl t2)
in (aux (d + 1) t1' t2'))))
end
end
| r -> begin
(success d r t1 t2)
end))
in (aux 0 t1 t2)))))

# 651 "FStar.TypeChecker.Rel.fst"
type tc =
| T of FStar_Syntax_Syntax.term
| C of FStar_Syntax_Syntax.comp

# 652 "FStar.TypeChecker.Rel.fst"
let is_T = (fun _discr_ -> (match (_discr_) with
| T (_) -> begin
true
end
| _ -> begin
false
end))

# 653 "FStar.TypeChecker.Rel.fst"
let is_C = (fun _discr_ -> (match (_discr_) with
| C (_) -> begin
true
end
| _ -> begin
false
end))

# 652 "FStar.TypeChecker.Rel.fst"
let ___T____0 : tc  ->  FStar_Syntax_Syntax.term = (fun projectee -> (match (projectee) with
| T (_69_694) -> begin
_69_694
end))

# 653 "FStar.TypeChecker.Rel.fst"
let ___C____0 : tc  ->  FStar_Syntax_Syntax.comp = (fun projectee -> (match (projectee) with
| C (_69_697) -> begin
_69_697
end))

# 654 "FStar.TypeChecker.Rel.fst"
type tcs =
tc Prims.list

# 656 "FStar.TypeChecker.Rel.fst"
let rec decompose = (fun env t -> (
# 657 "FStar.TypeChecker.Rel.fst"
let t = (FStar_Syntax_Util.unmeta t)
in (
# 658 "FStar.TypeChecker.Rel.fst"
let matches = (fun t' -> ((head_matches t t') <> MisMatch))
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_app (hd, args) -> begin
(
# 661 "FStar.TypeChecker.Rel.fst"
let rebuild = (fun args' -> (
# 662 "FStar.TypeChecker.Rel.fst"
let args = (FStar_List.map2 (fun x y -> (match ((x, y)) with
| ((_69_712, imp), T (t)) -> begin
(t, imp)
end
| _69_719 -> begin
(FStar_All.failwith "Bad reconstruction")
end)) args args')
in (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((hd, args))) None t.FStar_Syntax_Syntax.pos)))
in (
# 667 "FStar.TypeChecker.Rel.fst"
let tcs = (FStar_All.pipe_right args (FStar_List.map (fun _69_724 -> (match (_69_724) with
| (t, _69_723) -> begin
(None, INVARIANT, T (t))
end))))
in (rebuild, matches, tcs)))
end
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(
# 673 "FStar.TypeChecker.Rel.fst"
let fail = (fun _69_731 -> (match (()) with
| () -> begin
(FStar_All.failwith "Bad reconstruction")
end))
in (
# 674 "FStar.TypeChecker.Rel.fst"
let _69_734 = (FStar_Syntax_Subst.open_comp bs c)
in (match (_69_734) with
| (bs, c) -> begin
(
# 676 "FStar.TypeChecker.Rel.fst"
let rebuild = (fun tcs -> (
# 677 "FStar.TypeChecker.Rel.fst"
let rec aux = (fun out bs tcs -> (match ((bs, tcs)) with
| ((x, imp)::bs, T (t)::tcs) -> begin
(aux ((((
# 678 "FStar.TypeChecker.Rel.fst"
let _69_751 = x
in {FStar_Syntax_Syntax.ppname = _69_751.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _69_751.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t}), imp))::out) bs tcs)
end
| ([], C (c)::[]) -> begin
(FStar_Syntax_Util.arrow (FStar_List.rev out) c)
end
| _69_759 -> begin
(FStar_All.failwith "Bad reconstruction")
end))
in (aux [] bs tcs)))
in (
# 683 "FStar.TypeChecker.Rel.fst"
let rec decompose = (fun out _69_19 -> (match (_69_19) with
| [] -> begin
(FStar_List.rev (((None, COVARIANT, C (c)))::out))
end
| hd::rest -> begin
(
# 686 "FStar.TypeChecker.Rel.fst"
let bopt = if (FStar_Syntax_Syntax.is_null_binder hd) then begin
None
end else begin
Some (hd)
end
in (decompose (((bopt, CONTRAVARIANT, T ((Prims.fst hd).FStar_Syntax_Syntax.sort)))::out) rest))
end))
in (let _151_558 = (decompose [] bs)
in (rebuild, matches, _151_558))))
end)))
end
| _69_769 -> begin
(
# 694 "FStar.TypeChecker.Rel.fst"
let rebuild = (fun _69_20 -> (match (_69_20) with
| [] -> begin
t
end
| _69_773 -> begin
(FStar_All.failwith "Bad reconstruction")
end))
in (rebuild, (fun t -> true), []))
end))))

# 700 "FStar.TypeChecker.Rel.fst"
let un_T : tc  ->  FStar_Syntax_Syntax.term = (fun _69_21 -> (match (_69_21) with
| T (t) -> begin
t
end
| _69_780 -> begin
(FStar_All.failwith "Impossible")
end))

# 704 "FStar.TypeChecker.Rel.fst"
let arg_of_tc : tc  ->  FStar_Syntax_Syntax.arg = (fun _69_22 -> (match (_69_22) with
| T (t) -> begin
(FStar_Syntax_Syntax.as_arg t)
end
| _69_785 -> begin
(FStar_All.failwith "Impossible")
end))

# 708 "FStar.TypeChecker.Rel.fst"
let imitation_sub_probs = (fun orig env scope ps qs -> (
# 713 "FStar.TypeChecker.Rel.fst"
let r = (p_loc orig)
in (
# 714 "FStar.TypeChecker.Rel.fst"
let rel = (p_rel orig)
in (
# 715 "FStar.TypeChecker.Rel.fst"
let sub_prob = (fun scope args q -> (match (q) with
| (_69_798, variance, T (ti)) -> begin
(
# 718 "FStar.TypeChecker.Rel.fst"
let k = (
# 719 "FStar.TypeChecker.Rel.fst"
let _69_806 = (FStar_Syntax_Util.type_u ())
in (match (_69_806) with
| (t, _69_805) -> begin
(let _151_580 = (new_uvar r scope t)
in (Prims.fst _151_580))
end))
in (
# 721 "FStar.TypeChecker.Rel.fst"
let _69_810 = (new_uvar r scope k)
in (match (_69_810) with
| (gi_xs, gi) -> begin
(
# 722 "FStar.TypeChecker.Rel.fst"
let gi_ps = (match (args) with
| [] -> begin
gi
end
| _69_813 -> begin
(FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app ((gi, args))) None r)
end)
in (let _151_583 = (let _151_582 = (mk_problem scope orig gi_ps (vary_rel rel variance) ti None "type subterm")
in (FStar_All.pipe_left (fun _151_581 -> FStar_TypeChecker_Common.TProb (_151_581)) _151_582))
in (T (gi_xs), _151_583)))
end)))
end
| (_69_816, _69_818, C (_69_820)) -> begin
(FStar_All.failwith "impos")
end))
in (
# 730 "FStar.TypeChecker.Rel.fst"
let rec aux = (fun scope args qs -> (match (qs) with
| [] -> begin
([], [], FStar_Syntax_Util.t_true)
end
| q::qs -> begin
(
# 734 "FStar.TypeChecker.Rel.fst"
let _69_898 = (match (q) with
| (bopt, variance, C ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Total (ti); FStar_Syntax_Syntax.tk = _69_838; FStar_Syntax_Syntax.pos = _69_836; FStar_Syntax_Syntax.vars = _69_834})) -> begin
(match ((sub_prob scope args (bopt, variance, T (ti)))) with
| (T (gi_xs), prob) -> begin
(let _151_592 = (let _151_591 = (FStar_Syntax_Syntax.mk_Total gi_xs)
in (FStar_All.pipe_left (fun _151_590 -> C (_151_590)) _151_591))
in (_151_592, (prob)::[]))
end
| _69_849 -> begin
(FStar_All.failwith "impossible")
end)
end
| (bopt, variance, C ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.GTotal (ti); FStar_Syntax_Syntax.tk = _69_857; FStar_Syntax_Syntax.pos = _69_855; FStar_Syntax_Syntax.vars = _69_853})) -> begin
(match ((sub_prob scope args (bopt, variance, T (ti)))) with
| (T (gi_xs), prob) -> begin
(let _151_595 = (let _151_594 = (FStar_Syntax_Syntax.mk_GTotal gi_xs)
in (FStar_All.pipe_left (fun _151_593 -> C (_151_593)) _151_594))
in (_151_595, (prob)::[]))
end
| _69_868 -> begin
(FStar_All.failwith "impossible")
end)
end
| (_69_870, _69_872, C ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Comp (c); FStar_Syntax_Syntax.tk = _69_878; FStar_Syntax_Syntax.pos = _69_876; FStar_Syntax_Syntax.vars = _69_874})) -> begin
(
# 748 "FStar.TypeChecker.Rel.fst"
let components = (FStar_All.pipe_right c.FStar_Syntax_Syntax.effect_args (FStar_List.map (fun t -> (None, INVARIANT, T ((Prims.fst t))))))
in (
# 749 "FStar.TypeChecker.Rel.fst"
let components = ((None, COVARIANT, T (c.FStar_Syntax_Syntax.result_typ)))::components
in (
# 750 "FStar.TypeChecker.Rel.fst"
let _69_889 = (let _151_597 = (FStar_List.map (sub_prob scope args) components)
in (FStar_All.pipe_right _151_597 FStar_List.unzip))
in (match (_69_889) with
| (tcs, sub_probs) -> begin
(
# 751 "FStar.TypeChecker.Rel.fst"
let gi_xs = (let _151_602 = (let _151_601 = (let _151_598 = (FStar_List.hd tcs)
in (FStar_All.pipe_right _151_598 un_T))
in (let _151_600 = (let _151_599 = (FStar_List.tl tcs)
in (FStar_All.pipe_right _151_599 (FStar_List.map arg_of_tc)))
in {FStar_Syntax_Syntax.effect_name = c.FStar_Syntax_Syntax.effect_name; FStar_Syntax_Syntax.result_typ = _151_601; FStar_Syntax_Syntax.effect_args = _151_600; FStar_Syntax_Syntax.flags = c.FStar_Syntax_Syntax.flags}))
in (FStar_All.pipe_left FStar_Syntax_Syntax.mk_Comp _151_602))
in (C (gi_xs), sub_probs))
end))))
end
| _69_892 -> begin
(
# 760 "FStar.TypeChecker.Rel.fst"
let _69_895 = (sub_prob scope args q)
in (match (_69_895) with
| (ktec, prob) -> begin
(ktec, (prob)::[])
end))
end)
in (match (_69_898) with
| (tc, probs) -> begin
(
# 763 "FStar.TypeChecker.Rel.fst"
let _69_911 = (match (q) with
| (Some (b), _69_902, _69_904) -> begin
(let _151_604 = (let _151_603 = (FStar_Syntax_Util.arg_of_non_null_binder b)
in (_151_603)::args)
in (Some (b), (b)::scope, _151_604))
end
| _69_907 -> begin
(None, scope, args)
end)
in (match (_69_911) with
| (bopt, scope, args) -> begin
(
# 767 "FStar.TypeChecker.Rel.fst"
let _69_915 = (aux scope args qs)
in (match (_69_915) with
| (sub_probs, tcs, f) -> begin
(
# 768 "FStar.TypeChecker.Rel.fst"
let f = (match (bopt) with
| None -> begin
(let _151_607 = (let _151_606 = (FStar_All.pipe_right probs (FStar_List.map (fun prob -> (FStar_All.pipe_right (p_guard prob) Prims.fst))))
in (f)::_151_606)
in (FStar_Syntax_Util.mk_conj_l _151_607))
end
| Some (b) -> begin
(let _151_611 = (let _151_610 = (FStar_Syntax_Util.mk_forall (Prims.fst b) f)
in (let _151_609 = (FStar_All.pipe_right probs (FStar_List.map (fun prob -> (FStar_All.pipe_right (p_guard prob) Prims.fst))))
in (_151_610)::_151_609))
in (FStar_Syntax_Util.mk_conj_l _151_611))
end)
in ((FStar_List.append probs sub_probs), (tc)::tcs, f))
end))
end))
end))
end))
in (aux scope ps qs))))))

# 783 "FStar.TypeChecker.Rel.fst"
let rec eq_tm : FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  Prims.bool = (fun t1 t2 -> (
# 784 "FStar.TypeChecker.Rel.fst"
let t1 = (FStar_Syntax_Subst.compress t1)
in (
# 785 "FStar.TypeChecker.Rel.fst"
let t2 = (FStar_Syntax_Subst.compress t2)
in (match ((t1.FStar_Syntax_Syntax.n, t2.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_name (a), FStar_Syntax_Syntax.Tm_name (b)) -> begin
(FStar_Syntax_Syntax.bv_eq a b)
end
| (FStar_Syntax_Syntax.Tm_fvar (f), FStar_Syntax_Syntax.Tm_fvar (g)) -> begin
(FStar_Syntax_Syntax.fv_eq f g)
end
| (FStar_Syntax_Syntax.Tm_constant (c), FStar_Syntax_Syntax.Tm_constant (d)) -> begin
(c = d)
end
| (FStar_Syntax_Syntax.Tm_uvar (u1, _69_943), FStar_Syntax_Syntax.Tm_uvar (u2, _69_948)) -> begin
(FStar_Unionfind.equivalent u1 u2)
end
| (FStar_Syntax_Syntax.Tm_app (h1, args1), FStar_Syntax_Syntax.Tm_app (h2, args2)) -> begin
((eq_tm h1 h2) && (eq_args args1 args2))
end
| _69_962 -> begin
false
end))))
and eq_args : FStar_Syntax_Syntax.args  ->  FStar_Syntax_Syntax.args  ->  Prims.bool = (fun a1 a2 -> (((FStar_List.length a1) = (FStar_List.length a2)) && (FStar_List.forall2 (fun _69_968 _69_972 -> (match ((_69_968, _69_972)) with
| ((a1, _69_967), (a2, _69_971)) -> begin
(eq_tm a1 a2)
end)) a1 a2)))

# 802 "FStar.TypeChecker.Rel.fst"
type flex_t =
(FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.typ * FStar_Syntax_Syntax.args)

# 803 "FStar.TypeChecker.Rel.fst"
type im_or_proj_t =
((FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.typ) * FStar_Syntax_Syntax.arg Prims.list * FStar_Syntax_Syntax.binders * ((tc Prims.list  ->  FStar_Syntax_Syntax.typ) * (FStar_Syntax_Syntax.typ  ->  Prims.bool) * (FStar_Syntax_Syntax.binder Prims.option * variance * tc) Prims.list))

# 805 "FStar.TypeChecker.Rel.fst"
let rigid_rigid : Prims.int = 0

# 806 "FStar.TypeChecker.Rel.fst"
let flex_rigid_eq : Prims.int = 1

# 807 "FStar.TypeChecker.Rel.fst"
let flex_refine_inner : Prims.int = 2

# 808 "FStar.TypeChecker.Rel.fst"
let flex_refine : Prims.int = 3

# 809 "FStar.TypeChecker.Rel.fst"
let flex_rigid : Prims.int = 4

# 810 "FStar.TypeChecker.Rel.fst"
let rigid_flex : Prims.int = 5

# 811 "FStar.TypeChecker.Rel.fst"
let refine_flex : Prims.int = 6

# 812 "FStar.TypeChecker.Rel.fst"
let flex_flex : Prims.int = 7

# 813 "FStar.TypeChecker.Rel.fst"
let compress_tprob = (fun wl p -> (
# 813 "FStar.TypeChecker.Rel.fst"
let _69_975 = p
in (let _151_633 = (whnf wl.tcenv p.FStar_TypeChecker_Common.lhs)
in (let _151_632 = (whnf wl.tcenv p.FStar_TypeChecker_Common.rhs)
in {FStar_TypeChecker_Common.pid = _69_975.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _151_633; FStar_TypeChecker_Common.relation = _69_975.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _151_632; FStar_TypeChecker_Common.element = _69_975.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_975.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_975.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_975.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_975.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_975.FStar_TypeChecker_Common.rank}))))

# 815 "FStar.TypeChecker.Rel.fst"
let compress_prob : worklist  ->  FStar_TypeChecker_Common.prob  ->  FStar_TypeChecker_Common.prob = (fun wl p -> (match (p) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(let _151_639 = (compress_tprob wl p)
in (FStar_All.pipe_right _151_639 (fun _151_638 -> FStar_TypeChecker_Common.TProb (_151_638))))
end
| FStar_TypeChecker_Common.CProb (_69_982) -> begin
p
end))

# 820 "FStar.TypeChecker.Rel.fst"
let rank : worklist  ->  FStar_TypeChecker_Common.prob  ->  (Prims.int * FStar_TypeChecker_Common.prob) = (fun wl pr -> (
# 823 "FStar.TypeChecker.Rel.fst"
let prob = (let _151_644 = (compress_prob wl pr)
in (FStar_All.pipe_right _151_644 maybe_invert_p))
in (match (prob) with
| FStar_TypeChecker_Common.TProb (tp) -> begin
(
# 826 "FStar.TypeChecker.Rel.fst"
let _69_992 = (FStar_Syntax_Util.head_and_args tp.FStar_TypeChecker_Common.lhs)
in (match (_69_992) with
| (lh, _69_991) -> begin
(
# 827 "FStar.TypeChecker.Rel.fst"
let _69_996 = (FStar_Syntax_Util.head_and_args tp.FStar_TypeChecker_Common.rhs)
in (match (_69_996) with
| (rh, _69_995) -> begin
(
# 828 "FStar.TypeChecker.Rel.fst"
let _69_1052 = (match ((lh.FStar_Syntax_Syntax.n, rh.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_uvar (_69_998), FStar_Syntax_Syntax.Tm_uvar (_69_1001)) -> begin
(flex_flex, tp)
end
| ((FStar_Syntax_Syntax.Tm_uvar (_), _)) | ((_, FStar_Syntax_Syntax.Tm_uvar (_))) when (tp.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) -> begin
(flex_rigid_eq, tp)
end
| (FStar_Syntax_Syntax.Tm_uvar (_69_1017), _69_1020) -> begin
(
# 835 "FStar.TypeChecker.Rel.fst"
let _69_1024 = (base_and_refinement wl.tcenv wl tp.FStar_TypeChecker_Common.rhs)
in (match (_69_1024) with
| (b, ref_opt) -> begin
(match (ref_opt) with
| None -> begin
(flex_rigid, tp)
end
| _69_1027 -> begin
(
# 839 "FStar.TypeChecker.Rel.fst"
let rank = if (is_top_level_prob prob) then begin
flex_refine
end else begin
flex_refine_inner
end
in (let _151_646 = (
# 843 "FStar.TypeChecker.Rel.fst"
let _69_1029 = tp
in (let _151_645 = (force_refinement (b, ref_opt))
in {FStar_TypeChecker_Common.pid = _69_1029.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _69_1029.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = _69_1029.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _151_645; FStar_TypeChecker_Common.element = _69_1029.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_1029.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_1029.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_1029.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_1029.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_1029.FStar_TypeChecker_Common.rank}))
in (rank, _151_646)))
end)
end))
end
| (_69_1032, FStar_Syntax_Syntax.Tm_uvar (_69_1034)) -> begin
(
# 847 "FStar.TypeChecker.Rel.fst"
let _69_1039 = (base_and_refinement wl.tcenv wl tp.FStar_TypeChecker_Common.lhs)
in (match (_69_1039) with
| (b, ref_opt) -> begin
(match (ref_opt) with
| None -> begin
(rigid_flex, tp)
end
| _69_1042 -> begin
(let _151_648 = (
# 850 "FStar.TypeChecker.Rel.fst"
let _69_1043 = tp
in (let _151_647 = (force_refinement (b, ref_opt))
in {FStar_TypeChecker_Common.pid = _69_1043.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _151_647; FStar_TypeChecker_Common.relation = _69_1043.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _69_1043.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _69_1043.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_1043.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_1043.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_1043.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_1043.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_1043.FStar_TypeChecker_Common.rank}))
in (refine_flex, _151_648))
end)
end))
end
| (_69_1046, _69_1048) -> begin
(rigid_rigid, tp)
end)
in (match (_69_1052) with
| (rank, tp) -> begin
(let _151_650 = (FStar_All.pipe_right (
# 855 "FStar.TypeChecker.Rel.fst"
let _69_1053 = tp
in {FStar_TypeChecker_Common.pid = _69_1053.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _69_1053.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = _69_1053.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _69_1053.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _69_1053.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_1053.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_1053.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_1053.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_1053.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = Some (rank)}) (fun _151_649 -> FStar_TypeChecker_Common.TProb (_151_649)))
in (rank, _151_650))
end))
end))
end))
end
| FStar_TypeChecker_Common.CProb (cp) -> begin
(let _151_652 = (FStar_All.pipe_right (
# 857 "FStar.TypeChecker.Rel.fst"
let _69_1057 = cp
in {FStar_TypeChecker_Common.pid = _69_1057.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _69_1057.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = _69_1057.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _69_1057.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _69_1057.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_1057.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_1057.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_1057.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_1057.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = Some (rigid_rigid)}) (fun _151_651 -> FStar_TypeChecker_Common.CProb (_151_651)))
in (rigid_rigid, _151_652))
end)))

# 859 "FStar.TypeChecker.Rel.fst"
let next_prob : worklist  ->  (FStar_TypeChecker_Common.prob Prims.option * FStar_TypeChecker_Common.prob Prims.list * Prims.int) = (fun wl -> (
# 863 "FStar.TypeChecker.Rel.fst"
let rec aux = (fun _69_1064 probs -> (match (_69_1064) with
| (min_rank, min, out) -> begin
(match (probs) with
| [] -> begin
(min, out, min_rank)
end
| hd::tl -> begin
(
# 866 "FStar.TypeChecker.Rel.fst"
let _69_1072 = (rank wl hd)
in (match (_69_1072) with
| (rank, hd) -> begin
if (rank <= flex_rigid_eq) then begin
(match (min) with
| None -> begin
(Some (hd), (FStar_List.append out tl), rank)
end
| Some (m) -> begin
(Some (hd), (FStar_List.append out ((m)::tl)), rank)
end)
end else begin
if (rank < min_rank) then begin
(match (min) with
| None -> begin
(aux (rank, Some (hd), out) tl)
end
| Some (m) -> begin
(aux (rank, Some (hd), (m)::out) tl)
end)
end else begin
(aux (min_rank, min, (hd)::out) tl)
end
end
end))
end)
end))
in (aux ((flex_flex + 1), None, []) wl.attempting)))

# 879 "FStar.TypeChecker.Rel.fst"
let is_flex_rigid : Prims.int  ->  Prims.bool = (fun rank -> ((flex_refine_inner <= rank) && (rank <= flex_rigid)))

# 881 "FStar.TypeChecker.Rel.fst"
type univ_eq_sol =
| UDeferred of worklist
| USolved of worklist
| UFailed of Prims.string

# 882 "FStar.TypeChecker.Rel.fst"
let is_UDeferred = (fun _discr_ -> (match (_discr_) with
| UDeferred (_) -> begin
true
end
| _ -> begin
false
end))

# 883 "FStar.TypeChecker.Rel.fst"
let is_USolved = (fun _discr_ -> (match (_discr_) with
| USolved (_) -> begin
true
end
| _ -> begin
false
end))

# 884 "FStar.TypeChecker.Rel.fst"
let is_UFailed = (fun _discr_ -> (match (_discr_) with
| UFailed (_) -> begin
true
end
| _ -> begin
false
end))

# 882 "FStar.TypeChecker.Rel.fst"
let ___UDeferred____0 : univ_eq_sol  ->  worklist = (fun projectee -> (match (projectee) with
| UDeferred (_69_1082) -> begin
_69_1082
end))

# 883 "FStar.TypeChecker.Rel.fst"
let ___USolved____0 : univ_eq_sol  ->  worklist = (fun projectee -> (match (projectee) with
| USolved (_69_1085) -> begin
_69_1085
end))

# 884 "FStar.TypeChecker.Rel.fst"
let ___UFailed____0 : univ_eq_sol  ->  Prims.string = (fun projectee -> (match (projectee) with
| UFailed (_69_1088) -> begin
_69_1088
end))

# 886 "FStar.TypeChecker.Rel.fst"
let rec solve_universe_eq : Prims.int  ->  worklist  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe  ->  univ_eq_sol = (fun orig wl u1 u2 -> (
# 887 "FStar.TypeChecker.Rel.fst"
let u1 = (FStar_TypeChecker_Normalize.normalize_universe wl.tcenv u1)
in (
# 888 "FStar.TypeChecker.Rel.fst"
let u2 = (FStar_TypeChecker_Normalize.normalize_universe wl.tcenv u2)
in (
# 889 "FStar.TypeChecker.Rel.fst"
let rec occurs_univ = (fun v1 u -> (match (u) with
| FStar_Syntax_Syntax.U_max (us) -> begin
(FStar_All.pipe_right us (FStar_Util.for_some (fun u -> (
# 892 "FStar.TypeChecker.Rel.fst"
let _69_1104 = (FStar_Syntax_Util.univ_kernel u)
in (match (_69_1104) with
| (k, _69_1103) -> begin
(match (k) with
| FStar_Syntax_Syntax.U_unif (v2) -> begin
(FStar_Unionfind.equivalent v1 v2)
end
| _69_1108 -> begin
false
end)
end)))))
end
| _69_1110 -> begin
(occurs_univ v1 (FStar_Syntax_Syntax.U_max ((u)::[])))
end))
in (
# 898 "FStar.TypeChecker.Rel.fst"
let try_umax_components = (fun u1 u2 msg -> (match ((u1, u2)) with
| (FStar_Syntax_Syntax.U_max (_69_1116), FStar_Syntax_Syntax.U_max (_69_1119)) -> begin
(let _151_724 = (let _151_723 = (FStar_Syntax_Print.univ_to_string u1)
in (let _151_722 = (FStar_Syntax_Print.univ_to_string u2)
in (FStar_Util.format2 "Unable to unify universes: %s and %s" _151_723 _151_722)))
in UFailed (_151_724))
end
| ((FStar_Syntax_Syntax.U_max (us), u')) | ((u', FStar_Syntax_Syntax.U_max (us))) -> begin
(
# 905 "FStar.TypeChecker.Rel.fst"
let rec aux = (fun wl us -> (match (us) with
| [] -> begin
USolved (wl)
end
| u::us -> begin
(match ((solve_universe_eq orig wl u u')) with
| USolved (wl) -> begin
(aux wl us)
end
| failed -> begin
failed
end)
end))
in (aux wl us))
end
| _69_1139 -> begin
(let _151_731 = (let _151_730 = (FStar_Syntax_Print.univ_to_string u1)
in (let _151_729 = (FStar_Syntax_Print.univ_to_string u2)
in (FStar_Util.format3 "Unable to unify universes: %s and %s (%s)" _151_730 _151_729 msg)))
in UFailed (_151_731))
end))
in (match ((u1, u2)) with
| ((FStar_Syntax_Syntax.U_bvar (_), _)) | ((FStar_Syntax_Syntax.U_unknown, _)) | ((_, FStar_Syntax_Syntax.U_bvar (_))) | ((_, FStar_Syntax_Syntax.U_unknown)) -> begin
(FStar_All.failwith "Impossible: locally nameless")
end
| (FStar_Syntax_Syntax.U_unif (v1), FStar_Syntax_Syntax.U_unif (v2)) -> begin
if (FStar_Unionfind.equivalent v1 v2) then begin
USolved (wl)
end else begin
(
# 926 "FStar.TypeChecker.Rel.fst"
let wl = (extend_solution orig ((UNIV ((v1, u2)))::[]) wl)
in USolved (wl))
end
end
| ((FStar_Syntax_Syntax.U_unif (v1), u)) | ((u, FStar_Syntax_Syntax.U_unif (v1))) -> begin
(
# 931 "FStar.TypeChecker.Rel.fst"
let u = (norm_univ wl u)
in if (occurs_univ v1 u) then begin
(let _151_734 = (let _151_733 = (FStar_Syntax_Print.univ_to_string (FStar_Syntax_Syntax.U_unif (v1)))
in (let _151_732 = (FStar_Syntax_Print.univ_to_string u)
in (FStar_Util.format2 "Failed occurs check: %s occurs in %s" _151_733 _151_732)))
in (try_umax_components u1 u2 _151_734))
end else begin
(let _151_735 = (extend_solution orig ((UNIV ((v1, u)))::[]) wl)
in USolved (_151_735))
end)
end
| (FStar_Syntax_Syntax.U_zero, FStar_Syntax_Syntax.U_zero) -> begin
USolved (wl)
end
| (FStar_Syntax_Syntax.U_succ (u1), FStar_Syntax_Syntax.U_succ (u2)) -> begin
(solve_universe_eq orig wl u1 u2)
end
| ((FStar_Syntax_Syntax.U_succ (_), _)) | ((FStar_Syntax_Syntax.U_zero, _)) | ((_, FStar_Syntax_Syntax.U_succ (_))) | ((_, FStar_Syntax_Syntax.U_zero)) -> begin
UFailed ("Incompatible universes")
end
| (FStar_Syntax_Syntax.U_name (x), FStar_Syntax_Syntax.U_name (y)) when (x.FStar_Ident.idText = y.FStar_Ident.idText) -> begin
USolved (wl)
end
| ((FStar_Syntax_Syntax.U_max (_), _)) | ((_, FStar_Syntax_Syntax.U_max (_))) -> begin
if wl.defer_ok then begin
UDeferred (wl)
end else begin
(
# 956 "FStar.TypeChecker.Rel.fst"
let u1 = (norm_univ wl u1)
in (
# 957 "FStar.TypeChecker.Rel.fst"
let u2 = (norm_univ wl u2)
in if (FStar_Syntax_Util.eq_univs u1 u2) then begin
USolved (wl)
end else begin
(try_umax_components u1 u2 "")
end))
end
end
| ((FStar_Syntax_Syntax.U_name (_), _)) | ((_, FStar_Syntax_Syntax.U_name (_))) -> begin
UFailed ("Incompatible universes")
end))))))

# 969 "FStar.TypeChecker.Rel.fst"
let rec solve : FStar_TypeChecker_Env.env  ->  worklist  ->  solution = (fun env probs -> (
# 971 "FStar.TypeChecker.Rel.fst"
let _69_1234 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(let _151_778 = (wl_to_string probs)
in (FStar_Util.print1 "solve:\n\t%s\n" _151_778))
end else begin
()
end
in (match ((next_prob probs)) with
| (Some (hd), tl, rank) -> begin
(
# 975 "FStar.TypeChecker.Rel.fst"
let probs = (
# 975 "FStar.TypeChecker.Rel.fst"
let _69_1241 = probs
in {attempting = tl; wl_deferred = _69_1241.wl_deferred; ctr = _69_1241.ctr; defer_ok = _69_1241.defer_ok; smt_ok = _69_1241.smt_ok; tcenv = _69_1241.tcenv})
in (match (hd) with
| FStar_TypeChecker_Common.CProb (cp) -> begin
(solve_c env (maybe_invert cp) probs)
end
| FStar_TypeChecker_Common.TProb (tp) -> begin
if (((not (probs.defer_ok)) && (flex_refine_inner <= rank)) && (rank <= flex_rigid)) then begin
(match ((solve_flex_rigid_join env tp probs)) with
| None -> begin
(solve_t' env (maybe_invert tp) probs)
end
| Some (wl) -> begin
(solve env wl)
end)
end else begin
(solve_t' env (maybe_invert tp) probs)
end
end))
end
| (None, _69_1253, _69_1255) -> begin
(match (probs.wl_deferred) with
| [] -> begin
Success ([])
end
| _69_1259 -> begin
(
# 997 "FStar.TypeChecker.Rel.fst"
let _69_1268 = (FStar_All.pipe_right probs.wl_deferred (FStar_List.partition (fun _69_1265 -> (match (_69_1265) with
| (c, _69_1262, _69_1264) -> begin
(c < probs.ctr)
end))))
in (match (_69_1268) with
| (attempt, rest) -> begin
(match (attempt) with
| [] -> begin
(let _151_781 = (FStar_List.map (fun _69_1274 -> (match (_69_1274) with
| (_69_1271, x, y) -> begin
(x, y)
end)) probs.wl_deferred)
in Success (_151_781))
end
| _69_1276 -> begin
(let _151_784 = (
# 1003 "FStar.TypeChecker.Rel.fst"
let _69_1277 = probs
in (let _151_783 = (FStar_All.pipe_right attempt (FStar_List.map (fun _69_1284 -> (match (_69_1284) with
| (_69_1280, _69_1282, y) -> begin
y
end))))
in {attempting = _151_783; wl_deferred = rest; ctr = _69_1277.ctr; defer_ok = _69_1277.defer_ok; smt_ok = _69_1277.smt_ok; tcenv = _69_1277.tcenv}))
in (solve env _151_784))
end)
end))
end)
end)))
and solve_one_universe_eq : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe  ->  worklist  ->  solution = (fun env orig u1 u2 wl -> (match ((solve_universe_eq (p_pid orig) wl u1 u2)) with
| USolved (wl) -> begin
(let _151_790 = (solve_prob orig None [] wl)
in (solve env _151_790))
end
| UFailed (msg) -> begin
(giveup env msg orig)
end
| UDeferred (wl) -> begin
(solve env (defer "" orig wl))
end))
and solve_maybe_uinsts : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.term  ->  worklist  ->  univ_eq_sol = (fun env orig t1 t2 wl -> (
# 1017 "FStar.TypeChecker.Rel.fst"
let rec aux = (fun wl us1 us2 -> (match ((us1, us2)) with
| ([], []) -> begin
USolved (wl)
end
| (u1::us1, u2::us2) -> begin
(match ((solve_universe_eq (p_pid orig) wl u1 u2)) with
| USolved (wl) -> begin
(aux wl us1 us2)
end
| failed_or_deferred -> begin
failed_or_deferred
end)
end
| _69_1319 -> begin
UFailed ("Unequal number of universes")
end))
in (match ((let _151_805 = (let _151_802 = (whnf env t1)
in _151_802.FStar_Syntax_Syntax.n)
in (let _151_804 = (let _151_803 = (whnf env t2)
in _151_803.FStar_Syntax_Syntax.n)
in (_151_805, _151_804)))) with
| (FStar_Syntax_Syntax.Tm_uinst ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (f); FStar_Syntax_Syntax.tk = _69_1325; FStar_Syntax_Syntax.pos = _69_1323; FStar_Syntax_Syntax.vars = _69_1321}, us1), FStar_Syntax_Syntax.Tm_uinst ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar (g); FStar_Syntax_Syntax.tk = _69_1337; FStar_Syntax_Syntax.pos = _69_1335; FStar_Syntax_Syntax.vars = _69_1333}, us2)) -> begin
(
# 1032 "FStar.TypeChecker.Rel.fst"
let b = (FStar_Syntax_Syntax.fv_eq f g)
in (
# 1033 "FStar.TypeChecker.Rel.fst"
let _69_1346 = ()
in (aux wl us1 us2)))
end
| ((FStar_Syntax_Syntax.Tm_uinst (_), _)) | ((_, FStar_Syntax_Syntax.Tm_uinst (_))) -> begin
(FStar_All.failwith "Impossible: expect head symbols to match")
end
| _69_1361 -> begin
USolved (wl)
end)))
and giveup_or_defer : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  worklist  ->  Prims.string  ->  solution = (fun env orig wl msg -> if wl.defer_ok then begin
(
# 1046 "FStar.TypeChecker.Rel.fst"
let _69_1366 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_810 = (prob_to_string env orig)
in (FStar_Util.print2 "\n\t\tDeferring %s\n\t\tBecause %s\n" _151_810 msg))
end else begin
()
end
in (solve env (defer msg orig wl)))
end else begin
(giveup env msg orig)
end)
and solve_flex_rigid_join : FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.typ, FStar_Syntax_Syntax.term) FStar_TypeChecker_Common.problem  ->  worklist  ->  worklist Prims.option = (fun env tp wl -> (
# 1056 "FStar.TypeChecker.Rel.fst"
let _69_1371 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(let _151_814 = (FStar_Util.string_of_int tp.FStar_TypeChecker_Common.pid)
in (FStar_Util.print1 "Trying to solve by joining refinements:%s\n" _151_814))
end else begin
()
end
in (
# 1058 "FStar.TypeChecker.Rel.fst"
let _69_1375 = (FStar_Syntax_Util.head_and_args tp.FStar_TypeChecker_Common.lhs)
in (match (_69_1375) with
| (u, args) -> begin
(
# 1059 "FStar.TypeChecker.Rel.fst"
let _69_1381 = (0, 1, 2, 3, 4)
in (match (_69_1381) with
| (ok, head_match, partial_match, fallback, failed_match) -> begin
(
# 1060 "FStar.TypeChecker.Rel.fst"
let max = (fun i j -> if (i < j) then begin
j
end else begin
i
end)
in (
# 1062 "FStar.TypeChecker.Rel.fst"
let base_types_match = (fun t1 t2 -> (
# 1063 "FStar.TypeChecker.Rel.fst"
let _69_1390 = (FStar_Syntax_Util.head_and_args t1)
in (match (_69_1390) with
| (h1, args1) -> begin
(
# 1064 "FStar.TypeChecker.Rel.fst"
let _69_1394 = (FStar_Syntax_Util.head_and_args t2)
in (match (_69_1394) with
| (h2, _69_1393) -> begin
(match ((h1.FStar_Syntax_Syntax.n, h2.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_fvar (tc1), FStar_Syntax_Syntax.Tm_fvar (tc2)) -> begin
if (FStar_Syntax_Syntax.fv_eq tc1 tc2) then begin
if ((FStar_List.length args1) = 0) then begin
Some ([])
end else begin
(let _151_826 = (let _151_825 = (let _151_824 = (new_problem env t1 FStar_TypeChecker_Common.EQ t2 None t1.FStar_Syntax_Syntax.pos "joining refinements")
in (FStar_All.pipe_left (fun _151_823 -> FStar_TypeChecker_Common.TProb (_151_823)) _151_824))
in (_151_825)::[])
in Some (_151_826))
end
end else begin
None
end
end
| (FStar_Syntax_Syntax.Tm_name (a), FStar_Syntax_Syntax.Tm_name (b)) -> begin
if (FStar_Syntax_Syntax.bv_eq a b) then begin
Some ([])
end else begin
None
end
end
| _69_1406 -> begin
None
end)
end))
end)))
in (
# 1080 "FStar.TypeChecker.Rel.fst"
let conjoin = (fun t1 t2 -> (match ((t1.FStar_Syntax_Syntax.n, t2.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.Tm_refine (x, phi1), FStar_Syntax_Syntax.Tm_refine (y, phi2)) -> begin
(
# 1082 "FStar.TypeChecker.Rel.fst"
let m = (base_types_match x.FStar_Syntax_Syntax.sort y.FStar_Syntax_Syntax.sort)
in (match (m) with
| None -> begin
None
end
| Some (m) -> begin
(
# 1086 "FStar.TypeChecker.Rel.fst"
let x = (FStar_Syntax_Syntax.freshen_bv x)
in (
# 1087 "FStar.TypeChecker.Rel.fst"
let subst = (let _151_833 = (let _151_832 = (let _151_831 = (FStar_Syntax_Syntax.bv_to_name x)
in (0, _151_831))
in FStar_Syntax_Syntax.DB (_151_832))
in (_151_833)::[])
in (
# 1088 "FStar.TypeChecker.Rel.fst"
let phi1 = (FStar_Syntax_Subst.subst subst phi1)
in (
# 1089 "FStar.TypeChecker.Rel.fst"
let phi2 = (FStar_Syntax_Subst.subst subst phi2)
in (let _151_836 = (let _151_835 = (let _151_834 = (FStar_Syntax_Util.mk_conj phi1 phi2)
in (FStar_Syntax_Util.refine x _151_834))
in (_151_835, m))
in Some (_151_836))))))
end))
end
| (_69_1428, FStar_Syntax_Syntax.Tm_refine (y, _69_1431)) -> begin
(
# 1094 "FStar.TypeChecker.Rel.fst"
let m = (base_types_match t1 y.FStar_Syntax_Syntax.sort)
in (match (m) with
| None -> begin
None
end
| Some (m) -> begin
Some ((t2, m))
end))
end
| (FStar_Syntax_Syntax.Tm_refine (x, _69_1441), _69_1445) -> begin
(
# 1101 "FStar.TypeChecker.Rel.fst"
let m = (base_types_match x.FStar_Syntax_Syntax.sort t2)
in (match (m) with
| None -> begin
None
end
| Some (m) -> begin
Some ((t1, m))
end))
end
| _69_1452 -> begin
(
# 1108 "FStar.TypeChecker.Rel.fst"
let m = (base_types_match t1 t2)
in (match (m) with
| None -> begin
None
end
| Some (m) -> begin
Some ((t1, m))
end))
end))
in (
# 1114 "FStar.TypeChecker.Rel.fst"
let tt = u
in (match (tt.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_uvar (uv, _69_1460) -> begin
(
# 1118 "FStar.TypeChecker.Rel.fst"
let _69_1485 = (FStar_All.pipe_right wl.attempting (FStar_List.partition (fun _69_23 -> (match (_69_23) with
| FStar_TypeChecker_Common.TProb (tp) -> begin
(match (tp.FStar_TypeChecker_Common.rank) with
| Some (rank) when (is_flex_rigid rank) -> begin
(
# 1122 "FStar.TypeChecker.Rel.fst"
let _69_1471 = (FStar_Syntax_Util.head_and_args tp.FStar_TypeChecker_Common.lhs)
in (match (_69_1471) with
| (u', _69_1470) -> begin
(match ((let _151_838 = (whnf env u')
in _151_838.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_uvar (uv', _69_1474) -> begin
(FStar_Unionfind.equivalent uv uv')
end
| _69_1478 -> begin
false
end)
end))
end
| _69_1480 -> begin
false
end)
end
| _69_1482 -> begin
false
end))))
in (match (_69_1485) with
| (upper_bounds, rest) -> begin
(
# 1131 "FStar.TypeChecker.Rel.fst"
let rec make_upper_bound = (fun _69_1489 tps -> (match (_69_1489) with
| (bound, sub_probs) -> begin
(match (tps) with
| [] -> begin
Some ((bound, sub_probs))
end
| FStar_TypeChecker_Common.TProb (hd)::tl -> begin
(match ((let _151_843 = (whnf env hd.FStar_TypeChecker_Common.rhs)
in (conjoin bound _151_843))) with
| Some (bound, sub) -> begin
(make_upper_bound (bound, (FStar_List.append sub sub_probs)) tl)
end
| None -> begin
None
end)
end
| _69_1502 -> begin
None
end)
end))
in (match ((let _151_845 = (let _151_844 = (whnf env tp.FStar_TypeChecker_Common.rhs)
in (_151_844, []))
in (make_upper_bound _151_845 upper_bounds))) with
| None -> begin
(
# 1142 "FStar.TypeChecker.Rel.fst"
let _69_1504 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(FStar_Util.print_string "No upper bounds\n")
end else begin
()
end
in None)
end
| Some (rhs_bound, sub_probs) -> begin
(
# 1155 "FStar.TypeChecker.Rel.fst"
let eq_prob = (new_problem env tp.FStar_TypeChecker_Common.lhs FStar_TypeChecker_Common.EQ rhs_bound None tp.FStar_TypeChecker_Common.loc "joining refinements")
in (
# 1156 "FStar.TypeChecker.Rel.fst"
let _69_1514 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(
# 1157 "FStar.TypeChecker.Rel.fst"
let wl' = (
# 1157 "FStar.TypeChecker.Rel.fst"
let _69_1511 = wl
in {attempting = (FStar_TypeChecker_Common.TProb (eq_prob))::sub_probs; wl_deferred = _69_1511.wl_deferred; ctr = _69_1511.ctr; defer_ok = _69_1511.defer_ok; smt_ok = _69_1511.smt_ok; tcenv = _69_1511.tcenv})
in (let _151_846 = (wl_to_string wl')
in (FStar_Util.print1 "After joining refinements: %s\n" _151_846)))
end else begin
()
end
in (match ((solve_t env eq_prob (
# 1159 "FStar.TypeChecker.Rel.fst"
let _69_1516 = wl
in {attempting = sub_probs; wl_deferred = _69_1516.wl_deferred; ctr = _69_1516.ctr; defer_ok = _69_1516.defer_ok; smt_ok = _69_1516.smt_ok; tcenv = _69_1516.tcenv}))) with
| Success (_69_1519) -> begin
(
# 1161 "FStar.TypeChecker.Rel.fst"
let wl = (
# 1161 "FStar.TypeChecker.Rel.fst"
let _69_1521 = wl
in {attempting = rest; wl_deferred = _69_1521.wl_deferred; ctr = _69_1521.ctr; defer_ok = _69_1521.defer_ok; smt_ok = _69_1521.smt_ok; tcenv = _69_1521.tcenv})
in (
# 1162 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob' false (FStar_TypeChecker_Common.TProb (tp)) None [] wl)
in (
# 1163 "FStar.TypeChecker.Rel.fst"
let _69_1527 = (FStar_List.fold_left (fun wl p -> (solve_prob' true p None [] wl)) wl upper_bounds)
in Some (wl))))
end
| _69_1530 -> begin
None
end)))
end))
end))
end
| _69_1532 -> begin
(FStar_All.failwith "Impossible: Not a flex-rigid")
end)))))
end))
end))))
and solve_binders : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.binders  ->  FStar_Syntax_Syntax.binders  ->  FStar_TypeChecker_Common.prob  ->  worklist  ->  (FStar_Syntax_Syntax.binders  ->  FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.subst_elt Prims.list  ->  FStar_TypeChecker_Common.prob)  ->  solution = (fun env bs1 bs2 orig wl rhs -> (
# 1173 "FStar.TypeChecker.Rel.fst"
let rec aux = (fun scope env subst xs ys -> (match ((xs, ys)) with
| ([], []) -> begin
(
# 1176 "FStar.TypeChecker.Rel.fst"
let rhs_prob = (rhs (FStar_List.rev scope) env subst)
in (
# 1177 "FStar.TypeChecker.Rel.fst"
let _69_1549 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_874 = (prob_to_string env rhs_prob)
in (FStar_Util.print1 "rhs_prob = %s\n" _151_874))
end else begin
()
end
in (
# 1179 "FStar.TypeChecker.Rel.fst"
let formula = (FStar_All.pipe_right (p_guard rhs_prob) Prims.fst)
in FStar_Util.Inl (((rhs_prob)::[], formula)))))
end
| ((hd1, imp)::xs, (hd2, imp')::ys) when (imp = imp') -> begin
(
# 1183 "FStar.TypeChecker.Rel.fst"
let hd1 = (
# 1183 "FStar.TypeChecker.Rel.fst"
let _69_1563 = hd1
in (let _151_875 = (FStar_Syntax_Subst.subst subst hd1.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _69_1563.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _69_1563.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _151_875}))
in (
# 1184 "FStar.TypeChecker.Rel.fst"
let hd2 = (
# 1184 "FStar.TypeChecker.Rel.fst"
let _69_1566 = hd2
in (let _151_876 = (FStar_Syntax_Subst.subst subst hd2.FStar_Syntax_Syntax.sort)
in {FStar_Syntax_Syntax.ppname = _69_1566.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _69_1566.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = _151_876}))
in (
# 1185 "FStar.TypeChecker.Rel.fst"
let prob = (let _151_879 = (let _151_878 = (FStar_All.pipe_left invert_rel (p_rel orig))
in (mk_problem scope orig hd1.FStar_Syntax_Syntax.sort _151_878 hd2.FStar_Syntax_Syntax.sort None "Formal parameter"))
in (FStar_All.pipe_left (fun _151_877 -> FStar_TypeChecker_Common.TProb (_151_877)) _151_879))
in (
# 1186 "FStar.TypeChecker.Rel.fst"
let hd1 = (FStar_Syntax_Syntax.freshen_bv hd1)
in (
# 1187 "FStar.TypeChecker.Rel.fst"
let subst = (let _151_883 = (let _151_881 = (let _151_880 = (FStar_Syntax_Syntax.bv_to_name hd1)
in (0, _151_880))
in FStar_Syntax_Syntax.DB (_151_881))
in (let _151_882 = (FStar_Syntax_Subst.shift_subst 1 subst)
in (_151_883)::_151_882))
in (
# 1188 "FStar.TypeChecker.Rel.fst"
let env = (FStar_TypeChecker_Env.push_bv env hd1)
in (match ((aux (((hd1, imp))::scope) env subst xs ys)) with
| FStar_Util.Inl (sub_probs, phi) -> begin
(
# 1191 "FStar.TypeChecker.Rel.fst"
let phi = (let _151_885 = (FStar_All.pipe_right (p_guard prob) Prims.fst)
in (let _151_884 = (FStar_Syntax_Util.close_forall (((hd1, imp))::[]) phi)
in (FStar_Syntax_Util.mk_conj _151_885 _151_884)))
in (
# 1192 "FStar.TypeChecker.Rel.fst"
let _69_1578 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_887 = (FStar_Syntax_Print.term_to_string phi)
in (let _151_886 = (FStar_Syntax_Print.bv_to_string hd1)
in (FStar_Util.print2 "Formula is %s\n\thd1=%s\n" _151_887 _151_886)))
end else begin
()
end
in FStar_Util.Inl (((prob)::sub_probs, phi))))
end
| fail -> begin
fail
end)))))))
end
| _69_1582 -> begin
FStar_Util.Inr ("arity mismatch")
end))
in (
# 1201 "FStar.TypeChecker.Rel.fst"
let scope = (p_scope orig)
in (match ((aux scope env [] bs1 bs2)) with
| FStar_Util.Inr (msg) -> begin
(giveup env msg orig)
end
| FStar_Util.Inl (sub_probs, phi) -> begin
(
# 1205 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob orig (Some (phi)) [] wl)
in (solve env (attempt sub_probs wl)))
end))))
and solve_t : FStar_TypeChecker_Env.env  ->  tprob  ->  worklist  ->  solution = (fun env problem wl -> (let _151_891 = (compress_tprob wl problem)
in (solve_t' env _151_891 wl)))
and solve_t' : FStar_TypeChecker_Env.env  ->  tprob  ->  worklist  ->  solution = (fun env problem wl -> (
# 1212 "FStar.TypeChecker.Rel.fst"
let giveup_or_defer = (fun orig msg -> (giveup_or_defer env orig wl msg))
in (
# 1215 "FStar.TypeChecker.Rel.fst"
let rigid_rigid_delta = (fun env orig wl head1 head2 t1 t2 -> (
# 1216 "FStar.TypeChecker.Rel.fst"
let _69_1610 = (head_matches_delta env wl t1 t2)
in (match (_69_1610) with
| (m, o) -> begin
(match ((m, o)) with
| (MisMatch, _69_1613) -> begin
(
# 1219 "FStar.TypeChecker.Rel.fst"
let may_relate = (fun head -> (match (head.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_name (_69_1618) -> begin
true
end
| FStar_Syntax_Syntax.Tm_fvar (tc, _69_1622) -> begin
(FStar_TypeChecker_Env.is_projector env tc.FStar_Syntax_Syntax.v)
end
| _69_1626 -> begin
false
end))
in if (((may_relate head1) || (may_relate head2)) && wl.smt_ok) then begin
(
# 1224 "FStar.TypeChecker.Rel.fst"
let guard = if (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) then begin
(FStar_Syntax_Util.mk_eq FStar_Syntax_Syntax.tun FStar_Syntax_Syntax.tun t1 t2)
end else begin
(
# 1227 "FStar.TypeChecker.Rel.fst"
let has_type_guard = (fun t1 t2 -> (match (problem.FStar_TypeChecker_Common.element) with
| Some (t) -> begin
(FStar_Syntax_Util.mk_has_type t1 t t2)
end
| None -> begin
(
# 1231 "FStar.TypeChecker.Rel.fst"
let x = (FStar_Syntax_Syntax.new_bv None t1)
in (let _151_920 = (let _151_919 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_Syntax_Util.mk_has_type t1 _151_919 t2))
in (FStar_Syntax_Util.mk_forall x _151_920)))
end))
in if (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.SUB) then begin
(has_type_guard t1 t2)
end else begin
(has_type_guard t2 t1)
end)
end
in (let _151_921 = (solve_prob orig (Some (guard)) [] wl)
in (solve env _151_921)))
end else begin
(giveup env "head mismatch" orig)
end)
end
| (_69_1636, Some (t1, t2)) -> begin
(solve_t env (
# 1240 "FStar.TypeChecker.Rel.fst"
let _69_1642 = problem
in {FStar_TypeChecker_Common.pid = _69_1642.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = t1; FStar_TypeChecker_Common.relation = _69_1642.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = t2; FStar_TypeChecker_Common.element = _69_1642.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_1642.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_1642.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_1642.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_1642.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_1642.FStar_TypeChecker_Common.rank}) wl)
end
| (_69_1645, None) -> begin
(
# 1243 "FStar.TypeChecker.Rel.fst"
let _69_1648 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_925 = (FStar_Syntax_Print.term_to_string t1)
in (let _151_924 = (FStar_Syntax_Print.tag_of_term t1)
in (let _151_923 = (FStar_Syntax_Print.term_to_string t2)
in (let _151_922 = (FStar_Syntax_Print.tag_of_term t2)
in (FStar_Util.print4 "Head matches: %s (%s) and %s (%s)\n" _151_925 _151_924 _151_923 _151_922)))))
end else begin
()
end
in (
# 1247 "FStar.TypeChecker.Rel.fst"
let _69_1652 = (FStar_Syntax_Util.head_and_args t1)
in (match (_69_1652) with
| (head, args) -> begin
(
# 1248 "FStar.TypeChecker.Rel.fst"
let _69_1655 = (FStar_Syntax_Util.head_and_args t2)
in (match (_69_1655) with
| (head', args') -> begin
(
# 1249 "FStar.TypeChecker.Rel.fst"
let nargs = (FStar_List.length args)
in if (nargs <> (FStar_List.length args')) then begin
(let _151_930 = (let _151_929 = (FStar_Syntax_Print.term_to_string head)
in (let _151_928 = (args_to_string args)
in (let _151_927 = (FStar_Syntax_Print.term_to_string head')
in (let _151_926 = (args_to_string args')
in (FStar_Util.format4 "unequal number of arguments: %s[%s] and %s[%s]" _151_929 _151_928 _151_927 _151_926)))))
in (giveup env _151_930 orig))
end else begin
if ((nargs = 0) || (eq_args args args')) then begin
(match ((solve_maybe_uinsts env orig head head' wl)) with
| USolved (wl) -> begin
(let _151_931 = (solve_prob orig None [] wl)
in (solve env _151_931))
end
| UFailed (msg) -> begin
(giveup env msg orig)
end
| UDeferred (wl) -> begin
(solve env (defer "universe constraints" orig wl))
end)
end else begin
(
# 1270 "FStar.TypeChecker.Rel.fst"
let _69_1665 = (base_and_refinement env wl t1)
in (match (_69_1665) with
| (base1, refinement1) -> begin
(
# 1271 "FStar.TypeChecker.Rel.fst"
let _69_1668 = (base_and_refinement env wl t2)
in (match (_69_1668) with
| (base2, refinement2) -> begin
(match ((refinement1, refinement2)) with
| (None, None) -> begin
(match ((solve_maybe_uinsts env orig base1 base2 wl)) with
| UFailed (msg) -> begin
(giveup env msg orig)
end
| UDeferred (wl) -> begin
(solve env (defer "universe constraints" orig wl))
end
| USolved (wl) -> begin
(
# 1278 "FStar.TypeChecker.Rel.fst"
let subprobs = (FStar_List.map2 (fun _69_1681 _69_1685 -> (match ((_69_1681, _69_1685)) with
| ((a, _69_1680), (a', _69_1684)) -> begin
(let _151_935 = (mk_problem (p_scope orig) orig a FStar_TypeChecker_Common.EQ a' None "index")
in (FStar_All.pipe_left (fun _151_934 -> FStar_TypeChecker_Common.TProb (_151_934)) _151_935))
end)) args args')
in (
# 1279 "FStar.TypeChecker.Rel.fst"
let formula = (let _151_937 = (FStar_List.map (fun p -> (Prims.fst (p_guard p))) subprobs)
in (FStar_Syntax_Util.mk_conj_l _151_937))
in (
# 1280 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob orig (Some (formula)) [] wl)
in (solve env (attempt subprobs wl)))))
end)
end
| _69_1691 -> begin
(
# 1285 "FStar.TypeChecker.Rel.fst"
let lhs = (force_refinement (base1, refinement1))
in (
# 1286 "FStar.TypeChecker.Rel.fst"
let rhs = (force_refinement (base2, refinement2))
in (solve_t env (
# 1287 "FStar.TypeChecker.Rel.fst"
let _69_1694 = problem
in {FStar_TypeChecker_Common.pid = _69_1694.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = lhs; FStar_TypeChecker_Common.relation = _69_1694.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = rhs; FStar_TypeChecker_Common.element = _69_1694.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_1694.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_1694.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_1694.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_1694.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_1694.FStar_TypeChecker_Common.rank}) wl)))
end)
end))
end))
end
end)
end))
end)))
end)
end)))
in (
# 1293 "FStar.TypeChecker.Rel.fst"
let imitate = (fun orig env wl p -> (
# 1294 "FStar.TypeChecker.Rel.fst"
let _69_1711 = p
in (match (_69_1711) with
| ((u, k), ps, xs, (h, _69_1708, qs)) -> begin
(
# 1295 "FStar.TypeChecker.Rel.fst"
let xs = (sn_binders env xs)
in (
# 1300 "FStar.TypeChecker.Rel.fst"
let r = (FStar_TypeChecker_Env.get_range env)
in (
# 1301 "FStar.TypeChecker.Rel.fst"
let _69_1717 = (imitation_sub_probs orig env xs ps qs)
in (match (_69_1717) with
| (sub_probs, gs_xs, formula) -> begin
(
# 1302 "FStar.TypeChecker.Rel.fst"
let im = (let _151_948 = (h gs_xs)
in (u_abs xs _151_948))
in (
# 1303 "FStar.TypeChecker.Rel.fst"
let _69_1719 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_953 = (FStar_Syntax_Print.term_to_string im)
in (let _151_952 = (FStar_Syntax_Print.tag_of_term im)
in (let _151_951 = (let _151_949 = (FStar_List.map (prob_to_string env) sub_probs)
in (FStar_All.pipe_right _151_949 (FStar_String.concat ", ")))
in (let _151_950 = (FStar_TypeChecker_Normalize.term_to_string env formula)
in (FStar_Util.print4 "Imitating %s (%s)\nsub_probs = %s\nformula=%s\n" _151_953 _151_952 _151_951 _151_950)))))
end else begin
()
end
in (
# 1308 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob orig (Some (formula)) ((TERM (((u, k), im)))::[]) wl)
in (solve env (attempt sub_probs wl)))))
end))))
end)))
in (
# 1313 "FStar.TypeChecker.Rel.fst"
let project = (fun orig env wl i p -> (
# 1314 "FStar.TypeChecker.Rel.fst"
let _69_1735 = p
in (match (_69_1735) with
| (u, ps, xs, (h, matches, qs)) -> begin
(
# 1318 "FStar.TypeChecker.Rel.fst"
let r = (FStar_TypeChecker_Env.get_range env)
in (
# 1319 "FStar.TypeChecker.Rel.fst"
let _69_1740 = (FStar_List.nth ps i)
in (match (_69_1740) with
| (pi, _69_1739) -> begin
(
# 1320 "FStar.TypeChecker.Rel.fst"
let _69_1744 = (FStar_List.nth xs i)
in (match (_69_1744) with
| (xi, _69_1743) -> begin
(
# 1322 "FStar.TypeChecker.Rel.fst"
let rec gs = (fun k -> (
# 1323 "FStar.TypeChecker.Rel.fst"
let _69_1749 = (FStar_Syntax_Util.arrow_formals k)
in (match (_69_1749) with
| (bs, k) -> begin
(
# 1324 "FStar.TypeChecker.Rel.fst"
let rec aux = (fun subst bs -> (match (bs) with
| [] -> begin
([], [])
end
| (a, _69_1757)::tl -> begin
(
# 1327 "FStar.TypeChecker.Rel.fst"
let k_a = (FStar_Syntax_Subst.subst subst a.FStar_Syntax_Syntax.sort)
in (
# 1328 "FStar.TypeChecker.Rel.fst"
let _69_1763 = (new_uvar r xs k_a)
in (match (_69_1763) with
| (gi_xs, gi) -> begin
(
# 1329 "FStar.TypeChecker.Rel.fst"
let gi_xs = (FStar_TypeChecker_Normalize.eta_expand env gi_xs)
in (
# 1330 "FStar.TypeChecker.Rel.fst"
let gi_ps = (FStar_Syntax_Syntax.mk_Tm_app gi ps (Some (k_a.FStar_Syntax_Syntax.n)) r)
in (
# 1331 "FStar.TypeChecker.Rel.fst"
let subst = if (FStar_Syntax_Syntax.is_null_bv a) then begin
subst
end else begin
(FStar_Syntax_Syntax.NT ((a, gi_xs)))::subst
end
in (
# 1332 "FStar.TypeChecker.Rel.fst"
let _69_1769 = (aux subst tl)
in (match (_69_1769) with
| (gi_xs', gi_ps') -> begin
(let _151_975 = (let _151_972 = (FStar_Syntax_Syntax.as_arg gi_xs)
in (_151_972)::gi_xs')
in (let _151_974 = (let _151_973 = (FStar_Syntax_Syntax.as_arg gi_ps)
in (_151_973)::gi_ps')
in (_151_975, _151_974)))
end)))))
end)))
end))
in (aux [] bs))
end)))
in if (let _151_976 = (matches pi)
in (FStar_All.pipe_left Prims.op_Negation _151_976)) then begin
None
end else begin
(
# 1338 "FStar.TypeChecker.Rel.fst"
let _69_1773 = (gs xi.FStar_Syntax_Syntax.sort)
in (match (_69_1773) with
| (g_xs, _69_1772) -> begin
(
# 1339 "FStar.TypeChecker.Rel.fst"
let xi = (FStar_Syntax_Syntax.bv_to_name xi)
in (
# 1340 "FStar.TypeChecker.Rel.fst"
let proj = (let _151_977 = (FStar_Syntax_Syntax.mk_Tm_app xi g_xs None r)
in (u_abs xs _151_977))
in (
# 1341 "FStar.TypeChecker.Rel.fst"
let sub = (let _151_983 = (let _151_982 = (FStar_Syntax_Syntax.mk_Tm_app proj ps None r)
in (let _151_981 = (let _151_980 = (FStar_List.map (fun _69_1781 -> (match (_69_1781) with
| (_69_1777, _69_1779, y) -> begin
y
end)) qs)
in (FStar_All.pipe_left h _151_980))
in (mk_problem (p_scope orig) orig _151_982 (p_rel orig) _151_981 None "projection")))
in (FStar_All.pipe_left (fun _151_978 -> FStar_TypeChecker_Common.TProb (_151_978)) _151_983))
in (
# 1342 "FStar.TypeChecker.Rel.fst"
let _69_1783 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_985 = (FStar_Syntax_Print.term_to_string proj)
in (let _151_984 = (prob_to_string env sub)
in (FStar_Util.print2 "Projecting %s\n\tsubprob=%s\n" _151_985 _151_984)))
end else begin
()
end
in (
# 1343 "FStar.TypeChecker.Rel.fst"
let wl = (let _151_987 = (let _151_986 = (FStar_All.pipe_left Prims.fst (p_guard sub))
in Some (_151_986))
in (solve_prob orig _151_987 ((TERM ((u, proj)))::[]) wl))
in (let _151_989 = (solve env (attempt ((sub)::[]) wl))
in (FStar_All.pipe_left (fun _151_988 -> Some (_151_988)) _151_989)))))))
end))
end)
end))
end)))
end)))
in (
# 1348 "FStar.TypeChecker.Rel.fst"
let solve_t_flex_rigid = (fun orig lhs t2 wl -> (
# 1349 "FStar.TypeChecker.Rel.fst"
let _69_1797 = lhs
in (match (_69_1797) with
| ((t1, uv, k, args_lhs), maybe_pat_vars) -> begin
(
# 1350 "FStar.TypeChecker.Rel.fst"
let subterms = (fun ps -> (
# 1351 "FStar.TypeChecker.Rel.fst"
let xs = (let _151_1016 = (FStar_Syntax_Util.arrow_formals k)
in (FStar_All.pipe_right _151_1016 Prims.fst))
in (let _151_1021 = (decompose env t2)
in ((uv, k), ps, xs, _151_1021))))
in (
# 1354 "FStar.TypeChecker.Rel.fst"
let rec imitate_or_project = (fun n st i -> if (i >= n) then begin
(giveup env "flex-rigid case failed all backtracking attempts" orig)
end else begin
(
# 1357 "FStar.TypeChecker.Rel.fst"
let tx = (FStar_Unionfind.new_transaction ())
in if (i = (- (1))) then begin
(match ((imitate orig env wl st)) with
| Failed (_69_1807) -> begin
(
# 1361 "FStar.TypeChecker.Rel.fst"
let _69_1809 = (FStar_Unionfind.rollback tx)
in (imitate_or_project n st (i + 1)))
end
| sol -> begin
sol
end)
end else begin
(match ((project orig env wl i st)) with
| (None) | (Some (Failed (_))) -> begin
(
# 1368 "FStar.TypeChecker.Rel.fst"
let _69_1817 = (FStar_Unionfind.rollback tx)
in (imitate_or_project n st (i + 1)))
end
| Some (sol) -> begin
sol
end)
end)
end)
in (
# 1372 "FStar.TypeChecker.Rel.fst"
let check_head = (fun fvs1 t2 -> (
# 1373 "FStar.TypeChecker.Rel.fst"
let _69_1827 = (FStar_Syntax_Util.head_and_args t2)
in (match (_69_1827) with
| (hd, _69_1826) -> begin
(match (hd.FStar_Syntax_Syntax.n) with
| (FStar_Syntax_Syntax.Tm_arrow (_)) | (FStar_Syntax_Syntax.Tm_constant (_)) | (FStar_Syntax_Syntax.Tm_abs (_)) -> begin
true
end
| _69_1838 -> begin
(
# 1379 "FStar.TypeChecker.Rel.fst"
let fvs_hd = (FStar_Syntax_Free.names hd)
in if (FStar_Util.set_is_subset_of fvs_hd fvs1) then begin
true
end else begin
(
# 1382 "FStar.TypeChecker.Rel.fst"
let _69_1840 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_1032 = (names_to_string fvs_hd)
in (FStar_Util.print1 "Free variables are %s" _151_1032))
end else begin
()
end
in false)
end)
end)
end)))
in (
# 1385 "FStar.TypeChecker.Rel.fst"
let imitate_ok = (fun t2 -> (
# 1386 "FStar.TypeChecker.Rel.fst"
let fvs_hd = (let _151_1036 = (let _151_1035 = (FStar_Syntax_Util.head_and_args t2)
in (FStar_All.pipe_right _151_1035 Prims.fst))
in (FStar_All.pipe_right _151_1036 FStar_Syntax_Free.names))
in if (FStar_Util.set_is_empty fvs_hd) then begin
(- (1))
end else begin
0
end))
in (match (maybe_pat_vars) with
| Some (vars) -> begin
(
# 1393 "FStar.TypeChecker.Rel.fst"
let t1 = (sn env t1)
in (
# 1394 "FStar.TypeChecker.Rel.fst"
let t2 = (sn env t2)
in (
# 1395 "FStar.TypeChecker.Rel.fst"
let fvs1 = (FStar_Syntax_Free.names t1)
in (
# 1396 "FStar.TypeChecker.Rel.fst"
let fvs2 = (FStar_Syntax_Free.names t2)
in (
# 1397 "FStar.TypeChecker.Rel.fst"
let _69_1853 = (occurs_check env wl (uv, k) t2)
in (match (_69_1853) with
| (occurs_ok, msg) -> begin
if (not (occurs_ok)) then begin
(let _151_1038 = (let _151_1037 = (FStar_Option.get msg)
in (Prims.strcat "occurs-check failed: " _151_1037))
in (giveup_or_defer orig _151_1038))
end else begin
if (FStar_Util.set_is_subset_of fvs2 fvs1) then begin
if ((FStar_Syntax_Util.is_function_typ t2) && ((p_rel orig) <> FStar_TypeChecker_Common.EQ)) then begin
(let _151_1039 = (subterms args_lhs)
in (imitate orig env wl _151_1039))
end else begin
(
# 1404 "FStar.TypeChecker.Rel.fst"
let _69_1854 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_1042 = (FStar_Syntax_Print.term_to_string t1)
in (let _151_1041 = (names_to_string fvs1)
in (let _151_1040 = (names_to_string fvs2)
in (FStar_Util.print3 "Pattern %s with fvars=%s succeeded fvar check: %s\n" _151_1042 _151_1041 _151_1040))))
end else begin
()
end
in (
# 1409 "FStar.TypeChecker.Rel.fst"
let sol = (match (vars) with
| [] -> begin
t2
end
| _69_1858 -> begin
(let _151_1043 = (sn_binders env vars)
in (u_abs _151_1043 t2))
end)
in (
# 1412 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob orig None ((TERM (((uv, k), sol)))::[]) wl)
in (solve env wl))))
end
end else begin
if wl.defer_ok then begin
(solve env (defer "flex pattern/rigid: occurs or freevar check" orig wl))
end else begin
if (check_head fvs1 t2) then begin
(
# 1417 "FStar.TypeChecker.Rel.fst"
let _69_1861 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_1046 = (FStar_Syntax_Print.term_to_string t1)
in (let _151_1045 = (names_to_string fvs1)
in (let _151_1044 = (names_to_string fvs2)
in (FStar_Util.print3 "Pattern %s with fvars=%s failed fvar check: %s ... imitating\n" _151_1046 _151_1045 _151_1044))))
end else begin
()
end
in (let _151_1047 = (subterms args_lhs)
in (imitate_or_project (FStar_List.length args_lhs) _151_1047 (- (1)))))
end else begin
(giveup env "free-variable check failed on a non-redex" orig)
end
end
end
end
end))))))
end
| None -> begin
if wl.defer_ok then begin
(solve env (defer "not a pattern" orig wl))
end else begin
if (let _151_1048 = (FStar_Syntax_Free.names t1)
in (check_head _151_1048 t2)) then begin
(
# 1429 "FStar.TypeChecker.Rel.fst"
let im_ok = (imitate_ok t2)
in (
# 1430 "FStar.TypeChecker.Rel.fst"
let _69_1865 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_1049 = (FStar_Syntax_Print.term_to_string t1)
in (FStar_Util.print2 "Not a pattern (%s) ... %s\n" _151_1049 (if (im_ok < 0) then begin
"imitating"
end else begin
"projecting"
end)))
end else begin
()
end
in (let _151_1050 = (subterms args_lhs)
in (imitate_or_project (FStar_List.length args_lhs) _151_1050 im_ok))))
end else begin
(giveup env "head-symbol is free" orig)
end
end
end)))))
end)))
in (
# 1455 "FStar.TypeChecker.Rel.fst"
let flex_flex = (fun orig lhs rhs -> if (wl.defer_ok && ((p_rel orig) <> FStar_TypeChecker_Common.EQ)) then begin
(solve env (defer "flex-flex deferred" orig wl))
end else begin
(
# 1458 "FStar.TypeChecker.Rel.fst"
let force_quasi_pattern = (fun xs_opt _69_1877 -> (match (_69_1877) with
| (t, u, k, args) -> begin
(
# 1461 "FStar.TypeChecker.Rel.fst"
let _69_1881 = (FStar_Syntax_Util.arrow_formals k)
in (match (_69_1881) with
| (all_formals, _69_1880) -> begin
(
# 1462 "FStar.TypeChecker.Rel.fst"
let _69_1882 = ()
in (
# 1464 "FStar.TypeChecker.Rel.fst"
let rec aux = (fun pat_args pattern_vars pattern_var_set formals args -> (match ((formals, args)) with
| ([], []) -> begin
(
# 1472 "FStar.TypeChecker.Rel.fst"
let pat_args = (FStar_All.pipe_right (FStar_List.rev pat_args) (FStar_List.map (fun _69_1895 -> (match (_69_1895) with
| (x, imp) -> begin
(let _151_1072 = (FStar_Syntax_Syntax.bv_to_name x)
in (_151_1072, imp))
end))))
in (
# 1473 "FStar.TypeChecker.Rel.fst"
let pattern_vars = (FStar_List.rev pattern_vars)
in (
# 1474 "FStar.TypeChecker.Rel.fst"
let kk = (
# 1475 "FStar.TypeChecker.Rel.fst"
let _69_1901 = (FStar_Syntax_Util.type_u ())
in (match (_69_1901) with
| (t, _69_1900) -> begin
(let _151_1073 = (new_uvar t.FStar_Syntax_Syntax.pos pattern_vars t)
in (Prims.fst _151_1073))
end))
in (
# 1477 "FStar.TypeChecker.Rel.fst"
let _69_1905 = (new_uvar t.FStar_Syntax_Syntax.pos pattern_vars kk)
in (match (_69_1905) with
| (t', tm_u1) -> begin
(
# 1478 "FStar.TypeChecker.Rel.fst"
let _69_1912 = (destruct_flex_t t')
in (match (_69_1912) with
| (_69_1907, u1, k1, _69_1911) -> begin
(
# 1479 "FStar.TypeChecker.Rel.fst"
let sol = (let _151_1075 = (let _151_1074 = (u_abs all_formals t')
in ((u, k), _151_1074))
in TERM (_151_1075))
in (
# 1480 "FStar.TypeChecker.Rel.fst"
let t_app = (FStar_Syntax_Syntax.mk_Tm_app tm_u1 pat_args None t.FStar_Syntax_Syntax.pos)
in (sol, (t_app, u1, k1, pat_args))))
end))
end)))))
end
| (formal::formals, hd::tl) -> begin
(match ((pat_var_opt env pat_args hd)) with
| None -> begin
(aux pat_args pattern_vars pattern_var_set formals tl)
end
| Some (y) -> begin
(
# 1489 "FStar.TypeChecker.Rel.fst"
let maybe_pat = (match (xs_opt) with
| None -> begin
true
end
| Some (xs) -> begin
(FStar_All.pipe_right xs (FStar_Util.for_some (fun _69_1931 -> (match (_69_1931) with
| (x, _69_1930) -> begin
(FStar_Syntax_Syntax.bv_eq x (Prims.fst y))
end))))
end)
in if (not (maybe_pat)) then begin
(aux pat_args pattern_vars pattern_var_set formals tl)
end else begin
(
# 1496 "FStar.TypeChecker.Rel.fst"
let fvs = (FStar_Syntax_Free.names (Prims.fst y).FStar_Syntax_Syntax.sort)
in if (not ((FStar_Util.set_is_subset_of fvs pattern_var_set))) then begin
(aux pat_args pattern_vars pattern_var_set formals tl)
end else begin
(let _151_1077 = (FStar_Util.set_add (Prims.fst formal) pattern_var_set)
in (aux ((y)::pat_args) ((formal)::pattern_vars) _151_1077 formals tl))
end)
end)
end)
end
| _69_1935 -> begin
(FStar_All.failwith "Impossible")
end))
in (let _151_1078 = (FStar_Syntax_Syntax.new_bv_set ())
in (aux [] [] _151_1078 all_formals args))))
end))
end))
in (
# 1508 "FStar.TypeChecker.Rel.fst"
let solve_both_pats = (fun wl _69_1941 _69_1945 r -> (match ((_69_1941, _69_1945)) with
| ((u1, k1, xs), (u2, k2, ys)) -> begin
if ((FStar_Unionfind.equivalent u1 u2) && (binders_eq xs ys)) then begin
(let _151_1087 = (solve_prob orig None [] wl)
in (solve env _151_1087))
end else begin
(
# 1516 "FStar.TypeChecker.Rel.fst"
let xs = (sn_binders env xs)
in (
# 1517 "FStar.TypeChecker.Rel.fst"
let ys = (sn_binders env ys)
in (
# 1518 "FStar.TypeChecker.Rel.fst"
let zs = (intersect_vars xs ys)
in (
# 1519 "FStar.TypeChecker.Rel.fst"
let _69_1950 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_1090 = (FStar_Syntax_Print.binders_to_string ", " xs)
in (let _151_1089 = (FStar_Syntax_Print.binders_to_string ", " ys)
in (let _151_1088 = (FStar_Syntax_Print.binders_to_string ", " zs)
in (FStar_Util.print3 "Flex-flex patterns: intersected %s and %s; got %s\n" _151_1090 _151_1089 _151_1088))))
end else begin
()
end
in (
# 1522 "FStar.TypeChecker.Rel.fst"
let _69_1963 = (
# 1523 "FStar.TypeChecker.Rel.fst"
let _69_1955 = (FStar_Syntax_Util.type_u ())
in (match (_69_1955) with
| (t, _69_1954) -> begin
(
# 1524 "FStar.TypeChecker.Rel.fst"
let _69_1959 = (new_uvar r zs t)
in (match (_69_1959) with
| (k, _69_1958) -> begin
(new_uvar r zs k)
end))
end))
in (match (_69_1963) with
| (u_zs, _69_1962) -> begin
(
# 1526 "FStar.TypeChecker.Rel.fst"
let sub1 = (u_abs xs u_zs)
in (
# 1527 "FStar.TypeChecker.Rel.fst"
let _69_1967 = (occurs_check env wl (u1, k1) sub1)
in (match (_69_1967) with
| (occurs_ok, msg) -> begin
if (not (occurs_ok)) then begin
(giveup_or_defer orig "flex-flex: failed occcurs check")
end else begin
(
# 1530 "FStar.TypeChecker.Rel.fst"
let sol1 = TERM (((u1, k1), sub1))
in if (FStar_Unionfind.equivalent u1 u2) then begin
(
# 1532 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob orig None ((sol1)::[]) wl)
in (solve env wl))
end else begin
(
# 1534 "FStar.TypeChecker.Rel.fst"
let sub2 = (u_abs ys u_zs)
in (
# 1535 "FStar.TypeChecker.Rel.fst"
let _69_1973 = (occurs_check env wl (u2, k2) sub2)
in (match (_69_1973) with
| (occurs_ok, msg) -> begin
if (not (occurs_ok)) then begin
(giveup_or_defer orig "flex-flex: failed occurs check")
end else begin
(
# 1538 "FStar.TypeChecker.Rel.fst"
let sol2 = TERM (((u2, k2), sub2))
in (
# 1539 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob orig None ((sol1)::(sol2)::[]) wl)
in (solve env wl)))
end
end)))
end)
end
end)))
end))))))
end
end))
in (
# 1542 "FStar.TypeChecker.Rel.fst"
let solve_one_pat = (fun _69_1981 _69_1986 -> (match ((_69_1981, _69_1986)) with
| ((t1, u1, k1, xs), (t2, u2, k2, args2)) -> begin
(
# 1544 "FStar.TypeChecker.Rel.fst"
let _69_1987 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_1096 = (FStar_Syntax_Print.term_to_string t1)
in (let _151_1095 = (FStar_Syntax_Print.term_to_string t2)
in (FStar_Util.print2 "Trying flex-flex one pattern (%s) with %s\n" _151_1096 _151_1095)))
end else begin
()
end
in if (FStar_Unionfind.equivalent u1 u2) then begin
(
# 1547 "FStar.TypeChecker.Rel.fst"
let sub_probs = (FStar_List.map2 (fun _69_1992 _69_1996 -> (match ((_69_1992, _69_1996)) with
| ((a, _69_1991), (t2, _69_1995)) -> begin
(let _151_1101 = (let _151_1099 = (FStar_Syntax_Syntax.bv_to_name a)
in (mk_problem (p_scope orig) orig _151_1099 FStar_TypeChecker_Common.EQ t2 None "flex-flex index"))
in (FStar_All.pipe_right _151_1101 (fun _151_1100 -> FStar_TypeChecker_Common.TProb (_151_1100))))
end)) xs args2)
in (
# 1550 "FStar.TypeChecker.Rel.fst"
let guard = (let _151_1103 = (FStar_List.map (fun p -> (FStar_All.pipe_right (p_guard p) Prims.fst)) sub_probs)
in (FStar_Syntax_Util.mk_conj_l _151_1103))
in (
# 1551 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob orig (Some (guard)) [] wl)
in (solve env (attempt sub_probs wl)))))
end else begin
(
# 1554 "FStar.TypeChecker.Rel.fst"
let t2 = (sn env t2)
in (
# 1555 "FStar.TypeChecker.Rel.fst"
let rhs_vars = (FStar_Syntax_Free.names t2)
in (
# 1556 "FStar.TypeChecker.Rel.fst"
let _69_2006 = (occurs_check env wl (u1, k1) t2)
in (match (_69_2006) with
| (occurs_ok, _69_2005) -> begin
(
# 1557 "FStar.TypeChecker.Rel.fst"
let lhs_vars = (FStar_Syntax_Free.names_of_binders xs)
in if (occurs_ok && (FStar_Util.set_is_subset_of rhs_vars lhs_vars)) then begin
(
# 1560 "FStar.TypeChecker.Rel.fst"
let sol = (let _151_1105 = (let _151_1104 = (u_abs xs t2)
in ((u1, k1), _151_1104))
in TERM (_151_1105))
in (
# 1561 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob orig None ((sol)::[]) wl)
in (solve env wl)))
end else begin
if (occurs_ok && (FStar_All.pipe_left Prims.op_Negation wl.defer_ok)) then begin
(
# 1564 "FStar.TypeChecker.Rel.fst"
let _69_2017 = (force_quasi_pattern (Some (xs)) (t2, u2, k2, args2))
in (match (_69_2017) with
| (sol, (_69_2012, u2, k2, ys)) -> begin
(
# 1565 "FStar.TypeChecker.Rel.fst"
let wl = (extend_solution (p_pid orig) ((sol)::[]) wl)
in (
# 1566 "FStar.TypeChecker.Rel.fst"
let _69_2019 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("QuasiPattern"))) then begin
(let _151_1106 = (uvi_to_string env sol)
in (FStar_Util.print1 "flex-flex quasi pattern (2): %s\n" _151_1106))
end else begin
()
end
in (match (orig) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(solve_t env p wl)
end
| _69_2024 -> begin
(giveup env "impossible" orig)
end)))
end))
end else begin
(giveup_or_defer orig "flex-flex constraint")
end
end)
end))))
end)
end))
in (
# 1574 "FStar.TypeChecker.Rel.fst"
let _69_2029 = lhs
in (match (_69_2029) with
| (t1, u1, k1, args1) -> begin
(
# 1575 "FStar.TypeChecker.Rel.fst"
let _69_2034 = rhs
in (match (_69_2034) with
| (t2, u2, k2, args2) -> begin
(
# 1576 "FStar.TypeChecker.Rel.fst"
let maybe_pat_vars1 = (pat_vars env [] args1)
in (
# 1577 "FStar.TypeChecker.Rel.fst"
let maybe_pat_vars2 = (pat_vars env [] args2)
in (
# 1578 "FStar.TypeChecker.Rel.fst"
let r = t2.FStar_Syntax_Syntax.pos
in (match ((maybe_pat_vars1, maybe_pat_vars2)) with
| (Some (xs), Some (ys)) -> begin
(solve_both_pats wl (u1, k1, xs) (u2, k2, ys) t2.FStar_Syntax_Syntax.pos)
end
| (Some (xs), None) -> begin
(solve_one_pat (t1, u1, k1, xs) rhs)
end
| (None, Some (ys)) -> begin
(solve_one_pat (t2, u2, k2, ys) lhs)
end
| _69_2052 -> begin
if wl.defer_ok then begin
(giveup_or_defer orig "flex-flex: neither side is a pattern")
end else begin
(
# 1587 "FStar.TypeChecker.Rel.fst"
let _69_2056 = (force_quasi_pattern None (t1, u1, k1, args1))
in (match (_69_2056) with
| (sol, _69_2055) -> begin
(
# 1588 "FStar.TypeChecker.Rel.fst"
let wl = (extend_solution (p_pid orig) ((sol)::[]) wl)
in (
# 1589 "FStar.TypeChecker.Rel.fst"
let _69_2058 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("QuasiPattern"))) then begin
(let _151_1107 = (uvi_to_string env sol)
in (FStar_Util.print1 "flex-flex quasi pattern (1): %s\n" _151_1107))
end else begin
()
end
in (match (orig) with
| FStar_TypeChecker_Common.TProb (p) -> begin
(solve_t env p wl)
end
| _69_2063 -> begin
(giveup env "impossible" orig)
end)))
end))
end
end))))
end))
end)))))
end)
in (
# 1596 "FStar.TypeChecker.Rel.fst"
let orig = FStar_TypeChecker_Common.TProb (problem)
in if (FStar_Util.physical_equality problem.FStar_TypeChecker_Common.lhs problem.FStar_TypeChecker_Common.rhs) then begin
(let _151_1108 = (solve_prob orig None [] wl)
in (solve env _151_1108))
end else begin
(
# 1598 "FStar.TypeChecker.Rel.fst"
let t1 = problem.FStar_TypeChecker_Common.lhs
in (
# 1599 "FStar.TypeChecker.Rel.fst"
let t2 = problem.FStar_TypeChecker_Common.rhs
in if (FStar_Util.physical_equality t1 t2) then begin
(let _151_1109 = (solve_prob orig None [] wl)
in (solve env _151_1109))
end else begin
(
# 1601 "FStar.TypeChecker.Rel.fst"
let _69_2067 = if (FStar_TypeChecker_Env.debug env (FStar_Options.Other ("RelCheck"))) then begin
(let _151_1110 = (FStar_Util.string_of_int problem.FStar_TypeChecker_Common.pid)
in (FStar_Util.print1 "Attempting %s\n" _151_1110))
end else begin
()
end
in (
# 1604 "FStar.TypeChecker.Rel.fst"
let r = (FStar_TypeChecker_Env.get_range env)
in (
# 1606 "FStar.TypeChecker.Rel.fst"
let match_num_binders = (fun _69_2072 _69_2075 -> (match ((_69_2072, _69_2075)) with
| ((bs1, mk_cod1), (bs2, mk_cod2)) -> begin
(
# 1608 "FStar.TypeChecker.Rel.fst"
let curry = (fun n bs mk_cod -> (
# 1609 "FStar.TypeChecker.Rel.fst"
let _69_2082 = (FStar_Util.first_N n bs)
in (match (_69_2082) with
| (bs, rest) -> begin
(let _151_1140 = (mk_cod rest)
in (bs, _151_1140))
end)))
in (
# 1612 "FStar.TypeChecker.Rel.fst"
let l1 = (FStar_List.length bs1)
in (
# 1613 "FStar.TypeChecker.Rel.fst"
let l2 = (FStar_List.length bs2)
in if (l1 = l2) then begin
(let _151_1144 = (let _151_1141 = (mk_cod1 [])
in (bs1, _151_1141))
in (let _151_1143 = (let _151_1142 = (mk_cod2 [])
in (bs2, _151_1142))
in (_151_1144, _151_1143)))
end else begin
if (l1 > l2) then begin
(let _151_1147 = (curry l2 bs1 mk_cod1)
in (let _151_1146 = (let _151_1145 = (mk_cod2 [])
in (bs2, _151_1145))
in (_151_1147, _151_1146)))
end else begin
(let _151_1150 = (let _151_1148 = (mk_cod1 [])
in (bs1, _151_1148))
in (let _151_1149 = (curry l1 bs2 mk_cod2)
in (_151_1150, _151_1149)))
end
end)))
end))
in (match ((t1.FStar_Syntax_Syntax.n, t2.FStar_Syntax_Syntax.n)) with
| ((FStar_Syntax_Syntax.Tm_bvar (_), _)) | ((_, FStar_Syntax_Syntax.Tm_bvar (_))) -> begin
(FStar_All.failwith "Only locally nameless! We should never see a de Bruijn variable")
end
| (FStar_Syntax_Syntax.Tm_type (u1), FStar_Syntax_Syntax.Tm_type (u2)) -> begin
(solve_one_universe_eq env orig u1 u2 wl)
end
| (FStar_Syntax_Syntax.Tm_arrow (bs1, c1), FStar_Syntax_Syntax.Tm_arrow (bs2, c2)) -> begin
(
# 1631 "FStar.TypeChecker.Rel.fst"
let mk_c = (fun c _69_24 -> (match (_69_24) with
| [] -> begin
c
end
| bs -> begin
(let _151_1155 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow ((bs, c))) None c.FStar_Syntax_Syntax.pos)
in (FStar_Syntax_Syntax.mk_Total _151_1155))
end))
in (
# 1635 "FStar.TypeChecker.Rel.fst"
let _69_2125 = (match_num_binders (bs1, (mk_c c1)) (bs2, (mk_c c2)))
in (match (_69_2125) with
| ((bs1, c1), (bs2, c2)) -> begin
(solve_binders env bs1 bs2 orig wl (fun scope env subst -> (
# 1640 "FStar.TypeChecker.Rel.fst"
let c1 = (FStar_Syntax_Subst.subst_comp subst c1)
in (
# 1641 "FStar.TypeChecker.Rel.fst"
let c2 = (FStar_Syntax_Subst.subst_comp subst c2)
in (
# 1642 "FStar.TypeChecker.Rel.fst"
let rel = if (FStar_ST.read FStar_Options.use_eq_at_higher_order) then begin
FStar_TypeChecker_Common.EQ
end else begin
problem.FStar_TypeChecker_Common.relation
end
in (let _151_1162 = (mk_problem scope orig c1 rel c2 None "function co-domain")
in (FStar_All.pipe_left (fun _151_1161 -> FStar_TypeChecker_Common.CProb (_151_1161)) _151_1162)))))))
end)))
end
| (FStar_Syntax_Syntax.Tm_abs (bs1, tbody1, _69_2135), FStar_Syntax_Syntax.Tm_abs (bs2, tbody2, _69_2141)) -> begin
(
# 1646 "FStar.TypeChecker.Rel.fst"
let mk_t = (fun t _69_25 -> (match (_69_25) with
| [] -> begin
t
end
| bs -> begin
(FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_abs ((bs, t, None))) None t.FStar_Syntax_Syntax.pos)
end))
in (
# 1649 "FStar.TypeChecker.Rel.fst"
let _69_2156 = (match_num_binders (bs1, (mk_t tbody1)) (bs2, (mk_t tbody2)))
in (match (_69_2156) with
| ((bs1, tbody1), (bs2, tbody2)) -> begin
(solve_binders env bs1 bs2 orig wl (fun scope env subst -> (let _151_1175 = (let _151_1174 = (FStar_Syntax_Subst.subst subst tbody1)
in (let _151_1173 = (FStar_Syntax_Subst.subst subst tbody2)
in (mk_problem scope orig _151_1174 problem.FStar_TypeChecker_Common.relation _151_1173 None "lambda co-domain")))
in (FStar_All.pipe_left (fun _151_1172 -> FStar_TypeChecker_Common.TProb (_151_1172)) _151_1175))))
end)))
end
| (FStar_Syntax_Syntax.Tm_refine (_69_2161), FStar_Syntax_Syntax.Tm_refine (_69_2164)) -> begin
(
# 1658 "FStar.TypeChecker.Rel.fst"
let _69_2169 = (as_refinement env wl t1)
in (match (_69_2169) with
| (x1, phi1) -> begin
(
# 1659 "FStar.TypeChecker.Rel.fst"
let _69_2172 = (as_refinement env wl t2)
in (match (_69_2172) with
| (x2, phi2) -> begin
(
# 1660 "FStar.TypeChecker.Rel.fst"
let base_prob = (let _151_1177 = (mk_problem (p_scope orig) orig x1.FStar_Syntax_Syntax.sort problem.FStar_TypeChecker_Common.relation x2.FStar_Syntax_Syntax.sort problem.FStar_TypeChecker_Common.element "refinement base type")
in (FStar_All.pipe_left (fun _151_1176 -> FStar_TypeChecker_Common.TProb (_151_1176)) _151_1177))
in (
# 1661 "FStar.TypeChecker.Rel.fst"
let x1 = (FStar_Syntax_Syntax.freshen_bv x1)
in (
# 1662 "FStar.TypeChecker.Rel.fst"
let subst = (let _151_1180 = (let _151_1179 = (let _151_1178 = (FStar_Syntax_Syntax.bv_to_name x1)
in (0, _151_1178))
in FStar_Syntax_Syntax.DB (_151_1179))
in (_151_1180)::[])
in (
# 1663 "FStar.TypeChecker.Rel.fst"
let phi1 = (FStar_Syntax_Subst.subst subst phi1)
in (
# 1664 "FStar.TypeChecker.Rel.fst"
let phi2 = (FStar_Syntax_Subst.subst subst phi2)
in (
# 1665 "FStar.TypeChecker.Rel.fst"
let env = (FStar_TypeChecker_Env.push_bv env x1)
in (
# 1666 "FStar.TypeChecker.Rel.fst"
let mk_imp = (fun imp phi1 phi2 -> (let _151_1197 = (imp phi1 phi2)
in (FStar_All.pipe_right _151_1197 (guard_on_element problem x1))))
in (
# 1667 "FStar.TypeChecker.Rel.fst"
let fallback = (fun _69_2184 -> (match (()) with
| () -> begin
(
# 1668 "FStar.TypeChecker.Rel.fst"
let impl = if (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) then begin
(mk_imp FStar_Syntax_Util.mk_iff phi1 phi2)
end else begin
(mk_imp FStar_Syntax_Util.mk_imp phi1 phi2)
end
in (
# 1672 "FStar.TypeChecker.Rel.fst"
let guard = (let _151_1200 = (FStar_All.pipe_right (p_guard base_prob) Prims.fst)
in (FStar_Syntax_Util.mk_conj _151_1200 impl))
in (
# 1673 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob orig (Some (guard)) [] wl)
in (solve env (attempt ((base_prob)::[]) wl)))))
end))
in if (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) then begin
(
# 1676 "FStar.TypeChecker.Rel.fst"
let ref_prob = (let _151_1204 = (let _151_1203 = (let _151_1202 = (FStar_Syntax_Syntax.mk_binder x1)
in (_151_1202)::(p_scope orig))
in (mk_problem _151_1203 orig phi1 FStar_TypeChecker_Common.EQ phi2 None "refinement formula"))
in (FStar_All.pipe_left (fun _151_1201 -> FStar_TypeChecker_Common.TProb (_151_1201)) _151_1204))
in (match ((solve env (
# 1677 "FStar.TypeChecker.Rel.fst"
let _69_2189 = wl
in {attempting = (ref_prob)::[]; wl_deferred = []; ctr = _69_2189.ctr; defer_ok = false; smt_ok = _69_2189.smt_ok; tcenv = _69_2189.tcenv}))) with
| Failed (_69_2192) -> begin
(fallback ())
end
| Success (_69_2195) -> begin
(
# 1680 "FStar.TypeChecker.Rel.fst"
let guard = (let _151_1207 = (FStar_All.pipe_right (p_guard base_prob) Prims.fst)
in (let _151_1206 = (let _151_1205 = (FStar_All.pipe_right (p_guard ref_prob) Prims.fst)
in (FStar_All.pipe_right _151_1205 (guard_on_element problem x1)))
in (FStar_Syntax_Util.mk_conj _151_1207 _151_1206)))
in (
# 1681 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob orig (Some (guard)) [] wl)
in (
# 1682 "FStar.TypeChecker.Rel.fst"
let wl = (
# 1682 "FStar.TypeChecker.Rel.fst"
let _69_2199 = wl
in {attempting = _69_2199.attempting; wl_deferred = _69_2199.wl_deferred; ctr = (wl.ctr + 1); defer_ok = _69_2199.defer_ok; smt_ok = _69_2199.smt_ok; tcenv = _69_2199.tcenv})
in (solve env (attempt ((base_prob)::[]) wl)))))
end))
end else begin
(fallback ())
end))))))))
end))
end))
end
| ((FStar_Syntax_Syntax.Tm_uvar (_), FStar_Syntax_Syntax.Tm_uvar (_))) | ((FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _), FStar_Syntax_Syntax.Tm_uvar (_))) | ((FStar_Syntax_Syntax.Tm_uvar (_), FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _))) | ((FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _), FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _))) -> begin
(let _151_1209 = (destruct_flex_t t1)
in (let _151_1208 = (destruct_flex_t t2)
in (flex_flex orig _151_1209 _151_1208)))
end
| ((FStar_Syntax_Syntax.Tm_uvar (_), _)) | ((FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _), _)) when (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) -> begin
(let _151_1210 = (destruct_flex_pattern env t1)
in (solve_t_flex_rigid orig _151_1210 t2 wl))
end
| ((_, FStar_Syntax_Syntax.Tm_uvar (_))) | ((_, FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _))) when (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) -> begin
(solve_t env (invert problem) wl)
end
| ((FStar_Syntax_Syntax.Tm_uvar (_), _)) | ((FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _), _)) -> begin
if wl.defer_ok then begin
(solve env (defer "flex-rigid subtyping deferred" orig wl))
end else begin
(
# 1710 "FStar.TypeChecker.Rel.fst"
let new_rel = if (FStar_ST.read FStar_Options.no_slack) then begin
FStar_TypeChecker_Common.EQ
end else begin
problem.FStar_TypeChecker_Common.relation
end
in if (let _151_1211 = (is_top_level_prob orig)
in (FStar_All.pipe_left Prims.op_Negation _151_1211)) then begin
(let _151_1214 = (FStar_All.pipe_left (fun _151_1212 -> FStar_TypeChecker_Common.TProb (_151_1212)) (
# 1712 "FStar.TypeChecker.Rel.fst"
let _69_2344 = problem
in {FStar_TypeChecker_Common.pid = _69_2344.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _69_2344.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = new_rel; FStar_TypeChecker_Common.rhs = _69_2344.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _69_2344.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_2344.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_2344.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_2344.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_2344.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_2344.FStar_TypeChecker_Common.rank}))
in (let _151_1213 = (destruct_flex_pattern env t1)
in (solve_t_flex_rigid _151_1214 _151_1213 t2 wl)))
end else begin
(
# 1713 "FStar.TypeChecker.Rel.fst"
let _69_2348 = (base_and_refinement env wl t2)
in (match (_69_2348) with
| (t_base, ref_opt) -> begin
(match (ref_opt) with
| None -> begin
(let _151_1217 = (FStar_All.pipe_left (fun _151_1215 -> FStar_TypeChecker_Common.TProb (_151_1215)) (
# 1716 "FStar.TypeChecker.Rel.fst"
let _69_2350 = problem
in {FStar_TypeChecker_Common.pid = _69_2350.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _69_2350.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = new_rel; FStar_TypeChecker_Common.rhs = _69_2350.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _69_2350.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_2350.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_2350.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_2350.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_2350.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_2350.FStar_TypeChecker_Common.rank}))
in (let _151_1216 = (destruct_flex_pattern env t1)
in (solve_t_flex_rigid _151_1217 _151_1216 t_base wl)))
end
| Some (y, phi) -> begin
(
# 1719 "FStar.TypeChecker.Rel.fst"
let y' = (
# 1719 "FStar.TypeChecker.Rel.fst"
let _69_2356 = y
in {FStar_Syntax_Syntax.ppname = _69_2356.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _69_2356.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = t1})
in (
# 1720 "FStar.TypeChecker.Rel.fst"
let impl = (guard_on_element problem y' phi)
in (
# 1721 "FStar.TypeChecker.Rel.fst"
let base_prob = (let _151_1219 = (mk_problem problem.FStar_TypeChecker_Common.scope orig t1 new_rel y.FStar_Syntax_Syntax.sort problem.FStar_TypeChecker_Common.element "flex-rigid: base type")
in (FStar_All.pipe_left (fun _151_1218 -> FStar_TypeChecker_Common.TProb (_151_1218)) _151_1219))
in (
# 1723 "FStar.TypeChecker.Rel.fst"
let guard = (let _151_1220 = (FStar_All.pipe_right (p_guard base_prob) Prims.fst)
in (FStar_Syntax_Util.mk_conj _151_1220 impl))
in (
# 1724 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob orig (Some (guard)) [] wl)
in (solve env (attempt ((base_prob)::[]) wl)))))))
end)
end))
end)
end
end
| ((_, FStar_Syntax_Syntax.Tm_uvar (_))) | ((_, FStar_Syntax_Syntax.Tm_app ({FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_uvar (_); FStar_Syntax_Syntax.tk = _; FStar_Syntax_Syntax.pos = _; FStar_Syntax_Syntax.vars = _}, _))) -> begin
if wl.defer_ok then begin
(solve env (defer "rigid-flex subtyping deferred" orig wl))
end else begin
(
# 1733 "FStar.TypeChecker.Rel.fst"
let _69_2389 = (base_and_refinement env wl t1)
in (match (_69_2389) with
| (t_base, _69_2388) -> begin
(solve_t env (
# 1734 "FStar.TypeChecker.Rel.fst"
let _69_2390 = problem
in {FStar_TypeChecker_Common.pid = _69_2390.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = t_base; FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ; FStar_TypeChecker_Common.rhs = _69_2390.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _69_2390.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_2390.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_2390.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_2390.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_2390.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_2390.FStar_TypeChecker_Common.rank}) wl)
end))
end
end
| (FStar_Syntax_Syntax.Tm_refine (_69_2393), _69_2396) -> begin
(
# 1737 "FStar.TypeChecker.Rel.fst"
let t2 = (let _151_1221 = (base_and_refinement env wl t2)
in (FStar_All.pipe_left force_refinement _151_1221))
in (solve_t env (
# 1738 "FStar.TypeChecker.Rel.fst"
let _69_2399 = problem
in {FStar_TypeChecker_Common.pid = _69_2399.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _69_2399.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = _69_2399.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = t2; FStar_TypeChecker_Common.element = _69_2399.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_2399.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_2399.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_2399.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_2399.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_2399.FStar_TypeChecker_Common.rank}) wl))
end
| (_69_2402, FStar_Syntax_Syntax.Tm_refine (_69_2404)) -> begin
(
# 1741 "FStar.TypeChecker.Rel.fst"
let t1 = (let _151_1222 = (base_and_refinement env wl t1)
in (FStar_All.pipe_left force_refinement _151_1222))
in (solve_t env (
# 1742 "FStar.TypeChecker.Rel.fst"
let _69_2408 = problem
in {FStar_TypeChecker_Common.pid = _69_2408.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = t1; FStar_TypeChecker_Common.relation = _69_2408.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _69_2408.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _69_2408.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_2408.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_2408.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_2408.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_2408.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_2408.FStar_TypeChecker_Common.rank}) wl))
end
| ((FStar_Syntax_Syntax.Tm_abs (_), _)) | ((_, FStar_Syntax_Syntax.Tm_abs (_))) -> begin
(
# 1746 "FStar.TypeChecker.Rel.fst"
let maybe_eta = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_abs (_69_2425) -> begin
t
end
| _69_2428 -> begin
(FStar_TypeChecker_Normalize.eta_expand wl.tcenv t)
end))
in (let _151_1227 = (
# 1749 "FStar.TypeChecker.Rel.fst"
let _69_2429 = problem
in (let _151_1226 = (maybe_eta t1)
in (let _151_1225 = (maybe_eta t2)
in {FStar_TypeChecker_Common.pid = _69_2429.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _151_1226; FStar_TypeChecker_Common.relation = _69_2429.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _151_1225; FStar_TypeChecker_Common.element = _69_2429.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_2429.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_2429.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_2429.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_2429.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_2429.FStar_TypeChecker_Common.rank})))
in (solve_t env _151_1227 wl)))
end
| ((FStar_Syntax_Syntax.Tm_uinst (_), _)) | ((FStar_Syntax_Syntax.Tm_name (_), _)) | ((FStar_Syntax_Syntax.Tm_constant (_), _)) | ((FStar_Syntax_Syntax.Tm_fvar (_), _)) | ((FStar_Syntax_Syntax.Tm_app (_), _)) | ((_, FStar_Syntax_Syntax.Tm_uinst (_))) | ((_, FStar_Syntax_Syntax.Tm_name (_))) | ((_, FStar_Syntax_Syntax.Tm_constant (_))) | ((_, FStar_Syntax_Syntax.Tm_fvar (_))) | ((_, FStar_Syntax_Syntax.Tm_app (_))) -> begin
(
# 1761 "FStar.TypeChecker.Rel.fst"
let head1 = (let _151_1228 = (FStar_Syntax_Util.head_and_args t1)
in (FStar_All.pipe_right _151_1228 Prims.fst))
in (
# 1762 "FStar.TypeChecker.Rel.fst"
let head2 = (let _151_1229 = (FStar_Syntax_Util.head_and_args t2)
in (FStar_All.pipe_right _151_1229 Prims.fst))
in if ((((FStar_TypeChecker_Env.is_interpreted env head1) || (FStar_TypeChecker_Env.is_interpreted env head2)) && wl.smt_ok) && (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ)) then begin
(
# 1767 "FStar.TypeChecker.Rel.fst"
let uv1 = (FStar_Syntax_Free.uvars t1)
in (
# 1768 "FStar.TypeChecker.Rel.fst"
let uv2 = (FStar_Syntax_Free.uvars t2)
in if ((FStar_Util.set_is_empty uv1) && (FStar_Util.set_is_empty uv2)) then begin
(
# 1770 "FStar.TypeChecker.Rel.fst"
let guard = if (eq_tm t1 t2) then begin
None
end else begin
(let _151_1231 = (FStar_Syntax_Util.mk_eq FStar_Syntax_Syntax.tun FStar_Syntax_Syntax.tun t1 t2)
in (FStar_All.pipe_left (fun _151_1230 -> Some (_151_1230)) _151_1231))
end
in (let _151_1232 = (solve_prob orig guard [] wl)
in (solve env _151_1232)))
end else begin
(rigid_rigid_delta env orig wl head1 head2 t1 t2)
end))
end else begin
(rigid_rigid_delta env orig wl head1 head2 t1 t2)
end))
end
| (FStar_Syntax_Syntax.Tm_ascribed (t1, _69_2498, _69_2500), _69_2504) -> begin
(solve_t' env (
# 1778 "FStar.TypeChecker.Rel.fst"
let _69_2506 = problem
in {FStar_TypeChecker_Common.pid = _69_2506.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = t1; FStar_TypeChecker_Common.relation = _69_2506.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _69_2506.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _69_2506.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_2506.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_2506.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_2506.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_2506.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_2506.FStar_TypeChecker_Common.rank}) wl)
end
| (_69_2509, FStar_Syntax_Syntax.Tm_ascribed (t2, _69_2512, _69_2514)) -> begin
(solve_t' env (
# 1781 "FStar.TypeChecker.Rel.fst"
let _69_2518 = problem
in {FStar_TypeChecker_Common.pid = _69_2518.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _69_2518.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = _69_2518.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = t2; FStar_TypeChecker_Common.element = _69_2518.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_2518.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_2518.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_2518.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_2518.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_2518.FStar_TypeChecker_Common.rank}) wl)
end
| ((FStar_Syntax_Syntax.Tm_let (_), _)) | ((FStar_Syntax_Syntax.Tm_meta (_), _)) | ((FStar_Syntax_Syntax.Tm_delayed (_), _)) | ((_, FStar_Syntax_Syntax.Tm_meta (_))) | ((_, FStar_Syntax_Syntax.Tm_delayed (_))) | ((_, FStar_Syntax_Syntax.Tm_let (_))) -> begin
(let _151_1235 = (let _151_1234 = (FStar_Syntax_Print.tag_of_term t1)
in (let _151_1233 = (FStar_Syntax_Print.tag_of_term t2)
in (FStar_Util.format2 "Impossible: %s and %s" _151_1234 _151_1233)))
in (FStar_All.failwith _151_1235))
end
| _69_2557 -> begin
(giveup env "head tag mismatch" orig)
end))))
end))
end))))))))
and solve_c : FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.comp, Prims.unit) FStar_TypeChecker_Common.problem  ->  worklist  ->  solution = (fun env problem wl -> (
# 1793 "FStar.TypeChecker.Rel.fst"
let c1 = problem.FStar_TypeChecker_Common.lhs
in (
# 1794 "FStar.TypeChecker.Rel.fst"
let c2 = problem.FStar_TypeChecker_Common.rhs
in (
# 1795 "FStar.TypeChecker.Rel.fst"
let orig = FStar_TypeChecker_Common.CProb (problem)
in (
# 1796 "FStar.TypeChecker.Rel.fst"
let sub_prob = (fun t1 rel t2 reason -> (mk_problem (p_scope orig) orig t1 rel t2 None reason))
in (
# 1798 "FStar.TypeChecker.Rel.fst"
let solve_eq = (fun c1_comp c2_comp -> (
# 1799 "FStar.TypeChecker.Rel.fst"
let _69_2574 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("EQ"))) then begin
(FStar_Util.print_string "solve_c is using an equality constraint\n")
end else begin
()
end
in (
# 1801 "FStar.TypeChecker.Rel.fst"
let sub_probs = (FStar_List.map2 (fun _69_2579 _69_2583 -> (match ((_69_2579, _69_2583)) with
| ((a1, _69_2578), (a2, _69_2582)) -> begin
(let _151_1250 = (sub_prob a1 FStar_TypeChecker_Common.EQ a2 "effect arg")
in (FStar_All.pipe_left (fun _151_1249 -> FStar_TypeChecker_Common.TProb (_151_1249)) _151_1250))
end)) c1_comp.FStar_Syntax_Syntax.effect_args c2_comp.FStar_Syntax_Syntax.effect_args)
in (
# 1804 "FStar.TypeChecker.Rel.fst"
let guard = (let _151_1252 = (FStar_List.map (fun p -> (FStar_All.pipe_right (p_guard p) Prims.fst)) sub_probs)
in (FStar_Syntax_Util.mk_conj_l _151_1252))
in (
# 1805 "FStar.TypeChecker.Rel.fst"
let wl = (solve_prob orig (Some (guard)) [] wl)
in (solve env (attempt sub_probs wl)))))))
in if (FStar_Util.physical_equality c1 c2) then begin
(let _151_1253 = (solve_prob orig None [] wl)
in (solve env _151_1253))
end else begin
(
# 1809 "FStar.TypeChecker.Rel.fst"
let _69_2588 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_1255 = (FStar_Syntax_Print.comp_to_string c1)
in (let _151_1254 = (FStar_Syntax_Print.comp_to_string c2)
in (FStar_Util.print3 "solve_c %s %s %s\n" _151_1255 (rel_to_string problem.FStar_TypeChecker_Common.relation) _151_1254)))
end else begin
()
end
in (
# 1814 "FStar.TypeChecker.Rel.fst"
let r = (FStar_TypeChecker_Env.get_range env)
in (
# 1815 "FStar.TypeChecker.Rel.fst"
let _69_2593 = (c1, c2)
in (match (_69_2593) with
| (c1_0, c2_0) -> begin
(match ((c1.FStar_Syntax_Syntax.n, c2.FStar_Syntax_Syntax.n)) with
| (FStar_Syntax_Syntax.GTotal (_69_2595), FStar_Syntax_Syntax.Total (_69_2598)) -> begin
(giveup env "incompatible monad ordering: GTot </: Tot" orig)
end
| ((FStar_Syntax_Syntax.Total (t1), FStar_Syntax_Syntax.Total (t2))) | ((FStar_Syntax_Syntax.GTotal (t1), FStar_Syntax_Syntax.GTotal (t2))) | ((FStar_Syntax_Syntax.Total (t1), FStar_Syntax_Syntax.GTotal (t2))) -> begin
(let _151_1256 = (problem_using_guard orig t1 problem.FStar_TypeChecker_Common.relation t2 None "result type")
in (solve_t env _151_1256 wl))
end
| ((FStar_Syntax_Syntax.GTotal (_), FStar_Syntax_Syntax.Comp (_))) | ((FStar_Syntax_Syntax.Total (_), FStar_Syntax_Syntax.Comp (_))) -> begin
(let _151_1258 = (
# 1827 "FStar.TypeChecker.Rel.fst"
let _69_2626 = problem
in (let _151_1257 = (FStar_All.pipe_left FStar_Syntax_Syntax.mk_Comp (FStar_Syntax_Util.comp_to_comp_typ c1))
in {FStar_TypeChecker_Common.pid = _69_2626.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _151_1257; FStar_TypeChecker_Common.relation = _69_2626.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _69_2626.FStar_TypeChecker_Common.rhs; FStar_TypeChecker_Common.element = _69_2626.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_2626.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_2626.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_2626.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_2626.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_2626.FStar_TypeChecker_Common.rank}))
in (solve_c env _151_1258 wl))
end
| ((FStar_Syntax_Syntax.Comp (_), FStar_Syntax_Syntax.GTotal (_))) | ((FStar_Syntax_Syntax.Comp (_), FStar_Syntax_Syntax.Total (_))) -> begin
(let _151_1260 = (
# 1831 "FStar.TypeChecker.Rel.fst"
let _69_2642 = problem
in (let _151_1259 = (FStar_All.pipe_left FStar_Syntax_Syntax.mk_Comp (FStar_Syntax_Util.comp_to_comp_typ c2))
in {FStar_TypeChecker_Common.pid = _69_2642.FStar_TypeChecker_Common.pid; FStar_TypeChecker_Common.lhs = _69_2642.FStar_TypeChecker_Common.lhs; FStar_TypeChecker_Common.relation = _69_2642.FStar_TypeChecker_Common.relation; FStar_TypeChecker_Common.rhs = _151_1259; FStar_TypeChecker_Common.element = _69_2642.FStar_TypeChecker_Common.element; FStar_TypeChecker_Common.logical_guard = _69_2642.FStar_TypeChecker_Common.logical_guard; FStar_TypeChecker_Common.scope = _69_2642.FStar_TypeChecker_Common.scope; FStar_TypeChecker_Common.reason = _69_2642.FStar_TypeChecker_Common.reason; FStar_TypeChecker_Common.loc = _69_2642.FStar_TypeChecker_Common.loc; FStar_TypeChecker_Common.rank = _69_2642.FStar_TypeChecker_Common.rank}))
in (solve_c env _151_1260 wl))
end
| (FStar_Syntax_Syntax.Comp (_69_2645), FStar_Syntax_Syntax.Comp (_69_2648)) -> begin
if (((FStar_Syntax_Util.is_ml_comp c1) && (FStar_Syntax_Util.is_ml_comp c2)) || ((FStar_Syntax_Util.is_total_comp c1) && ((FStar_Syntax_Util.is_total_comp c2) || (FStar_Syntax_Util.is_ml_comp c2)))) then begin
(let _151_1261 = (problem_using_guard orig (FStar_Syntax_Util.comp_result c1) problem.FStar_TypeChecker_Common.relation (FStar_Syntax_Util.comp_result c2) None "result type")
in (solve_t env _151_1261 wl))
end else begin
(
# 1837 "FStar.TypeChecker.Rel.fst"
let c1_comp = (FStar_Syntax_Util.comp_to_comp_typ c1)
in (
# 1838 "FStar.TypeChecker.Rel.fst"
let c2_comp = (FStar_Syntax_Util.comp_to_comp_typ c2)
in if ((problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) && (FStar_Ident.lid_equals c1_comp.FStar_Syntax_Syntax.effect_name c2_comp.FStar_Syntax_Syntax.effect_name)) then begin
(solve_eq c1_comp c2_comp)
end else begin
(
# 1842 "FStar.TypeChecker.Rel.fst"
let c1 = (FStar_TypeChecker_Normalize.unfold_effect_abbrev env c1)
in (
# 1843 "FStar.TypeChecker.Rel.fst"
let c2 = (FStar_TypeChecker_Normalize.unfold_effect_abbrev env c2)
in (
# 1844 "FStar.TypeChecker.Rel.fst"
let _69_2655 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(FStar_Util.print2 "solve_c for %s and %s\n" c1.FStar_Syntax_Syntax.effect_name.FStar_Ident.str c2.FStar_Syntax_Syntax.effect_name.FStar_Ident.str)
end else begin
()
end
in (match ((FStar_TypeChecker_Env.monad_leq env c1.FStar_Syntax_Syntax.effect_name c2.FStar_Syntax_Syntax.effect_name)) with
| None -> begin
(let _151_1264 = (let _151_1263 = (FStar_Syntax_Print.lid_to_string c1.FStar_Syntax_Syntax.effect_name)
in (let _151_1262 = (FStar_Syntax_Print.lid_to_string c2.FStar_Syntax_Syntax.effect_name)
in (FStar_Util.format2 "incompatible monad ordering: %s </: %s" _151_1263 _151_1262)))
in (giveup env _151_1264 orig))
end
| Some (edge) -> begin
if (problem.FStar_TypeChecker_Common.relation = FStar_TypeChecker_Common.EQ) then begin
(
# 1851 "FStar.TypeChecker.Rel.fst"
let _69_2673 = (match (c1.FStar_Syntax_Syntax.effect_args) with
| (wp1, _69_2666)::(wlp1, _69_2662)::[] -> begin
(wp1, wlp1)
end
| _69_2670 -> begin
(let _151_1266 = (let _151_1265 = (FStar_Range.string_of_range (FStar_Ident.range_of_lid c1.FStar_Syntax_Syntax.effect_name))
in (FStar_Util.format1 "Unexpected number of indices on a normalized effect (%s)" _151_1265))
in (FStar_All.failwith _151_1266))
end)
in (match (_69_2673) with
| (wp, wlp) -> begin
(
# 1854 "FStar.TypeChecker.Rel.fst"
let c1 = (let _151_1272 = (let _151_1271 = (let _151_1267 = (edge.FStar_TypeChecker_Env.mlift c1.FStar_Syntax_Syntax.result_typ wp)
in (FStar_Syntax_Syntax.as_arg _151_1267))
in (let _151_1270 = (let _151_1269 = (let _151_1268 = (edge.FStar_TypeChecker_Env.mlift c1.FStar_Syntax_Syntax.result_typ wlp)
in (FStar_Syntax_Syntax.as_arg _151_1268))
in (_151_1269)::[])
in (_151_1271)::_151_1270))
in {FStar_Syntax_Syntax.effect_name = c2.FStar_Syntax_Syntax.effect_name; FStar_Syntax_Syntax.result_typ = c1.FStar_Syntax_Syntax.result_typ; FStar_Syntax_Syntax.effect_args = _151_1272; FStar_Syntax_Syntax.flags = c1.FStar_Syntax_Syntax.flags})
in (solve_eq c1 c2))
end))
end else begin
(
# 1861 "FStar.TypeChecker.Rel.fst"
let is_null_wp_2 = (FStar_All.pipe_right c2.FStar_Syntax_Syntax.flags (FStar_Util.for_some (fun _69_26 -> (match (_69_26) with
| (FStar_Syntax_Syntax.TOTAL) | (FStar_Syntax_Syntax.MLEFFECT) | (FStar_Syntax_Syntax.SOMETRIVIAL) -> begin
true
end
| _69_2680 -> begin
false
end))))
in (
# 1862 "FStar.TypeChecker.Rel.fst"
let _69_2701 = (match ((c1.FStar_Syntax_Syntax.effect_args, c2.FStar_Syntax_Syntax.effect_args)) with
| ((wp1, _69_2686)::_69_2683, (wp2, _69_2693)::_69_2690) -> begin
(wp1, wp2)
end
| _69_2698 -> begin
(let _151_1276 = (let _151_1275 = (FStar_Syntax_Print.lid_to_string c1.FStar_Syntax_Syntax.effect_name)
in (let _151_1274 = (FStar_Syntax_Print.lid_to_string c2.FStar_Syntax_Syntax.effect_name)
in (FStar_Util.format2 "Got effects %s and %s, expected normalized effects" _151_1275 _151_1274)))
in (FStar_All.failwith _151_1276))
end)
in (match (_69_2701) with
| (wpc1, wpc2) -> begin
if (FStar_Util.physical_equality wpc1 wpc2) then begin
(let _151_1277 = (problem_using_guard orig c1.FStar_Syntax_Syntax.result_typ problem.FStar_TypeChecker_Common.relation c2.FStar_Syntax_Syntax.result_typ None "result type")
in (solve_t env _151_1277 wl))
end else begin
(
# 1869 "FStar.TypeChecker.Rel.fst"
let c2_decl = (FStar_TypeChecker_Env.get_effect_decl env c2.FStar_Syntax_Syntax.effect_name)
in (
# 1870 "FStar.TypeChecker.Rel.fst"
let g = if is_null_wp_2 then begin
(
# 1872 "FStar.TypeChecker.Rel.fst"
let _69_2703 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(FStar_Util.print_string "Using trivial wp ... \n")
end else begin
()
end
in (let _151_1287 = (let _151_1286 = (let _151_1285 = (let _151_1279 = (let _151_1278 = (env.FStar_TypeChecker_Env.universe_of env c1.FStar_Syntax_Syntax.result_typ)
in (_151_1278)::[])
in (FStar_TypeChecker_Env.inst_effect_fun_with _151_1279 env c2_decl c2_decl.FStar_Syntax_Syntax.trivial))
in (let _151_1284 = (let _151_1283 = (FStar_Syntax_Syntax.as_arg c1.FStar_Syntax_Syntax.result_typ)
in (let _151_1282 = (let _151_1281 = (let _151_1280 = (edge.FStar_TypeChecker_Env.mlift c1.FStar_Syntax_Syntax.result_typ wpc1)
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _151_1280))
in (_151_1281)::[])
in (_151_1283)::_151_1282))
in (_151_1285, _151_1284)))
in FStar_Syntax_Syntax.Tm_app (_151_1286))
in (FStar_Syntax_Syntax.mk _151_1287 (Some (FStar_Syntax_Util.ktype0.FStar_Syntax_Syntax.n)) r)))
end else begin
(
# 1876 "FStar.TypeChecker.Rel.fst"
let wp2_imp_wp1 = (let _151_1302 = (let _151_1301 = (let _151_1300 = (let _151_1289 = (let _151_1288 = (env.FStar_TypeChecker_Env.universe_of env c2.FStar_Syntax_Syntax.result_typ)
in (_151_1288)::[])
in (FStar_TypeChecker_Env.inst_effect_fun_with _151_1289 env c2_decl c2_decl.FStar_Syntax_Syntax.wp_binop))
in (let _151_1299 = (let _151_1298 = (FStar_Syntax_Syntax.as_arg c2.FStar_Syntax_Syntax.result_typ)
in (let _151_1297 = (let _151_1296 = (FStar_Syntax_Syntax.as_arg wpc2)
in (let _151_1295 = (let _151_1294 = (let _151_1290 = (FStar_Syntax_Syntax.fvar None FStar_Syntax_Const.imp_lid r)
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _151_1290))
in (let _151_1293 = (let _151_1292 = (let _151_1291 = (edge.FStar_TypeChecker_Env.mlift c1.FStar_Syntax_Syntax.result_typ wpc1)
in (FStar_All.pipe_left FStar_Syntax_Syntax.as_arg _151_1291))
in (_151_1292)::[])
in (_151_1294)::_151_1293))
in (_151_1296)::_151_1295))
in (_151_1298)::_151_1297))
in (_151_1300, _151_1299)))
in FStar_Syntax_Syntax.Tm_app (_151_1301))
in (FStar_Syntax_Syntax.mk _151_1302 None r))
in (let _151_1311 = (let _151_1310 = (let _151_1309 = (let _151_1304 = (let _151_1303 = (env.FStar_TypeChecker_Env.universe_of env c2.FStar_Syntax_Syntax.result_typ)
in (_151_1303)::[])
in (FStar_TypeChecker_Env.inst_effect_fun_with _151_1304 env c2_decl c2_decl.FStar_Syntax_Syntax.wp_as_type))
in (let _151_1308 = (let _151_1307 = (FStar_Syntax_Syntax.as_arg c2.FStar_Syntax_Syntax.result_typ)
in (let _151_1306 = (let _151_1305 = (FStar_Syntax_Syntax.as_arg wp2_imp_wp1)
in (_151_1305)::[])
in (_151_1307)::_151_1306))
in (_151_1309, _151_1308)))
in FStar_Syntax_Syntax.Tm_app (_151_1310))
in (FStar_Syntax_Syntax.mk _151_1311 (Some (FStar_Syntax_Util.ktype0.FStar_Syntax_Syntax.n)) r)))
end
in (
# 1883 "FStar.TypeChecker.Rel.fst"
let base_prob = (let _151_1313 = (sub_prob c1.FStar_Syntax_Syntax.result_typ problem.FStar_TypeChecker_Common.relation c2.FStar_Syntax_Syntax.result_typ "result type")
in (FStar_All.pipe_left (fun _151_1312 -> FStar_TypeChecker_Common.TProb (_151_1312)) _151_1313))
in (
# 1884 "FStar.TypeChecker.Rel.fst"
let wl = (let _151_1317 = (let _151_1316 = (let _151_1315 = (FStar_All.pipe_right (p_guard base_prob) Prims.fst)
in (FStar_Syntax_Util.mk_conj _151_1315 g))
in (FStar_All.pipe_left (fun _151_1314 -> Some (_151_1314)) _151_1316))
in (solve_prob orig _151_1317 [] wl))
in (solve env (attempt ((base_prob)::[]) wl))))))
end
end)))
end
end))))
end))
end
end)
end))))
end))))))

# 1891 "FStar.TypeChecker.Rel.fst"
let print_pending_implicits : FStar_TypeChecker_Env.guard_t  ->  Prims.string = (fun g -> (let _151_1321 = (FStar_All.pipe_right g.FStar_TypeChecker_Env.implicits (FStar_List.map (fun _69_2719 -> (match (_69_2719) with
| (_69_2711, u, _69_2714, _69_2716, _69_2718) -> begin
(FStar_Syntax_Print.uvar_to_string u)
end))))
in (FStar_All.pipe_right _151_1321 (FStar_String.concat ", "))))

# 1893 "FStar.TypeChecker.Rel.fst"
let guard_to_string : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.guard_t  ->  Prims.string = (fun env g -> (match ((g.FStar_TypeChecker_Env.guard_f, g.FStar_TypeChecker_Env.deferred)) with
| (FStar_TypeChecker_Common.Trivial, []) -> begin
"{}"
end
| _69_2726 -> begin
(
# 1897 "FStar.TypeChecker.Rel.fst"
let form = (match (g.FStar_TypeChecker_Env.guard_f) with
| FStar_TypeChecker_Common.Trivial -> begin
"trivial"
end
| FStar_TypeChecker_Common.NonTrivial (f) -> begin
if ((FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) || (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Implicits")))) then begin
(FStar_TypeChecker_Normalize.term_to_string env f)
end else begin
"non-trivial"
end
end)
in (
# 1904 "FStar.TypeChecker.Rel.fst"
let carry = (let _151_1327 = (FStar_List.map (fun _69_2734 -> (match (_69_2734) with
| (_69_2732, x) -> begin
(prob_to_string env x)
end)) g.FStar_TypeChecker_Env.deferred)
in (FStar_All.pipe_right _151_1327 (FStar_String.concat ",\n")))
in (
# 1905 "FStar.TypeChecker.Rel.fst"
let imps = (print_pending_implicits g)
in (FStar_Util.format3 "\n\t{guard_f=%s;\n\t deferred={\n%s};\n\t implicits={%s}}\n" form carry imps))))
end))

# 1911 "FStar.TypeChecker.Rel.fst"
let guard_of_guard_formula : FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Env.guard_t = (fun g -> {FStar_TypeChecker_Env.guard_f = g; FStar_TypeChecker_Env.deferred = []; FStar_TypeChecker_Env.univ_ineqs = []; FStar_TypeChecker_Env.implicits = []})

# 1913 "FStar.TypeChecker.Rel.fst"
let guard_form : FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Common.guard_formula = (fun g -> g.FStar_TypeChecker_Env.guard_f)

# 1915 "FStar.TypeChecker.Rel.fst"
let is_trivial : FStar_TypeChecker_Env.guard_t  ->  Prims.bool = (fun g -> (match (g) with
| {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = []; FStar_TypeChecker_Env.univ_ineqs = _69_2743; FStar_TypeChecker_Env.implicits = _69_2741} -> begin
true
end
| _69_2748 -> begin
false
end))

# 1919 "FStar.TypeChecker.Rel.fst"
let trivial_guard : FStar_TypeChecker_Env.guard_t = {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = []; FStar_TypeChecker_Env.univ_ineqs = []; FStar_TypeChecker_Env.implicits = []}

# 1921 "FStar.TypeChecker.Rel.fst"
let abstract_guard : FStar_Syntax_Syntax.bv  ->  FStar_TypeChecker_Env.guard_t Prims.option  ->  FStar_TypeChecker_Env.guard_t Prims.option = (fun x g -> (match (g) with
| (None) | (Some ({FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = _; FStar_TypeChecker_Env.univ_ineqs = _; FStar_TypeChecker_Env.implicits = _})) -> begin
g
end
| Some (g) -> begin
(
# 1925 "FStar.TypeChecker.Rel.fst"
let f = (match (g.FStar_TypeChecker_Env.guard_f) with
| FStar_TypeChecker_Common.NonTrivial (f) -> begin
f
end
| _69_2766 -> begin
(FStar_All.failwith "impossible")
end)
in (let _151_1343 = (
# 1928 "FStar.TypeChecker.Rel.fst"
let _69_2768 = g
in (let _151_1342 = (let _151_1341 = (let _151_1340 = (let _151_1339 = (FStar_Syntax_Syntax.mk_binder x)
in (_151_1339)::[])
in (u_abs _151_1340 f))
in (FStar_All.pipe_left (fun _151_1338 -> FStar_TypeChecker_Common.NonTrivial (_151_1338)) _151_1341))
in {FStar_TypeChecker_Env.guard_f = _151_1342; FStar_TypeChecker_Env.deferred = _69_2768.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _69_2768.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _69_2768.FStar_TypeChecker_Env.implicits}))
in Some (_151_1343)))
end))

# 1930 "FStar.TypeChecker.Rel.fst"
let apply_guard : FStar_TypeChecker_Env.guard_t  ->  FStar_Syntax_Syntax.term  ->  FStar_TypeChecker_Env.guard_t = (fun g e -> (match (g.FStar_TypeChecker_Env.guard_f) with
| FStar_TypeChecker_Common.Trivial -> begin
g
end
| FStar_TypeChecker_Common.NonTrivial (f) -> begin
(
# 1932 "FStar.TypeChecker.Rel.fst"
let _69_2775 = g
in (let _151_1354 = (let _151_1353 = (let _151_1352 = (let _151_1351 = (let _151_1350 = (let _151_1349 = (FStar_Syntax_Syntax.as_arg e)
in (_151_1349)::[])
in (f, _151_1350))
in FStar_Syntax_Syntax.Tm_app (_151_1351))
in (FStar_Syntax_Syntax.mk _151_1352 (Some (FStar_Syntax_Util.ktype0.FStar_Syntax_Syntax.n)) f.FStar_Syntax_Syntax.pos))
in (FStar_All.pipe_left (fun _151_1348 -> FStar_TypeChecker_Common.NonTrivial (_151_1348)) _151_1353))
in {FStar_TypeChecker_Env.guard_f = _151_1354; FStar_TypeChecker_Env.deferred = _69_2775.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _69_2775.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _69_2775.FStar_TypeChecker_Env.implicits}))
end))

# 1934 "FStar.TypeChecker.Rel.fst"
let trivial : FStar_TypeChecker_Common.guard_formula  ->  Prims.unit = (fun t -> (match (t) with
| FStar_TypeChecker_Common.Trivial -> begin
()
end
| FStar_TypeChecker_Common.NonTrivial (_69_2780) -> begin
(FStar_All.failwith "impossible")
end))

# 1938 "FStar.TypeChecker.Rel.fst"
let conj_guard_f : FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Common.guard_formula = (fun g1 g2 -> (match ((g1, g2)) with
| ((FStar_TypeChecker_Common.Trivial, g)) | ((g, FStar_TypeChecker_Common.Trivial)) -> begin
g
end
| (FStar_TypeChecker_Common.NonTrivial (f1), FStar_TypeChecker_Common.NonTrivial (f2)) -> begin
(let _151_1361 = (FStar_Syntax_Util.mk_conj f1 f2)
in FStar_TypeChecker_Common.NonTrivial (_151_1361))
end))

# 1943 "FStar.TypeChecker.Rel.fst"
let check_trivial : (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax  ->  FStar_TypeChecker_Common.guard_formula = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (tc, _69_2797) when (FStar_Ident.lid_equals tc.FStar_Syntax_Syntax.v FStar_Syntax_Const.true_lid) -> begin
FStar_TypeChecker_Common.Trivial
end
| _69_2801 -> begin
FStar_TypeChecker_Common.NonTrivial (t)
end))

# 1947 "FStar.TypeChecker.Rel.fst"
let imp_guard_f : FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Common.guard_formula = (fun g1 g2 -> (match ((g1, g2)) with
| (FStar_TypeChecker_Common.Trivial, g) -> begin
g
end
| (g, FStar_TypeChecker_Common.Trivial) -> begin
FStar_TypeChecker_Common.Trivial
end
| (FStar_TypeChecker_Common.NonTrivial (f1), FStar_TypeChecker_Common.NonTrivial (f2)) -> begin
(
# 1951 "FStar.TypeChecker.Rel.fst"
let imp = (FStar_Syntax_Util.mk_imp f1 f2)
in (check_trivial imp))
end))

# 1953 "FStar.TypeChecker.Rel.fst"
let binop_guard : (FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Common.guard_formula  ->  FStar_TypeChecker_Common.guard_formula)  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun f g1 g2 -> (let _151_1384 = (f g1.FStar_TypeChecker_Env.guard_f g2.FStar_TypeChecker_Env.guard_f)
in {FStar_TypeChecker_Env.guard_f = _151_1384; FStar_TypeChecker_Env.deferred = (FStar_List.append g1.FStar_TypeChecker_Env.deferred g2.FStar_TypeChecker_Env.deferred); FStar_TypeChecker_Env.univ_ineqs = (FStar_List.append g1.FStar_TypeChecker_Env.univ_ineqs g2.FStar_TypeChecker_Env.univ_ineqs); FStar_TypeChecker_Env.implicits = (FStar_List.append g1.FStar_TypeChecker_Env.implicits g2.FStar_TypeChecker_Env.implicits)}))

# 1957 "FStar.TypeChecker.Rel.fst"
let conj_guard : FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun g1 g2 -> (binop_guard conj_guard_f g1 g2))

# 1958 "FStar.TypeChecker.Rel.fst"
let imp_guard : FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun g1 g2 -> (binop_guard imp_guard_f g1 g2))

# 1960 "FStar.TypeChecker.Rel.fst"
let close_guard : FStar_Syntax_Syntax.binders  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun binders g -> (match (g.FStar_TypeChecker_Env.guard_f) with
| FStar_TypeChecker_Common.Trivial -> begin
g
end
| FStar_TypeChecker_Common.NonTrivial (f) -> begin
(
# 1962 "FStar.TypeChecker.Rel.fst"
let _69_2828 = g
in (let _151_1399 = (let _151_1398 = (FStar_Syntax_Util.close_forall binders f)
in (FStar_All.pipe_right _151_1398 (fun _151_1397 -> FStar_TypeChecker_Common.NonTrivial (_151_1397))))
in {FStar_TypeChecker_Env.guard_f = _151_1399; FStar_TypeChecker_Env.deferred = _69_2828.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _69_2828.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _69_2828.FStar_TypeChecker_Env.implicits}))
end))

# 1967 "FStar.TypeChecker.Rel.fst"
let new_t_problem = (fun env lhs rel rhs elt loc -> (
# 1968 "FStar.TypeChecker.Rel.fst"
let reason = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("ExplainRel"))) then begin
(let _151_1407 = (FStar_TypeChecker_Normalize.term_to_string env lhs)
in (let _151_1406 = (FStar_TypeChecker_Normalize.term_to_string env rhs)
in (FStar_Util.format3 "Top-level:\n%s\n\t%s\n%s" _151_1407 (rel_to_string rel) _151_1406)))
end else begin
"TOP"
end
in (
# 1973 "FStar.TypeChecker.Rel.fst"
let p = (new_problem env lhs rel rhs elt loc reason)
in p)))

# 1976 "FStar.TypeChecker.Rel.fst"
let new_t_prob : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  FStar_TypeChecker_Common.rel  ->  FStar_Syntax_Syntax.term  ->  (FStar_TypeChecker_Common.prob * FStar_Syntax_Syntax.bv) = (fun env t1 rel t2 -> (
# 1977 "FStar.TypeChecker.Rel.fst"
let x = (let _151_1418 = (let _151_1417 = (FStar_TypeChecker_Env.get_range env)
in (FStar_All.pipe_left (fun _151_1416 -> Some (_151_1416)) _151_1417))
in (FStar_Syntax_Syntax.new_bv _151_1418 t1))
in (
# 1978 "FStar.TypeChecker.Rel.fst"
let env = (FStar_TypeChecker_Env.push_bv env x)
in (
# 1979 "FStar.TypeChecker.Rel.fst"
let p = (let _151_1422 = (let _151_1420 = (FStar_Syntax_Syntax.bv_to_name x)
in (FStar_All.pipe_left (fun _151_1419 -> Some (_151_1419)) _151_1420))
in (let _151_1421 = (FStar_TypeChecker_Env.get_range env)
in (new_t_problem env t1 rel t2 _151_1422 _151_1421)))
in (FStar_TypeChecker_Common.TProb (p), x)))))

# 1982 "FStar.TypeChecker.Rel.fst"
let solve_and_commit : FStar_TypeChecker_Env.env  ->  worklist  ->  ((FStar_TypeChecker_Common.prob * Prims.string)  ->  FStar_TypeChecker_Common.deferred Prims.option)  ->  FStar_TypeChecker_Common.deferred Prims.option = (fun env probs err -> (
# 1983 "FStar.TypeChecker.Rel.fst"
let probs = if (FStar_ST.read FStar_Options.eager_inference) then begin
(
# 1983 "FStar.TypeChecker.Rel.fst"
let _69_2848 = probs
in {attempting = _69_2848.attempting; wl_deferred = _69_2848.wl_deferred; ctr = _69_2848.ctr; defer_ok = false; smt_ok = _69_2848.smt_ok; tcenv = _69_2848.tcenv})
end else begin
probs
end
in (
# 1984 "FStar.TypeChecker.Rel.fst"
let tx = (FStar_Unionfind.new_transaction ())
in (
# 1985 "FStar.TypeChecker.Rel.fst"
let sol = (solve env probs)
in (match (sol) with
| Success (deferred) -> begin
(
# 1988 "FStar.TypeChecker.Rel.fst"
let _69_2855 = (FStar_Unionfind.commit tx)
in Some (deferred))
end
| Failed (d, s) -> begin
(
# 1991 "FStar.TypeChecker.Rel.fst"
let _69_2861 = (FStar_Unionfind.rollback tx)
in (
# 1992 "FStar.TypeChecker.Rel.fst"
let _69_2863 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("ExplainRel"))) then begin
(let _151_1434 = (explain env d s)
in (FStar_All.pipe_left FStar_Util.print_string _151_1434))
end else begin
()
end
in (err (d, s))))
end)))))

# 1996 "FStar.TypeChecker.Rel.fst"
let simplify_guard : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun env g -> (match (g.FStar_TypeChecker_Env.guard_f) with
| FStar_TypeChecker_Common.Trivial -> begin
g
end
| FStar_TypeChecker_Common.NonTrivial (f) -> begin
(
# 1999 "FStar.TypeChecker.Rel.fst"
let _69_2870 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Simplification"))) then begin
(let _151_1439 = (FStar_Syntax_Print.term_to_string f)
in (FStar_Util.print1 "Simplifying guard %s\n" _151_1439))
end else begin
()
end
in (
# 2000 "FStar.TypeChecker.Rel.fst"
let f = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Inline)::(FStar_TypeChecker_Normalize.Simplify)::[]) env f)
in (
# 2001 "FStar.TypeChecker.Rel.fst"
let _69_2873 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Simplification"))) then begin
(let _151_1440 = (FStar_Syntax_Print.term_to_string f)
in (FStar_Util.print1 "Simplified guard to %s\n" _151_1440))
end else begin
()
end
in (
# 2002 "FStar.TypeChecker.Rel.fst"
let f = (match ((let _151_1441 = (FStar_Syntax_Util.unmeta f)
in _151_1441.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_fvar (fv, _69_2877) when (FStar_Ident.lid_equals fv.FStar_Syntax_Syntax.v FStar_Syntax_Const.true_lid) -> begin
FStar_TypeChecker_Common.Trivial
end
| _69_2881 -> begin
FStar_TypeChecker_Common.NonTrivial (f)
end)
in (
# 2005 "FStar.TypeChecker.Rel.fst"
let _69_2883 = g
in {FStar_TypeChecker_Env.guard_f = f; FStar_TypeChecker_Env.deferred = _69_2883.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _69_2883.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _69_2883.FStar_TypeChecker_Env.implicits})))))
end))

# 2007 "FStar.TypeChecker.Rel.fst"
let with_guard : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Common.prob  ->  FStar_TypeChecker_Common.deferred Prims.option  ->  FStar_TypeChecker_Env.guard_t Prims.option = (fun env prob dopt -> (match (dopt) with
| None -> begin
None
end
| Some (d) -> begin
(let _151_1453 = (let _151_1452 = (let _151_1451 = (let _151_1450 = (FStar_All.pipe_right (p_guard prob) Prims.fst)
in (FStar_All.pipe_right _151_1450 (fun _151_1449 -> FStar_TypeChecker_Common.NonTrivial (_151_1449))))
in {FStar_TypeChecker_Env.guard_f = _151_1451; FStar_TypeChecker_Env.deferred = d; FStar_TypeChecker_Env.univ_ineqs = []; FStar_TypeChecker_Env.implicits = []})
in (simplify_guard env _151_1452))
in (FStar_All.pipe_left (fun _151_1448 -> Some (_151_1448)) _151_1453))
end))

# 2012 "FStar.TypeChecker.Rel.fst"
let try_teq : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_TypeChecker_Env.guard_t Prims.option = (fun env t1 t2 -> (
# 2013 "FStar.TypeChecker.Rel.fst"
let _69_2894 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_1461 = (FStar_Syntax_Print.term_to_string t1)
in (let _151_1460 = (FStar_Syntax_Print.term_to_string t2)
in (FStar_Util.print2 "try_teq of %s and %s\n" _151_1461 _151_1460)))
end else begin
()
end
in (
# 2015 "FStar.TypeChecker.Rel.fst"
let prob = (let _151_1464 = (let _151_1463 = (FStar_TypeChecker_Env.get_range env)
in (new_t_problem env t1 FStar_TypeChecker_Common.EQ t2 None _151_1463))
in (FStar_All.pipe_left (fun _151_1462 -> FStar_TypeChecker_Common.TProb (_151_1462)) _151_1464))
in (
# 2016 "FStar.TypeChecker.Rel.fst"
let g = (let _151_1466 = (solve_and_commit env (singleton env prob) (fun _69_2897 -> None))
in (FStar_All.pipe_left (with_guard env prob) _151_1466))
in g))))

# 2019 "FStar.TypeChecker.Rel.fst"
let teq : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_TypeChecker_Env.guard_t = (fun env t1 t2 -> (match ((try_teq env t1 t2)) with
| None -> begin
(let _151_1476 = (let _151_1475 = (let _151_1474 = (FStar_TypeChecker_Errors.basic_type_error env None t2 t1)
in (let _151_1473 = (FStar_TypeChecker_Env.get_range env)
in (_151_1474, _151_1473)))
in FStar_Syntax_Syntax.Error (_151_1475))
in (Prims.raise _151_1476))
end
| Some (g) -> begin
(
# 2023 "FStar.TypeChecker.Rel.fst"
let _69_2906 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_1479 = (FStar_Syntax_Print.term_to_string t1)
in (let _151_1478 = (FStar_Syntax_Print.term_to_string t2)
in (let _151_1477 = (guard_to_string env g)
in (FStar_Util.print3 "teq of %s and %s succeeded with guard %s\n" _151_1479 _151_1478 _151_1477))))
end else begin
()
end
in g)
end))

# 2030 "FStar.TypeChecker.Rel.fst"
let try_subtype : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_TypeChecker_Env.guard_t Prims.option = (fun env t1 t2 -> (
# 2031 "FStar.TypeChecker.Rel.fst"
let _69_2911 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_1487 = (FStar_TypeChecker_Normalize.term_to_string env t1)
in (let _151_1486 = (FStar_TypeChecker_Normalize.term_to_string env t2)
in (FStar_Util.print2 "try_subtype of %s and %s\n" _151_1487 _151_1486)))
end else begin
()
end
in (
# 2033 "FStar.TypeChecker.Rel.fst"
let _69_2915 = (new_t_prob env t1 FStar_TypeChecker_Common.SUB t2)
in (match (_69_2915) with
| (prob, x) -> begin
(
# 2034 "FStar.TypeChecker.Rel.fst"
let g = (let _151_1489 = (solve_and_commit env (singleton env prob) (fun _69_2916 -> None))
in (FStar_All.pipe_left (with_guard env prob) _151_1489))
in (
# 2035 "FStar.TypeChecker.Rel.fst"
let _69_2919 = if ((FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) && (FStar_Util.is_some g)) then begin
(let _151_1493 = (FStar_TypeChecker_Normalize.term_to_string env t1)
in (let _151_1492 = (FStar_TypeChecker_Normalize.term_to_string env t2)
in (let _151_1491 = (let _151_1490 = (FStar_Util.must g)
in (guard_to_string env _151_1490))
in (FStar_Util.print3 "try_subtype succeeded: %s <: %s\n\tguard is %s\n" _151_1493 _151_1492 _151_1491))))
end else begin
()
end
in (abstract_guard x g)))
end))))

# 2043 "FStar.TypeChecker.Rel.fst"
let subtype_fail = (fun env t1 t2 -> (let _151_1500 = (let _151_1499 = (let _151_1498 = (FStar_TypeChecker_Errors.basic_type_error env None t2 t1)
in (let _151_1497 = (FStar_TypeChecker_Env.get_range env)
in (_151_1498, _151_1497)))
in FStar_Syntax_Syntax.Error (_151_1499))
in (Prims.raise _151_1500)))

# 2047 "FStar.TypeChecker.Rel.fst"
let sub_comp : FStar_TypeChecker_Env.env  ->  FStar_Syntax_Syntax.comp  ->  FStar_Syntax_Syntax.comp  ->  FStar_TypeChecker_Env.guard_t Prims.option = (fun env c1 c2 -> (
# 2048 "FStar.TypeChecker.Rel.fst"
let _69_2927 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_1508 = (FStar_Syntax_Print.comp_to_string c1)
in (let _151_1507 = (FStar_Syntax_Print.comp_to_string c2)
in (FStar_Util.print2 "sub_comp of %s and %s\n" _151_1508 _151_1507)))
end else begin
()
end
in (
# 2050 "FStar.TypeChecker.Rel.fst"
let rel = if env.FStar_TypeChecker_Env.use_eq then begin
FStar_TypeChecker_Common.EQ
end else begin
FStar_TypeChecker_Common.SUB
end
in (
# 2051 "FStar.TypeChecker.Rel.fst"
let prob = (let _151_1511 = (let _151_1510 = (FStar_TypeChecker_Env.get_range env)
in (new_problem env c1 rel c2 None _151_1510 "sub_comp"))
in (FStar_All.pipe_left (fun _151_1509 -> FStar_TypeChecker_Common.CProb (_151_1509)) _151_1511))
in (let _151_1513 = (solve_and_commit env (singleton env prob) (fun _69_2931 -> None))
in (FStar_All.pipe_left (with_guard env prob) _151_1513))))))

# 2055 "FStar.TypeChecker.Rel.fst"
let solve_universe_inequalities' : FStar_Unionfind.tx  ->  FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.universe * FStar_Syntax_Syntax.universe) Prims.list  ->  Prims.unit = (fun tx env ineqs -> (
# 2056 "FStar.TypeChecker.Rel.fst"
let fail = (fun msg u1 u2 -> (
# 2057 "FStar.TypeChecker.Rel.fst"
let _69_2940 = (FStar_Unionfind.rollback tx)
in (
# 2058 "FStar.TypeChecker.Rel.fst"
let msg = (match (msg) with
| None -> begin
""
end
| Some (s) -> begin
(Prims.strcat ": " s)
end)
in (let _151_1531 = (let _151_1530 = (let _151_1529 = (let _151_1527 = (FStar_Syntax_Print.univ_to_string u1)
in (let _151_1526 = (FStar_Syntax_Print.univ_to_string u2)
in (FStar_Util.format3 "Universe %s and %s are incompatible%s" _151_1527 _151_1526 msg)))
in (let _151_1528 = (FStar_TypeChecker_Env.get_range env)
in (_151_1529, _151_1528)))
in FStar_Syntax_Syntax.Error (_151_1530))
in (Prims.raise _151_1531)))))
in (
# 2067 "FStar.TypeChecker.Rel.fst"
let rec insert = (fun uv u1 groups -> (match (groups) with
| [] -> begin
((uv, (u1)::[]))::[]
end
| hd::tl -> begin
(
# 2070 "FStar.TypeChecker.Rel.fst"
let _69_2956 = hd
in (match (_69_2956) with
| (uv', lower_bounds) -> begin
if (FStar_Unionfind.equivalent uv uv') then begin
((uv', (u1)::lower_bounds))::tl
end else begin
(let _151_1538 = (insert uv u1 tl)
in (hd)::_151_1538)
end
end))
end))
in (
# 2075 "FStar.TypeChecker.Rel.fst"
let rec group_by = (fun out ineqs -> (match (ineqs) with
| [] -> begin
Some (out)
end
| (u1, u2)::rest -> begin
(
# 2078 "FStar.TypeChecker.Rel.fst"
let u2 = (FStar_TypeChecker_Normalize.normalize_universe env u2)
in (match (u2) with
| FStar_Syntax_Syntax.U_unif (uv) -> begin
(
# 2081 "FStar.TypeChecker.Rel.fst"
let u1 = (FStar_TypeChecker_Normalize.normalize_universe env u1)
in if (FStar_Syntax_Util.eq_univs u1 u2) then begin
(group_by out rest)
end else begin
(let _151_1543 = (insert uv u1 out)
in (group_by _151_1543 rest))
end)
end
| _69_2971 -> begin
None
end))
end))
in (
# 2088 "FStar.TypeChecker.Rel.fst"
let ad_hoc_fallback = (fun _69_2973 -> (match (()) with
| () -> begin
(match (ineqs) with
| [] -> begin
()
end
| _69_2976 -> begin
(
# 2093 "FStar.TypeChecker.Rel.fst"
let wl = (
# 2093 "FStar.TypeChecker.Rel.fst"
let _69_2977 = (empty_worklist env)
in {attempting = _69_2977.attempting; wl_deferred = _69_2977.wl_deferred; ctr = _69_2977.ctr; defer_ok = true; smt_ok = _69_2977.smt_ok; tcenv = _69_2977.tcenv})
in (
# 2094 "FStar.TypeChecker.Rel.fst"
let _69_3017 = (FStar_All.pipe_right ineqs (FStar_List.iter (fun _69_2982 -> (match (_69_2982) with
| (u1, u2) -> begin
(
# 2095 "FStar.TypeChecker.Rel.fst"
let u1 = (FStar_TypeChecker_Normalize.normalize_universe env u1)
in (
# 2096 "FStar.TypeChecker.Rel.fst"
let u2 = (FStar_TypeChecker_Normalize.normalize_universe env u2)
in (match (u1) with
| FStar_Syntax_Syntax.U_zero -> begin
()
end
| _69_2987 -> begin
(match ((solve_universe_eq (- (1)) wl u1 u2)) with
| (UDeferred (_)) | (UFailed (_)) -> begin
(
# 2102 "FStar.TypeChecker.Rel.fst"
let us1 = (match (u1) with
| FStar_Syntax_Syntax.U_max (us1) -> begin
us1
end
| _69_2997 -> begin
(u1)::[]
end)
in (
# 2105 "FStar.TypeChecker.Rel.fst"
let us2 = (match (u2) with
| FStar_Syntax_Syntax.U_max (us2) -> begin
us2
end
| _69_3002 -> begin
(u2)::[]
end)
in if (FStar_All.pipe_right us1 (FStar_Util.for_all (fun _69_27 -> (match (_69_27) with
| FStar_Syntax_Syntax.U_zero -> begin
true
end
| u -> begin
(
# 2111 "FStar.TypeChecker.Rel.fst"
let _69_3009 = (FStar_Syntax_Util.univ_kernel u)
in (match (_69_3009) with
| (k_u, n) -> begin
(FStar_All.pipe_right us2 (FStar_Util.for_some (fun u' -> (
# 2113 "FStar.TypeChecker.Rel.fst"
let _69_3013 = (FStar_Syntax_Util.univ_kernel u')
in (match (_69_3013) with
| (k_u', n') -> begin
((FStar_Syntax_Util.eq_univs k_u k_u') && (n <= n'))
end)))))
end))
end)))) then begin
()
end else begin
(fail None u1 u2)
end))
end
| USolved (_69_3015) -> begin
()
end)
end)))
end))))
in (FStar_TypeChecker_Errors.warn FStar_Range.dummyRange "Universe inequality check not fully implemented")))
end)
end))
in (match ((group_by [] ineqs)) with
| Some (groups) -> begin
(
# 2124 "FStar.TypeChecker.Rel.fst"
let wl = (
# 2124 "FStar.TypeChecker.Rel.fst"
let _69_3021 = (empty_worklist env)
in {attempting = _69_3021.attempting; wl_deferred = _69_3021.wl_deferred; ctr = _69_3021.ctr; defer_ok = false; smt_ok = _69_3021.smt_ok; tcenv = _69_3021.tcenv})
in (
# 2125 "FStar.TypeChecker.Rel.fst"
let rec solve_all_groups = (fun wl groups -> (match (groups) with
| [] -> begin
()
end
| (u, lower_bounds)::groups -> begin
(match ((solve_universe_eq (- (1)) wl (FStar_Syntax_Syntax.U_max (lower_bounds)) (FStar_Syntax_Syntax.U_unif (u)))) with
| USolved (wl) -> begin
(solve_all_groups wl groups)
end
| _69_3036 -> begin
(ad_hoc_fallback ())
end)
end))
in (solve_all_groups wl groups)))
end
| None -> begin
(ad_hoc_fallback ())
end))))))

# 2137 "FStar.TypeChecker.Rel.fst"
let solve_universe_inequalities : FStar_TypeChecker_Env.env  ->  (FStar_Syntax_Syntax.universe * FStar_Syntax_Syntax.universe) Prims.list  ->  Prims.unit = (fun env ineqs -> (
# 2138 "FStar.TypeChecker.Rel.fst"
let tx = (FStar_Unionfind.new_transaction ())
in (
# 2139 "FStar.TypeChecker.Rel.fst"
let _69_3041 = (solve_universe_inequalities' tx env ineqs)
in (FStar_Unionfind.commit tx))))

# 2142 "FStar.TypeChecker.Rel.fst"
let rec solve_deferred_constraints : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun env g -> (
# 2143 "FStar.TypeChecker.Rel.fst"
let fail = (fun _69_3048 -> (match (_69_3048) with
| (d, s) -> begin
(
# 2144 "FStar.TypeChecker.Rel.fst"
let msg = (explain env d s)
in (Prims.raise (FStar_Syntax_Syntax.Error ((msg, (p_loc d))))))
end))
in (
# 2146 "FStar.TypeChecker.Rel.fst"
let wl = (wl_of_guard env g.FStar_TypeChecker_Env.deferred)
in (
# 2147 "FStar.TypeChecker.Rel.fst"
let _69_3051 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(let _151_1564 = (wl_to_string wl)
in (let _151_1563 = (FStar_Util.string_of_int (FStar_List.length g.FStar_TypeChecker_Env.implicits))
in (FStar_Util.print2 "Trying to solve carried problems: begin\n\t%s\nend\n and %s implicits\n" _151_1564 _151_1563)))
end else begin
()
end
in (
# 2149 "FStar.TypeChecker.Rel.fst"
let g = (match ((solve_and_commit env wl fail)) with
| Some ([]) -> begin
(
# 2150 "FStar.TypeChecker.Rel.fst"
let _69_3055 = g
in {FStar_TypeChecker_Env.guard_f = _69_3055.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = []; FStar_TypeChecker_Env.univ_ineqs = _69_3055.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _69_3055.FStar_TypeChecker_Env.implicits})
end
| _69_3058 -> begin
(FStar_All.failwith "impossible: Unexpected deferred constraints remain")
end)
in (
# 2152 "FStar.TypeChecker.Rel.fst"
let _69_3060 = (solve_universe_inequalities env g.FStar_TypeChecker_Env.univ_ineqs)
in (
# 2153 "FStar.TypeChecker.Rel.fst"
let _69_3062 = g
in {FStar_TypeChecker_Env.guard_f = _69_3062.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = _69_3062.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = []; FStar_TypeChecker_Env.implicits = _69_3062.FStar_TypeChecker_Env.implicits})))))))

# 2155 "FStar.TypeChecker.Rel.fst"
let discharge_guard : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun env g -> (
# 2156 "FStar.TypeChecker.Rel.fst"
let g = (solve_deferred_constraints env g)
in (
# 2157 "FStar.TypeChecker.Rel.fst"
let _69_3076 = if (not ((FStar_Options.should_verify env.FStar_TypeChecker_Env.curmodule.FStar_Ident.str))) then begin
()
end else begin
(match (g.FStar_TypeChecker_Env.guard_f) with
| FStar_TypeChecker_Common.Trivial -> begin
()
end
| FStar_TypeChecker_Common.NonTrivial (vc) -> begin
(
# 2161 "FStar.TypeChecker.Rel.fst"
let vc = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Inline)::(FStar_TypeChecker_Normalize.Beta)::(FStar_TypeChecker_Normalize.Eta)::(FStar_TypeChecker_Normalize.Simplify)::[]) env vc)
in (match ((check_trivial vc)) with
| FStar_TypeChecker_Common.Trivial -> begin
()
end
| FStar_TypeChecker_Common.NonTrivial (vc) -> begin
(
# 2165 "FStar.TypeChecker.Rel.fst"
let _69_3074 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _151_1571 = (FStar_TypeChecker_Env.get_range env)
in (let _151_1570 = (let _151_1569 = (FStar_Syntax_Print.term_to_string vc)
in (FStar_Util.format1 "Checking VC=\n%s\n" _151_1569))
in (FStar_TypeChecker_Errors.diag _151_1571 _151_1570)))
end else begin
()
end
in (env.FStar_TypeChecker_Env.solver.FStar_TypeChecker_Env.solve env vc))
end))
end)
end
in (
# 2170 "FStar.TypeChecker.Rel.fst"
let _69_3078 = g
in {FStar_TypeChecker_Env.guard_f = FStar_TypeChecker_Common.Trivial; FStar_TypeChecker_Env.deferred = _69_3078.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _69_3078.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _69_3078.FStar_TypeChecker_Env.implicits}))))

# 2172 "FStar.TypeChecker.Rel.fst"
let resolve_implicits : FStar_TypeChecker_Env.guard_t  ->  FStar_TypeChecker_Env.guard_t = (fun g -> (
# 2173 "FStar.TypeChecker.Rel.fst"
let unresolved = (fun u -> (match ((FStar_Unionfind.find u)) with
| FStar_Syntax_Syntax.Uvar -> begin
true
end
| _69_3085 -> begin
false
end))
in (
# 2176 "FStar.TypeChecker.Rel.fst"
let rec until_fixpoint = (fun _69_3089 implicits -> (match (_69_3089) with
| (out, changed) -> begin
(match (implicits) with
| [] -> begin
if (not (changed)) then begin
out
end else begin
(until_fixpoint ([], false) out)
end
end
| hd::tl -> begin
(
# 2180 "FStar.TypeChecker.Rel.fst"
let _69_3100 = hd
in (match (_69_3100) with
| (env, u, tm, k, r) -> begin
if (unresolved u) then begin
(until_fixpoint ((hd)::out, changed) tl)
end else begin
(
# 2183 "FStar.TypeChecker.Rel.fst"
let env = (FStar_TypeChecker_Env.set_expected_typ env k)
in (
# 2184 "FStar.TypeChecker.Rel.fst"
let tm = (FStar_TypeChecker_Normalize.normalize ((FStar_TypeChecker_Normalize.Beta)::[]) env tm)
in (
# 2185 "FStar.TypeChecker.Rel.fst"
let _69_3103 = if (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env) (FStar_Options.Other ("RelCheck"))) then begin
(let _151_1582 = (FStar_Syntax_Print.uvar_to_string u)
in (let _151_1581 = (FStar_Syntax_Print.term_to_string tm)
in (let _151_1580 = (FStar_Syntax_Print.term_to_string k)
in (FStar_Util.print3 "Checking uvar %s resolved to %s at type %s\n" _151_1582 _151_1581 _151_1580))))
end else begin
()
end
in (
# 2188 "FStar.TypeChecker.Rel.fst"
let _69_3110 = (env.FStar_TypeChecker_Env.type_of (
# 2188 "FStar.TypeChecker.Rel.fst"
let _69_3105 = env
in {FStar_TypeChecker_Env.solver = _69_3105.FStar_TypeChecker_Env.solver; FStar_TypeChecker_Env.range = _69_3105.FStar_TypeChecker_Env.range; FStar_TypeChecker_Env.curmodule = _69_3105.FStar_TypeChecker_Env.curmodule; FStar_TypeChecker_Env.gamma = _69_3105.FStar_TypeChecker_Env.gamma; FStar_TypeChecker_Env.gamma_cache = _69_3105.FStar_TypeChecker_Env.gamma_cache; FStar_TypeChecker_Env.modules = _69_3105.FStar_TypeChecker_Env.modules; FStar_TypeChecker_Env.expected_typ = _69_3105.FStar_TypeChecker_Env.expected_typ; FStar_TypeChecker_Env.sigtab = _69_3105.FStar_TypeChecker_Env.sigtab; FStar_TypeChecker_Env.is_pattern = _69_3105.FStar_TypeChecker_Env.is_pattern; FStar_TypeChecker_Env.instantiate_imp = _69_3105.FStar_TypeChecker_Env.instantiate_imp; FStar_TypeChecker_Env.effects = _69_3105.FStar_TypeChecker_Env.effects; FStar_TypeChecker_Env.generalize = _69_3105.FStar_TypeChecker_Env.generalize; FStar_TypeChecker_Env.letrecs = _69_3105.FStar_TypeChecker_Env.letrecs; FStar_TypeChecker_Env.top_level = _69_3105.FStar_TypeChecker_Env.top_level; FStar_TypeChecker_Env.check_uvars = _69_3105.FStar_TypeChecker_Env.check_uvars; FStar_TypeChecker_Env.use_eq = _69_3105.FStar_TypeChecker_Env.use_eq; FStar_TypeChecker_Env.is_iface = _69_3105.FStar_TypeChecker_Env.is_iface; FStar_TypeChecker_Env.admit = _69_3105.FStar_TypeChecker_Env.admit; FStar_TypeChecker_Env.default_effects = _69_3105.FStar_TypeChecker_Env.default_effects; FStar_TypeChecker_Env.type_of = _69_3105.FStar_TypeChecker_Env.type_of; FStar_TypeChecker_Env.universe_of = _69_3105.FStar_TypeChecker_Env.universe_of; FStar_TypeChecker_Env.use_bv_sorts = true}) tm)
in (match (_69_3110) with
| (_69_3108, g) -> begin
(
# 2189 "FStar.TypeChecker.Rel.fst"
let g' = (discharge_guard env g)
in (until_fixpoint ((FStar_List.append g'.FStar_TypeChecker_Env.implicits out), true) tl))
end)))))
end
end))
end)
end))
in (
# 2191 "FStar.TypeChecker.Rel.fst"
let _69_3112 = g
in (let _151_1583 = (until_fixpoint ([], false) g.FStar_TypeChecker_Env.implicits)
in {FStar_TypeChecker_Env.guard_f = _69_3112.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = _69_3112.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = _69_3112.FStar_TypeChecker_Env.univ_ineqs; FStar_TypeChecker_Env.implicits = _151_1583})))))

# 2193 "FStar.TypeChecker.Rel.fst"
let force_trivial_guard : FStar_TypeChecker_Env.env  ->  FStar_TypeChecker_Env.guard_t  ->  Prims.unit = (fun env g -> (
# 2194 "FStar.TypeChecker.Rel.fst"
let g = (let _151_1588 = (solve_deferred_constraints env g)
in (FStar_All.pipe_right _151_1588 resolve_implicits))
in (match (g.FStar_TypeChecker_Env.implicits) with
| [] -> begin
(let _151_1589 = (discharge_guard env g)
in (FStar_All.pipe_left Prims.ignore _151_1589))
end
| (_69_3121, _69_3123, _69_3125, _69_3127, r)::_69_3119 -> begin
(Prims.raise (FStar_Syntax_Syntax.Error (("Failed to resolve implicit argument", r))))
end)))

# 2199 "FStar.TypeChecker.Rel.fst"
let universe_inequality : FStar_Syntax_Syntax.universe  ->  FStar_Syntax_Syntax.universe  ->  FStar_TypeChecker_Env.guard_t = (fun u1 u2 -> (
# 2201 "FStar.TypeChecker.Rel.fst"
let _69_3133 = trivial_guard
in {FStar_TypeChecker_Env.guard_f = _69_3133.FStar_TypeChecker_Env.guard_f; FStar_TypeChecker_Env.deferred = _69_3133.FStar_TypeChecker_Env.deferred; FStar_TypeChecker_Env.univ_ineqs = ((u1, u2))::[]; FStar_TypeChecker_Env.implicits = _69_3133.FStar_TypeChecker_Env.implicits}))




