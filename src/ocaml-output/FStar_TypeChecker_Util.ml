open Prims
type lcomp_with_binder =
  (FStar_Syntax_Syntax.bv FStar_Pervasives_Native.option *
    FStar_TypeChecker_Common.lcomp)
let (report : FStar_TypeChecker_Env.env -> Prims.string Prims.list -> unit) =
  fun env ->
    fun errs ->
      let uu____22 = FStar_TypeChecker_Env.get_range env in
      let uu____23 = FStar_TypeChecker_Err.failed_to_prove_specification errs in
      FStar_Errors.log_issue uu____22 uu____23
let (new_implicit_var :
  Prims.string ->
    FStar_Range.range ->
      FStar_TypeChecker_Env.env ->
        FStar_Syntax_Syntax.typ ->
          (FStar_Syntax_Syntax.term * (FStar_Syntax_Syntax.ctx_uvar *
            FStar_Range.range) Prims.list * FStar_TypeChecker_Common.guard_t))
  =
  fun reason ->
    fun r ->
      fun env ->
        fun k ->
          FStar_TypeChecker_Env.new_implicit_var_aux reason r env k
            FStar_Syntax_Syntax.Strict FStar_Pervasives_Native.None
let (close_guard_implicits :
  FStar_TypeChecker_Env.env ->
    Prims.bool ->
      FStar_Syntax_Syntax.binders ->
        FStar_TypeChecker_Common.guard_t -> FStar_TypeChecker_Common.guard_t)
  =
  fun env ->
    fun solve_deferred ->
      fun xs ->
        fun g ->
          let uu____87 = (FStar_Options.eager_subtyping ()) || solve_deferred in
          if uu____87
          then
            let uu____90 =
              FStar_All.pipe_right g.FStar_TypeChecker_Common.deferred
                (FStar_List.partition
                   (fun uu____142 ->
                      match uu____142 with
                      | (uu____149, p) ->
                          FStar_TypeChecker_Rel.flex_prob_closing env xs p)) in
            match uu____90 with
            | (solve_now, defer) ->
                ((let uu____184 =
                    FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
                      (FStar_Options.Other "Rel") in
                  if uu____184
                  then
                    (FStar_Util.print_string "SOLVE BEFORE CLOSING:\n";
                     FStar_List.iter
                       (fun uu____201 ->
                          match uu____201 with
                          | (s, p) ->
                              let uu____211 =
                                FStar_TypeChecker_Rel.prob_to_string env p in
                              FStar_Util.print2 "%s: %s\n" s uu____211)
                       solve_now;
                     FStar_Util.print_string " ...DEFERRED THE REST:\n";
                     FStar_List.iter
                       (fun uu____226 ->
                          match uu____226 with
                          | (s, p) ->
                              let uu____236 =
                                FStar_TypeChecker_Rel.prob_to_string env p in
                              FStar_Util.print2 "%s: %s\n" s uu____236) defer;
                     FStar_Util.print_string "END\n")
                  else ());
                 (let g1 =
                    FStar_TypeChecker_Rel.solve_deferred_constraints env
                      (let uu___49_244 = g in
                       {
                         FStar_TypeChecker_Common.guard_f =
                           (uu___49_244.FStar_TypeChecker_Common.guard_f);
                         FStar_TypeChecker_Common.deferred_to_tac =
                           (uu___49_244.FStar_TypeChecker_Common.deferred_to_tac);
                         FStar_TypeChecker_Common.deferred = solve_now;
                         FStar_TypeChecker_Common.univ_ineqs =
                           (uu___49_244.FStar_TypeChecker_Common.univ_ineqs);
                         FStar_TypeChecker_Common.implicits =
                           (uu___49_244.FStar_TypeChecker_Common.implicits)
                       }) in
                  let g2 =
                    let uu___52_246 = g1 in
                    {
                      FStar_TypeChecker_Common.guard_f =
                        (uu___52_246.FStar_TypeChecker_Common.guard_f);
                      FStar_TypeChecker_Common.deferred_to_tac =
                        (uu___52_246.FStar_TypeChecker_Common.deferred_to_tac);
                      FStar_TypeChecker_Common.deferred = defer;
                      FStar_TypeChecker_Common.univ_ineqs =
                        (uu___52_246.FStar_TypeChecker_Common.univ_ineqs);
                      FStar_TypeChecker_Common.implicits =
                        (uu___52_246.FStar_TypeChecker_Common.implicits)
                    } in
                  g2))
          else g
let (check_uvars : FStar_Range.range -> FStar_Syntax_Syntax.typ -> unit) =
  fun r ->
    fun t ->
      let uvs = FStar_Syntax_Free.uvars t in
      let uu____263 =
        let uu____265 = FStar_Util.set_is_empty uvs in
        Prims.op_Negation uu____265 in
      if uu____263
      then
        let us =
          let uu____270 =
            let uu____274 = FStar_Util.set_elements uvs in
            FStar_List.map
              (fun u ->
                 FStar_Syntax_Print.uvar_to_string
                   u.FStar_Syntax_Syntax.ctx_uvar_head) uu____274 in
          FStar_All.pipe_right uu____270 (FStar_String.concat ", ") in
        (FStar_Options.push ();
         FStar_Options.set_option "hide_uvar_nums" (FStar_Options.Bool false);
         FStar_Options.set_option "print_implicits" (FStar_Options.Bool true);
         (let uu____293 =
            let uu____299 =
              let uu____301 = FStar_Syntax_Print.term_to_string t in
              FStar_Util.format2
                "Unconstrained unification variables %s in type signature %s; please add an annotation"
                us uu____301 in
            (FStar_Errors.Error_UncontrainedUnificationVar, uu____299) in
          FStar_Errors.log_issue r uu____293);
         FStar_Options.pop ())
      else ()
let (extract_let_rec_annotation :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.letbinding ->
      (FStar_Syntax_Syntax.univ_names * FStar_Syntax_Syntax.typ * Prims.bool))
  =
  fun env ->
    fun uu____324 ->
      match uu____324 with
      | { FStar_Syntax_Syntax.lbname = lbname;
          FStar_Syntax_Syntax.lbunivs = univ_vars;
          FStar_Syntax_Syntax.lbtyp = t;
          FStar_Syntax_Syntax.lbeff = uu____335;
          FStar_Syntax_Syntax.lbdef = e;
          FStar_Syntax_Syntax.lbattrs = uu____337;
          FStar_Syntax_Syntax.lbpos = uu____338;_} ->
          let rng = FStar_Syntax_Syntax.range_of_lbname lbname in
          let t1 = FStar_Syntax_Subst.compress t in
          (match t1.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Tm_unknown ->
               let uu____373 = FStar_Syntax_Subst.open_univ_vars univ_vars e in
               (match uu____373 with
                | (univ_vars1, e1) ->
                    let env1 =
                      FStar_TypeChecker_Env.push_univ_vars env univ_vars1 in
                    let r = FStar_TypeChecker_Env.get_range env1 in
                    let rec aux e2 =
                      let e3 = FStar_Syntax_Subst.compress e2 in
                      match e3.FStar_Syntax_Syntax.n with
                      | FStar_Syntax_Syntax.Tm_meta (e4, uu____411) -> aux e4
                      | FStar_Syntax_Syntax.Tm_ascribed (e4, t2, uu____418)
                          -> FStar_Pervasives_Native.fst t2
                      | FStar_Syntax_Syntax.Tm_abs (bs, body, uu____473) ->
                          let res = aux body in
                          let c =
                            match res with
                            | FStar_Util.Inl t2 ->
                                let uu____509 = FStar_Options.ml_ish () in
                                if uu____509
                                then FStar_Syntax_Util.ml_comp t2 r
                                else FStar_Syntax_Syntax.mk_Total t2
                            | FStar_Util.Inr c -> c in
                          let t2 =
                            FStar_Syntax_Syntax.mk
                              (FStar_Syntax_Syntax.Tm_arrow (bs, c))
                              c.FStar_Syntax_Syntax.pos in
                          ((let uu____531 =
                              FStar_TypeChecker_Env.debug env1
                                FStar_Options.High in
                            if uu____531
                            then
                              let uu____534 = FStar_Range.string_of_range r in
                              let uu____536 =
                                FStar_Syntax_Print.term_to_string t2 in
                              FStar_Util.print2 "(%s) Using type %s\n"
                                uu____534 uu____536
                            else ());
                           FStar_Util.Inl t2)
                      | uu____541 -> FStar_Util.Inl FStar_Syntax_Syntax.tun in
                    let t2 =
                      let uu____543 = aux e1 in
                      match uu____543 with
                      | FStar_Util.Inr c ->
                          let uu____549 =
                            FStar_Syntax_Util.is_tot_or_gtot_comp c in
                          if uu____549
                          then FStar_Syntax_Util.comp_result c
                          else
                            (let uu____554 =
                               let uu____560 =
                                 let uu____562 =
                                   FStar_Syntax_Print.comp_to_string c in
                                 FStar_Util.format1
                                   "Expected a 'let rec' to be annotated with a value type; got a computation type %s"
                                   uu____562 in
                               (FStar_Errors.Fatal_UnexpectedComputationTypeForLetRec,
                                 uu____560) in
                             FStar_Errors.raise_error uu____554 rng)
                      | FStar_Util.Inl t2 -> t2 in
                    (univ_vars1, t2, true))
           | uu____571 ->
               let uu____572 = FStar_Syntax_Subst.open_univ_vars univ_vars t1 in
               (match uu____572 with
                | (univ_vars1, t2) -> (univ_vars1, t2, false)))
let rec (decorated_pattern_as_term :
  FStar_Syntax_Syntax.pat ->
    (FStar_Syntax_Syntax.bv Prims.list * FStar_Syntax_Syntax.term))
  =
  fun pat ->
    let mk f = FStar_Syntax_Syntax.mk f pat.FStar_Syntax_Syntax.p in
    let pat_as_arg uu____636 =
      match uu____636 with
      | (p, i) ->
          let uu____656 = decorated_pattern_as_term p in
          (match uu____656 with
           | (vars, te) ->
               let uu____679 =
                 let uu____684 = FStar_Syntax_Syntax.as_implicit i in
                 (te, uu____684) in
               (vars, uu____679)) in
    match pat.FStar_Syntax_Syntax.v with
    | FStar_Syntax_Syntax.Pat_constant c ->
        let uu____698 = mk (FStar_Syntax_Syntax.Tm_constant c) in
        ([], uu____698)
    | FStar_Syntax_Syntax.Pat_wild x ->
        let uu____702 = mk (FStar_Syntax_Syntax.Tm_name x) in
        ([x], uu____702)
    | FStar_Syntax_Syntax.Pat_var x ->
        let uu____706 = mk (FStar_Syntax_Syntax.Tm_name x) in
        ([x], uu____706)
    | FStar_Syntax_Syntax.Pat_cons (fv, pats) ->
        let uu____729 =
          let uu____748 =
            FStar_All.pipe_right pats (FStar_List.map pat_as_arg) in
          FStar_All.pipe_right uu____748 FStar_List.unzip in
        (match uu____729 with
         | (vars, args) ->
             let vars1 = FStar_List.flatten vars in
             let uu____886 =
               let uu____887 =
                 let uu____888 =
                   let uu____905 = FStar_Syntax_Syntax.fv_to_tm fv in
                   (uu____905, args) in
                 FStar_Syntax_Syntax.Tm_app uu____888 in
               mk uu____887 in
             (vars1, uu____886))
    | FStar_Syntax_Syntax.Pat_dot_term (x, e) -> ([], e)
let (comp_univ_opt :
  FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.universe FStar_Pervasives_Native.option)
  =
  fun c ->
    match c.FStar_Syntax_Syntax.n with
    | FStar_Syntax_Syntax.Total (uu____944, uopt) -> uopt
    | FStar_Syntax_Syntax.GTotal (uu____954, uopt) -> uopt
    | FStar_Syntax_Syntax.Comp c1 ->
        (match c1.FStar_Syntax_Syntax.comp_univs with
         | [] -> FStar_Pervasives_Native.None
         | hd::uu____968 -> FStar_Pervasives_Native.Some hd)
let (lcomp_univ_opt :
  FStar_TypeChecker_Common.lcomp ->
    (FStar_Syntax_Syntax.universe FStar_Pervasives_Native.option *
      FStar_TypeChecker_Common.guard_t))
  =
  fun lc ->
    let uu____983 =
      FStar_All.pipe_right lc FStar_TypeChecker_Common.lcomp_comp in
    FStar_All.pipe_right uu____983
      (fun uu____1011 ->
         match uu____1011 with | (c, g) -> ((comp_univ_opt c), g))
let (destruct_wp_comp :
  FStar_Syntax_Syntax.comp_typ ->
    (FStar_Syntax_Syntax.universe * FStar_Syntax_Syntax.typ *
      FStar_Syntax_Syntax.typ))
  = fun c -> FStar_Syntax_Util.destruct_comp c
let (mk_comp_l :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.universe ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term ->
          FStar_Syntax_Syntax.cflag Prims.list -> FStar_Syntax_Syntax.comp)
  =
  fun mname ->
    fun u_result ->
      fun result ->
        fun wp ->
          fun flags ->
            let uu____1084 =
              let uu____1085 =
                let uu____1096 = FStar_Syntax_Syntax.as_arg wp in
                [uu____1096] in
              {
                FStar_Syntax_Syntax.comp_univs = [u_result];
                FStar_Syntax_Syntax.effect_name = mname;
                FStar_Syntax_Syntax.result_typ = result;
                FStar_Syntax_Syntax.effect_args = uu____1085;
                FStar_Syntax_Syntax.flags = flags
              } in
            FStar_Syntax_Syntax.mk_Comp uu____1084
let (mk_comp :
  FStar_Syntax_Syntax.eff_decl ->
    FStar_Syntax_Syntax.universe ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.term ->
          FStar_Syntax_Syntax.cflag Prims.list -> FStar_Syntax_Syntax.comp)
  = fun md -> mk_comp_l md.FStar_Syntax_Syntax.mname
let (effect_args_from_repr :
  FStar_Syntax_Syntax.term ->
    Prims.bool -> FStar_Range.range -> FStar_Syntax_Syntax.term Prims.list)
  =
  fun repr ->
    fun is_layered ->
      fun r ->
        let err uu____1180 =
          let uu____1181 =
            let uu____1187 =
              let uu____1189 = FStar_Syntax_Print.term_to_string repr in
              let uu____1191 = FStar_Util.string_of_bool is_layered in
              FStar_Util.format2
                "Could not get effect args from repr %s with is_layered %s"
                uu____1189 uu____1191 in
            (FStar_Errors.Fatal_UnexpectedEffect, uu____1187) in
          FStar_Errors.raise_error uu____1181 r in
        let repr1 = FStar_Syntax_Subst.compress repr in
        if is_layered
        then
          match repr1.FStar_Syntax_Syntax.n with
          | FStar_Syntax_Syntax.Tm_app (uu____1203, uu____1204::is) ->
              FStar_All.pipe_right is
                (FStar_List.map FStar_Pervasives_Native.fst)
          | uu____1272 -> err ()
        else
          (match repr1.FStar_Syntax_Syntax.n with
           | FStar_Syntax_Syntax.Tm_arrow (uu____1277, c) ->
               let uu____1299 =
                 FStar_All.pipe_right c FStar_Syntax_Util.comp_to_comp_typ in
               FStar_All.pipe_right uu____1299
                 (fun ct ->
                    FStar_All.pipe_right ct.FStar_Syntax_Syntax.effect_args
                      (FStar_List.map FStar_Pervasives_Native.fst))
           | uu____1334 -> err ())
let (mk_wp_return :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.eff_decl ->
      FStar_Syntax_Syntax.universe ->
        FStar_Syntax_Syntax.typ ->
          FStar_Syntax_Syntax.term ->
            FStar_Range.range -> FStar_Syntax_Syntax.comp)
  =
  fun env ->
    fun ed ->
      fun u_a ->
        fun a ->
          fun e ->
            fun r ->
              let c =
                let uu____1367 =
                  let uu____1369 =
                    FStar_TypeChecker_Env.lid_exists env
                      FStar_Parser_Const.effect_GTot_lid in
                  FStar_All.pipe_left Prims.op_Negation uu____1369 in
                if uu____1367
                then FStar_Syntax_Syntax.mk_Total a
                else
                  (let uu____1376 = FStar_Syntax_Util.is_unit a in
                   if uu____1376
                   then
                     FStar_Syntax_Syntax.mk_Total' a
                       (FStar_Pervasives_Native.Some
                          FStar_Syntax_Syntax.U_zero)
                   else
                     (let wp =
                        let uu____1382 =
                          env.FStar_TypeChecker_Env.lax &&
                            (FStar_Options.ml_ish ()) in
                        if uu____1382
                        then FStar_Syntax_Syntax.tun
                        else
                          (let ret_wp =
                             FStar_All.pipe_right ed
                               FStar_Syntax_Util.get_return_vc_combinator in
                           let uu____1388 =
                             let uu____1389 =
                               FStar_TypeChecker_Env.inst_effect_fun_with
                                 [u_a] env ed ret_wp in
                             let uu____1390 =
                               let uu____1391 = FStar_Syntax_Syntax.as_arg a in
                               let uu____1400 =
                                 let uu____1411 =
                                   FStar_Syntax_Syntax.as_arg e in
                                 [uu____1411] in
                               uu____1391 :: uu____1400 in
                             FStar_Syntax_Syntax.mk_Tm_app uu____1389
                               uu____1390 e.FStar_Syntax_Syntax.pos in
                           FStar_TypeChecker_Normalize.normalize
                             [FStar_TypeChecker_Env.Beta;
                             FStar_TypeChecker_Env.NoFullNorm] env uu____1388) in
                      mk_comp ed u_a a wp [FStar_Syntax_Syntax.RETURN])) in
              (let uu____1445 =
                 FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
                   (FStar_Options.Other "Return") in
               if uu____1445
               then
                 let uu____1450 =
                   FStar_Range.string_of_range e.FStar_Syntax_Syntax.pos in
                 let uu____1452 = FStar_Syntax_Print.term_to_string e in
                 let uu____1454 =
                   FStar_TypeChecker_Normalize.comp_to_string env c in
                 FStar_Util.print3 "(%s) returning %s at comp type %s\n"
                   uu____1450 uu____1452 uu____1454
               else ());
              c
let (mk_indexed_return :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.eff_decl ->
      FStar_Syntax_Syntax.universe ->
        FStar_Syntax_Syntax.typ ->
          FStar_Syntax_Syntax.term ->
            FStar_Range.range ->
              (FStar_Syntax_Syntax.comp * FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun ed ->
      fun u_a ->
        fun a ->
          fun e ->
            fun r ->
              (let uu____1499 =
                 FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
                   (FStar_Options.Other "LayeredEffects") in
               if uu____1499
               then
                 let uu____1504 =
                   FStar_Ident.string_of_lid ed.FStar_Syntax_Syntax.mname in
                 let uu____1506 = FStar_Syntax_Print.univ_to_string u_a in
                 let uu____1508 = FStar_Syntax_Print.term_to_string a in
                 let uu____1510 = FStar_Syntax_Print.term_to_string e in
                 FStar_Util.print4
                   "Computing %s.return for u_a:%s, a:%s, and e:%s{\n"
                   uu____1504 uu____1506 uu____1508 uu____1510
               else ());
              (let uu____1515 =
                 let uu____1520 =
                   FStar_All.pipe_right ed
                     FStar_Syntax_Util.get_return_vc_combinator in
                 FStar_TypeChecker_Env.inst_tscheme_with uu____1520 [u_a] in
               match uu____1515 with
               | (uu____1525, return_t) ->
                   let return_t_shape_error s =
                     let uu____1540 =
                       let uu____1542 =
                         FStar_Ident.string_of_lid
                           ed.FStar_Syntax_Syntax.mname in
                       let uu____1544 =
                         FStar_Syntax_Print.term_to_string return_t in
                       FStar_Util.format3
                         "%s.return %s does not have proper shape (reason:%s)"
                         uu____1542 uu____1544 s in
                     (FStar_Errors.Fatal_UnexpectedEffect, uu____1540) in
                   let uu____1548 =
                     let uu____1577 =
                       let uu____1578 = FStar_Syntax_Subst.compress return_t in
                       uu____1578.FStar_Syntax_Syntax.n in
                     match uu____1577 with
                     | FStar_Syntax_Syntax.Tm_arrow (bs, c) when
                         (FStar_List.length bs) >= (Prims.of_int (2)) ->
                         let uu____1638 = FStar_Syntax_Subst.open_comp bs c in
                         (match uu____1638 with
                          | (a_b::x_b::bs1, c1) ->
                              let uu____1707 =
                                FStar_Syntax_Util.comp_to_comp_typ c1 in
                              (a_b, x_b, bs1, uu____1707))
                     | uu____1728 ->
                         let uu____1729 =
                           return_t_shape_error
                             "Either not an arrow or not enough binders" in
                         FStar_Errors.raise_error uu____1729 r in
                   (match uu____1548 with
                    | (a_b, x_b, rest_bs, return_ct) ->
                        let uu____1812 =
                          let uu____1819 =
                            let uu____1820 =
                              let uu____1821 =
                                let uu____1828 =
                                  FStar_All.pipe_right a_b
                                    FStar_Pervasives_Native.fst in
                                (uu____1828, a) in
                              FStar_Syntax_Syntax.NT uu____1821 in
                            let uu____1839 =
                              let uu____1842 =
                                let uu____1843 =
                                  let uu____1850 =
                                    FStar_All.pipe_right x_b
                                      FStar_Pervasives_Native.fst in
                                  (uu____1850, e) in
                                FStar_Syntax_Syntax.NT uu____1843 in
                              [uu____1842] in
                            uu____1820 :: uu____1839 in
                          FStar_TypeChecker_Env.uvars_for_binders env rest_bs
                            uu____1819
                            (fun b ->
                               let uu____1866 =
                                 FStar_Syntax_Print.binder_to_string b in
                               let uu____1868 =
                                 let uu____1870 =
                                   FStar_Ident.string_of_lid
                                     ed.FStar_Syntax_Syntax.mname in
                                 FStar_Util.format1 "%s.return" uu____1870 in
                               let uu____1873 = FStar_Range.string_of_range r in
                               FStar_Util.format3
                                 "implicit var for binder %s of %s at %s"
                                 uu____1866 uu____1868 uu____1873) r in
                        (match uu____1812 with
                         | (rest_bs_uvars, g_uvars) ->
                             let subst =
                               FStar_List.map2
                                 (fun b ->
                                    fun t ->
                                      let uu____1910 =
                                        let uu____1917 =
                                          FStar_All.pipe_right b
                                            FStar_Pervasives_Native.fst in
                                        (uu____1917, t) in
                                      FStar_Syntax_Syntax.NT uu____1910) (a_b
                                 :: x_b :: rest_bs) (a :: e :: rest_bs_uvars) in
                             let is =
                               let uu____1943 =
                                 let uu____1946 =
                                   FStar_Syntax_Subst.compress
                                     return_ct.FStar_Syntax_Syntax.result_typ in
                                 let uu____1947 =
                                   FStar_Syntax_Util.is_layered ed in
                                 effect_args_from_repr uu____1946 uu____1947
                                   r in
                               FStar_All.pipe_right uu____1943
                                 (FStar_List.map
                                    (FStar_Syntax_Subst.subst subst)) in
                             let c =
                               let uu____1954 =
                                 let uu____1955 =
                                   FStar_All.pipe_right is
                                     (FStar_List.map
                                        FStar_Syntax_Syntax.as_arg) in
                                 {
                                   FStar_Syntax_Syntax.comp_univs = [u_a];
                                   FStar_Syntax_Syntax.effect_name =
                                     (ed.FStar_Syntax_Syntax.mname);
                                   FStar_Syntax_Syntax.result_typ = a;
                                   FStar_Syntax_Syntax.effect_args =
                                     uu____1955;
                                   FStar_Syntax_Syntax.flags = []
                                 } in
                               FStar_Syntax_Syntax.mk_Comp uu____1954 in
                             ((let uu____1979 =
                                 FStar_All.pipe_left
                                   (FStar_TypeChecker_Env.debug env)
                                   (FStar_Options.Other "LayeredEffects") in
                               if uu____1979
                               then
                                 let uu____1984 =
                                   FStar_Syntax_Print.comp_to_string c in
                                 FStar_Util.print1 "} c after return %s\n"
                                   uu____1984
                               else ());
                              (c, g_uvars)))))
let (mk_return :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.eff_decl ->
      FStar_Syntax_Syntax.universe ->
        FStar_Syntax_Syntax.typ ->
          FStar_Syntax_Syntax.term ->
            FStar_Range.range ->
              (FStar_Syntax_Syntax.comp * FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun ed ->
      fun u_a ->
        fun a ->
          fun e ->
            fun r ->
              let uu____2028 =
                FStar_All.pipe_right ed FStar_Syntax_Util.is_layered in
              if uu____2028
              then mk_indexed_return env ed u_a a e r
              else
                (let uu____2038 = mk_wp_return env ed u_a a e r in
                 (uu____2038, FStar_TypeChecker_Env.trivial_guard))
let (lift_comp :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.comp_typ ->
      FStar_TypeChecker_Env.mlift ->
        (FStar_Syntax_Syntax.comp * FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun c ->
      fun lift ->
        let uu____2063 =
          FStar_All.pipe_right
            (let uu___257_2065 = c in
             {
               FStar_Syntax_Syntax.comp_univs =
                 (uu___257_2065.FStar_Syntax_Syntax.comp_univs);
               FStar_Syntax_Syntax.effect_name =
                 (uu___257_2065.FStar_Syntax_Syntax.effect_name);
               FStar_Syntax_Syntax.result_typ =
                 (uu___257_2065.FStar_Syntax_Syntax.result_typ);
               FStar_Syntax_Syntax.effect_args =
                 (uu___257_2065.FStar_Syntax_Syntax.effect_args);
               FStar_Syntax_Syntax.flags = []
             }) FStar_Syntax_Syntax.mk_Comp in
        FStar_All.pipe_right uu____2063
          (lift.FStar_TypeChecker_Env.mlift_wp env)
let (join_effects :
  FStar_TypeChecker_Env.env ->
    FStar_Ident.lident -> FStar_Ident.lident -> FStar_Ident.lident)
  =
  fun env ->
    fun l1_in ->
      fun l2_in ->
        let uu____2086 =
          let uu____2091 = FStar_TypeChecker_Env.norm_eff_name env l1_in in
          let uu____2092 = FStar_TypeChecker_Env.norm_eff_name env l2_in in
          (uu____2091, uu____2092) in
        match uu____2086 with
        | (l1, l2) ->
            let uu____2095 = FStar_TypeChecker_Env.join_opt env l1 l2 in
            (match uu____2095 with
             | FStar_Pervasives_Native.Some (m, uu____2105, uu____2106) -> m
             | FStar_Pervasives_Native.None ->
                 let uu____2119 =
                   FStar_TypeChecker_Env.exists_polymonadic_bind env l1 l2 in
                 (match uu____2119 with
                  | FStar_Pervasives_Native.Some (m, uu____2133) -> m
                  | FStar_Pervasives_Native.None ->
                      let uu____2166 =
                        let uu____2172 =
                          let uu____2174 =
                            FStar_Syntax_Print.lid_to_string l1_in in
                          let uu____2176 =
                            FStar_Syntax_Print.lid_to_string l2_in in
                          FStar_Util.format2
                            "Effects %s and %s cannot be composed" uu____2174
                            uu____2176 in
                        (FStar_Errors.Fatal_EffectsCannotBeComposed,
                          uu____2172) in
                      FStar_Errors.raise_error uu____2166
                        env.FStar_TypeChecker_Env.range))
let (join_lcomp :
  FStar_TypeChecker_Env.env ->
    FStar_TypeChecker_Common.lcomp ->
      FStar_TypeChecker_Common.lcomp -> FStar_Ident.lident)
  =
  fun env ->
    fun c1 ->
      fun c2 ->
        let uu____2196 =
          (FStar_TypeChecker_Common.is_total_lcomp c1) &&
            (FStar_TypeChecker_Common.is_total_lcomp c2) in
        if uu____2196
        then FStar_Parser_Const.effect_Tot_lid
        else
          join_effects env c1.FStar_TypeChecker_Common.eff_name
            c2.FStar_TypeChecker_Common.eff_name
let (lift_comps_sep_guards :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.comp ->
      FStar_Syntax_Syntax.comp ->
        FStar_Syntax_Syntax.bv FStar_Pervasives_Native.option ->
          Prims.bool ->
            (FStar_Ident.lident * FStar_Syntax_Syntax.comp *
              FStar_Syntax_Syntax.comp * FStar_TypeChecker_Common.guard_t *
              FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun c1 ->
      fun c2 ->
        fun b ->
          fun for_bind ->
            let c11 = FStar_TypeChecker_Env.unfold_effect_abbrev env c1 in
            let c21 = FStar_TypeChecker_Env.unfold_effect_abbrev env c2 in
            let uu____2255 =
              FStar_TypeChecker_Env.join_opt env
                c11.FStar_Syntax_Syntax.effect_name
                c21.FStar_Syntax_Syntax.effect_name in
            match uu____2255 with
            | FStar_Pervasives_Native.Some (m, lift1, lift2) ->
                let uu____2283 = lift_comp env c11 lift1 in
                (match uu____2283 with
                 | (c12, g1) ->
                     let uu____2300 =
                       if Prims.op_Negation for_bind
                       then lift_comp env c21 lift2
                       else
                         (let x_a =
                            match b with
                            | FStar_Pervasives_Native.None ->
                                FStar_Syntax_Syntax.null_binder
                                  (FStar_Syntax_Util.comp_result c12)
                            | FStar_Pervasives_Native.Some x ->
                                FStar_Syntax_Syntax.mk_binder x in
                          let env_x =
                            FStar_TypeChecker_Env.push_binders env [x_a] in
                          let uu____2339 = lift_comp env_x c21 lift2 in
                          match uu____2339 with
                          | (c22, g2) ->
                              let uu____2350 =
                                FStar_TypeChecker_Env.close_guard env 
                                  [x_a] g2 in
                              (c22, uu____2350)) in
                     (match uu____2300 with
                      | (c22, g2) -> (m, c12, c22, g1, g2)))
            | FStar_Pervasives_Native.None ->
                let rng = env.FStar_TypeChecker_Env.range in
                let err uu____2397 =
                  let uu____2398 =
                    let uu____2404 =
                      let uu____2406 =
                        FStar_Syntax_Print.lid_to_string
                          c11.FStar_Syntax_Syntax.effect_name in
                      let uu____2408 =
                        FStar_Syntax_Print.lid_to_string
                          c21.FStar_Syntax_Syntax.effect_name in
                      FStar_Util.format2
                        "Effects %s and %s cannot be composed" uu____2406
                        uu____2408 in
                    (FStar_Errors.Fatal_EffectsCannotBeComposed, uu____2404) in
                  FStar_Errors.raise_error uu____2398 rng in
                ((let uu____2423 =
                    FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
                      (FStar_Options.Other "LayeredEffects") in
                  if uu____2423
                  then
                    let uu____2428 =
                      let uu____2430 =
                        FStar_All.pipe_right c11 FStar_Syntax_Syntax.mk_Comp in
                      FStar_All.pipe_right uu____2430
                        FStar_Syntax_Print.comp_to_string in
                    let uu____2432 =
                      let uu____2434 =
                        FStar_All.pipe_right c21 FStar_Syntax_Syntax.mk_Comp in
                      FStar_All.pipe_right uu____2434
                        FStar_Syntax_Print.comp_to_string in
                    let uu____2436 = FStar_Util.string_of_bool for_bind in
                    FStar_Util.print3
                      "Lifting comps %s and %s with for_bind %s{\n"
                      uu____2428 uu____2432 uu____2436
                  else ());
                 if for_bind
                 then err ()
                 else
                   (let bind_with_return ct ret_eff f_bind =
                      let x_bv =
                        FStar_Syntax_Syntax.gen_bv "x"
                          FStar_Pervasives_Native.None
                          ct.FStar_Syntax_Syntax.result_typ in
                      let uu____2492 =
                        let uu____2497 =
                          FStar_TypeChecker_Env.push_bv env x_bv in
                        let uu____2498 =
                          FStar_TypeChecker_Env.get_effect_decl env ret_eff in
                        let uu____2499 =
                          FStar_List.hd ct.FStar_Syntax_Syntax.comp_univs in
                        let uu____2500 = FStar_Syntax_Syntax.bv_to_name x_bv in
                        mk_return uu____2497 uu____2498 uu____2499
                          ct.FStar_Syntax_Syntax.result_typ uu____2500 rng in
                      match uu____2492 with
                      | (c_ret, g_ret) ->
                          let uu____2507 =
                            let uu____2512 =
                              FStar_Syntax_Util.comp_to_comp_typ c_ret in
                            f_bind env ct (FStar_Pervasives_Native.Some x_bv)
                              uu____2512 [] rng in
                          (match uu____2507 with
                           | (c, g_bind) ->
                               let uu____2519 =
                                 FStar_TypeChecker_Env.conj_guard g_ret
                                   g_bind in
                               (c, uu____2519)) in
                    let try_lift c12 c22 =
                      let p_bind_opt =
                        FStar_TypeChecker_Env.exists_polymonadic_bind env
                          c12.FStar_Syntax_Syntax.effect_name
                          c22.FStar_Syntax_Syntax.effect_name in
                      let uu____2564 =
                        FStar_All.pipe_right p_bind_opt FStar_Util.is_some in
                      if uu____2564
                      then
                        let uu____2600 =
                          FStar_All.pipe_right p_bind_opt FStar_Util.must in
                        match uu____2600 with
                        | (p, f_bind) ->
                            let uu____2667 =
                              FStar_Ident.lid_equals p
                                c22.FStar_Syntax_Syntax.effect_name in
                            (if uu____2667
                             then
                               let uu____2680 = bind_with_return c12 p f_bind in
                               match uu____2680 with
                               | (c13, g) ->
                                   let uu____2697 =
                                     let uu____2706 =
                                       FStar_Syntax_Syntax.mk_Comp c22 in
                                     ((c22.FStar_Syntax_Syntax.effect_name),
                                       c13, uu____2706, g) in
                                   FStar_Pervasives_Native.Some uu____2697
                             else FStar_Pervasives_Native.None)
                      else FStar_Pervasives_Native.None in
                    let uu____2735 =
                      let uu____2746 = try_lift c11 c21 in
                      match uu____2746 with
                      | FStar_Pervasives_Native.Some (p, c12, c22, g) ->
                          (p, c12, c22, g,
                            FStar_TypeChecker_Env.trivial_guard)
                      | FStar_Pervasives_Native.None ->
                          let uu____2787 = try_lift c21 c11 in
                          (match uu____2787 with
                           | FStar_Pervasives_Native.Some (p, c22, c12, g) ->
                               (p, c12, c22,
                                 FStar_TypeChecker_Env.trivial_guard, g)
                           | FStar_Pervasives_Native.None -> err ()) in
                    match uu____2735 with
                    | (p, c12, c22, g1, g2) ->
                        ((let uu____2844 =
                            FStar_All.pipe_left
                              (FStar_TypeChecker_Env.debug env)
                              (FStar_Options.Other "LayeredEffects") in
                          if uu____2844
                          then
                            let uu____2849 = FStar_Ident.string_of_lid p in
                            let uu____2851 =
                              FStar_Syntax_Print.comp_to_string c12 in
                            let uu____2853 =
                              FStar_Syntax_Print.comp_to_string c22 in
                            FStar_Util.print3
                              "} Returning p %s, c1 %s, and c2 %s\n"
                              uu____2849 uu____2851 uu____2853
                          else ());
                         (p, c12, c22, g1, g2))))
let (lift_comps :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.comp ->
      FStar_Syntax_Syntax.comp ->
        FStar_Syntax_Syntax.bv FStar_Pervasives_Native.option ->
          Prims.bool ->
            (FStar_Ident.lident * FStar_Syntax_Syntax.comp *
              FStar_Syntax_Syntax.comp * FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun c1 ->
      fun c2 ->
        fun b ->
          fun for_bind ->
            let uu____2906 = lift_comps_sep_guards env c1 c2 b for_bind in
            match uu____2906 with
            | (l, c11, c21, g1, g2) ->
                let uu____2930 = FStar_TypeChecker_Env.conj_guard g1 g2 in
                (l, c11, c21, uu____2930)
let (is_pure_effect :
  FStar_TypeChecker_Env.env -> FStar_Ident.lident -> Prims.bool) =
  fun env ->
    fun l ->
      let l1 = FStar_TypeChecker_Env.norm_eff_name env l in
      FStar_Ident.lid_equals l1 FStar_Parser_Const.effect_PURE_lid
let (is_pure_or_ghost_effect :
  FStar_TypeChecker_Env.env -> FStar_Ident.lident -> Prims.bool) =
  fun env ->
    fun l ->
      let l1 = FStar_TypeChecker_Env.norm_eff_name env l in
      (FStar_Ident.lid_equals l1 FStar_Parser_Const.effect_PURE_lid) ||
        (FStar_Ident.lid_equals l1 FStar_Parser_Const.effect_GHOST_lid)
let (lax_mk_tot_or_comp_l :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.universe ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.cflag Prims.list -> FStar_Syntax_Syntax.comp)
  =
  fun mname ->
    fun u_result ->
      fun result ->
        fun flags ->
          let uu____2986 =
            FStar_Ident.lid_equals mname FStar_Parser_Const.effect_Tot_lid in
          if uu____2986
          then
            FStar_Syntax_Syntax.mk_Total' result
              (FStar_Pervasives_Native.Some u_result)
          else mk_comp_l mname u_result result FStar_Syntax_Syntax.tun flags
let (is_function : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun t ->
    let uu____2998 =
      let uu____2999 = FStar_Syntax_Subst.compress t in
      uu____2999.FStar_Syntax_Syntax.n in
    match uu____2998 with
    | FStar_Syntax_Syntax.Tm_arrow uu____3003 -> true
    | uu____3019 -> false
let (label :
  Prims.string ->
    FStar_Range.range -> FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  =
  fun reason ->
    fun r ->
      fun f ->
        FStar_Syntax_Syntax.mk
          (FStar_Syntax_Syntax.Tm_meta
             (f, (FStar_Syntax_Syntax.Meta_labeled (reason, r, false))))
          f.FStar_Syntax_Syntax.pos
let (label_opt :
  FStar_TypeChecker_Env.env ->
    (unit -> Prims.string) FStar_Pervasives_Native.option ->
      FStar_Range.range -> FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.typ)
  =
  fun env ->
    fun reason ->
      fun r ->
        fun f ->
          match reason with
          | FStar_Pervasives_Native.None -> f
          | FStar_Pervasives_Native.Some reason1 ->
              let uu____3089 =
                let uu____3091 = FStar_TypeChecker_Env.should_verify env in
                FStar_All.pipe_left Prims.op_Negation uu____3091 in
              if uu____3089
              then f
              else (let uu____3098 = reason1 () in label uu____3098 r f)
let (label_guard :
  FStar_Range.range ->
    Prims.string ->
      FStar_TypeChecker_Common.guard_t -> FStar_TypeChecker_Common.guard_t)
  =
  fun r ->
    fun reason ->
      fun g ->
        match g.FStar_TypeChecker_Common.guard_f with
        | FStar_TypeChecker_Common.Trivial -> g
        | FStar_TypeChecker_Common.NonTrivial f ->
            let uu___402_3119 = g in
            let uu____3120 =
              let uu____3121 = label reason r f in
              FStar_TypeChecker_Common.NonTrivial uu____3121 in
            {
              FStar_TypeChecker_Common.guard_f = uu____3120;
              FStar_TypeChecker_Common.deferred_to_tac =
                (uu___402_3119.FStar_TypeChecker_Common.deferred_to_tac);
              FStar_TypeChecker_Common.deferred =
                (uu___402_3119.FStar_TypeChecker_Common.deferred);
              FStar_TypeChecker_Common.univ_ineqs =
                (uu___402_3119.FStar_TypeChecker_Common.univ_ineqs);
              FStar_TypeChecker_Common.implicits =
                (uu___402_3119.FStar_TypeChecker_Common.implicits)
            }
let (close_wp_comp :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.bv Prims.list ->
      FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.comp)
  =
  fun env ->
    fun bvs ->
      fun c ->
        let uu____3142 = FStar_Syntax_Util.is_ml_comp c in
        if uu____3142
        then c
        else
          (let uu____3147 =
             env.FStar_TypeChecker_Env.lax && (FStar_Options.ml_ish ()) in
           if uu____3147
           then c
           else
             (let close_wp u_res md res_t bvs1 wp0 =
                let close =
                  let uu____3189 =
                    FStar_All.pipe_right md
                      FStar_Syntax_Util.get_wp_close_combinator in
                  FStar_All.pipe_right uu____3189 FStar_Util.must in
                FStar_List.fold_right
                  (fun x ->
                     fun wp ->
                       let bs =
                         let uu____3218 = FStar_Syntax_Syntax.mk_binder x in
                         [uu____3218] in
                       let us =
                         let uu____3240 =
                           let uu____3243 =
                             env.FStar_TypeChecker_Env.universe_of env
                               x.FStar_Syntax_Syntax.sort in
                           [uu____3243] in
                         u_res :: uu____3240 in
                       let wp1 =
                         FStar_Syntax_Util.abs bs wp
                           (FStar_Pervasives_Native.Some
                              (FStar_Syntax_Util.mk_residual_comp
                                 FStar_Parser_Const.effect_Tot_lid
                                 FStar_Pervasives_Native.None
                                 [FStar_Syntax_Syntax.TOTAL])) in
                       let uu____3249 =
                         FStar_TypeChecker_Env.inst_effect_fun_with us env md
                           close in
                       let uu____3250 =
                         let uu____3251 = FStar_Syntax_Syntax.as_arg res_t in
                         let uu____3260 =
                           let uu____3271 =
                             FStar_Syntax_Syntax.as_arg
                               x.FStar_Syntax_Syntax.sort in
                           let uu____3280 =
                             let uu____3291 = FStar_Syntax_Syntax.as_arg wp1 in
                             [uu____3291] in
                           uu____3271 :: uu____3280 in
                         uu____3251 :: uu____3260 in
                       FStar_Syntax_Syntax.mk_Tm_app uu____3249 uu____3250
                         wp0.FStar_Syntax_Syntax.pos) bvs1 wp0 in
              let c1 = FStar_TypeChecker_Env.unfold_effect_abbrev env c in
              let uu____3333 = destruct_wp_comp c1 in
              match uu____3333 with
              | (u_res_t, res_t, wp) ->
                  let md =
                    FStar_TypeChecker_Env.get_effect_decl env
                      c1.FStar_Syntax_Syntax.effect_name in
                  let wp1 = close_wp u_res_t md res_t bvs wp in
                  mk_comp md u_res_t c1.FStar_Syntax_Syntax.result_typ wp1
                    c1.FStar_Syntax_Syntax.flags))
let (close_wp_lcomp :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.bv Prims.list ->
      FStar_TypeChecker_Common.lcomp -> FStar_TypeChecker_Common.lcomp)
  =
  fun env ->
    fun bvs ->
      fun lc ->
        let bs =
          FStar_All.pipe_right bvs
            (FStar_List.map FStar_Syntax_Syntax.mk_binder) in
        FStar_All.pipe_right lc
          (FStar_TypeChecker_Common.apply_lcomp (close_wp_comp env bvs)
             (fun g ->
                let uu____3373 =
                  FStar_All.pipe_right g
                    (FStar_TypeChecker_Env.close_guard env bs) in
                FStar_All.pipe_right uu____3373
                  (close_guard_implicits env false bs)))
let (close_layered_lcomp :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.bv Prims.list ->
      FStar_Syntax_Syntax.term Prims.list ->
        FStar_TypeChecker_Common.lcomp -> FStar_TypeChecker_Common.lcomp)
  =
  fun env ->
    fun bvs ->
      fun tms ->
        fun lc ->
          let bs =
            FStar_All.pipe_right bvs
              (FStar_List.map FStar_Syntax_Syntax.mk_binder) in
          let substs =
            FStar_List.map2
              (fun bv -> fun tm -> FStar_Syntax_Syntax.NT (bv, tm)) bvs tms in
          FStar_All.pipe_right lc
            (FStar_TypeChecker_Common.apply_lcomp
               (FStar_Syntax_Subst.subst_comp substs)
               (fun g ->
                  let uu____3423 =
                    FStar_All.pipe_right g
                      (FStar_TypeChecker_Env.close_guard env bs) in
                  FStar_All.pipe_right uu____3423
                    (close_guard_implicits env false bs)))
let (should_not_inline_lc : FStar_TypeChecker_Common.lcomp -> Prims.bool) =
  fun lc ->
    FStar_All.pipe_right lc.FStar_TypeChecker_Common.cflags
      (FStar_Util.for_some
         (fun uu___0_3436 ->
            match uu___0_3436 with
            | FStar_Syntax_Syntax.SHOULD_NOT_INLINE -> true
            | uu____3439 -> false))
let (should_return :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term FStar_Pervasives_Native.option ->
      FStar_TypeChecker_Common.lcomp -> Prims.bool)
  =
  fun env ->
    fun eopt ->
      fun lc ->
        let lc_is_unit_or_effectful =
          let uu____3464 =
            let uu____3467 =
              FStar_All.pipe_right lc.FStar_TypeChecker_Common.res_typ
                FStar_Syntax_Util.arrow_formals_comp in
            FStar_All.pipe_right uu____3467 FStar_Pervasives_Native.snd in
          FStar_All.pipe_right uu____3464
            (fun c ->
               (let uu____3491 =
                  FStar_TypeChecker_Env.is_reifiable_comp env c in
                Prims.op_Negation uu____3491) &&
                 ((FStar_All.pipe_right (FStar_Syntax_Util.comp_result c)
                     FStar_Syntax_Util.is_unit)
                    ||
                    (let uu____3495 =
                       FStar_Syntax_Util.is_pure_or_ghost_comp c in
                     Prims.op_Negation uu____3495))) in
        match eopt with
        | FStar_Pervasives_Native.None -> false
        | FStar_Pervasives_Native.Some e ->
            (((FStar_TypeChecker_Common.is_pure_or_ghost_lcomp lc) &&
                (Prims.op_Negation lc_is_unit_or_effectful))
               &&
               (let uu____3506 = FStar_Syntax_Util.head_and_args' e in
                match uu____3506 with
                | (head, uu____3523) ->
                    let uu____3544 =
                      let uu____3545 = FStar_Syntax_Util.un_uinst head in
                      uu____3545.FStar_Syntax_Syntax.n in
                    (match uu____3544 with
                     | FStar_Syntax_Syntax.Tm_fvar fv ->
                         let uu____3550 =
                           let uu____3552 = FStar_Syntax_Syntax.lid_of_fv fv in
                           FStar_TypeChecker_Env.is_irreducible env
                             uu____3552 in
                         Prims.op_Negation uu____3550
                     | uu____3553 -> true)))
              &&
              (let uu____3556 = should_not_inline_lc lc in
               Prims.op_Negation uu____3556)
let (return_value :
  FStar_TypeChecker_Env.env ->
    FStar_Ident.lident ->
      FStar_Syntax_Syntax.universe FStar_Pervasives_Native.option ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
          FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
            (FStar_Syntax_Syntax.comp * FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun eff_lid ->
      fun u_t_opt ->
        fun t ->
          fun v ->
            let u =
              match u_t_opt with
              | FStar_Pervasives_Native.None ->
                  env.FStar_TypeChecker_Env.universe_of env t
              | FStar_Pervasives_Native.Some u -> u in
            let uu____3602 =
              FStar_TypeChecker_Env.get_effect_decl env eff_lid in
            mk_return env uu____3602 u t v v.FStar_Syntax_Syntax.pos
let (mk_indexed_bind :
  FStar_TypeChecker_Env.env ->
    FStar_Ident.lident ->
      FStar_Ident.lident ->
        FStar_Ident.lident ->
          FStar_Syntax_Syntax.tscheme ->
            FStar_Syntax_Syntax.comp_typ ->
              FStar_Syntax_Syntax.bv FStar_Pervasives_Native.option ->
                FStar_Syntax_Syntax.comp_typ ->
                  FStar_Syntax_Syntax.cflag Prims.list ->
                    FStar_Range.range ->
                      (FStar_Syntax_Syntax.comp *
                        FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun m ->
      fun n ->
        fun p ->
          fun bind_t ->
            fun ct1 ->
              fun b ->
                fun ct2 ->
                  fun flags ->
                    fun r1 ->
                      (let uu____3671 =
                         FStar_All.pipe_left
                           (FStar_TypeChecker_Env.debug env)
                           (FStar_Options.Other "LayeredEffects") in
                       if uu____3671
                       then
                         let uu____3676 =
                           let uu____3678 = FStar_Syntax_Syntax.mk_Comp ct1 in
                           FStar_Syntax_Print.comp_to_string uu____3678 in
                         let uu____3679 =
                           let uu____3681 = FStar_Syntax_Syntax.mk_Comp ct2 in
                           FStar_Syntax_Print.comp_to_string uu____3681 in
                         FStar_Util.print2 "Binding c1:%s and c2:%s {\n"
                           uu____3676 uu____3679
                       else ());
                      (let uu____3686 =
                         FStar_All.pipe_left
                           (FStar_TypeChecker_Env.debug env)
                           (FStar_Options.Other "ResolveImplicitsHook") in
                       if uu____3686
                       then
                         let uu____3691 =
                           let uu____3693 =
                             FStar_TypeChecker_Env.get_range env in
                           FStar_Range.string_of_range uu____3693 in
                         let uu____3694 =
                           FStar_Syntax_Print.tscheme_to_string bind_t in
                         FStar_Util.print2
                           "///////////////////////////////Bind at %s/////////////////////\nwith bind_t = %s\n"
                           uu____3691 uu____3694
                       else ());
                      (let uu____3699 =
                         let uu____3706 =
                           FStar_TypeChecker_Env.get_effect_decl env m in
                         let uu____3707 =
                           FStar_TypeChecker_Env.get_effect_decl env n in
                         let uu____3708 =
                           FStar_TypeChecker_Env.get_effect_decl env p in
                         (uu____3706, uu____3707, uu____3708) in
                       match uu____3699 with
                       | (m_ed, n_ed, p_ed) ->
                           let uu____3716 =
                             let uu____3729 =
                               FStar_List.hd
                                 ct1.FStar_Syntax_Syntax.comp_univs in
                             let uu____3730 =
                               FStar_List.map FStar_Pervasives_Native.fst
                                 ct1.FStar_Syntax_Syntax.effect_args in
                             (uu____3729,
                               (ct1.FStar_Syntax_Syntax.result_typ),
                               uu____3730) in
                           (match uu____3716 with
                            | (u1, t1, is1) ->
                                let uu____3774 =
                                  let uu____3787 =
                                    FStar_List.hd
                                      ct2.FStar_Syntax_Syntax.comp_univs in
                                  let uu____3788 =
                                    FStar_List.map
                                      FStar_Pervasives_Native.fst
                                      ct2.FStar_Syntax_Syntax.effect_args in
                                  (uu____3787,
                                    (ct2.FStar_Syntax_Syntax.result_typ),
                                    uu____3788) in
                                (match uu____3774 with
                                 | (u2, t2, is2) ->
                                     let uu____3832 =
                                       FStar_TypeChecker_Env.inst_tscheme_with
                                         bind_t [u1; u2] in
                                     (match uu____3832 with
                                      | (uu____3841, bind_t1) ->
                                          let bind_t_shape_error s =
                                            let uu____3856 =
                                              let uu____3858 =
                                                FStar_Syntax_Print.term_to_string
                                                  bind_t1 in
                                              FStar_Util.format2
                                                "bind %s does not have proper shape (reason:%s)"
                                                uu____3858 s in
                                            (FStar_Errors.Fatal_UnexpectedEffect,
                                              uu____3856) in
                                          let uu____3862 =
                                            let uu____3907 =
                                              let uu____3908 =
                                                FStar_Syntax_Subst.compress
                                                  bind_t1 in
                                              uu____3908.FStar_Syntax_Syntax.n in
                                            match uu____3907 with
                                            | FStar_Syntax_Syntax.Tm_arrow
                                                (bs, c) when
                                                (FStar_List.length bs) >=
                                                  (Prims.of_int (4))
                                                ->
                                                let uu____3984 =
                                                  FStar_Syntax_Subst.open_comp
                                                    bs c in
                                                (match uu____3984 with
                                                 | (a_b::b_b::bs1, c1) ->
                                                     let uu____4069 =
                                                       let uu____4096 =
                                                         FStar_List.splitAt
                                                           ((FStar_List.length
                                                               bs1)
                                                              -
                                                              (Prims.of_int (2)))
                                                           bs1 in
                                                       FStar_All.pipe_right
                                                         uu____4096
                                                         (fun uu____4181 ->
                                                            match uu____4181
                                                            with
                                                            | (l1, l2) ->
                                                                let uu____4262
                                                                  =
                                                                  FStar_List.hd
                                                                    l2 in
                                                                let uu____4275
                                                                  =
                                                                  let uu____4282
                                                                    =
                                                                    FStar_List.tl
                                                                    l2 in
                                                                  FStar_List.hd
                                                                    uu____4282 in
                                                                (l1,
                                                                  uu____4262,
                                                                  uu____4275)) in
                                                     (match uu____4069 with
                                                      | (rest_bs, f_b, g_b)
                                                          ->
                                                          (a_b, b_b, rest_bs,
                                                            f_b, g_b, c1)))
                                            | uu____4442 ->
                                                let uu____4443 =
                                                  bind_t_shape_error
                                                    "Either not an arrow or not enough binders" in
                                                FStar_Errors.raise_error
                                                  uu____4443 r1 in
                                          (match uu____3862 with
                                           | (a_b, b_b, rest_bs, f_b, g_b,
                                              bind_c) ->
                                               let uu____4568 =
                                                 let uu____4575 =
                                                   let uu____4576 =
                                                     let uu____4577 =
                                                       let uu____4584 =
                                                         FStar_All.pipe_right
                                                           a_b
                                                           FStar_Pervasives_Native.fst in
                                                       (uu____4584, t1) in
                                                     FStar_Syntax_Syntax.NT
                                                       uu____4577 in
                                                   let uu____4595 =
                                                     let uu____4598 =
                                                       let uu____4599 =
                                                         let uu____4606 =
                                                           FStar_All.pipe_right
                                                             b_b
                                                             FStar_Pervasives_Native.fst in
                                                         (uu____4606, t2) in
                                                       FStar_Syntax_Syntax.NT
                                                         uu____4599 in
                                                     [uu____4598] in
                                                   uu____4576 :: uu____4595 in
                                                 FStar_TypeChecker_Env.uvars_for_binders
                                                   env rest_bs uu____4575
                                                   (fun b1 ->
                                                      let uu____4622 =
                                                        FStar_Syntax_Print.binder_to_string
                                                          b1 in
                                                      let uu____4624 =
                                                        let uu____4626 =
                                                          FStar_Ident.string_of_lid
                                                            m in
                                                        let uu____4628 =
                                                          FStar_Ident.string_of_lid
                                                            n in
                                                        let uu____4630 =
                                                          FStar_Ident.string_of_lid
                                                            p in
                                                        FStar_Util.format3
                                                          "(%s, %s) |> %s"
                                                          uu____4626
                                                          uu____4628
                                                          uu____4630 in
                                                      let uu____4633 =
                                                        FStar_Range.string_of_range
                                                          r1 in
                                                      FStar_Util.format3
                                                        "implicit var for binder %s of %s at %s"
                                                        uu____4622 uu____4624
                                                        uu____4633) r1 in
                                               (match uu____4568 with
                                                | (rest_bs_uvars, g_uvars) ->
                                                    ((let uu____4647 =
                                                        FStar_All.pipe_left
                                                          (FStar_TypeChecker_Env.debug
                                                             env)
                                                          (FStar_Options.Other
                                                             "ResolveImplicitsHook") in
                                                      if uu____4647
                                                      then
                                                        FStar_All.pipe_right
                                                          rest_bs_uvars
                                                          (FStar_List.iter
                                                             (fun t ->
                                                                let uu____4661
                                                                  =
                                                                  let uu____4662
                                                                    =
                                                                    FStar_Syntax_Subst.compress
                                                                    t in
                                                                  uu____4662.FStar_Syntax_Syntax.n in
                                                                match uu____4661
                                                                with
                                                                | FStar_Syntax_Syntax.Tm_uvar
                                                                    (u,
                                                                    uu____4666)
                                                                    ->
                                                                    let uu____4683
                                                                    =
                                                                    FStar_Syntax_Print.term_to_string
                                                                    t in
                                                                    let uu____4685
                                                                    =
                                                                    match 
                                                                    u.FStar_Syntax_Syntax.ctx_uvar_meta
                                                                    with
                                                                    | 
                                                                    FStar_Pervasives_Native.Some
                                                                    (FStar_Syntax_Syntax.Ctx_uvar_meta_attr
                                                                    a) ->
                                                                    FStar_Syntax_Print.term_to_string
                                                                    a
                                                                    | 
                                                                    uu____4691
                                                                    ->
                                                                    "<no attr>" in
                                                                    FStar_Util.print2
                                                                    "Generated uvar %s with attribute %s\n"
                                                                    uu____4683
                                                                    uu____4685))
                                                      else ());
                                                     (let subst =
                                                        FStar_List.map2
                                                          (fun b1 ->
                                                             fun t ->
                                                               let uu____4722
                                                                 =
                                                                 let uu____4729
                                                                   =
                                                                   FStar_All.pipe_right
                                                                    b1
                                                                    FStar_Pervasives_Native.fst in
                                                                 (uu____4729,
                                                                   t) in
                                                               FStar_Syntax_Syntax.NT
                                                                 uu____4722)
                                                          (a_b :: b_b ::
                                                          rest_bs) (t1 :: t2
                                                          :: rest_bs_uvars) in
                                                      let f_guard =
                                                        let f_sort_is =
                                                          let uu____4758 =
                                                            let uu____4761 =
                                                              let uu____4762
                                                                =
                                                                let uu____4763
                                                                  =
                                                                  FStar_All.pipe_right
                                                                    f_b
                                                                    FStar_Pervasives_Native.fst in
                                                                uu____4763.FStar_Syntax_Syntax.sort in
                                                              FStar_Syntax_Subst.compress
                                                                uu____4762 in
                                                            let uu____4772 =
                                                              FStar_Syntax_Util.is_layered
                                                                m_ed in
                                                            effect_args_from_repr
                                                              uu____4761
                                                              uu____4772 r1 in
                                                          FStar_All.pipe_right
                                                            uu____4758
                                                            (FStar_List.map
                                                               (FStar_Syntax_Subst.subst
                                                                  subst)) in
                                                        FStar_List.fold_left2
                                                          (fun g ->
                                                             fun i1 ->
                                                               fun f_i1 ->
                                                                 (let uu____4797
                                                                    =
                                                                    FStar_All.pipe_left
                                                                    (FStar_TypeChecker_Env.debug
                                                                    env)
                                                                    (FStar_Options.Other
                                                                    "ResolveImplicitsHook") in
                                                                  if
                                                                    uu____4797
                                                                  then
                                                                    let uu____4802
                                                                    =
                                                                    FStar_Syntax_Print.term_to_string
                                                                    i1 in
                                                                    let uu____4804
                                                                    =
                                                                    FStar_Syntax_Print.term_to_string
                                                                    f_i1 in
                                                                    FStar_Util.print2
                                                                    "Generating constraint %s = %s\n"
                                                                    uu____4802
                                                                    uu____4804
                                                                  else ());
                                                                 (let uu____4809
                                                                    =
                                                                    FStar_TypeChecker_Rel.teq
                                                                    env i1
                                                                    f_i1 in
                                                                  FStar_TypeChecker_Env.conj_guard
                                                                    g
                                                                    uu____4809))
                                                          FStar_TypeChecker_Env.trivial_guard
                                                          is1 f_sort_is in
                                                      let g_guard =
                                                        let x_a =
                                                          match b with
                                                          | FStar_Pervasives_Native.None
                                                              ->
                                                              FStar_Syntax_Syntax.null_binder
                                                                ct1.FStar_Syntax_Syntax.result_typ
                                                          | FStar_Pervasives_Native.Some
                                                              x ->
                                                              FStar_Syntax_Syntax.mk_binder
                                                                x in
                                                        let g_sort_is =
                                                          let uu____4828 =
                                                            let uu____4829 =
                                                              let uu____4832
                                                                =
                                                                let uu____4833
                                                                  =
                                                                  FStar_All.pipe_right
                                                                    g_b
                                                                    FStar_Pervasives_Native.fst in
                                                                uu____4833.FStar_Syntax_Syntax.sort in
                                                              FStar_Syntax_Subst.compress
                                                                uu____4832 in
                                                            uu____4829.FStar_Syntax_Syntax.n in
                                                          match uu____4828
                                                          with
                                                          | FStar_Syntax_Syntax.Tm_arrow
                                                              (bs, c) ->
                                                              let uu____4866
                                                                =
                                                                FStar_Syntax_Subst.open_comp
                                                                  bs c in
                                                              (match uu____4866
                                                               with
                                                               | (bs1, c1) ->
                                                                   let bs_subst
                                                                    =
                                                                    let uu____4876
                                                                    =
                                                                    let uu____4883
                                                                    =
                                                                    let uu____4884
                                                                    =
                                                                    FStar_List.hd
                                                                    bs1 in
                                                                    FStar_All.pipe_right
                                                                    uu____4884
                                                                    FStar_Pervasives_Native.fst in
                                                                    let uu____4905
                                                                    =
                                                                    let uu____4908
                                                                    =
                                                                    FStar_All.pipe_right
                                                                    x_a
                                                                    FStar_Pervasives_Native.fst in
                                                                    FStar_All.pipe_right
                                                                    uu____4908
                                                                    FStar_Syntax_Syntax.bv_to_name in
                                                                    (uu____4883,
                                                                    uu____4905) in
                                                                    FStar_Syntax_Syntax.NT
                                                                    uu____4876 in
                                                                   let c2 =
                                                                    FStar_Syntax_Subst.subst_comp
                                                                    [bs_subst]
                                                                    c1 in
                                                                   let uu____4922
                                                                    =
                                                                    let uu____4925
                                                                    =
                                                                    FStar_Syntax_Subst.compress
                                                                    (FStar_Syntax_Util.comp_result
                                                                    c2) in
                                                                    let uu____4926
                                                                    =
                                                                    FStar_Syntax_Util.is_layered
                                                                    n_ed in
                                                                    effect_args_from_repr
                                                                    uu____4925
                                                                    uu____4926
                                                                    r1 in
                                                                   FStar_All.pipe_right
                                                                    uu____4922
                                                                    (FStar_List.map
                                                                    (FStar_Syntax_Subst.subst
                                                                    subst)))
                                                          | uu____4932 ->
                                                              failwith
                                                                "imspossible: mk_indexed_bind" in
                                                        let env_g =
                                                          FStar_TypeChecker_Env.push_binders
                                                            env [x_a] in
                                                        let uu____4949 =
                                                          FStar_List.fold_left2
                                                            (fun g ->
                                                               fun i1 ->
                                                                 fun g_i1 ->
                                                                   (let uu____4967
                                                                    =
                                                                    FStar_All.pipe_left
                                                                    (FStar_TypeChecker_Env.debug
                                                                    env)
                                                                    (FStar_Options.Other
                                                                    "ResolveImplicitsHook") in
                                                                    if
                                                                    uu____4967
                                                                    then
                                                                    let uu____4972
                                                                    =
                                                                    FStar_Syntax_Print.term_to_string
                                                                    i1 in
                                                                    let uu____4974
                                                                    =
                                                                    FStar_Syntax_Print.term_to_string
                                                                    g_i1 in
                                                                    FStar_Util.print2
                                                                    "Generating constraint %s = %s\n"
                                                                    uu____4972
                                                                    uu____4974
                                                                    else ());
                                                                   (let uu____4979
                                                                    =
                                                                    FStar_TypeChecker_Rel.teq
                                                                    env_g i1
                                                                    g_i1 in
                                                                    FStar_TypeChecker_Env.conj_guard
                                                                    g
                                                                    uu____4979))
                                                            FStar_TypeChecker_Env.trivial_guard
                                                            is2 g_sort_is in
                                                        FStar_All.pipe_right
                                                          uu____4949
                                                          (FStar_TypeChecker_Env.close_guard
                                                             env [x_a]) in
                                                      let bind_ct =
                                                        let uu____4993 =
                                                          FStar_All.pipe_right
                                                            bind_c
                                                            (FStar_Syntax_Subst.subst_comp
                                                               subst) in
                                                        FStar_All.pipe_right
                                                          uu____4993
                                                          FStar_Syntax_Util.comp_to_comp_typ in
                                                      let fml =
                                                        let uu____4995 =
                                                          let uu____5000 =
                                                            FStar_List.hd
                                                              bind_ct.FStar_Syntax_Syntax.comp_univs in
                                                          let uu____5001 =
                                                            let uu____5002 =
                                                              FStar_List.hd
                                                                bind_ct.FStar_Syntax_Syntax.effect_args in
                                                            FStar_Pervasives_Native.fst
                                                              uu____5002 in
                                                          (uu____5000,
                                                            uu____5001) in
                                                        match uu____4995 with
                                                        | (u, wp) ->
                                                            FStar_TypeChecker_Env.pure_precondition_for_trivial_post
                                                              env u
                                                              bind_ct.FStar_Syntax_Syntax.result_typ
                                                              wp
                                                              FStar_Range.dummyRange in
                                                      let is =
                                                        let uu____5028 =
                                                          FStar_Syntax_Subst.compress
                                                            bind_ct.FStar_Syntax_Syntax.result_typ in
                                                        let uu____5029 =
                                                          FStar_Syntax_Util.is_layered
                                                            p_ed in
                                                        effect_args_from_repr
                                                          uu____5028
                                                          uu____5029 r1 in
                                                      let c =
                                                        let uu____5032 =
                                                          let uu____5033 =
                                                            FStar_List.map
                                                              FStar_Syntax_Syntax.as_arg
                                                              is in
                                                          {
                                                            FStar_Syntax_Syntax.comp_univs
                                                              =
                                                              (ct2.FStar_Syntax_Syntax.comp_univs);
                                                            FStar_Syntax_Syntax.effect_name
                                                              =
                                                              (p_ed.FStar_Syntax_Syntax.mname);
                                                            FStar_Syntax_Syntax.result_typ
                                                              = t2;
                                                            FStar_Syntax_Syntax.effect_args
                                                              = uu____5033;
                                                            FStar_Syntax_Syntax.flags
                                                              = flags
                                                          } in
                                                        FStar_Syntax_Syntax.mk_Comp
                                                          uu____5032 in
                                                      (let uu____5053 =
                                                         FStar_All.pipe_left
                                                           (FStar_TypeChecker_Env.debug
                                                              env)
                                                           (FStar_Options.Other
                                                              "LayeredEffects") in
                                                       if uu____5053
                                                       then
                                                         let uu____5058 =
                                                           FStar_Syntax_Print.comp_to_string
                                                             c in
                                                         FStar_Util.print1
                                                           "} c after bind: %s\n"
                                                           uu____5058
                                                       else ());
                                                      (let guard =
                                                         let uu____5064 =
                                                           let uu____5067 =
                                                             let uu____5070 =
                                                               let uu____5073
                                                                 =
                                                                 let uu____5076
                                                                   =
                                                                   FStar_TypeChecker_Env.guard_of_guard_formula
                                                                    (FStar_TypeChecker_Common.NonTrivial
                                                                    fml) in
                                                                 [uu____5076] in
                                                               g_guard ::
                                                                 uu____5073 in
                                                             f_guard ::
                                                               uu____5070 in
                                                           g_uvars ::
                                                             uu____5067 in
                                                         FStar_TypeChecker_Env.conj_guards
                                                           uu____5064 in
                                                       (let uu____5078 =
                                                          FStar_All.pipe_left
                                                            (FStar_TypeChecker_Env.debug
                                                               env)
                                                            (FStar_Options.Other
                                                               "ResolveImplicitsHook") in
                                                        if uu____5078
                                                        then
                                                          let uu____5083 =
                                                            let uu____5085 =
                                                              FStar_TypeChecker_Env.get_range
                                                                env in
                                                            FStar_Range.string_of_range
                                                              uu____5085 in
                                                          let uu____5086 =
                                                            FStar_TypeChecker_Rel.guard_to_string
                                                              env guard in
                                                          FStar_Util.print2
                                                            "///////////////////////////////EndBind at %s/////////////////////\nguard = %s\n"
                                                            uu____5083
                                                            uu____5086
                                                        else ());
                                                       (c, guard))))))))))
let (mk_wp_bind :
  FStar_TypeChecker_Env.env ->
    FStar_Ident.lident ->
      FStar_Syntax_Syntax.comp_typ ->
        FStar_Syntax_Syntax.bv FStar_Pervasives_Native.option ->
          FStar_Syntax_Syntax.comp_typ ->
            FStar_Syntax_Syntax.cflag Prims.list ->
              FStar_Range.range -> FStar_Syntax_Syntax.comp)
  =
  fun env ->
    fun m ->
      fun ct1 ->
        fun b ->
          fun ct2 ->
            fun flags ->
              fun r1 ->
                let uu____5135 =
                  let md = FStar_TypeChecker_Env.get_effect_decl env m in
                  let uu____5161 = FStar_TypeChecker_Env.wp_signature env m in
                  match uu____5161 with
                  | (a, kwp) ->
                      let uu____5192 = destruct_wp_comp ct1 in
                      let uu____5199 = destruct_wp_comp ct2 in
                      ((md, a, kwp), uu____5192, uu____5199) in
                match uu____5135 with
                | ((md, a, kwp), (u_t1, t1, wp1), (u_t2, t2, wp2)) ->
                    let bs =
                      match b with
                      | FStar_Pervasives_Native.None ->
                          let uu____5252 = FStar_Syntax_Syntax.null_binder t1 in
                          [uu____5252]
                      | FStar_Pervasives_Native.Some x ->
                          let uu____5272 = FStar_Syntax_Syntax.mk_binder x in
                          [uu____5272] in
                    let mk_lam wp =
                      FStar_Syntax_Util.abs bs wp
                        (FStar_Pervasives_Native.Some
                           (FStar_Syntax_Util.mk_residual_comp
                              FStar_Parser_Const.effect_Tot_lid
                              FStar_Pervasives_Native.None
                              [FStar_Syntax_Syntax.TOTAL])) in
                    let r11 =
                      FStar_Syntax_Syntax.mk
                        (FStar_Syntax_Syntax.Tm_constant
                           (FStar_Const.Const_range r1)) r1 in
                    let wp_args =
                      let uu____5319 = FStar_Syntax_Syntax.as_arg r11 in
                      let uu____5328 =
                        let uu____5339 = FStar_Syntax_Syntax.as_arg t1 in
                        let uu____5348 =
                          let uu____5359 = FStar_Syntax_Syntax.as_arg t2 in
                          let uu____5368 =
                            let uu____5379 = FStar_Syntax_Syntax.as_arg wp1 in
                            let uu____5388 =
                              let uu____5399 =
                                let uu____5408 = mk_lam wp2 in
                                FStar_Syntax_Syntax.as_arg uu____5408 in
                              [uu____5399] in
                            uu____5379 :: uu____5388 in
                          uu____5359 :: uu____5368 in
                        uu____5339 :: uu____5348 in
                      uu____5319 :: uu____5328 in
                    let bind_wp =
                      FStar_All.pipe_right md
                        FStar_Syntax_Util.get_bind_vc_combinator in
                    let wp =
                      let uu____5459 =
                        FStar_TypeChecker_Env.inst_effect_fun_with
                          [u_t1; u_t2] env md bind_wp in
                      FStar_Syntax_Syntax.mk_Tm_app uu____5459 wp_args
                        t2.FStar_Syntax_Syntax.pos in
                    mk_comp md u_t2 t2 wp flags
let (mk_bind :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.comp ->
      FStar_Syntax_Syntax.bv FStar_Pervasives_Native.option ->
        FStar_Syntax_Syntax.comp ->
          FStar_Syntax_Syntax.cflag Prims.list ->
            FStar_Range.range ->
              (FStar_Syntax_Syntax.comp * FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun c1 ->
      fun b ->
        fun c2 ->
          fun flags ->
            fun r1 ->
              let uu____5507 =
                let uu____5512 =
                  FStar_TypeChecker_Env.unfold_effect_abbrev env c1 in
                let uu____5513 =
                  FStar_TypeChecker_Env.unfold_effect_abbrev env c2 in
                (uu____5512, uu____5513) in
              match uu____5507 with
              | (ct1, ct2) ->
                  let uu____5520 =
                    FStar_TypeChecker_Env.exists_polymonadic_bind env
                      ct1.FStar_Syntax_Syntax.effect_name
                      ct2.FStar_Syntax_Syntax.effect_name in
                  (match uu____5520 with
                   | FStar_Pervasives_Native.Some (p, f_bind) ->
                       f_bind env ct1 b ct2 flags r1
                   | FStar_Pervasives_Native.None ->
                       let uu____5571 = lift_comps env c1 c2 b true in
                       (match uu____5571 with
                        | (m, c11, c21, g_lift) ->
                            let uu____5589 =
                              let uu____5594 =
                                FStar_Syntax_Util.comp_to_comp_typ c11 in
                              let uu____5595 =
                                FStar_Syntax_Util.comp_to_comp_typ c21 in
                              (uu____5594, uu____5595) in
                            (match uu____5589 with
                             | (ct11, ct21) ->
                                 let uu____5602 =
                                   let uu____5607 =
                                     FStar_TypeChecker_Env.is_layered_effect
                                       env m in
                                   if uu____5607
                                   then
                                     let bind_t =
                                       let uu____5615 =
                                         FStar_All.pipe_right m
                                           (FStar_TypeChecker_Env.get_effect_decl
                                              env) in
                                       FStar_All.pipe_right uu____5615
                                         FStar_Syntax_Util.get_bind_vc_combinator in
                                     mk_indexed_bind env m m m bind_t ct11 b
                                       ct21 flags r1
                                   else
                                     (let uu____5618 =
                                        mk_wp_bind env m ct11 b ct21 flags r1 in
                                      (uu____5618,
                                        FStar_TypeChecker_Env.trivial_guard)) in
                                 (match uu____5602 with
                                  | (c, g_bind) ->
                                      let uu____5625 =
                                        FStar_TypeChecker_Env.conj_guard
                                          g_lift g_bind in
                                      (c, uu____5625)))))
let (bind_pure_wp_with :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.typ ->
      FStar_Syntax_Syntax.comp ->
        FStar_Syntax_Syntax.cflag Prims.list ->
          (FStar_Syntax_Syntax.comp * FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun wp1 ->
      fun c ->
        fun flags ->
          let r = FStar_TypeChecker_Env.get_range env in
          let pure_c =
            let uu____5661 =
              let uu____5662 =
                let uu____5673 =
                  FStar_All.pipe_right wp1 FStar_Syntax_Syntax.as_arg in
                [uu____5673] in
              {
                FStar_Syntax_Syntax.comp_univs = [FStar_Syntax_Syntax.U_zero];
                FStar_Syntax_Syntax.effect_name =
                  FStar_Parser_Const.effect_PURE_lid;
                FStar_Syntax_Syntax.result_typ = FStar_Syntax_Syntax.t_unit;
                FStar_Syntax_Syntax.effect_args = uu____5662;
                FStar_Syntax_Syntax.flags = []
              } in
            FStar_Syntax_Syntax.mk_Comp uu____5661 in
          mk_bind env pure_c FStar_Pervasives_Native.None c flags r
let (weaken_flags :
  FStar_Syntax_Syntax.cflag Prims.list ->
    FStar_Syntax_Syntax.cflag Prims.list)
  =
  fun flags ->
    let uu____5718 =
      FStar_All.pipe_right flags
        (FStar_Util.for_some
           (fun uu___1_5724 ->
              match uu___1_5724 with
              | FStar_Syntax_Syntax.SHOULD_NOT_INLINE -> true
              | uu____5727 -> false)) in
    if uu____5718
    then [FStar_Syntax_Syntax.SHOULD_NOT_INLINE]
    else
      FStar_All.pipe_right flags
        (FStar_List.collect
           (fun uu___2_5739 ->
              match uu___2_5739 with
              | FStar_Syntax_Syntax.TOTAL ->
                  [FStar_Syntax_Syntax.TRIVIAL_POSTCONDITION]
              | FStar_Syntax_Syntax.RETURN ->
                  [FStar_Syntax_Syntax.PARTIAL_RETURN;
                  FStar_Syntax_Syntax.TRIVIAL_POSTCONDITION]
              | f -> [f]))
let (weaken_comp :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.comp ->
      FStar_Syntax_Syntax.term ->
        (FStar_Syntax_Syntax.comp * FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun c ->
      fun formula ->
        let uu____5767 = FStar_Syntax_Util.is_ml_comp c in
        if uu____5767
        then (c, FStar_TypeChecker_Env.trivial_guard)
        else
          (let ct = FStar_TypeChecker_Env.unfold_effect_abbrev env c in
           let pure_assume_wp =
             let uu____5778 =
               FStar_Syntax_Syntax.lid_as_fv
                 FStar_Parser_Const.pure_assume_wp_lid
                 (FStar_Syntax_Syntax.Delta_constant_at_level Prims.int_one)
                 FStar_Pervasives_Native.None in
             FStar_Syntax_Syntax.fv_to_tm uu____5778 in
           let pure_assume_wp1 =
             let uu____5781 =
               let uu____5782 =
                 FStar_All.pipe_left FStar_Syntax_Syntax.as_arg formula in
               [uu____5782] in
             let uu____5815 = FStar_TypeChecker_Env.get_range env in
             FStar_Syntax_Syntax.mk_Tm_app pure_assume_wp uu____5781
               uu____5815 in
           let uu____5816 = weaken_flags ct.FStar_Syntax_Syntax.flags in
           bind_pure_wp_with env pure_assume_wp1 c uu____5816)
let (weaken_precondition :
  FStar_TypeChecker_Env.env ->
    FStar_TypeChecker_Common.lcomp ->
      FStar_TypeChecker_Common.guard_formula ->
        FStar_TypeChecker_Common.lcomp)
  =
  fun env ->
    fun lc ->
      fun f ->
        let weaken uu____5844 =
          let uu____5845 = FStar_TypeChecker_Common.lcomp_comp lc in
          match uu____5845 with
          | (c, g_c) ->
              let uu____5856 =
                env.FStar_TypeChecker_Env.lax && (FStar_Options.ml_ish ()) in
              if uu____5856
              then (c, g_c)
              else
                (match f with
                 | FStar_TypeChecker_Common.Trivial -> (c, g_c)
                 | FStar_TypeChecker_Common.NonTrivial f1 ->
                     let uu____5870 = weaken_comp env c f1 in
                     (match uu____5870 with
                      | (c1, g_w) ->
                          let uu____5881 =
                            FStar_TypeChecker_Env.conj_guard g_c g_w in
                          (c1, uu____5881))) in
        let uu____5882 = weaken_flags lc.FStar_TypeChecker_Common.cflags in
        FStar_TypeChecker_Common.mk_lcomp
          lc.FStar_TypeChecker_Common.eff_name
          lc.FStar_TypeChecker_Common.res_typ uu____5882 weaken
let (strengthen_comp :
  FStar_TypeChecker_Env.env ->
    (unit -> Prims.string) FStar_Pervasives_Native.option ->
      FStar_Syntax_Syntax.comp ->
        FStar_Syntax_Syntax.formula ->
          FStar_Syntax_Syntax.cflag Prims.list ->
            (FStar_Syntax_Syntax.comp * FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun reason ->
      fun c ->
        fun f ->
          fun flags ->
            if env.FStar_TypeChecker_Env.lax
            then (c, FStar_TypeChecker_Env.trivial_guard)
            else
              (let r = FStar_TypeChecker_Env.get_range env in
               let pure_assert_wp =
                 let uu____5939 =
                   FStar_Syntax_Syntax.lid_as_fv
                     FStar_Parser_Const.pure_assert_wp_lid
                     (FStar_Syntax_Syntax.Delta_constant_at_level
                        Prims.int_one) FStar_Pervasives_Native.None in
                 FStar_Syntax_Syntax.fv_to_tm uu____5939 in
               let pure_assert_wp1 =
                 let uu____5942 =
                   let uu____5943 =
                     let uu____5952 = label_opt env reason r f in
                     FStar_All.pipe_left FStar_Syntax_Syntax.as_arg
                       uu____5952 in
                   [uu____5943] in
                 FStar_Syntax_Syntax.mk_Tm_app pure_assert_wp uu____5942 r in
               bind_pure_wp_with env pure_assert_wp1 c flags)
let (strengthen_precondition :
  (unit -> Prims.string) FStar_Pervasives_Native.option ->
    FStar_TypeChecker_Env.env ->
      FStar_Syntax_Syntax.term ->
        FStar_TypeChecker_Common.lcomp ->
          FStar_TypeChecker_Common.guard_t ->
            (FStar_TypeChecker_Common.lcomp *
              FStar_TypeChecker_Common.guard_t))
  =
  fun reason ->
    fun env ->
      fun e_for_debugging_only ->
        fun lc ->
          fun g0 ->
            let uu____6022 =
              FStar_TypeChecker_Env.is_trivial_guard_formula g0 in
            if uu____6022
            then (lc, g0)
            else
              (let flags =
                 let uu____6034 =
                   let uu____6042 =
                     FStar_TypeChecker_Common.is_tot_or_gtot_lcomp lc in
                   if uu____6042
                   then (true, [FStar_Syntax_Syntax.TRIVIAL_POSTCONDITION])
                   else (false, []) in
                 match uu____6034 with
                 | (maybe_trivial_post, flags) ->
                     let uu____6072 =
                       FStar_All.pipe_right
                         lc.FStar_TypeChecker_Common.cflags
                         (FStar_List.collect
                            (fun uu___3_6080 ->
                               match uu___3_6080 with
                               | FStar_Syntax_Syntax.RETURN ->
                                   [FStar_Syntax_Syntax.PARTIAL_RETURN]
                               | FStar_Syntax_Syntax.PARTIAL_RETURN ->
                                   [FStar_Syntax_Syntax.PARTIAL_RETURN]
                               | FStar_Syntax_Syntax.SOMETRIVIAL when
                                   Prims.op_Negation maybe_trivial_post ->
                                   [FStar_Syntax_Syntax.TRIVIAL_POSTCONDITION]
                               | FStar_Syntax_Syntax.TRIVIAL_POSTCONDITION
                                   when Prims.op_Negation maybe_trivial_post
                                   ->
                                   [FStar_Syntax_Syntax.TRIVIAL_POSTCONDITION]
                               | FStar_Syntax_Syntax.SHOULD_NOT_INLINE ->
                                   [FStar_Syntax_Syntax.SHOULD_NOT_INLINE]
                               | uu____6083 -> [])) in
                     FStar_List.append flags uu____6072 in
               let strengthen uu____6093 =
                 let uu____6094 = FStar_TypeChecker_Common.lcomp_comp lc in
                 match uu____6094 with
                 | (c, g_c) ->
                     if env.FStar_TypeChecker_Env.lax
                     then (c, g_c)
                     else
                       (let g01 = FStar_TypeChecker_Rel.simplify_guard env g0 in
                        let uu____6113 = FStar_TypeChecker_Env.guard_form g01 in
                        match uu____6113 with
                        | FStar_TypeChecker_Common.Trivial -> (c, g_c)
                        | FStar_TypeChecker_Common.NonTrivial f ->
                            ((let uu____6120 =
                                FStar_All.pipe_left
                                  (FStar_TypeChecker_Env.debug env)
                                  FStar_Options.Extreme in
                              if uu____6120
                              then
                                let uu____6124 =
                                  FStar_TypeChecker_Normalize.term_to_string
                                    env e_for_debugging_only in
                                let uu____6126 =
                                  FStar_TypeChecker_Normalize.term_to_string
                                    env f in
                                FStar_Util.print2
                                  "-------------Strengthening pre-condition of term %s with guard %s\n"
                                  uu____6124 uu____6126
                              else ());
                             (let uu____6131 =
                                strengthen_comp env reason c f flags in
                              match uu____6131 with
                              | (c1, g_s) ->
                                  let uu____6142 =
                                    FStar_TypeChecker_Env.conj_guard g_c g_s in
                                  (c1, uu____6142)))) in
               let uu____6143 =
                 let uu____6144 =
                   FStar_TypeChecker_Env.norm_eff_name env
                     lc.FStar_TypeChecker_Common.eff_name in
                 FStar_TypeChecker_Common.mk_lcomp uu____6144
                   lc.FStar_TypeChecker_Common.res_typ flags strengthen in
               (uu____6143,
                 (let uu___725_6146 = g0 in
                  {
                    FStar_TypeChecker_Common.guard_f =
                      FStar_TypeChecker_Common.Trivial;
                    FStar_TypeChecker_Common.deferred_to_tac =
                      (uu___725_6146.FStar_TypeChecker_Common.deferred_to_tac);
                    FStar_TypeChecker_Common.deferred =
                      (uu___725_6146.FStar_TypeChecker_Common.deferred);
                    FStar_TypeChecker_Common.univ_ineqs =
                      (uu___725_6146.FStar_TypeChecker_Common.univ_ineqs);
                    FStar_TypeChecker_Common.implicits =
                      (uu___725_6146.FStar_TypeChecker_Common.implicits)
                  })))
let (lcomp_has_trivial_postcondition :
  FStar_TypeChecker_Common.lcomp -> Prims.bool) =
  fun lc ->
    (FStar_TypeChecker_Common.is_tot_or_gtot_lcomp lc) ||
      (FStar_Util.for_some
         (fun uu___4_6155 ->
            match uu___4_6155 with
            | FStar_Syntax_Syntax.SOMETRIVIAL -> true
            | FStar_Syntax_Syntax.TRIVIAL_POSTCONDITION -> true
            | uu____6159 -> false) lc.FStar_TypeChecker_Common.cflags)
let (maybe_add_with_type :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.universe FStar_Pervasives_Native.option ->
      FStar_TypeChecker_Common.lcomp ->
        FStar_Syntax_Syntax.term ->
          FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun env ->
    fun uopt ->
      fun lc ->
        fun e ->
          let uu____6188 =
            (FStar_TypeChecker_Common.is_lcomp_partial_return lc) ||
              env.FStar_TypeChecker_Env.lax in
          if uu____6188
          then e
          else
            (let uu____6195 =
               (lcomp_has_trivial_postcondition lc) &&
                 (let uu____6198 =
                    FStar_TypeChecker_Env.try_lookup_lid env
                      FStar_Parser_Const.with_type_lid in
                  FStar_Option.isSome uu____6198) in
             if uu____6195
             then
               let u =
                 match uopt with
                 | FStar_Pervasives_Native.Some u -> u
                 | FStar_Pervasives_Native.None ->
                     env.FStar_TypeChecker_Env.universe_of env
                       lc.FStar_TypeChecker_Common.res_typ in
               FStar_Syntax_Util.mk_with_type u
                 lc.FStar_TypeChecker_Common.res_typ e
             else e)
let (maybe_capture_unit_refinement :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.bv ->
        FStar_Syntax_Syntax.comp ->
          (FStar_Syntax_Syntax.comp * FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun t ->
      fun x ->
        fun c ->
          let t1 =
            FStar_TypeChecker_Normalize.normalize_refinement
              FStar_TypeChecker_Normalize.whnf_steps env t in
          match t1.FStar_Syntax_Syntax.n with
          | FStar_Syntax_Syntax.Tm_refine (b, phi) ->
              let is_unit =
                match (b.FStar_Syntax_Syntax.sort).FStar_Syntax_Syntax.n with
                | FStar_Syntax_Syntax.Tm_fvar fv ->
                    FStar_Syntax_Syntax.fv_eq_lid fv
                      FStar_Parser_Const.unit_lid
                | uu____6268 -> false in
              if is_unit
              then
                let uu____6275 =
                  let uu____6277 =
                    let uu____6278 =
                      FStar_All.pipe_right c
                        FStar_Syntax_Util.comp_effect_name in
                    FStar_All.pipe_right uu____6278
                      (FStar_TypeChecker_Env.norm_eff_name env) in
                  FStar_All.pipe_right uu____6277
                    (FStar_TypeChecker_Env.is_layered_effect env) in
                (if uu____6275
                 then
                   let uu____6287 = FStar_Syntax_Subst.open_term_bv b phi in
                   match uu____6287 with
                   | (b1, phi1) ->
                       let phi2 =
                         FStar_Syntax_Subst.subst
                           [FStar_Syntax_Syntax.NT
                              (b1, FStar_Syntax_Syntax.unit_const)] phi1 in
                       weaken_comp env c phi2
                 else
                   (let uu____6303 = close_wp_comp env [x] c in
                    (uu____6303, FStar_TypeChecker_Env.trivial_guard)))
              else (c, FStar_TypeChecker_Env.trivial_guard)
          | uu____6306 -> (c, FStar_TypeChecker_Env.trivial_guard)
let (bind :
  FStar_Range.range ->
    FStar_TypeChecker_Env.env ->
      FStar_Syntax_Syntax.term FStar_Pervasives_Native.option ->
        FStar_TypeChecker_Common.lcomp ->
          lcomp_with_binder -> FStar_TypeChecker_Common.lcomp)
  =
  fun r1 ->
    fun env ->
      fun e1opt ->
        fun lc1 ->
          fun uu____6334 ->
            match uu____6334 with
            | (b, lc2) ->
                let debug f =
                  let uu____6354 =
                    (FStar_TypeChecker_Env.debug env FStar_Options.Extreme)
                      ||
                      (FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
                         (FStar_Options.Other "bind")) in
                  if uu____6354 then f () else () in
                let lc11 =
                  FStar_TypeChecker_Normalize.ghost_to_pure_lcomp env lc1 in
                let lc21 =
                  FStar_TypeChecker_Normalize.ghost_to_pure_lcomp env lc2 in
                let joined_eff = join_lcomp env lc11 lc21 in
                let bind_flags =
                  let uu____6367 =
                    (should_not_inline_lc lc11) ||
                      (should_not_inline_lc lc21) in
                  if uu____6367
                  then [FStar_Syntax_Syntax.SHOULD_NOT_INLINE]
                  else
                    (let flags =
                       let uu____6377 =
                         FStar_TypeChecker_Common.is_total_lcomp lc11 in
                       if uu____6377
                       then
                         let uu____6382 =
                           FStar_TypeChecker_Common.is_total_lcomp lc21 in
                         (if uu____6382
                          then [FStar_Syntax_Syntax.TOTAL]
                          else
                            (let uu____6389 =
                               FStar_TypeChecker_Common.is_tot_or_gtot_lcomp
                                 lc21 in
                             if uu____6389
                             then [FStar_Syntax_Syntax.SOMETRIVIAL]
                             else []))
                       else
                         (let uu____6398 =
                            (FStar_TypeChecker_Common.is_tot_or_gtot_lcomp
                               lc11)
                              &&
                              (FStar_TypeChecker_Common.is_tot_or_gtot_lcomp
                                 lc21) in
                          if uu____6398
                          then [FStar_Syntax_Syntax.SOMETRIVIAL]
                          else []) in
                     let uu____6405 = lcomp_has_trivial_postcondition lc21 in
                     if uu____6405
                     then FStar_Syntax_Syntax.TRIVIAL_POSTCONDITION :: flags
                     else flags) in
                let bind_it uu____6421 =
                  let uu____6422 =
                    env.FStar_TypeChecker_Env.lax &&
                      (FStar_Options.ml_ish ()) in
                  if uu____6422
                  then
                    let u_t =
                      env.FStar_TypeChecker_Env.universe_of env
                        lc21.FStar_TypeChecker_Common.res_typ in
                    let uu____6430 =
                      lax_mk_tot_or_comp_l joined_eff u_t
                        lc21.FStar_TypeChecker_Common.res_typ [] in
                    (uu____6430, FStar_TypeChecker_Env.trivial_guard)
                  else
                    (let uu____6433 =
                       FStar_TypeChecker_Common.lcomp_comp lc11 in
                     match uu____6433 with
                     | (c1, g_c1) ->
                         let uu____6444 =
                           FStar_TypeChecker_Common.lcomp_comp lc21 in
                         (match uu____6444 with
                          | (c2, g_c2) ->
                              let trivial_guard =
                                let uu____6456 =
                                  match b with
                                  | FStar_Pervasives_Native.Some x ->
                                      let b1 =
                                        FStar_Syntax_Syntax.mk_binder x in
                                      let uu____6459 =
                                        FStar_Syntax_Syntax.is_null_binder b1 in
                                      if uu____6459
                                      then g_c2
                                      else
                                        FStar_TypeChecker_Env.close_guard env
                                          [b1] g_c2
                                  | FStar_Pervasives_Native.None -> g_c2 in
                                FStar_TypeChecker_Env.conj_guard g_c1
                                  uu____6456 in
                              (debug
                                 (fun uu____6485 ->
                                    let uu____6486 =
                                      FStar_Syntax_Print.comp_to_string c1 in
                                    let uu____6488 =
                                      match b with
                                      | FStar_Pervasives_Native.None ->
                                          "none"
                                      | FStar_Pervasives_Native.Some x ->
                                          FStar_Syntax_Print.bv_to_string x in
                                    let uu____6493 =
                                      FStar_Syntax_Print.comp_to_string c2 in
                                    FStar_Util.print3
                                      "(1) bind: \n\tc1=%s\n\tx=%s\n\tc2=%s\n(1. end bind)\n"
                                      uu____6486 uu____6488 uu____6493);
                               (let aux uu____6511 =
                                  let uu____6512 =
                                    FStar_Syntax_Util.is_trivial_wp c1 in
                                  if uu____6512
                                  then
                                    match b with
                                    | FStar_Pervasives_Native.None ->
                                        FStar_Util.Inl
                                          (c2, "trivial no binder")
                                    | FStar_Pervasives_Native.Some uu____6543
                                        ->
                                        let uu____6544 =
                                          FStar_Syntax_Util.is_ml_comp c2 in
                                        (if uu____6544
                                         then
                                           FStar_Util.Inl (c2, "trivial ml")
                                         else
                                           FStar_Util.Inr
                                             "c1 trivial; but c2 is not ML")
                                  else
                                    (let uu____6576 =
                                       (FStar_Syntax_Util.is_ml_comp c1) &&
                                         (FStar_Syntax_Util.is_ml_comp c2) in
                                     if uu____6576
                                     then FStar_Util.Inl (c2, "both ml")
                                     else
                                       FStar_Util.Inr
                                         "c1 not trivial, and both are not ML") in
                                let try_simplify uu____6623 =
                                  let aux_with_trivial_guard uu____6653 =
                                    let uu____6654 = aux () in
                                    match uu____6654 with
                                    | FStar_Util.Inl (c, reason) ->
                                        FStar_Util.Inl
                                          (c, trivial_guard, reason)
                                    | FStar_Util.Inr reason ->
                                        FStar_Util.Inr reason in
                                  let uu____6712 =
                                    let uu____6714 =
                                      FStar_TypeChecker_Env.try_lookup_effect_lid
                                        env
                                        FStar_Parser_Const.effect_GTot_lid in
                                    FStar_Option.isNone uu____6714 in
                                  if uu____6712
                                  then
                                    let uu____6730 =
                                      (FStar_Syntax_Util.is_tot_or_gtot_comp
                                         c1)
                                        &&
                                        (FStar_Syntax_Util.is_tot_or_gtot_comp
                                           c2) in
                                    (if uu____6730
                                     then
                                       FStar_Util.Inl
                                         (c2, trivial_guard,
                                           "Early in prims; we don't have bind yet")
                                     else
                                       (let uu____6757 =
                                          FStar_TypeChecker_Env.get_range env in
                                        FStar_Errors.raise_error
                                          (FStar_Errors.Fatal_NonTrivialPreConditionInPrims,
                                            "Non-trivial pre-conditions very early in prims, even before we have defined the PURE monad")
                                          uu____6757))
                                  else
                                    (let uu____6774 =
                                       FStar_Syntax_Util.is_total_comp c1 in
                                     if uu____6774
                                     then
                                       let close_with_type_of_x x c =
                                         let x1 =
                                           let uu___828_6805 = x in
                                           {
                                             FStar_Syntax_Syntax.ppname =
                                               (uu___828_6805.FStar_Syntax_Syntax.ppname);
                                             FStar_Syntax_Syntax.index =
                                               (uu___828_6805.FStar_Syntax_Syntax.index);
                                             FStar_Syntax_Syntax.sort =
                                               (FStar_Syntax_Util.comp_result
                                                  c1)
                                           } in
                                         maybe_capture_unit_refinement env
                                           x1.FStar_Syntax_Syntax.sort x1 c in
                                       match (e1opt, b) with
                                       | (FStar_Pervasives_Native.Some e,
                                          FStar_Pervasives_Native.Some x) ->
                                           let uu____6836 =
                                             let uu____6841 =
                                               FStar_All.pipe_right c2
                                                 (FStar_Syntax_Subst.subst_comp
                                                    [FStar_Syntax_Syntax.NT
                                                       (x, e)]) in
                                             FStar_All.pipe_right uu____6841
                                               (close_with_type_of_x x) in
                                           (match uu____6836 with
                                            | (c21, g_close) ->
                                                let uu____6862 =
                                                  let uu____6870 =
                                                    let uu____6871 =
                                                      let uu____6874 =
                                                        let uu____6877 =
                                                          FStar_TypeChecker_Env.map_guard
                                                            g_c2
                                                            (FStar_Syntax_Subst.subst
                                                               [FStar_Syntax_Syntax.NT
                                                                  (x, e)]) in
                                                        [uu____6877; g_close] in
                                                      g_c1 :: uu____6874 in
                                                    FStar_TypeChecker_Env.conj_guards
                                                      uu____6871 in
                                                  (c21, uu____6870, "c1 Tot") in
                                                FStar_Util.Inl uu____6862)
                                       | (uu____6890,
                                          FStar_Pervasives_Native.Some x) ->
                                           let uu____6902 =
                                             FStar_All.pipe_right c2
                                               (close_with_type_of_x x) in
                                           (match uu____6902 with
                                            | (c21, g_close) ->
                                                let uu____6925 =
                                                  let uu____6933 =
                                                    let uu____6934 =
                                                      let uu____6937 =
                                                        let uu____6940 =
                                                          let uu____6941 =
                                                            let uu____6942 =
                                                              FStar_Syntax_Syntax.mk_binder
                                                                x in
                                                            [uu____6942] in
                                                          FStar_TypeChecker_Env.close_guard
                                                            env uu____6941
                                                            g_c2 in
                                                        [uu____6940; g_close] in
                                                      g_c1 :: uu____6937 in
                                                    FStar_TypeChecker_Env.conj_guards
                                                      uu____6934 in
                                                  (c21, uu____6933,
                                                    "c1 Tot only close") in
                                                FStar_Util.Inl uu____6925)
                                       | (uu____6971, uu____6972) ->
                                           aux_with_trivial_guard ()
                                     else
                                       (let uu____6987 =
                                          (FStar_Syntax_Util.is_tot_or_gtot_comp
                                             c1)
                                            &&
                                            (FStar_Syntax_Util.is_tot_or_gtot_comp
                                               c2) in
                                        if uu____6987
                                        then
                                          let uu____7002 =
                                            let uu____7010 =
                                              FStar_Syntax_Syntax.mk_GTotal
                                                (FStar_Syntax_Util.comp_result
                                                   c2) in
                                            (uu____7010, trivial_guard,
                                              "both GTot") in
                                          FStar_Util.Inl uu____7002
                                        else aux_with_trivial_guard ())) in
                                let uu____7023 = try_simplify () in
                                match uu____7023 with
                                | FStar_Util.Inl (c, g, reason) ->
                                    (debug
                                       (fun uu____7058 ->
                                          let uu____7059 =
                                            FStar_Syntax_Print.comp_to_string
                                              c in
                                          FStar_Util.print2
                                            "(2) bind: Simplified (because %s) to\n\t%s\n"
                                            reason uu____7059);
                                     (c, g))
                                | FStar_Util.Inr reason ->
                                    (debug
                                       (fun uu____7075 ->
                                          FStar_Util.print1
                                            "(2) bind: Not simplified because %s\n"
                                            reason);
                                     (let mk_bind1 c11 b1 c21 g =
                                        let uu____7106 =
                                          mk_bind env c11 b1 c21 bind_flags
                                            r1 in
                                        match uu____7106 with
                                        | (c, g_bind) ->
                                            let uu____7117 =
                                              FStar_TypeChecker_Env.conj_guard
                                                g g_bind in
                                            (c, uu____7117) in
                                      let mk_seq c11 b1 c21 =
                                        let c12 =
                                          FStar_TypeChecker_Env.unfold_effect_abbrev
                                            env c11 in
                                        let c22 =
                                          FStar_TypeChecker_Env.unfold_effect_abbrev
                                            env c21 in
                                        let uu____7144 =
                                          FStar_TypeChecker_Env.join env
                                            c12.FStar_Syntax_Syntax.effect_name
                                            c22.FStar_Syntax_Syntax.effect_name in
                                        match uu____7144 with
                                        | (m, uu____7156, lift2) ->
                                            let uu____7158 =
                                              lift_comp env c22 lift2 in
                                            (match uu____7158 with
                                             | (c23, g2) ->
                                                 let uu____7169 =
                                                   destruct_wp_comp c12 in
                                                 (match uu____7169 with
                                                  | (u1, t1, wp1) ->
                                                      let md_pure_or_ghost =
                                                        FStar_TypeChecker_Env.get_effect_decl
                                                          env
                                                          c12.FStar_Syntax_Syntax.effect_name in
                                                      let trivial =
                                                        let uu____7185 =
                                                          FStar_All.pipe_right
                                                            md_pure_or_ghost
                                                            FStar_Syntax_Util.get_wp_trivial_combinator in
                                                        FStar_All.pipe_right
                                                          uu____7185
                                                          FStar_Util.must in
                                                      let vc1 =
                                                        let uu____7193 =
                                                          FStar_TypeChecker_Env.inst_effect_fun_with
                                                            [u1] env
                                                            md_pure_or_ghost
                                                            trivial in
                                                        let uu____7194 =
                                                          let uu____7195 =
                                                            FStar_Syntax_Syntax.as_arg
                                                              t1 in
                                                          let uu____7204 =
                                                            let uu____7215 =
                                                              FStar_Syntax_Syntax.as_arg
                                                                wp1 in
                                                            [uu____7215] in
                                                          uu____7195 ::
                                                            uu____7204 in
                                                        FStar_Syntax_Syntax.mk_Tm_app
                                                          uu____7193
                                                          uu____7194 r1 in
                                                      let uu____7248 =
                                                        strengthen_comp env
                                                          FStar_Pervasives_Native.None
                                                          c23 vc1 bind_flags in
                                                      (match uu____7248 with
                                                       | (c, g_s) ->
                                                           let uu____7263 =
                                                             FStar_TypeChecker_Env.conj_guards
                                                               [g_c1;
                                                               g_c2;
                                                               g2;
                                                               g_s] in
                                                           (c, uu____7263)))) in
                                      let uu____7264 =
                                        let t =
                                          FStar_Syntax_Util.comp_result c1 in
                                        match comp_univ_opt c1 with
                                        | FStar_Pervasives_Native.None ->
                                            let uu____7280 =
                                              env.FStar_TypeChecker_Env.universe_of
                                                env t in
                                            (uu____7280, t)
                                        | FStar_Pervasives_Native.Some u ->
                                            (u, t) in
                                      match uu____7264 with
                                      | (u_res_t1, res_t1) ->
                                          let uu____7296 =
                                            (FStar_Option.isSome b) &&
                                              (should_return env e1opt lc11) in
                                          if uu____7296
                                          then
                                            let e1 = FStar_Option.get e1opt in
                                            let x = FStar_Option.get b in
                                            let uu____7305 =
                                              FStar_Syntax_Util.is_partial_return
                                                c1 in
                                            (if uu____7305
                                             then
                                               (debug
                                                  (fun uu____7319 ->
                                                     let uu____7320 =
                                                       FStar_TypeChecker_Normalize.term_to_string
                                                         env e1 in
                                                     let uu____7322 =
                                                       FStar_Syntax_Print.bv_to_string
                                                         x in
                                                     FStar_Util.print2
                                                       "(3) bind (case a): Substituting %s for %s"
                                                       uu____7320 uu____7322);
                                                (let c21 =
                                                   FStar_Syntax_Subst.subst_comp
                                                     [FStar_Syntax_Syntax.NT
                                                        (x, e1)] c2 in
                                                 let g =
                                                   let uu____7329 =
                                                     FStar_TypeChecker_Env.map_guard
                                                       g_c2
                                                       (FStar_Syntax_Subst.subst
                                                          [FStar_Syntax_Syntax.NT
                                                             (x, e1)]) in
                                                   FStar_TypeChecker_Env.conj_guard
                                                     g_c1 uu____7329 in
                                                 mk_bind1 c1 b c21 g))
                                             else
                                               (let uu____7334 =
                                                  ((FStar_Options.vcgen_optimize_bind_as_seq
                                                      ())
                                                     &&
                                                     (lcomp_has_trivial_postcondition
                                                        lc11))
                                                    &&
                                                    (let uu____7337 =
                                                       FStar_TypeChecker_Env.try_lookup_lid
                                                         env
                                                         FStar_Parser_Const.with_type_lid in
                                                     FStar_Option.isSome
                                                       uu____7337) in
                                                if uu____7334
                                                then
                                                  let e1' =
                                                    let uu____7362 =
                                                      FStar_Options.vcgen_decorate_with_type
                                                        () in
                                                    if uu____7362
                                                    then
                                                      FStar_Syntax_Util.mk_with_type
                                                        u_res_t1 res_t1 e1
                                                    else e1 in
                                                  (debug
                                                     (fun uu____7374 ->
                                                        let uu____7375 =
                                                          FStar_TypeChecker_Normalize.term_to_string
                                                            env e1' in
                                                        let uu____7377 =
                                                          FStar_Syntax_Print.bv_to_string
                                                            x in
                                                        FStar_Util.print2
                                                          "(3) bind (case b): Substituting %s for %s"
                                                          uu____7375
                                                          uu____7377);
                                                   (let c21 =
                                                      FStar_Syntax_Subst.subst_comp
                                                        [FStar_Syntax_Syntax.NT
                                                           (x, e1')] c2 in
                                                    mk_seq c1 b c21))
                                                else
                                                  (debug
                                                     (fun uu____7392 ->
                                                        let uu____7393 =
                                                          FStar_TypeChecker_Normalize.term_to_string
                                                            env e1 in
                                                        let uu____7395 =
                                                          FStar_Syntax_Print.bv_to_string
                                                            x in
                                                        FStar_Util.print2
                                                          "(3) bind (case c): Adding equality %s = %s"
                                                          uu____7393
                                                          uu____7395);
                                                   (let c21 =
                                                      FStar_Syntax_Subst.subst_comp
                                                        [FStar_Syntax_Syntax.NT
                                                           (x, e1)] c2 in
                                                    let x_eq_e =
                                                      let uu____7402 =
                                                        FStar_Syntax_Syntax.bv_to_name
                                                          x in
                                                      FStar_Syntax_Util.mk_eq2
                                                        u_res_t1 res_t1 e1
                                                        uu____7402 in
                                                    let uu____7403 =
                                                      let uu____7408 =
                                                        let uu____7409 =
                                                          let uu____7410 =
                                                            FStar_Syntax_Syntax.mk_binder
                                                              x in
                                                          [uu____7410] in
                                                        FStar_TypeChecker_Env.push_binders
                                                          env uu____7409 in
                                                      weaken_comp uu____7408
                                                        c21 x_eq_e in
                                                    match uu____7403 with
                                                    | (c22, g_w) ->
                                                        let g =
                                                          let uu____7436 =
                                                            let uu____7437 =
                                                              let uu____7438
                                                                =
                                                                FStar_Syntax_Syntax.mk_binder
                                                                  x in
                                                              [uu____7438] in
                                                            let uu____7457 =
                                                              FStar_TypeChecker_Common.weaken_guard_formula
                                                                g_c2 x_eq_e in
                                                            FStar_TypeChecker_Env.close_guard
                                                              env uu____7437
                                                              uu____7457 in
                                                          FStar_TypeChecker_Env.conj_guard
                                                            g_c1 uu____7436 in
                                                        let uu____7458 =
                                                          mk_bind1 c1 b c22 g in
                                                        (match uu____7458
                                                         with
                                                         | (c, g_bind) ->
                                                             let uu____7469 =
                                                               FStar_TypeChecker_Env.conj_guard
                                                                 g_w g_bind in
                                                             (c, uu____7469))))))
                                          else mk_bind1 c1 b c2 trivial_guard)))))) in
                FStar_TypeChecker_Common.mk_lcomp joined_eff
                  lc21.FStar_TypeChecker_Common.res_typ bind_flags bind_it
let (weaken_guard :
  FStar_TypeChecker_Common.guard_formula ->
    FStar_TypeChecker_Common.guard_formula ->
      FStar_TypeChecker_Common.guard_formula)
  =
  fun g1 ->
    fun g2 ->
      match (g1, g2) with
      | (FStar_TypeChecker_Common.NonTrivial f1,
         FStar_TypeChecker_Common.NonTrivial f2) ->
          let g = FStar_Syntax_Util.mk_imp f1 f2 in
          FStar_TypeChecker_Common.NonTrivial g
      | uu____7486 -> g2
let (maybe_assume_result_eq_pure_term_in_m :
  FStar_TypeChecker_Env.env ->
    FStar_Ident.lident FStar_Pervasives_Native.option ->
      FStar_Syntax_Syntax.term ->
        FStar_TypeChecker_Common.lcomp -> FStar_TypeChecker_Common.lcomp)
  =
  fun env ->
    fun m_opt ->
      fun e ->
        fun lc ->
          let should_return1 =
            (((Prims.op_Negation env.FStar_TypeChecker_Env.lax) &&
                (FStar_TypeChecker_Env.lid_exists env
                   FStar_Parser_Const.effect_GTot_lid))
               && (should_return env (FStar_Pervasives_Native.Some e) lc))
              &&
              (let uu____7519 =
                 FStar_TypeChecker_Common.is_lcomp_partial_return lc in
               Prims.op_Negation uu____7519) in
          let flags =
            if should_return1
            then
              let uu____7527 = FStar_TypeChecker_Common.is_total_lcomp lc in
              (if uu____7527
               then FStar_Syntax_Syntax.RETURN ::
                 (lc.FStar_TypeChecker_Common.cflags)
               else FStar_Syntax_Syntax.PARTIAL_RETURN ::
                 (lc.FStar_TypeChecker_Common.cflags))
            else lc.FStar_TypeChecker_Common.cflags in
          let refine uu____7547 =
            let uu____7548 = FStar_TypeChecker_Common.lcomp_comp lc in
            match uu____7548 with
            | (c, g_c) ->
                let u_t =
                  match comp_univ_opt c with
                  | FStar_Pervasives_Native.Some u_t -> u_t
                  | FStar_Pervasives_Native.None ->
                      env.FStar_TypeChecker_Env.universe_of env
                        (FStar_Syntax_Util.comp_result c) in
                let m =
                  let uu____7564 =
                    FStar_All.pipe_right m_opt FStar_Util.is_none in
                  if uu____7564
                  then FStar_Parser_Const.effect_PURE_lid
                  else
                    (let uu____7572 =
                       let uu____7574 =
                         FStar_All.pipe_right c
                           FStar_Syntax_Util.comp_effect_name in
                       FStar_All.pipe_right uu____7574 (is_pure_effect env) in
                     if uu____7572
                     then FStar_All.pipe_right m_opt FStar_Util.must
                     else FStar_Parser_Const.effect_PURE_lid) in
                let uu____7583 = FStar_Syntax_Util.is_tot_or_gtot_comp c in
                if uu____7583
                then
                  let uu____7592 =
                    return_value env m (FStar_Pervasives_Native.Some u_t)
                      (FStar_Syntax_Util.comp_result c) e in
                  (match uu____7592 with
                   | (retc, g_retc) ->
                       let g_c1 = FStar_TypeChecker_Env.conj_guard g_c g_retc in
                       let uu____7606 =
                         let uu____7608 = FStar_Syntax_Util.is_pure_comp c in
                         Prims.op_Negation uu____7608 in
                       if uu____7606
                       then
                         let retc1 = FStar_Syntax_Util.comp_to_comp_typ retc in
                         let retc2 =
                           let uu___960_7619 = retc1 in
                           {
                             FStar_Syntax_Syntax.comp_univs =
                               (uu___960_7619.FStar_Syntax_Syntax.comp_univs);
                             FStar_Syntax_Syntax.effect_name =
                               FStar_Parser_Const.effect_GHOST_lid;
                             FStar_Syntax_Syntax.result_typ =
                               (uu___960_7619.FStar_Syntax_Syntax.result_typ);
                             FStar_Syntax_Syntax.effect_args =
                               (uu___960_7619.FStar_Syntax_Syntax.effect_args);
                             FStar_Syntax_Syntax.flags = flags
                           } in
                         let uu____7620 = FStar_Syntax_Syntax.mk_Comp retc2 in
                         (uu____7620, g_c1)
                       else
                         (let uu____7627 =
                            FStar_Syntax_Util.comp_set_flags retc flags in
                          (uu____7627, g_c1)))
                else
                  (let c1 = FStar_TypeChecker_Env.unfold_effect_abbrev env c in
                   let t = c1.FStar_Syntax_Syntax.result_typ in
                   let c2 = FStar_Syntax_Syntax.mk_Comp c1 in
                   let x =
                     FStar_Syntax_Syntax.new_bv
                       (FStar_Pervasives_Native.Some
                          (t.FStar_Syntax_Syntax.pos)) t in
                   let xexp = FStar_Syntax_Syntax.bv_to_name x in
                   let env_x = FStar_TypeChecker_Env.push_bv env x in
                   let uu____7642 =
                     return_value env_x m (FStar_Pervasives_Native.Some u_t)
                       t xexp in
                   match uu____7642 with
                   | (ret, g_ret) ->
                       let ret1 =
                         let uu____7656 =
                           FStar_Syntax_Util.comp_set_flags ret
                             [FStar_Syntax_Syntax.PARTIAL_RETURN] in
                         FStar_All.pipe_left
                           FStar_TypeChecker_Common.lcomp_of_comp uu____7656 in
                       let eq = FStar_Syntax_Util.mk_eq2 u_t t xexp e in
                       let eq_ret =
                         weaken_precondition env_x ret1
                           (FStar_TypeChecker_Common.NonTrivial eq) in
                       let uu____7659 =
                         let uu____7664 =
                           let uu____7665 =
                             FStar_TypeChecker_Common.lcomp_of_comp c2 in
                           bind e.FStar_Syntax_Syntax.pos env
                             FStar_Pervasives_Native.None uu____7665
                             ((FStar_Pervasives_Native.Some x), eq_ret) in
                         FStar_TypeChecker_Common.lcomp_comp uu____7664 in
                       (match uu____7659 with
                        | (bind_c, g_bind) ->
                            let uu____7676 =
                              FStar_Syntax_Util.comp_set_flags bind_c flags in
                            let uu____7679 =
                              FStar_TypeChecker_Env.conj_guards
                                [g_c; g_ret; g_bind] in
                            (uu____7676, uu____7679))) in
          if Prims.op_Negation should_return1
          then lc
          else
            FStar_TypeChecker_Common.mk_lcomp
              lc.FStar_TypeChecker_Common.eff_name
              lc.FStar_TypeChecker_Common.res_typ flags refine
let (maybe_assume_result_eq_pure_term :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_TypeChecker_Common.lcomp -> FStar_TypeChecker_Common.lcomp)
  =
  fun env ->
    fun e ->
      fun lc ->
        maybe_assume_result_eq_pure_term_in_m env
          FStar_Pervasives_Native.None e lc
let (maybe_return_e2_and_bind :
  FStar_Range.range ->
    FStar_TypeChecker_Env.env ->
      FStar_Syntax_Syntax.term FStar_Pervasives_Native.option ->
        FStar_TypeChecker_Common.lcomp ->
          FStar_Syntax_Syntax.term ->
            lcomp_with_binder -> FStar_TypeChecker_Common.lcomp)
  =
  fun r ->
    fun env ->
      fun e1opt ->
        fun lc1 ->
          fun e2 ->
            fun uu____7733 ->
              match uu____7733 with
              | (x, lc2) ->
                  let lc21 =
                    let eff1 =
                      FStar_TypeChecker_Env.norm_eff_name env
                        lc1.FStar_TypeChecker_Common.eff_name in
                    let eff2 =
                      FStar_TypeChecker_Env.norm_eff_name env
                        lc2.FStar_TypeChecker_Common.eff_name in
                    let uu____7745 =
                      ((let uu____7749 = is_pure_or_ghost_effect env eff1 in
                        Prims.op_Negation uu____7749) ||
                         (should_not_inline_lc lc1))
                        && (is_pure_or_ghost_effect env eff2) in
                    if uu____7745
                    then
                      let env_x =
                        match x with
                        | FStar_Pervasives_Native.None -> env
                        | FStar_Pervasives_Native.Some x1 ->
                            FStar_TypeChecker_Env.push_bv env x1 in
                      let uu____7754 =
                        FStar_All.pipe_right eff1
                          (fun uu____7759 ->
                             FStar_Pervasives_Native.Some uu____7759) in
                      maybe_assume_result_eq_pure_term_in_m env_x uu____7754
                        e2 lc2
                    else lc2 in
                  bind r env e1opt lc1 (x, lc21)
let (fvar_const :
  FStar_TypeChecker_Env.env -> FStar_Ident.lident -> FStar_Syntax_Syntax.term)
  =
  fun env ->
    fun lid ->
      let uu____7775 =
        let uu____7776 = FStar_TypeChecker_Env.get_range env in
        FStar_Ident.set_lid_range lid uu____7776 in
      FStar_Syntax_Syntax.fvar uu____7775 FStar_Syntax_Syntax.delta_constant
        FStar_Pervasives_Native.None
let (mk_layered_conjunction :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.eff_decl ->
      FStar_Syntax_Syntax.universe ->
        FStar_Syntax_Syntax.term ->
          FStar_Syntax_Syntax.typ ->
            FStar_Syntax_Syntax.comp_typ ->
              FStar_Syntax_Syntax.comp_typ ->
                FStar_Range.range ->
                  (FStar_Syntax_Syntax.comp *
                    FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun ed ->
      fun u_a ->
        fun a ->
          fun p ->
            fun ct1 ->
              fun ct2 ->
                fun r ->
                  let uu____7826 =
                    let uu____7831 =
                      let uu____7832 =
                        FStar_All.pipe_right ed
                          FStar_Syntax_Util.get_layered_if_then_else_combinator in
                      FStar_All.pipe_right uu____7832 FStar_Util.must in
                    FStar_TypeChecker_Env.inst_tscheme_with uu____7831 [u_a] in
                  match uu____7826 with
                  | (uu____7843, conjunction) ->
                      let uu____7845 =
                        let uu____7854 =
                          FStar_List.map FStar_Pervasives_Native.fst
                            ct1.FStar_Syntax_Syntax.effect_args in
                        let uu____7869 =
                          FStar_List.map FStar_Pervasives_Native.fst
                            ct2.FStar_Syntax_Syntax.effect_args in
                        (uu____7854, uu____7869) in
                      (match uu____7845 with
                       | (is1, is2) ->
                           let conjunction_t_error s =
                             let uu____7915 =
                               let uu____7917 =
                                 FStar_Syntax_Print.term_to_string
                                   conjunction in
                               FStar_Util.format2
                                 "conjunction %s does not have proper shape (reason:%s)"
                                 uu____7917 s in
                             (FStar_Errors.Fatal_UnexpectedEffect,
                               uu____7915) in
                           let uu____7921 =
                             let uu____7966 =
                               let uu____7967 =
                                 FStar_Syntax_Subst.compress conjunction in
                               uu____7967.FStar_Syntax_Syntax.n in
                             match uu____7966 with
                             | FStar_Syntax_Syntax.Tm_abs
                                 (bs, body, uu____8016) when
                                 (FStar_List.length bs) >= (Prims.of_int (4))
                                 ->
                                 let uu____8048 =
                                   FStar_Syntax_Subst.open_term bs body in
                                 (match uu____8048 with
                                  | (a_b::bs1, body1) ->
                                      let uu____8120 =
                                        FStar_List.splitAt
                                          ((FStar_List.length bs1) -
                                             (Prims.of_int (3))) bs1 in
                                      (match uu____8120 with
                                       | (rest_bs, f_b::g_b::p_b::[]) ->
                                           let uu____8268 =
                                             FStar_All.pipe_right body1
                                               FStar_Syntax_Util.unascribe in
                                           (a_b, rest_bs, f_b, g_b, p_b,
                                             uu____8268)))
                             | uu____8301 ->
                                 let uu____8302 =
                                   conjunction_t_error
                                     "Either not an abstraction or not enough binders" in
                                 FStar_Errors.raise_error uu____8302 r in
                           (match uu____7921 with
                            | (a_b, rest_bs, f_b, g_b, p_b, body) ->
                                let uu____8427 =
                                  let uu____8434 =
                                    let uu____8435 =
                                      let uu____8436 =
                                        let uu____8443 =
                                          FStar_All.pipe_right a_b
                                            FStar_Pervasives_Native.fst in
                                        (uu____8443, a) in
                                      FStar_Syntax_Syntax.NT uu____8436 in
                                    [uu____8435] in
                                  FStar_TypeChecker_Env.uvars_for_binders env
                                    rest_bs uu____8434
                                    (fun b ->
                                       let uu____8459 =
                                         FStar_Syntax_Print.binder_to_string
                                           b in
                                       let uu____8461 =
                                         FStar_Ident.string_of_lid
                                           ed.FStar_Syntax_Syntax.mname in
                                       let uu____8463 =
                                         FStar_All.pipe_right r
                                           FStar_Range.string_of_range in
                                       FStar_Util.format3
                                         "implicit var for binder %s of %s:conjunction at %s"
                                         uu____8459 uu____8461 uu____8463) r in
                                (match uu____8427 with
                                 | (rest_bs_uvars, g_uvars) ->
                                     let substs =
                                       FStar_List.map2
                                         (fun b ->
                                            fun t ->
                                              let uu____8501 =
                                                let uu____8508 =
                                                  FStar_All.pipe_right b
                                                    FStar_Pervasives_Native.fst in
                                                (uu____8508, t) in
                                              FStar_Syntax_Syntax.NT
                                                uu____8501) (a_b ::
                                         (FStar_List.append rest_bs [p_b]))
                                         (a ::
                                         (FStar_List.append rest_bs_uvars [p])) in
                                     let f_guard =
                                       let f_sort_is =
                                         let uu____8547 =
                                           let uu____8548 =
                                             let uu____8551 =
                                               let uu____8552 =
                                                 FStar_All.pipe_right f_b
                                                   FStar_Pervasives_Native.fst in
                                               uu____8552.FStar_Syntax_Syntax.sort in
                                             FStar_Syntax_Subst.compress
                                               uu____8551 in
                                           uu____8548.FStar_Syntax_Syntax.n in
                                         match uu____8547 with
                                         | FStar_Syntax_Syntax.Tm_app
                                             (uu____8563, uu____8564::is) ->
                                             let uu____8606 =
                                               FStar_All.pipe_right is
                                                 (FStar_List.map
                                                    FStar_Pervasives_Native.fst) in
                                             FStar_All.pipe_right uu____8606
                                               (FStar_List.map
                                                  (FStar_Syntax_Subst.subst
                                                     substs))
                                         | uu____8639 ->
                                             let uu____8640 =
                                               conjunction_t_error
                                                 "f's type is not a repr type" in
                                             FStar_Errors.raise_error
                                               uu____8640 r in
                                       FStar_List.fold_left2
                                         (fun g ->
                                            fun i1 ->
                                              fun f_i ->
                                                let uu____8656 =
                                                  FStar_TypeChecker_Rel.teq
                                                    env i1 f_i in
                                                FStar_TypeChecker_Env.conj_guard
                                                  g uu____8656)
                                         FStar_TypeChecker_Env.trivial_guard
                                         is1 f_sort_is in
                                     let g_guard =
                                       let g_sort_is =
                                         let uu____8661 =
                                           let uu____8662 =
                                             let uu____8665 =
                                               let uu____8666 =
                                                 FStar_All.pipe_right g_b
                                                   FStar_Pervasives_Native.fst in
                                               uu____8666.FStar_Syntax_Syntax.sort in
                                             FStar_Syntax_Subst.compress
                                               uu____8665 in
                                           uu____8662.FStar_Syntax_Syntax.n in
                                         match uu____8661 with
                                         | FStar_Syntax_Syntax.Tm_app
                                             (uu____8677, uu____8678::is) ->
                                             let uu____8720 =
                                               FStar_All.pipe_right is
                                                 (FStar_List.map
                                                    FStar_Pervasives_Native.fst) in
                                             FStar_All.pipe_right uu____8720
                                               (FStar_List.map
                                                  (FStar_Syntax_Subst.subst
                                                     substs))
                                         | uu____8753 ->
                                             let uu____8754 =
                                               conjunction_t_error
                                                 "g's type is not a repr type" in
                                             FStar_Errors.raise_error
                                               uu____8754 r in
                                       FStar_List.fold_left2
                                         (fun g ->
                                            fun i2 ->
                                              fun g_i ->
                                                let uu____8770 =
                                                  FStar_TypeChecker_Rel.teq
                                                    env i2 g_i in
                                                FStar_TypeChecker_Env.conj_guard
                                                  g uu____8770)
                                         FStar_TypeChecker_Env.trivial_guard
                                         is2 g_sort_is in
                                     let body1 =
                                       FStar_Syntax_Subst.subst substs body in
                                     let is =
                                       let uu____8775 =
                                         let uu____8776 =
                                           FStar_Syntax_Subst.compress body1 in
                                         uu____8776.FStar_Syntax_Syntax.n in
                                       match uu____8775 with
                                       | FStar_Syntax_Syntax.Tm_app
                                           (uu____8781, a1::args) ->
                                           FStar_List.map
                                             FStar_Pervasives_Native.fst args
                                       | uu____8836 ->
                                           let uu____8837 =
                                             conjunction_t_error
                                               "body is not a repr type" in
                                           FStar_Errors.raise_error
                                             uu____8837 r in
                                     let uu____8846 =
                                       let uu____8847 =
                                         let uu____8848 =
                                           FStar_All.pipe_right is
                                             (FStar_List.map
                                                FStar_Syntax_Syntax.as_arg) in
                                         {
                                           FStar_Syntax_Syntax.comp_univs =
                                             [u_a];
                                           FStar_Syntax_Syntax.effect_name =
                                             (ed.FStar_Syntax_Syntax.mname);
                                           FStar_Syntax_Syntax.result_typ = a;
                                           FStar_Syntax_Syntax.effect_args =
                                             uu____8848;
                                           FStar_Syntax_Syntax.flags = []
                                         } in
                                       FStar_Syntax_Syntax.mk_Comp uu____8847 in
                                     let uu____8871 =
                                       let uu____8872 =
                                         FStar_TypeChecker_Env.conj_guard
                                           g_uvars f_guard in
                                       FStar_TypeChecker_Env.conj_guard
                                         uu____8872 g_guard in
                                     (uu____8846, uu____8871))))
let (mk_non_layered_conjunction :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.eff_decl ->
      FStar_Syntax_Syntax.universe ->
        FStar_Syntax_Syntax.term ->
          FStar_Syntax_Syntax.typ ->
            FStar_Syntax_Syntax.comp_typ ->
              FStar_Syntax_Syntax.comp_typ ->
                FStar_Range.range ->
                  (FStar_Syntax_Syntax.comp *
                    FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun ed ->
      fun u_a ->
        fun a ->
          fun p ->
            fun ct1 ->
              fun ct2 ->
                fun uu____8917 ->
                  let if_then_else =
                    let uu____8923 =
                      FStar_All.pipe_right ed
                        FStar_Syntax_Util.get_wp_if_then_else_combinator in
                    FStar_All.pipe_right uu____8923 FStar_Util.must in
                  let uu____8930 = destruct_wp_comp ct1 in
                  match uu____8930 with
                  | (uu____8941, uu____8942, wp_t) ->
                      let uu____8944 = destruct_wp_comp ct2 in
                      (match uu____8944 with
                       | (uu____8955, uu____8956, wp_e) ->
                           let wp =
                             let uu____8959 =
                               FStar_TypeChecker_Env.inst_effect_fun_with
                                 [u_a] env ed if_then_else in
                             let uu____8960 =
                               let uu____8961 = FStar_Syntax_Syntax.as_arg a in
                               let uu____8970 =
                                 let uu____8981 =
                                   FStar_Syntax_Syntax.as_arg p in
                                 let uu____8990 =
                                   let uu____9001 =
                                     FStar_Syntax_Syntax.as_arg wp_t in
                                   let uu____9010 =
                                     let uu____9021 =
                                       FStar_Syntax_Syntax.as_arg wp_e in
                                     [uu____9021] in
                                   uu____9001 :: uu____9010 in
                                 uu____8981 :: uu____8990 in
                               uu____8961 :: uu____8970 in
                             let uu____9070 =
                               FStar_Range.union_ranges
                                 wp_t.FStar_Syntax_Syntax.pos
                                 wp_e.FStar_Syntax_Syntax.pos in
                             FStar_Syntax_Syntax.mk_Tm_app uu____8959
                               uu____8960 uu____9070 in
                           let uu____9071 = mk_comp ed u_a a wp [] in
                           (uu____9071, FStar_TypeChecker_Env.trivial_guard))
let (comp_pure_wp_false :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.universe ->
      FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.comp)
  =
  fun env ->
    fun u ->
      fun t ->
        let post_k =
          let uu____9091 =
            let uu____9100 = FStar_Syntax_Syntax.null_binder t in
            [uu____9100] in
          let uu____9119 =
            FStar_Syntax_Syntax.mk_Total FStar_Syntax_Util.ktype0 in
          FStar_Syntax_Util.arrow uu____9091 uu____9119 in
        let kwp =
          let uu____9125 =
            let uu____9134 = FStar_Syntax_Syntax.null_binder post_k in
            [uu____9134] in
          let uu____9153 =
            FStar_Syntax_Syntax.mk_Total FStar_Syntax_Util.ktype0 in
          FStar_Syntax_Util.arrow uu____9125 uu____9153 in
        let post =
          FStar_Syntax_Syntax.new_bv FStar_Pervasives_Native.None post_k in
        let wp =
          let uu____9160 =
            let uu____9161 = FStar_Syntax_Syntax.mk_binder post in
            [uu____9161] in
          let uu____9180 = fvar_const env FStar_Parser_Const.false_lid in
          FStar_Syntax_Util.abs uu____9160 uu____9180
            (FStar_Pervasives_Native.Some
               (FStar_Syntax_Util.mk_residual_comp
                  FStar_Parser_Const.effect_Tot_lid
                  FStar_Pervasives_Native.None [FStar_Syntax_Syntax.TOTAL])) in
        let md =
          FStar_TypeChecker_Env.get_effect_decl env
            FStar_Parser_Const.effect_PURE_lid in
        mk_comp md u t wp []
let (bind_cases :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.typ ->
      (FStar_Syntax_Syntax.typ * FStar_Ident.lident *
        FStar_Syntax_Syntax.cflag Prims.list *
        (Prims.bool -> FStar_TypeChecker_Common.lcomp)) Prims.list ->
        FStar_Syntax_Syntax.bv -> FStar_TypeChecker_Common.lcomp)
  =
  fun env0 ->
    fun res_t ->
      fun lcases ->
        fun scrutinee ->
          let env =
            let uu____9239 =
              let uu____9240 =
                FStar_All.pipe_right scrutinee FStar_Syntax_Syntax.mk_binder in
              [uu____9240] in
            FStar_TypeChecker_Env.push_binders env0 uu____9239 in
          let eff =
            FStar_List.fold_left
              (fun eff ->
                 fun uu____9287 ->
                   match uu____9287 with
                   | (uu____9301, eff_label, uu____9303, uu____9304) ->
                       join_effects env eff eff_label)
              FStar_Parser_Const.effect_PURE_lid lcases in
          let uu____9317 =
            let uu____9325 =
              FStar_All.pipe_right lcases
                (FStar_Util.for_some
                   (fun uu____9363 ->
                      match uu____9363 with
                      | (uu____9378, uu____9379, flags, uu____9381) ->
                          FStar_All.pipe_right flags
                            (FStar_Util.for_some
                               (fun uu___5_9398 ->
                                  match uu___5_9398 with
                                  | FStar_Syntax_Syntax.SHOULD_NOT_INLINE ->
                                      true
                                  | uu____9401 -> false)))) in
            if uu____9325
            then (true, [FStar_Syntax_Syntax.SHOULD_NOT_INLINE])
            else (false, []) in
          match uu____9317 with
          | (should_not_inline_whole_match, bind_cases_flags) ->
              let bind_cases uu____9438 =
                let u_res_t = env.FStar_TypeChecker_Env.universe_of env res_t in
                let uu____9440 =
                  env.FStar_TypeChecker_Env.lax && (FStar_Options.ml_ish ()) in
                if uu____9440
                then
                  let uu____9447 = lax_mk_tot_or_comp_l eff u_res_t res_t [] in
                  (uu____9447, FStar_TypeChecker_Env.trivial_guard)
                else
                  (let maybe_return eff_label_then cthen =
                     let uu____9468 =
                       should_not_inline_whole_match ||
                         (let uu____9471 = is_pure_or_ghost_effect env eff in
                          Prims.op_Negation uu____9471) in
                     if uu____9468 then cthen true else cthen false in
                   let uu____9478 =
                     let uu____9489 =
                       let uu____9502 =
                         let uu____9507 =
                           let uu____9518 =
                             FStar_All.pipe_right lcases
                               (FStar_List.map
                                  (fun uu____9568 ->
                                     match uu____9568 with
                                     | (g, uu____9587, uu____9588,
                                        uu____9589) -> g)) in
                           FStar_All.pipe_right uu____9518
                             (FStar_List.fold_left
                                (fun uu____9637 ->
                                   fun g ->
                                     match uu____9637 with
                                     | (conds, acc) ->
                                         let cond =
                                           let uu____9678 =
                                             FStar_Syntax_Util.mk_neg g in
                                           FStar_Syntax_Util.mk_conj acc
                                             uu____9678 in
                                         ((FStar_List.append conds [cond]),
                                           cond))
                                ([FStar_Syntax_Util.t_true],
                                  FStar_Syntax_Util.t_true)) in
                         FStar_All.pipe_right uu____9507
                           FStar_Pervasives_Native.fst in
                       FStar_All.pipe_right uu____9502
                         (fun l ->
                            FStar_List.splitAt
                              ((FStar_List.length l) - Prims.int_one) l) in
                     FStar_All.pipe_right uu____9489
                       (fun uu____9776 ->
                          match uu____9776 with
                          | (l1, l2) ->
                              let uu____9817 = FStar_List.hd l2 in
                              (l1, uu____9817)) in
                   match uu____9478 with
                   | (neg_branch_conds, exhaustiveness_branch_cond) ->
                       let uu____9846 =
                         match lcases with
                         | [] ->
                             let uu____9877 =
                               comp_pure_wp_false env u_res_t res_t in
                             (FStar_Pervasives_Native.None, uu____9877,
                               FStar_TypeChecker_Env.trivial_guard)
                         | uu____9880 ->
                             let uu____9897 =
                               let uu____9930 =
                                 let uu____9941 =
                                   FStar_All.pipe_right neg_branch_conds
                                     (FStar_List.splitAt
                                        ((FStar_List.length lcases) -
                                           Prims.int_one)) in
                                 FStar_All.pipe_right uu____9941
                                   (fun uu____10013 ->
                                      match uu____10013 with
                                      | (l1, l2) ->
                                          let uu____10054 = FStar_List.hd l2 in
                                          (l1, uu____10054)) in
                               match uu____9930 with
                               | (neg_branch_conds1, neg_last) ->
                                   let uu____10111 =
                                     let uu____10150 =
                                       FStar_All.pipe_right lcases
                                         (FStar_List.splitAt
                                            ((FStar_List.length lcases) -
                                               Prims.int_one)) in
                                     FStar_All.pipe_right uu____10150
                                       (fun uu____10362 ->
                                          match uu____10362 with
                                          | (l1, l2) ->
                                              let uu____10513 =
                                                FStar_List.hd l2 in
                                              (l1, uu____10513)) in
                                   (match uu____10111 with
                                    | (lcases1,
                                       (g_last, eff_last, uu____10615,
                                        c_last)) ->
                                        let uu____10685 =
                                          let lc =
                                            maybe_return eff_last c_last in
                                          let uu____10691 =
                                            FStar_TypeChecker_Common.lcomp_comp
                                              lc in
                                          match uu____10691 with
                                          | (c, g) ->
                                              let uu____10702 =
                                                let uu____10703 =
                                                  FStar_Syntax_Util.mk_conj
                                                    g_last neg_last in
                                                FStar_TypeChecker_Common.weaken_guard_formula
                                                  g uu____10703 in
                                              (c, uu____10702) in
                                        (match uu____10685 with
                                         | (c, g) ->
                                             let uu____10738 =
                                               let uu____10739 =
                                                 FStar_All.pipe_right
                                                   eff_last
                                                   (FStar_TypeChecker_Env.norm_eff_name
                                                      env) in
                                               FStar_All.pipe_right
                                                 uu____10739
                                                 (FStar_TypeChecker_Env.get_effect_decl
                                                    env) in
                                             (lcases1, neg_branch_conds1,
                                               uu____10738, c, g))) in
                             (match uu____9897 with
                              | (lcases1, neg_branch_conds1, md, comp,
                                 g_comp) ->
                                  FStar_List.fold_right2
                                    (fun uu____10871 ->
                                       fun neg_cond ->
                                         fun uu____10873 ->
                                           match (uu____10871, uu____10873)
                                           with
                                           | ((g, eff_label, uu____10933,
                                               cthen),
                                              (uu____10935, celse, g_comp1))
                                               ->
                                               let uu____10982 =
                                                 let uu____10987 =
                                                   maybe_return eff_label
                                                     cthen in
                                                 FStar_TypeChecker_Common.lcomp_comp
                                                   uu____10987 in
                                               (match uu____10982 with
                                                | (cthen1, g_then) ->
                                                    let uu____10998 =
                                                      let uu____11009 =
                                                        lift_comps_sep_guards
                                                          env cthen1 celse
                                                          FStar_Pervasives_Native.None
                                                          false in
                                                      match uu____11009 with
                                                      | (m, cthen2, celse1,
                                                         g_lift_then,
                                                         g_lift_else) ->
                                                          let md1 =
                                                            FStar_TypeChecker_Env.get_effect_decl
                                                              env m in
                                                          let uu____11037 =
                                                            FStar_All.pipe_right
                                                              cthen2
                                                              FStar_Syntax_Util.comp_to_comp_typ in
                                                          let uu____11038 =
                                                            FStar_All.pipe_right
                                                              celse1
                                                              FStar_Syntax_Util.comp_to_comp_typ in
                                                          (md1, uu____11037,
                                                            uu____11038,
                                                            g_lift_then,
                                                            g_lift_else) in
                                                    (match uu____10998 with
                                                     | (md1, ct_then,
                                                        ct_else, g_lift_then,
                                                        g_lift_else) ->
                                                         let fn =
                                                           let uu____11089 =
                                                             FStar_All.pipe_right
                                                               md1
                                                               FStar_Syntax_Util.is_layered in
                                                           if uu____11089
                                                           then
                                                             mk_layered_conjunction
                                                           else
                                                             mk_non_layered_conjunction in
                                                         let uu____11123 =
                                                           let uu____11128 =
                                                             FStar_TypeChecker_Env.get_range
                                                               env in
                                                           fn env md1 u_res_t
                                                             res_t g ct_then
                                                             ct_else
                                                             uu____11128 in
                                                         (match uu____11123
                                                          with
                                                          | (c,
                                                             g_conjunction)
                                                              ->
                                                              let g_then1 =
                                                                let uu____11140
                                                                  =
                                                                  FStar_TypeChecker_Env.conj_guard
                                                                    g_then
                                                                    g_lift_then in
                                                                let uu____11141
                                                                  =
                                                                  FStar_Syntax_Util.mk_conj
                                                                    neg_cond
                                                                    g in
                                                                FStar_TypeChecker_Common.weaken_guard_formula
                                                                  uu____11140
                                                                  uu____11141 in
                                                              let g_else =
                                                                let uu____11143
                                                                  =
                                                                  let uu____11144
                                                                    =
                                                                    FStar_Syntax_Util.mk_neg
                                                                    g in
                                                                  FStar_Syntax_Util.mk_conj
                                                                    neg_cond
                                                                    uu____11144 in
                                                                FStar_TypeChecker_Common.weaken_guard_formula
                                                                  g_lift_else
                                                                  uu____11143 in
                                                              let uu____11147
                                                                =
                                                                FStar_TypeChecker_Env.conj_guards
                                                                  [g_comp1;
                                                                  g_then1;
                                                                  g_else;
                                                                  g_conjunction] in
                                                              ((FStar_Pervasives_Native.Some
                                                                  md1), c,
                                                                uu____11147)))))
                                    lcases1 neg_branch_conds1
                                    ((FStar_Pervasives_Native.Some md), comp,
                                      g_comp)) in
                       (match uu____9846 with
                        | (md, comp, g_comp) ->
                            let uu____11163 =
                              let uu____11168 =
                                let check =
                                  FStar_Syntax_Util.mk_imp
                                    exhaustiveness_branch_cond
                                    FStar_Syntax_Util.t_false in
                                let check1 =
                                  let uu____11175 =
                                    FStar_TypeChecker_Env.get_range env in
                                  label
                                    FStar_TypeChecker_Err.exhaustiveness_check
                                    uu____11175 check in
                                strengthen_comp env
                                  FStar_Pervasives_Native.None comp check1
                                  bind_cases_flags in
                              match uu____11168 with
                              | (c, g) ->
                                  let uu____11186 =
                                    FStar_TypeChecker_Env.conj_guard g_comp g in
                                  (c, uu____11186) in
                            (match uu____11163 with
                             | (comp1, g_comp1) ->
                                 let g_comp2 =
                                   let uu____11194 =
                                     let uu____11195 =
                                       FStar_All.pipe_right scrutinee
                                         FStar_Syntax_Syntax.mk_binder in
                                     [uu____11195] in
                                   FStar_TypeChecker_Env.close_guard env0
                                     uu____11194 g_comp1 in
                                 (match lcases with
                                  | [] -> (comp1, g_comp2)
                                  | uu____11238::[] -> (comp1, g_comp2)
                                  | uu____11281 ->
                                      let uu____11298 =
                                        let uu____11300 =
                                          FStar_All.pipe_right md
                                            FStar_Util.must in
                                        FStar_All.pipe_right uu____11300
                                          FStar_Syntax_Util.is_layered in
                                      if uu____11298
                                      then (comp1, g_comp2)
                                      else
                                        (let comp2 =
                                           FStar_TypeChecker_Env.comp_to_comp_typ
                                             env comp1 in
                                         let md1 =
                                           FStar_TypeChecker_Env.get_effect_decl
                                             env
                                             comp2.FStar_Syntax_Syntax.effect_name in
                                         let uu____11313 =
                                           destruct_wp_comp comp2 in
                                         match uu____11313 with
                                         | (uu____11324, uu____11325, wp) ->
                                             let ite_wp =
                                               let uu____11328 =
                                                 FStar_All.pipe_right md1
                                                   FStar_Syntax_Util.get_wp_ite_combinator in
                                               FStar_All.pipe_right
                                                 uu____11328 FStar_Util.must in
                                             let wp1 =
                                               let uu____11336 =
                                                 FStar_TypeChecker_Env.inst_effect_fun_with
                                                   [u_res_t] env md1 ite_wp in
                                               let uu____11337 =
                                                 let uu____11338 =
                                                   FStar_Syntax_Syntax.as_arg
                                                     res_t in
                                                 let uu____11347 =
                                                   let uu____11358 =
                                                     FStar_Syntax_Syntax.as_arg
                                                       wp in
                                                   [uu____11358] in
                                                 uu____11338 :: uu____11347 in
                                               FStar_Syntax_Syntax.mk_Tm_app
                                                 uu____11336 uu____11337
                                                 wp.FStar_Syntax_Syntax.pos in
                                             let uu____11391 =
                                               mk_comp md1 u_res_t res_t wp1
                                                 bind_cases_flags in
                                             (uu____11391, g_comp2)))))) in
              FStar_TypeChecker_Common.mk_lcomp eff res_t bind_cases_flags
                bind_cases
let (check_comp :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.comp ->
        FStar_Syntax_Syntax.comp ->
          (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.comp *
            FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun e ->
      fun c ->
        fun c' ->
          let uu____11426 = FStar_TypeChecker_Rel.sub_comp env c c' in
          match uu____11426 with
          | FStar_Pervasives_Native.None ->
              if env.FStar_TypeChecker_Env.use_eq
              then
                let uu____11442 =
                  FStar_TypeChecker_Err.computed_computation_type_does_not_match_annotation_eq
                    env e c c' in
                let uu____11448 = FStar_TypeChecker_Env.get_range env in
                FStar_Errors.raise_error uu____11442 uu____11448
              else
                (let uu____11457 =
                   FStar_TypeChecker_Err.computed_computation_type_does_not_match_annotation
                     env e c c' in
                 let uu____11463 = FStar_TypeChecker_Env.get_range env in
                 FStar_Errors.raise_error uu____11457 uu____11463)
          | FStar_Pervasives_Native.Some g -> (e, c', g)
let (universe_of_comp :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.universe ->
      FStar_Syntax_Syntax.comp -> FStar_Syntax_Syntax.universe)
  =
  fun env ->
    fun u_res ->
      fun c ->
        let c_lid =
          let uu____11488 =
            FStar_All.pipe_right c FStar_Syntax_Util.comp_effect_name in
          FStar_All.pipe_right uu____11488
            (FStar_TypeChecker_Env.norm_eff_name env) in
        let uu____11491 = FStar_Syntax_Util.is_pure_or_ghost_effect c_lid in
        if uu____11491
        then u_res
        else
          (let is_total =
             let uu____11498 =
               FStar_TypeChecker_Env.lookup_effect_quals env c_lid in
             FStar_All.pipe_right uu____11498
               (FStar_List.existsb
                  (fun q -> q = FStar_Syntax_Syntax.TotalEffect)) in
           if Prims.op_Negation is_total
           then FStar_Syntax_Syntax.U_zero
           else
             (let uu____11509 = FStar_TypeChecker_Env.effect_repr env c u_res in
              match uu____11509 with
              | FStar_Pervasives_Native.None ->
                  let uu____11512 =
                    let uu____11518 =
                      let uu____11520 =
                        FStar_Syntax_Print.lid_to_string c_lid in
                      FStar_Util.format1
                        "Effect %s is marked total but does not have a repr"
                        uu____11520 in
                    (FStar_Errors.Fatal_EffectCannotBeReified, uu____11518) in
                  FStar_Errors.raise_error uu____11512
                    c.FStar_Syntax_Syntax.pos
              | FStar_Pervasives_Native.Some tm ->
                  env.FStar_TypeChecker_Env.universe_of env tm))
let (check_trivial_precondition :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.comp ->
      (FStar_Syntax_Syntax.comp_typ * FStar_Syntax_Syntax.formula *
        FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun c ->
      let ct =
        FStar_All.pipe_right c
          (FStar_TypeChecker_Env.unfold_effect_abbrev env) in
      let md =
        FStar_TypeChecker_Env.get_effect_decl env
          ct.FStar_Syntax_Syntax.effect_name in
      let uu____11544 = destruct_wp_comp ct in
      match uu____11544 with
      | (u_t, t, wp) ->
          let vc =
            let uu____11561 =
              let uu____11562 =
                let uu____11563 =
                  FStar_All.pipe_right md
                    FStar_Syntax_Util.get_wp_trivial_combinator in
                FStar_All.pipe_right uu____11563 FStar_Util.must in
              FStar_TypeChecker_Env.inst_effect_fun_with [u_t] env md
                uu____11562 in
            let uu____11570 =
              let uu____11571 = FStar_Syntax_Syntax.as_arg t in
              let uu____11580 =
                let uu____11591 = FStar_Syntax_Syntax.as_arg wp in
                [uu____11591] in
              uu____11571 :: uu____11580 in
            let uu____11624 = FStar_TypeChecker_Env.get_range env in
            FStar_Syntax_Syntax.mk_Tm_app uu____11561 uu____11570 uu____11624 in
          let uu____11625 =
            FStar_All.pipe_left FStar_TypeChecker_Env.guard_of_guard_formula
              (FStar_TypeChecker_Common.NonTrivial vc) in
          (ct, vc, uu____11625)
let (coerce_with :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_TypeChecker_Common.lcomp ->
        FStar_Syntax_Syntax.typ ->
          FStar_Ident.lident ->
            FStar_Syntax_Syntax.universes ->
              FStar_Syntax_Syntax.args ->
                (FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.comp) ->
                  (FStar_Syntax_Syntax.term * FStar_TypeChecker_Common.lcomp))
  =
  fun env ->
    fun e ->
      fun lc ->
        fun ty ->
          fun f ->
            fun us ->
              fun eargs ->
                fun mkcomp ->
                  let uu____11680 =
                    FStar_TypeChecker_Env.try_lookup_lid env f in
                  match uu____11680 with
                  | FStar_Pervasives_Native.Some uu____11695 ->
                      ((let uu____11713 =
                          FStar_TypeChecker_Env.debug env
                            (FStar_Options.Other "Coercions") in
                        if uu____11713
                        then
                          let uu____11717 = FStar_Ident.string_of_lid f in
                          FStar_Util.print1 "Coercing with %s!\n" uu____11717
                        else ());
                       (let coercion =
                          let uu____11723 =
                            FStar_Ident.set_lid_range f
                              e.FStar_Syntax_Syntax.pos in
                          FStar_Syntax_Syntax.fvar uu____11723
                            (FStar_Syntax_Syntax.Delta_constant_at_level
                               Prims.int_one) FStar_Pervasives_Native.None in
                        let coercion1 =
                          FStar_Syntax_Syntax.mk_Tm_uinst coercion us in
                        let coercion2 =
                          FStar_Syntax_Util.mk_app coercion1 eargs in
                        let lc1 =
                          let uu____11730 =
                            let uu____11731 =
                              let uu____11732 = mkcomp ty in
                              FStar_All.pipe_left
                                FStar_TypeChecker_Common.lcomp_of_comp
                                uu____11732 in
                            (FStar_Pervasives_Native.None, uu____11731) in
                          bind e.FStar_Syntax_Syntax.pos env
                            (FStar_Pervasives_Native.Some e) lc uu____11730 in
                        let e1 =
                          let uu____11736 =
                            let uu____11737 = FStar_Syntax_Syntax.as_arg e in
                            [uu____11737] in
                          FStar_Syntax_Syntax.mk_Tm_app coercion2 uu____11736
                            e.FStar_Syntax_Syntax.pos in
                        (e1, lc1)))
                  | FStar_Pervasives_Native.None ->
                      ((let uu____11771 =
                          let uu____11777 =
                            let uu____11779 = FStar_Ident.string_of_lid f in
                            FStar_Util.format1
                              "Coercion %s was not found in the environment, not coercing."
                              uu____11779 in
                          (FStar_Errors.Warning_CoercionNotFound,
                            uu____11777) in
                        FStar_Errors.log_issue e.FStar_Syntax_Syntax.pos
                          uu____11771);
                       (e, lc))
type isErased =
  | Yes of FStar_Syntax_Syntax.term 
  | Maybe 
  | No 
let (uu___is_Yes : isErased -> Prims.bool) =
  fun projectee ->
    match projectee with | Yes _0 -> true | uu____11798 -> false
let (__proj__Yes__item___0 : isErased -> FStar_Syntax_Syntax.term) =
  fun projectee -> match projectee with | Yes _0 -> _0
let (uu___is_Maybe : isErased -> Prims.bool) =
  fun projectee ->
    match projectee with | Maybe -> true | uu____11816 -> false
let (uu___is_No : isErased -> Prims.bool) =
  fun projectee -> match projectee with | No -> true | uu____11827 -> false
let rec (check_erased :
  FStar_TypeChecker_Env.env -> FStar_Syntax_Syntax.term -> isErased) =
  fun env ->
    fun t ->
      let norm' =
        FStar_TypeChecker_Normalize.normalize
          [FStar_TypeChecker_Env.Beta;
          FStar_TypeChecker_Env.Eager_unfolding;
          FStar_TypeChecker_Env.UnfoldUntil
            FStar_Syntax_Syntax.delta_constant;
          FStar_TypeChecker_Env.Exclude FStar_TypeChecker_Env.Zeta;
          FStar_TypeChecker_Env.Primops;
          FStar_TypeChecker_Env.Weak;
          FStar_TypeChecker_Env.HNF;
          FStar_TypeChecker_Env.Iota] in
      let t1 = norm' env t in
      let t2 = FStar_Syntax_Util.unrefine t1 in
      let uu____11851 = FStar_Syntax_Util.head_and_args t2 in
      match uu____11851 with
      | (h, args) ->
          let h1 = FStar_Syntax_Util.un_uinst h in
          let r =
            let uu____11896 =
              let uu____11911 =
                let uu____11912 = FStar_Syntax_Subst.compress h1 in
                uu____11912.FStar_Syntax_Syntax.n in
              (uu____11911, args) in
            match uu____11896 with
            | (FStar_Syntax_Syntax.Tm_fvar fv,
               (a, FStar_Pervasives_Native.None)::[]) when
                FStar_Syntax_Syntax.fv_eq_lid fv
                  FStar_Parser_Const.erased_lid
                -> Yes a
            | (FStar_Syntax_Syntax.Tm_uvar uu____11959, uu____11960) -> Maybe
            | (FStar_Syntax_Syntax.Tm_unknown, uu____11993) -> Maybe
            | (FStar_Syntax_Syntax.Tm_match (uu____12014, branches),
               uu____12016) ->
                FStar_All.pipe_right branches
                  (FStar_List.fold_left
                     (fun acc ->
                        fun br ->
                          match acc with
                          | Yes uu____12080 -> Maybe
                          | Maybe -> Maybe
                          | No ->
                              let uu____12081 =
                                FStar_Syntax_Subst.open_branch br in
                              (match uu____12081 with
                               | (uu____12082, uu____12083, br_body) ->
                                   let uu____12101 =
                                     let uu____12102 =
                                       let uu____12107 =
                                         let uu____12108 =
                                           let uu____12111 =
                                             FStar_All.pipe_right br_body
                                               FStar_Syntax_Free.names in
                                           FStar_All.pipe_right uu____12111
                                             FStar_Util.set_elements in
                                         FStar_All.pipe_right uu____12108
                                           (FStar_TypeChecker_Env.push_bvs
                                              env) in
                                       check_erased uu____12107 in
                                     FStar_All.pipe_right br_body uu____12102 in
                                   (match uu____12101 with
                                    | No -> No
                                    | uu____12122 -> Maybe))) No)
            | uu____12123 -> No in
          r
let (maybe_coerce_lc :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_TypeChecker_Common.lcomp ->
        FStar_Syntax_Syntax.typ ->
          (FStar_Syntax_Syntax.term * FStar_TypeChecker_Common.lcomp *
            FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun e ->
      fun lc ->
        fun exp_t ->
          let should_coerce =
            (((let uu____12175 = FStar_Options.use_two_phase_tc () in
               Prims.op_Negation uu____12175) ||
                env.FStar_TypeChecker_Env.phase1)
               || env.FStar_TypeChecker_Env.lax)
              || (FStar_Options.lax ()) in
          if Prims.op_Negation should_coerce
          then (e, lc, FStar_TypeChecker_Env.trivial_guard)
          else
            (let is_t_term t =
               let t1 = FStar_TypeChecker_Normalize.unfold_whnf env t in
               let uu____12194 =
                 let uu____12195 = FStar_Syntax_Subst.compress t1 in
                 uu____12195.FStar_Syntax_Syntax.n in
               match uu____12194 with
               | FStar_Syntax_Syntax.Tm_fvar fv ->
                   FStar_Syntax_Syntax.fv_eq_lid fv
                     FStar_Parser_Const.term_lid
               | uu____12200 -> false in
             let is_t_term_view t =
               let t1 = FStar_TypeChecker_Normalize.unfold_whnf env t in
               let uu____12210 =
                 let uu____12211 = FStar_Syntax_Subst.compress t1 in
                 uu____12211.FStar_Syntax_Syntax.n in
               match uu____12210 with
               | FStar_Syntax_Syntax.Tm_fvar fv ->
                   FStar_Syntax_Syntax.fv_eq_lid fv
                     FStar_Parser_Const.term_view_lid
               | uu____12216 -> false in
             let is_type t =
               let t1 = FStar_TypeChecker_Normalize.unfold_whnf env t in
               let t2 = FStar_Syntax_Util.unrefine t1 in
               let uu____12227 =
                 let uu____12228 = FStar_Syntax_Subst.compress t2 in
                 uu____12228.FStar_Syntax_Syntax.n in
               match uu____12227 with
               | FStar_Syntax_Syntax.Tm_type uu____12232 -> true
               | uu____12234 -> false in
             let res_typ =
               FStar_Syntax_Util.unrefine lc.FStar_TypeChecker_Common.res_typ in
             let uu____12237 = FStar_Syntax_Util.head_and_args res_typ in
             match uu____12237 with
             | (head, args) ->
                 ((let uu____12287 =
                     FStar_TypeChecker_Env.debug env
                       (FStar_Options.Other "Coercions") in
                   if uu____12287
                   then
                     let uu____12291 =
                       FStar_Range.string_of_range e.FStar_Syntax_Syntax.pos in
                     let uu____12293 = FStar_Syntax_Print.term_to_string e in
                     let uu____12295 =
                       FStar_Syntax_Print.term_to_string res_typ in
                     let uu____12297 =
                       FStar_Syntax_Print.term_to_string exp_t in
                     FStar_Util.print4
                       "(%s) Trying to coerce %s from type (%s) to type (%s)\n"
                       uu____12291 uu____12293 uu____12295 uu____12297
                   else ());
                  (let mk_erased u t =
                     let uu____12315 =
                       let uu____12318 =
                         fvar_const env FStar_Parser_Const.erased_lid in
                       FStar_Syntax_Syntax.mk_Tm_uinst uu____12318 [u] in
                     let uu____12319 =
                       let uu____12330 = FStar_Syntax_Syntax.as_arg t in
                       [uu____12330] in
                     FStar_Syntax_Util.mk_app uu____12315 uu____12319 in
                   let uu____12355 =
                     let uu____12370 =
                       let uu____12371 = FStar_Syntax_Util.un_uinst head in
                       uu____12371.FStar_Syntax_Syntax.n in
                     (uu____12370, args) in
                   match uu____12355 with
                   | (FStar_Syntax_Syntax.Tm_fvar fv, []) when
                       (FStar_Syntax_Syntax.fv_eq_lid fv
                          FStar_Parser_Const.bool_lid)
                         && (is_type exp_t)
                       ->
                       let uu____12409 =
                         coerce_with env e lc FStar_Syntax_Util.ktype0
                           FStar_Parser_Const.b2t_lid [] []
                           FStar_Syntax_Syntax.mk_Total in
                       (match uu____12409 with
                        | (e1, lc1) ->
                            (e1, lc1, FStar_TypeChecker_Env.trivial_guard))
                   | (FStar_Syntax_Syntax.Tm_fvar fv, []) when
                       (FStar_Syntax_Syntax.fv_eq_lid fv
                          FStar_Parser_Const.term_lid)
                         && (is_t_term_view exp_t)
                       ->
                       let uu____12449 =
                         coerce_with env e lc FStar_Syntax_Syntax.t_term_view
                           FStar_Parser_Const.inspect [] []
                           FStar_Syntax_Syntax.mk_Tac in
                       (match uu____12449 with
                        | (e1, lc1) ->
                            (e1, lc1, FStar_TypeChecker_Env.trivial_guard))
                   | (FStar_Syntax_Syntax.Tm_fvar fv, []) when
                       (FStar_Syntax_Syntax.fv_eq_lid fv
                          FStar_Parser_Const.term_view_lid)
                         && (is_t_term exp_t)
                       ->
                       let uu____12489 =
                         coerce_with env e lc FStar_Syntax_Syntax.t_term
                           FStar_Parser_Const.pack [] []
                           FStar_Syntax_Syntax.mk_Tac in
                       (match uu____12489 with
                        | (e1, lc1) ->
                            (e1, lc1, FStar_TypeChecker_Env.trivial_guard))
                   | (FStar_Syntax_Syntax.Tm_fvar fv, []) when
                       (FStar_Syntax_Syntax.fv_eq_lid fv
                          FStar_Parser_Const.binder_lid)
                         && (is_t_term exp_t)
                       ->
                       let uu____12529 =
                         coerce_with env e lc FStar_Syntax_Syntax.t_term
                           FStar_Parser_Const.binder_to_term [] []
                           FStar_Syntax_Syntax.mk_Tac in
                       (match uu____12529 with
                        | (e1, lc1) ->
                            (e1, lc1, FStar_TypeChecker_Env.trivial_guard))
                   | uu____12550 ->
                       let uu____12565 =
                         let uu____12570 = check_erased env res_typ in
                         let uu____12571 = check_erased env exp_t in
                         (uu____12570, uu____12571) in
                       (match uu____12565 with
                        | (No, Yes ty) ->
                            let u =
                              env.FStar_TypeChecker_Env.universe_of env ty in
                            let uu____12580 =
                              FStar_TypeChecker_Rel.get_subtyping_predicate
                                env res_typ ty in
                            (match uu____12580 with
                             | FStar_Pervasives_Native.None ->
                                 (e, lc, FStar_TypeChecker_Env.trivial_guard)
                             | FStar_Pervasives_Native.Some g ->
                                 let g1 =
                                   FStar_TypeChecker_Env.apply_guard g e in
                                 let uu____12591 =
                                   let uu____12596 =
                                     let uu____12597 =
                                       FStar_Syntax_Syntax.iarg ty in
                                     [uu____12597] in
                                   coerce_with env e lc exp_t
                                     FStar_Parser_Const.hide [u] uu____12596
                                     FStar_Syntax_Syntax.mk_Total in
                                 (match uu____12591 with
                                  | (e1, lc1) -> (e1, lc1, g1)))
                        | (Yes ty, No) ->
                            let u =
                              env.FStar_TypeChecker_Env.universe_of env ty in
                            let uu____12632 =
                              let uu____12637 =
                                let uu____12638 = FStar_Syntax_Syntax.iarg ty in
                                [uu____12638] in
                              coerce_with env e lc ty
                                FStar_Parser_Const.reveal [u] uu____12637
                                FStar_Syntax_Syntax.mk_GTotal in
                            (match uu____12632 with
                             | (e1, lc1) ->
                                 (e1, lc1,
                                   FStar_TypeChecker_Env.trivial_guard))
                        | uu____12671 ->
                            (e, lc, FStar_TypeChecker_Env.trivial_guard)))))
let (coerce_views :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_TypeChecker_Common.lcomp ->
        (FStar_Syntax_Syntax.term * FStar_TypeChecker_Common.lcomp)
          FStar_Pervasives_Native.option)
  =
  fun env ->
    fun e ->
      fun lc ->
        let rt = lc.FStar_TypeChecker_Common.res_typ in
        let rt1 = FStar_Syntax_Util.unrefine rt in
        let uu____12706 = FStar_Syntax_Util.head_and_args rt1 in
        match uu____12706 with
        | (hd, args) ->
            let uu____12755 =
              let uu____12770 =
                let uu____12771 = FStar_Syntax_Subst.compress hd in
                uu____12771.FStar_Syntax_Syntax.n in
              (uu____12770, args) in
            (match uu____12755 with
             | (FStar_Syntax_Syntax.Tm_fvar fv, []) when
                 FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.term_lid
                 ->
                 let uu____12809 =
                   coerce_with env e lc FStar_Syntax_Syntax.t_term_view
                     FStar_Parser_Const.inspect [] []
                     FStar_Syntax_Syntax.mk_Tac in
                 FStar_All.pipe_left
                   (fun uu____12836 ->
                      FStar_Pervasives_Native.Some uu____12836) uu____12809
             | uu____12837 -> FStar_Pervasives_Native.None)
let (weaken_result_typ :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_TypeChecker_Common.lcomp ->
        FStar_Syntax_Syntax.typ ->
          (FStar_Syntax_Syntax.term * FStar_TypeChecker_Common.lcomp *
            FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun e ->
      fun lc ->
        fun t ->
          (let uu____12890 =
             FStar_TypeChecker_Env.debug env FStar_Options.High in
           if uu____12890
           then
             let uu____12893 = FStar_Syntax_Print.term_to_string e in
             let uu____12895 = FStar_TypeChecker_Common.lcomp_to_string lc in
             let uu____12897 = FStar_Syntax_Print.term_to_string t in
             FStar_Util.print3 "weaken_result_typ e=(%s) lc=(%s) t=(%s)\n"
               uu____12893 uu____12895 uu____12897
           else ());
          (let use_eq =
             (env.FStar_TypeChecker_Env.use_eq_strict ||
                env.FStar_TypeChecker_Env.use_eq)
               ||
               (let uu____12907 =
                  FStar_TypeChecker_Env.effect_decl_opt env
                    lc.FStar_TypeChecker_Common.eff_name in
                match uu____12907 with
                | FStar_Pervasives_Native.Some (ed, qualifiers) ->
                    FStar_All.pipe_right qualifiers
                      (FStar_List.contains FStar_Syntax_Syntax.Reifiable)
                | uu____12932 -> false) in
           let gopt =
             if use_eq
             then
               let uu____12958 =
                 FStar_TypeChecker_Rel.try_teq true env
                   lc.FStar_TypeChecker_Common.res_typ t in
               (uu____12958, false)
             else
               (let uu____12968 =
                  FStar_TypeChecker_Rel.get_subtyping_predicate env
                    lc.FStar_TypeChecker_Common.res_typ t in
                (uu____12968, true)) in
           match gopt with
           | (FStar_Pervasives_Native.None, uu____12981) ->
               if env.FStar_TypeChecker_Env.failhard
               then
                 let uu____12993 =
                   FStar_TypeChecker_Err.basic_type_error env
                     (FStar_Pervasives_Native.Some e) t
                     lc.FStar_TypeChecker_Common.res_typ in
                 FStar_Errors.raise_error uu____12993
                   e.FStar_Syntax_Syntax.pos
               else
                 (FStar_TypeChecker_Rel.subtype_fail env e
                    lc.FStar_TypeChecker_Common.res_typ t;
                  (e,
                    ((let uu___1458_13009 = lc in
                      {
                        FStar_TypeChecker_Common.eff_name =
                          (uu___1458_13009.FStar_TypeChecker_Common.eff_name);
                        FStar_TypeChecker_Common.res_typ = t;
                        FStar_TypeChecker_Common.cflags =
                          (uu___1458_13009.FStar_TypeChecker_Common.cflags);
                        FStar_TypeChecker_Common.comp_thunk =
                          (uu___1458_13009.FStar_TypeChecker_Common.comp_thunk)
                      })), FStar_TypeChecker_Env.trivial_guard))
           | (FStar_Pervasives_Native.Some g, apply_guard) ->
               let uu____13016 = FStar_TypeChecker_Env.guard_form g in
               (match uu____13016 with
                | FStar_TypeChecker_Common.Trivial ->
                    let strengthen_trivial uu____13032 =
                      let uu____13033 =
                        FStar_TypeChecker_Common.lcomp_comp lc in
                      match uu____13033 with
                      | (c, g_c) ->
                          let res_t = FStar_Syntax_Util.comp_result c in
                          let set_result_typ c1 =
                            FStar_Syntax_Util.set_result_typ c1 t in
                          let uu____13053 =
                            let uu____13055 = FStar_Syntax_Util.eq_tm t res_t in
                            uu____13055 = FStar_Syntax_Util.Equal in
                          if uu____13053
                          then
                            ((let uu____13062 =
                                FStar_All.pipe_left
                                  (FStar_TypeChecker_Env.debug env)
                                  FStar_Options.Extreme in
                              if uu____13062
                              then
                                let uu____13066 =
                                  FStar_Syntax_Print.term_to_string res_t in
                                let uu____13068 =
                                  FStar_Syntax_Print.term_to_string t in
                                FStar_Util.print2
                                  "weaken_result_type::strengthen_trivial: res_t:%s is same as t:%s\n"
                                  uu____13066 uu____13068
                              else ());
                             (let uu____13073 = set_result_typ c in
                              (uu____13073, g_c)))
                          else
                            (let is_res_t_refinement =
                               let res_t1 =
                                 FStar_TypeChecker_Normalize.normalize_refinement
                                   FStar_TypeChecker_Normalize.whnf_steps env
                                   res_t in
                               match res_t1.FStar_Syntax_Syntax.n with
                               | FStar_Syntax_Syntax.Tm_refine uu____13080 ->
                                   true
                               | uu____13088 -> false in
                             if is_res_t_refinement
                             then
                               let x =
                                 FStar_Syntax_Syntax.new_bv
                                   (FStar_Pervasives_Native.Some
                                      (res_t.FStar_Syntax_Syntax.pos)) res_t in
                               let uu____13096 =
                                 let uu____13101 =
                                   let uu____13102 =
                                     FStar_All.pipe_right c
                                       FStar_Syntax_Util.comp_effect_name in
                                   FStar_All.pipe_right uu____13102
                                     (FStar_TypeChecker_Env.norm_eff_name env) in
                                 let uu____13105 =
                                   FStar_Syntax_Syntax.bv_to_name x in
                                 return_value env uu____13101
                                   (comp_univ_opt c) res_t uu____13105 in
                               match uu____13096 with
                               | (cret, gret) ->
                                   let lc1 =
                                     let uu____13115 =
                                       FStar_TypeChecker_Common.lcomp_of_comp
                                         c in
                                     let uu____13116 =
                                       let uu____13117 =
                                         FStar_TypeChecker_Common.lcomp_of_comp
                                           cret in
                                       ((FStar_Pervasives_Native.Some x),
                                         uu____13117) in
                                     bind e.FStar_Syntax_Syntax.pos env
                                       (FStar_Pervasives_Native.Some e)
                                       uu____13115 uu____13116 in
                                   ((let uu____13121 =
                                       FStar_All.pipe_left
                                         (FStar_TypeChecker_Env.debug env)
                                         FStar_Options.Extreme in
                                     if uu____13121
                                     then
                                       let uu____13125 =
                                         FStar_Syntax_Print.term_to_string e in
                                       let uu____13127 =
                                         FStar_Syntax_Print.comp_to_string c in
                                       let uu____13129 =
                                         FStar_Syntax_Print.term_to_string t in
                                       let uu____13131 =
                                         FStar_TypeChecker_Common.lcomp_to_string
                                           lc1 in
                                       FStar_Util.print4
                                         "weaken_result_type::strengthen_trivial: inserting a return for e: %s, c: %s, t: %s, and then post return lc: %s\n"
                                         uu____13125 uu____13127 uu____13129
                                         uu____13131
                                     else ());
                                    (let uu____13136 =
                                       FStar_TypeChecker_Common.lcomp_comp
                                         lc1 in
                                     match uu____13136 with
                                     | (c1, g_lc) ->
                                         let uu____13147 = set_result_typ c1 in
                                         let uu____13148 =
                                           FStar_TypeChecker_Env.conj_guards
                                             [g_c; gret; g_lc] in
                                         (uu____13147, uu____13148)))
                             else
                               ((let uu____13152 =
                                   FStar_All.pipe_left
                                     (FStar_TypeChecker_Env.debug env)
                                     FStar_Options.Extreme in
                                 if uu____13152
                                 then
                                   let uu____13156 =
                                     FStar_Syntax_Print.term_to_string res_t in
                                   let uu____13158 =
                                     FStar_Syntax_Print.comp_to_string c in
                                   FStar_Util.print2
                                     "weaken_result_type::strengthen_trivial: res_t:%s is not a refinement, leaving c:%s as is\n"
                                     uu____13156 uu____13158
                                 else ());
                                (let uu____13163 = set_result_typ c in
                                 (uu____13163, g_c)))) in
                    let lc1 =
                      FStar_TypeChecker_Common.mk_lcomp
                        lc.FStar_TypeChecker_Common.eff_name t
                        lc.FStar_TypeChecker_Common.cflags strengthen_trivial in
                    (e, lc1, g)
                | FStar_TypeChecker_Common.NonTrivial f ->
                    let g1 =
                      let uu___1497_13167 = g in
                      {
                        FStar_TypeChecker_Common.guard_f =
                          FStar_TypeChecker_Common.Trivial;
                        FStar_TypeChecker_Common.deferred_to_tac =
                          (uu___1497_13167.FStar_TypeChecker_Common.deferred_to_tac);
                        FStar_TypeChecker_Common.deferred =
                          (uu___1497_13167.FStar_TypeChecker_Common.deferred);
                        FStar_TypeChecker_Common.univ_ineqs =
                          (uu___1497_13167.FStar_TypeChecker_Common.univ_ineqs);
                        FStar_TypeChecker_Common.implicits =
                          (uu___1497_13167.FStar_TypeChecker_Common.implicits)
                      } in
                    let strengthen uu____13177 =
                      let uu____13178 =
                        env.FStar_TypeChecker_Env.lax &&
                          (FStar_Options.ml_ish ()) in
                      if uu____13178
                      then FStar_TypeChecker_Common.lcomp_comp lc
                      else
                        (let f1 =
                           FStar_TypeChecker_Normalize.normalize
                             [FStar_TypeChecker_Env.Beta;
                             FStar_TypeChecker_Env.Eager_unfolding;
                             FStar_TypeChecker_Env.Simplify;
                             FStar_TypeChecker_Env.Primops] env f in
                         let uu____13188 =
                           let uu____13189 = FStar_Syntax_Subst.compress f1 in
                           uu____13189.FStar_Syntax_Syntax.n in
                         match uu____13188 with
                         | FStar_Syntax_Syntax.Tm_abs
                             (uu____13196,
                              {
                                FStar_Syntax_Syntax.n =
                                  FStar_Syntax_Syntax.Tm_fvar fv;
                                FStar_Syntax_Syntax.pos = uu____13198;
                                FStar_Syntax_Syntax.vars = uu____13199;_},
                              uu____13200)
                             when
                             FStar_Syntax_Syntax.fv_eq_lid fv
                               FStar_Parser_Const.true_lid
                             ->
                             let lc1 =
                               let uu___1513_13226 = lc in
                               {
                                 FStar_TypeChecker_Common.eff_name =
                                   (uu___1513_13226.FStar_TypeChecker_Common.eff_name);
                                 FStar_TypeChecker_Common.res_typ = t;
                                 FStar_TypeChecker_Common.cflags =
                                   (uu___1513_13226.FStar_TypeChecker_Common.cflags);
                                 FStar_TypeChecker_Common.comp_thunk =
                                   (uu___1513_13226.FStar_TypeChecker_Common.comp_thunk)
                               } in
                             FStar_TypeChecker_Common.lcomp_comp lc1
                         | uu____13227 ->
                             let uu____13228 =
                               FStar_TypeChecker_Common.lcomp_comp lc in
                             (match uu____13228 with
                              | (c, g_c) ->
                                  ((let uu____13240 =
                                      FStar_All.pipe_left
                                        (FStar_TypeChecker_Env.debug env)
                                        FStar_Options.Extreme in
                                    if uu____13240
                                    then
                                      let uu____13244 =
                                        FStar_TypeChecker_Normalize.term_to_string
                                          env
                                          lc.FStar_TypeChecker_Common.res_typ in
                                      let uu____13246 =
                                        FStar_TypeChecker_Normalize.term_to_string
                                          env t in
                                      let uu____13248 =
                                        FStar_TypeChecker_Normalize.comp_to_string
                                          env c in
                                      let uu____13250 =
                                        FStar_TypeChecker_Normalize.term_to_string
                                          env f1 in
                                      FStar_Util.print4
                                        "Weakened from %s to %s\nStrengthening %s with guard %s\n"
                                        uu____13244 uu____13246 uu____13248
                                        uu____13250
                                    else ());
                                   (let u_t_opt = comp_univ_opt c in
                                    let x =
                                      FStar_Syntax_Syntax.new_bv
                                        (FStar_Pervasives_Native.Some
                                           (t.FStar_Syntax_Syntax.pos)) t in
                                    let xexp =
                                      FStar_Syntax_Syntax.bv_to_name x in
                                    let uu____13260 =
                                      let uu____13265 =
                                        let uu____13266 =
                                          FStar_All.pipe_right c
                                            FStar_Syntax_Util.comp_effect_name in
                                        FStar_All.pipe_right uu____13266
                                          (FStar_TypeChecker_Env.norm_eff_name
                                             env) in
                                      return_value env uu____13265 u_t_opt t
                                        xexp in
                                    match uu____13260 with
                                    | (cret, gret) ->
                                        let guard =
                                          if apply_guard
                                          then
                                            let uu____13277 =
                                              let uu____13278 =
                                                FStar_Syntax_Syntax.as_arg
                                                  xexp in
                                              [uu____13278] in
                                            FStar_Syntax_Syntax.mk_Tm_app f1
                                              uu____13277
                                              f1.FStar_Syntax_Syntax.pos
                                          else f1 in
                                        let uu____13305 =
                                          let uu____13310 =
                                            FStar_All.pipe_left
                                              (fun uu____13331 ->
                                                 FStar_Pervasives_Native.Some
                                                   uu____13331)
                                              (FStar_TypeChecker_Err.subtyping_failed
                                                 env
                                                 lc.FStar_TypeChecker_Common.res_typ
                                                 t) in
                                          let uu____13332 =
                                            let uu____13333 =
                                              FStar_TypeChecker_Env.push_bvs
                                                env [x] in
                                            FStar_TypeChecker_Env.set_range
                                              uu____13333
                                              e.FStar_Syntax_Syntax.pos in
                                          let uu____13334 =
                                            FStar_TypeChecker_Common.lcomp_of_comp
                                              cret in
                                          let uu____13335 =
                                            FStar_All.pipe_left
                                              FStar_TypeChecker_Env.guard_of_guard_formula
                                              (FStar_TypeChecker_Common.NonTrivial
                                                 guard) in
                                          strengthen_precondition uu____13310
                                            uu____13332 e uu____13334
                                            uu____13335 in
                                        (match uu____13305 with
                                         | (eq_ret,
                                            _trivial_so_ok_to_discard) ->
                                             let x1 =
                                               let uu___1533_13343 = x in
                                               {
                                                 FStar_Syntax_Syntax.ppname =
                                                   (uu___1533_13343.FStar_Syntax_Syntax.ppname);
                                                 FStar_Syntax_Syntax.index =
                                                   (uu___1533_13343.FStar_Syntax_Syntax.index);
                                                 FStar_Syntax_Syntax.sort =
                                                   (lc.FStar_TypeChecker_Common.res_typ)
                                               } in
                                             let c1 =
                                               let uu____13345 =
                                                 FStar_TypeChecker_Common.lcomp_of_comp
                                                   c in
                                               bind e.FStar_Syntax_Syntax.pos
                                                 env
                                                 (FStar_Pervasives_Native.Some
                                                    e) uu____13345
                                                 ((FStar_Pervasives_Native.Some
                                                     x1), eq_ret) in
                                             let uu____13348 =
                                               FStar_TypeChecker_Common.lcomp_comp
                                                 c1 in
                                             (match uu____13348 with
                                              | (c2, g_lc) ->
                                                  ((let uu____13360 =
                                                      FStar_All.pipe_left
                                                        (FStar_TypeChecker_Env.debug
                                                           env)
                                                        FStar_Options.Extreme in
                                                    if uu____13360
                                                    then
                                                      let uu____13364 =
                                                        FStar_TypeChecker_Normalize.comp_to_string
                                                          env c2 in
                                                      FStar_Util.print1
                                                        "Strengthened to %s\n"
                                                        uu____13364
                                                    else ());
                                                   (let uu____13369 =
                                                      FStar_TypeChecker_Env.conj_guards
                                                        [g_c; gret; g_lc] in
                                                    (c2, uu____13369))))))))) in
                    let flags =
                      FStar_All.pipe_right lc.FStar_TypeChecker_Common.cflags
                        (FStar_List.collect
                           (fun uu___6_13378 ->
                              match uu___6_13378 with
                              | FStar_Syntax_Syntax.RETURN ->
                                  [FStar_Syntax_Syntax.PARTIAL_RETURN]
                              | FStar_Syntax_Syntax.PARTIAL_RETURN ->
                                  [FStar_Syntax_Syntax.PARTIAL_RETURN]
                              | FStar_Syntax_Syntax.CPS ->
                                  [FStar_Syntax_Syntax.CPS]
                              | uu____13381 -> [])) in
                    let lc1 =
                      let uu____13383 =
                        FStar_TypeChecker_Env.norm_eff_name env
                          lc.FStar_TypeChecker_Common.eff_name in
                      FStar_TypeChecker_Common.mk_lcomp uu____13383 t flags
                        strengthen in
                    let g2 =
                      let uu___1549_13385 = g1 in
                      {
                        FStar_TypeChecker_Common.guard_f =
                          FStar_TypeChecker_Common.Trivial;
                        FStar_TypeChecker_Common.deferred_to_tac =
                          (uu___1549_13385.FStar_TypeChecker_Common.deferred_to_tac);
                        FStar_TypeChecker_Common.deferred =
                          (uu___1549_13385.FStar_TypeChecker_Common.deferred);
                        FStar_TypeChecker_Common.univ_ineqs =
                          (uu___1549_13385.FStar_TypeChecker_Common.univ_ineqs);
                        FStar_TypeChecker_Common.implicits =
                          (uu___1549_13385.FStar_TypeChecker_Common.implicits)
                      } in
                    (e, lc1, g2)))
let (pure_or_ghost_pre_and_post :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.comp ->
      (FStar_Syntax_Syntax.typ FStar_Pervasives_Native.option *
        FStar_Syntax_Syntax.typ))
  =
  fun env ->
    fun comp ->
      let mk_post_type res_t ens =
        let x = FStar_Syntax_Syntax.new_bv FStar_Pervasives_Native.None res_t in
        let uu____13421 =
          let uu____13424 =
            let uu____13425 =
              let uu____13434 = FStar_Syntax_Syntax.bv_to_name x in
              FStar_Syntax_Syntax.as_arg uu____13434 in
            [uu____13425] in
          FStar_Syntax_Syntax.mk_Tm_app ens uu____13424
            res_t.FStar_Syntax_Syntax.pos in
        FStar_Syntax_Util.refine x uu____13421 in
      let norm t =
        FStar_TypeChecker_Normalize.normalize
          [FStar_TypeChecker_Env.Beta;
          FStar_TypeChecker_Env.Eager_unfolding;
          FStar_TypeChecker_Env.EraseUniverses] env t in
      let uu____13457 = FStar_Syntax_Util.is_tot_or_gtot_comp comp in
      if uu____13457
      then
        (FStar_Pervasives_Native.None, (FStar_Syntax_Util.comp_result comp))
      else
        (match comp.FStar_Syntax_Syntax.n with
         | FStar_Syntax_Syntax.GTotal uu____13476 -> failwith "Impossible"
         | FStar_Syntax_Syntax.Total uu____13492 -> failwith "Impossible"
         | FStar_Syntax_Syntax.Comp ct ->
             let uu____13509 =
               (FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
                  FStar_Parser_Const.effect_Pure_lid)
                 ||
                 (FStar_Ident.lid_equals ct.FStar_Syntax_Syntax.effect_name
                    FStar_Parser_Const.effect_Ghost_lid) in
             if uu____13509
             then
               (match ct.FStar_Syntax_Syntax.effect_args with
                | (req, uu____13525)::(ens, uu____13527)::uu____13528 ->
                    let uu____13571 =
                      let uu____13574 = norm req in
                      FStar_Pervasives_Native.Some uu____13574 in
                    let uu____13575 =
                      let uu____13576 =
                        mk_post_type ct.FStar_Syntax_Syntax.result_typ ens in
                      FStar_All.pipe_left norm uu____13576 in
                    (uu____13571, uu____13575)
                | uu____13579 ->
                    let uu____13590 =
                      let uu____13596 =
                        let uu____13598 =
                          FStar_Syntax_Print.comp_to_string comp in
                        FStar_Util.format1
                          "Effect constructor is not fully applied; got %s"
                          uu____13598 in
                      (FStar_Errors.Fatal_EffectConstructorNotFullyApplied,
                        uu____13596) in
                    FStar_Errors.raise_error uu____13590
                      comp.FStar_Syntax_Syntax.pos)
             else
               (let ct1 = FStar_TypeChecker_Env.unfold_effect_abbrev env comp in
                match ct1.FStar_Syntax_Syntax.effect_args with
                | (wp, uu____13618)::uu____13619 ->
                    let uu____13646 =
                      let uu____13651 =
                        FStar_TypeChecker_Env.lookup_lid env
                          FStar_Parser_Const.as_requires in
                      FStar_All.pipe_left FStar_Pervasives_Native.fst
                        uu____13651 in
                    (match uu____13646 with
                     | (us_r, uu____13683) ->
                         let uu____13684 =
                           let uu____13689 =
                             FStar_TypeChecker_Env.lookup_lid env
                               FStar_Parser_Const.as_ensures in
                           FStar_All.pipe_left FStar_Pervasives_Native.fst
                             uu____13689 in
                         (match uu____13684 with
                          | (us_e, uu____13721) ->
                              let r =
                                (ct1.FStar_Syntax_Syntax.result_typ).FStar_Syntax_Syntax.pos in
                              let as_req =
                                let uu____13724 =
                                  let uu____13725 =
                                    FStar_Ident.set_lid_range
                                      FStar_Parser_Const.as_requires r in
                                  FStar_Syntax_Syntax.fvar uu____13725
                                    FStar_Syntax_Syntax.delta_equational
                                    FStar_Pervasives_Native.None in
                                FStar_Syntax_Syntax.mk_Tm_uinst uu____13724
                                  us_r in
                              let as_ens =
                                let uu____13727 =
                                  let uu____13728 =
                                    FStar_Ident.set_lid_range
                                      FStar_Parser_Const.as_ensures r in
                                  FStar_Syntax_Syntax.fvar uu____13728
                                    FStar_Syntax_Syntax.delta_equational
                                    FStar_Pervasives_Native.None in
                                FStar_Syntax_Syntax.mk_Tm_uinst uu____13727
                                  us_e in
                              let req =
                                let uu____13730 =
                                  let uu____13731 =
                                    let uu____13742 =
                                      FStar_Syntax_Syntax.as_arg wp in
                                    [uu____13742] in
                                  ((ct1.FStar_Syntax_Syntax.result_typ),
                                    (FStar_Pervasives_Native.Some
                                       FStar_Syntax_Syntax.imp_tag))
                                    :: uu____13731 in
                                FStar_Syntax_Syntax.mk_Tm_app as_req
                                  uu____13730
                                  (ct1.FStar_Syntax_Syntax.result_typ).FStar_Syntax_Syntax.pos in
                              let ens =
                                let uu____13780 =
                                  let uu____13781 =
                                    let uu____13792 =
                                      FStar_Syntax_Syntax.as_arg wp in
                                    [uu____13792] in
                                  ((ct1.FStar_Syntax_Syntax.result_typ),
                                    (FStar_Pervasives_Native.Some
                                       FStar_Syntax_Syntax.imp_tag))
                                    :: uu____13781 in
                                FStar_Syntax_Syntax.mk_Tm_app as_ens
                                  uu____13780
                                  (ct1.FStar_Syntax_Syntax.result_typ).FStar_Syntax_Syntax.pos in
                              let uu____13829 =
                                let uu____13832 = norm req in
                                FStar_Pervasives_Native.Some uu____13832 in
                              let uu____13833 =
                                let uu____13834 =
                                  mk_post_type
                                    ct1.FStar_Syntax_Syntax.result_typ ens in
                                norm uu____13834 in
                              (uu____13829, uu____13833)))
                | uu____13837 -> failwith "Impossible"))
let (reify_body :
  FStar_TypeChecker_Env.env ->
    FStar_TypeChecker_Env.steps ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
  =
  fun env ->
    fun steps ->
      fun t ->
        let tm = FStar_Syntax_Util.mk_reify t in
        let tm' =
          FStar_TypeChecker_Normalize.normalize
            (FStar_List.append
               [FStar_TypeChecker_Env.Beta;
               FStar_TypeChecker_Env.Reify;
               FStar_TypeChecker_Env.Eager_unfolding;
               FStar_TypeChecker_Env.EraseUniverses;
               FStar_TypeChecker_Env.AllowUnboundUniverses;
               FStar_TypeChecker_Env.Exclude FStar_TypeChecker_Env.Zeta]
               steps) env tm in
        (let uu____13876 =
           FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
             (FStar_Options.Other "SMTEncodingReify") in
         if uu____13876
         then
           let uu____13881 = FStar_Syntax_Print.term_to_string tm in
           let uu____13883 = FStar_Syntax_Print.term_to_string tm' in
           FStar_Util.print2 "Reified body %s \nto %s\n" uu____13881
             uu____13883
         else ());
        tm'
let (reify_body_with_arg :
  FStar_TypeChecker_Env.env ->
    FStar_TypeChecker_Env.steps ->
      FStar_Syntax_Syntax.term ->
        FStar_Syntax_Syntax.arg -> FStar_Syntax_Syntax.term)
  =
  fun env ->
    fun steps ->
      fun head ->
        fun arg ->
          let tm =
            FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (head, [arg]))
              head.FStar_Syntax_Syntax.pos in
          let tm' =
            FStar_TypeChecker_Normalize.normalize
              (FStar_List.append
                 [FStar_TypeChecker_Env.Beta;
                 FStar_TypeChecker_Env.Reify;
                 FStar_TypeChecker_Env.Eager_unfolding;
                 FStar_TypeChecker_Env.EraseUniverses;
                 FStar_TypeChecker_Env.AllowUnboundUniverses;
                 FStar_TypeChecker_Env.Exclude FStar_TypeChecker_Env.Zeta]
                 steps) env tm in
          (let uu____13942 =
             FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
               (FStar_Options.Other "SMTEncodingReify") in
           if uu____13942
           then
             let uu____13947 = FStar_Syntax_Print.term_to_string tm in
             let uu____13949 = FStar_Syntax_Print.term_to_string tm' in
             FStar_Util.print2 "Reified body %s \nto %s\n" uu____13947
               uu____13949
           else ());
          tm'
let (remove_reify : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun t ->
    let uu____13960 =
      let uu____13962 =
        let uu____13963 = FStar_Syntax_Subst.compress t in
        uu____13963.FStar_Syntax_Syntax.n in
      match uu____13962 with
      | FStar_Syntax_Syntax.Tm_app uu____13967 -> false
      | uu____13985 -> true in
    if uu____13960
    then t
    else
      (let uu____13990 = FStar_Syntax_Util.head_and_args t in
       match uu____13990 with
       | (head, args) ->
           let uu____14033 =
             let uu____14035 =
               let uu____14036 = FStar_Syntax_Subst.compress head in
               uu____14036.FStar_Syntax_Syntax.n in
             match uu____14035 with
             | FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_reify) ->
                 true
             | uu____14041 -> false in
           if uu____14033
           then
             (match args with
              | x::[] -> FStar_Pervasives_Native.fst x
              | uu____14073 ->
                  failwith
                    "Impossible : Reify applied to multiple arguments after normalization.")
           else t)
let (maybe_instantiate :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.typ ->
        (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.typ *
          FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun e ->
      fun t ->
        let torig = FStar_Syntax_Subst.compress t in
        if Prims.op_Negation env.FStar_TypeChecker_Env.instantiate_imp
        then (e, torig, FStar_TypeChecker_Env.trivial_guard)
        else
          ((let uu____14120 =
              FStar_TypeChecker_Env.debug env FStar_Options.High in
            if uu____14120
            then
              let uu____14123 = FStar_Syntax_Print.term_to_string e in
              let uu____14125 = FStar_Syntax_Print.term_to_string t in
              let uu____14127 =
                let uu____14129 = FStar_TypeChecker_Env.expected_typ env in
                FStar_Common.string_of_option
                  FStar_Syntax_Print.term_to_string uu____14129 in
              FStar_Util.print3
                "maybe_instantiate: starting check for (%s) of type (%s), expected type is %s\n"
                uu____14123 uu____14125 uu____14127
            else ());
           (let unfolded_arrow_formals t1 =
              let rec aux bs t2 =
                let t3 = FStar_TypeChecker_Normalize.unfold_whnf env t2 in
                let uu____14165 = FStar_Syntax_Util.arrow_formals t3 in
                match uu____14165 with
                | (bs', t4) ->
                    (match bs' with
                     | [] -> bs
                     | bs'1 -> aux (FStar_List.append bs bs'1) t4) in
              aux [] t1 in
            let number_of_implicits t1 =
              let formals = unfolded_arrow_formals t1 in
              let n_implicits =
                let uu____14199 =
                  FStar_All.pipe_right formals
                    (FStar_Util.prefix_until
                       (fun uu____14277 ->
                          match uu____14277 with
                          | (uu____14285, imp) ->
                              (FStar_Option.isNone imp) ||
                                (let uu____14292 =
                                   FStar_Syntax_Util.eq_aqual imp
                                     (FStar_Pervasives_Native.Some
                                        FStar_Syntax_Syntax.Equality) in
                                 uu____14292 = FStar_Syntax_Util.Equal))) in
                match uu____14199 with
                | FStar_Pervasives_Native.None -> FStar_List.length formals
                | FStar_Pervasives_Native.Some
                    (implicits, _first_explicit, _rest) ->
                    FStar_List.length implicits in
              n_implicits in
            let inst_n_binders t1 =
              let uu____14411 = FStar_TypeChecker_Env.expected_typ env in
              match uu____14411 with
              | FStar_Pervasives_Native.None -> FStar_Pervasives_Native.None
              | FStar_Pervasives_Native.Some expected_t ->
                  let n_expected = number_of_implicits expected_t in
                  let n_available = number_of_implicits t1 in
                  if n_available < n_expected
                  then
                    let uu____14425 =
                      let uu____14431 =
                        let uu____14433 = FStar_Util.string_of_int n_expected in
                        let uu____14435 = FStar_Syntax_Print.term_to_string e in
                        let uu____14437 =
                          FStar_Util.string_of_int n_available in
                        FStar_Util.format3
                          "Expected a term with %s implicit arguments, but %s has only %s"
                          uu____14433 uu____14435 uu____14437 in
                      (FStar_Errors.Fatal_MissingImplicitArguments,
                        uu____14431) in
                    let uu____14441 = FStar_TypeChecker_Env.get_range env in
                    FStar_Errors.raise_error uu____14425 uu____14441
                  else
                    FStar_Pervasives_Native.Some (n_available - n_expected) in
            let decr_inst uu___7_14459 =
              match uu___7_14459 with
              | FStar_Pervasives_Native.None -> FStar_Pervasives_Native.None
              | FStar_Pervasives_Native.Some i ->
                  FStar_Pervasives_Native.Some (i - Prims.int_one) in
            let t1 = FStar_TypeChecker_Normalize.unfold_whnf env t in
            match t1.FStar_Syntax_Syntax.n with
            | FStar_Syntax_Syntax.Tm_arrow (bs, c) ->
                let uu____14502 = FStar_Syntax_Subst.open_comp bs c in
                (match uu____14502 with
                 | (bs1, c1) ->
                     let rec aux subst inst_n bs2 =
                       match (inst_n, bs2) with
                       | (FStar_Pervasives_Native.Some uu____14633,
                          uu____14620) when uu____14633 = Prims.int_zero ->
                           ([], bs2, subst,
                             FStar_TypeChecker_Env.trivial_guard)
                       | (uu____14666,
                          (x, FStar_Pervasives_Native.Some
                           (FStar_Syntax_Syntax.Implicit uu____14668))::rest)
                           ->
                           let t2 =
                             FStar_Syntax_Subst.subst subst
                               x.FStar_Syntax_Syntax.sort in
                           let uu____14702 =
                             new_implicit_var
                               "Instantiation of implicit argument"
                               e.FStar_Syntax_Syntax.pos env t2 in
                           (match uu____14702 with
                            | (v, uu____14743, g) ->
                                ((let uu____14758 =
                                    FStar_TypeChecker_Env.debug env
                                      FStar_Options.High in
                                  if uu____14758
                                  then
                                    let uu____14761 =
                                      FStar_Syntax_Print.term_to_string v in
                                    FStar_Util.print1
                                      "maybe_instantiate: Instantiating implicit with %s\n"
                                      uu____14761
                                  else ());
                                 (let subst1 =
                                    (FStar_Syntax_Syntax.NT (x, v)) :: subst in
                                  let uu____14771 =
                                    aux subst1 (decr_inst inst_n) rest in
                                  match uu____14771 with
                                  | (args, bs3, subst2, g') ->
                                      let uu____14864 =
                                        FStar_TypeChecker_Env.conj_guard g g' in
                                      (((v,
                                          (FStar_Pervasives_Native.Some
                                             FStar_Syntax_Syntax.imp_tag)) ::
                                        args), bs3, subst2, uu____14864))))
                       | (uu____14891,
                          (x, FStar_Pervasives_Native.Some
                           (FStar_Syntax_Syntax.Meta tac_or_attr))::rest) ->
                           let t2 =
                             FStar_Syntax_Subst.subst subst
                               x.FStar_Syntax_Syntax.sort in
                           let meta_t =
                             match tac_or_attr with
                             | FStar_Syntax_Syntax.Arg_qualifier_meta_tac tau
                                 ->
                                 let uu____14930 =
                                   let uu____14937 = FStar_Dyn.mkdyn env in
                                   (uu____14937, tau) in
                                 FStar_Syntax_Syntax.Ctx_uvar_meta_tac
                                   uu____14930
                             | FStar_Syntax_Syntax.Arg_qualifier_meta_attr
                                 attr ->
                                 FStar_Syntax_Syntax.Ctx_uvar_meta_attr attr in
                           let uu____14943 =
                             FStar_TypeChecker_Env.new_implicit_var_aux
                               "Instantiation of meta argument"
                               e.FStar_Syntax_Syntax.pos env t2
                               FStar_Syntax_Syntax.Strict
                               (FStar_Pervasives_Native.Some meta_t) in
                           (match uu____14943 with
                            | (v, uu____14984, g) ->
                                ((let uu____14999 =
                                    FStar_TypeChecker_Env.debug env
                                      FStar_Options.High in
                                  if uu____14999
                                  then
                                    let uu____15002 =
                                      FStar_Syntax_Print.term_to_string v in
                                    FStar_Util.print1
                                      "maybe_instantiate: Instantiating meta argument with %s\n"
                                      uu____15002
                                  else ());
                                 (let subst1 =
                                    (FStar_Syntax_Syntax.NT (x, v)) :: subst in
                                  let uu____15012 =
                                    aux subst1 (decr_inst inst_n) rest in
                                  match uu____15012 with
                                  | (args, bs3, subst2, g') ->
                                      let uu____15105 =
                                        FStar_TypeChecker_Env.conj_guard g g' in
                                      (((v,
                                          (FStar_Pervasives_Native.Some
                                             FStar_Syntax_Syntax.imp_tag)) ::
                                        args), bs3, subst2, uu____15105))))
                       | (uu____15132, bs3) ->
                           ([], bs3, subst,
                             FStar_TypeChecker_Env.trivial_guard) in
                     let uu____15180 =
                       let uu____15207 = inst_n_binders t1 in
                       aux [] uu____15207 bs1 in
                     (match uu____15180 with
                      | (args, bs2, subst, guard) ->
                          (match (args, bs2) with
                           | ([], uu____15279) -> (e, torig, guard)
                           | (uu____15310, []) when
                               let uu____15341 =
                                 FStar_Syntax_Util.is_total_comp c1 in
                               Prims.op_Negation uu____15341 ->
                               (e, torig,
                                 FStar_TypeChecker_Env.trivial_guard)
                           | uu____15343 ->
                               let t2 =
                                 match bs2 with
                                 | [] -> FStar_Syntax_Util.comp_result c1
                                 | uu____15371 ->
                                     FStar_Syntax_Util.arrow bs2 c1 in
                               let t3 = FStar_Syntax_Subst.subst subst t2 in
                               let e1 =
                                 FStar_Syntax_Syntax.mk_Tm_app e args
                                   e.FStar_Syntax_Syntax.pos in
                               (e1, t3, guard))))
            | uu____15382 -> (e, torig, FStar_TypeChecker_Env.trivial_guard)))
let (string_of_univs :
  FStar_Syntax_Syntax.universe_uvar FStar_Util.set -> Prims.string) =
  fun univs ->
    let uu____15394 =
      let uu____15398 = FStar_Util.set_elements univs in
      FStar_All.pipe_right uu____15398
        (FStar_List.map
           (fun u ->
              let uu____15410 = FStar_Syntax_Unionfind.univ_uvar_id u in
              FStar_All.pipe_right uu____15410 FStar_Util.string_of_int)) in
    FStar_All.pipe_right uu____15394 (FStar_String.concat ", ")
let (gen_univs :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.universe_uvar FStar_Util.set ->
      FStar_Syntax_Syntax.univ_name Prims.list)
  =
  fun env ->
    fun x ->
      let uu____15438 = FStar_Util.set_is_empty x in
      if uu____15438
      then []
      else
        (let s =
           let uu____15458 =
             let uu____15461 = FStar_TypeChecker_Env.univ_vars env in
             FStar_Util.set_difference x uu____15461 in
           FStar_All.pipe_right uu____15458 FStar_Util.set_elements in
         (let uu____15479 =
            FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
              (FStar_Options.Other "Gen") in
          if uu____15479
          then
            let uu____15484 =
              let uu____15486 = FStar_TypeChecker_Env.univ_vars env in
              string_of_univs uu____15486 in
            FStar_Util.print1 "univ_vars in env: %s\n" uu____15484
          else ());
         (let r =
            let uu____15495 = FStar_TypeChecker_Env.get_range env in
            FStar_Pervasives_Native.Some uu____15495 in
          let u_names =
            FStar_All.pipe_right s
              (FStar_List.map
                 (fun u ->
                    let u_name = FStar_Syntax_Syntax.new_univ_name r in
                    (let uu____15540 =
                       FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
                         (FStar_Options.Other "Gen") in
                     if uu____15540
                     then
                       let uu____15545 =
                         let uu____15547 =
                           FStar_Syntax_Unionfind.univ_uvar_id u in
                         FStar_All.pipe_left FStar_Util.string_of_int
                           uu____15547 in
                       let uu____15551 =
                         FStar_Syntax_Print.univ_to_string
                           (FStar_Syntax_Syntax.U_unif u) in
                       let uu____15553 =
                         FStar_Syntax_Print.univ_to_string
                           (FStar_Syntax_Syntax.U_name u_name) in
                       FStar_Util.print3 "Setting ?%s (%s) to %s\n"
                         uu____15545 uu____15551 uu____15553
                     else ());
                    FStar_Syntax_Unionfind.univ_change u
                      (FStar_Syntax_Syntax.U_name u_name);
                    u_name)) in
          u_names))
let (gather_free_univnames :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.univ_name Prims.list)
  =
  fun env ->
    fun t ->
      let ctx_univnames = FStar_TypeChecker_Env.univnames env in
      let tm_univnames = FStar_Syntax_Free.univnames t in
      let univnames =
        let uu____15583 =
          FStar_Util.set_difference tm_univnames ctx_univnames in
        FStar_All.pipe_right uu____15583 FStar_Util.set_elements in
      univnames
let (check_universe_generalization :
  FStar_Syntax_Syntax.univ_name Prims.list ->
    FStar_Syntax_Syntax.univ_name Prims.list ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.univ_name Prims.list)
  =
  fun explicit_univ_names ->
    fun generalized_univ_names ->
      fun t ->
        match (explicit_univ_names, generalized_univ_names) with
        | ([], uu____15622) -> generalized_univ_names
        | (uu____15629, []) -> explicit_univ_names
        | uu____15636 ->
            let uu____15645 =
              let uu____15651 =
                let uu____15653 = FStar_Syntax_Print.term_to_string t in
                Prims.op_Hat
                  "Generalized universe in a term containing explicit universe annotation : "
                  uu____15653 in
              (FStar_Errors.Fatal_UnexpectedGeneralizedUniverse, uu____15651) in
            FStar_Errors.raise_error uu____15645 t.FStar_Syntax_Syntax.pos
let (generalize_universes :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.tscheme)
  =
  fun env ->
    fun t0 ->
      let t =
        FStar_TypeChecker_Normalize.normalize
          [FStar_TypeChecker_Env.NoFullNorm;
          FStar_TypeChecker_Env.Beta;
          FStar_TypeChecker_Env.DoNotUnfoldPureLets] env t0 in
      let univnames = gather_free_univnames env t in
      (let uu____15675 =
         FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
           (FStar_Options.Other "Gen") in
       if uu____15675
       then
         let uu____15680 = FStar_Syntax_Print.term_to_string t in
         let uu____15682 = FStar_Syntax_Print.univ_names_to_string univnames in
         FStar_Util.print2
           "generalizing universes in the term (post norm): %s with univnames: %s\n"
           uu____15680 uu____15682
       else ());
      (let univs = FStar_Syntax_Free.univs t in
       (let uu____15691 =
          FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
            (FStar_Options.Other "Gen") in
        if uu____15691
        then
          let uu____15696 = string_of_univs univs in
          FStar_Util.print1 "univs to gen : %s\n" uu____15696
        else ());
       (let gen = gen_univs env univs in
        (let uu____15705 =
           FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
             (FStar_Options.Other "Gen") in
         if uu____15705
         then
           let uu____15710 = FStar_Syntax_Print.term_to_string t in
           let uu____15712 = FStar_Syntax_Print.univ_names_to_string gen in
           FStar_Util.print2 "After generalization, t: %s and univs: %s\n"
             uu____15710 uu____15712
         else ());
        (let univs1 = check_universe_generalization univnames gen t0 in
         let t1 = FStar_TypeChecker_Normalize.reduce_uvar_solutions env t in
         let ts = FStar_Syntax_Subst.close_univ_vars univs1 t1 in
         (univs1, ts))))
let (gen :
  FStar_TypeChecker_Env.env ->
    Prims.bool ->
      (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.term *
        FStar_Syntax_Syntax.comp) Prims.list ->
        (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.univ_name
          Prims.list * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.comp *
          FStar_Syntax_Syntax.binder Prims.list) Prims.list
          FStar_Pervasives_Native.option)
  =
  fun env ->
    fun is_rec ->
      fun lecs ->
        let uu____15796 =
          let uu____15798 =
            FStar_Util.for_all
              (fun uu____15812 ->
                 match uu____15812 with
                 | (uu____15822, uu____15823, c) ->
                     FStar_Syntax_Util.is_pure_or_ghost_comp c) lecs in
          FStar_All.pipe_left Prims.op_Negation uu____15798 in
        if uu____15796
        then FStar_Pervasives_Native.None
        else
          (let norm c =
             (let uu____15875 =
                FStar_TypeChecker_Env.debug env FStar_Options.Medium in
              if uu____15875
              then
                let uu____15878 = FStar_Syntax_Print.comp_to_string c in
                FStar_Util.print1 "Normalizing before generalizing:\n\t %s\n"
                  uu____15878
              else ());
             (let c1 =
                FStar_TypeChecker_Normalize.normalize_comp
                  [FStar_TypeChecker_Env.Beta;
                  FStar_TypeChecker_Env.Exclude FStar_TypeChecker_Env.Zeta;
                  FStar_TypeChecker_Env.NoFullNorm;
                  FStar_TypeChecker_Env.DoNotUnfoldPureLets] env c in
              (let uu____15885 =
                 FStar_TypeChecker_Env.debug env FStar_Options.Medium in
               if uu____15885
               then
                 let uu____15888 = FStar_Syntax_Print.comp_to_string c1 in
                 FStar_Util.print1 "Normalized to:\n\t %s\n" uu____15888
               else ());
              c1) in
           let env_uvars = FStar_TypeChecker_Env.uvars_in_env env in
           let gen_uvars uvs =
             let uu____15906 = FStar_Util.set_difference uvs env_uvars in
             FStar_All.pipe_right uu____15906 FStar_Util.set_elements in
           let univs_and_uvars_of_lec uu____15940 =
             match uu____15940 with
             | (lbname, e, c) ->
                 let c1 = norm c in
                 let t = FStar_Syntax_Util.comp_result c1 in
                 let univs = FStar_Syntax_Free.univs t in
                 let uvt = FStar_Syntax_Free.uvars t in
                 ((let uu____15977 =
                     FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
                       (FStar_Options.Other "Gen") in
                   if uu____15977
                   then
                     let uu____15982 =
                       let uu____15984 =
                         let uu____15988 = FStar_Util.set_elements univs in
                         FStar_All.pipe_right uu____15988
                           (FStar_List.map
                              (fun u ->
                                 FStar_Syntax_Print.univ_to_string
                                   (FStar_Syntax_Syntax.U_unif u))) in
                       FStar_All.pipe_right uu____15984
                         (FStar_String.concat ", ") in
                     let uu____16044 =
                       let uu____16046 =
                         let uu____16050 = FStar_Util.set_elements uvt in
                         FStar_All.pipe_right uu____16050
                           (FStar_List.map
                              (fun u ->
                                 let uu____16063 =
                                   FStar_Syntax_Print.uvar_to_string
                                     u.FStar_Syntax_Syntax.ctx_uvar_head in
                                 let uu____16065 =
                                   FStar_Syntax_Print.term_to_string
                                     u.FStar_Syntax_Syntax.ctx_uvar_typ in
                                 FStar_Util.format2 "(%s : %s)" uu____16063
                                   uu____16065)) in
                       FStar_All.pipe_right uu____16046
                         (FStar_String.concat ", ") in
                     FStar_Util.print2
                       "^^^^\n\tFree univs = %s\n\tFree uvt=%s\n" uu____15982
                       uu____16044
                   else ());
                  (let univs1 =
                     let uu____16079 = FStar_Util.set_elements uvt in
                     FStar_List.fold_left
                       (fun univs1 ->
                          fun uv ->
                            let uu____16091 =
                              FStar_Syntax_Free.univs
                                uv.FStar_Syntax_Syntax.ctx_uvar_typ in
                            FStar_Util.set_union univs1 uu____16091) univs
                       uu____16079 in
                   let uvs = gen_uvars uvt in
                   (let uu____16098 =
                      FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
                        (FStar_Options.Other "Gen") in
                    if uu____16098
                    then
                      let uu____16103 =
                        let uu____16105 =
                          let uu____16109 = FStar_Util.set_elements univs1 in
                          FStar_All.pipe_right uu____16109
                            (FStar_List.map
                               (fun u ->
                                  FStar_Syntax_Print.univ_to_string
                                    (FStar_Syntax_Syntax.U_unif u))) in
                        FStar_All.pipe_right uu____16105
                          (FStar_String.concat ", ") in
                      let uu____16165 =
                        let uu____16167 =
                          FStar_All.pipe_right uvs
                            (FStar_List.map
                               (fun u ->
                                  let uu____16181 =
                                    FStar_Syntax_Print.uvar_to_string
                                      u.FStar_Syntax_Syntax.ctx_uvar_head in
                                  let uu____16183 =
                                    FStar_TypeChecker_Normalize.term_to_string
                                      env u.FStar_Syntax_Syntax.ctx_uvar_typ in
                                  FStar_Util.format2 "(%s : %s)" uu____16181
                                    uu____16183)) in
                        FStar_All.pipe_right uu____16167
                          (FStar_String.concat ", ") in
                      FStar_Util.print2
                        "^^^^\n\tFree univs = %s\n\tgen_uvars =%s"
                        uu____16103 uu____16165
                    else ());
                   (univs1, uvs, (lbname, e, c1)))) in
           let uu____16204 =
             let uu____16221 = FStar_List.hd lecs in
             univs_and_uvars_of_lec uu____16221 in
           match uu____16204 with
           | (univs, uvs, lec_hd) ->
               let force_univs_eq lec2 u1 u2 =
                 let uu____16311 =
                   (FStar_Util.set_is_subset_of u1 u2) &&
                     (FStar_Util.set_is_subset_of u2 u1) in
                 if uu____16311
                 then ()
                 else
                   (let uu____16316 = lec_hd in
                    match uu____16316 with
                    | (lb1, uu____16324, uu____16325) ->
                        let uu____16326 = lec2 in
                        (match uu____16326 with
                         | (lb2, uu____16334, uu____16335) ->
                             let msg =
                               let uu____16338 =
                                 FStar_Syntax_Print.lbname_to_string lb1 in
                               let uu____16340 =
                                 FStar_Syntax_Print.lbname_to_string lb2 in
                               FStar_Util.format2
                                 "Generalizing the types of these mutually recursive definitions requires an incompatible set of universes for %s and %s"
                                 uu____16338 uu____16340 in
                             let uu____16343 =
                               FStar_TypeChecker_Env.get_range env in
                             FStar_Errors.raise_error
                               (FStar_Errors.Fatal_IncompatibleSetOfUniverse,
                                 msg) uu____16343)) in
               let force_uvars_eq lec2 u1 u2 =
                 let uvars_subseteq u11 u21 =
                   FStar_All.pipe_right u11
                     (FStar_Util.for_all
                        (fun u ->
                           FStar_All.pipe_right u21
                             (FStar_Util.for_some
                                (fun u' ->
                                   FStar_Syntax_Unionfind.equiv
                                     u.FStar_Syntax_Syntax.ctx_uvar_head
                                     u'.FStar_Syntax_Syntax.ctx_uvar_head)))) in
                 let uu____16411 =
                   (uvars_subseteq u1 u2) && (uvars_subseteq u2 u1) in
                 if uu____16411
                 then ()
                 else
                   (let uu____16416 = lec_hd in
                    match uu____16416 with
                    | (lb1, uu____16424, uu____16425) ->
                        let uu____16426 = lec2 in
                        (match uu____16426 with
                         | (lb2, uu____16434, uu____16435) ->
                             let msg =
                               let uu____16438 =
                                 FStar_Syntax_Print.lbname_to_string lb1 in
                               let uu____16440 =
                                 FStar_Syntax_Print.lbname_to_string lb2 in
                               FStar_Util.format2
                                 "Generalizing the types of these mutually recursive definitions requires an incompatible number of types for %s and %s"
                                 uu____16438 uu____16440 in
                             let uu____16443 =
                               FStar_TypeChecker_Env.get_range env in
                             FStar_Errors.raise_error
                               (FStar_Errors.Fatal_IncompatibleNumberOfTypes,
                                 msg) uu____16443)) in
               let lecs1 =
                 let uu____16454 = FStar_List.tl lecs in
                 FStar_List.fold_right
                   (fun this_lec ->
                      fun lecs1 ->
                        let uu____16507 = univs_and_uvars_of_lec this_lec in
                        match uu____16507 with
                        | (this_univs, this_uvs, this_lec1) ->
                            (force_univs_eq this_lec1 univs this_univs;
                             force_uvars_eq this_lec1 uvs this_uvs;
                             this_lec1
                             ::
                             lecs1)) uu____16454 [] in
               let lecs2 = lec_hd :: lecs1 in
               let gen_types uvs1 =
                 let fail rng k =
                   let uu____16617 = lec_hd in
                   match uu____16617 with
                   | (lbname, e, c) ->
                       let uu____16627 =
                         let uu____16633 =
                           let uu____16635 =
                             FStar_Syntax_Print.term_to_string k in
                           let uu____16637 =
                             FStar_Syntax_Print.lbname_to_string lbname in
                           let uu____16639 =
                             FStar_Syntax_Print.term_to_string
                               (FStar_Syntax_Util.comp_result c) in
                           FStar_Util.format3
                             "Failed to resolve implicit argument of type '%s' in the type of %s (%s)"
                             uu____16635 uu____16637 uu____16639 in
                         (FStar_Errors.Fatal_FailToResolveImplicitArgument,
                           uu____16633) in
                       FStar_Errors.raise_error uu____16627 rng in
                 FStar_All.pipe_right uvs1
                   (FStar_List.map
                      (fun u ->
                         let uu____16661 =
                           FStar_Syntax_Unionfind.find
                             u.FStar_Syntax_Syntax.ctx_uvar_head in
                         match uu____16661 with
                         | FStar_Pervasives_Native.Some uu____16670 ->
                             failwith
                               "Unexpected instantiation of mutually recursive uvar"
                         | uu____16678 ->
                             let k =
                               FStar_TypeChecker_Normalize.normalize
                                 [FStar_TypeChecker_Env.Beta;
                                 FStar_TypeChecker_Env.Exclude
                                   FStar_TypeChecker_Env.Zeta] env
                                 u.FStar_Syntax_Syntax.ctx_uvar_typ in
                             let uu____16682 =
                               FStar_Syntax_Util.arrow_formals k in
                             (match uu____16682 with
                              | (bs, kres) ->
                                  ((let uu____16702 =
                                      let uu____16703 =
                                        let uu____16706 =
                                          FStar_TypeChecker_Normalize.unfold_whnf
                                            env kres in
                                        FStar_Syntax_Util.unrefine
                                          uu____16706 in
                                      uu____16703.FStar_Syntax_Syntax.n in
                                    match uu____16702 with
                                    | FStar_Syntax_Syntax.Tm_type uu____16707
                                        ->
                                        let free =
                                          FStar_Syntax_Free.names kres in
                                        let uu____16711 =
                                          let uu____16713 =
                                            FStar_Util.set_is_empty free in
                                          Prims.op_Negation uu____16713 in
                                        if uu____16711
                                        then
                                          fail
                                            u.FStar_Syntax_Syntax.ctx_uvar_range
                                            kres
                                        else ()
                                    | uu____16718 ->
                                        fail
                                          u.FStar_Syntax_Syntax.ctx_uvar_range
                                          kres);
                                   (let a =
                                      let uu____16720 =
                                        let uu____16723 =
                                          FStar_TypeChecker_Env.get_range env in
                                        FStar_All.pipe_left
                                          (fun uu____16726 ->
                                             FStar_Pervasives_Native.Some
                                               uu____16726) uu____16723 in
                                      FStar_Syntax_Syntax.new_bv uu____16720
                                        kres in
                                    let t =
                                      match bs with
                                      | [] ->
                                          FStar_Syntax_Syntax.bv_to_name a
                                      | uu____16734 ->
                                          let uu____16735 =
                                            FStar_Syntax_Syntax.bv_to_name a in
                                          FStar_Syntax_Util.abs bs
                                            uu____16735
                                            (FStar_Pervasives_Native.Some
                                               (FStar_Syntax_Util.residual_tot
                                                  kres)) in
                                    FStar_Syntax_Util.set_uvar
                                      u.FStar_Syntax_Syntax.ctx_uvar_head t;
                                    (a,
                                      (FStar_Pervasives_Native.Some
                                         FStar_Syntax_Syntax.imp_tag))))))) in
               let gen_univs1 = gen_univs env univs in
               let gen_tvars = gen_types uvs in
               let ecs =
                 FStar_All.pipe_right lecs2
                   (FStar_List.map
                      (fun uu____16838 ->
                         match uu____16838 with
                         | (lbname, e, c) ->
                             let uu____16884 =
                               match (gen_tvars, gen_univs1) with
                               | ([], []) -> (e, c, [])
                               | uu____16945 ->
                                   let uu____16958 = (e, c) in
                                   (match uu____16958 with
                                    | (e0, c0) ->
                                        let c1 =
                                          FStar_TypeChecker_Normalize.normalize_comp
                                            [FStar_TypeChecker_Env.Beta;
                                            FStar_TypeChecker_Env.DoNotUnfoldPureLets;
                                            FStar_TypeChecker_Env.CompressUvars;
                                            FStar_TypeChecker_Env.NoFullNorm;
                                            FStar_TypeChecker_Env.Exclude
                                              FStar_TypeChecker_Env.Zeta] env
                                            c in
                                        let e1 =
                                          FStar_TypeChecker_Normalize.reduce_uvar_solutions
                                            env e in
                                        let e2 =
                                          if is_rec
                                          then
                                            let tvar_args =
                                              FStar_List.map
                                                (fun uu____16998 ->
                                                   match uu____16998 with
                                                   | (x, uu____17004) ->
                                                       let uu____17005 =
                                                         FStar_Syntax_Syntax.bv_to_name
                                                           x in
                                                       FStar_Syntax_Syntax.iarg
                                                         uu____17005)
                                                gen_tvars in
                                            let instantiate_lbname_with_app
                                              tm fv =
                                              let uu____17023 =
                                                let uu____17025 =
                                                  FStar_Util.right lbname in
                                                FStar_Syntax_Syntax.fv_eq fv
                                                  uu____17025 in
                                              if uu____17023
                                              then
                                                FStar_Syntax_Syntax.mk_Tm_app
                                                  tm tvar_args
                                                  tm.FStar_Syntax_Syntax.pos
                                              else tm in
                                            FStar_Syntax_InstFV.inst
                                              instantiate_lbname_with_app e1
                                          else e1 in
                                        let t =
                                          let uu____17034 =
                                            let uu____17035 =
                                              FStar_Syntax_Subst.compress
                                                (FStar_Syntax_Util.comp_result
                                                   c1) in
                                            uu____17035.FStar_Syntax_Syntax.n in
                                          match uu____17034 with
                                          | FStar_Syntax_Syntax.Tm_arrow
                                              (bs, cod) ->
                                              let uu____17060 =
                                                FStar_Syntax_Subst.open_comp
                                                  bs cod in
                                              (match uu____17060 with
                                               | (bs1, cod1) ->
                                                   FStar_Syntax_Util.arrow
                                                     (FStar_List.append
                                                        gen_tvars bs1) cod1)
                                          | uu____17071 ->
                                              FStar_Syntax_Util.arrow
                                                gen_tvars c1 in
                                        let e' =
                                          FStar_Syntax_Util.abs gen_tvars e2
                                            (FStar_Pervasives_Native.Some
                                               (FStar_Syntax_Util.residual_comp_of_comp
                                                  c1)) in
                                        let uu____17075 =
                                          FStar_Syntax_Syntax.mk_Total t in
                                        (e', uu____17075, gen_tvars)) in
                             (match uu____16884 with
                              | (e1, c1, gvs) ->
                                  (lbname, gen_univs1, e1, c1, gvs)))) in
               FStar_Pervasives_Native.Some ecs)
let (generalize' :
  FStar_TypeChecker_Env.env ->
    Prims.bool ->
      (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.term *
        FStar_Syntax_Syntax.comp) Prims.list ->
        (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.univ_names *
          FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.comp *
          FStar_Syntax_Syntax.binder Prims.list) Prims.list)
  =
  fun env ->
    fun is_rec ->
      fun lecs ->
        (let uu____17222 = FStar_TypeChecker_Env.debug env FStar_Options.Low in
         if uu____17222
         then
           let uu____17225 =
             let uu____17227 =
               FStar_List.map
                 (fun uu____17242 ->
                    match uu____17242 with
                    | (lb, uu____17251, uu____17252) ->
                        FStar_Syntax_Print.lbname_to_string lb) lecs in
             FStar_All.pipe_right uu____17227 (FStar_String.concat ", ") in
           FStar_Util.print1 "Generalizing: %s\n" uu____17225
         else ());
        (let univnames_lecs =
           FStar_List.map
             (fun uu____17278 ->
                match uu____17278 with
                | (l, t, c) -> gather_free_univnames env t) lecs in
         let generalized_lecs =
           let uu____17307 = gen env is_rec lecs in
           match uu____17307 with
           | FStar_Pervasives_Native.None ->
               FStar_All.pipe_right lecs
                 (FStar_List.map
                    (fun uu____17406 ->
                       match uu____17406 with
                       | (l, t, c) -> (l, [], t, c, [])))
           | FStar_Pervasives_Native.Some luecs ->
               ((let uu____17468 =
                   FStar_TypeChecker_Env.debug env FStar_Options.Medium in
                 if uu____17468
                 then
                   FStar_All.pipe_right luecs
                     (FStar_List.iter
                        (fun uu____17516 ->
                           match uu____17516 with
                           | (l, us, e, c, gvs) ->
                               let uu____17550 =
                                 FStar_Range.string_of_range
                                   e.FStar_Syntax_Syntax.pos in
                               let uu____17552 =
                                 FStar_Syntax_Print.lbname_to_string l in
                               let uu____17554 =
                                 FStar_Syntax_Print.term_to_string
                                   (FStar_Syntax_Util.comp_result c) in
                               let uu____17556 =
                                 FStar_Syntax_Print.term_to_string e in
                               let uu____17558 =
                                 FStar_Syntax_Print.binders_to_string ", "
                                   gvs in
                               FStar_Util.print5
                                 "(%s) Generalized %s at type %s\n%s\nVars = (%s)\n"
                                 uu____17550 uu____17552 uu____17554
                                 uu____17556 uu____17558))
                 else ());
                luecs) in
         FStar_List.map2
           (fun univnames ->
              fun uu____17603 ->
                match uu____17603 with
                | (l, generalized_univs, t, c, gvs) ->
                    let uu____17647 =
                      check_universe_generalization univnames
                        generalized_univs t in
                    (l, uu____17647, t, c, gvs)) univnames_lecs
           generalized_lecs)
let (generalize :
  FStar_TypeChecker_Env.env ->
    Prims.bool ->
      (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.term *
        FStar_Syntax_Syntax.comp) Prims.list ->
        (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.univ_names *
          FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.comp *
          FStar_Syntax_Syntax.binder Prims.list) Prims.list)
  =
  fun env ->
    fun is_rec ->
      fun lecs ->
        let uu____17702 =
          let uu____17706 =
            let uu____17708 = FStar_TypeChecker_Env.current_module env in
            FStar_Ident.string_of_lid uu____17708 in
          FStar_Pervasives_Native.Some uu____17706 in
        FStar_Profiling.profile
          (fun uu____17725 -> generalize' env is_rec lecs) uu____17702
          "FStar.TypeChecker.Util.generalize"
let (check_has_type :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_TypeChecker_Common.lcomp ->
        FStar_Syntax_Syntax.typ ->
          (FStar_Syntax_Syntax.term * FStar_TypeChecker_Common.lcomp *
            FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun e ->
      fun lc ->
        fun t2 ->
          let env1 =
            FStar_TypeChecker_Env.set_range env e.FStar_Syntax_Syntax.pos in
          let check env2 t1 t21 =
            if env2.FStar_TypeChecker_Env.use_eq_strict
            then
              let uu____17782 =
                FStar_TypeChecker_Rel.get_teq_predicate env2 t1 t21 in
              match uu____17782 with
              | FStar_Pervasives_Native.None -> FStar_Pervasives_Native.None
              | FStar_Pervasives_Native.Some f ->
                  let uu____17788 = FStar_TypeChecker_Env.apply_guard f e in
                  FStar_All.pipe_right uu____17788
                    (fun uu____17791 ->
                       FStar_Pervasives_Native.Some uu____17791)
            else
              if env2.FStar_TypeChecker_Env.use_eq
              then FStar_TypeChecker_Rel.try_teq true env2 t1 t21
              else
                (let uu____17800 =
                   FStar_TypeChecker_Rel.get_subtyping_predicate env2 t1 t21 in
                 match uu____17800 with
                 | FStar_Pervasives_Native.None ->
                     FStar_Pervasives_Native.None
                 | FStar_Pervasives_Native.Some f ->
                     let uu____17806 = FStar_TypeChecker_Env.apply_guard f e in
                     FStar_All.pipe_left
                       (fun uu____17809 ->
                          FStar_Pervasives_Native.Some uu____17809)
                       uu____17806) in
          let uu____17810 = maybe_coerce_lc env1 e lc t2 in
          match uu____17810 with
          | (e1, lc1, g_c) ->
              let uu____17826 =
                check env1 lc1.FStar_TypeChecker_Common.res_typ t2 in
              (match uu____17826 with
               | FStar_Pervasives_Native.None ->
                   let uu____17835 =
                     FStar_TypeChecker_Err.expected_expression_of_type env1
                       t2 e1 lc1.FStar_TypeChecker_Common.res_typ in
                   let uu____17841 = FStar_TypeChecker_Env.get_range env1 in
                   FStar_Errors.raise_error uu____17835 uu____17841
               | FStar_Pervasives_Native.Some g ->
                   ((let uu____17850 =
                       FStar_All.pipe_left (FStar_TypeChecker_Env.debug env1)
                         (FStar_Options.Other "Rel") in
                     if uu____17850
                     then
                       let uu____17855 =
                         FStar_TypeChecker_Rel.guard_to_string env1 g in
                       FStar_All.pipe_left
                         (FStar_Util.print1 "Applied guard is %s\n")
                         uu____17855
                     else ());
                    (let uu____17861 = FStar_TypeChecker_Env.conj_guard g g_c in
                     (e1, lc1, uu____17861))))
let (check_top_level :
  FStar_TypeChecker_Env.env ->
    FStar_TypeChecker_Common.guard_t ->
      FStar_TypeChecker_Common.lcomp ->
        (Prims.bool * FStar_Syntax_Syntax.comp))
  =
  fun env ->
    fun g ->
      fun lc ->
        (let uu____17889 =
           FStar_TypeChecker_Env.debug env FStar_Options.Medium in
         if uu____17889
         then
           let uu____17892 = FStar_TypeChecker_Common.lcomp_to_string lc in
           FStar_Util.print1 "check_top_level, lc = %s\n" uu____17892
         else ());
        (let discharge g1 =
           FStar_TypeChecker_Rel.force_trivial_guard env g1;
           FStar_TypeChecker_Common.is_pure_lcomp lc in
         let g1 = FStar_TypeChecker_Rel.solve_deferred_constraints env g in
         let uu____17906 = FStar_TypeChecker_Common.lcomp_comp lc in
         match uu____17906 with
         | (c, g_c) ->
             let uu____17918 = FStar_TypeChecker_Common.is_total_lcomp lc in
             if uu____17918
             then
               let uu____17926 =
                 let uu____17928 = FStar_TypeChecker_Env.conj_guard g1 g_c in
                 discharge uu____17928 in
               (uu____17926, c)
             else
               (let steps =
                  [FStar_TypeChecker_Env.Beta;
                  FStar_TypeChecker_Env.NoFullNorm;
                  FStar_TypeChecker_Env.DoNotUnfoldPureLets] in
                let c1 =
                  let uu____17936 =
                    let uu____17937 =
                      FStar_TypeChecker_Env.unfold_effect_abbrev env c in
                    FStar_All.pipe_right uu____17937
                      FStar_Syntax_Syntax.mk_Comp in
                  FStar_All.pipe_right uu____17936
                    (FStar_TypeChecker_Normalize.normalize_comp steps env) in
                let uu____17938 = check_trivial_precondition env c1 in
                match uu____17938 with
                | (ct, vc, g_pre) ->
                    ((let uu____17954 =
                        FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
                          (FStar_Options.Other "Simplification") in
                      if uu____17954
                      then
                        let uu____17959 =
                          FStar_Syntax_Print.term_to_string vc in
                        FStar_Util.print1 "top-level VC: %s\n" uu____17959
                      else ());
                     (let uu____17964 =
                        let uu____17966 =
                          let uu____17967 =
                            FStar_TypeChecker_Env.conj_guard g_c g_pre in
                          FStar_TypeChecker_Env.conj_guard g1 uu____17967 in
                        discharge uu____17966 in
                      let uu____17968 =
                        FStar_All.pipe_right ct FStar_Syntax_Syntax.mk_Comp in
                      (uu____17964, uu____17968)))))
let (short_circuit :
  FStar_Syntax_Syntax.term ->
    FStar_Syntax_Syntax.args -> FStar_TypeChecker_Common.guard_formula)
  =
  fun head ->
    fun seen_args ->
      let short_bin_op f uu___8_18002 =
        match uu___8_18002 with
        | [] -> FStar_TypeChecker_Common.Trivial
        | (fst, uu____18012)::[] -> f fst
        | uu____18037 -> failwith "Unexpexted args to binary operator" in
      let op_and_e e =
        let uu____18049 = FStar_Syntax_Util.b2t e in
        FStar_All.pipe_right uu____18049
          (fun uu____18050 -> FStar_TypeChecker_Common.NonTrivial uu____18050) in
      let op_or_e e =
        let uu____18061 =
          let uu____18062 = FStar_Syntax_Util.b2t e in
          FStar_Syntax_Util.mk_neg uu____18062 in
        FStar_All.pipe_right uu____18061
          (fun uu____18065 -> FStar_TypeChecker_Common.NonTrivial uu____18065) in
      let op_and_t t =
        FStar_All.pipe_right t
          (fun uu____18072 -> FStar_TypeChecker_Common.NonTrivial uu____18072) in
      let op_or_t t =
        let uu____18083 = FStar_All.pipe_right t FStar_Syntax_Util.mk_neg in
        FStar_All.pipe_right uu____18083
          (fun uu____18086 -> FStar_TypeChecker_Common.NonTrivial uu____18086) in
      let op_imp_t t =
        FStar_All.pipe_right t
          (fun uu____18093 -> FStar_TypeChecker_Common.NonTrivial uu____18093) in
      let short_op_ite uu___9_18099 =
        match uu___9_18099 with
        | [] -> FStar_TypeChecker_Common.Trivial
        | (guard, uu____18109)::[] ->
            FStar_TypeChecker_Common.NonTrivial guard
        | _then::(guard, uu____18136)::[] ->
            let uu____18177 = FStar_Syntax_Util.mk_neg guard in
            FStar_All.pipe_right uu____18177
              (fun uu____18178 ->
                 FStar_TypeChecker_Common.NonTrivial uu____18178)
        | uu____18179 -> failwith "Unexpected args to ITE" in
      let table =
        let uu____18191 =
          let uu____18199 = short_bin_op op_and_e in
          (FStar_Parser_Const.op_And, uu____18199) in
        let uu____18207 =
          let uu____18217 =
            let uu____18225 = short_bin_op op_or_e in
            (FStar_Parser_Const.op_Or, uu____18225) in
          let uu____18233 =
            let uu____18243 =
              let uu____18251 = short_bin_op op_and_t in
              (FStar_Parser_Const.and_lid, uu____18251) in
            let uu____18259 =
              let uu____18269 =
                let uu____18277 = short_bin_op op_or_t in
                (FStar_Parser_Const.or_lid, uu____18277) in
              let uu____18285 =
                let uu____18295 =
                  let uu____18303 = short_bin_op op_imp_t in
                  (FStar_Parser_Const.imp_lid, uu____18303) in
                [uu____18295; (FStar_Parser_Const.ite_lid, short_op_ite)] in
              uu____18269 :: uu____18285 in
            uu____18243 :: uu____18259 in
          uu____18217 :: uu____18233 in
        uu____18191 :: uu____18207 in
      match head.FStar_Syntax_Syntax.n with
      | FStar_Syntax_Syntax.Tm_fvar fv ->
          let lid = (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v in
          let uu____18365 =
            FStar_Util.find_map table
              (fun uu____18380 ->
                 match uu____18380 with
                 | (x, mk) ->
                     let uu____18397 = FStar_Ident.lid_equals x lid in
                     if uu____18397
                     then
                       let uu____18402 = mk seen_args in
                       FStar_Pervasives_Native.Some uu____18402
                     else FStar_Pervasives_Native.None) in
          (match uu____18365 with
           | FStar_Pervasives_Native.None -> FStar_TypeChecker_Common.Trivial
           | FStar_Pervasives_Native.Some g -> g)
      | uu____18406 -> FStar_TypeChecker_Common.Trivial
let (short_circuit_head : FStar_Syntax_Syntax.term -> Prims.bool) =
  fun l ->
    let uu____18414 =
      let uu____18415 = FStar_Syntax_Util.un_uinst l in
      uu____18415.FStar_Syntax_Syntax.n in
    match uu____18414 with
    | FStar_Syntax_Syntax.Tm_fvar fv ->
        FStar_Util.for_some (FStar_Syntax_Syntax.fv_eq_lid fv)
          [FStar_Parser_Const.op_And;
          FStar_Parser_Const.op_Or;
          FStar_Parser_Const.and_lid;
          FStar_Parser_Const.or_lid;
          FStar_Parser_Const.imp_lid;
          FStar_Parser_Const.ite_lid]
    | uu____18420 -> false
let (maybe_add_implicit_binders :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.binders -> FStar_Syntax_Syntax.binders)
  =
  fun env ->
    fun bs ->
      let pos bs1 =
        match bs1 with
        | (hd, uu____18456)::uu____18457 ->
            FStar_Syntax_Syntax.range_of_bv hd
        | uu____18476 -> FStar_TypeChecker_Env.get_range env in
      match bs with
      | (uu____18485, FStar_Pervasives_Native.Some
         (FStar_Syntax_Syntax.Implicit uu____18486))::uu____18487 -> bs
      | uu____18505 ->
          let uu____18506 = FStar_TypeChecker_Env.expected_typ env in
          (match uu____18506 with
           | FStar_Pervasives_Native.None -> bs
           | FStar_Pervasives_Native.Some t ->
               let uu____18510 =
                 let uu____18511 = FStar_Syntax_Subst.compress t in
                 uu____18511.FStar_Syntax_Syntax.n in
               (match uu____18510 with
                | FStar_Syntax_Syntax.Tm_arrow (bs', uu____18515) ->
                    let uu____18536 =
                      FStar_Util.prefix_until
                        (fun uu___10_18576 ->
                           match uu___10_18576 with
                           | (uu____18584, FStar_Pervasives_Native.Some
                              (FStar_Syntax_Syntax.Implicit uu____18585)) ->
                               false
                           | uu____18590 -> true) bs' in
                    (match uu____18536 with
                     | FStar_Pervasives_Native.None -> bs
                     | FStar_Pervasives_Native.Some
                         ([], uu____18626, uu____18627) -> bs
                     | FStar_Pervasives_Native.Some
                         (imps, uu____18699, uu____18700) ->
                         let uu____18773 =
                           FStar_All.pipe_right imps
                             (FStar_Util.for_all
                                (fun uu____18794 ->
                                   match uu____18794 with
                                   | (x, uu____18803) ->
                                       let uu____18808 =
                                         FStar_Ident.string_of_id
                                           x.FStar_Syntax_Syntax.ppname in
                                       FStar_Util.starts_with uu____18808 "'")) in
                         if uu____18773
                         then
                           let r = pos bs in
                           let imps1 =
                             FStar_All.pipe_right imps
                               (FStar_List.map
                                  (fun uu____18854 ->
                                     match uu____18854 with
                                     | (x, i) ->
                                         let uu____18873 =
                                           FStar_Syntax_Syntax.set_range_of_bv
                                             x r in
                                         (uu____18873, i))) in
                           FStar_List.append imps1 bs
                         else bs)
                | uu____18884 -> bs))
let (maybe_lift :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Ident.lident ->
        FStar_Ident.lident ->
          FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.term)
  =
  fun env ->
    fun e ->
      fun c1 ->
        fun c2 ->
          fun t ->
            let m1 = FStar_TypeChecker_Env.norm_eff_name env c1 in
            let m2 = FStar_TypeChecker_Env.norm_eff_name env c2 in
            let uu____18913 =
              ((FStar_Ident.lid_equals m1 m2) ||
                 ((FStar_Syntax_Util.is_pure_effect c1) &&
                    (FStar_Syntax_Util.is_ghost_effect c2)))
                ||
                ((FStar_Syntax_Util.is_pure_effect c2) &&
                   (FStar_Syntax_Util.is_ghost_effect c1)) in
            if uu____18913
            then e
            else
              FStar_Syntax_Syntax.mk
                (FStar_Syntax_Syntax.Tm_meta
                   (e, (FStar_Syntax_Syntax.Meta_monadic_lift (m1, m2, t))))
                e.FStar_Syntax_Syntax.pos
let (maybe_monadic :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Ident.lident ->
        FStar_Syntax_Syntax.typ -> FStar_Syntax_Syntax.term)
  =
  fun env ->
    fun e ->
      fun c ->
        fun t ->
          let m = FStar_TypeChecker_Env.norm_eff_name env c in
          let uu____18944 =
            ((is_pure_or_ghost_effect env m) ||
               (FStar_Ident.lid_equals m FStar_Parser_Const.effect_Tot_lid))
              ||
              (FStar_Ident.lid_equals m FStar_Parser_Const.effect_GTot_lid) in
          if uu____18944
          then e
          else
            FStar_Syntax_Syntax.mk
              (FStar_Syntax_Syntax.Tm_meta
                 (e, (FStar_Syntax_Syntax.Meta_monadic (m, t))))
              e.FStar_Syntax_Syntax.pos
let (d : Prims.string -> unit) =
  fun s -> FStar_Util.print1 "\027[01;36m%s\027[00m\n" s
let (mk_toplevel_definition :
  FStar_TypeChecker_Env.env ->
    FStar_Ident.lident ->
      FStar_Syntax_Syntax.term ->
        (FStar_Syntax_Syntax.sigelt * FStar_Syntax_Syntax.term))
  =
  fun env ->
    fun lident ->
      fun def ->
        (let uu____18987 =
           FStar_TypeChecker_Env.debug env (FStar_Options.Other "ED") in
         if uu____18987
         then
           ((let uu____18992 = FStar_Ident.string_of_lid lident in
             d uu____18992);
            (let uu____18994 = FStar_Ident.string_of_lid lident in
             let uu____18996 = FStar_Syntax_Print.term_to_string def in
             FStar_Util.print2 "Registering top-level definition: %s\n%s\n"
               uu____18994 uu____18996))
         else ());
        (let fv =
           let uu____19002 = FStar_Syntax_Util.incr_delta_qualifier def in
           FStar_Syntax_Syntax.lid_as_fv lident uu____19002
             FStar_Pervasives_Native.None in
         let lbname = FStar_Util.Inr fv in
         let lb =
           (false,
             [FStar_Syntax_Util.mk_letbinding lbname []
                FStar_Syntax_Syntax.tun FStar_Parser_Const.effect_Tot_lid def
                [] FStar_Range.dummyRange]) in
         let sig_ctx =
           FStar_Syntax_Syntax.mk_sigelt
             (FStar_Syntax_Syntax.Sig_let (lb, [lident])) in
         let uu____19014 =
           FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_fvar fv)
             FStar_Range.dummyRange in
         ((let uu___2176_19016 = sig_ctx in
           {
             FStar_Syntax_Syntax.sigel =
               (uu___2176_19016.FStar_Syntax_Syntax.sigel);
             FStar_Syntax_Syntax.sigrng =
               (uu___2176_19016.FStar_Syntax_Syntax.sigrng);
             FStar_Syntax_Syntax.sigquals =
               [FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen];
             FStar_Syntax_Syntax.sigmeta =
               (uu___2176_19016.FStar_Syntax_Syntax.sigmeta);
             FStar_Syntax_Syntax.sigattrs =
               (uu___2176_19016.FStar_Syntax_Syntax.sigattrs);
             FStar_Syntax_Syntax.sigopts =
               (uu___2176_19016.FStar_Syntax_Syntax.sigopts)
           }), uu____19014))
let (check_sigelt_quals :
  FStar_TypeChecker_Env.env -> FStar_Syntax_Syntax.sigelt -> unit) =
  fun env ->
    fun se ->
      let visibility uu___11_19034 =
        match uu___11_19034 with
        | FStar_Syntax_Syntax.Private -> true
        | uu____19037 -> false in
      let reducibility uu___12_19045 =
        match uu___12_19045 with
        | FStar_Syntax_Syntax.Abstract -> true
        | FStar_Syntax_Syntax.Irreducible -> true
        | FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen -> true
        | FStar_Syntax_Syntax.Visible_default -> true
        | FStar_Syntax_Syntax.Inline_for_extraction -> true
        | uu____19052 -> false in
      let assumption uu___13_19060 =
        match uu___13_19060 with
        | FStar_Syntax_Syntax.Assumption -> true
        | FStar_Syntax_Syntax.New -> true
        | uu____19064 -> false in
      let reification uu___14_19072 =
        match uu___14_19072 with
        | FStar_Syntax_Syntax.Reifiable -> true
        | FStar_Syntax_Syntax.Reflectable uu____19075 -> true
        | uu____19077 -> false in
      let inferred uu___15_19085 =
        match uu___15_19085 with
        | FStar_Syntax_Syntax.Discriminator uu____19087 -> true
        | FStar_Syntax_Syntax.Projector uu____19089 -> true
        | FStar_Syntax_Syntax.RecordType uu____19095 -> true
        | FStar_Syntax_Syntax.RecordConstructor uu____19105 -> true
        | FStar_Syntax_Syntax.ExceptionConstructor -> true
        | FStar_Syntax_Syntax.HasMaskedEffect -> true
        | FStar_Syntax_Syntax.Effect -> true
        | uu____19118 -> false in
      let has_eq uu___16_19126 =
        match uu___16_19126 with
        | FStar_Syntax_Syntax.Noeq -> true
        | FStar_Syntax_Syntax.Unopteq -> true
        | uu____19130 -> false in
      let quals_combo_ok quals q =
        match q with
        | FStar_Syntax_Syntax.Assumption ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    ((((((x = q) || (x = FStar_Syntax_Syntax.Logic)) ||
                          (inferred x))
                         || (visibility x))
                        || (assumption x))
                       ||
                       (env.FStar_TypeChecker_Env.is_iface &&
                          (x = FStar_Syntax_Syntax.Inline_for_extraction)))
                      || (x = FStar_Syntax_Syntax.NoExtract)))
        | FStar_Syntax_Syntax.New ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    (((x = q) || (inferred x)) || (visibility x)) ||
                      (assumption x)))
        | FStar_Syntax_Syntax.Inline_for_extraction ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    ((((((((x = q) || (x = FStar_Syntax_Syntax.Logic)) ||
                            (visibility x))
                           || (reducibility x))
                          || (reification x))
                         || (inferred x))
                        || (has_eq x))
                       ||
                       (env.FStar_TypeChecker_Env.is_iface &&
                          (x = FStar_Syntax_Syntax.Assumption)))
                      || (x = FStar_Syntax_Syntax.NoExtract)))
        | FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    ((((((((x = q) || (x = FStar_Syntax_Syntax.Logic)) ||
                            (x = FStar_Syntax_Syntax.Abstract))
                           || (x = FStar_Syntax_Syntax.Inline_for_extraction))
                          || (x = FStar_Syntax_Syntax.NoExtract))
                         || (has_eq x))
                        || (inferred x))
                       || (visibility x))
                      || (reification x)))
        | FStar_Syntax_Syntax.Visible_default ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    ((((((((x = q) || (x = FStar_Syntax_Syntax.Logic)) ||
                            (x = FStar_Syntax_Syntax.Abstract))
                           || (x = FStar_Syntax_Syntax.Inline_for_extraction))
                          || (x = FStar_Syntax_Syntax.NoExtract))
                         || (has_eq x))
                        || (inferred x))
                       || (visibility x))
                      || (reification x)))
        | FStar_Syntax_Syntax.Irreducible ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    ((((((((x = q) || (x = FStar_Syntax_Syntax.Logic)) ||
                            (x = FStar_Syntax_Syntax.Abstract))
                           || (x = FStar_Syntax_Syntax.Inline_for_extraction))
                          || (x = FStar_Syntax_Syntax.NoExtract))
                         || (has_eq x))
                        || (inferred x))
                       || (visibility x))
                      || (reification x)))
        | FStar_Syntax_Syntax.Abstract ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    ((((((((x = q) || (x = FStar_Syntax_Syntax.Logic)) ||
                            (x = FStar_Syntax_Syntax.Abstract))
                           || (x = FStar_Syntax_Syntax.Inline_for_extraction))
                          || (x = FStar_Syntax_Syntax.NoExtract))
                         || (has_eq x))
                        || (inferred x))
                       || (visibility x))
                      || (reification x)))
        | FStar_Syntax_Syntax.Noeq ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    ((((((((x = q) || (x = FStar_Syntax_Syntax.Logic)) ||
                            (x = FStar_Syntax_Syntax.Abstract))
                           || (x = FStar_Syntax_Syntax.Inline_for_extraction))
                          || (x = FStar_Syntax_Syntax.NoExtract))
                         || (has_eq x))
                        || (inferred x))
                       || (visibility x))
                      || (reification x)))
        | FStar_Syntax_Syntax.Unopteq ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    ((((((((x = q) || (x = FStar_Syntax_Syntax.Logic)) ||
                            (x = FStar_Syntax_Syntax.Abstract))
                           || (x = FStar_Syntax_Syntax.Inline_for_extraction))
                          || (x = FStar_Syntax_Syntax.NoExtract))
                         || (has_eq x))
                        || (inferred x))
                       || (visibility x))
                      || (reification x)))
        | FStar_Syntax_Syntax.TotalEffect ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    (((x = q) || (inferred x)) || (visibility x)) ||
                      (reification x)))
        | FStar_Syntax_Syntax.Logic ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    ((((x = q) || (x = FStar_Syntax_Syntax.Assumption)) ||
                        (inferred x))
                       || (visibility x))
                      || (reducibility x)))
        | FStar_Syntax_Syntax.Reifiable ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    ((((reification x) || (inferred x)) || (visibility x)) ||
                       (x = FStar_Syntax_Syntax.TotalEffect))
                      || (x = FStar_Syntax_Syntax.Visible_default)))
        | FStar_Syntax_Syntax.Reflectable uu____19209 ->
            FStar_All.pipe_right quals
              (FStar_List.for_all
                 (fun x ->
                    ((((reification x) || (inferred x)) || (visibility x)) ||
                       (x = FStar_Syntax_Syntax.TotalEffect))
                      || (x = FStar_Syntax_Syntax.Visible_default)))
        | FStar_Syntax_Syntax.Private -> true
        | uu____19216 -> true in
      let check_erasable quals se1 r =
        let lids = FStar_Syntax_Util.lids_of_sigelt se1 in
        let val_exists =
          FStar_All.pipe_right lids
            (FStar_Util.for_some
               (fun l ->
                  let uu____19249 =
                    FStar_TypeChecker_Env.try_lookup_val_decl env l in
                  FStar_Option.isSome uu____19249)) in
        let val_has_erasable_attr =
          FStar_All.pipe_right lids
            (FStar_Util.for_some
               (fun l ->
                  let attrs_opt =
                    FStar_TypeChecker_Env.lookup_attrs_of_lid env l in
                  (FStar_Option.isSome attrs_opt) &&
                    (let uu____19280 = FStar_Option.get attrs_opt in
                     FStar_Syntax_Util.has_attribute uu____19280
                       FStar_Parser_Const.erasable_attr))) in
        let se_has_erasable_attr =
          FStar_Syntax_Util.has_attribute se1.FStar_Syntax_Syntax.sigattrs
            FStar_Parser_Const.erasable_attr in
        if
          (val_exists && val_has_erasable_attr) &&
            (Prims.op_Negation se_has_erasable_attr)
        then
          FStar_Errors.raise_error
            (FStar_Errors.Fatal_QulifierListNotPermitted,
              "Mismatch of attributes between declaration and definition: Declaration is marked `erasable` but the definition is not")
            r
        else ();
        if
          (val_exists && (Prims.op_Negation val_has_erasable_attr)) &&
            se_has_erasable_attr
        then
          FStar_Errors.raise_error
            (FStar_Errors.Fatal_QulifierListNotPermitted,
              "Mismatch of attributed between declaration and definition: Definition is marked `erasable` but the declaration is not")
            r
        else ();
        if se_has_erasable_attr
        then
          (match se1.FStar_Syntax_Syntax.sigel with
           | FStar_Syntax_Syntax.Sig_bundle uu____19300 ->
               let uu____19309 =
                 let uu____19311 =
                   FStar_All.pipe_right quals
                     (FStar_Util.for_some
                        (fun uu___17_19317 ->
                           match uu___17_19317 with
                           | FStar_Syntax_Syntax.Noeq -> true
                           | uu____19320 -> false)) in
                 Prims.op_Negation uu____19311 in
               if uu____19309
               then
                 FStar_Errors.raise_error
                   (FStar_Errors.Fatal_QulifierListNotPermitted,
                     "Incompatible attributes and qualifiers: erasable types do not support decidable equality and must be marked `noeq`")
                   r
               else ()
           | FStar_Syntax_Syntax.Sig_declare_typ uu____19327 -> ()
           | FStar_Syntax_Syntax.Sig_fail uu____19334 -> ()
           | uu____19347 ->
               FStar_Errors.raise_error
                 (FStar_Errors.Fatal_QulifierListNotPermitted,
                   "Illegal attribute: the `erasable` attribute is only permitted on inductive type definitions")
                 r)
        else () in
      let quals =
        FStar_All.pipe_right (FStar_Syntax_Util.quals_of_sigelt se)
          (FStar_List.filter
             (fun x -> Prims.op_Negation (x = FStar_Syntax_Syntax.Logic))) in
      let uu____19361 =
        let uu____19363 =
          FStar_All.pipe_right quals
            (FStar_Util.for_some
               (fun uu___18_19369 ->
                  match uu___18_19369 with
                  | FStar_Syntax_Syntax.OnlyName -> true
                  | uu____19372 -> false)) in
        FStar_All.pipe_right uu____19363 Prims.op_Negation in
      if uu____19361
      then
        let r = FStar_Syntax_Util.range_of_sigelt se in
        let no_dup_quals =
          FStar_Util.remove_dups (fun x -> fun y -> x = y) quals in
        let err' msg =
          let uu____19393 =
            let uu____19399 =
              let uu____19401 = FStar_Syntax_Print.quals_to_string quals in
              FStar_Util.format2
                "The qualifier list \"[%s]\" is not permissible for this element%s"
                uu____19401 msg in
            (FStar_Errors.Fatal_QulifierListNotPermitted, uu____19399) in
          FStar_Errors.raise_error uu____19393 r in
        let err msg = err' (Prims.op_Hat ": " msg) in
        let err'1 uu____19419 = err' "" in
        (if (FStar_List.length quals) <> (FStar_List.length no_dup_quals)
         then err "duplicate qualifiers"
         else ();
         (let uu____19427 =
            let uu____19429 =
              FStar_All.pipe_right quals
                (FStar_List.for_all (quals_combo_ok quals)) in
            Prims.op_Negation uu____19429 in
          if uu____19427 then err "ill-formed combination" else ());
         check_erasable quals se r;
         (match se.FStar_Syntax_Syntax.sigel with
          | FStar_Syntax_Syntax.Sig_let ((is_rec, uu____19440), uu____19441)
              ->
              ((let uu____19453 =
                  is_rec &&
                    (FStar_All.pipe_right quals
                       (FStar_List.contains
                          FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen)) in
                if uu____19453
                then err "recursive definitions cannot be marked inline"
                else ());
               (let uu____19462 =
                  FStar_All.pipe_right quals
                    (FStar_Util.for_some
                       (fun x -> (assumption x) || (has_eq x))) in
                if uu____19462
                then
                  err
                    "definitions cannot be assumed or marked with equality qualifiers"
                else ()))
          | FStar_Syntax_Syntax.Sig_bundle uu____19473 ->
              ((let uu____19483 =
                  let uu____19485 =
                    FStar_All.pipe_right quals
                      (FStar_Util.for_all
                         (fun x ->
                            (((((x = FStar_Syntax_Syntax.Abstract) ||
                                  (x =
                                     FStar_Syntax_Syntax.Inline_for_extraction))
                                 || (x = FStar_Syntax_Syntax.NoExtract))
                                || (inferred x))
                               || (visibility x))
                              || (has_eq x))) in
                  Prims.op_Negation uu____19485 in
                if uu____19483 then err'1 () else ());
               (let uu____19495 =
                  (FStar_All.pipe_right quals
                     (FStar_List.existsb
                        (fun uu___19_19501 ->
                           match uu___19_19501 with
                           | FStar_Syntax_Syntax.Unopteq -> true
                           | uu____19504 -> false)))
                    &&
                    (FStar_Syntax_Util.has_attribute
                       se.FStar_Syntax_Syntax.sigattrs
                       FStar_Parser_Const.erasable_attr) in
                if uu____19495
                then
                  err
                    "unopteq is not allowed on an erasable inductives since they don't have decidable equality"
                else ()))
          | FStar_Syntax_Syntax.Sig_declare_typ uu____19510 ->
              let uu____19517 =
                FStar_All.pipe_right quals (FStar_Util.for_some has_eq) in
              if uu____19517 then err'1 () else ()
          | FStar_Syntax_Syntax.Sig_assume uu____19525 ->
              let uu____19532 =
                let uu____19534 =
                  FStar_All.pipe_right quals
                    (FStar_Util.for_all
                       (fun x ->
                          (visibility x) ||
                            (x = FStar_Syntax_Syntax.Assumption))) in
                Prims.op_Negation uu____19534 in
              if uu____19532 then err'1 () else ()
          | FStar_Syntax_Syntax.Sig_new_effect uu____19544 ->
              let uu____19545 =
                let uu____19547 =
                  FStar_All.pipe_right quals
                    (FStar_Util.for_all
                       (fun x ->
                          (((x = FStar_Syntax_Syntax.TotalEffect) ||
                              (inferred x))
                             || (visibility x))
                            || (reification x))) in
                Prims.op_Negation uu____19547 in
              if uu____19545 then err'1 () else ()
          | FStar_Syntax_Syntax.Sig_effect_abbrev uu____19557 ->
              let uu____19570 =
                let uu____19572 =
                  FStar_All.pipe_right quals
                    (FStar_Util.for_all
                       (fun x -> (inferred x) || (visibility x))) in
                Prims.op_Negation uu____19572 in
              if uu____19570 then err'1 () else ()
          | uu____19582 -> ()))
      else ()
let (must_erase_for_extraction :
  FStar_TypeChecker_Env.env -> FStar_Syntax_Syntax.term -> Prims.bool) =
  fun g ->
    fun t ->
      let rec descend env t1 =
        let uu____19621 =
          let uu____19622 = FStar_Syntax_Subst.compress t1 in
          uu____19622.FStar_Syntax_Syntax.n in
        match uu____19621 with
        | FStar_Syntax_Syntax.Tm_arrow uu____19626 ->
            let uu____19641 = FStar_Syntax_Util.arrow_formals_comp t1 in
            (match uu____19641 with
             | (bs, c) ->
                 let env1 = FStar_TypeChecker_Env.push_binders env bs in
                 (FStar_Syntax_Util.is_ghost_effect
                    (FStar_Syntax_Util.comp_effect_name c))
                   ||
                   ((FStar_Syntax_Util.is_pure_or_ghost_comp c) &&
                      (aux env1 (FStar_Syntax_Util.comp_result c))))
        | FStar_Syntax_Syntax.Tm_refine
            ({ FStar_Syntax_Syntax.ppname = uu____19650;
               FStar_Syntax_Syntax.index = uu____19651;
               FStar_Syntax_Syntax.sort = t2;_},
             uu____19653)
            -> aux env t2
        | FStar_Syntax_Syntax.Tm_app (head, uu____19662) -> descend env head
        | FStar_Syntax_Syntax.Tm_uinst (head, uu____19688) ->
            descend env head
        | FStar_Syntax_Syntax.Tm_fvar fv ->
            FStar_TypeChecker_Env.fv_has_attr env fv
              FStar_Parser_Const.must_erase_for_extraction_attr
        | uu____19694 -> false
      and aux env t1 =
        let t2 =
          FStar_TypeChecker_Normalize.normalize
            [FStar_TypeChecker_Env.Primops;
            FStar_TypeChecker_Env.Weak;
            FStar_TypeChecker_Env.HNF;
            FStar_TypeChecker_Env.UnfoldUntil
              FStar_Syntax_Syntax.delta_constant;
            FStar_TypeChecker_Env.Beta;
            FStar_TypeChecker_Env.AllowUnboundUniverses;
            FStar_TypeChecker_Env.Zeta;
            FStar_TypeChecker_Env.Iota;
            FStar_TypeChecker_Env.Unascribe] env t1 in
        let res =
          (FStar_TypeChecker_Env.non_informative env t2) || (descend env t2) in
        (let uu____19704 =
           FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
             (FStar_Options.Other "Extraction") in
         if uu____19704
         then
           let uu____19709 = FStar_Syntax_Print.term_to_string t2 in
           FStar_Util.print2 "must_erase=%s: %s\n"
             (if res then "true" else "false") uu____19709
         else ());
        res in
      aux g t
let (fresh_effect_repr :
  FStar_TypeChecker_Env.env ->
    FStar_Range.range ->
      FStar_Ident.lident ->
        FStar_Syntax_Syntax.tscheme ->
          FStar_Syntax_Syntax.tscheme FStar_Pervasives_Native.option ->
            FStar_Syntax_Syntax.universe ->
              FStar_Syntax_Syntax.term ->
                (FStar_Syntax_Syntax.term * FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun r ->
      fun eff_name ->
        fun signature_ts ->
          fun repr_ts_opt ->
            fun u ->
              fun a_tm ->
                let fail t =
                  let uu____19774 =
                    FStar_TypeChecker_Err.unexpected_signature_for_monad env
                      eff_name t in
                  FStar_Errors.raise_error uu____19774 r in
                let uu____19784 =
                  FStar_TypeChecker_Env.inst_tscheme signature_ts in
                match uu____19784 with
                | (uu____19793, signature) ->
                    let uu____19795 =
                      let uu____19796 = FStar_Syntax_Subst.compress signature in
                      uu____19796.FStar_Syntax_Syntax.n in
                    (match uu____19795 with
                     | FStar_Syntax_Syntax.Tm_arrow (bs, uu____19804) ->
                         let bs1 = FStar_Syntax_Subst.open_binders bs in
                         (match bs1 with
                          | a::bs2 ->
                              let uu____19852 =
                                FStar_TypeChecker_Env.uvars_for_binders env
                                  bs2
                                  [FStar_Syntax_Syntax.NT
                                     ((FStar_Pervasives_Native.fst a), a_tm)]
                                  (fun b ->
                                     let uu____19868 =
                                       FStar_Syntax_Print.binder_to_string b in
                                     let uu____19870 =
                                       FStar_Ident.string_of_lid eff_name in
                                     let uu____19872 =
                                       FStar_Range.string_of_range r in
                                     FStar_Util.format3
                                       "uvar for binder %s when creating a fresh repr for %s at %s"
                                       uu____19868 uu____19870 uu____19872) r in
                              (match uu____19852 with
                               | (is, g) ->
                                   let uu____19885 =
                                     match repr_ts_opt with
                                     | FStar_Pervasives_Native.None ->
                                         let eff_c =
                                           let uu____19887 =
                                             let uu____19888 =
                                               FStar_List.map
                                                 FStar_Syntax_Syntax.as_arg
                                                 is in
                                             {
                                               FStar_Syntax_Syntax.comp_univs
                                                 = [u];
                                               FStar_Syntax_Syntax.effect_name
                                                 = eff_name;
                                               FStar_Syntax_Syntax.result_typ
                                                 = a_tm;
                                               FStar_Syntax_Syntax.effect_args
                                                 = uu____19888;
                                               FStar_Syntax_Syntax.flags = []
                                             } in
                                           FStar_Syntax_Syntax.mk_Comp
                                             uu____19887 in
                                         let uu____19907 =
                                           let uu____19908 =
                                             let uu____19923 =
                                               let uu____19932 =
                                                 FStar_Syntax_Syntax.null_binder
                                                   FStar_Syntax_Syntax.t_unit in
                                               [uu____19932] in
                                             (uu____19923, eff_c) in
                                           FStar_Syntax_Syntax.Tm_arrow
                                             uu____19908 in
                                         FStar_Syntax_Syntax.mk uu____19907 r
                                     | FStar_Pervasives_Native.Some repr_ts
                                         ->
                                         let repr =
                                           let uu____19963 =
                                             FStar_TypeChecker_Env.inst_tscheme_with
                                               repr_ts [u] in
                                           FStar_All.pipe_right uu____19963
                                             FStar_Pervasives_Native.snd in
                                         let uu____19972 =
                                           FStar_List.map
                                             FStar_Syntax_Syntax.as_arg (a_tm
                                             :: is) in
                                         FStar_Syntax_Syntax.mk_Tm_app repr
                                           uu____19972 r in
                                   (uu____19885, g))
                          | uu____19981 -> fail signature)
                     | uu____19982 -> fail signature)
let (fresh_effect_repr_en :
  FStar_TypeChecker_Env.env ->
    FStar_Range.range ->
      FStar_Ident.lident ->
        FStar_Syntax_Syntax.universe ->
          FStar_Syntax_Syntax.term ->
            (FStar_Syntax_Syntax.term * FStar_TypeChecker_Common.guard_t))
  =
  fun env ->
    fun r ->
      fun eff_name ->
        fun u ->
          fun a_tm ->
            let uu____20013 =
              FStar_All.pipe_right eff_name
                (FStar_TypeChecker_Env.get_effect_decl env) in
            FStar_All.pipe_right uu____20013
              (fun ed ->
                 let uu____20021 =
                   FStar_All.pipe_right ed FStar_Syntax_Util.get_eff_repr in
                 fresh_effect_repr env r eff_name
                   ed.FStar_Syntax_Syntax.signature uu____20021 u a_tm)
let (layered_effect_indices_as_binders :
  FStar_TypeChecker_Env.env ->
    FStar_Range.range ->
      FStar_Ident.lident ->
        FStar_Syntax_Syntax.tscheme ->
          FStar_Syntax_Syntax.universe ->
            FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.binders)
  =
  fun env ->
    fun r ->
      fun eff_name ->
        fun sig_ts ->
          fun u ->
            fun a_tm ->
              let uu____20057 =
                FStar_TypeChecker_Env.inst_tscheme_with sig_ts [u] in
              match uu____20057 with
              | (uu____20062, sig_tm) ->
                  let fail t =
                    let uu____20070 =
                      FStar_TypeChecker_Err.unexpected_signature_for_monad
                        env eff_name t in
                    FStar_Errors.raise_error uu____20070 r in
                  let uu____20076 =
                    let uu____20077 = FStar_Syntax_Subst.compress sig_tm in
                    uu____20077.FStar_Syntax_Syntax.n in
                  (match uu____20076 with
                   | FStar_Syntax_Syntax.Tm_arrow (bs, uu____20081) ->
                       let bs1 = FStar_Syntax_Subst.open_binders bs in
                       (match bs1 with
                        | (a', uu____20104)::bs2 ->
                            FStar_All.pipe_right bs2
                              (FStar_Syntax_Subst.subst_binders
                                 [FStar_Syntax_Syntax.NT (a', a_tm)])
                        | uu____20126 -> fail sig_tm)
                   | uu____20127 -> fail sig_tm)
let (lift_tf_layered_effect :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.tscheme ->
      FStar_TypeChecker_Env.env ->
        FStar_Syntax_Syntax.comp ->
          (FStar_Syntax_Syntax.comp * FStar_TypeChecker_Common.guard_t))
  =
  fun tgt ->
    fun lift_ts ->
      fun env ->
        fun c ->
          (let uu____20158 =
             FStar_All.pipe_left (FStar_TypeChecker_Env.debug env)
               (FStar_Options.Other "LayeredEffects") in
           if uu____20158
           then
             let uu____20163 = FStar_Syntax_Print.comp_to_string c in
             let uu____20165 = FStar_Syntax_Print.lid_to_string tgt in
             FStar_Util.print2 "Lifting comp %s to layered effect %s {\n"
               uu____20163 uu____20165
           else ());
          (let r = FStar_TypeChecker_Env.get_range env in
           let ct = FStar_Syntax_Util.comp_to_comp_typ c in
           let uu____20172 =
             let uu____20183 =
               FStar_List.hd ct.FStar_Syntax_Syntax.comp_univs in
             let uu____20184 =
               FStar_All.pipe_right ct.FStar_Syntax_Syntax.effect_args
                 (FStar_List.map FStar_Pervasives_Native.fst) in
             (uu____20183, (ct.FStar_Syntax_Syntax.result_typ), uu____20184) in
           match uu____20172 with
           | (u, a, c_is) ->
               let uu____20232 =
                 FStar_TypeChecker_Env.inst_tscheme_with lift_ts [u] in
               (match uu____20232 with
                | (uu____20241, lift_t) ->
                    let lift_t_shape_error s =
                      let uu____20252 =
                        FStar_Ident.string_of_lid
                          ct.FStar_Syntax_Syntax.effect_name in
                      let uu____20254 = FStar_Ident.string_of_lid tgt in
                      let uu____20256 =
                        FStar_Syntax_Print.term_to_string lift_t in
                      FStar_Util.format4
                        "Lift from %s to %s has unexpected shape, reason: %s (lift:%s)"
                        uu____20252 uu____20254 s uu____20256 in
                    let uu____20259 =
                      let uu____20292 =
                        let uu____20293 = FStar_Syntax_Subst.compress lift_t in
                        uu____20293.FStar_Syntax_Syntax.n in
                      match uu____20292 with
                      | FStar_Syntax_Syntax.Tm_arrow (bs, c1) when
                          (FStar_List.length bs) >= (Prims.of_int (2)) ->
                          let uu____20357 =
                            FStar_Syntax_Subst.open_comp bs c1 in
                          (match uu____20357 with
                           | (a_b::bs1, c2) ->
                               let uu____20417 =
                                 FStar_All.pipe_right bs1
                                   (FStar_List.splitAt
                                      ((FStar_List.length bs1) -
                                         Prims.int_one)) in
                               (a_b, uu____20417, c2))
                      | uu____20505 ->
                          let uu____20506 =
                            let uu____20512 =
                              lift_t_shape_error
                                "either not an arrow or not enough binders" in
                            (FStar_Errors.Fatal_UnexpectedEffect,
                              uu____20512) in
                          FStar_Errors.raise_error uu____20506 r in
                    (match uu____20259 with
                     | (a_b, (rest_bs, f_b::[]), lift_c) ->
                         let uu____20630 =
                           let uu____20637 =
                             let uu____20638 =
                               let uu____20639 =
                                 let uu____20646 =
                                   FStar_All.pipe_right a_b
                                     FStar_Pervasives_Native.fst in
                                 (uu____20646, a) in
                               FStar_Syntax_Syntax.NT uu____20639 in
                             [uu____20638] in
                           FStar_TypeChecker_Env.uvars_for_binders env
                             rest_bs uu____20637
                             (fun b ->
                                let uu____20663 =
                                  FStar_Syntax_Print.binder_to_string b in
                                let uu____20665 =
                                  FStar_Ident.string_of_lid
                                    ct.FStar_Syntax_Syntax.effect_name in
                                let uu____20667 =
                                  FStar_Ident.string_of_lid tgt in
                                let uu____20669 =
                                  FStar_Range.string_of_range r in
                                FStar_Util.format4
                                  "implicit var for binder %s of %s~>%s at %s"
                                  uu____20663 uu____20665 uu____20667
                                  uu____20669) r in
                         (match uu____20630 with
                          | (rest_bs_uvars, g) ->
                              ((let uu____20683 =
                                  FStar_All.pipe_left
                                    (FStar_TypeChecker_Env.debug env)
                                    (FStar_Options.Other "LayeredEffects") in
                                if uu____20683
                                then
                                  let uu____20688 =
                                    FStar_List.fold_left
                                      (fun s ->
                                         fun u1 ->
                                           let uu____20697 =
                                             let uu____20699 =
                                               FStar_Syntax_Print.term_to_string
                                                 u1 in
                                             Prims.op_Hat ";;;;" uu____20699 in
                                           Prims.op_Hat s uu____20697) ""
                                      rest_bs_uvars in
                                  FStar_Util.print1 "Introduced uvars: %s\n"
                                    uu____20688
                                else ());
                               (let substs =
                                  FStar_List.map2
                                    (fun b ->
                                       fun t ->
                                         let uu____20730 =
                                           let uu____20737 =
                                             FStar_All.pipe_right b
                                               FStar_Pervasives_Native.fst in
                                           (uu____20737, t) in
                                         FStar_Syntax_Syntax.NT uu____20730)
                                    (a_b :: rest_bs) (a :: rest_bs_uvars) in
                                let guard_f =
                                  let f_sort =
                                    let uu____20756 =
                                      FStar_All.pipe_right
                                        (FStar_Pervasives_Native.fst f_b).FStar_Syntax_Syntax.sort
                                        (FStar_Syntax_Subst.subst substs) in
                                    FStar_All.pipe_right uu____20756
                                      FStar_Syntax_Subst.compress in
                                  let f_sort_is =
                                    let uu____20762 =
                                      FStar_TypeChecker_Env.is_layered_effect
                                        env
                                        ct.FStar_Syntax_Syntax.effect_name in
                                    effect_args_from_repr f_sort uu____20762
                                      r in
                                  FStar_List.fold_left2
                                    (fun g1 ->
                                       fun i1 ->
                                         fun i2 ->
                                           let uu____20771 =
                                             FStar_TypeChecker_Rel.teq env i1
                                               i2 in
                                           FStar_TypeChecker_Env.conj_guard
                                             g1 uu____20771)
                                    FStar_TypeChecker_Env.trivial_guard c_is
                                    f_sort_is in
                                let lift_ct =
                                  let uu____20773 =
                                    FStar_All.pipe_right lift_c
                                      (FStar_Syntax_Subst.subst_comp substs) in
                                  FStar_All.pipe_right uu____20773
                                    FStar_Syntax_Util.comp_to_comp_typ in
                                let is =
                                  let uu____20777 =
                                    FStar_TypeChecker_Env.is_layered_effect
                                      env tgt in
                                  effect_args_from_repr
                                    lift_ct.FStar_Syntax_Syntax.result_typ
                                    uu____20777 r in
                                let fml =
                                  let uu____20782 =
                                    let uu____20787 =
                                      FStar_List.hd
                                        lift_ct.FStar_Syntax_Syntax.comp_univs in
                                    let uu____20788 =
                                      let uu____20789 =
                                        FStar_List.hd
                                          lift_ct.FStar_Syntax_Syntax.effect_args in
                                      FStar_Pervasives_Native.fst uu____20789 in
                                    (uu____20787, uu____20788) in
                                  match uu____20782 with
                                  | (u1, wp) ->
                                      FStar_TypeChecker_Env.pure_precondition_for_trivial_post
                                        env u1
                                        lift_ct.FStar_Syntax_Syntax.result_typ
                                        wp FStar_Range.dummyRange in
                                (let uu____20815 =
                                   (FStar_All.pipe_left
                                      (FStar_TypeChecker_Env.debug env)
                                      (FStar_Options.Other "LayeredEffects"))
                                     &&
                                     (FStar_All.pipe_left
                                        (FStar_TypeChecker_Env.debug env)
                                        FStar_Options.Extreme) in
                                 if uu____20815
                                 then
                                   let uu____20821 =
                                     FStar_Syntax_Print.term_to_string fml in
                                   FStar_Util.print1 "Guard for lift is: %s"
                                     uu____20821
                                 else ());
                                (let c1 =
                                   let uu____20827 =
                                     let uu____20828 =
                                       FStar_All.pipe_right is
                                         (FStar_List.map
                                            FStar_Syntax_Syntax.as_arg) in
                                     {
                                       FStar_Syntax_Syntax.comp_univs =
                                         (lift_ct.FStar_Syntax_Syntax.comp_univs);
                                       FStar_Syntax_Syntax.effect_name = tgt;
                                       FStar_Syntax_Syntax.result_typ = a;
                                       FStar_Syntax_Syntax.effect_args =
                                         uu____20828;
                                       FStar_Syntax_Syntax.flags = []
                                     } in
                                   FStar_Syntax_Syntax.mk_Comp uu____20827 in
                                 (let uu____20852 =
                                    FStar_All.pipe_left
                                      (FStar_TypeChecker_Env.debug env)
                                      (FStar_Options.Other "LayeredEffects") in
                                  if uu____20852
                                  then
                                    let uu____20857 =
                                      FStar_Syntax_Print.comp_to_string c1 in
                                    FStar_Util.print1 "} Lifted comp: %s\n"
                                      uu____20857
                                  else ());
                                 (let uu____20862 =
                                    let uu____20863 =
                                      FStar_TypeChecker_Env.conj_guard g
                                        guard_f in
                                    let uu____20864 =
                                      FStar_TypeChecker_Env.guard_of_guard_formula
                                        (FStar_TypeChecker_Common.NonTrivial
                                           fml) in
                                    FStar_TypeChecker_Env.conj_guard
                                      uu____20863 uu____20864 in
                                  (c1, uu____20862)))))))))
let lift_tf_layered_effect_term :
  'uuuuuu20878 .
    'uuuuuu20878 ->
      FStar_Syntax_Syntax.sub_eff ->
        FStar_Syntax_Syntax.universe ->
          FStar_Syntax_Syntax.typ ->
            FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term
  =
  fun env ->
    fun sub ->
      fun u ->
        fun a ->
          fun e ->
            let lift =
              let uu____20907 =
                let uu____20912 =
                  FStar_All.pipe_right sub.FStar_Syntax_Syntax.lift
                    FStar_Util.must in
                FStar_All.pipe_right uu____20912
                  (fun ts -> FStar_TypeChecker_Env.inst_tscheme_with ts [u]) in
              FStar_All.pipe_right uu____20907 FStar_Pervasives_Native.snd in
            let rest_bs =
              let lift_t =
                FStar_All.pipe_right sub.FStar_Syntax_Syntax.lift_wp
                  FStar_Util.must in
              let uu____20955 =
                let uu____20956 =
                  let uu____20959 =
                    FStar_All.pipe_right lift_t FStar_Pervasives_Native.snd in
                  FStar_All.pipe_right uu____20959
                    FStar_Syntax_Subst.compress in
                uu____20956.FStar_Syntax_Syntax.n in
              match uu____20955 with
              | FStar_Syntax_Syntax.Tm_arrow (uu____20982::bs, uu____20984)
                  when (FStar_List.length bs) >= Prims.int_one ->
                  let uu____21024 =
                    FStar_All.pipe_right bs
                      (FStar_List.splitAt
                         ((FStar_List.length bs) - Prims.int_one)) in
                  FStar_All.pipe_right uu____21024
                    FStar_Pervasives_Native.fst
              | uu____21130 ->
                  let uu____21131 =
                    let uu____21137 =
                      let uu____21139 =
                        FStar_Syntax_Print.tscheme_to_string lift_t in
                      FStar_Util.format1
                        "lift_t tscheme %s is not an arrow with enough binders"
                        uu____21139 in
                    (FStar_Errors.Fatal_UnexpectedEffect, uu____21137) in
                  FStar_Errors.raise_error uu____21131
                    (FStar_Pervasives_Native.snd lift_t).FStar_Syntax_Syntax.pos in
            let args =
              let uu____21166 = FStar_Syntax_Syntax.as_arg a in
              let uu____21175 =
                let uu____21186 =
                  FStar_All.pipe_right rest_bs
                    (FStar_List.map
                       (fun uu____21222 ->
                          FStar_Syntax_Syntax.as_arg
                            FStar_Syntax_Syntax.unit_const)) in
                let uu____21229 =
                  let uu____21240 = FStar_Syntax_Syntax.as_arg e in
                  [uu____21240] in
                FStar_List.append uu____21186 uu____21229 in
              uu____21166 :: uu____21175 in
            FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_app (lift, args))
              e.FStar_Syntax_Syntax.pos
let (get_field_projector_name :
  FStar_TypeChecker_Env.env ->
    FStar_Ident.lident -> Prims.int -> FStar_Ident.lident)
  =
  fun env ->
    fun datacon ->
      fun index ->
        let uu____21311 = FStar_TypeChecker_Env.lookup_datacon env datacon in
        match uu____21311 with
        | (uu____21316, t) ->
            let err n =
              let uu____21326 =
                let uu____21332 =
                  let uu____21334 = FStar_Ident.string_of_lid datacon in
                  let uu____21336 = FStar_Util.string_of_int n in
                  let uu____21338 = FStar_Util.string_of_int index in
                  FStar_Util.format3
                    "Data constructor %s does not have enough binders (has %s, tried %s)"
                    uu____21334 uu____21336 uu____21338 in
                (FStar_Errors.Fatal_UnexpectedDataConstructor, uu____21332) in
              let uu____21342 = FStar_TypeChecker_Env.get_range env in
              FStar_Errors.raise_error uu____21326 uu____21342 in
            let uu____21343 =
              let uu____21344 = FStar_Syntax_Subst.compress t in
              uu____21344.FStar_Syntax_Syntax.n in
            (match uu____21343 with
             | FStar_Syntax_Syntax.Tm_arrow (bs, uu____21348) ->
                 let bs1 =
                   FStar_All.pipe_right bs
                     (FStar_List.filter
                        (fun uu____21403 ->
                           match uu____21403 with
                           | (uu____21411, q) ->
                               (match q with
                                | FStar_Pervasives_Native.Some
                                    (FStar_Syntax_Syntax.Implicit (true)) ->
                                    false
                                | uu____21420 -> true))) in
                 if (FStar_List.length bs1) <= index
                 then err (FStar_List.length bs1)
                 else
                   (let b = FStar_List.nth bs1 index in
                    FStar_Syntax_Util.mk_field_projector_name datacon
                      (FStar_Pervasives_Native.fst b) index)
             | uu____21454 -> err Prims.int_zero)
let (get_mlift_for_subeff :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.sub_eff -> FStar_TypeChecker_Env.mlift)
  =
  fun env ->
    fun sub ->
      let uu____21467 =
        (FStar_TypeChecker_Env.is_layered_effect env
           sub.FStar_Syntax_Syntax.source)
          ||
          (FStar_TypeChecker_Env.is_layered_effect env
             sub.FStar_Syntax_Syntax.target) in
      if uu____21467
      then
        let uu____21470 =
          let uu____21483 =
            FStar_All.pipe_right sub.FStar_Syntax_Syntax.lift_wp
              FStar_Util.must in
          lift_tf_layered_effect sub.FStar_Syntax_Syntax.target uu____21483 in
        {
          FStar_TypeChecker_Env.mlift_wp = uu____21470;
          FStar_TypeChecker_Env.mlift_term =
            (FStar_Pervasives_Native.Some
               (lift_tf_layered_effect_term env sub))
        }
      else
        (let mk_mlift_wp ts env1 c =
           let ct = FStar_Syntax_Util.comp_to_comp_typ c in
           let uu____21518 =
             FStar_TypeChecker_Env.inst_tscheme_with ts
               ct.FStar_Syntax_Syntax.comp_univs in
           match uu____21518 with
           | (uu____21527, lift_t) ->
               let wp = FStar_List.hd ct.FStar_Syntax_Syntax.effect_args in
               let uu____21546 =
                 let uu____21547 =
                   let uu___2552_21548 = ct in
                   let uu____21549 =
                     let uu____21560 =
                       let uu____21569 =
                         let uu____21570 =
                           let uu____21571 =
                             let uu____21588 =
                               let uu____21599 =
                                 FStar_Syntax_Syntax.as_arg
                                   ct.FStar_Syntax_Syntax.result_typ in
                               [uu____21599; wp] in
                             (lift_t, uu____21588) in
                           FStar_Syntax_Syntax.Tm_app uu____21571 in
                         FStar_Syntax_Syntax.mk uu____21570
                           (FStar_Pervasives_Native.fst wp).FStar_Syntax_Syntax.pos in
                       FStar_All.pipe_right uu____21569
                         FStar_Syntax_Syntax.as_arg in
                     [uu____21560] in
                   {
                     FStar_Syntax_Syntax.comp_univs =
                       (uu___2552_21548.FStar_Syntax_Syntax.comp_univs);
                     FStar_Syntax_Syntax.effect_name =
                       (sub.FStar_Syntax_Syntax.target);
                     FStar_Syntax_Syntax.result_typ =
                       (uu___2552_21548.FStar_Syntax_Syntax.result_typ);
                     FStar_Syntax_Syntax.effect_args = uu____21549;
                     FStar_Syntax_Syntax.flags =
                       (uu___2552_21548.FStar_Syntax_Syntax.flags)
                   } in
                 FStar_Syntax_Syntax.mk_Comp uu____21547 in
               (uu____21546, FStar_TypeChecker_Common.trivial_guard) in
         let mk_mlift_term ts u r e =
           let uu____21699 = FStar_TypeChecker_Env.inst_tscheme_with ts [u] in
           match uu____21699 with
           | (uu____21706, lift_t) ->
               let uu____21708 =
                 let uu____21709 =
                   let uu____21726 =
                     let uu____21737 = FStar_Syntax_Syntax.as_arg r in
                     let uu____21746 =
                       let uu____21757 =
                         FStar_Syntax_Syntax.as_arg FStar_Syntax_Syntax.tun in
                       let uu____21766 =
                         let uu____21777 = FStar_Syntax_Syntax.as_arg e in
                         [uu____21777] in
                       uu____21757 :: uu____21766 in
                     uu____21737 :: uu____21746 in
                   (lift_t, uu____21726) in
                 FStar_Syntax_Syntax.Tm_app uu____21709 in
               FStar_Syntax_Syntax.mk uu____21708 e.FStar_Syntax_Syntax.pos in
         let uu____21830 =
           let uu____21843 =
             FStar_All.pipe_right sub.FStar_Syntax_Syntax.lift_wp
               FStar_Util.must in
           FStar_All.pipe_right uu____21843 mk_mlift_wp in
         {
           FStar_TypeChecker_Env.mlift_wp = uu____21830;
           FStar_TypeChecker_Env.mlift_term =
             (match sub.FStar_Syntax_Syntax.lift with
              | FStar_Pervasives_Native.None ->
                  FStar_Pervasives_Native.Some
                    ((fun uu____21879 ->
                        fun uu____21880 -> fun e -> FStar_Util.return_all e))
              | FStar_Pervasives_Native.Some ts ->
                  FStar_Pervasives_Native.Some (mk_mlift_term ts))
         })
let (update_env_sub_eff :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.sub_eff -> FStar_TypeChecker_Env.env)
  =
  fun env ->
    fun sub ->
      let uu____21903 = get_mlift_for_subeff env sub in
      FStar_TypeChecker_Env.update_effect_lattice env
        sub.FStar_Syntax_Syntax.source sub.FStar_Syntax_Syntax.target
        uu____21903
let (update_env_polymonadic_bind :
  FStar_TypeChecker_Env.env ->
    FStar_Ident.lident ->
      FStar_Ident.lident ->
        FStar_Ident.lident ->
          FStar_Syntax_Syntax.tscheme -> FStar_TypeChecker_Env.env)
  =
  fun env ->
    fun m ->
      fun n ->
        fun p ->
          fun ty ->
            FStar_TypeChecker_Env.add_polymonadic_bind env m n p
              (fun env1 ->
                 fun c1 ->
                   fun bv_opt ->
                     fun c2 ->
                       fun flags ->
                         fun r ->
                           mk_indexed_bind env1 m n p ty c1 bv_opt c2 flags r)