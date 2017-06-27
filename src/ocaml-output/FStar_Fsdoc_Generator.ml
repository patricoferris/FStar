open Prims
let one_toplevel :
  FStar_Parser_AST.decl Prims.list ->
    (FStar_Parser_AST.decl,FStar_Parser_AST.decl Prims.list)
      FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option
  =
  fun decls  ->
    let uu____11 =
      FStar_List.partition
        (fun d  ->
           match d.FStar_Parser_AST.d with
           | FStar_Parser_AST.TopLevelModule uu____19 -> true
           | uu____20 -> false) decls
       in
    match uu____11 with
    | (top,nontops) ->
        (match top with
         | t::[] -> FStar_Pervasives_Native.Some (t, nontops)
         | uu____40 -> FStar_Pervasives_Native.None)
  
type mforest =
  | Leaf of (Prims.string,Prims.string) FStar_Pervasives_Native.tuple2 
  | Branch of mforest FStar_Util.smap 
let uu___is_Leaf : mforest -> Prims.bool =
  fun projectee  ->
    match projectee with | Leaf _0 -> true | uu____63 -> false
  
let __proj__Leaf__item___0 :
  mforest -> (Prims.string,Prims.string) FStar_Pervasives_Native.tuple2 =
  fun projectee  -> match projectee with | Leaf _0 -> _0 
let uu___is_Branch : mforest -> Prims.bool =
  fun projectee  ->
    match projectee with | Branch _0 -> true | uu____84 -> false
  
let __proj__Branch__item___0 : mforest -> mforest FStar_Util.smap =
  fun projectee  -> match projectee with | Branch _0 -> _0 
let htree : mforest FStar_Util.smap =
  FStar_Util.smap_create (Prims.parse_int "50") 
let string_of_optiont f y xo =
  match xo with
  | FStar_Pervasives_Native.Some x -> f x
  | FStar_Pervasives_Native.None  -> y 
let string_of_fsdoco :
  (Prims.string,(Prims.string,Prims.string) FStar_Pervasives_Native.tuple2
                  Prims.list)
    FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option ->
    Prims.string
  =
  fun d  ->
    string_of_optiont
      (fun x  ->
         let uu____158 =
           let uu____159 = FStar_Parser_AST.string_of_fsdoc x  in
           Prims.strcat uu____159 "*)"  in
         Prims.strcat "(*" uu____158) "" d
  
let string_of_termo :
  FStar_Parser_AST.term FStar_Pervasives_Native.option -> Prims.string =
  fun t  -> string_of_optiont FStar_Parser_AST.term_to_string "" t 
let code_wrap : Prims.string -> Prims.string =
  fun s  -> Prims.strcat "```fsharp\n" (Prims.strcat s "\n```\n") 
let string_of_tycon : FStar_Parser_AST.tycon -> Prims.string =
  fun tycon  ->
    match tycon with
    | FStar_Parser_AST.TyconAbstract uu____174 -> "abstract"
    | FStar_Parser_AST.TyconAbbrev uu____180 -> "abbrev"
    | FStar_Parser_AST.TyconRecord (id,_bb,_ko,fields) ->
        let uu____205 =
          let uu____206 =
            let uu____207 =
              let uu____208 =
                FStar_All.pipe_right fields
                  (FStar_List.map
                     (fun uu____231  ->
                        match uu____231 with
                        | (id1,t,doco) ->
                            let uu____256 = string_of_fsdoco doco  in
                            let uu____257 =
                              let uu____258 =
                                let uu____259 =
                                  FStar_Parser_AST.term_to_string t  in
                                Prims.strcat ":" uu____259  in
                              Prims.strcat id1.FStar_Ident.idText uu____258
                               in
                            Prims.strcat uu____256 uu____257))
                 in
              FStar_All.pipe_right uu____208 (FStar_String.concat "; ")  in
            Prims.strcat uu____207 " }"  in
          Prims.strcat " = { " uu____206  in
        Prims.strcat id.FStar_Ident.idText uu____205
    | FStar_Parser_AST.TyconVariant (id,_bb,_ko,vars) ->
        let uu____283 =
          let uu____284 =
            let uu____285 =
              FStar_All.pipe_right vars
                (FStar_List.map
                   (fun uu____313  ->
                      match uu____313 with
                      | (id1,trmo,doco,u) ->
                          let uu____343 = string_of_fsdoco doco  in
                          let uu____344 =
                            let uu____345 =
                              let uu____346 =
                                string_of_optiont
                                  FStar_Parser_AST.term_to_string "" trmo
                                 in
                              Prims.strcat ":" uu____346  in
                            Prims.strcat id1.FStar_Ident.idText uu____345  in
                          Prims.strcat uu____343 uu____344))
               in
            FStar_All.pipe_right uu____285 (FStar_String.concat " | ")  in
          Prims.strcat " = " uu____284  in
        Prims.strcat id.FStar_Ident.idText uu____283
  
let string_of_decl' : FStar_Parser_AST.decl' -> Prims.string =
  fun d  ->
    match d with
    | FStar_Parser_AST.TopLevelModule l ->
        Prims.strcat "module " l.FStar_Ident.str
    | FStar_Parser_AST.Open l -> Prims.strcat "open " l.FStar_Ident.str
    | FStar_Parser_AST.Include l -> Prims.strcat "include " l.FStar_Ident.str
    | FStar_Parser_AST.ModuleAbbrev (i,l) ->
        Prims.strcat "module "
          (Prims.strcat i.FStar_Ident.idText
             (Prims.strcat " = " l.FStar_Ident.str))
    | FStar_Parser_AST.TopLevelLet (uu____357,pats) ->
        let termty =
          FStar_List.map
            (fun uu____378  ->
               match uu____378 with
               | (p,t) ->
                   let uu____385 = FStar_Parser_AST.pat_to_string p  in
                   let uu____386 = FStar_Parser_AST.term_to_string t  in
                   (uu____385, uu____386)) pats
           in
        let termty' =
          FStar_List.map
            (fun uu____394  ->
               match uu____394 with
               | (p,t) -> Prims.strcat p (Prims.strcat ":" t)) termty
           in
        Prims.strcat "let " (FStar_String.concat ", " termty')
    | FStar_Parser_AST.Main uu____399 -> "main ..."
    | FStar_Parser_AST.Assume (i,t) ->
        let uu____402 =
          let uu____403 =
            let uu____404 = FStar_Parser_AST.term_to_string t  in
            Prims.strcat ":" uu____404  in
          Prims.strcat i.FStar_Ident.idText uu____403  in
        Prims.strcat "assume " uu____402
    | FStar_Parser_AST.Tycon (uu____405,tys) ->
        let uu____415 =
          let uu____416 =
            FStar_All.pipe_right tys
              (FStar_List.map
                 (fun uu____436  ->
                    match uu____436 with
                    | (t,d1) ->
                        let uu____459 = string_of_tycon t  in
                        let uu____460 =
                          let uu____461 = string_of_fsdoco d1  in
                          Prims.strcat " " uu____461  in
                        Prims.strcat uu____459 uu____460))
             in
          FStar_All.pipe_right uu____416 (FStar_String.concat " and ")  in
        Prims.strcat "type " uu____415
    | FStar_Parser_AST.Val (i,t) ->
        let uu____465 =
          let uu____466 =
            let uu____467 = FStar_Parser_AST.term_to_string t  in
            Prims.strcat ":" uu____467  in
          Prims.strcat i.FStar_Ident.idText uu____466  in
        Prims.strcat "val " uu____465
    | FStar_Parser_AST.Exception (i,uu____469) ->
        Prims.strcat "exception " i.FStar_Ident.idText
    | FStar_Parser_AST.NewEffect (FStar_Parser_AST.DefineEffect
        (i,uu____473,uu____474,uu____475)) ->
        Prims.strcat "new_effect " i.FStar_Ident.idText
    | FStar_Parser_AST.NewEffect (FStar_Parser_AST.RedefineEffect
        (i,uu____481,uu____482)) ->
        Prims.strcat "new_effect " i.FStar_Ident.idText
    | FStar_Parser_AST.SubEffect uu____485 -> "sub_effect"
    | FStar_Parser_AST.Pragma uu____486 -> "pragma"
    | FStar_Parser_AST.Fsdoc (comm,uu____488) -> comm
  
let decl_documented : FStar_Parser_AST.decl -> Prims.bool =
  fun d  ->
    let tycon_documented tt =
      let tyconvars_documented tycon =
        match tycon with
        | FStar_Parser_AST.TyconAbstract uu____515 -> false
        | FStar_Parser_AST.TyconAbbrev uu____521 -> false
        | FStar_Parser_AST.TyconRecord (uu____528,uu____529,uu____530,fields)
            ->
            FStar_List.existsb
              (fun uu____554  ->
                 match uu____554 with
                 | (_id,_t,doco) -> FStar_Util.is_some doco) fields
        | FStar_Parser_AST.TyconVariant (uu____564,uu____565,uu____566,vars)
            ->
            FStar_List.existsb
              (fun uu____597  ->
                 match uu____597 with
                 | (_id,_t,doco,_u) -> FStar_Util.is_some doco) vars
         in
      FStar_List.existsb
        (fun uu____618  ->
           match uu____618 with
           | (tycon,doco) ->
               (tyconvars_documented tycon) || (FStar_Util.is_some doco)) tt
       in
    match d.FStar_Parser_AST.doc with
    | FStar_Pervasives_Native.Some uu____626 -> true
    | uu____627 ->
        (match d.FStar_Parser_AST.d with
         | FStar_Parser_AST.Fsdoc uu____629 -> true
         | FStar_Parser_AST.Tycon (uu____630,ty) -> tycon_documented ty
         | uu____640 -> false)
  
let document_decl :
  (Prims.string -> Prims.unit) -> FStar_Parser_AST.decl -> Prims.unit =
  fun w  ->
    fun d  ->
      if decl_documented d
      then
        let uu____654 = d  in
        match uu____654 with
        | { FStar_Parser_AST.d = decl; FStar_Parser_AST.drange = uu____656;
            FStar_Parser_AST.doc = fsdoc; FStar_Parser_AST.quals = uu____658;
            FStar_Parser_AST.attrs = uu____659;_} ->
            ((let uu____662 =
                let uu____663 = string_of_decl' d.FStar_Parser_AST.d  in
                code_wrap uu____663  in
              w uu____662);
             (match fsdoc with
              | FStar_Pervasives_Native.Some (doc1,_kw) ->
                  w (Prims.strcat "\n" doc1)
              | uu____678 -> ());
             w "")
      else ()
  
let document_toplevel name topdecl =
  match topdecl.FStar_Parser_AST.d with
  | FStar_Parser_AST.TopLevelModule uu____700 ->
      (match topdecl.FStar_Parser_AST.doc with
       | FStar_Pervasives_Native.Some (doc1,kw) ->
           let uu____718 =
             FStar_List.tryFind
               (fun uu____727  ->
                  match uu____727 with | (k,v1) -> k = "summary") kw
              in
           (match uu____718 with
            | FStar_Pervasives_Native.None  ->
                (FStar_Pervasives_Native.None,
                  (FStar_Pervasives_Native.Some doc1))
            | FStar_Pervasives_Native.Some (uu____740,summary) ->
                ((FStar_Pervasives_Native.Some summary),
                  (FStar_Pervasives_Native.Some doc1)))
       | FStar_Pervasives_Native.None  ->
           (FStar_Pervasives_Native.None, FStar_Pervasives_Native.None))
  | uu____748 -> raise (FStar_Errors.Err "Not a TopLevelModule") 
let document_module : FStar_Parser_AST.modul -> FStar_Ident.lid =
  fun m  ->
    let uu____757 =
      match m with
      | FStar_Parser_AST.Module (n1,d) -> (n1, d, "module")
      | FStar_Parser_AST.Interface (n1,d,uu____773) -> (n1, d, "interface")
       in
    match uu____757 with
    | (name,decls,_mt) ->
        let uu____782 = one_toplevel decls  in
        (match uu____782 with
         | FStar_Pervasives_Native.Some (top_decl,other_decls) ->
             let on =
               FStar_Options.prepend_output_dir
                 (Prims.strcat name.FStar_Ident.str ".md")
                in
             let fd = FStar_Util.open_file_for_writing on  in
             let w = FStar_Util.append_to_file fd  in
             let no_summary = "fsdoc: no-summary-found"  in
             let no_comment = "fsdoc: no-comment-found"  in
             let uu____801 = document_toplevel name top_decl  in
             (match uu____801 with
              | (summary,comment) ->
                  let summary1 =
                    match summary with
                    | FStar_Pervasives_Native.Some s -> s
                    | FStar_Pervasives_Native.None  -> no_summary  in
                  let comment1 =
                    match comment with
                    | FStar_Pervasives_Native.Some s -> s
                    | FStar_Pervasives_Native.None  -> no_comment  in
                  ((let uu____817 =
                      FStar_Util.format "# module %s" [name.FStar_Ident.str]
                       in
                    w uu____817);
                   (let uu____819 = FStar_Util.format "%s\n" [summary1]  in
                    w uu____819);
                   (let uu____821 = FStar_Util.format "%s\n" [comment1]  in
                    w uu____821);
                   FStar_List.iter (document_decl w) other_decls;
                   FStar_Util.close_file fd;
                   name))
         | FStar_Pervasives_Native.None  ->
             let uu____827 =
               let uu____828 =
                 FStar_Util.format1 "No singleton toplevel in module %s"
                   name.FStar_Ident.str
                  in
               FStar_Errors.Err uu____828  in
             raise uu____827)
  
let generate : Prims.string Prims.list -> Prims.unit =
  fun files  ->
    let modules =
      FStar_List.collect
        (fun fn  ->
           let uu____840 = FStar_Parser_Driver.parse_file fn  in
           FStar_Pervasives_Native.fst uu____840) files
       in
    let mods = FStar_List.map document_module modules  in
    let on = FStar_Options.prepend_output_dir "index.md"  in
    let fd = FStar_Util.open_file_for_writing on  in
    FStar_List.iter
      (fun m  ->
         let uu____857 = FStar_Util.format "%s\n" [m.FStar_Ident.str]  in
         FStar_Util.append_to_file fd uu____857) mods;
    FStar_Util.close_file fd
  